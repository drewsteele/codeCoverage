
.cc.coverage:([func:`$()]ns:`$(); origDef:(); script:(); startLine:`long$(); endLine:`long$();calls:`long$();isMocked:`boolean$());

.cc.isNs:{(1#.q)~1#x};

.cc.exists:{not ()~key x};

.cc.findFuncs:{[ns]
    if[not .cc.exists ns; :()];
    subNs:` sv/: ns,/:where .cc.isNs each value ns;
    :raze (` sv/: ns,/:system"f ",string[ns]) , .z.s each subNs;
    };


.cc.registerDetails:{[fnName]
    if[fnName in key .cc.coverage; -1 "function ",string[fnName]," is already registered"; :()];
    def:value fnName;
    ns:` sv `,first 1_` vs fnName;
    if[type[def] > 100h; / TODO - handle some of these cases
        .cc.coverage[fnName]: `ns`origDef`script`startLine`endLine`calls!(ns; def; ""; 0N; 0N;0);
        :()
        ];
    script:first struct:-3#value def;
    startLine:struct 1;
    endLine:-1 + startLine + count "\n" vs struct 2;
    .cc.coverage[fnName] :`ns`origDef`script`startLine`endLine`calls!(ns; def; script; startLine; endLine;0);
    };


.cc.registerCall:{[fn;dummy]
    .cc.coverage:.cc.coverage pj ([func:(),fn]; calls:(),1);
    };

.cc.mockFunction:{[fnName]
    if[not .cc.exists fnName; '"function ",string[fnName]," does not exist"];
    if[not fnName in key .cc.coverage; 
        .cc.coverage upsert 1!enlist .cc.getDetails fnName
        ];
    if[.cc.coverage[fnName]`isMocked; -1"Function ",string[fnName]," already mocked"; :()];
    fnName set ('[.cc.registerCall[fnName;]; value fnName]);
    update isMocked:1b from `.cc.coverage where func=fnName;
    };

.cc.unMockFunction:{[fnName]
    if[not fnName in key .cc.coverage; '"function ",string[fnName]," not registered in .cc.coverage"];
    fnName set .cc.coverage[fnName]`origDef;
    update isMocked:0b from `.cc.coverage where func=fnName;
    };

.cc.initCoverage:{[nsList]
    .cc.registerDetails each raze .cc.findFuncs each nsList;
    .cc.mockFunction each exec func from .cc.coverage;    
    };    



