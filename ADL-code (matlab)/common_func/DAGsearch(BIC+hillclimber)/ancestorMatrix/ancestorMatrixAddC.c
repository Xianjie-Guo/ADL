#include "mex.h"

#include <string.h>
#include <stdio.h>
#include <math.h>
#include <ctype.h>
#include "ancestorMatrix.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    
    double *ancMatrix, *ancMatrixUpdated;
    int nc,nr,i,j,p,source,sink;
    
    ancMatrix = mxGetPr(prhs[0]);
    nc = mxGetN(prhs[0]);
    nr = mxGetM(prhs[0]);
    source = mxGetScalar(prhs[1])-1;
    sink = mxGetScalar(prhs[2])-1;
    
    plhs[0] = mxCreateDoubleMatrix( nr, nc, mxREAL );
    ancMatrixUpdated = mxGetPr(plhs[0]);
    
    /* Copy old Ancestor Matrix */
    for(i = 0; i < nr; i++)
    {
        for(j = 0; j < nc; j++)
        {
            ancMatrixUpdated[i + nr*j] = ancMatrix[i + nr*j];
        }
    }
    
	add(ancMatrixUpdated,ancMatrix,nr,source,sink);

}
