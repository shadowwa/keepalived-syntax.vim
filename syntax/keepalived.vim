" Vim syntax file
" Language:     keepalived config http://www.keepalived.org/
" URL:          https://github.com/shadowwa/keepalived-syntax.vim
" Version:      2.0.6
" Author:       Akira Maeda <glidenote@gmail.com>
" Maintainer:   Shad

if exists("b:current_syntax")
  finish
end

setlocal iskeyword+=.
setlocal iskeyword+=/
setlocal iskeyword+=:

syntax sync fromstart

syn match   keepalivedDelimiter   "[{}()\[\];,]"
syn match   keepalivedOperator    "[~!=|&\*\+\<\>]"
syn match   keepalivedComment     "\([#!].*\)"
syn match   keepalivedNumber      "[-+]\=\<\d\+\(\.\d*\)\=\>"
syn region  keepalivedString      start=+"+ skip=+\\"+ end=+"+

syn keyword keepalivedBoolean on off true false yes no
syn keyword keepalivedLvsSched rr wrr lc wlc lblc sh dh fo ovf lblcr sed nq containedin=keepalivedvirtual_serverBlock
syn keyword keepalivedStatus MASTER BACKUP containedin=keepalivedvrrp_instanceBlock
syn keyword keepalivedProto TCP SCTP UDP containedin=keepalivedvirtual_serverBlock
syn keyword keepalivedMethod NAT DR TUN containedin=keepalivedvirtual_serverBlock

" IPv4
syn match ipaddress excludenl /\v\s(25[0-4]|2[0-4]\d|1\d{1,2}|[1-9]\d|[1-9])\.(25[0-5]|2[0-4]\d|1\d\d|\d{1,2})\.(25[0-5]|2[0-4]\d|1\d\d|\d{1,2})\.(25[0-5]|2[0-4]\d|1\d\d|\d{1,2})/ nextgroup=ipaddr_cidr,subnetmask contained containedin=keepalivedGenericBlock
syn match ipaddr_cidr /\v[/]\d{1,3}/ contained
syn match subnetmask contained excludenl  /\v (0|192|224|240|248|252|254|255)\.(0|128|192|224|240|248|252|254|255)\.(0|128|192|224|240|248|252|254|255)\.(0|128|192|224|240|248|252|254|255)/he=e+1
" IPv6
syn match   ipaddress       /\s\(\x\{1,4}\:\)\{7}\(\:\|\(\x\{1,4}\)\)/
syn match   ipaddress       /\s\(\x\{1,4}\:\)\{6}\(\:\|\(\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\(\.\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\)\{3}\)\|\(\:\x\{1,4}\)\)/
syn match   ipaddress       /\s\(\x\{1,4}\:\)\{5}\(\(\:\(\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\(\.\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\)\{3}\)\?\)\|\(\(\:\x\{1,4}\)\{1,2}\)\)/
syn match   ipaddress       /\s\(\x\{1,4}\:\)\{4}\(\:\x\{1,4}\)\{0,1}\(\:\(\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\(\.\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\)\{3}\)\?\)/
syn match   ipaddress       /\s\(\x\{1,4}\:\)\{4}\(\:\x\{1,4}\)\{0,1}\(\(\:\x\{1,4}\)\{1,2}\)/
syn match   ipaddress       /\s\(\x\{1,4}\:\)\{3}\(\:\x\{1,4}\)\{0,2}\(\:\(\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\(\.\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\)\{3}\)\?\)/
syn match   ipaddress       /\s\(\x\{1,4}\:\)\{3}\(\:\x\{1,4}\)\{0,2}\(\(\:\x\{1,4}\)\{1,2}\)/
syn match   ipaddress       /\s\(\x\{1,4}\:\)\{2}\(\:\x\{1,4}\)\{0,3}\(\:\(\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\(\.\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\)\{3}\)\?\)/
syn match   ipaddress       /\s\(\x\{1,4}\:\)\{2}\(\:\x\{1,4}\)\{0,3}\(\(\:\x\{1,4}\)\{1,2}\)/
syn match   ipaddress       /\s\(\x\{1,4}\:\)\(\:\x\{1,4}\)\{0,4}\(\:\(\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\(\.\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\)\{3}\)\?\)/
syn match   ipaddress       /\s\(\x\{1,4}\:\)\(\:\x\{1,4}\)\{0,4}\(\(\:\x\{1,4}\)\{1,2}\)/
syn match   ipaddress       /\s\:\(\:\x\{1,4}\)\{0,5}\(\(\:\(\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\(\.\(25[0-5]\|2[0-4]\d\|[01]\?\d\{1,2}\)\)\{3}\)\?\)\|\(\(\:\x\{1,4}\)\{1,2}\)\)/

