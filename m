Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 5/8] iio: adc: ti-adc081c: Use devm_iio_device_register
Date: Tue, 24 Sep 2013 17:35:35 +0530
Message-Id: <1380024338-30204-6-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380024338-30204-1-git-send-email-sachin.kamat@linaro.org>
References: <1380024338-30204-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/adc/ti-adc081c.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index ee5f72b..f0b7e73 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -97,7 +97,7 @@ static int adc081c_probe(struct i2c_client *client,
 	iio->channels = &adc081c_channel;
 	iio->num_channels = 1;
 
-	err = iio_device_register(iio);
+	err = devm_iio_device_register(&client->dev, iio);
 	if (err < 0)
 		goto regulator_disable;
 
@@ -116,7 +116,6 @@ static int adc081c_remove(struct i2c_client *client)
 	struct iio_dev *iio = i2c_get_clientdata(client);
 	struct adc081c *adc = iio_priv(iio);
 
-	iio_device_unregister(iio);
 	regulator_disable(adc->ref);
 
 	return 0;
-- 
1.7.9.5
