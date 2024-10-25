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

from Function test, Function publicMethod
where isTest(test) and
      isPublicMethod(publicMethod) and
      exists(DataFlow::CallNode call | call.getEnclosingFunction() = test and call.getACallee() = publicMethod)
select publicMethod, "This public method is called by a test."