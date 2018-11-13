classdef mWait < hgsetget
    
    properties
        time_start
        time_set
        done
        displayed
        name
    end
    
    methods
        function w = mWait(t, varargin)
            w.time_set = t ;
            w.time_start = -1 ;
            w.done = false ;
            w.displayed = false ;
            
            for i=1:2:length(varargin)
                pn = varargin{i} ;
                pv = varargin{i+1} ;
                if isprop(w,pn),
                    set(w,pn,pv)
                end
            end
            
            if(isempty(w.name)), w.name = 'Waiter' ; end
        end
        
        function d = wait(w, t)
            if(~w.displayed),
                buf = sprintf('[%2.4f] %s: start waiting for %d seconds...', t, w.name, w.time_set) ;
                disp(buf) ;
                w.displayed = true ;
            end
            
            if(w.time_start<0), w.time_start = t ; end
            
            if((t-w.time_start)>=w.time_set),
                w.done = true ;
            end
            
            d = w.done ;
        end
        
        function d = isDone(w)
            d = w.done ;
        end
        
        function t = getSetTime(ww)
            t = [] ;
            for w = ww
            t = [t w.time_set] ; %#ok
            end
        end
        
        function reset(ww)
            for w = ww,
                w.time_start = -1 ;
                w.done = false ;
                w.displayed = false ;
            end
        end
    end
end