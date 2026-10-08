# Horario semanal

Creado 2026-10-08. Ancla principal: **cerrar los ojos a las 23:15**.

## Semana

| Lunes | Martes | Miércoles | Jueves | Viernes |
|---|---|---|---|---|
| Gym | Bici | Gym | Bici | Gym |

## Día de gym

| Hora | Qué |
|---|---|
| 7:15 | Levantarse |
| 7:15–7:45 | Desayuno |
| 7:45–9:45 | Salgo al gym → entreno → llego a la oficina (2 h) |
| 9:45–18:15 | Trabajo (8,5 h, comida incluida) |
| 23:15 | Ojos cerrados — 8 h de sueño |

## Día de bici

| Hora | Qué |
|---|---|
| 6:40 | Levantarse |
| 6:40–7:00 | Desayuno |
| 7:00–9:00 | Bici (2 h) |
| 9:00–9:30 | Ducha |
| 9:30–9:40 | Trayecto a la oficina (10 min) |
| 9:40–18:10 | Trabajo (8,5 h, comida incluida) |
| 23:15 | Ojos cerrados (8 h hasta el día de gym siguiente) |

La noche antes de bici (lunes y miércoles): **ojos cerrados a las 22:45**, ~8 h de sueño.

## Reglas

- La hora de dormir manda: si falla, falla todo lo demás.
- Si hay un imprevisto, se mueve, no se salta. Una sesión más corta cuenta.

## Avisos (pendiente de configurar desde Mother con `/schedule`)

Zona horaria: Europe/Madrid.

**Antes de dormir** — 30 min antes de cerrar los ojos, diciendo qué toca mañana por la mañana:

| Noche | Aviso | Ojos cerrados | Mañana |
|---|---|---|---|
| Domingo | 22:45 | 23:15 | Gym — levantarse 7:15, salir 7:45 |
| Lunes | 22:15 | 22:45 | Bici — levantarse 6:40, bici 7:00 |
| Martes | 22:45 | 23:15 | Gym — levantarse 7:15, salir 7:45 |
| Miércoles | 22:15 | 22:45 | Bici — levantarse 6:40, bici 7:00 |
| Jueves | 22:45 | 23:15 | Gym — levantarse 7:15, salir 7:45 |

Viernes y sábado: sin aviso.

**Salir de la oficina** — no es fijo. Cada día Vicente confirma su hora de entrada al decir "buenos días";
entonces se programa un aviso único a entrada + 8,5 h (comida incluida).

## Sincronía

Copia maestra: `~/.cuore/horario.md`. Copia en Mother: `~/Mother/docs/horario.md` (idéntica).
Se comprueba al iniciar sesión en (dot)cuore (`.claude/hooks/horario-sync.sh`); Mother no puede leer (dot)cuore.
