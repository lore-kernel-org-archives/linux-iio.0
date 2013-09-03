Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:33377 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759146Ab3ICBFc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Sep 2013 21:05:32 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 02/18] staging:iio:hmc5843: Use devm_iio_device_alloc
Date: Tue,  3 Sep 2013 03:05:04 +0200
Message-Id: <1378170320-27538-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
References: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c |   24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index c3f3f53..3e72121 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -643,11 +643,9 @@ static int hmc5843_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int err = 0;
 
-	indio_dev = iio_device_alloc(sizeof(*data));
-	if (indio_dev == NULL) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (indio_dev == NULL)
+		return -ENOMEM;
 
 	/* default settings at probe */
 	data = iio_priv(indio_dev);
@@ -665,24 +663,16 @@ static int hmc5843_probe(struct i2c_client *client,
 
 	err = iio_device_register(indio_dev);
 	if (err)
-		goto exit_free2;
+		return err;
 
 	return 0;
-
-exit_free2:
-	iio_device_free(indio_dev);
-exit:
-	return err;
 }
 
 static int hmc5843_remove(struct i2c_client *client)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
+	iio_device_unregister(i2c_get_clientdata(client));
 	 /*  sleep mode to save power */
 	hmc5843_configure(client, HMC5843_MODE_SLEEP);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
@@ -691,14 +681,14 @@ static int hmc5843_remove(struct i2c_client *client)
 static int hmc5843_suspend(struct device *dev)
 {
 	hmc5843_configure(to_i2c_client(dev), HMC5843_MODE_SLEEP);
+
 	return 0;
 }
 
 static int hmc5843_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct hmc5843_data *data = iio_priv(indio_dev);
+	struct hmc5843_data *data = iio_priv(i2c_get_clientdata(client));
 
 	hmc5843_configure(client, data->operating_mode);
 
-- 
1.7.9.5

