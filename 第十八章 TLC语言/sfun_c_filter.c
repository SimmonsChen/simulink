#define S_FUNCTION_NAME  sfun_c_filter
#define S_FUNCTION_LEVEL 2

#include "simstruc.h"

#define COEF_IDX 0
#define PARAM_NUM 1
#define COEF(S) mxGetScalar(ssGetSFcnParam(S,COEF_IDX))
/*================*
 * Build checking *
 *================*/


/* Function: mdlInitializeSizes ===============================================
 * Abstract:
 *   Setup sizes of the various vectors.
 */
static void mdlInitializeSizes(SimStruct *S)
{
    ssSetNumSFcnParams(S, 1);
    if (ssGetNumSFcnParams(S) != ssGetSFcnParamsCount(S)) {
        return; /* Parameter mismatch will be reported by Simulink */
    }

    if (!ssSetNumInputPorts(S, 1)) return;
    ssSetInputPortWidth(S, 0, DYNAMICALLY_SIZED);
    ssSetInputPortDirectFeedThrough(S, 0, 1);

    if (!ssSetNumOutputPorts(S,1)) return;
    ssSetOutputPortWidth(S, 0, DYNAMICALLY_SIZED);

    ssSetNumDWork(S, 1);
    ssSetDWorkWidth(S, 0, DYNAMICALLY_SIZED); 
    ssSetDWorkName(S, 0, "dwork");
    /* Identifier */
    ssSetDWorkRTWIdentifier(S, 0, "x");

    /* Type Qualifier */
    ssSetDWorkRTWTypeQualifier(S, 0, "volatile");

    /* Storage class */
    ssSetDWorkRTWStorageClass(S, 0, SS_RTW_STORAGE_EXPORTED_GLOBAL);
       
    ssSetNumSampleTimes(S, 1);
    
    /* set parameter untunable */
    ssSetSFcnParamNotTunable(S, 0);
    
    /* specify the sim state compliance to be same as a built-in block */
    ssSetSimStateCompliance(S, USE_DEFAULT_SIM_STATE);

    ssSetOptions(S, (SS_OPTION_EXCEPTION_FREE_CODE |
            SS_OPTION_DISALLOW_CONSTANT_SAMPLE_TIME));
}


/* Function: mdlInitializeSampleTimes =========================================
 * Abstract:
 *    Specifiy that we inherit our sample time from the driving block.
 */
static void mdlInitializeSampleTimes(SimStruct *S)
{
    ssSetSampleTime(S, 0, INHERITED_SAMPLE_TIME);
    ssSetOffsetTime(S, 0, 0.0);
    ssSetModelReferenceSampleTimeDefaultInheritance(S); 
}

#define MDL_INITIALIZE_CONDITIONS
/* Function: mdlInitializeConditions ========================================
 * Abstract:
 *    Initialize both discrete states to one.
 */
static void mdlInitializeConditions(SimStruct *S)
{
    real_T *x = (real_T*) ssGetDWork(S,0);
    x[0] = 0.0;  // initial to 0.0
}
/* Function: mdlOutputs =======================================================
 * Abstract:
 *    y = (u - x) * coef + x
 */
static void mdlOutputs(SimStruct *S, int_T tid)
{
    int_T             i;
    InputRealPtrsType uPtrs = ssGetInputPortRealSignalPtrs(S,0);
    real_T            *y    = ssGetOutputPortRealSignal(S,0);
    int_T             width = ssGetOutputPortWidth(S,0);
    real_T            *x = (real_T*) ssGetDWork(S,0);
    real_T            Lc = COEF(S);  // floating point datatype
    
    for (i = 0; i < width; i++)
    {
         y[i] = (*uPtrs[i] - x[i]) * Lc + x[i];
    }
    
    /* save the current output as the DWork Vector */
    for (i=0; i<width; i++) {
         x[i] = y[i];
    }
}


/* Function: mdlTerminate =====================================================
 * Abstract:
 *    No termination needed, but we are required to have this routine.
 */
static void mdlTerminate(SimStruct *S)
{
}

#define MDL_RTW
void mdlRTW(SimStruct *S)
{
    /* get parameter and dwork */
    real_T c_coef = COEF(S);
    real_T *x = (real_T*) ssGetDWork(S,0);
    /* write parameter into rtw file */
    if (!ssWriteRTWParamSettings(S, 1, 
            SSWRITE_VALUE_DTYPE_NUM,"r_coef",&c_coef, DTINFO(SS_DOUBLE, COMPLEX_NO)))
        return;
    /* dwork is automatically written into rtw file */
}


#ifdef  MATLAB_MEX_FILE    /* Is this file being compiled as a MEX-file? */
#include "simulink.c"      /* MEX-file interface mechanism */
#else
#include "cg_sfun.h"       /* Code generation registration function */
#endif
