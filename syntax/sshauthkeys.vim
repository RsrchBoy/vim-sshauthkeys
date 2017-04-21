if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

set iskeyword+=-

" don't wrap on editing
setlocal textwidth=0

" Options
syn match   sshOptionError contained "\k\+" nextgroup=sshOptionSep
syn match   sshOptionSep "," contained nextgroup=sshOption,sshOptionError
syn region  sshOptionString start=/"/ skip=/\\"/ end=/"/ oneline nextgroup=sshOptionSep,sshSSH2Key contained
syn keyword sshOption contained nextgroup=sshOptionSep cert-authority no-agent-forwarding no-port-forwarding no-pty no-user-rc no-X11-forwarding
syn match   sshOption /\<\(command\|environment\|from\|permitopen\|principals\|tunnel\)=/ nextgroup=sshOptionString contained

" SSH1
"
" syn match sshSSH1Bits     "\(^\| \)\d*" nextgroup=sshSSH1Exponent
syn match sshSSH1Bits     "\(^\| \)\d*" nextgroup=sshSSH1Exponent contained
syn match sshSSH1Exponent " \d*" contained nextgroup=sshSSH1Modulus
syn match sshSSH1Modulus  " \d*" contained nextgroup=sshSSH1Comment
syn match sshSSH1Comment  " .*" contained

" SSH2

syn region  sshSSH2Key     start=/\<AAAA/ end=/\( \|$\)/ keepend nextgroup=sshSSH2Comment contains=NONE,sshSSH2KeyBody oneline conceal cchar=*
syn match   sshSSH2Comment /\S.*$/ contained
syn keyword sshSSH2KeyType ecdsa-sha2-nistp256 ecdsa-sha2-nistp384 ecdsa-sha2-nistp521 ssh-ed25519 ssh-rsa ssh-dss nextgroup=sshSSH2Key,sshOption,sshOptionError

" Strings
syn region sshString start=/"/ skip=/\\"/ end=/"/ oneline

" Comments
syn match sshComment /^#.*/

if version >= 508
	command -nargs=+ HiLink hi link <args>
else
	command -nargs=+ HiLink hi def link <args>
endif

HiLink sshSSH1Bits     Type
HiLink sshSSH1Exponent Special
HiLink sshSSH1Comment  Comment

HiLink sshSSH2KeyType Type
HiLink sshSSH2Comment Comment
HiLink sshSSH2Key     Ignore

HiLink sshComment Comment

HiLink sshOption        Keyword
HiLink sshOptionError   Error
HiLink sshString        String
HiLink sshOptionString  sshString

delcommand HiLink

let b:current_syntax = "sshauthkeys"

