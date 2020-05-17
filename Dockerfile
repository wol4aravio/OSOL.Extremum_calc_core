FROM julia:1.4.1-buster

WORKDIR core

COPY Project.toml .
COPY Manifest.toml .

ENV JULIA_PROJECT=/core
RUN julia -e 'using Pkg; Pkg.activate(".")'
RUN julia -e 'using Pkg; Pkg.instantiate()'

COPY OSOL_Extremum OSOL_Extremum

EXPOSE 8085
CMD julia -e 'include("OSOL_Extremum/src/Core.jl")'
