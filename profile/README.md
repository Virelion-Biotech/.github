# Virelion Biotech

> **Engineering the Heart.**

Virelion Biotech is an early-stage biotechnology venture focused on the intersection of clinical cardiology and translational regenerative medicine. Its stated goal is to engineer biological solutions for complex cardiac conditions by combining cardiac mapping, computational modeling, gene-therapy vectors, and engineered cardiomyocyte platforms.

The company describes its development philosophy as **clinical-question first**: start with what is failing in a diseased heart—conduction, contraction, or structure—then select the biological and computational tools best suited to restore function.

**Website:** https://virelionbiotech.netlify.app/  
**Contact:** virelion85@gmail.com  
**Parent structure:** Biotechnology venture under Hannan Enterprises Holdings  
**Founded:** 2024  
**Founder:** Syed Umer Hannan

---

## Company at a glance

| Area | Publicly described position |
|---|---|
| Mission | Engineer biological solutions for complex cardiac conditions |
| Core domain | Cardiac regenerative medicine and translational electrophysiology |
| Development model | Clinical characterization → computational triage → biological validation |
| Core modalities | Gene therapy vectors, engineered cardiomyocyte grafts, cardiac mapping, computational modeling |
| Current programs | N/A |
| Program stage | All three publicly disclosed programs are in discovery |
| Publications | None publicly listed yet |
| Clinical data | None publicly reported yet |
| Advisory board | No formal advisory board publicly listed |
| Team | Deliberately lean founding team led by Syed Umer Hannan |
| Capital/structure | Independently capitalized; venture operates under Hannan Enterprises Holdings |
| Open-source work | Lab utilities, research-intelligence tooling, cardiotoxicity scoring, and biosafety planning tools |

---

## What Virelion is building

Virelion positions itself as a biology-first cardiac technology company rather than a single-product therapeutics business. Its public platform is organized around four complementary pillars.

### 1. Biological pacemakers

Virelion is developing targeted gene-therapy and cellular pacing approaches intended to restore rhythm-generating function natively rather than relying exclusively on implanted electronic hardware.

The stated objective is to mitigate limitations associated with traditional pacing by creating a biological mechanism for cardiac rhythm restoration.

### 2. Engineered cardiomyocyte grafts

The company describes a stem-cell-derived platform for engineering specialized cardiomyocytes for cardiac repair.

The emphasis is not only on generating replacement cells, but on achieving:

- Structural integration with the host myocardium
- Electrical coupling with native tissue
- Synchronous contraction rather than mechanically or electrically discordant graft behavior

### 3. High-resolution cardiac mapping

Clinical cardiology is used to characterize the anatomical and functional deficit before therapeutic intervention.

Virelion describes mapping as a way to identify **where** a biological therapy needs to act in diseased myocardium before candidate vectors or cells are advanced through laboratory development.

### 4. Computational cardiac modeling

Predictive models based on single-cell and trajectory data are used to narrow candidate vectors and cell lines before extensive bench experimentation.

The intended role of computation is decision support: reduce search-space complexity, prioritize stronger hypotheses, and limit wasted experimental iteration.

---

## How the platform fits together

Virelion explicitly describes its four platform pillars as different levers on the same problem: **restoring function to damaged myocardium**.

### Step 01 — Clinical Characterization

Cardiac mapping data defines the specific structural or functional deficit that a program needs to address.

### Step 02 — Computational Triage

Predictive models narrow the set of vectors and cell lines worth advancing, concentrating experimental effort on the strongest candidates.

### Step 03 — Biological Validation

Gene-therapy vectors and engineered cardiomyocyte grafts are tested against functional benchmarks established during clinical characterization.

This workflow is intended to keep programs grounded in a real cardiac problem from the beginning rather than starting with a technology and searching for an indication later.

---

## Research and technology infrastructure

Alongside therapeutic discovery, Virelion maintains an open-source research-tooling layer for laboratory workflows, cardiac electrophysiology, research intelligence, and biosafety planning.

### Cardiac Regenerative Lab Autocrawler

An autonomous research-intelligence pipeline designed to discover, deduplicate, score, and track academic and translational laboratories working in areas such as:

- Cardiac regeneration
- Engineered heart tissue
- Direct reprogramming
- Stem-cell therapy
- Biological pacing