highlight link ipaddress Constant
highlight link ipaddr_cidr Constant
highlight link subnetmask Constant

syn match keepalivedDirective /^\s*@\w\+/ containedin=ALL
highlight link keepalivedDirective PreProc

syn keyword keepalivedInclude include includer includem includew includeb includea
highlight link keepalivedInclude Include
" add include_check ?

" root

syn region keepalivedSSLBlock start="\s*SSL\ze\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedSSLKeyword,keepalivedSSLDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock
syn keyword keepalivedSSLDefinition                            SSL contained containedin=keepalivedSSLBlock

" SSL
syn keyword keepalivedSSLKeyword                                  ca  contained
syn keyword keepalivedSSLKeyword                         certificate  contained
syn keyword keepalivedSSLKeyword                                 key  contained
syn keyword keepalivedSSLKeyword                            password  contained
highlight link keepalivedSSLDefinition  Statement
highlight link keepalivedSSLKeyword       Type

syn keyword keepalivedrootKeyword                     child_wait_time           

syn region keepalivedgarp_groupBlock start="\s*garp_group\ze\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedgarp_groupKeyword,keepalivedgarp_groupDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock
syn keyword keepalivedgarp_groupDefinition                     garp_group contained containedin=keepalivedgarp_groupBlock

" garp_group
syn keyword keepalivedgarp_groupKeyword                       garp_interval  contained
syn keyword keepalivedgarp_groupKeyword                        gna_interval  contained
syn keyword keepalivedgarp_groupKeyword                           interface  contained
syn keyword keepalivedgarp_groupKeyword                          interfaces  contained
highlight link keepalivedgarp_groupDefinition  Statement
highlight link keepalivedgarp_groupKeyword       Type


syn region keepalivedglobal_defsBlock start="\s*global_defs\ze\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedglobal_defsKeyword,keepalivedglobal_defsDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock
syn keyword keepalivedglobal_defsDefinition                    global_defs contained containedin=keepalivedglobal_defsBlock

