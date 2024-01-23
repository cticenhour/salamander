//* This file is part of SALAMANDER: Fusion Energy Integrated Multiphys-X,
//* A multiphysics application for modeling plasma facing components
//* https://github.com/idaholab/salamander
//*
//* SALAMANDER is powered by the MOOSE Framework
//* https://www.mooseframework.inl.gov
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "TestPICStudyUserDefinedRays.h"
#include "AuxAccumulator.h"

/**
 * Test study for mapping charge from particles into a finite element
 * aux variable
 */
class TestChargeAccumulator : public TestPICStudyUserDefinedRays
{
public:
  TestChargeAccumulator(const InputParameters & parameters);

  static InputParameters validParams();

  virtual void postExecuteStudy() override;

private:
  /// the aux variable we want to accumulate charge into
  const AuxVariableName _var_name;
};
