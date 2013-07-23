Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 10/11] iio: adc: ti-adc081c: Use devm_* APIs
Date: Tue, 23 Jul 2013 14:28:16 +0530
Message-Id: <1374569897-3858-11-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
References: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/iio/adc/ti-adc081c.c |   18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 2826faa..ee5f72b 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -74,22 +74,20 @@ static int adc081c_probe(struct i2c_client *client,
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
 		return -ENODEV;
 
-	iio = iio_device_alloc(sizeof(*adc));
+	iio = devm_iio_device_alloc(&client->dev, sizeof(*adc));
 	if (!iio)
 		return -ENOMEM;
 
 	adc = iio_priv(iio);
 	adc->i2c = client;
 
-	adc->ref = regulator_get(&client->dev, "vref");
-	if (IS_ERR(adc->ref)) {
-		err = PTR_ERR(adc->ref);
-		goto iio_free;
-	}
+	adc->ref = devm_regulator_get(&client->dev, "vref");
+	if (IS_ERR(adc->ref))
+		return PTR_ERR(adc->ref);
 
 	err = regulator_enable(adc->ref);
 	if (err < 0)
-		goto regulator_put;
+		return err;
 
 	iio->dev.parent = &client->dev;
 	iio->name = dev_name(&client->dev);
@@ -109,10 +107,6 @@ static int adc081c_probe(struct i2c_client *client,
 
 regulator_disable:
 	regulator_disable(adc->ref);
-regulator_put:
-	regulator_put(adc->ref);
-iio_free:
-	iio_device_free(iio);
 
 	return err;
 }
@@ -124,8 +118,6 @@ static int adc081c_remove(struct i2c_client *client)
 
 	iio_device_unregister(iio);
 	regulator_disable(adc->ref);
-	regulator_put(adc->ref);
-	iio_device_free(iio);
 
 	return 0;
 }
-- 
1.7.9.5
