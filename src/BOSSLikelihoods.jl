module BOSSLikelihoods

using Artifacts
using NPZ

function __init__()

    global k = npzread(joinpath(artifact"BOSS_data", "k.npy"))

    global cmass_ngc_l0  = npzread(joinpath(artifact"BOSS_data", "cmass_ngc_l0.npy"))
    global cmass_ngc_l2  = npzread(joinpath(artifact"BOSS_data", "cmass_ngc_l2.npy"))
    global cmass_ngc_l4  = npzread(joinpath(artifact"BOSS_data", "cmass_ngc_l4.npy"))
    global cmass_ngc_cov = npzread(joinpath(artifact"BOSS_data", "cmass_ngc_cov.npy"))
    global k_mask_cmass_ngc = npzread(joinpath(artifact"BOSS_data", "k_mask_cmass_ngc.npy"))
    global mask_cmass_ngc = npzread(joinpath(artifact"BOSS_data", "mask_cmass_ngc.npy"))

    global cmass_sgc_l0  = npzread(joinpath(artifact"BOSS_data", "cmass_sgc_l0.npy"))
    global cmass_sgc_l2  = npzread(joinpath(artifact"BOSS_data", "cmass_sgc_l2.npy"))
    global cmass_sgc_l4  = npzread(joinpath(artifact"BOSS_data", "cmass_sgc_l4.npy"))
    global cmass_sgc_cov = npzread(joinpath(artifact"BOSS_data", "cmass_sgc_cov.npy"))
    global k_mask_cmass_sgc = npzread(joinpath(artifact"BOSS_data", "k_mask_cmass_sgc.npy"))
    global mask_cmass_sgc = npzread(joinpath(artifact"BOSS_data", "mask_cmass_sgc.npy"))

    global cmass_H = 92.9672
    global cmass_D = 1386.27
    global cmass_rd = 147.653

    global lowz_ngc_l0  = npzread(joinpath(artifact"BOSS_data", "lowz_ngc_l0.npy"))
    global lowz_ngc_l2  = npzread(joinpath(artifact"BOSS_data", "lowz_ngc_l2.npy"))
    global lowz_ngc_l4  = npzread(joinpath(artifact"BOSS_data", "lowz_ngc_l4.npy"))
    global lowz_ngc_cov = npzread(joinpath(artifact"BOSS_data", "lowz_ngc_cov.npy"))
    global k_mask_lowz_ngc = npzread(joinpath(artifact"BOSS_data", "k_mask_lowz_ngc.npy"))
    global mask_lowz_ngc = npzread(joinpath(artifact"BOSS_data", "mask_lowz_ngc.npy"))

    global lowz_sgc_l0  = npzread(joinpath(artifact"BOSS_data", "lowz_sgc_l0.npy"))
    global lowz_sgc_l2  = npzread(joinpath(artifact"BOSS_data", "lowz_sgc_l2.npy"))
    global lowz_sgc_l4  = npzread(joinpath(artifact"BOSS_data", "lowz_sgc_l4.npy"))
    global lowz_sgc_cov = npzread(joinpath(artifact"BOSS_data", "lowz_sgc_cov.npy"))
    global k_mask_lowz_sgc = npzread(joinpath(artifact"BOSS_data", "k_mask_lowz_sgc.npy"))
    global mask_lowz_sgc = npzread(joinpath(artifact"BOSS_data", "mask_lowz_sgc.npy"))

    global lowz_H = 80.1701
    global lowz_D = 990.132
    global lowz_rd = 147.653

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

function slice_data_cov(data, r_test, Cov, elements_to_remove_left, elements_to_remove_right)
    first_dataset = vcat(data[1,1+elements_to_remove_left:37-elements_to_remove_right],
                         data[2,1+elements_to_remove_left:37-elements_to_remove_right])
    first_dataset_vec = data[:,1+elements_to_remove_left:37-elements_to_remove_right]
    r_firstdataset = r_test[1+elements_to_remove_left:37-elements_to_remove_right]

    datavec_len = 37-elements_to_remove_left-elements_to_remove_right
    intermediate_Cov = zeros(37*3, 2*datavec_len)
    first_Cov = zeros(datavec_len*2,datavec_len*2)
    for i in 1:datavec_len
        intermediate_Cov[:,i] = Cov[:, i+elements_to_remove_left]
        intermediate_Cov[:,i+datavec_len] = Cov[:, i+elements_to_remove_left+37]
    end

    for i in 1:37-elements_to_remove_left-elements_to_remove_right
        first_Cov[i,:] = intermediate_Cov[i+elements_to_remove_left,:]
        first_Cov[i+37-elements_to_remove_left-elements_to_remove_right,:] = intermediate_Cov[i+elements_to_remove_left+37,:]
    end
    return first_dataset, r_firstdataset, first_Cov
end

end # module BOSSLikelihoods
