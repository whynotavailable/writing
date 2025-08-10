# Review Guidelines

In this world of AI I, I'm compelled to put together some information on what I believe efficient
code reviews look like.

It's easy when executing a code review to bring in biases and opinion, while this may help code
quality, it doesn't help work get completed nor does it help people learn.

This document outlines a process for applying a standard to code reviews. It's broken up into two
parts: the first being how to apply your standard, and the second on how to develop your standard.

## Code Reviews

Code reviews should be unopinionated. If you are going to stop code from being merged you should
have a real/valid reason for doing so. Any comment on a code review (either in writing or in person)
should be prefaced with a type. I have defined a few comment types below, but you are free to change
them or define extra ones.

**Note**: A note is simply that. Something that's nothing more than a comment. It could be around
code design, or something similar. Will not impact the actual results of the review.

**Nitpick**: An opinion of something that doesn't fall under technical debt or other major issues.
Things like parameter ordering or variable names can fall under this type. Will not impact the
actual results of the review.

**Performance**: The code will impact the performance of the specific location or the system as a
whole. May impact the results of the review, but a defense against it would be load and performance
tests before and after the change showing that SLOs are still met.

**Bug**: A defect in the software. Will impact the results of the review.

**Logic**: An issue with the change not matching the request from the work tracking system. Should
include a link to the appropriate place in the work tracking system that outlines the change needed
to be made alongside a description of why the code doesn't meet the request. Will impact the results
of the review.

**Tech Debt**: The code increases tech debt and therefore requires changes. This type will impact
the review, but is special in that it should be accompanied by an associated work item to update
coding guidelines for the project in cover the change. As in "If something would be considered tech
debt it should be added to the coding guidelines."

**Guidelines**: The code violates coding guidelines. A specific reference should be provided to the
guideline in question as well as an explanation of how it applies. Will impact the results of the
review.

______________________________________________________________________

What I see relatively often when it comes to code reviews taking a long time are large amounts of
nitpicks and supposed tech debt. By simply ignoring nitpicks and requiring the reviewer to do the
legwork to prove tech debt, code reviews can be made significantly faster.

## The Guideline

The guideline should be built in layers. With enterprise/company guidelines at the top with the
least detail and getting more detailed going down the organizational structure and into the
repository.

The highest level should be the most abstract. Ideally simple things like "What programming
languages are acceptable?" would be as far as you would go.

Nearly immediately into tech organizational structure should be things like "What frameworks are
allowed?" and "What architectural patterns should be used?" Use words like SHOULD or MUST when
describing guidelines. While it's OK to allow for flexibility, the further down the organizational
structure the less freedom there should be.

Once it gets down to the repo level the guidelines should be **extremely** detailed and **never**
optional.

The filename can be whatever you'd like, but my suggestion would be `CODING.md` or more simply
`CODING` for those who do not want to use markdown.

The format of this file isn't dictated by any standard, but links to the organizational guidelines
covering that repo should be at the top of the list, in order of specificity (with the company
guidelines at the top).

Immediately after the list of links should be a section describing the various sections of the code.
What each folder is used for, and where a given file should go. Here's an example.

```
./logic - general business logic. Contains sub-folders for larger capabilites.
./services - classes/functions for interacting with third party systems.
./models - common models.

If a new model is needed and isn't general usage, it should go in the logic or service folder with
it's capability
```

Following that should be any details pertinent to your application. These are some ideas.

- What database system is used?
  - How is the database used?
  - Are there naming conventions or patterns for the data in use?
- How should logging should be performed?
- How dependency injection is setup, and what patterns/best practices are in place?
- What design patterns are important to follow?

In our current world of AI it may be useful to combine your guidelines into instructions for your
agent.

## But Why?

A few reasons.

- Spending a large amount of time reviewing code doesn't make software significantly better.
- Petty bickering is meaningless and a de-motivator for code authors.
- AI code is a lot more common now and AIs can write code much faster than humans. Humans however
  still need to be the ones to review such code.
