extends Node

var grey_cat_alive
var creme_cat_alive

var grey_cat_hunger
var creme_cat_hunger

var grey_cat_time_left
var creme_cat_time_left

var grey_cat_num_times_fed
var creme_cat_num_times_fed

func _ready():
	grey_cat_alive = true
	creme_cat_alive = true
	grey_cat_hunger = 100
	creme_cat_hunger = 100
	grey_cat_time_left = 100
	creme_cat_time_left = 100
	grey_cat_num_times_fed = 0
	creme_cat_num_times_fed = 0
	
