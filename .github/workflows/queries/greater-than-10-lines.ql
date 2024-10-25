/**
 * @description Find functions greater than 10 lines
 * @kind problem
 * @id javascript/greater-than-10-lines
 * @problem.severity recommendation
 */
import javascript

from Function f
where f.getNumLines() > 10
select f, "This function is longer than 10 lines."