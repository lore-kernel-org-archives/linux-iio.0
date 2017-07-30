Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36224 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754011AbdG3PN3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jul 2017 11:13:29 -0400
Received: by mail-pg0-f67.google.com with SMTP id y129so28219157pgy.3
        for <linux-iio@vger.kernel.org>; Sun, 30 Jul 2017 08:13:29 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v3 09/11] iio: adc: ti-ads1015: use devm_iio_triggered_buffer_setup
Date: Mon, 31 Jul 2017 00:12:53 +0900
Message-Id: <1501427575-31045-10-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1501427575-31045-1-git-send-email-akinobu.mita@gmail.com>
References: <1501427575-31045-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

