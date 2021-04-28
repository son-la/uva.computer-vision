classdef residualBlockLayer < nnet.layer.Layer
    % Example custom residual block layer.
    
    properties (Learnable)
        % Layer learnable parameters.

        % Residual block.
        Network
    end
    
    methods
        function layer = residualBlockLayer(inputSize,numFilters,NameValueArgs)
            % layer = residualBlockLayer(inputSize,numFilters) creates a
            % residual block layer with the specified input size and number
            % of filters.
            %
            % layer = residualBlockLayer(inputSize,numFilters,Name,Value)
            % specifies additional options using one or more name-value
            % pairs:
            % 
            %     'Stride'                 - Stride of convolution operation 
            %                                (default 1)
            %
            %     'IncludeSkipConvolution' - Flag to include convolution in
            %                                skip connection
            %                                (default false)
            %
            %     'Name'                   - Layer name
            %                                (default '')
            
            % Parse input arguments.
            arguments
                inputSize
                numFilters
                NameValueArgs.Stride = 1
                NameValueArgs.IncludeSkipConvolution = false
                NameValueArgs.Name = ''
            end
            
            stride = NameValueArgs.Stride;
            includeSkipConvolution = NameValueArgs.IncludeSkipConvolution;
            name = NameValueArgs.Name;
            
            % Set layer name.
            layer.Name = name;
            
            % Set layer description.
            description = "Residual block with " + numFilters + " filters, stride " + stride;
            if includeSkipConvolution
                description = description + ", and skip convolution";
            end
            layer.Description = description;
            
            % Set layer type.
            layer.Type = "Residual Block";
            
            % Define nested layer graph.
            layers = [
                imageInputLayer(inputSize,'Normalization','None','Name','in')
                
                convolution2dLayer(3,numFilters,'Padding','same','Stride',stride,'Name','conv1')
                groupNormalizationLayer('all-channels','Name','gn1')
                reluLayer('Name','relu1')
                convolution2dLayer(3,numFilters,'Padding','same','Name','conv2')
                groupNormalizationLayer('channel-wise','Name','gn2')
                
                additionLayer(2,'Name','add')
                reluLayer('Name','relu2')];
            
            lgraph = layerGraph(layers);
            
            % Add skip connection.
            if includeSkipConvolution
                layers = [
                    convolution2dLayer(1,numFilters,'Stride',stride,'Name','convSkip')
                    groupNormalizationLayer('all-channels','Name','gnSkip')];
                
                lgraph = addLayers(lgraph,layers);
                lgraph = connectLayers(lgraph,'in','convSkip');
                lgraph = connectLayers(lgraph,'gnSkip','add/in2');
            else
                lgraph = connectLayers(lgraph,'in','add/in2');    
            end 
                            
            % Convert to dlnetwork.
            dlnet = dlnetwork(lgraph);
            
            % Set Network property.
            layer.Network = dlnet;
        end
        
        function Z = predict(layer, X)
            % Forward input data through the layer at prediction time and
            % output the result.
            %
            % Inputs:
            %         layer - Layer to forward propagate through
            %         X     - Input data
            % Outputs:
            %         Z - Output of layer forward function
                       
            % Convert input data to formatted dlarray.
            X = dlarray(X,'SSCB');
            
            % Predict using network.
            dlnet = layer.Network;
            Z = predict(dlnet,X);
            
            % Strip dimension labels.
            Z = stripdims(Z);
        end
    end
end