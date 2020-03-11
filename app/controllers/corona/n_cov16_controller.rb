class Corona::NCov16Controller < ApplicationController
  def cases
    @cases = Corona::ApiClient.request('t/nubentos.com/ncovapi/cases')&.first
    case_thing = Case.where(snapshot: @cases['date']).first_or_create(amount: @cases['cases'], snapshot: @cases['date'])
    Corona::EsClient.update_cases(case_thing)

    @all_cases = Case.order(:amount).all

    @min = Case.first.amount - @all_cases.size / 10
    @max = Case.last.amount + @all_cases.size / 10

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cases }
    end
  end

  def deaths
    @deaths = Corona::ApiClient.request('t/nubentos.com/ncovapi/deaths')&.first
    death_thing = Death.where(snapshot: @deaths['date']).first_or_create(amount: @deaths['data'], snapshot: @deaths['date'])
    Corona::EsClient.update_deaths(death_thing)

    @all_deaths = Death.all

    @min = Death.first.amount - @all_deaths.size / 10
    @max = Death.last.amount + @all_deaths.size / 10

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @deaths }
    end
  end

  def recovers
    @recovers = Corona::ApiClient.request('t/nubentos.com/ncovapi/recovered')&.first
    recover_thing = Recover.where(snapshot: @recovers['date']).first_or_create(amount: @recovers['data'], snapshot: @recovers['date'])
    Corona::EsClient.update_recovered(recover_thing)

    @all_recovers = Recover.all

    @min = Recover.first.amount - @all_recovers.size / 10
    @max = Recover.last.amount + @all_recovers.size / 10

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recovers }
    end
  end
end
