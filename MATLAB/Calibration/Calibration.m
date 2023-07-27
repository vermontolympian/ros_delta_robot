function Calibration
%% The best and easiest initial guess is the nominal kinematic Parameters (Table 1 in
%%the Paper:
initialguess=[   92    84     0   305   111     0   604
                 27   122     0   -56   320     0   604
                -119    37     0  -248   208     0   604
                -119   -37     0  -248  -208     0   604
                 27  -122     0   -56  -320     0   604
                 92   -84     0   305  -111     0   604];
             
%% Minimizing the Cost Function can be done using lsqnonlin as follows:

IdentifiedValues=lsqnonlin(@CostFunction,initialguess');

%% We have the RealValues from the Paper as follows:
RealValues=[  
   96.6610   22.2476  -122.4519  -120.6859   24.7769   91.3462
   81.7602  125.2511   36.6453   -34.4565  -125.0489   -80.9866
    1.0684    -0.5530    4.3547    -4.9014    -4.8473    0.2515
  305.2599   -55.2814  -244.7954  -252.5755   -53.9678  302.4266
  115.0695  322.9819  208.0087  -211.8783  -320.6115  -109.4351
    2.6210    4.2181    3.9365    -3.0128    4.3181    3.3812
  604.4299  607.2473  600.4441  605.9031  604.5251  600.0616 
];

%% The error between Identified Values after calibration (Calibration Result) and Real Values:

ErrorAfterCalibration=abs(IdentifiedValues-RealValues)


%% We have the nominal values from the Paper as follows:

NominalValues=[
   92.1597   27.0550  -119.2146  -119.2146   27.0550   92.1597
   84.4488  122.0370   37.5882   -37.5882  -122.0370   -84.4488
         0         0         0         0         0         0
  305.4001   -56.4357  -248.9644  -248.9644   -56.4357  305.4001
  111.1565  320.0625  208.9060  -208.9060  -320.0625  -111.1565
         0         0         0         0         0         0
  604.8652  604.8652  604.8652  604.8652  604.8652  604.8652    
];

%% If we do not calibrate the robot at all, the error in the kinematic parameters would be as follows:

ErrorBeforeCalibration=abs(NominalValues-RealValues)

