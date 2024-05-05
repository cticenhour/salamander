!config navigation breadcrumbs=False scrollspy=False



# Software for Advanced Large-scale Analysis of MAgnetic confinement for Numerical Design, Engineering & Research (SALAMANDER) class=center style=font-weight:200;font-size:200%

!style halign=center
As fusion energy gains traction internationally to enable a carbon-free future, designing components for fusion systems is a pressing challenge. During the planned lifetime of a fusion device, components evolve in extreme environments. Complex physical processes take place simultaneously, interact in intricate ways, and impose important constraints. Experimental data is rare and costly to obtain, making design particularly challenging. Predictive computational frameworks must be an integral part of an accelerated and cost-effective design process by modeling fusion system performance in simulated environments. To better understand component degradation and operational impacts on their performance, SALAMANDER is designed as an open-source, fully integrated, multiphysics, multiscale, Nuclear Quality Assurance, level 1 (NQA-1) compliant framework facilitating 3D, high-fidelity fusion system modeling.
SALAMANDER is an application based on the
[MOOSE framework](https://mooseframework.inl.gov) performing system-level, engineering scale (i.e., at the scale of
centimeters and meters), and microstructure-scale (i.e., at the scale of microns) multiphysics
calculations related to magnetic confinement fusion energy systems.
These models often include highly coupled systems of equations related to plasma physics,
electromagnetics, heat conduction, scalar transport, thermal hydraulics, [!ac](CFD),
and thermomechanics, amongst others.
Interfaces to other MOOSE-based codes, including tritium transport ([TMAP8](https://mooseframework.inl.gov/tmap8))
and neutronics ([Cardinal](https://cardinal.cels.anl.gov/)) are also included to support SALAMANDER simulations.
SALAMANDER will enable high-fidelity modeling of irradiation levels and plasma exposure
conditions of plasma facing components and their impact on heat and tritium distributions, as well
as the resulting mechanical constraints experienced by the plasma facing components.
SALAMANDER supports design, safety, engineering, and research projects.

!row!
!col! small=12 medium=4 large=4 icon=get_app
## [Getting Started](getting_started/installation.md) class=center style=font-weight:200;font-size:150%;

!style halign=center
Quickly learn how to obtain the SALAMANDER source code, compile an executable, and
run simulations with these instructions.
!col-end!

!col! small=12 medium=4 large=4 icon=settings

## [Code Reference](syntax/index.md) class=center style=font-weight:200;font-size:150%;

!style halign=center
SALAMANDER provides capabilities that can be applied to a wide variety of problems.
The Code Reference provides detailed documentation of specific code features.
General user notes on SALAMANDER can also be found [here](getting_started/user_notes.md).
!col-end!

!col! small=12 medium=4 large=4 icon=assessment
## [Verification, Validation, and Example Cases](verification_validation_examples/index.md) class=center style=font-weight:200;font-size:150%;

!style halign=center
Verification, validation, and example cases list cases showcasing SALAMANDER's capabilities
and ensuring its accuracy.
!col-end!
!row-end!

## SALAMANDER is built on MOOSE style=clear:both;

!style halign=left
SALAMANDER is based on [MOOSE], an extremely flexible framework and simulation environment
that permits the solution of coupled physics problems of varying size and dimensionality.
These can be solved using computer hardware appropriate for the model size, ranging from
laptops and workstations to large high performance computers.

!media large_media/framework/inl_blue.png style=float:right;width:20%;margin-left:30px;

Code reliability is a central principle in code development, and this project
employs a well-defined development and testing strategy.  Code changes are only
merged into the repository after both a manual code review and the automated
regression test system have been completed.  The testing process and status of
SALAMANDER is available at [civet.inl.gov](https://civet.inl.gov/repo/530/).

SALAMANDER and MOOSE are developed at Idaho National Laboratory by a team of
computer scientists and engineers and is supported by various funding agencies,
including the [United States Department of Energy](http://energy.gov).  Development
of these codes is ongoing at [INL](https://www.inl.gov) and by collaborators
throughout the world.

## Utilities

- [AuxAccumulator.md] - Accumulates pointwise data akin to a point source into an auxiliary field

- [VariableSampler.md] - Samples a variable at a given point in space
