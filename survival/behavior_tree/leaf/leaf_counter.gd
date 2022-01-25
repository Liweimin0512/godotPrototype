extends Task

class_name Counter

var count = 0

const MAX = 100

func run():
  if status == RUNNING:
    count += 1
    if count <= MAX:
      tree.show_value("Count", count)
      running()
    else:
      count = 0
      success() 