The site says the pipeline can ingest information from academic papers and preprints, NIH grant data, clinical-trial registries, patent filings, and targeted web crawling of laboratory and scientific-society directories.

Its analysis layer combines deterministic structured-field extraction with LLM-assisted work for research categorization and duplicate-principal-investigator resolution. An **Activity Verification Index** classifies labs as Active, Aging, Inactive-Legacy, or Unknown, with year-over-year comparisons, a funding leaderboard, and a clinical-trial dashboard.

Virelion describes this as an internal research-intelligence utility rather than a clinical or diagnostic product.

### Virelion-OptiCell

A microscopy image quality-control application for batch analysis of cell-image datasets.

Key capabilities described by Virelion include:

- Focus/blur detection using variance of the Laplacian
- Brightness checks
- Estimated cell counting
- Dataset-wide histograms
- Per-image quality flags
- Preview overlays
- Downloadable summary CSV output
- Streamlit GUI and command-line usage
- Optional Cellpose-based segmentation when installed

The tool is intended to help researchers review large microscopy datasets quickly and identify suspicious images without manually opening every frame.

### Virelion-ElectroTrace

A lightweight Streamlit application for creating labeled ECG datasets.

The public feature set includes:

- Multi-channel CSV upload
- Interactive Plotly waveform visualization
- Point annotations such as R peaks and pacing spikes
- Interval annotations for QRS, P/T waves, and artifacts
- Confidence and note fields
- Optional display-only filtering
- JSON export with re-import support
- Flattened CSV export for machine-learning pipelines
- Built-in synthetic sample data

The display filters are described as non-destructive: the raw signal data is not modified.

### Virelion-CardioScore

A preclinical cardiotoxicity-risk scoring framework for **human iPSC-derived cardiomyocyte (iPSC-CM) microelectrode-array (MEA)** recordings.

Virelion describes CardioScore as CiPA-oriented and intended for early prioritization of candidates such as:

- Vaccines
- Antitoxins
- Antivirals
- Other medical-countermeasure candidates

The pipeline is described as automating:

1. Signal quality control
2. Field-potential feature extraction
3. Concentration-response summaries
4. Multi-endpoint risk scoring

Reported endpoints include:

- Field-potential duration (FPD) change
- Beat rate
- Amplitude
- Short-term variability (STV)
- Triangulation proxies

The resulting **CardioScore** is a transparent 0–1 construct mapped to **Low / Moderate / High** risk classes. The site states that weights and thresholds are configurable and that the contribution of each endpoint is inspectable.

**Important limitation:** Virelion explicitly states that CardioScore is a research and preclinical prioritization framework, **not a validated regulatory assay** and not a replacement for CiPA/ICH S7B regulatory testing.

### Virelion-Biosafety-Assessment

A single-page planning aid for cardiac stem-cell and gene-therapy workflows.

The tool allows users to specify factors such as:

- Cell type
- Genetic modification
- Viral vector
- Working scale
- Intended use

It then produces planning guidance covering:

- Suggested minimum biosafety level
- Engineering controls
- PPE
- Waste handling
- Training
- Documentation
- Items that may require Institutional Biosafety Committee (IBC) review

The site says its planning logic is informed by publicly available CDC/NIH BMBL guidance, NIH recombinant-DNA guidance, and WHO laboratory-biosafety guidance.

**Important limitation:** The site explicitly frames this as a general planning reference and **not a substitute for formal IBC or Biosafety Officer sign-off**.

### Open-source access

The public website links to Virelion's GitHub organization and to the individual projects described above:

https://github.com/Virelion-Biotech

Because repositories and project status can change independently of the company website, the GitHub organization should be treated as the current source for code, implementation details, and repository-level documentation.

---

## Development pipeline

Virelion currently discloses three named programs.

| Program | Description | Modality | Indication / objective | Stage | Started |
|---|---|---|---|---|---:|
| **VB-101** | Myocardial Regeneration Gene Therapy Vector | Gene therapy | Myocardial regeneration | Discovery | 2024 |
| **VB-204** | Engineered Cardiomyocyte Graft | Cell therapy / engineered tissue | Structural and functional repair | Discovery | 2025 |
| **VB-310** | Heart Regeneration Computational Model | Computational modeling | Decision support for vector/cell selection | Discovery | 2026 |

