#!/bin/bash

# Copy the [de]activate scripts to $PREFIX/etc/conda/[de]activate.d.
# This will allow them to be run on environment activation.
# Name this script starting with `~` so it is run after all other compiler activation scripts.
# At the point of running this, $CXX must be defined.
for CHANGE in "activate" "deactivate"
do
    mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
    sed -e "s/@cross_target_platform@/$cross_target_platform/g" \
        -e "s/@arm_variant_target@/$arm_variant_target/g" \
        -e "s/@default_cudaarchs@/$DEFAULT_CUDAARCHS/g" \
        -e "s/@default_torch_cuda_arch_list@/$DEFAULT_TORCH_CUDA_ARCH_LIST/g" \
    "${RECIPE_DIR}/${CHANGE}.sh" > "${PREFIX}/etc/conda/${CHANGE}.d/~cuda-nvcc_${CHANGE}.sh"
done
