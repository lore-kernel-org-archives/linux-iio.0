Return-Path: <Fabio.Estevam@freescale.com>
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <jic23@kernel.org>
CC: <srinivas.pandruvada@linux.intel.com>, <linux-iio@vger.kernel.org>, "Fabio
 Estevam" <fabio.estevam@freescale.com>
Subject: [PATCH v2 4/6] iio: orientation: hid-sensor-incl-3d: Fix memory leak in probe()
Date: Tue, 12 May 2015 12:40:39 -0300
Message-ID: <1431445241-17557-4-git-send-email-fabio.estevam@freescale.com>
In-Reply-To: <1431445241-17557-1-git-send-email-fabio.estevam@freescale.com>
References: <1431445241-17557-1-git-send-email-fabio.estevam@freescale.com>
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

 drivers/iio/orientation/hid-sensor-incl-3d.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 5930fa3..2eb49a8 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -315,7 +315,6 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct incl_3d_state *incl_state;
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
-	struct iio_chan_spec *channels;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					  sizeof(struct incl_3d_state));
@@ -336,21 +335,22 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	channels = kmemdup(incl_3d_channels, sizeof(incl_3d_channels),
-			   GFP_KERNEL);
-	if (!channels) {
+	indio_dev->channels = kmemdup(incl_3d_channels,
+				      sizeof(incl_3d_channels), GFP_KERNEL);
+	if (!indio_dev->channels) {
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
 		return -ENOMEM;
 	}
 
-	ret = incl_3d_parse_report(pdev, hsdev, channels,
-				HID_USAGE_SENSOR_INCLINOMETER_3D, incl_state);
+	ret = incl_3d_parse_report(pdev, hsdev,
+				   (struct iio_chan_spec *)indio_dev->channels,
+				   HID_USAGE_SENSOR_INCLINOMETER_3D,
+				   incl_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
 		goto error_free_dev_mem;
 	}
 
-	indio_dev->channels = channels;
 	indio_dev->num_channels = ARRAY_SIZE(incl_3d_channels);
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->info = &incl_3d_info;
-- 
1.9.1
