signature RECURSIVE3 =
  sig
    structure Template1 : FUNCTOR3
    structure Template2 : FUNCTOR3
    structure Template3 : FUNCTOR3

    type t1
     and t2
     and t3

    val hide : {
      1 : (t1, t2, t3) Template1.t -> t1,
      2 : (t1, t2, t3) Template2.t -> t2,
      3 : (t1, t2, t3) Template3.t -> t3
    }
    and show : {
      1 : t1 -> (t1, t2, t3) Template1.t,
      2 : t2 -> (t1, t2, t3) Template2.t,
      3 : t3 -> (t1, t2, t3) Template3.t
    }

    val fold : {
      1 : ('a1, 'a2, 'a3) Template1.t -> 'a1,
      2 : ('a1, 'a2, 'a3) Template2.t -> 'a2,
      3 : ('a1, 'a2, 'a3) Template3.t -> 'a3
    } -> {
      1 : t1 -> 'a1,
      2 : t2 -> 'a2,
      3 : t3 -> 'a3
    }

    val unfold : {
      1 : 'a1 -> ('a1, 'a2, 'a3) Template1.t,
      2 : 'a2 -> ('a1, 'a2, 'a3) Template2.t,
      3 : 'a3 -> ('a1, 'a2, 'a3) Template3.t
    } -> {
      1 : 'a1 -> t1,
      2 : 'a2 -> t2,
      3 : 'a3 -> t3
    }
  end
