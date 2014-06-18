Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:28211 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933819AbaFRGV7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jun 2014 02:21:59 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N7C00HTBPOAVR10@mailout4.samsung.com> for
 linux-iio@vger.kernel.org; Wed, 18 Jun 2014 15:21:46 +0900 (KST)
From: Beomho Seo <beomho.seo@samsung.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org,
	j.anaszewski@samsung.com, sachin.kamat@linaro.org,
	ch.naveen@samsung.com, ktsai@capellamicro.com,
	srinivas.pandruvada@linux.intel.com, t.figa@samsung.com
Cc: myungjoo.ham@samsung.com, jh80.chung@samsung.com,
	cw00.choi@samsung.com, Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH 5/5] iio: magnetometer: ak8975: Use devm_* APIs
Date: Wed, 18 Jun 2014 15:21:43 +0900
Message-id: <1403072503-29246-6-git-send-email-beomho.seo@samsung.com>
In-reply-to: <1403072503-29246-1-git-send-email-beomho.seo@samsung.com>
References: <1403072503-29246-1-git-send-email-beomho.seo@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch use devm_* APIs and make driver simpler.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/iio/magnetometer/ak8975.c |   48 ++++++++-----------------------------
 1 file changed, 10 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 09ea5c4..ad71160 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -165,7 +165,7 @@ static int ak8975_setup_irq(struct ak8975_data *data)
 	else
 		irq = gpio_to_irq(data->eoc_gpio);
 
-	rc = request_irq(irq, ak8975_irq_handler,
+	rc = devm_request_irq(&client->dev, irq, ak8975_irq_handler,
 			 IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 			 dev_name(&client->dev), data);
 	if (rc < 0) {
@@ -520,20 +520,21 @@ static int ak8975_probe(struct i2c_client *client,
 	/* We may not have a GPIO based IRQ to scan, that is fine, we will
 	   poll if so */
 	if (gpio_is_valid(eoc_gpio)) {
-		err = gpio_request_one(eoc_gpio, GPIOF_IN, "ak_8975");
+		err = devm_gpio_request_one(&client->dev, eoc_gpio,
+							GPIOF_IN, "ak_8975");
 		if (err < 0) {
 			dev_err(&client->dev,
 				"failed to request GPIO %d, error %d\n",
 							eoc_gpio, err);
-			goto exit;
+			return err;
 		}
 	}
 
 	/* Register with IIO */
-	indio_dev = iio_device_alloc(sizeof(*data));
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (indio_dev == NULL) {
 		err = -ENOMEM;
-		goto exit_gpio;
+		return err;
 	}
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
@@ -551,7 +552,7 @@ static int ak8975_probe(struct i2c_client *client,
 		name = ak8975_match_acpi_device(&client->dev, &data->chipset);
 	else {
 		err = -ENOSYS;
-		goto exit_free_iio;
+		return err;
 	}
 	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
 
@@ -559,7 +560,7 @@ static int ak8975_probe(struct i2c_client *client,
 	err = ak8975_setup(client);
 	if (err < 0) {
 		dev_err(&client->dev, "AK8975 initialization fails\n");
-		goto exit_free_iio;
+		return err;
 	}
 
 	data->client = client;
@@ -571,37 +572,9 @@ static int ak8975_probe(struct i2c_client *client,
 	indio_dev->info = &ak8975_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = name;
-	err = iio_device_register(indio_dev);
+	err = devm_iio_device_register(&client->dev, indio_dev);
 	if (err < 0)
-		goto exit_free_iio;
-
-	return 0;
-
-exit_free_iio:
-	iio_device_free(indio_dev);
-	if (data->eoc_irq)
-		free_irq(data->eoc_irq, data);
-exit_gpio:
-	if (gpio_is_valid(eoc_gpio))
-		gpio_free(eoc_gpio);
-exit:
-	return err;
-}
-
-static int ak8975_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct ak8975_data *data = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	if (data->eoc_irq)
-		free_irq(data->eoc_irq, data);
-
-	if (gpio_is_valid(data->eoc_gpio))
-		gpio_free(data->eoc_gpio);
-
-	iio_device_free(indio_dev);
+		return err;
 
 	return 0;
 }
@@ -628,7 +601,6 @@ static struct i2c_driver ak8975_driver = {
 		.acpi_match_table = ACPI_PTR(ak_acpi_match),
 	},
 	.probe		= ak8975_probe,
-	.remove		= ak8975_remove,
 	.id_table	= ak8975_id,
 };
 module_i2c_driver(ak8975_driver);
-- 
1.7.9.5

