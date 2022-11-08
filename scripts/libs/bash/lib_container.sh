#!/usr/bin/env bash

__CONTAINER_FILE_DIR=${__BASE_PATH}/containers
__CONTAINER_TOOL=echo
g_CONTAINER_IMAGES=()

__set_container_tool()
{
  __CONTAINER_TOOL=$1
}

__download_containers_from_web()
{
  local container=$@
  ${__CONTAINER_TOOL} pull "${container[@]}"
}

__save_container_image()
{
  local image_names=${@:1:$#-1}
  local host_path=${@:$#}
  mkdir -p "${host_path}"
  for image_name in ${image_names[@]}; do
    ${__CONTAINER_TOOL} save -o "${host_path}"/"${image_name%:*}"-"${image_name##*:}".tar "${image_name}"
    __log echo "${host_path}"/"${image_name%:*}"-"${image_name##*:}".tar
  done
}

__copy_from_image()
{
  local image_name=$1
  local container_path=$2
  local output_path=$3
  mkdir -p "${output_path}"
  local container_id=$(podman create "${image_name}" --)
  ${__CONTAINER_TOOL} cp "${container_id}":"${container_path}"/ "${output_path}"/
  ${__CONTAINER_TOOL} container rm "${container_id}" > /dev/null
}

__load_from_container_tar()
{
  __LOADED_IMAGES=()
  local image_tars=${@}
  for image_tar in ${image_tars[@]}; do
    local loaded=$(${__CONTAINER_TOOL} load --input "${image_tar}" -q)
    __LOADED_IMAGES+=("${loaded#*: }")
  done
}

__copy_from_container_tar()
{
  local tar_file=$1
  local container_path=$2
  local output_path=$3
  __load_from_container_tar "${tar_file}"
  __copy_from_image ${__LOADED_IMAGES[@]} "${container_path}" "${output_path}"
}

__build_container_from_dir()
{
  local container=$@
  for item in ${container[@]} ; do
    local this_item=$item
    local image_requirements=$(sed -n '/requirements:/ s/[^:]*: *//p' "${item}"/config.yml)

    if [ -f $(__resolve_path "${this_item}"/"${image_requirements}"/config.yml) ]; then
      local resolved_dir="$(__resolve_dir "${this_item}"/"${image_requirements}"/config.yml)"
      if [ "${resolved_dir}" != "${this_item}" ]; then
        __build_container_from_dir "${resolved_dir}"
      fi
    fi
    local image_name=$(sed -n '/image_name:/ s/[^:]*: *//p' "${this_item}"/config.yml)
    local image_tag=$(sed -n '/image_tag:/ s/[^:]*: *//p' "${this_item}"/config.yml)
    g_CONTAINER_IMAGES+=("${image_name}:${image_tag}")
    local image_build_context=$(sed -n '/build_context:/ s/[^:]*:\s\+//p' "${this_item}"/config.yml)
    ${__CONTAINER_TOOL} build -f "${this_item}"/Containerfile -t "${image_name}":"${image_tag}" "${this_item}"/"${image_build_context}"
  done
}