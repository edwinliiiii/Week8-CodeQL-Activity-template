import javascript

predicate isPublicMethod(Function f) {
  exists(MethodDefinition md | md.isPublic() and md.getBody() = f)
}

predicate isTest(Function test) {
  exists(CallExpr describe, CallExpr it |
    describe.getCalleeName() = "describe" and
    it.getCalleeName() = "it" and
    it.getParent*() = describe and
    test = it.getArgument(1)
  )
}

predicate isCalledByTest(Function f) {
  exists(Function test |
    isTest(test) and 
    exists(DataFlow::CallNode call | call.getEnclosingFunction() = test and call.getACallee() = f)
  )
}

from Function publicMethod
where isPublicMethod(publicMethod) and
      not isCalledByTest(publicMethod)
select publicMethod, "This public method is not called by any test."