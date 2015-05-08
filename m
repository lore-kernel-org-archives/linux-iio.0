Return-Path: <festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/6] iio: gyro: hid-sensor-gyro-3d: Fix memory leak in probe()
Date: Fri,  8 May 2015 16:59:59 -0300
Message-Id: <1431115203-14511-2-git-send-email-festevam@gmail.com>
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

 drivers/iio/gyro/hid-sensor-gyro-3d.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index b5883b6..7b60b58 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -298,7 +298,6 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct gyro_3d_state *gyro_state;
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
-	struct iio_chan_spec *channels;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*gyro_state));
 	if (!indio_dev)
@@ -317,21 +316,21 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	channels = kmemdup(gyro_3d_channels, sizeof(gyro_3d_channels),
-			   GFP_KERNEL);
-	if (!channels) {
+	indio_dev->channels = kmemdup(gyro_3d_channels,
+				      sizeof(gyro_3d_channels), GFP_KERNEL);
+	if (!indio_dev->channels) {
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
 		return -ENOMEM;
 	}
 
-	ret = gyro_3d_parse_report(pdev, hsdev, channels,
-					HID_USAGE_SENSOR_GYRO_3D, gyro_state);
+	ret = gyro_3d_parse_report(pdev, hsdev,
+				   (struct iio_chan_spec *)indio_dev->channels,
+				   HID_USAGE_SENSOR_GYRO_3D, gyro_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
 		goto error_free_dev_mem;
 	}
 
-	indio_dev->channels = channels;
 	indio_dev->num_channels = ARRAY_SIZE(gyro_3d_channels);
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->info = &gyro_3d_info;
-- 
1.9.1
