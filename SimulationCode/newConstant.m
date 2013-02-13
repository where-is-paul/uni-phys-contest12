function res = getConstant(name)
% Constants. A convoluted way to share global constants across different
% m-files.
    R = 3;
    rho = 1.225;
    C_d = 0.5;
    m = 0.0025;
    g = 9.8;
    abs_vis = 1.81*10^-5;
    kin_vis = abs_vis / rho;
    mu = 0.25;
    cor = 0.93;
    table_l = 2.74;
    table_w = 1.525;
    net_h = 0.1525;

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
        res =  m;
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

end
