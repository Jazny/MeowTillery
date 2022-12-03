extends Node

var grey_cat_alive
var calico_cat_alive
var black_cat_alive

var grey_cat_hunger
var calico_cat_hunger
var black_cat_hunger

var grey_cat_time_left
var calico_cat_time_left
var black_cat_time_left

var grey_cat_num_times_fed
var calico_cat_num_times_fed
var black_cat_num_times_fed

func _ready():
	grey_cat_alive = true
	calico_cat_alive = true
	black_cat_alive = true
	grey_cat_hunger = 100
	calico_cat_hunger = 100
	black_cat_hunger = 100
	grey_cat_time_left = 100
	calico_cat_time_left = 100
	black_cat_time_left = 100
	grey_cat_num_times_fed = 0
	calico_cat_num_times_fed = 0
	black_cat_num_times_fed = 0
	
	
