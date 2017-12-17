
--Returns the sign of the number (1 if positive or Zero, or -1 if negative)
function math.sign(n)
  return n<0 and -1 or 1
end

function math.absSign(n)
  return n==0 and 0 or math.sign(n)
end