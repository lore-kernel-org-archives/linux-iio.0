Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hosting.pavoucek.net ([46.28.107.168]:59477 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932694AbcI3N0m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2016 09:26:42 -0400
From: Tomas Novotny <tomas@novotny.cz>
To: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Yong Li <sdliyong@gmail.com>, linux-iio@vger.kernel.org
Subject: [PATCH 3/3] iio: dac: mcp4725: add devicetree support
Date: Fri, 30 Sep 2016 15:19:48 +0200
Message-Id: <1475241588-18429-4-git-send-email-tomas@novotny.cz>
In-Reply-To: <1475241588-18429-1-git-send-email-tomas@novotny.cz>
References: <1475241588-18429-1-git-send-email-tomas@novotny.cz>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Tomas Novotny <tomas@novotny.cz>
---
 drivers/iio/dac/mcp4725.c | 71 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index f8e54f1..74ffe56 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -18,6 +18,7 @@
 #include <linux/i2c.h>
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -326,23 +327,57 @@ static const struct iio_info mcp4725_info = {
 	.driver_module = THIS_MODULE,
 };
 
+#ifdef CONFIG_OF
+static int mcp472x_probe_dt(struct device *dev,
+			    struct mcp4725_platform_data *pdata)
+{
+	struct device_node *np = dev->of_node;
+	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
+		to_i2c_client(dev)));
+	int err;
+	unsigned vref_mv;
+	unsigned vref_mode = 0;
+
+	if (!np)
+		return -ENODEV;
+
+	err = of_property_read_u32(np, "vref-millivolt", &vref_mv);
+	if (err) {
+		dev_err(dev, "missing or invalid vref-millivolt devicetree data");
+		return err;
+	}
+
+	err = of_property_read_u32(np, "vref-mode", &vref_mode);
+	if (data->id == MCP4725 && !err) {
+		dev_warn(dev, "vref-mode is unavailable on MCP4725");
+		vref_mode = 0;
+	}
+
+	pdata->vref_mv = vref_mv;
+	pdata->vref_mode = vref_mode;
+
+	return 0;
+}
+#else
+static int mcp472x_probe_dt(struct device *dev,
+			    struct mcp4725_platform_data *platform_data)
+{
+	return -ENODEV;
+}
+#endif
+
 static int mcp4725_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct mcp4725_data *data;
 	struct iio_dev *indio_dev;
-	struct mcp4725_platform_data *platform_data = client->dev.platform_data;
+	struct mcp4725_platform_data *pdata = dev_get_platdata(&client->dev);
 	u8 inoutbuf[3];
 	u8 pd;
 	u8 vref;
 	int ret;
 	int err;
 
-	if (!platform_data || !platform_data->vref_mv) {
-		dev_err(&client->dev, "invalid platform data");
-		return -EINVAL;
-	}
-
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (indio_dev == NULL)
 		return -ENOMEM;
@@ -351,12 +386,23 @@ static int mcp4725_probe(struct i2c_client *client,
 	data->client = client;
 	data->id = id->driver_data;
 
-	if (data->id == MCP4725 && platform_data->vref_mode > 0) {
+	if (!dev_get_platdata(&client->dev)) {
+		pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+		err = mcp472x_probe_dt(&client->dev, pdata);
+		if (err) {
+			dev_err(&client->dev, "invalid platform or devicetree data");
+			return err;
+		}
+	}
+
+	if (data->id == MCP4725 && pdata->vref_mode > 0) {
 		dev_warn(&client->dev, "vref mode is unavailable on MCP4725, ignoring");
-		platform_data->vref_mode = 0;
+		pdata->vref_mode = 0;
 	}
 
-	if (data->id == MCP4726 && platform_data->vref_mode > 3) {
+	if (data->id == MCP4726 && pdata->vref_mode > 3) {
 		dev_err(&client->dev, "vref mode is out of range");
 		return -EINVAL;
 	}
@@ -368,8 +414,8 @@ static int mcp4725_probe(struct i2c_client *client,
 	indio_dev->num_channels = 1;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	data->vref_mv = platform_data->vref_mv;
-	data->vref_mode = platform_data->vref_mode;
+	data->vref_mv = pdata->vref_mv;
+	data->vref_mode = pdata->vref_mode;
 
 	/* read current DAC value */
 	err = i2c_master_recv(client, inoutbuf, 3);
@@ -402,6 +448,9 @@ static int mcp4725_probe(struct i2c_client *client,
 			return -EIO;
 	}
 
+	if (!dev_get_platdata(&client->dev))
+		devm_kfree(&client->dev, pdata);
+
 	return iio_device_register(indio_dev);
 }
 
-- 
2.1.4

