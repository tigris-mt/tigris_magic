# Jewelry
* Adds jewelry action `mana = {[max = <x>], [regen = <x>]}` to modify mana player attributes.

# Mana
* `tigris.magic.mana(player, set, relative)`: If `<set>` is nil, will return current player mana. Otherwise will set current player mana to `<set>`. If `<relative>` is true, will add current player mana to set value.

## Player Monoids
* `tigris.magic.mana_max_monoid`
* `tigris.magic.mana_regen_monoid`

# Emblems
* `attack`
* `defense`
* `action`

# Potions
* `tigris.magic.register_potion(name, def)`: Register potion `<name>` with `<def>`.
  * `color`: Color to colorize the base image. (Example: `#1AF`).
  * `description`: Potion description.
  * `on_use(itemstack, player, pointed_thing` [nil]: Called upon use of the potion. If true returned, will drink and remove potion from inventory.
  * `strong` [false]: If true, will use the steel bottle image instead of glass.
  * `emblem` [nil]: Specify a magic emblem to overlay on the image.
  * `overlay` [nil]: Specify an arbitrary image to overlay on the image.

# Spells
* `tigris.magic.register_spell(name, def)`: Register spell.
  * `description`: Spell description.
  * `cost`: Cost table `{mana = <n>, hp = <n>, breath = <bool>}` (all keys optional).
  * `emblem`: Magic emblem overlay.
  * `color`: Base image colorization.
  * `on_use(itemstack, player, pointed_thing)` [nil]: Called upon use of the spell. If true returned, will remove used spell from inventory.
  * `overlay` [nil]: Specify an arbitrary image to overlay on the image.
  * `groups` [{spell = 1}]: Custom item groups.
  * `do_cost(player, cost)` [nil]: Optional function to apply custom cost handling. `<cost>` is `def.cost`.
