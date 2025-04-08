# author: Audra Cornick
# date: 2025-03-12

all: data/raw/shelter_data.csv \
	data/clean/clean_shelter_data.csv \
	results/data-summary.csv \
	results/target-summary.csv \
	results/intake-summary.csv \
	results/type-v-type-plot.png \
	results/type-v-group-plot.png \
	results/cond-v-type-plot.png \
	results/cond-v-group-plot.png \
	results/age-v-group-plot.png \
	results/elbow_plot.png \
	results/confusion_matrix.png \
	results/summary.csv \
	reports/animal_shelter_adoptability_analysis.html \
	reports/animal_shelter_adoptability_analysis.pdf \
	docs/index.html


# generate cleaned csv
data/shelter_data.csv: scripts/Script1-read-data.R
	Rscript scripts/Script1-read-data.R \
		--output_path="data/raw/shelter_data.csv"

data/clean_shelter_data.csv: data/raw/shelter_data.csv scripts/Script2-clean-data.R
	Rscript scripts/Script2-clean-data.R --input_file_path="data/raw/shelter_data.csv" --output_file_path="data/clean/clean_shelter_data.csv"

# generate figures and objects for EDA
results/data-summary.csv results/target-summary.csv results/intake-summary.csv results/type-v-type-plot.png results/type-v-group-plot.png results/cond-v-type-plot.png results/cond-v-grouppplot.png results/age-v-groupplot.png: data scripts/Script3-EDA.R
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
results/elbow_plot.png results/confusion_matrix.png results/summary.csv: data/clean/clean_shelter_data.csv scripts/Script4-model-results.R
	Rscript scripts/Script4-model-results.R --input_path="data/clean_shelter_data.csv" \
		--output_prefix="results"

# render quarto report in HTML and PDF
reports/animal_shelter_adoptability_analysis.html: results reports/animal_shelter_adoptability_analysis.qmd
	quarto render reports/animal_shelter_adoptability_analysis.qmd --to html

reports/animal_shelter_adoptability_analysis.pdf: results reports/animal_shelter_adoptability_analysis.qmd
	quarto render reports/animal_shelter_adoptability_analysis.qmd --to pdf

docs/index.html: reports/animal_shelter_adoptability_analysis.html
	cp reports/animal_shelter_adoptability_analysis.html docs/index.html

# clean
clean:
	rm -rf results/*
	rm -rf reports/animal_shelter_adoptability_analysis.html \
		reports/animal_shelter_adoptability_analysis.pdf \
		data/raw/shelter_data.csv data/clean/clean_shelter_data.csv \
		docs/index.html