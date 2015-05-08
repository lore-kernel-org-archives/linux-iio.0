Return-Path: <festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/2] iio: light: hid-sensor-prox: Use devm_iio_device_register()
Date: Fri,  8 May 2015 15:54:01 -0300
Message-Id: <1431111241-7472-2-git-send-email-festevam@gmail.com>
In-Reply-To: <1431111241-7472-1-git-send-email-festevam@gmail.com>
References: <1431111241-7472-1-git-send-email-festevam@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

Using devm_iio_device_register() can make the code shorter and cleaner.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/iio/light/hid-sensor-prox.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 4ed42df..c9f804b 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -306,7 +306,7 @@ static int hid_prox_probe(struct platform_device *pdev)
 		goto error_unreg_buffer_funcs;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "device register failed\n");
 		goto error_remove_trigger;
@@ -319,13 +319,11 @@ static int hid_prox_probe(struct platform_device *pdev)
 					&prox_state->callbacks);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "callback reg failed\n");
-		goto error_iio_unreg;
+		return ret;
 	}
 
-	return ret;
+	return 0;
 
-error_iio_unreg:
-	iio_device_unregister(indio_dev);
 error_remove_trigger:
 	hid_sensor_remove_trigger(&prox_state->common_attributes);
 error_unreg_buffer_funcs:
@@ -343,7 +341,6 @@ static int hid_prox_remove(struct platform_device *pdev)
 	struct prox_state *prox_state = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PROX);
-	iio_device_unregister(indio_dev);
 	hid_sensor_remove_trigger(&prox_state->common_attributes);
 	iio_triggered_buffer_cleanup(indio_dev);
 	kfree(indio_dev->channels);
-- 
1.9.1
