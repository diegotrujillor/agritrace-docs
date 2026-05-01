# Recommended Repository Structure - AgriTrace Docs

## Overview
This document defines the organized structure for the AgriTrace documentation repository. All files are organized by phase and reading order, named in English, with numerical prefixes to indicate sequence.

## Root Level Structure

```
agritrace-docs/
├── README.md                          (Main index)
├── estructura_recomendada.md          (This file)
├── phase-1-mvp/                       (Phase 1: MVP Preparation)
├── phase-2-development/               (Phase 2: Development - future)
├── technical-docs/                    (Technical Documentation)
├── assets/                            (Shared assets and images)
└── archive/                           (Historical or archive documents)
```

## Phase 1: MVP Preparation (`phase-1-mvp/`)

This phase covers analysis, design, architecture, infrastructure, and project management for the MVP.

```
phase-1-mvp/
├── README.md
├── 01-survey/
│   ├── README.md
│   └── 01-stakeholder-survey.md
├── 02-requirements/
│   ├── README.md
│   ├── 01-functional-requirements.md
│   └── 02-non-functional-requirements.md
├── 03-functional-mapping/
│   ├── README.md
│   └── 01-functional-map.md
├── 04-ui-ux-design/
│   ├── README.md
│   ├── 01-ui-ux-guidelines.md
│   ├── 02-screen-specifications/
│   │   ├── README.md
│   │   └── 01-screen-specs.md
│   ├── 03-user-journeys/
│   │   ├── README.md
│   │   └── 01-user-journey-maps.md
│   ├── 04-platform-design/
│   │   ├── README.md
│   │   └── 01-platform-design.md
│   └── 05-interactive-prototype/
│       ├── README.md
│       └── 01-prototype-guide.md
├── 05-technical-architecture/
│   ├── README.md
│   ├── 01-architecture-overview.md
│   ├── 02-database-design.md
│   ├── 03-data-flow.md
│   └── 04-technology-stack.md
├── 06-infrastructure/
│   ├── README.md
│   ├── 01-infrastructure-setup.md
│   ├── 02-dns-domain-setup.md
│   ├── 03-docker-configuration.md
│   ├── 04-database-setup.md
│   └── 05-backup-monitoring.md
├── 07-project-management/
│   ├── README.md
│   ├── 01-project-roadmap.md
│   ├── 02-product-backlog.md
│   ├── 03-kpi-dashboard.md
│   └── 04-schedule-timeline.md
└── 99-budget-investment/
    ├── README.md
    └── 01-budget-control.md
```

## Technical Documentation (`technical-docs/`)

In-depth technical specifications and implementation guides.

```
technical-docs/
├── README.md
├── 01-analysis/
│   ├── README.md
│   └── 01-complete-analysis.md
├── 02-database/
│   ├── README.md
│   ├── 01-database-design.md
│   └── 02-data-models.md
├── 03-api/
│   ├── README.md
│   ├── 01-openapi-specification.yaml
│   └── 02-api-guidelines.md
├── 04-development/
│   ├── README.md
│   └── 01-development-guidelines.md
├── 05-documentation/
│   ├── README.md
│   └── 01-documentation-guide.md
└── 06-deployment/
    ├── README.md
    └── 01-deployment-guide.md
```

## Assets (`assets/`)

Shared images, diagrams, and other resources used across documentation.

```
assets/
├── images/
├── diagrams/
├── icons/
└── brand-guidelines/
```

## File Naming Conventions

1. **Folder names**: Use kebab-case (lowercase with hyphens)
   - Good: `ui-ux-design`, `functional-mapping`
   - Bad: `UIUX Design`, `functional_mapping`

2. **File names**: Use kebab-case with numeric prefixes
   - Good: `01-stakeholder-survey.md`, `02-functional-requirements.md`
   - Bad: `StakeholderSurvey.md`, `Functional Requirements.md`

3. **Section headers**: Use clear, descriptive English names
   - Good: "Functional Requirements", "User Journey Maps"

4. **No emojis in filenames** (for CLI compatibility)
   - Emojis can be used in document headers

## Reading Order - Phase 1 MVP

Follow this sequence for understanding AgriTrace Phase 1:

1. Phase 1 MVP Overview (main README)
2. 01-survey: Stakeholder feedback and initial survey
3. 02-requirements: Functional and non-functional requirements
4. 03-functional-mapping: System functionality and user flows
5. 04-ui-ux-design: User interface and experience design
6. 05-technical-architecture: System architecture and design
7. 06-infrastructure: Infrastructure setup requirements
8. 07-project-management: Roadmap and timeline
9. 99-budget-investment: Investment tracking and budget control

## Migration Notes

This structure was reorganized from the previous flat structure that used Unicode emoji prefixes and Spanish filenames. All content has been preserved and translated to English for better CLI compatibility and international collaboration.
