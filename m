Return-Path: <Fabio.Estevam@freescale.com>
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <jic23@kernel.org>
CC: <srinivas.pandruvada@linux.intel.com>, <linux-iio@vger.kernel.org>, "Fabio
 Estevam" <fabio.estevam@freescale.com>
Subject: [PATCH v2 6/6] iio: pressure: hid-sensor-press: Fix memory leak in probe()
Date: Tue, 12 May 2015 12:40:41 -0300
Message-ID: <1431445241-17557-6-git-send-email-fabio.estevam@freescale.com>
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

 drivers/iio/pressure/hid-sensor-press.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 7bb8d4c..f1bcb89 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -262,7 +262,6 @@ static int hid_press_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct press_state *press_state;
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
-	struct iio_chan_spec *channels;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 				sizeof(struct press_state));
@@ -282,20 +281,21 @@ static int hid_press_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	channels = kmemdup(press_channels, sizeof(press_channels), GFP_KERNEL);
-	if (!channels) {
+	indio_dev->channels = kmemdup(press_channels, sizeof(press_channels),
+				      GFP_KERNEL);
+	if (!indio_dev->channels) {
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
 		return -ENOMEM;
 	}
 
-	ret = press_parse_report(pdev, hsdev, channels,
+	ret = press_parse_report(pdev, hsdev,
+				(struct iio_chan_spec *)indio_dev->channels,
 				HID_USAGE_SENSOR_PRESSURE, press_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
 		goto error_free_dev_mem;
 	}
 
-	indio_dev->channels = channels;
 	indio_dev->num_channels =
 				ARRAY_SIZE(press_channels);
 	indio_dev->dev.parent = &pdev->dev;
-- 
1.9.1
