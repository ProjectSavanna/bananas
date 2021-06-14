# bananas
Recursion schemes in Standard ML

## Usage Examples

### Natural Numbers

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

val add = fn (m, n) =>
  Nat.fold (
    fn Zero   => n
     | Succ m => Succ' m
  ) m

val toInt =
  Nat.fold (
    fn Zero   => 0
     | Succ n => n + 1
  )

val 42 = toInt (double (fromInt 21))
```

### Binary Trees

```sml
structure TreeTemplate =
  struct
    datatype 'a t
      = Empty
      | Node of 'a * Nat.t * 'a

    fun map f =
      fn Empty          => Empty
       | Node (l, x, r) => Node (f l, x, f r)
  end

structure Tree = Recursive (TreeTemplate)

open TreeTemplate

val Empty' = Tree.hide Empty
val Node' = Tree.hide o Node

val leaf = fn x => Node' (Empty', x, Empty')

val sum =
  Tree.fold (
    fn Empty          => Zero'
     | Node (l, x, r) => add (x, add (l, r))
  )

val 6 =
  toInt (
    sum (
      Node' (
        leaf (fromInt 3),
        fromInt 1,
        leaf (fromInt 2)
      )
    )
  )
```
