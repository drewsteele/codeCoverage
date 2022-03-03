@[system; "l script.q"; "failed to load script.q ",];
@[system; "l cc.q"; "failed to load cc.q ",];

.cc.initCoverage `.st`.ns2;

.test.testFunc1:{
    :.st.func1[2;3] = 5
    };


.test.testNestedFunc:{
    .st.nested.func[2] = 3
    };

.test.testMultiline:{
    .st.multiline[([]a:1 2;v:3 4)] ~ ([]a:(),1; v:4)
    };

.test.run:{
    tests:` sv/: `.test,/:t where (t:system["f .test"]) like "test*";
    r:tests!@[;`;0b]each value each tests;
    -1"Test results:\n\n";
    -1 .Q.s r;
    :r
    };


