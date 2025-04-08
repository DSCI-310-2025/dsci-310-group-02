# author: Audra Cornick
# date: 2025-03-12

all: data \
	results \
	analysis \
	reports


# generate cleaned csv
data: scripts/Script1-read-data.R scripts/Script2-clean-data.R data
	Rscript scripts/Script1-read-data.R \
		--output_path="data/raw/shelter_data.csv"
	Rscript scripts/Script2-clean-data.R \
		--input_file_path="data/raw/shelter_data.csv" \
		--output_file_path="data/clean/clean_shelter_data.csv"

# generate figures and objects for EDA
results: data/clean/clean_shelter_data.csv scripts/Script3-EDA.R
	Rscript scripts/Script3-EDA.R --path_data="data/clean/clean_shelter_data.csv" \
		--folder="results" \
		--name1="data-summary.csv" \
		--name2="target-summary.csv" \
		--name3="intake-summary.csv" \
		--name4="type-v-type-plot.png" \
		--name5="type-v-group-plot.png" \
		--name6="cond-v-type-plot.png" \
		--name7="cond-v-group-plot.png" \
		--name8="age-v-group-plot.png"

# generate figures for analysis
analysis: data/clean/clean_shelter_data.csv scripts/Script4-model-results.R
	Rscript scripts/Script4-model-results.R \
		--input_path="data/clean/clean_shelter_data.csv" \
		--output_prefix="results"

# render quarto report in HTML and PDF
reports: reports/animal_shelter_adoptability_analysis.qmd
	quarto render reports/animal_shelter_adoptability_analysis.qmd --to html
	quarto render reports/animal_shelter_adoptability_analysis.qmd --to pdf
	cp reports/animal_shelter_adoptability_analysis.html docs/index.html

# clean
clean:
	rm -rf results/*
	rm -rf reports/animal_shelter_adoptability_analysis.html \
		reports/animal_shelter_adoptability_analysis.pdf \
		data/raw/shelter_data.csv data/clean/clean_shelter_data.csv \
		docs/index.html