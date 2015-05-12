Return-Path: <Fabio.Estevam@freescale.com>
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <jic23@kernel.org>
CC: <srinivas.pandruvada@linux.intel.com>, <linux-iio@vger.kernel.org>, "Fabio
 Estevam" <fabio.estevam@freescale.com>
Subject: [PATCH v2 1/6] iio: accel: hid-sensor-accel-3d: Fix memory leak in probe()
Date: Tue, 12 May 2015 12:40:36 -0300
Message-ID: <1431445241-17557-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

'channels' is allocated via kmemdup and it is never freed in the
subsequent error paths.

Use 'indio_dev->channels' directly instead, so that we avoid such
memory leak problem.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Build-tested only.

Changes since v1:
- Make clear in the commit log that the proble only occurs in the error
paths

 drivers/iio/accel/hid-sensor-accel-3d.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 2b4fad6..b933957 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -299,7 +299,6 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct accel_3d_state *accel_state;
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
-	struct iio_chan_spec *channels;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					  sizeof(struct accel_3d_state));
@@ -320,21 +319,21 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	channels = kmemdup(accel_3d_channels, sizeof(accel_3d_channels),
-			   GFP_KERNEL);
-	if (!channels) {
+	indio_dev->channels = kmemdup(accel_3d_channels,
+				      sizeof(accel_3d_channels), GFP_KERNEL);
+	if (!indio_dev->channels) {
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
 		return -ENOMEM;
 	}
 
-	ret = accel_3d_parse_report(pdev, hsdev, channels,
-					HID_USAGE_SENSOR_ACCEL_3D, accel_state);
+	ret = accel_3d_parse_report(pdev, hsdev,
+				    (struct iio_chan_spec *)indio_dev->channels,
+				     HID_USAGE_SENSOR_ACCEL_3D, accel_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
 		goto error_free_dev_mem;
 	}
 
-	indio_dev->channels = channels;
 	indio_dev->num_channels = ARRAY_SIZE(accel_3d_channels);
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->info = &accel_3d_info;
-- 
1.9.1
