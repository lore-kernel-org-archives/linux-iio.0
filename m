Return-Path: <festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 5/6] iio: orientation: hid-sensor-rotation: Fix memory leak in probe()
Date: Fri,  8 May 2015 17:00:02 -0300
Message-Id: <1431115203-14511-5-git-send-email-festevam@gmail.com>
In-Reply-To: <1431115203-14511-1-git-send-email-festevam@gmail.com>
References: <1431115203-14511-1-git-send-email-festevam@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

'channels' is allocated via kmemdup and it is never freed.

Use 'indio_dev->channels' directly instead, so that we avoid such
memory leak problem.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Build-tested only.

 drivers/iio/orientation/hid-sensor-rotation.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 4afb6c7..b6ee50f 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -222,7 +222,6 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct dev_rot_state *rot_state;
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
-	struct iio_chan_spec *channels;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					  sizeof(struct dev_rot_state));
@@ -243,21 +242,23 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	channels = devm_kmemdup(&pdev->dev, dev_rot_channels,
-					sizeof(dev_rot_channels), GFP_KERNEL);
-	if (!channels) {
+	indio_dev->channels = devm_kmemdup(&pdev->dev, dev_rot_channels,
+					   sizeof(dev_rot_channels),
+					   GFP_KERNEL);
+	if (!indio_dev->channels) {
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
 		return -ENOMEM;
 	}
 
-	ret = dev_rot_parse_report(pdev, hsdev, channels,
-			HID_USAGE_SENSOR_DEVICE_ORIENTATION, rot_state);
+	ret = dev_rot_parse_report(pdev, hsdev,
+				   (struct iio_chan_spec *)indio_dev->channels,
+				   HID_USAGE_SENSOR_DEVICE_ORIENTATION,
+				   rot_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
 		return ret;
 	}
 
-	indio_dev->channels = channels;
 	indio_dev->num_channels = ARRAY_SIZE(dev_rot_channels);
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->info = &dev_rot_info;
-- 
1.9.1