" global_defs
syn keyword keepalivedglobal_defsKeyword                         bfd_no_swap  contained
syn keyword keepalivedglobal_defsKeyword                        bfd_priority  contained
syn keyword keepalivedglobal_defsKeyword                    bfd_rlimit_rtime  contained
syn keyword keepalivedglobal_defsKeyword                     bfd_rt_priority  contained
syn keyword keepalivedglobal_defsKeyword                     checker_no_swap  contained
syn keyword keepalivedglobal_defsKeyword                    checker_priority  contained
syn keyword keepalivedglobal_defsKeyword                checker_rlimit_rtime  contained
syn keyword keepalivedglobal_defsKeyword                 checker_rt_priority  contained
syn keyword keepalivedglobal_defsKeyword                   dbus_service_name  contained
syn keyword keepalivedglobal_defsKeyword                   default_interface  contained
syn keyword keepalivedglobal_defsKeyword                  dynamic_interfaces  contained
syn keyword keepalivedglobal_defsKeyword                         enable_dbus  contained
syn keyword keepalivedglobal_defsKeyword              enable_script_security  contained
syn keyword keepalivedglobal_defsKeyword                 enable_snmp_checker  contained
syn keyword keepalivedglobal_defsKeyword              enable_snmp_keepalived  contained
syn keyword keepalivedglobal_defsKeyword                     enable_snmp_rfc  contained
syn keyword keepalivedglobal_defsKeyword                   enable_snmp_rfcv2  contained
syn keyword keepalivedglobal_defsKeyword                   enable_snmp_rfcv3  contained
syn keyword keepalivedglobal_defsKeyword                    enable_snmp_vrrp  contained
syn keyword keepalivedglobal_defsKeyword                        enable_traps  contained
syn keyword keepalivedglobal_defsKeyword                           lvs_flush  contained
syn keyword keepalivedglobal_defsKeyword            lvs_netlink_cmd_rcv_bufs  contained
syn keyword keepalivedglobal_defsKeyword      lvs_netlink_cmd_rcv_bufs_force  contained
syn keyword keepalivedglobal_defsKeyword        lvs_netlink_monitor_rcv_bufs  contained
syn keyword keepalivedglobal_defsKeyword  lvs_netlink_monitor_rcv_bufs_force  contained
syn keyword keepalivedglobal_defsKeyword                     lvs_notify_fifo  contained
syn keyword keepalivedglobal_defsKeyword              lvs_notify_fifo_script  contained
syn keyword keepalivedglobal_defsKeyword                     lvs_sync_daemon  contained
syn keyword keepalivedglobal_defsKeyword                        lvs_timeouts  contained
syn keyword keepalivedglobal_defsKeyword                   no_checker_emails  contained
syn keyword keepalivedglobal_defsKeyword                     no_email_faults  contained
syn keyword keepalivedglobal_defsKeyword                  notification_email  contained
syn keyword keepalivedglobal_defsKeyword             notification_email_from  contained
syn keyword keepalivedglobal_defsKeyword                         notify_fifo  contained
syn keyword keepalivedglobal_defsKeyword                  notify_fifo_script  contained
syn keyword keepalivedglobal_defsKeyword                           router_id  contained
syn keyword keepalivedglobal_defsKeyword                    rs_init_notifies  contained
syn keyword keepalivedglobal_defsKeyword                         script_user  contained
syn keyword keepalivedglobal_defsKeyword                          smtp_alert  contained
syn keyword keepalivedglobal_defsKeyword                  smtp_alert_checker  contained
syn keyword keepalivedglobal_defsKeyword                     smtp_alert_vrrp  contained
syn keyword keepalivedglobal_defsKeyword                smtp_connect_timeout  contained
syn keyword keepalivedglobal_defsKeyword                      smtp_helo_name  contained
syn keyword keepalivedglobal_defsKeyword                         smtp_server  contained
syn keyword keepalivedglobal_defsKeyword                         snmp_socket  contained
syn keyword keepalivedglobal_defsKeyword              vrrp_check_unicast_src  contained
syn keyword keepalivedglobal_defsKeyword                  vrrp_garp_interval  contained
syn keyword keepalivedglobal_defsKeyword          vrrp_garp_lower_prio_delay  contained
syn keyword keepalivedglobal_defsKeyword         vrrp_garp_lower_prio_repeat  contained
syn keyword keepalivedglobal_defsKeyword              vrrp_garp_master_delay  contained
syn keyword keepalivedglobal_defsKeyword            vrrp_garp_master_refresh  contained
syn keyword keepalivedglobal_defsKeyword     vrrp_garp_master_refresh_repeat  contained
syn keyword keepalivedglobal_defsKeyword             vrrp_garp_master_repeat  contained
syn keyword keepalivedglobal_defsKeyword                   vrrp_gna_interval  contained
syn keyword keepalivedglobal_defsKeyword        vrrp_higher_prio_send_advert  contained
syn keyword keepalivedglobal_defsKeyword                         vrrp_ipsets  contained
syn keyword keepalivedglobal_defsKeyword                       vrrp_iptables  contained
syn keyword keepalivedglobal_defsKeyword           vrrp_lower_prio_no_advert  contained
syn keyword keepalivedglobal_defsKeyword                   vrrp_mcast_group4  contained
syn keyword keepalivedglobal_defsKeyword                   vrrp_mcast_group6  contained
syn keyword keepalivedglobal_defsKeyword           vrrp_netlink_cmd_rcv_bufs  contained
syn keyword keepalivedglobal_defsKeyword     vrrp_netlink_cmd_rcv_bufs_force  contained
syn keyword keepalivedglobal_defsKeyword       vrrp_netlink_monitor_rcv_bufs  contained
syn keyword keepalivedglobal_defsKeyword vrrp_netlink_monitor_rcv_bufs_force  contained
syn keyword keepalivedglobal_defsKeyword                        vrrp_no_swap  contained
syn keyword keepalivedglobal_defsKeyword                    vrrp_notify_fifo  contained
syn keyword keepalivedglobal_defsKeyword             vrrp_notify_fifo_script  contained
syn keyword keepalivedglobal_defsKeyword                       vrrp_priority  contained
syn keyword keepalivedglobal_defsKeyword                   vrrp_rlimit_rtime  contained
syn keyword keepalivedglobal_defsKeyword                    vrrp_rt_priority  contained
syn keyword keepalivedglobal_defsKeyword             vrrp_rx_bufs_multiplier  contained
syn keyword keepalivedglobal_defsKeyword                 vrrp_rx_bufs_policy  contained
syn keyword keepalivedglobal_defsKeyword            vrrp_skip_check_adv_addr  contained
syn keyword keepalivedglobal_defsKeyword                         vrrp_strict  contained
syn keyword keepalivedglobal_defsKeyword                        vrrp_version  contained
highlight link keepalivedglobal_defsDefinition  Statement
highlight link keepalivedglobal_defsKeyword       Type

