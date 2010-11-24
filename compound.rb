require 'rubygems'
require 'opentox-ruby'
require 'test/unit'

class CompoundTest < Test::Unit::TestCase

  def test_compound

    c = OpenTox::Compound.from_smiles "F[B-](F)(F)F.[Na+]"
    assert_equal "InChI=1S/BF4.Na/c2-1(3,4)5;/q-1;+1", c.inchi
    #assert_equal "[Na+].F[B-](F)(F)F", c.smiles # still does not work on 64bit machines
    c = OpenTox::Compound.from_smiles "CC(=O)CC(C)C#N"
    assert_equal "InChI=1S/C6H9NO/c1-5(4-7)3-6(2)8/h5H,3H2,1-2H3", c.inchi
    assert_equal "CC(CC(=O)C)C#N", c.to_smiles
    c = OpenTox::Compound.from_name "Benzene"
    assert_equal "InChI=1S/C6H6/c1-2-4-6-5-3-1/h1-6H", c.inchi
    assert_equal "c1ccccc1", c.to_smiles
    c = OpenTox::Compound.from_smiles "N#[N+]C1=CC=CC=C1.F[B-](F)(F)F"
    assert_equal "InChI=1S/C6H5N2.BF4/c7-8-6-4-2-1-3-5-6;2-1(3,4)5/h1-5H;/q+1;-1", c.inchi
    assert_equal "N#[N+]c1ccccc1.F[B-](F)(F)F", c.to_smiles
    c = OpenTox::Compound.from_inchi "InChI=1S/C6H6/c1-2-4-6-5-3-1/h1-6H"
    assert_equal "c1ccccc1", c.to_smiles
    c = OpenTox::Compound.new "http://apps.ideaconsult.net:8080/ambit2/compound/144036"
    assert_equal "InChI=1S/C6H11NO2/c1-3-5-6(4-2)7(8)9/h5H,3-4H2,1-2H3", c.inchi
    assert_equal "CCC=C(CC)N(=O)=O", c.to_smiles
  end


end
