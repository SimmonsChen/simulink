/*  File    : sfun_fcncall.c
 *  Abstract:
 *
 *      Example of an S-function which is configured to execute "function-call"
 *      subsystems on the 1st and 2nd elements of the 1st output port. Note that
 *      function-calls can be issued from the 1st output port only.
 *
 *      For more details about S-functions, see
 *
 *  Copyright 1990-2013 The MathWorks, Inc.
 */

#define S_FUNCTION_NAME  sfun_fcncall
#define S_FUNCTION_LEVEL 2

#include "simstruc.h"


static void mdlInitializeSizes(SimStruct *S)
{
    ssSetNumSFcnParams(S, 0);  /* Number of expected parameters */
    if (ssGetNumSFcnParams(S) != ssGetSFcnParamsCount(S)) {
        return; /* Parameter mismatch will be reported by Simulink */
    }

    ssSetNumContStates(S, 0);
    ssSetNumDiscStates(S, 0);

    if (!ssSetNumInputPorts(S, 1)) return;
    ssSetInputPortWidth(S, 0, 1);
    ssSetInputPortDirectFeedThrough(S, 0, 1);
    
    if (!ssSetNumOutputPorts(S,1)) return;
    ssSetOutputPortWidth(S, 0, 2);


    /* All output elements are function-call, so we can set the data type of the
     * entire port to be function-call. */
    ssSetOutputPortDataType(S, 0, SS_FCN_CALL);

    /* specify the sim state compliance to be same as a built-in block */
    ssSetSimStateCompliance(S, USE_DEFAULT_SIM_STATE);

    ssSetOptions(S, SS_OPTION_EXCEPTION_FREE_CODE);
}


static void mdlInitializeSampleTimes(SimStruct *S)
{
    ssSetSampleTime(S, 0, 0.1);
    ssSetOffsetTime(S, 0, 0.0);
    
    ssSetCallSystemOutput(S,0);  /* call on first element */
    ssSetCallSystemOutput(S,1);  /* call on second element */
    ssSetModelReferenceSampleTimeDefaultInheritance(S);
}



static void mdlOutputs(SimStruct *S, int_T tid)
{
    real_T            *x    = ssGetRealDiscStates(S);
    InputRealPtrsType uPtrs = ssGetInputPortRealSignalPtrs(S,0);
    real_T            *y    = ssGetOutputPortRealSignal(S,1);

    /*
     * ssCallSystemWithTid is used to execute a function-call subsystem. The
     * 2nd argument is the element of the 1st output port index which
     * connected to the function-call subsystem. Function-call subsystems
     * can be driven by the first output port of s-function blocks.
     */
    
    UNUSED_ARG(tid); /* not used in single tasking mode */

    if (((int)*uPtrs[0]) % 2 == 1) {
        if (!ssCallSystemWithTid(S,0,tid)) {
            /* Error occurred which will be reported by Simulink */
            return;
        }
    } else {
        if (!ssCallSystemWithTid(S,1,tid)) {
            /* Error occurred which will be reported by Simulink */
            return;
        }
    }
}

static void mdlTerminate(SimStruct *S)
{

}

#ifdef  MATLAB_MEX_FILE    /* Is this file being compiled as a MEX-file? */
#include "simulink.c"      /* MEX-file interface mechanism */
#else
#include "cg_sfun.h"       /* Code generation registration function */
#endif