syn keyword keepalivedrootKeyword                            instance           
syn keyword keepalivedrootKeyword                linkbeat_use_polling           
syn keyword keepalivedrootKeyword               namespace_with_ipsets           
syn keyword keepalivedrootKeyword                       net_namespace           

syn region keepalivedstatic_ipaddressBlock start="\s*static_ipaddress\ze\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedstatic_ipaddressKeyword,keepalivedstatic_ipaddressDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock
syn keyword keepalivedstatic_ipaddressDefinition               static_ipaddress contained containedin=keepalivedstatic_ipaddressBlock

highlight link keepalivedstatic_ipaddressDefinition  Statement

syn region keepalivedstatic_routesBlock start="\s*static_routes\ze\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedstatic_routesKeyword,keepalivedstatic_routesDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock
syn keyword keepalivedstatic_routesDefinition                  static_routes contained containedin=keepalivedstatic_routesBlock

highlight link keepalivedstatic_routesDefinition  Statement
syn keyword keepalivedrootKeyword                        static_rules           

syn region keepalivedtrack_groupBlock start="\s*track_group\ze\s*\w*\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedtrack_groupKeyword,keepalivedtrack_groupDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock
syn keyword keepalivedtrack_groupDefinition                    track_group contained containedin=keepalivedtrack_groupBlock

" track_group
syn keyword keepalivedtrack_groupKeyword                               group  contained
highlight link keepalivedtrack_groupDefinition  Statement
highlight link keepalivedtrack_groupKeyword       Type

syn keyword keepalivedrootKeyword                         use_pid_dir           

syn region keepalivedvirtual_serverBlock start="\s*virtual_server\ze\s*[a-zA-Z0-9_.:]*\s*\w*\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedvirtual_serverKeyword,keepalivedvirtual_serverDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock
syn keyword keepalivedvirtual_serverDefinition                 virtual_server contained containedin=keepalivedvirtual_serverBlock

" virtual_server
syn keyword keepalivedvirtual_serverKeyword                               alpha  contained
syn keyword keepalivedvirtual_serverKeyword                  delay_before_retry  contained
syn keyword keepalivedvirtual_serverKeyword                          delay_loop  contained
syn keyword keepalivedvirtual_serverKeyword                              flag-1  contained
syn keyword keepalivedvirtual_serverKeyword                              flag-2  contained
syn keyword keepalivedvirtual_serverKeyword                              flag-3  contained
syn keyword keepalivedvirtual_serverKeyword                          ha_suspend  contained
syn keyword keepalivedvirtual_serverKeyword                              hashed  contained
syn keyword keepalivedvirtual_serverKeyword                          hysteresis  contained
syn keyword keepalivedvirtual_serverKeyword                  inhibit_on_failure  contained
syn keyword keepalivedvirtual_serverKeyword                           ip_family  contained
syn keyword keepalivedvirtual_serverKeyword                             lb_algo  contained
syn keyword keepalivedvirtual_serverKeyword                             lb_kind  contained
syn keyword keepalivedvirtual_serverKeyword                          lvs_method  contained
syn keyword keepalivedvirtual_serverKeyword                           lvs_sched  contained
syn keyword keepalivedvirtual_serverKeyword                               omega  contained
syn keyword keepalivedvirtual_serverKeyword                                 ops  contained
syn keyword keepalivedvirtual_serverKeyword                  persistence_engine  contained
syn keyword keepalivedvirtual_serverKeyword             persistence_granularity  contained
syn keyword keepalivedvirtual_serverKeyword                 persistence_timeout  contained
syn keyword keepalivedvirtual_serverKeyword                            protocol  contained
syn keyword keepalivedvirtual_serverKeyword                              quorum  contained
syn keyword keepalivedvirtual_serverKeyword                         quorum_down  contained
syn keyword keepalivedvirtual_serverKeyword                           quorum_up  contained

syn region keepalivedreal_serverBlock start="\s*real_server\ze\s*[a-zA-Z0-9_.:]*\s*\w*\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedreal_serverKeyword,keepalivedreal_serverDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock contained containedin=keepalivedvirtual_serverBlock
syn keyword keepalivedreal_serverDefinition                    real_server contained containedin=keepalivedreal_serverBlock

