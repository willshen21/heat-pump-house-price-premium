
. do "C:\Users\wills\AppData\Local\Temp\STD2960_000000.tmp"

. foreach n in SolarPanel SolarWater CloWash DishWash CloDry Frig Light WaterHeat Win{
  2. probit `n' HP [pweight=NWEIGHT]
  3. margin, dydx(HP) atmeans
  4. }


