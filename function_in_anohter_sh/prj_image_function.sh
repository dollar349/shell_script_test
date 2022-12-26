
copy_image_file()
{
    local image_dir=$1
    local output_dir=$2
    local CALLER_NAME=$(basename $0)

    if [ ! -d ${image_dir} ]; then
        echo "Image not found!"
        return 1
    fi

    if [ -d ${output_dir} ]; then
        sudo rm -rf ${output_dir}
    fi
    mkdir -p ${output_dir}
    if test "${TARGET_MACHINE}" = "ast2600evb"; then
        if test "${CALLER_NAME}" = "upload_mr_build.sh"; then
            # For Merge request build
            install -m 0644 ${image_dir}/image-bmc ${output_dir}/.
            install -m 0644 ${image_dir}/obmc-phosphor-image-aci-ast2600evb.static.mtd.tar ${output_dir}/.
        else
            install -m 0644 ${image_dir}/image-bmc ${output_dir}/.
            install -m 0644 ${image_dir}/obmc-phosphor-image-aci-ast2600evb.static.mtd.tar ${output_dir}/.
            install -m 0644 ${image_dir}/image-kernel ${output_dir}/.
            install -m 0644 ${image_dir}/image-rofs ${output_dir}/.
            install -m 0644 ${image_dir}/image-u-boot ${output_dir}/.
        fi
    elif test "${TARGET_MACHINE}" = "archercity"; then
        if test "${CALLER_NAME}" = "upload_mr_build.sh"; then
            # For Merge request build
            install -m 0644 ${image_dir}/image-bmc ${output_dir}/.
            install -m 0644 ${image_dir}/obmc-phosphor-image-aci-ast2600evb.static.mtd.tar ${output_dir}/.
        else
            install -m 0644 ${image_dir}/image-bmc ${output_dir}/.
            install -m 0644 ${image_dir}/obmc-phosphor-image-aci-ast2600evb.static.mtd.tar ${output_dir}/.
            install -m 0644 ${image_dir}/image-kernel ${output_dir}/.
            install -m 0644 ${image_dir}/image-rofs ${output_dir}/.
            install -m 0644 ${image_dir}/image-u-boot ${output_dir}/.
        fi
    fi
}