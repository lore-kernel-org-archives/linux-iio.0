Return-Path: <festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: khoroshilov@ispras.ru,
	daniel.baluta@intel.com,
	linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v3] iio: light: hid-sensor-prox: Fix memory leak in probe()
Date: Thu,  7 May 2015 20:32:04 -0300
Message-Id: <1431041524-14113-1-git-send-email-festevam@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

'channels' is allocated via kmemdup and it is never freed.

Use 'indio_dev->channels' directly instead, so that we avoid such
memory leak problem.

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Build-tested only. 

Changes since v2:
- Get rid of the channels and use indio_dev->channels instead.

 drivers/iio/light/hid-sensor-prox.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 91ecc46..124a8f8 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -253,7 +253,6 @@ static int hid_prox_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct prox_state *prox_state;
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
-	struct iio_chan_spec *channels;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 				sizeof(struct prox_state));
@@ -272,20 +271,21 @@ static int hid_prox_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	channels = kmemdup(prox_channels, sizeof(prox_channels), GFP_KERNEL);
-	if (!channels) {
+	indio_dev->channels = kmemdup(prox_channels, sizeof(prox_channels),
+				      GFP_KERNEL);
+	if (!indio_dev->channels) {
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
 		return -ENOMEM;
 	}
 
-	ret = prox_parse_report(pdev, hsdev, channels,
+	ret = prox_parse_report(pdev, hsdev,
+				(struct iio_chan_spec *)indio_dev->channels,
 				HID_USAGE_SENSOR_PROX, prox_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
 		goto error_free_dev_mem;
 	}
 
-	indio_dev->channels = channels;
 	indio_dev->num_channels =
 				ARRAY_SIZE(prox_channels);
 	indio_dev->dev.parent = &pdev->dev;
-- 
1.9.1
