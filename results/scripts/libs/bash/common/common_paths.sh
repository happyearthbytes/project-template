__resolve_path(){
  RESOLVED_DIR="$(__resolve_dir "${1}")"
  echo $RESOLVED_DIR/"$(basename ${1})"
}
__resolve_dir(){
  echo $( cd -- "$(dirname "${1}")" >/dev/null 2>&1 ; pwd -P )
}

