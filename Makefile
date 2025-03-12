# author: Jordan Bourak & Tiffany Timbers
# date: 2021-11-22

all: results/horse_pop_plot_largest_sd.png \
	results/horse_pops_plot.png \
	results/horses_spread.csv \
	analysis/animal_shelter_adoptability_analysis.html \
	analysis/animal_shelter_adoptability_analysis.pdf


# generate cleaned csv
data/shelter_data.csv: source/download_shelter_data.R
	Rscript source/download_shelter_data.R \
		--out_dir="data"

data/clean_shelter_data.csv: source/shelter_data_cleaning.R
	Rscript source/shelter_data_cleaning.R --input_dir="shelter_data.csv" \
		--out_dir="data"

# generate figures and objects for report
results/horse_pop_plot_largest_sd.png results/horse_pops_plot.png results/horses_spread.csv: source/Script3.R
	Rscript source/generate_figures.R --input_dir="clean_shelter_data.csv" \
		--out_dir="results"

results/horse_pop_plot_largest_sd.png results/horse_pops_plot.png results/horses_spread.csv: source/summarize_shelter_data.R
	Rscript source/generate_figures.R --input_dir="clean_shelter_data.csv" \
		--out_dir="results"

# render quarto report in HTML and PDF
analysis/animal_shelter_adoptability_analysis.html: results reports/animal_shelter_adoptability_analysis.qmd
	quarto render reports/animal_shelter_adoptability_analysis.qmd --to html

analysis/animal_shelter_adoptability_analysis.pdf: results reports/animal_shelter_adoptability_analysis.qmd
	quarto render analysis/animal_shelter_adoptability_analysis.qmd --to pdf

# clean
clean:
	rm -rf results
	rm -rf analysis/animal_shelter_adoptability_analysis.html \
		analysis/animal_shelter_adoptability_analysis.pdf \
		analysis/nimal_shelter_adoptability_analysise_files