" real_server
syn keyword keepalivedreal_serverKeyword                               alpha  contained
syn keyword keepalivedreal_serverKeyword                  delay_before_retry  contained
syn keyword keepalivedreal_serverKeyword                          delay_loop  contained
syn keyword keepalivedreal_serverKeyword                  inhibit_on_failure  contained
syn keyword keepalivedreal_serverKeyword                          lthreshold  contained
syn keyword keepalivedreal_serverKeyword                          lvs_method  contained
syn keyword keepalivedreal_serverKeyword                         notify_down  contained
syn keyword keepalivedreal_serverKeyword                           notify_up  contained
syn keyword keepalivedreal_serverKeyword                               retry  contained
syn keyword keepalivedreal_serverKeyword                          smtp_alert  contained
syn keyword keepalivedreal_serverKeyword                          uthreshold  contained
syn keyword keepalivedreal_serverKeyword                         virtualhost  contained
syn keyword keepalivedreal_serverKeyword                              warmup  contained
syn keyword keepalivedreal_serverKeyword                              weight  contained
highlight link keepalivedreal_serverDefinition  Statement
highlight link keepalivedreal_serverKeyword       Type

syn keyword keepalivedvirtual_serverKeyword                               retry  contained
syn keyword keepalivedvirtual_serverKeyword                         sh-fallback  contained
syn keyword keepalivedvirtual_serverKeyword                             sh-port  contained
syn keyword keepalivedvirtual_serverKeyword                          smtp_alert  contained
syn keyword keepalivedvirtual_serverKeyword                        sorry_server  contained
syn keyword keepalivedvirtual_serverKeyword                sorry_server_inhibit  contained
syn keyword keepalivedvirtual_serverKeyword             sorry_server_lvs_method  contained
syn keyword keepalivedvirtual_serverKeyword                         virtualhost  contained
syn keyword keepalivedvirtual_serverKeyword                              warmup  contained
syn keyword keepalivedvirtual_serverKeyword                              weight  contained
highlight link keepalivedvirtual_serverDefinition  Statement
highlight link keepalivedvirtual_serverKeyword       Type

syn keyword keepalivedrootKeyword                virtual_server_group           

syn region keepalivedvrrp_instanceBlock start="\s*vrrp_instance\ze\s*\w*\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedvrrp_instanceKeyword,keepalivedvrrp_instanceDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock
syn keyword keepalivedvrrp_instanceDefinition                  vrrp_instance contained containedin=keepalivedvrrp_instanceBlock

" vrrp_instance
syn keyword keepalivedvrrp_instanceKeyword                              accept  contained
syn keyword keepalivedvrrp_instanceKeyword                          advert_int  contained

syn region keepalivedauthenticationBlock start="\s*authentication\ze\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedauthenticationKeyword,keepalivedauthenticationDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock contained containedin=keepalivedvrrp_instanceBlock
syn keyword keepalivedauthenticationDefinition                 authentication contained containedin=keepalivedauthenticationBlock

" authentication
syn keyword keepalivedauthenticationKeyword                           auth_pass  contained
syn keyword keepalivedauthenticationKeyword                           auth_type  contained
highlight link keepalivedauthenticationDefinition  Statement
highlight link keepalivedauthenticationKeyword       Type

