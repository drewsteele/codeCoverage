
.cc.coverage:([func:`$()]ns:`$(); origDef:(); script:(); startLine:`long$(); endLine:`long$();calls:`long$();isMocked:`boolean$());

.cc.callHistory

.cc.isNs:{(1#.q)~1#x};

ns:
()~ key `.ns2

.cc.exists:{not ()~key x};

.cc.findFuncs:{[ns]
    if[not .cc.exists ns; :()];
    subNs:` sv/: ns,/:where .cc.isNs each value ns;
    :raze (` sv/: ns,/:system"f ",string[ns]) , .z.s each subNs;
    };


.cc.getDetails:{[fn]
    def:$[-11h=type fn; value fn; fn];
    ns:` sv `,first 1_` vs fn;
    if[type[def] > 100h; / TODO - handle some of these cases
        :`func`ns`origDef`script`startLine`endLine`calls!(fn; ns; def; ""; 0N; 0N; 0)
        ];
    script:first struct:-3#value def;
    startLine:struct 1;
    endLine:-1 + startLine + count "\n" vs struct 2;
    :`func`ns`origDef`script`startLine`endLine`calls!(fn; ns; def; script; startLine; endLine; 0);
    };


.cc.initCoverage:{[nsList]
    .cc.coverage:.cc.coverage upsert .cc.getDetails each raze .cc.findFuncs each nsList;
    
    };    




