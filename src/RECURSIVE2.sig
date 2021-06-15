signature RECURSIVE2 =
  sig
    structure Template1 : FUNCTOR2
    structure Template2 : FUNCTOR2

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
  end
