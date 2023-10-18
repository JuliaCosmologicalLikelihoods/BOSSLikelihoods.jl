module BOSSLikelihoods

using Artifacts
using NPZ

function __init__()

    k = npzread(joinpath(artifact"BOSS_data", "k.npy"))

    cmass_ngc_l0  = npzread(joinpath(artifact"BOSS_data", "cmass_ngc_l0.npy"))
    cmass_ngc_l2  = npzread(joinpath(artifact"BOSS_data", "cmass_ngc_l2.npy"))
    cmass_ngc_l4  = npzread(joinpath(artifact"BOSS_data", "cmass_ngc_l4.npy"))
    cmass_ngc_cov = npzread(joinpath(artifact"BOSS_data", "cmass_ngc_cov.npy"))

    cmass_sgc_l0  = npzread(joinpath(artifact"BOSS_data", "cmass_sgc_l0.npy"))
    cmass_sgc_l2  = npzread(joinpath(artifact"BOSS_data", "cmass_sgc_l2.npy"))
    cmass_sgc_l4  = npzread(joinpath(artifact"BOSS_data", "cmass_sgc_l4.npy"))
    cmass_sgc_cov = npzread(joinpath(artifact"BOSS_data", "cmass_sgc_cov.npy"))

    lowz_ngc_l0  = npzread(joinpath(artifact"BOSS_data", "lowz_ngc_l0.npy"))
    lowz_ngc_l2  = npzread(joinpath(artifact"BOSS_data", "lowz_ngc_l2.npy"))
    lowz_ngc_l4  = npzread(joinpath(artifact"BOSS_data", "lowz_ngc_l4.npy"))
    lowz_ngc_cov = npzread(joinpath(artifact"BOSS_data", "lowz_ngc_cov.npy"))

    lowz_sgc_l0  = npzread(joinpath(artifact"BOSS_data", "lowz_sgc_l0.npy"))
    lowz_sgc_l2  = npzread(joinpath(artifact"BOSS_data", "lowz_sgc_l2.npy"))
    lowz_sgc_l4  = npzread(joinpath(artifact"BOSS_data", "lowz_sgc_l4.npy"))
    lowz_sgc_cov = npzread(joinpath(artifact"BOSS_data", "lowz_sgc_cov.npy"))

end

end # module BOSSLikelihoods
