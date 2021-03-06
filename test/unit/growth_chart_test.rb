require_relative '../test_helper'

class GrowthChartTest < Minitest::Test
  def setup
    @rule = Synthea::Modules::Lifecycle.new
  end

  def test_spot_check
    # pick some actual numbers from the chart and make sure they match
    # note - ages are in months

    # from wtage.csv
    assert_in_delta(15.18777349, @rule.growth_chart('weight', 'M', 24, 95), 0.1)
    assert_in_delta(12.06899744, @rule.growth_chart('weight', 'M', 32, 10), 0.1)
    assert_in_delta(55.35950558, @rule.growth_chart('weight', 'F', 206, 50), 0.1)

    # from wtageinf.csv
    assert_in_delta(9.34149038, @rule.growth_chart('weight', 'M', 7, 75), 0.1)
    assert_in_delta(9.508084539, @rule.growth_chart('weight', 'F', 14, 25), 0.1)
    assert_in_delta(9.867081272, @rule.growth_chart('weight', 'F', 21, 5), 0.1)

    # from statage.csv
    assert_in_delta(129.7540048, @rule.growth_chart('height', 'M', 118, 10), 0.1)
    assert_in_delta(92.67925322, @rule.growth_chart('height', 'F', 38, 25), 0.1)
    assert_in_delta(140.9491785, @rule.growth_chart('height', 'F', 99, 97), 0.1)

    # from lenageinf.csv
    assert_in_delta(82.40543643, @rule.growth_chart('height', 'M', 18, 50), 0.1)
    assert_in_delta(67.48634824, @rule.growth_chart('height', 'M', 9, 3), 0.1)
    assert_in_delta(62.12329513, @rule.growth_chart('height', 'F', 3, 75), 0.1)
  end

  def test_interpolation
    # pick some percentiles that aren't in the chart
    # and make sure the resulting value is in range

    # from wtage.csv
    assert_includes(17.66..19.24, @rule.growth_chart('weight', 'M', 64, 40))
    assert_includes(31.59..35.92, @rule.growth_chart('weight', 'F', 128, 35))

    # from wtageinf.csv
    assert_includes(9.34..10.02, @rule.growth_chart('weight', 'M', 7, 80))
    assert_includes(9.02..9.36, @rule.growth_chart('weight', 'F', 16, 7))


    # from statage.csv
    assert_includes(167.21..171.60, @rule.growth_chart('height', 'M', 222, 19))
    assert_includes(130.16..134.38, @rule.growth_chart('height', 'F', 111, 42))

    # from lenageinf.csv
    assert_includes(84.63..86.67, @rule.growth_chart('height', 'M', 18, 77))
    assert_includes(59.32..60.84, @rule.growth_chart('height', 'F', 4, 15))
  end
end