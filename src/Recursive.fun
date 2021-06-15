functor Recursive (Template : FUNCTOR) :>
  sig
    type t

    val hide : t Template.t -> t
    and show : t -> t Template.t

    val fold : ('a Template.t -> 'a) -> t -> 'a

    val unfold : ('a -> 'a Template.t) -> 'a -> t
  end =
  struct
    datatype t = Wrap of t Template.t

    val hide = Wrap
    and show = fn Wrap template => template

    infix |>
    fun x |> f = f x

    fun fold f x = x |> show |> Template.map (fold f) |> f

    fun unfold f x = x |> f |> Template.map (unfold f) |> hide
  end
