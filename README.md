# BSplinesBinaryBuilder

This is a repo for deploying Fortran code implementing the subroutines `bsplvb`
and `bsplvd` evaluating B-Splines and their derivatives for cross-platform use
in Julia. The Fortran code is modified from the original files in the "piecewise
polynomial pack", which can be found on [netlib](https://www.netlib.org/pppack/) . I believe the original source of the
subroutines is Carl de Boor's *A Practical Guide to Splines*.

The main purpose of this deploying the Fortran code is for use in my quantum
optimal control package:
[QuantumGateDesign.jl](https://github.com/leespen1/QuantumGateDesign.jl). This
repo may be abandoned in the future, if I get around to implementing the
B-Spline subroutines as Julia code directly in QuantumGateDesign.jl.

In order to deploy to github, need to do `export GITHUB_AUTH=ghp_yourpersonalaccesstokenhere`
once per session, then run `julia +1.7 build_tarballs.jl --deploy=gh`, or use
`--deploy=local` and manage the tarballs myself. 
