describe IGMarkets::DealingPlatform::SprintMarketPositionMethods do
  let(:session) { IGMarkets::Session.new }
  let(:platform) do
    IGMarkets::DealingPlatform.new.tap do |platform|
      platform.instance_variable_set :@session, session
    end
  end

  it 'can retrieve the current sprint market positions' do
    positions = [build(:sprint_market_position)]

    expect(session).to receive(:get)
      .with('positions/sprintmarkets', IGMarkets::API_V1)
      .and_return(sprint_market_positions: positions)

    expect(platform.sprint_market_positions.all).to eq(positions)
  end

  it 'can create a sprint market position' do
    attributes = {
      direction: :buy,
      epic: 'CS.D.EURUSD.CFD.IP',
      expiry_period: :five_minutes,
      size: 2.0
    }

    payload = {
      direction: 'BUY',
      epic: 'CS.D.EURUSD.CFD.IP',
      expiryPeriod: 'FIVE_MINUTES',
      size: 2.0
    }

    result = { deal_reference: 'reference' }

    expect(session).to receive(:post).with('positions/sprintmarkets', payload, IGMarkets::API_V1).and_return(result)
    expect(platform.sprint_market_positions.create(attributes)).to eq(result.fetch(:deal_reference))
  end
end
