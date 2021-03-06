{% from "mercurial/map.jinja" import mercurial with context %}

{% if mercurial.setup_repo %}
include:
  - .repo
{% endif %}

mercurial:
  pkg.installed:
    - name: mercurial
    - require:
      - pkgrepo: mercurial

  file.managed:
    - name: /etc/mercurial/hgrc.d/extensions.rc
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: mercurial
    - contents: |
        [extensions]
{%- for extension in mercurial.get('extensions', []) %}
        {{ extension }} =
{%- endfor %}
