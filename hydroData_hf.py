# cloned from -> https://github.com/hydroframe/hf_hydrodata#
# and going through code...
# install package via bash terminal -> pip install hf_hydrodata
# also info here -> https://hf-hydrodata.readthedocs.io/en/latest/getting_started.html#creating-a-hydroframe-api-account

import hf_hydrodata as hf
# create own account -> https://hydrogen.princeton.edu/signup
# and pin -> https://hydrogen.princeton.edu/pin
# hf.register_api_pin("tsgilbert@arizona.edu", "####")

print("hf_hydrodata...")



datasets = hf.get_datasets()
print("datasets:")
print(datasets)

variables = hf.get_variables({"dataset": "NLDAS2", "grid": "conus1"})
print("variables:")
print(variables)

options = {
  "dataset": "NLDAS2", "variable": "precipitation", "period": "hourly",
  "start_time": "2005-10-1", "end_time": "2005-10-2", "grid_bounds": [100, 100, 200, 200]
}

# need to be registered with email and pin ->
data = hf.get_gridded_data(options)
#print(data)





