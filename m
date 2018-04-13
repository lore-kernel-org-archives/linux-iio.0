Return-Path: <SRS0=Jzh+=HC=vanguardiasur.com.ar=hernan@kernel.org>
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH v2 09/14] staging: iio: ad7746: Add remove()
Date: Fri, 13 Apr 2018 13:36:46 -0300
Message-Id: <1523637411-8531-10-git-send-email-hernan@vanguardiasur.com.ar>
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

This allows the driver to be probed and removed as a module powering it
down on remove().

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index c29a221..05506bf9 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -775,6 +775,31 @@ static int ad7746_probe(struct i2c_client *client,
 	return 0;
 }
 
+static int ad7746_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ad7746_chip_info *chip = iio_priv(indio_dev);
+	unsigned char regval;
+	int ret;
+
+	mutex_lock(&chip->lock);
+
+	regval = chip->config | AD7746_CONF_MODE_PWRDN;
+	ret = i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG, regval);
+
+	mutex_unlock(&chip->lock);
+
+	if (ret < 0) {
+		dev_warn(&client->dev, "Could NOT Power Down!\n");
+		goto out;
+	}
+
+	iio_device_unregister(indio_dev);
+
+out:
+	return ret;
+}
+
 static const struct i2c_device_id ad7746_id[] = {
 	{ "ad7745", 7745 },
 	{ "ad7746", 7746 },
@@ -799,6 +824,7 @@ static struct i2c_driver ad7746_driver = {
 		.of_match_table = of_match_ptr(ad7746_of_match),
 	},
 	.probe = ad7746_probe,
+	.remove = ad7746_remove,
 	.id_table = ad7746_id,
 };
 module_i2c_driver(ad7746_driver);
-- 
2.7.4
