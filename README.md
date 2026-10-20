# Inspector de coches de segunda mano (CLIPS)

**ES** · [EN](#english)

Sistema basado en conocimiento que guía a un comprador inexperto durante la inspección de un coche de segunda mano. Trabajo final de la asignatura **Sistemas Basados en Conocimiento** (UCLM, curso 2025/2026).

## Qué incluye

- `inspector-coches.clp`: sistema experto con **27 reglas** en CLIPS. La inspección avanza por fases: fluidos, carrocería, dinámica y diagnóstico.
- `fuzzy-inspector.clp`: módulo de **inferencia borrosa tipo Mamdani** en FuzzyCLIPS, con 3 variables difusas (`gravedad-averia`, `num-averias`, `descuento-precio`) y 7 reglas.
- `informe.pdf`: memoria con el ciclo completo de ingeniería del conocimiento: viabilidad (test de Slagel), adquisición, conceptualización, representación y evaluación.
- `presentacion.pptx`: presentación del trabajo.

## Uso

Con CLIPS instalado, abre el intérprete y ejecuta:

```
(load "inspector-coches.clp")
(reset)
(run)
```

El módulo borroso requiere **FuzzyCLIPS**.

## Créditos

Autor: **Marcos Galán Rodríguez**.

---

## English

Knowledge-based system that guides an inexperienced buyer through the inspection of a used car. Final project for the course **Knowledge-Based Systems** (UCLM, 2025/2026).

### Features

- `inspector-coches.clp`: expert system with **27 CLIPS rules**. The inspection runs in phases: fluids, bodywork, driving test and diagnosis.
- `fuzzy-inspector.clp`: **Mamdani-style fuzzy inference** module in FuzzyCLIPS with 3 fuzzy variables and 7 rules.
- `informe.pdf`: report covering the full knowledge-engineering cycle (feasibility with the Slagel test, acquisition, conceptualisation, representation and evaluation), written in Spanish.
- `presentacion.pptx`: project presentation.

### Usage

With CLIPS installed, open the interpreter and run:

```
(load "inspector-coches.clp")
(reset)
(run)
```

The fuzzy module requires **FuzzyCLIPS**.

### Credits

Author: **Marcos Galán Rodríguez**.
