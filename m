Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hosting.pavoucek.net ([46.28.107.168]:59481 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933065AbcI3N0m (ORCPT
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
Subject: [PATCH 1/3] iio: dac: mcp4725: support voltage reference selection
Date: Fri, 30 Sep 2016 15:19:46 +0200
Message-Id: <1475241588-18429-2-git-send-email-tomas@novotny.cz>
In-Reply-To: <1475241588-18429-1-git-send-email-tomas@novotny.cz>
References: <1475241588-18429-1-git-send-email-tomas@novotny.cz>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

MCP47x6 chip supports selection of a voltage reference (VDD, VREF buffered
or unbuffered). MCP4725 doesn't have this feature thus the setting is
ignored and user is warned if there is an attempt to set a value other than
zero.

The setting is stored only in the volatile memory of the chip. You need to
manually store it to the EEPROM of the chip via 'store_eeprom' sysfs entry.

Signed-off-by: Tomas Novotny <tomas@novotny.cz>
---
 drivers/iio/dac/mcp4725.c       | 45 +++++++++++++++++++++++++++++++++++++----
 include/linux/iio/dac/mcp4725.h |  1 +
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index cca935c..f8e54f1 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -28,7 +28,9 @@
 
 struct mcp4725_data {
 	struct i2c_client *client;
+	int id;
 	u16 vref_mv;
+	unsigned vref_mode;
 	u16 dac_value;
 	bool powerdown;
 	unsigned powerdown_mode;
@@ -86,6 +88,7 @@ static ssize_t mcp4725_store_eeprom(struct device *dev,
 		return 0;
 
 	inoutbuf[0] = 0x60; /* write EEPROM */
+	inoutbuf[0] |= data->vref_mode << 3;
 	inoutbuf[1] = data->dac_value >> 4;
 	inoutbuf[2] = (data->dac_value & 0xf) << 4;
 
@@ -329,8 +332,10 @@ static int mcp4725_probe(struct i2c_client *client,
 	struct mcp4725_data *data;
 	struct iio_dev *indio_dev;
 	struct mcp4725_platform_data *platform_data = client->dev.platform_data;
-	u8 inbuf[3];
+	u8 inoutbuf[3];
 	u8 pd;
+	u8 vref;
+	int ret;
 	int err;
 
 	if (!platform_data || !platform_data->vref_mv) {
@@ -344,6 +349,17 @@ static int mcp4725_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
+	data->id = id->driver_data;
+
+	if (data->id == MCP4725 && platform_data->vref_mode > 0) {
+		dev_warn(&client->dev, "vref mode is unavailable on MCP4725, ignoring");
+		platform_data->vref_mode = 0;
+	}
+
+	if (data->id == MCP4726 && platform_data->vref_mode > 3) {
+		dev_err(&client->dev, "vref mode is out of range");
+		return -EINVAL;
+	}
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->name = id->name;
@@ -353,17 +369,38 @@ static int mcp4725_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	data->vref_mv = platform_data->vref_mv;
+	data->vref_mode = platform_data->vref_mode;
 
 	/* read current DAC value */
-	err = i2c_master_recv(client, inbuf, 3);
+	err = i2c_master_recv(client, inoutbuf, 3);
 	if (err < 0) {
 		dev_err(&client->dev, "failed to read DAC value");
 		return err;
 	}
-	pd = (inbuf[0] >> 1) & 0x3;
+	pd = (inoutbuf[0] >> 1) & 0x3;
 	data->powerdown = pd > 0 ? true : false;
 	data->powerdown_mode = pd ? pd - 1 : 2; /* largest register to gnd */
-	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
+	data->dac_value = (inoutbuf[1] << 4) | (inoutbuf[2] >> 4);
+	vref = inoutbuf[0] >> 3 & 0x3;
+
+	if (data->id == MCP4726 && vref != data->vref_mode) {
+		dev_info(&client->dev,
+			"vref_mode differs (conf: %d, eeprom: %d), setting %d",
+			data->vref_mode, vref, data->vref_mode);
+
+		inoutbuf[0] = 0x40;
+		inoutbuf[0] |= data->vref_mode << 3;
+		if (data->powerdown)
+			inoutbuf[0] |= data->powerdown << 1;
+		inoutbuf[1] = data->dac_value >> 4;
+		inoutbuf[2] = (data->dac_value & 0xf) << 4;
+
+		ret = i2c_master_send(data->client, inoutbuf, 3);
+		if (ret < 0)
+			return ret;
+		else if (ret != 3)
+			return -EIO;
+	}
 
 	return iio_device_register(indio_dev);
 }
diff --git a/include/linux/iio/dac/mcp4725.h b/include/linux/iio/dac/mcp4725.h
index 91530e6..370022b 100644
--- a/include/linux/iio/dac/mcp4725.h
+++ b/include/linux/iio/dac/mcp4725.h
@@ -11,6 +11,7 @@
 
 struct mcp4725_platform_data {
 	u16 vref_mv;
+	unsigned vref_mode;
 };
 
 #endif /* IIO_DAC_MCP4725_H_ */
-- 
2.1.4

