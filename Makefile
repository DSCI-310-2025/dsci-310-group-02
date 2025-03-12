# author: Audra Cornick
# date: 2025-03-12

all: results/name1.csv \
	results/name2.csv \
	results/name3.csv \
	results/name4.png \
	results/name5.png \
	results/name6.png \
	results/name7.png \
	results/name8.png \
	results/roc_curve.png \
	results/summary.csv \
	analysis/animal_shelter_adoptability_analysis.html \
	analysis/animal_shelter_adoptability_analysis.pdf


# generate cleaned csv
data/shelter_data.csv: code/Script1.R
	Rscript code/01_download_shelter_data.R \
		--out_dir="data"

data/clean_shelter_data.csv: code/Script2.R
	Rscript code/02_shelter_data_cleaning.R --input_dir="shelter_data.csv" \
		--out_dir="data"

# generate figures and objects for EDA
results/name1.csv results/name2.csv results/name3.csv results/name4.png results/name5.png results/name6.png results/name7.png results/name8.png: code/Script3.R
	Rscript code/Script3.R --input_dir="clean_shelter_data.csv" \
		--out_dir="results"

# generate figures for analysis
results/roc_curve.png results/summary.csv: code/Script4.R
	Rscript code/Script4.R --input_dir="clean_shelter_data.csv" \
		--out_dir="results"

# render quarto report in HTML and PDF
analysis/animal_shelter_adoptability_analysis.html: results analysis/animal_shelter_adoptability_analysis.qmd
	quarto render analysis/animal_shelter_adoptability_analysis.qmd --to html

analysis/animal_shelter_adoptability_analysis.pdf: results analysis/animal_shelter_adoptability_analysis.qmd
	quarto render analysis/animal_shelter_adoptability_analysis.qmd --to pdf

# clean
clean:
	rm -rf results
	rm -rf analysis/animal_shelter_adoptability_analysis.html \
		analysis/animal_shelter_adoptability_analysis.pdf \
		analysis/animal_shelter_adoptability_analysise_files \
		data/shelter_data.csv data/clean_shelter_data.csv