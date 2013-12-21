(clear)                   ; Memory Leak #1
(progn (release-mem) TRUE)
(mem-used)
(defclass SOURCE (is-a USER))

(deffunction foo()
   (do-for-all-instances ((?x SOURCE)) TRUE
      (bind ?y 0)
      (bogus)))
(clear)                   ; Memory Leak #2
(progn (release-mem) TRUE)
(mem-used)
(defclass SOURCE (is-a USER))

(deffunction foo()
   (do-for-all-instances ((?x SOURCE)) (progn (bind ?y 3) (bogus) TRUE)
      (+ 3 4)))
(clear)                   ; Memory Leak #3
(progn (release-mem) TRUE)
(mem-used)
(deftemplate SOURCE)

(deffunction foo()
   (do-for-all-facts ((?x SOURCE)) TRUE
      (bind ?y 0)
      (bogus)))
(clear)                   ; Memory Leak #41
(progn (release-mem) TRUE)
(mem-used)
(deftemplate SOURCE)

(deffunction foo()
   (do-for-all-facts ((?x SOURCE)) (progn (bind ?y 3) (bogus) TRUE)
      (+ 3 4)))
(clear)                   ; Memory Leak #5
(progn (release-mem) TRUE)
(mem-used)

(defclass FOO (is-a USER)
   (slot value1))

(deffunction foo ()
   (make-instance of FOO
      (value1 (bogus))))
(clear)                   ; Memory Leak #6
(progn (release-mem) TRUE)
(mem-used)

(deftemplate FOO
   (slot value1 (type SYMBOL)))

(defrule foo
   (FOO (value1 ?x))
   =>
   (+ ?x 1)
   (printout t ?x))
(clear)
(progn (release-mem) TRUE)
(mem-used)
(clear)

(deftemplate nar 
   (slot bc))

(defrule migrant 
   (test (eq 1 1))
   (nar (bc ?bc))
   =>
   (printout t ?bc crlf))

(deffacts stuff
   (nar  (bc "US")))
(reset)
(run)
(clear)                   ; SourceForge Bug #12
(defclass Test (is-a USER) (multislot Contents))
(make-instance of Test (Contents a b c d e f g h))

(defrule BrokenPatternMatchBehavior-Object
   (object (is-a Test) 
           (Contents $?first ?second ?third $?fourth ?fifth))
   =>
   (printout t ?first " " ?second " " ?third " " ?fourth " " ?fifth crlf))
(run)
