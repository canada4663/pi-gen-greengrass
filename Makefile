skip_all:
	touch stage0/SKIP stage1/SKIP stage2/SKIP
	touch stage3/SKIP
	touch stage4/SKIP stage5/SKIP
	touch stage60-wifi-supplicant/SKIP
	touch stage70/SKIP stage75-ggc/SKIP
	touch stage76-ml-base/SKIP stage77-opencv3/SKIP
	touch stage78-kinesis-video-streams/SKIP
	touch stage81-ggc-mxnet/SKIP stage82-ggc-tf/SKIP

skip_images_all:
	touch stage0/SKIP_IMAGES stage1/SKIP_IMAGES stage2/SKIP_IMAGES
	touch stage3/SKIP_IMAGES
	touch stage4/SKIP_IMAGES stage5/SKIP_IMAGES
	touch stage60-wifi-supplicant/SKIP_IMAGES
	touch stage70/SKIP_IMAGES stage75-ggc/SKIP_IMAGES
	touch stage76-ml-base/SKIP_IMAGES stage77-opencv3/SKIP_IMAGES
	touch stage78-kinesis-video-streams/SKIP_IMAGES
	touch stage81-ggc-mxnet/SKIP_IMAGES stage82-ggc-tf/SKIP_IMAGES

rm_skip_all:
	rm -f stage0/SKIP stage1/SKIP stage2/SKIP
	rm -f stage3/SKIP
	rm -f stage4/SKIP stage5/SKIP
	rm -f stage60-wifi-supplicant/SKIP
	rm -f stage70/SKIP stage75-ggc/SKIP
	rm -f stage76-ml-base/SKIP stage77-opencv3/SKIP
	rm -f stage78-kinesis-video-streams/SKIP
	#rm -f stage81-ggc-mxnet/SKIP stage82-ggc-tf/SKIP

rm_skip_images_all:
	#rm -f stage0/SKIP_IMAGES stage1/SKIP_IMAGES 
	rm -f stage2/SKIP_IMAGES
	rm -f stage3/SKIP_IMAGES
	#rm -f stage4/SKIP_IMAGES 
	rm -f stage5/SKIP_IMAGES
	#rm -f stage60-wifi-supplicant/SKIP_IMAGES
	rm -f stage70/SKIP_IMAGES stage75-ggc/SKIP_IMAGES
	rm -f stage76-ml-base/SKIP_IMAGES stage77-opencv3/SKIP_IMAGES
	rm -f stage78-kinesis-video-streams/SKIP_IMAGES
	#rm -f stage81-ggc-mxnet/SKIP_IMAGES stage82-ggc-tf/SKIP_IMAGES

rm_skip_images_last_working:
	rm -f stage78-kinesis-video-streams/SKIP_IMAGES

kvsonly: skip_all skip_images_all
	rm stage78-kinesis-video-streams/SKIP
	rm stage78-kinesis-video-streams/SKIP_IMAGES
	sudo CLEAN=1 ./build.sh -c extliburls

kvsall: skip_all skip_images_all rm_skip_all
	rm -f stage78-kinesis-video-streams/SKIP
	rm -f stage78-kinesis-video-streams/SKIP_IMAGES
	sudo CLEAN=1 ./build.sh -c extliburls

all: skip_all skip_images_all rm_skip_all rm_skip_images_all
	sudo CLEAN=1 ./build.sh -c extliburls
