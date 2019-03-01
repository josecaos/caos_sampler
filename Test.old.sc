
UnitTest {
  var <>assertionCount = 0, <>successCount = 0, <>failureCount = 0;

  test {
    arg name, func;
    ("Testing: " ++ name).postln;
    func.value(this);

    ("Assertions: " ++ assertionCount ++ "\t Successes: " ++ successCount ++ "\t Failures: " ++ failureCount).postln;
  }

  assert {
    arg truthValue;
    assertionCount = assertionCount+1;
    truthValue = truthValue.value;
    if(truthValue,
      { successCount = successCount+1 },
      { failureCount = failureCount+1 }
    );
    ^truthValue;
  }
}