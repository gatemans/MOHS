function MOHS
    % Multi-Harmony Search (MOHS) Algorithm Implementation
    % Author: [Mohammad Mahdi Khaligh]
    % GitHub: [https://github.com/gatemans]

    % Get Parameters from User
    HMS = input('Enter Harmony Memory Size (HMS): '); % Harmony Memory Size
    HMCR = input('Enter Harmony Memory Considering Rate (HMCR) [0-1]: '); % HMCR
    PAR = input('Enter Pitch Adjusting Rate (PAR) [0-1]: '); % PAR
    MaxIter = input('Enter Maximum Number of Iterations: '); % Max Iterations
    Dim = input('Enter Number of Dimensions (Variables): '); % Dimensions
    LowerBound = input('Enter Lower Bound for Variables: '); % Lower Bound
    UpperBound = input('Enter Upper Bound for Variables: '); % Upper Bound

    % Validate User Inputs
    if HMS <= 0 || HMCR < 0 || HMCR > 1 || PAR < 0 || PAR > 1 || MaxIter <= 0 || Dim <= 0 || LowerBound >= UpperBound
        error('Invalid input parameters. Please try again.');
    end

    % Initialize Harmony Memory
    HM = LowerBound + (UpperBound - LowerBound) * rand(HMS, Dim);
    Fitness = arrayfun(@ObjectiveFunction, HM);

    % Main Loop
    for iter = 1:MaxIter
        % Generate a New Harmony
        NewHarmony = zeros(1, Dim);
        for i = 1:Dim
            if rand < HMCR
                % Select from Harmony Memory
                NewHarmony(i) = HM(randi(HMS), i);
                if rand < PAR
                    % Pitch Adjustment
                    NewHarmony(i) = NewHarmony(i) + (rand - 0.5);
                end
            else
                % Generate Random Value
                NewHarmony(i) = LowerBound + (UpperBound - LowerBound) * rand;
            end
        end

        % Evaluate New Harmony
        NewFitness = ObjectiveFunction(NewHarmony);

        % Update Harmony Memory
        [WorstFitness, WorstIndex] = max(Fitness);
        if NewFitness < WorstFitness
            HM(WorstIndex, :) = NewHarmony;
            Fitness(WorstIndex) = NewFitness;
        end
    end

    % Display Results
    [BestFitness, BestIndex] = min(Fitness);
    disp('Best Solution:');
    disp(HM(BestIndex, :));
    disp('Best Objective Value:');
    disp(BestFitness);
end

%%     Multi-Harmony Search (MOHS) Algorithm Implementation
%      Author: [Mohammad Mahdi Khaligh]
%      GitHub: [https://github.com/gatemans]
