function [ llk ] = SSKF_wrap( params,setup,data )

llk=zeros(setup.number_models,1);
if setup.initial_provided==1

for mm=1:setup.number_models
wrapper_func=str2func(setup.wrapper{mm});
[A B C D add_matrices]=wrapper_func([params(setup.index_model{1});params(setup.index_model{mm+1})],setup,data{mm});
[ llk(mm) xest] = SSKF(A,B,C,D,setup.state_initial{mm},data{mm});
end

else
for mm=1:setup.number_models
wrapper_func=str2func(setup.wrapper{mm});
[A B C D initial_state initial_cov add_matrices]=wrapper_func([params(setup.index_model{1});params(setup.index_model{mm+1})],setup,data{mm});;
[ llk(mm) xest] = SSKF(A,B,C,D,initial_state,data{mm});

    
end



xest=[];
add_matrices=[]; %keep those empty for now. Change this later if we want to store estimates states or something else

end