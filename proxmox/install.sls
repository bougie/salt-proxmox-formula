{% from "proxmox/default.yml" import rawmap with context %}
{% set rawmap = salt['pillar.get']('proxmox', rawmap, merge=True) %}

{% if rawmap.preconfigure is defined and rawmap.preconfigure %}
include:
    - proxmox.preconfig
{% endif %}

proxmox_repo:
    pkgrepo.managed:
        - humanname: Proxmox VE Repository
        - name: deb http://download.proxmox.com/debian {{salt['grains.get']('oscodename')}} pve
        - dist: {{salt['grains.get']('oscodename')}}
        - file: /etc/apt/sources.list.d/pve-install-repo.list
        - key_url: http://download.proxmox.com/debian/key.asc
        - refresh_db: True

{% for pkg in ['pve-firmware', 'pve-kernel-2.6.32-26-pve', 'pve-headers-2.6.32-26-pve', 'proxmox-ve-2.6.32', 'ntp', 'ssh', 'lvm2', 'postfix', 'ksm-control-daemon', 'open-iscsi', 'vzprocps', 'bootlogd'] %}
{{pkg ~ '_installed'}}:
    pkg.installed:
        - name: {{pkg}}
{% endfor %}

