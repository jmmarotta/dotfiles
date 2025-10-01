## Your Task

Develop and plan a comprehensive project documentation strategy for your AI-first codebase. These documents will serve as a guide for building out the project. They should be thorough, and include all important considerations. The main purpose of this is to ask several questions.

Throughout the entire process, ask clarifying questions if needed -- we don't want any embellishments or assumptions.

### Below is a recommended order for creating these documents so each naturally builds upon the previous. This sequence ensures we first set the project context (overview, user flow, tech decisions), then define our rules (tech stack, UI, theme, code organization), and finally outline our phased approach and detailed workflows.

These files should be created in the `_docs/` folder.

1. `project-overview.md`

  - Establish overall project purpose, scope, and goals.
  - Create this by asking the user comprehenisive questions about the project.

2. `user-flow.md`

  - Clarify how users will interact with the application.
  - Use `project-overview.md` to create this document.
  - The user journey should take into account the different features the app has & how they are connected to one-another. This document will later serve as a guide for building out our project architecture and UI elements.

3. `architecture.md`

  - Describe the core technologies used and their roles.
  - Use `project-overview.md` and `user-flow.md` to make recommendations and ask if the user has any preferences.
  - After creating the initial version, update `tech-stack.md` to cover all best-practices, limitations, and conventions for using the selected technologies. It should be thorough, and include important considerations and common pitfalls for each one.

4. `ui-rules.md`

  - Define visual and interaction guidelines (including design principles and behaviors).
  - Walk me through some common design principles for this type of application where applicable, and recommend some possible styles that fit what we're building.
    - Observe `project-overview.md` and `user-flow.md` for context about the project to guide your recommendations.

6. `project-rules.md`

  - Outline folder structure, file naming conventions, etc.
  - We are building an AI-first codebase, which means it needs to be modular, scalable, and easy to understand.
    - The file structure should be highly navigable, and the code should be well-organized and easy to read.
    - All files should have descriptive names, an explanation of their contents at the top, and all functions should have proper commentation of their purpose and parameters.
    - To maximize compatibility with modern AI tools, files should not exceed 500 lines.
    - Use `architecture.md`, `user-flow.md`, `project-overview.md`, and `ui-rules.md` to put together a new file called `project-rules.md`, which touches on our project's directory structure, file naming conventions, and any other rules we need to follow.

7. `./phases/` (subdirectory within `_docs/`)

  - Outline the different phases of the project, and the different tasks and features we'll need to complete in order to complete our goal. Each feature (or group of features) should have its own phase document.
  - We need to define the tasks and features to build our project, progressing from a barebones setup to a minimal viable product (MVP), to a feature-rich polished version.
    - Create an iterative development plan for the project, outlining the tasks and features needed to reach these phases.
      - Rules to follow:
        - Start with a 'setup' phase: a barebones setup that functions at a basic level but isn’t fully usable (e.g., a minimal running framework or structure).
        - Define an 'MVP' phase: a minimal, usable version with core features integrated (e.g., essential functionality that delivers the project’s primary value).
        - Add additional phases as needed: enhancements to improve and expand the MVP (e.g., advanced features, polish, or scalability).
        - Each phase gets one document, detailing its scope and deliverables.
        - Focus each phase on delivering a functional product, combining essential features into a cohesive whole (e.g., key components that work together).
        - List features with actionable steps (max 5 steps per feature; break down into smaller features if longer).
        - Keep phases iterative—each builds on the previous phase, enhancing a working product.
      - Place these documents in `_docs/phases/`. Review `project-overview.md`, `user-flow.md`, arhcitechture.md`, `ui-rules.md`, and `project-rules.md` to see how we can use them to create our phases.

