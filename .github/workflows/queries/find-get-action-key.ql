import javascript

predicate isTest(Function test) {
  exists(CallExpr describe, CallExpr it |
    describe.getCalleeName() = "describe" and
    it.getCalleeName() = "it" and
    it.getParent*() = describe and
    test = it.getArgument(1)
  )
}

from Function test, Function pressActionKey
where isTest(test) and 
      pressActionKey.getName() = "pressActionKey" and
      exists(DataFlow::CallNode call | call.getEnclosingFunction() = test and call.getACallee() = pressActionKey)
select test, "This test calls the function 'pressActionKey'."