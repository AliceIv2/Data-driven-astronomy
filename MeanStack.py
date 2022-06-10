# Write your calc_stats function here.
import numpy as np

def calc_stats(file):
  data = np.loadtxt(file, delimiter =',')
  
  mean = np.mean(data)
  median = np.median(data)
  
  mean = np.round(mean, 1)
  median = np.round(median, 1)
  
  return mean, median



# You can use this to test your function.
# Any code inside this `if` statement will be ignored by the automarker.
if __name__ == '__main__':
  # Run your `calc_stats` function with examples:
  mean = calc_stats('data.csv')
  print(mean)
