signature RECURSIVE =
  sig
    structure Template : FUNCTOR

    type t

    val hide : t Template.t -> t
    and show : t -> t Template.t

    val fold : ('a Template.t -> 'a) -> t -> 'a

    val unfold : ('a -> 'a Template.t) -> 'a -> t
  end
