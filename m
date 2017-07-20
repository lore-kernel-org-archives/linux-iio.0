Return-Path: <SRS0=4kh6=6X=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 09/11] iio: adc: ti-ads1015: use devm_iio_triggered_buffer_setup
Date: Fri, 21 Jul 2017 00:24:25 +0900
Message-Id: <1500564267-8613-10-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
References: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Use devm_iio_triggered_buffer_setup to simplify the error path in the
probe() and remove() function.

This changes the remove order, but the end result of remove function
actually does the reverse of probe.

Cc: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 9f3f0c9..da25780 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -627,9 +627,9 @@ static int ads1015_probe(struct i2c_client *client,
 		return PTR_ERR(data->regmap);
 	}
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 ads1015_trigger_handler,
-					 &ads1015_buffer_setup_ops);
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+					      ads1015_trigger_handler,
+					      &ads1015_buffer_setup_ops);
 	if (ret < 0) {
 		dev_err(&client->dev, "iio triggered buffer setup failed\n");
 		return ret;
@@ -643,7 +643,7 @@ static int ads1015_probe(struct i2c_client *client,
 
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret)
-		goto err_buffer_cleanup;
+		return ret;
 	pm_runtime_set_autosuspend_delay(&client->dev, ADS1015_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
 	pm_runtime_enable(&client->dev);
@@ -651,15 +651,10 @@ static int ads1015_probe(struct i2c_client *client,
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to register IIO device\n");
-		goto err_buffer_cleanup;
+		return ret;
 	}
 
 	return 0;
-
-err_buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return ret;
 }
 
 static int ads1015_remove(struct i2c_client *client)
@@ -673,8 +668,6 @@ static int ads1015_remove(struct i2c_client *client)
 	pm_runtime_set_suspended(&client->dev);
 	pm_runtime_put_noidle(&client->dev);
 
-	iio_triggered_buffer_cleanup(indio_dev);
-
 	/* power down single shot mode */
 	return ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
 }
-- 
2.7.4
