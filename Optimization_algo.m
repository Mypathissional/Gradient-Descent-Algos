classdef Optimization_algo
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        f %test_function object
        l % learning rate
        eps %tolerance for stopping 
        n %  maximum number of iterations
        plot_
        animate
        a
        function_values
 
            
    end
    
    methods
        function obj = Optimization_algo(f,l,eps,n,p,animate)
           obj.f=f;
           obj.l=l;
           obj.eps=eps;
           obj.plot_=p;
           obj.animate = animate;
           obj.n = n;
           
           if obj.plot_
               obj.function_values = [];
           end
           
           if obj.animate 
              obj.a = Plot(obj.f);
              %obj.a.graph();
              figure()
           end
            
           
        end
        
        function x1 = Gradient_descent(obj,x0)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            
            x1 = x0;
            for i=1:obj.n
                disp(obj.f.eval(x0)) 

                gradient = obj.f.grad(x0);
                temp =x1;
                x1 = x0 - obj.l*gradient;
                x0 =temp;
                
                if norm(gradient) <= obj.eps
                    break
                end
                
                if obj.animate
                    obj.a.call(x0,x1,'Gradient Descent')
                end
                
                if obj.plot_
                    obj.function_values = [obj.function_values obj.f.eval(x0)];
                end
            end
            
            if obj.plot_
               figure()
               plot(1:numel(obj.function_values),obj.function_values)
               title('Gradient Descent')
               xlabel ('Time')
               ylabel('f(x)')
            end
            
                          
        end
        
        
        function x1 = Momentum(obj,x0,alpha)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            x1 = x0;
            m = zeros(1,obj.f.dim);
            for i=1:obj.n
                disp(obj.f.eval(x0)) 
                gradient = obj.f.grad(x0);
                m = alpha*m + obj.l*gradient;
                temp  =x1;
                x1 = x0 - m;
                x0 = temp;

                if norm(gradient) <= obj.eps
                    break
                end
                if obj.animate
                    obj.a.call(x0,x1,'Momentum')
                end
                
                if obj.plot_
                    obj.function_values = [obj.function_values obj.f.eval(x0)];
                end
            end
            
            if obj.plot_
               figure()
               plot(1:numel(obj.function_values),obj.function_values)
               title('Momentum')
               xlabel ('Time')
               ylabel('f(x)')
            end
               
        end
                   
        
        function x1 = NesterovMomentum(obj,x0,alpha)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            x1 = x0;
            m = zeros(1,obj.f.dim);
            for i=1:obj.n
                disp(obj.f.eval(x0)) 
                
                gradient = obj.f.grad(x0-alpha*m);  %lookahead gradient
                m = alpha*m + obj.l*gradient;
                temp  =x1;
                x1 = x0 - m;
                x0 = temp;

                if norm(gradient) <= obj.eps
                    break
                end
                
                if obj.animate
                    obj.a.call(x0,x1,'NesterovMomentum')
                end
                
                if obj.plot_
                    obj.function_values = [obj.function_values obj.f.eval(x0)];
                end
            end
            
            if obj.plot_
               figure()
               plot(1:numel(obj.function_values),obj.function_values)
               title('NesterovMomentum')
               xlabel ('Time')
               ylabel('f(x)')
            end
               
        end
        
        
        function x1 = AdaGrad(obj,x0)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            x1 = x0;
            G = zeros(1,obj.f.dim);

            for i=1:obj.n         
                disp(obj.f.eval(x0)) 
                gradient = obj.f.grad(x0);
                G = G + gradient.^2;
                temp = x1;
                x1 = x0 - obj.l*gradient./sqrt(G+0.1^15);
                x0 = temp;
                if norm(gradient) <= obj.eps
                    break
                end
                
                if obj.animate
                    obj.a.call(x0,x1,'AdaGrad')
                end
                
                if obj.plot_
                    obj.function_values = [obj.function_values obj.f.eval(x0)];
                end
            end
            if obj.plot_
               figure()
               plot(1:numel(obj.function_values),obj.function_values)
               title('AdaGrad')
               xlabel ('Time')
               ylabel('f(x)')
            end
               
        end
              
        
        function x1 = RMSprop(obj,x0,alpha)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            x1 = x0;
            G = zeros(1,obj.f.dim);

            for i=1:obj.n         
                disp(obj.f.eval(x0)) 
                disp(i)
                gradient = obj.f.grad(x0);
                G = alpha*G + (1-alpha)*gradient.^2;    
                temp = x1;
                x1 = x0 - obj.l*gradient./sqrt(G+0.1^15);
                x0 = temp;
                if norm(gradient) <= obj.eps
                    break
                end
                
                if obj.animate
                    obj.a.call(x0,x1,'RMSprop')
                end
                
                if obj.plot_
                    obj.function_values = [obj.function_values obj.f.eval(x0)];
                end
            end
            if obj.plot_
               figure()
               plot(1:numel(obj.function_values),obj.function_values)
               title('RMSprop')
               xlabel ('Time')
               ylabel('f(x)')
            end
               
        end
        
        function x1 = Adam(obj,x0,beta1,beta2)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            x1 = x0;
            G = zeros(1,obj.f.dim);
            m = zeros(1,obj.f.dim);

            for i=1:obj.n         
                disp(obj.f.eval(x0)) 
                disp(i)
                gradient = obj.f.grad(x0);
                G = (beta2*G + (1-beta2)*gradient.^2)/(1-beta2^i);
                m = (beta1*m + (1-beta1)*obj.l*gradient)/(1-beta1^i);
                temp = x1;
                x1 = (x0 - obj.l*m)./(sqrt(G)+0.1^8);
                x0 = temp;
                if norm(gradient) <= obj.eps
                    break
                end
                if obj.animate
                    obj.a.call(x0,x1,'Adam')
                end
                
                if obj.plot_
                    obj.function_values = [obj.function_values obj.f.eval(x0)];
                end
            end
            if obj.plot_
               figure()
               plot(1:numel(obj.function_values),obj.function_values)
               title('Adam')
               xlabel ('Time')
               ylabel('f(x)')
            end
               
        end
        
        
        
    end
end