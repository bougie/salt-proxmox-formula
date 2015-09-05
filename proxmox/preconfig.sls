{% from "proxmox/default.yml" import rawmap with context %}
{% set rawmap = salt['pillar.get']('proxmox', rawmap, merge=True) %}

hosts_prefile:
    file.managed:
        - name: /etc/hosts
        - source: salt://proxmox/files/hosts.j2
        - template: jinja
