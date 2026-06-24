<!--
This template is filled in by the contributor opening the PR.
The CI workflow will run ERC + DRC + KiRi regardless of which boxes are
checked. The checkboxes are here to remind reviewers what to look at.
-->

## What changed

- [ ] Schematic change
- [ ] PCB layout change
- [ ] Library change (symbols or footprints)
- [ ] Documentation / fab notes only
- [ ] No KiCad file changed (CI will skip this PR)

## Review focus

- [ ] New nets or components (please trace)
- [ ] Footprint swaps (please verify the new footprint)
- [ ] Layer-stack or stack-up change
- [ ] Power section change
- [ ] High-speed signal change (please simulate)
- [ ] Mechanical change (board edge, mounting holes, keepouts)

## CI status

- [ ] I have read the `kicad-pr-review` comment on this PR
- [ ] I have downloaded and reviewed the schematic PDF
- [ ] I have downloaded and reviewed the PCB PDF
- [ ] I have downloaded and reviewed the KiRi visual diff
- [ ] I have downloaded and reviewed the KiCanvas archive (browser)

## Risk and rollback

- What is the impact of merging this?
- How do we roll back if it fails in fab?

/label ~"kicad" ~"needs-review"