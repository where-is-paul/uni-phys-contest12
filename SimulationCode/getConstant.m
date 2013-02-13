function res = getConstant(name)
% Constants. A convoluted way to share global constants across different
% m-files.
    R = 0.03;
    rho = 1.225;
    C_d = 0.5;
    
    g = 9.8;
    abs_vis = 1.81*10^-5;
    kin_vis = abs_vis / rho;
    mu = 0.25;
    cor = 0.93;
    table_l = 2.74;
    table_w = 1.525;
    net_h = 0.1525;
    
    m_40 = 0.0027; % mass of the 40mm ball
    mass_p_area = m_40/(4*pi*(0.02)^2);
    m = mass_p_area * 4 * pi * R * R;
    
    v_avg = 17; %typical speed of a fast ping pong ball during play;
    E = 0.5 * m_40 * v_avg * v_avg; %an estimate for the maximum energy of the ball

    if (strcmp(name, 'C_d'))
        res =  C_d;
        return
    end
    if (strcmp(name, 'R'))
        res =  R;
        return
    end
    if (strcmp(name, 'rho'))
        res =  rho;
        return
    end
    if (strcmp(name, 'm'))
        res =  mass_p_area * 4 * pi * R * R;
        return
    end
    if (strcmp(name, 'g'))
        res =  g;
        return
    end
    if (strcmp(name, 'kin_vis'))
        res = kin_vis;
        return
    end
    if (strcmp(name, 'abs_vis'))
        res = abs_vis;
        return
    end
    if (strcmp(name, 'mu'))
        res = mu;
        return
    end
    if (strcmp(name, 'cor'))
        res = cor;
        return
    end
    if (strcmp(name, 'table_l'))
        res =  table_l;
        return
    end
    if (strcmp(name, 'table_w'))
        res =  table_w;
        return
    end
    if (strcmp(name, 'net_h'))
        res =  net_h;
        return
    end
    if (strcmp(name, 'energy'))
        res =  E;
        return
    end
    if (strcmp(name, 'v_avg'))
        res =  v_avg;
        return
    end
    

end
