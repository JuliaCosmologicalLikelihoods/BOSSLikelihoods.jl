module BOSSLikelihoods

using Artifacts
using NPZ

function __init__()

    global k = npzread(joinpath(artifact"BOSS_data", "k.npy"))

    global cmass_ngc_l0  = npzread(joinpath(artifact"BOSS_data", "cmass_ngc_l0.npy"))
    global cmass_ngc_l2  = npzread(joinpath(artifact"BOSS_data", "cmass_ngc_l2.npy"))
    global cmass_ngc_l4  = npzread(joinpath(artifact"BOSS_data", "cmass_ngc_l4.npy"))
    global cmass_ngc_cov = npzread(joinpath(artifact"BOSS_data", "cmass_ngc_cov.npy"))

    global cmass_sgc_l0  = npzread(joinpath(artifact"BOSS_data", "cmass_sgc_l0.npy"))
    global cmass_sgc_l2  = npzread(joinpath(artifact"BOSS_data", "cmass_sgc_l2.npy"))
    global cmass_sgc_l4  = npzread(joinpath(artifact"BOSS_data", "cmass_sgc_l4.npy"))
    global cmass_sgc_cov = npzread(joinpath(artifact"BOSS_data", "cmass_sgc_cov.npy"))

    global lowz_ngc_l0  = npzread(joinpath(artifact"BOSS_data", "lowz_ngc_l0.npy"))
    global lowz_ngc_l2  = npzread(joinpath(artifact"BOSS_data", "lowz_ngc_l2.npy"))
    global lowz_ngc_l4  = npzread(joinpath(artifact"BOSS_data", "lowz_ngc_l4.npy"))
    global lowz_ngc_cov = npzread(joinpath(artifact"BOSS_data", "lowz_ngc_cov.npy"))

    global lowz_sgc_l0  = npzread(joinpath(artifact"BOSS_data", "lowz_sgc_l0.npy"))
    global lowz_sgc_l2  = npzread(joinpath(artifact"BOSS_data", "lowz_sgc_l2.npy"))
    global lowz_sgc_l4  = npzread(joinpath(artifact"BOSS_data", "lowz_sgc_l4.npy"))
    global lowz_sgc_cov = npzread(joinpath(artifact"BOSS_data", "lowz_sgc_cov.npy"))

end


function mask_cov(cov, n)
    #TODO remove hardcoded numbers
    elements_to_remove_left = 0
    elements_to_remove_right = 37-n
    datavec_len = 37-elements_to_remove_left-elements_to_remove_right
    intermediate_Cov = zeros(111, 2*datavec_len)
    first_Cov = zeros(datavec_len*2,datavec_len*2)

    for i in 1:datavec_len
        intermediate_Cov[:,i] = cov[:, i+elements_to_remove_left]
        intermediate_Cov[:,i+datavec_len] = cov[:, i+elements_to_remove_left+37]
    end

    for i in 1:37-elements_to_remove_left-elements_to_remove_right
        first_Cov[i,:] = intermediate_Cov[i+elements_to_remove_left,:]
        first_Cov[i+37-elements_to_remove_left-elements_to_remove_right,:] =
        intermediate_Cov[i+elements_to_remove_left+37,:]
    end

    yerror_Mono = ones(n)
    yerror_Quad = ones(n)

    for i in 1:n
        yerror_Mono[i] = sqrt(cov[i,i])
        yerror_Quad[i] = sqrt(cov[37+i,37+i])
    end

    #let us enforce the covariance to be symmetric
    Covariance = (first_Cov .+ first_Cov')./2

    return Covariance, yerror_Mono, yerror_Quad
end

end # module BOSSLikelihoods
