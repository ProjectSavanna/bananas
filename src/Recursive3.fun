functor Recursive3 (
  structure Template1 : FUNCTOR3
  structure Template2 : FUNCTOR3
  structure Template3 : FUNCTOR3
) :> RECURSIVE3 where Template1 = Template1
                  and Template2 = Template2
                  and Template3 = Template3 =
  struct
    structure Template1 = Template1
    structure Template2 = Template2
    structure Template3 = Template3

    datatype t1 = Wrap1 of (t1, t2, t3) Template1.t
         and t2 = Wrap2 of (t1, t2, t3) Template2.t
         and t3 = Wrap3 of (t1, t2, t3) Template3.t

    val hide = (Wrap1, Wrap2, Wrap3)
    and show = (
      fn Wrap1 x1 => x1,
      fn Wrap2 x2 => x2,
      fn Wrap3 x3 => x3
    )

    infix |>
    fun x |> f = f x

    fun fold (f as (f1, f2, f3)) = (
      fn x1 => x1 |> #1 show |> Template1.map (fold f) |> f1,
      fn x2 => x2 |> #2 show |> Template2.map (fold f) |> f2,
      fn x3 => x3 |> #3 show |> Template3.map (fold f) |> f3
    )

    fun unfold (f as (f1, f2, f3)) = (
      fn x1 => x1 |> f1 |> Template1.map (unfold f) |> #1 hide,
      fn x2 => x2 |> f2 |> Template2.map (unfold f) |> #2 hide,
      fn x2 => x2 |> f3 |> Template3.map (unfold f) |> #3 hide
    )
  end
