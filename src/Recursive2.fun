functor Recursive2 (
  structure Template1 : FUNCTOR2
  structure Template2 : FUNCTOR2
) :>
  sig
    type t1
     and t2

    val hide : {
      1 : (t1, t2) Template1.t -> t1,
      2 : (t1, t2) Template2.t -> t2
    }
    and show : {
      1 : t1 -> (t1, t2) Template1.t,
      2 : t2 -> (t1, t2) Template2.t
    }

    val fold : {
      1 : ('a1, 'a2) Template1.t -> 'a1,
      2 : ('a1, 'a2) Template2.t -> 'a2
    } -> {
      1 : t1 -> 'a1,
      2 : t2 -> 'a2
    }

    val unfold : {
      1 : 'a1 -> ('a1, 'a2) Template1.t,
      2 : 'a2 -> ('a1, 'a2) Template2.t
    } -> {
      1 : 'a1 -> t1,
      2 : 'a2 -> t2
    }
  end =
  struct
    datatype t1 = Wrap1 of (t1, t2) Template1.t
         and t2 = Wrap2 of (t1, t2) Template2.t

    val hide = (Wrap1, Wrap2)
    and show = (
      fn Wrap1 x1 => x1,
      fn Wrap2 x2 => x2
    )

    infix |>
    fun x |> f = f x

    fun fold (f as (f1, f2)) = (
      fn x1 => x1 |> #1 show |> Template1.map (fold f) |> f1,
      fn x2 => x2 |> #2 show |> Template2.map (fold f) |> f2
    )

    fun unfold (f as (f1, f2)) = (
      fn x1 => x1 |> f1 |> Template1.map (unfold f) |> #1 hide,
      fn x2 => x2 |> f2 |> Template2.map (unfold f) |> #2 hide
    )
  end
