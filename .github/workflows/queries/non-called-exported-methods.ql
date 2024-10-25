import javascript

predicate isExportedFunction(Function f) {
  exists(Module m | m.getAnExportedValue(_).getAFunctionValue().getFunction() = f) and
  not f.inExternsFile()
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

from Function exportedFunction
where isExportedFunction(exportedFunction) and
      not isCalledByTest(exportedFunction)
select exportedFunction, "This exported function is not called by any test."