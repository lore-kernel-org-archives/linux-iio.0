Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	sachin.kamat@linaro.org,
	jic23@kernel.org,
	"J. August Brenner" <jbrenner@taosinc.com>
Subject: [PATCH 02/12] staging: iio: tsl2583: Use devm_iio_device_alloc
Date: Thu,  5 Sep 2013 14:59:47 +0530
Message-Id: <1378373397-22919-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org>
References: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_alloc makes the code simple. While at it also
fixed an uninitialized return with -EINVAL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: J. August Brenner <jbrenner@taosinc.com>
---
 drivers/staging/iio/light/tsl2583.c |   24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index b377dd3..d2aaf16 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -815,12 +815,9 @@ static int taos_probe(struct i2c_client *clientp,
 		return -EOPNOTSUPP;
 	}
 
-	indio_dev = iio_device_alloc(sizeof(*chip));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		dev_err(&clientp->dev, "iio allocation failed\n");
-		goto fail1;
-	}
+	indio_dev = devm_iio_device_alloc(&clientp->dev, sizeof(*chip));
+	if (!indio_dev)
+		return -ENOMEM;
 	chip = iio_priv(indio_dev);
 	chip->client = clientp;
 	i2c_set_clientdata(clientp, indio_dev);
@@ -835,14 +832,14 @@ static int taos_probe(struct i2c_client *clientp,
 		if (ret < 0) {
 			dev_err(&clientp->dev, "i2c_smbus_write_bytes() to cmd "
 				"reg failed in taos_probe(), err = %d\n", ret);
-			goto fail2;
+			return ret;
 		}
 		ret = i2c_smbus_read_byte(clientp);
 		if (ret < 0) {
 			dev_err(&clientp->dev, "i2c_smbus_read_byte from "
 				"reg failed in taos_probe(), err = %d\n", ret);
 
-			goto fail2;
+			return ret;
 		}
 		buf[i] = ret;
 	}
@@ -850,14 +847,14 @@ static int taos_probe(struct i2c_client *clientp,
 	if (!taos_tsl258x_device(buf)) {
 		dev_info(&clientp->dev, "i2c device found but does not match "
 			"expected id in taos_probe()\n");
-		goto fail2;
+		return -EINVAL;
 	}
 
 	ret = i2c_smbus_write_byte(clientp, (TSL258X_CMD_REG | TSL258X_CNTRL));
 	if (ret < 0) {
 		dev_err(&clientp->dev, "i2c_smbus_write_byte() to cmd reg "
 			"failed in taos_probe(), err = %d\n", ret);
-		goto fail2;
+		return ret;
 	}
 
 	indio_dev->info = &tsl2583_info;
@@ -867,7 +864,7 @@ static int taos_probe(struct i2c_client *clientp,
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(&clientp->dev, "iio registration failed\n");
-		goto fail2;
+		return ret;
 	}
 
 	/* Load up the V2 defaults (these are hard coded defaults for now) */
@@ -878,10 +875,6 @@ static int taos_probe(struct i2c_client *clientp,
 
 	dev_info(&clientp->dev, "Light sensor found.\n");
 	return 0;
-fail1:
-	iio_device_free(indio_dev);
-fail2:
-	return ret;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -926,7 +919,6 @@ static SIMPLE_DEV_PM_OPS(taos_pm_ops, taos_suspend, taos_resume);
 static int taos_remove(struct i2c_client *client)
 {
 	iio_device_unregister(i2c_get_clientdata(client));
-	iio_device_free(i2c_get_clientdata(client));
 
 	return 0;
 }
-- 
1.7.9.5
