namespace :corona do
  desc 'Take a snapshot of the cases number'
  task :case_snapshot => :environment do
    cases = ::Corona::ApiClient.request('t/nubentos.com/ncovapi/cases')&.first
    case_thing = Case.where(snapshot: cases['date']).first_or_create(amount: cases['cases'], snapshot: cases['date'])
    Corona::EsClient.update_cases(case_thing)
  end

  desc 'Take a snapshot of the deaths number'
  task :death_snapshot => :environment do
    deaths = Corona::ApiClient.request('t/nubentos.com/ncovapi/deaths')&.first
    death_thing = Death.where(snapshot: deaths['date']).first_or_create(amount: deaths['data'], snapshot: deaths['date'])
    Corona::EsClient.update_deaths(death_thing)
  end

  desc 'Take a snapshot of the recovered number'
  task :recover_snapshot => :environment do
    recovers = Corona::ApiClient.request('t/nubentos.com/ncovapi/recovered')&.first
    recover_thing = Recover.where(snapshot: recovers['date']).first_or_create(amount: recovers['data'], snapshot: recovers['date'])
    Corona::EsClient.update_recovered(recover_thing)
  end
end