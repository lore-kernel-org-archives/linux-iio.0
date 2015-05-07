Return-Path: <Fabio.Estevam@freescale.com>
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <jic23@kernel.org>
CC: <khoroshilov@ispras.ru>, <daniel.baluta@intel.com>,
	<linux-iio@vger.kernel.org>, <srinivas.pandruvada@linux.intel.com>, "Fabio
 Estevam" <fabio.estevam@freescale.com>
Subject: [PATCH v2] iio: light: hid-sensor-prox: Fix memory leak in probe()/remove()
Date: Thu, 7 May 2015 11:09:58 -0300
Message-ID: <1431007798-20807-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

'channels' is allocated via kmemdup, so we need to free it after its usage.

This way we fix the memory leak in both probe and remove paths.

Also, as 'indio_dev' is allocated via devm_iio_device_alloc(), so there is
no need to call kfree for it.

Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Always call kfree(channel) after its usage.

 drivers/iio/light/hid-sensor-prox.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 91ecc46..00ce0f6 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -278,16 +278,17 @@ static int hid_prox_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	indio_dev->channels = channels;
+
 	ret = prox_parse_report(pdev, hsdev, channels,
 				HID_USAGE_SENSOR_PROX, prox_state);
+	kfree(channels);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
-		goto error_free_dev_mem;
+		return ret;
 	}
 
-	indio_dev->channels = channels;
-	indio_dev->num_channels =
-				ARRAY_SIZE(prox_channels);
+	indio_dev->num_channels = ARRAY_SIZE(prox_channels);
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->info = &prox_info;
 	indio_dev->name = name;
@@ -297,7 +298,7 @@ static int hid_prox_probe(struct platform_device *pdev)
 		NULL, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to initialize trigger buffer\n");
-		goto error_free_dev_mem;
+		return ret;
 	}
 	atomic_set(&prox_state->common_attributes.data_ready, 0);
 	ret = hid_sensor_setup_trigger(indio_dev, name,
@@ -331,8 +332,6 @@ error_remove_trigger:
 	hid_sensor_remove_trigger(&prox_state->common_attributes);
 error_unreg_buffer_funcs:
 	iio_triggered_buffer_cleanup(indio_dev);
-error_free_dev_mem:
-	kfree(indio_dev->channels);
 	return ret;
 }
 
@@ -347,7 +346,6 @@ static int hid_prox_remove(struct platform_device *pdev)
 	iio_device_unregister(indio_dev);
 	hid_sensor_remove_trigger(&prox_state->common_attributes);
 	iio_triggered_buffer_cleanup(indio_dev);
-	kfree(indio_dev->channels);
 
 	return 0;
 }
-- 
1.9.1
