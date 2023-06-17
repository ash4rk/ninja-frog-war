extends Node

var callback_rewareded_ad = JavaScript.create_callback(self, '_rewarded_ad')
var callback_ad = JavaScript.create_callback(self, '_ad')

onready var win = JavaScript.get_interface('window')

func js_show_ad():
	if not win: 
		print_debug("Trying to show ad but missing Yandex sdk")
		return
	win.ShowAd(callback_ad)
	# Stop sound

func js_show_rewarded_ad():
	if not win: 
		print_debug("Trying to show rewarded ad but missing Yandex sdk")
		_rewarded_ad(" ")
		return
	win.ShowAdRewardedVideo(callback_rewareded_ad)
	# Stop sound
	
func _rewarded_ad(args):
	print(args[0])
	ShopPurchases.coins += int(rand_range(76, 145))
	# Resume sound

func _ad(args):
	print(args[0])
	# Resume sound