### VB-101 — Myocardial Regeneration Gene Therapy Vector

VB-101 is described as a gene-therapy-vector program aimed at restoring function in damaged myocardium.

The public site states that discovery work began in **2024**.

The site's 2026 milestone section says **IND-enabling studies are planned for VB-101**, but the program is still currently listed as being in discovery rather than in an IND-enabling or clinical stage.

### VB-204 — Engineered Cardiomyocyte Graft

VB-204 is a stem-cell-derived cardiomyocyte program focused on specialized cells engineered for structural integration and electrical coupling.

The stated goal is repair of both the structure and function of damaged cardiac tissue.

Discovery began in **2025**.

### VB-310 — Heart Regeneration Computational Model

VB-310 is a computational decision-support program based on single-cell and trajectory data.

Its intended use is to help identify promising vectors and cell lines for cardiac regeneration research.

The program was initiated in **2026** and is currently listed in discovery.

---

## Company history and milestones

### 2024

Virelion Biotech was founded under **Hannan Enterprises Holdings**.

The company says discovery work began on its heart-regeneration gene-therapy-vector program, later identified publicly as **VB-101**.

### 2025

The engineered cardiomyocyte graft platform, **VB-204**, entered early discovery alongside continuing work on VB-101.

### 2026

Virelion initiated **VB-310**, its computational heart-regeneration modeling program.

The company also states that IND-enabling studies are planned for VB-101 as the portfolio advances.

---

## Team

### Syed Umer Hannan — Founder

Virelion identifies **Syed Umer Hannan** as its founder.

The company describes him as an **MD candidate with a clinical focus in cardiology** who founded Virelion to bridge academic cardiac research with an industry-oriented development pipeline.

Virelion says its team is intentionally small and that hiring is driven by specific scientific or program needs rather than a headcount target.

### Advisors

No formal advisory board is publicly listed at present.

The company identifies electrophysiology, regenerative medicine, gene therapy, and regulatory science as areas of interest as a future advisory structure develops.

### Hiring

No formal open positions are currently listed.

Virelion says it remains open to introductions from people whose expertise overlaps with:

- Cardiac regenerative medicine
- Gene-therapy vector design
- Computational cardiology
- Cell engineering

---

## Strategic outlook

Virelion describes its strategic outlook as a combination of:

- Clinical cardiology
- Molecular biology
- Cell-based regeneration
- Computational engineering

Its stated philosophy prioritizes scientific progress, technological acceleration, institutional independence, and long-term thinking.

The company says it does not want to iterate on established modalities simply because they exist; instead, it aims to develop new approaches to cardiac care by combining disciplines that can address the underlying biology of damaged myocardium.

---

## How Virelion says it operates

### Evidence first

Programs are intended to be gated by data rather than conviction. The company states that a model that fails to replicate should be stopped before additional resources are spent.

### Clinical grounding

Programs originate from clinical cardiology questions rather than from technology searching for an indication.

### Lean by design

Virelion describes itself as independently capitalized and deliberately small so that scientific decisions can move quickly.

---

## Scientific and regulatory status

Virelion is currently an **early discovery-stage biotechnology company**.

The public site states that:

- All three named programs are in discovery.
- No IND-enabling or clinical stages have started.
- There are no publicly listed peer-reviewed papers, preprints, or technical notes yet.
- There is no publicly reported clinical data yet.
- Detailed development protocols and oversight arrangements are not public at the discovery stage.

The company states that later-stage development will follow applicable regulatory and ethical frameworks for preclinical and clinical research, including appropriate oversight for animal studies and any future human research.

Because the public portfolio is still early, claims in this README should be read as a description of Virelion's **stated programs and plans**, not as evidence of demonstrated clinical efficacy, safety, regulatory approval, or commercial availability.

---

## Collaboration and partnerships

Virelion invites inquiries related to:

- Scientific collaboration
- Partnerships / business development
- Investment
- Media and press
- General scientific questions
- Career introductions

For scientific outreach, the company asks correspondents to include who they are, their organization if applicable, the relevant program identifier (VB-101, VB-204, or VB-310), and the nature of the inquiry.

### Contact

**Email:** [virelion85@gmail.com](mailto:virelion85@gmail.com)

**Website:** https://virelionbiotech.netlify.app/

**GitHub:** https://github.com/Virelion-Biotech

---
