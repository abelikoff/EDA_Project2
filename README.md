# Exploratory Data Analysis - Project 2

## Notes on implementation

* All scripts rely on `utils.R` for all logic related to downloading
  the data archive (if it's not present), extracting it, and loading
  the datasets.

* In Question 4, we identify coal combustion-related sources by
  finding all sources where sector mentions both "comb" and "coal."

* Similarly, in Questions 5-6, we identify motor vehicle sources by
  finding all sources where sector mentions "vehicle."

All questions ask whether there is an increase or decrease in
emissions. Strictly speaking, one should plot changes relative to the
first year levels or year-to-year changes to clearly demonstrate the
dynamics but our case is rather simple with few years so we can simply
plot total emissions to assess the dynamics visually.
