Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hosting.pavoucek.net ([46.28.107.168]:36100 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752968AbcJKN6A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Oct 2016 09:58:00 -0400
From: Tomas Novotny <tomas@novotny.cz>
To: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Yong Li <sdliyong@gmail.com>, linux-iio@vger.kernel.org
Subject: [PATCH v2 1/4] iio: dac: mcp4725: use regulator framework
Date: Tue, 11 Oct 2016 15:57:40 +0200
Message-Id: <1476194263-12015-2-git-send-email-tomas@novotny.cz>
In-Reply-To: <1476194263-12015-1-git-send-email-tomas@novotny.cz>
References: <1476194263-12015-1-git-send-email-tomas@novotny.cz>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use a standard framework to get the reference voltage. It is done that way
in the iio subsystem and it will simplify extending of the driver.

Structure mcp4725_platform_data is left undeleted because it used in the
next patch.

This change breaks the current users of the driver, but there is no
mainline user of struct mcp4725_platform_data.

Signed-off-by: Tomas Novotny <tomas@novotny.cz>
---
 drivers/iio/dac/mcp4725.c       | 46 +++++++++++++++++++++++++++++++++--------
 include/linux/iio/dac/mcp4725.h |  1 -
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index cca935c..2b28b1f 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -18,6 +18,7 @@
 #include <linux/i2c.h>
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -28,10 +29,10 @@
 
 struct mcp4725_data {
 	struct i2c_client *client;
-	u16 vref_mv;
 	u16 dac_value;
 	bool powerdown;
 	unsigned powerdown_mode;
+	struct regulator *vdd_reg;
 };
 
 static int mcp4725_suspend(struct device *dev)
@@ -283,13 +284,18 @@ static int mcp4725_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	struct mcp4725_data *data = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		*val = data->dac_value;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = data->vref_mv;
+		ret = regulator_get_voltage(data->vdd_reg);
+		if (ret < 0)
+			return ret;
+
+		*val = ret / 1000;
 		*val2 = 12;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	}
@@ -328,12 +334,12 @@ static int mcp4725_probe(struct i2c_client *client,
 {
 	struct mcp4725_data *data;
 	struct iio_dev *indio_dev;
-	struct mcp4725_platform_data *platform_data = client->dev.platform_data;
+	struct mcp4725_platform_data *pdata = dev_get_platdata(&client->dev);
 	u8 inbuf[3];
 	u8 pd;
 	int err;
 
-	if (!platform_data || !platform_data->vref_mv) {
+	if (!pdata) {
 		dev_err(&client->dev, "invalid platform data");
 		return -EINVAL;
 	}
@@ -345,6 +351,14 @@ static int mcp4725_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
+	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(data->vdd_reg))
+		return PTR_ERR(data->vdd_reg);
+
+	err = regulator_enable(data->vdd_reg);
+	if (err)
+		return err;
+
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->name = id->name;
 	indio_dev->info = &mcp4725_info;
@@ -352,25 +366,39 @@ static int mcp4725_probe(struct i2c_client *client,
 	indio_dev->num_channels = 1;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	data->vref_mv = platform_data->vref_mv;
-
 	/* read current DAC value */
 	err = i2c_master_recv(client, inbuf, 3);
 	if (err < 0) {
 		dev_err(&client->dev, "failed to read DAC value");
-		return err;
+		goto err_disable_vdd_reg;
 	}
 	pd = (inbuf[0] >> 1) & 0x3;
 	data->powerdown = pd > 0 ? true : false;
 	data->powerdown_mode = pd ? pd - 1 : 2; /* largest register to gnd */
 	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
 
-	return iio_device_register(indio_dev);
+	err = iio_device_register(indio_dev);
+	if (err)
+		goto err_disable_vdd_reg;
+
+	return 0;
+
+
+err_disable_vdd_reg:
+	regulator_disable(data->vdd_reg);
+
+	return err;
 }
 
 static int mcp4725_remove(struct i2c_client *client)
 {
-	iio_device_unregister(i2c_get_clientdata(client));
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct mcp4725_data *data = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	regulator_disable(data->vdd_reg);
+
 	return 0;
 }
 
diff --git a/include/linux/iio/dac/mcp4725.h b/include/linux/iio/dac/mcp4725.h
index 91530e6..7c062e8 100644
--- a/include/linux/iio/dac/mcp4725.h
+++ b/include/linux/iio/dac/mcp4725.h
@@ -10,7 +10,6 @@
 #define IIO_DAC_MCP4725_H_
 
 struct mcp4725_platform_data {
-	u16 vref_mv;
 };
 
 #endif /* IIO_DAC_MCP4725_H_ */
-- 
2.1.4

