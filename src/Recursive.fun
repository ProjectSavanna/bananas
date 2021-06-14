functor Recursive (Template : TEMPLATE) :>
  sig
    type t

    val hide : t Template.t -> t
    val show : t -> t Template.t

    val fold : ('a Template.t -> 'a) -> t -> 'a
    val unfold : ('a -> 'a Template.t) -> 'a -> t
  end =
  struct
    datatype t = Wrap of t Template.t

    val hide = Wrap
    val show = fn Wrap template => template

    fun fold f = f o Template.map (fold f) o show
    fun unfold f = hide o Template.map (unfold f) o f
  end
