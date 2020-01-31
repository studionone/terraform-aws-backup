variable env {
  description = "The project environment, for use in backup plan names"
  type = string
}

variable project {
  description = "The project name, for use in backup plan names"
  type = string
}

variable resources {
  description = "A list of ARNs for resources to be backed up"
  type = list(string)
  default = []
}

variable tags {
  description = "A map of tags to apply to the backup plan, vaults etc"
  type = map
  default = {}
}

variable hourly_period {
  description = "The period in hours used for the hourly rule schedule"
  type = number
  default = 2
}

variable daily_time {
  description = "The UTC hour to perform backups for daily and weekly rule schedules"
  type = number
  default = 0
}

variable max_retention {
  description = "The number of days to keep weekly backups before deleting"
  type = number
  default = 90
}
