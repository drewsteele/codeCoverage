.st.func1:{[a;b]
    r:a+1;
    if[r > 3; b:b+1];

    c:$[b>4; -1; 0];

    :a+b+c
    };


.st.func2:{
    -1"Do something";
    .st.global:1;
    -1"Do something else";
    :x
    };

.st.nested.func:{x+1}

.st.very.very.very.nest.e.d.func:{x+3};
.st.projection:.st.func1[;2];

.st.multiline:{[tab]
    val:3;
    t2:select from tab
    where 
    v = val;

    :update v+1 from t2;
    };

.st.global:0N;

\d .st
nsFunc:{x+2};
\d .

.st.wierdDef:
    {[]
        x

        +

        5


        };

.st.unary:sum;
.st.operator:+;

.st.composition:('[.st.func2;.st.func1]);

.ns2.func:{:3};
