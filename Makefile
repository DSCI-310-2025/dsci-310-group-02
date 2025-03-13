# author: Audra Cornick
# date: 2025-03-12

all: data/shelter_data.csv \
	data/clean_shelter_data.csv \
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
	analysis/animal_shelter_adoptability_analysis.html \
	analysis/animal_shelter_adoptability_analysis.pdf \
	docs/index.html


# generate cleaned csv
data/shelter_data.csv: code/Script1-read-data.R
	Rscript code/script1-read-data.R \
		--output_path="data/shelter_data.csv"

data/clean_shelter_data.csv: data/shelter_data.csv code/Script2-clean-data.R
	Rscript code/script2-clean-data.R --input_file_path="data/shelter_data.csv" --output_file_path="data/clean_shelter_data.csv"

# generate figures and objects for EDA
results/data-summary.csv results/target-summary.csv results/intake-summary.csv results/type-v-type-plot.png results/type-v-group-plot.png results/cond-v-type-plot.png results/cond-v-grouppplot.png results/age-v-groupplot.png: data code/Script3-EDA.R
	Rscript code/Script3-EDA.R --path_data="data/clean_shelter_data.csv" \
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
results/elbow_plot.png results/confusion_matrix.png results/summary.csv: data code/Script4-model-results.R
	Rscript code/Script4-model-results.R --input_path="data/clean_shelter_data.csv" \
		--output_prefix="results"

# render quarto report in HTML and PDF
analysis/animal_shelter_adoptability_analysis.html: results analysis/animal_shelter_adoptability_analysis.qmd
	quarto render analysis/animal_shelter_adoptability_analysis.qmd --to html

analysis/animal_shelter_adoptability_analysis.pdf: results analysis/animal_shelter_adoptability_analysis.qmd
	quarto render analysis/animal_shelter_adoptability_analysis.qmd --to pdf

docs/index.html: analysis/animal_shelter_adoptability_analysis.html
	cp analysis/animal_shelter_adoptability_analysis.html docs/index.html

# clean
clean:
	rm -rf results/*
	rm -rf analysis/animal_shelter_adoptability_analysis.html \
		analysis/animal_shelter_adoptability_analysis.pdf \
		analysis/animal_shelter_adoptability_analysise_files \
		data/shelter_data.csv data/clean_shelter_data.csv \
		docs/index.html