syn keyword keepalivedvrrp_instanceKeyword                               debug  contained
syn keyword keepalivedvrrp_instanceKeyword                  dont_track_primary  contained
syn keyword keepalivedvrrp_instanceKeyword               garp_lower_prio_delay  contained
syn keyword keepalivedvrrp_instanceKeyword              garp_lower_prio_repeat  contained
syn keyword keepalivedvrrp_instanceKeyword                   garp_master_delay  contained
syn keyword keepalivedvrrp_instanceKeyword                 garp_master_refresh  contained
syn keyword keepalivedvrrp_instanceKeyword          garp_master_refresh_repeat  contained
syn keyword keepalivedvrrp_instanceKeyword                  garp_master_repeat  contained
syn keyword keepalivedvrrp_instanceKeyword             higher_prio_send_advert  contained
syn keyword keepalivedvrrp_instanceKeyword                           interface  contained
syn keyword keepalivedvrrp_instanceKeyword                  kernel_rx_buf_size  contained
syn keyword keepalivedvrrp_instanceKeyword                linkbeat_use_polling  contained
syn keyword keepalivedvrrp_instanceKeyword                lower_prio_no_advert  contained
syn keyword keepalivedvrrp_instanceKeyword           lvs_sync_daemon_interface  contained
syn keyword keepalivedvrrp_instanceKeyword                        mcast_src_ip  contained
syn keyword keepalivedvrrp_instanceKeyword                         native_ipv6  contained
syn keyword keepalivedvrrp_instanceKeyword                           no_accept  contained
syn keyword keepalivedvrrp_instanceKeyword                           nopreempt  contained
syn keyword keepalivedvrrp_instanceKeyword                              notify  contained
syn keyword keepalivedvrrp_instanceKeyword                       notify_backup  contained
syn keyword keepalivedvrrp_instanceKeyword                        notify_fault  contained
syn keyword keepalivedvrrp_instanceKeyword                       notify_master  contained
syn keyword keepalivedvrrp_instanceKeyword          notify_master_rx_lower_pri  contained
syn keyword keepalivedvrrp_instanceKeyword                         notify_stop  contained
syn keyword keepalivedvrrp_instanceKeyword                old_unicast_checksum  contained
syn keyword keepalivedvrrp_instanceKeyword                             preempt  contained
syn keyword keepalivedvrrp_instanceKeyword                       preempt_delay  contained
syn keyword keepalivedvrrp_instanceKeyword                            priority  contained
syn keyword keepalivedvrrp_instanceKeyword                 promote_secondaries  contained
syn keyword keepalivedvrrp_instanceKeyword                 skip_check_adv_addr  contained
syn keyword keepalivedvrrp_instanceKeyword                          smtp_alert  contained
syn keyword keepalivedvrrp_instanceKeyword                               state  contained
syn keyword keepalivedvrrp_instanceKeyword                         strict_mode  contained
syn keyword keepalivedvrrp_instanceKeyword                           track_bfd  contained
syn keyword keepalivedvrrp_instanceKeyword                          track_file  contained
syn keyword keepalivedvrrp_instanceKeyword                     track_interface  contained
syn keyword keepalivedvrrp_instanceKeyword                        track_script  contained
syn keyword keepalivedvrrp_instanceKeyword                        track_src_ip  contained
syn keyword keepalivedvrrp_instanceKeyword                        unicast_peer  contained
syn keyword keepalivedvrrp_instanceKeyword                      unicast_src_ip  contained
syn keyword keepalivedvrrp_instanceKeyword                            use_vmac  contained
syn keyword keepalivedvrrp_instanceKeyword                             version  contained
syn keyword keepalivedvrrp_instanceKeyword                   virtual_ipaddress  contained
syn keyword keepalivedvrrp_instanceKeyword          virtual_ipaddress_excluded  contained
syn keyword keepalivedvrrp_instanceKeyword                   virtual_router_id  contained
syn keyword keepalivedvrrp_instanceKeyword                      virtual_routes  contained
syn keyword keepalivedvrrp_instanceKeyword                       virtual_rules  contained
syn keyword keepalivedvrrp_instanceKeyword                      vmac_xmit_base  contained
highlight link keepalivedvrrp_instanceDefinition  Statement
highlight link keepalivedvrrp_instanceKeyword       Type


syn region keepalivedvrrp_scriptBlock start="\s*vrrp_script\ze\s*\w*\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedvrrp_scriptKeyword,keepalivedvrrp_scriptDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock
syn keyword keepalivedvrrp_scriptDefinition                    vrrp_script contained containedin=keepalivedvrrp_scriptBlock

" vrrp_script
syn keyword keepalivedvrrp_scriptKeyword                                fall  contained
syn keyword keepalivedvrrp_scriptKeyword                           init_fail  contained
syn keyword keepalivedvrrp_scriptKeyword                            interval  contained
syn keyword keepalivedvrrp_scriptKeyword                                rise  contained
syn keyword keepalivedvrrp_scriptKeyword                              script  contained
syn keyword keepalivedvrrp_scriptKeyword                             timeout  contained
syn keyword keepalivedvrrp_scriptKeyword                                user  contained
syn keyword keepalivedvrrp_scriptKeyword                              weight  contained
highlight link keepalivedvrrp_scriptDefinition  Statement
highlight link keepalivedvrrp_scriptKeyword       Type


syn region keepalivedvrrp_sync_groupBlock start="\s*vrrp_sync_group\ze\s*\w*\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedvrrp_sync_groupKeyword,keepalivedvrrp_sync_groupDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock
syn keyword keepalivedvrrp_sync_groupDefinition                vrrp_sync_group contained containedin=keepalivedvrrp_sync_groupBlock

