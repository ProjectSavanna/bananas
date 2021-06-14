# bananas
Recursion schemes in Standard ML

## Usage Example

```sml
structure NatTemplate =
  struct
    datatype 'a t
      = Zero
      | Succ of 'a

    fun map f =
      fn Zero   => Zero
       | Succ x => Succ (f x)
  end

structure Nat = Recursive (NatTemplate)

open NatTemplate

val Zero' = Nat.hide Zero
val Succ' = Nat.hide o Succ

val fromInt =
  Nat.unfold (
    fn 0 => Zero
     | n => Succ (n - 1)
  )

val double =
  Nat.fold (
    fn Zero   => Zero'
     | Succ n => Succ' (Succ' n)
  )

val toInt =
  Nat.fold (
    fn Zero   => 0
     | Succ n => n + 1
  )

val 42 = toInt (double (fromInt 21))
```
