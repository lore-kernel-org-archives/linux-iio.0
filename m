Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 09/11] iio: adc: nau7802: Use devm_iio_device_alloc
Date: Tue, 23 Jul 2013 14:28:15 +0530
Message-Id: <1374569897-3858-10-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
References: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/iio/adc/nau7802.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index 70fa171..bdf0346 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -404,7 +404,7 @@ static int nau7802_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	indio_dev = iio_device_alloc(sizeof(*st));
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -423,13 +423,13 @@ static int nau7802_probe(struct i2c_client *client,
 	ret = i2c_smbus_write_byte_data(st->client, NAU7802_REG_PUCTRL,
 				  NAU7802_PUCTRL_RR_BIT);
 	if (ret < 0)
-		goto error_free_indio;
+		return ret;
 
 	/* Enter normal operation mode */
 	ret = i2c_smbus_write_byte_data(st->client, NAU7802_REG_PUCTRL,
 				  NAU7802_PUCTRL_PUD_BIT);
 	if (ret < 0)
-		goto error_free_indio;
+		return ret;
 
 	/*
 	 * After about 200 usecs, the device should be ready and then
@@ -438,9 +438,9 @@ static int nau7802_probe(struct i2c_client *client,
 	udelay(210);
 	ret = i2c_smbus_read_byte_data(st->client, NAU7802_REG_PUCTRL);
 	if (ret < 0)
-		goto error_free_indio;
+		return ret;
 	if (!(ret & NAU7802_PUCTRL_PUR_BIT))
-		goto error_free_indio;
+		return ret;
 
 	of_property_read_u32(np, "nuvoton,vldo", &tmp);
 	st->vref_mv = tmp;
@@ -452,17 +452,17 @@ static int nau7802_probe(struct i2c_client *client,
 
 	ret = i2c_smbus_write_byte_data(st->client, NAU7802_REG_PUCTRL, data);
 	if (ret < 0)
-		goto error_free_indio;
+		return ret;
 	ret = i2c_smbus_write_byte_data(st->client, NAU7802_REG_ADC_CTRL, 0x30);
 	if (ret < 0)
-		goto error_free_indio;
+		return ret;
 
 	if (tmp >= 2400) {
 		data = NAU7802_CTRL1_VLDO((4500 - tmp) / 300);
 		ret = i2c_smbus_write_byte_data(st->client, NAU7802_REG_CTRL1,
 						data);
 		if (ret < 0)
-			goto error_free_indio;
+			return ret;
 	}
 
 	/* Populate available ADC input ranges */
@@ -533,8 +533,6 @@ error_device_register:
 error_free_irq:
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
-error_free_indio:
-	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -549,7 +547,6 @@ static int nau7802_remove(struct i2c_client *client)
 	mutex_destroy(&st->data_lock);
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