" vrrp_sync_group
syn keyword keepalivedvrrp_sync_groupKeyword                     global_tracking  contained
syn keyword keepalivedvrrp_sync_groupKeyword                               group  contained
syn keyword keepalivedvrrp_sync_groupKeyword                              notify  contained
syn keyword keepalivedvrrp_sync_groupKeyword                       notify_backup  contained
syn keyword keepalivedvrrp_sync_groupKeyword                        notify_fault  contained
syn keyword keepalivedvrrp_sync_groupKeyword                       notify_master  contained
syn keyword keepalivedvrrp_sync_groupKeyword                         notify_stop  contained
syn keyword keepalivedvrrp_sync_groupKeyword                          smtp_alert  contained
syn keyword keepalivedvrrp_sync_groupKeyword          sync_group_tracking_weight  contained
syn keyword keepalivedvrrp_sync_groupKeyword                           track_bfd  contained
syn keyword keepalivedvrrp_sync_groupKeyword                          track_file  contained
syn keyword keepalivedvrrp_sync_groupKeyword                     track_interface  contained
syn keyword keepalivedvrrp_sync_groupKeyword                        track_script  contained
highlight link keepalivedvrrp_sync_groupDefinition  Statement
highlight link keepalivedvrrp_sync_groupKeyword       Type


syn region keepalivedvrrp_track_fileBlock start="\s*vrrp_track_file\ze\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedvrrp_track_fileKeyword,keepalivedvrrp_track_fileDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock
syn keyword keepalivedvrrp_track_fileDefinition                vrrp_track_file contained containedin=keepalivedvrrp_track_fileBlock

" vrrp_track_file
syn keyword keepalivedvrrp_track_fileKeyword                                file  contained
syn keyword keepalivedvrrp_track_fileKeyword                           init_file  contained
syn keyword keepalivedvrrp_track_fileKeyword                              weight  contained
highlight link keepalivedvrrp_track_fileDefinition  Statement
highlight link keepalivedvrrp_track_fileKeyword       Type

highlight link keepalivedrootKeyword  Statement


syn region keepalivedMISC_CHECKBlock start="\s*MISC_CHECK\ze\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedMISC_CHECKKeyword,keepalivedMISC_CHECKDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock,keepalivedCommonCheckerKeyword contained containedin=keepalivedreal_serverBlock
syn keyword keepalivedMISC_CHECKDefinition                     MISC_CHECK contained containedin=keepalivedMISC_CHECKBlock

" MISC_CHECK
syn keyword keepalivedMISC_CHECKKeyword                        misc_dynamic  contained
syn keyword keepalivedMISC_CHECKKeyword                           misc_path  contained
syn keyword keepalivedMISC_CHECKKeyword                        misc_timeout  contained
syn keyword keepalivedMISC_CHECKKeyword                                user  contained
highlight link keepalivedMISC_CHECKDefinition Identifier
highlight link keepalivedMISC_CHECKKeyword Identifier



syn region keepalivedSMTP_CHECKBlock start="\s*SMTP_CHECK\ze\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedSMTP_CHECKKeyword,keepalivedSMTP_CHECKDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock,keepalivedCommonCheckerKeyword contained containedin=keepalivedreal_serverBlock
syn keyword keepalivedSMTP_CHECKDefinition                     SMTP_CHECK contained containedin=keepalivedSMTP_CHECKBlock

" SMTP_CHECK
syn keyword keepalivedSMTP_CHECKKeyword                           helo_name  contained

syn region keepalivedhostBlock start="\s*host\ze\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedhostKeyword,keepalivedhostDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock,keepalivedCommonCheckerKeyword contained containedin=keepalivedSMTP_CHECKBlock
syn keyword keepalivedhostDefinition                           host contained containedin=keepalivedhostBlock

" host
highlight link keepalivedhostDefinition Identifier
highlight link keepalivedhostKeyword Identifier

highlight link keepalivedSMTP_CHECKDefinition Identifier
highlight link keepalivedSMTP_CHECKKeyword Identifier



syn region keepalivedTCP_CHECKBlock start="\s*TCP_CHECK\ze\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedTCP_CHECKKeyword,keepalivedTCP_CHECKDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock,keepalivedCommonCheckerKeyword contained containedin=keepalivedreal_serverBlock
syn keyword keepalivedTCP_CHECKDefinition                      TCP_CHECK contained containedin=keepalivedTCP_CHECKBlock

" TCP_CHECK
highlight link keepalivedTCP_CHECKDefinition Identifier
highlight link keepalivedTCP_CHECKKeyword Identifier



syn region keepalivedHTTP_GETBlock start="\s*HTTP_GET\|SSL_GET\ze\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedHTTP_GETKeyword,keepalivedHTTP_GETDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock,keepalivedCommonCheckerKeyword contained containedin=keepalivedreal_serverBlock
syn keyword keepalivedHTTP_GETDefinition               HTTP_GET SSL_GET contained containedin=keepalivedHTTP_GETBlock

" HTTP_GET
syn keyword keepalivedHTTP_GETKeyword                          enable_sni  contained
syn keyword keepalivedHTTP_GETKeyword                        nb_get_retry  contained

