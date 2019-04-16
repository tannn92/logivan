require './check_out'

RSpec.describe CheckOut do
  describe '#total' do
    let(:lavender_heart) { Product.new('001', 'Lavender heart', 9.25) }
    let(:personalised_cufflinks) { Product.new('002', 'Personalised cufflinks', 45) }
    let(:kids_tshirt) { Product.new('003', 'Kids T-shirt', 19.95) }
    let(:lavender_heart_rule) { SpecificProductRule.new(lavender_heart, 2, 8.5) }
    let(:total_price_rule) { TotalPriceRule.new(60, 0.1) }
    let(:promotional_rules) { [lavender_heart_rule, total_price_rule] }
    let(:co) { CheckOut.new(promotional_rules) }

    context 'There is no item in the order' do
      let(:expected_result) { 0 }

      it 'returns 0 as default total' do
        expect(co.total.round(2)).to eq expected_result
      end
    end

    context 'There are items in the order' do
      context 'No rule is applied' do
        let(:expected_result) { 29.2 }

        it 'returns original total' do
          co.scan(lavender_heart)
          co.scan(kids_tshirt)

          expect(co.total.round(2)).to eq expected_result
        end
      end

      context 'Only total price rule is applied' do
        let(:expected_result) { 66.78 }

        it 'returns total with total price rule applied' do
          co.scan(lavender_heart)
          co.scan(personalised_cufflinks)
          co.scan(kids_tshirt)

          expect(co.total.round(2)).to eq expected_result
        end
      end

      context 'Only specific product rule is applied' do
        let(:expected_result) { 36.95 }

        it 'returns total with total price rule applied' do
          co.scan(lavender_heart)
          co.scan(kids_tshirt)
          co.scan(lavender_heart)

          expect(co.total.round(2)).to eq expected_result
        end
      end

      context 'Both rules are applied' do
        let(:expected_result) { 73.76 }

        it 'returns total with both rules applied' do
          co.scan(lavender_heart)
          co.scan(kids_tshirt)
          co.scan(lavender_heart)
          co.scan(personalised_cufflinks)

          expect(co.total.round(2)).to eq expected_result
        end
      end
    end
  end
end
