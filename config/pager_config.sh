# Pagers:
# This affects every invocation of `less`.
#   -i   case-insensitive search unless search string contains uppercase letters
#   -R   color
#   -F   exit if there is less than one page of content
#   -X   keep content on screen after exit
#   -M   show more info at the bottom prompt line
#   -x4  tabs are 4 instead of 8
export LESS="-iRFXMx4 --mouse --wheel-lines=2"
export PAGER='less'
export MANPAGER='less'

# Color support for 'less' and 'man'
#
# mb = blinking mode (start)
# md = bold mode (start)
# me = END all modes
# mh = half bright mode (start)
# mr = reverse mode (start)
#
# se = END standout mode
# so = standout mode (start)
#
# us = underlining (start)
# ue = END underlining
#
# ZH = italic mode (start)
# ZR = END italic mode
# ZN = subscript mode (start)
# ZV = END subscript mode
# ZO = superscript mode (start)
# ZW = END superscript mode

function man() {
  env \
    LESS_TERMCAP_mb=$(tput bold; tput setaf 5) \
    LESS_TERMCAP_md=$(tput setaf 4) \
    LESS_TERMCAP_me=$(tput sgr0) \
    LESS_TERMCAP_mh=$(tput dim) \
    LESS_TERMCAP_mr=$(tput rev) \
    LESS_TERMCAP_se=$(tput rmso; tput sgr0) \
    LESS_TERMCAP_so=$(tput setaf 0; tput setab 7) \
    LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 3) \
    LESS_TERMCAP_ue=$(tput rmul; tput sgr0) \
    LESS_TERMCAP_ZN=$(tput ssubm) \
    LESS_TERMCAP_ZV=$(tput rsubm) \
    LESS_TERMCAP_ZO=$(tput ssupm) \
    LESS_TERMCAP_ZW=$(tput rsupm) \
      command man ${@}
}