syn region keepalivedurlBlock start="\s*url\ze\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedurlKeyword,keepalivedurlDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock contained containedin=keepalivedHTTP_GETBlock
syn keyword keepalivedurlDefinition                            url contained containedin=keepalivedurlBlock

" url
syn keyword keepalivedurlKeyword                              digest  contained
syn keyword keepalivedurlKeyword                                path  contained
syn keyword keepalivedurlKeyword                         status_code  contained
syn keyword keepalivedurlKeyword                         virtualhost  contained
highlight link keepalivedurlDefinition Identifier
highlight link keepalivedurlKeyword Identifier

syn keyword keepalivedHTTP_GETKeyword                         virtualhost  contained
highlight link keepalivedHTTP_GETDefinition Identifier
highlight link keepalivedHTTP_GETKeyword Identifier




syn region keepalivedDNS_CHECKBlock start="\s*DNS_CHECK\ze\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedDNS_CHECKKeyword,keepalivedDNS_CHECKDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock,keepalivedCommonCheckerKeyword contained containedin=keepalivedreal_serverBlock
syn keyword keepalivedDNS_CHECKDefinition                      DNS_CHECK contained containedin=keepalivedDNS_CHECKBlock

" DNS_CHECK
syn keyword keepalivedDNS_CHECKKeyword                                name  contained
syn keyword keepalivedDNS_CHECKKeyword                                type  contained
highlight link keepalivedDNS_CHECKDefinition Identifier
highlight link keepalivedDNS_CHECKKeyword Identifier



syn region keepalivedBFD_CHECKBlock start="\s*BFD_CHECK\ze\s*{" matchgroup=keepalivedDelimiter end="\zs}" contains=keepalivedDelimiter,keepalivedBFD_CHECKKeyword,keepalivedBFD_CHECKDefinition,keepalivedOperator,keepalivedComment,keepalivedNumber,keepalivedString,keepalivedBoolean,ipaddress,ipaddr_cidr,keepalivedGenericBlock contained containedin=keepalivedreal_serverBlock
syn keyword keepalivedBFD_CHECKDefinition                      BFD_CHECK contained containedin=keepalivedBFD_CHECKBlock

" BFD_CHECK
syn keyword keepalivedBFD_CHECKKeyword                               alpha  contained
syn keyword keepalivedBFD_CHECKKeyword                                name  contained
highlight link keepalivedBFD_CHECKDefinition Identifier
highlight link keepalivedBFD_CHECKKeyword Identifier


syn keyword keepalivedCommonCheckerKeyword                          alpha  contained
syn keyword keepalivedCommonCheckerKeyword                        bind_if  contained
syn keyword keepalivedCommonCheckerKeyword                      bind_port  contained
syn keyword keepalivedCommonCheckerKeyword                         bindto  contained
syn keyword keepalivedCommonCheckerKeyword                     connect_ip  contained
syn keyword keepalivedCommonCheckerKeyword                   connect_port  contained
syn keyword keepalivedCommonCheckerKeyword                connect_timeout  contained
syn keyword keepalivedCommonCheckerKeyword             delay_before_retry  contained
syn keyword keepalivedCommonCheckerKeyword                     delay_loop  contained
syn keyword keepalivedCommonCheckerKeyword                         fwmark  contained
syn keyword keepalivedCommonCheckerKeyword                          retry  contained
syn keyword keepalivedCommonCheckerKeyword                         warmup  contained
highlight link keepalivedCommonCheckerKeyword Identifier

syn region keepalivedGenericBlock matchgroup=keepalivedDelimiter start="\(^\s*\(SSL\|garp_group\|global_defs\|static_ipaddress\|static_routes\|track_group\|virtual_server\|real_server\|vrrp_instance\|authentication\|vrrp_script\|vrrp_sync_group\|vrrp_track_file\|MISC_CHECK\|SMTP_CHECK\|host\|TCP_CHECK\|HTTP_GET\|SSL_GET\|url\|DNS_CHECK\|BFD_CHECK\)\(\s\+[a-zA-Z0-9_.:]\+\)\?\(\s\+\w\+\)\?\s*\)\@<!{" end="}" transparent


" highlight
hi link keepalivedDelimiter           Delimiter
hi link keepalivedOperator            Operator
hi link keepalivedComment             Comment
hi link keepalivedNumber              Number
hi link keepalivedString              String
hi link keepalivedBoolean             Boolean
hi link keepalivedLvsSched            Constant
hi link keepalivedStatus              Constant
hi link keepalivedProto               Constant
hi link keepalivedMethod              Constant

let b:current_syntax = "keepalived"
