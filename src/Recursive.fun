functor Recursive (Template : FUNCTOR) :> RECURSIVE where Template = Template =
  struct
    structure Template = Template

    datatype t = Wrap of t Template.t

    val hide = Wrap
    and show = fn Wrap template => template

    infix |>
    fun x |> f = f x

    fun fold f x = x |> show |> Template.map (fold f) |> f

    fun unfold f x = x |> f |> Template.map (unfold f) |> hide
  end
