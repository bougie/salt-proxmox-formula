{% from "proxmox/default.yml" import rawmap with context %}
{% set rawmap = salt['pillar.get']('proxmox', rawmap, merge=True) %}

{% if rawmap.networks is defined %}
interfaces_file:
    file.managed:
        - name: /etc/network/interfaces
        - source: salt://proxmox/files/interfaces.j2
        - template: jinja
        - context:
            networks: {{rawmap.networks}}
{% endif %}

hosts_file:
    file.managed:
        - name: /etc/hosts
        - source: salt://proxmox/files/hosts.j2
        - template: jinja
{% if rawmap.networks is defined %}
        - context:
            networks: {{rawmap.networks}}
{% endif %}
