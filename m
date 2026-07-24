Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1BF433049
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908534; cv=none; b=fsJitq/y3rSk+y0elY6mwBoD4i8So59/6GNW/dbmHnYPMVlSeZlZ5Ac7noSuMjO3467hzomngz03nMpdzD9uPXjNdEXve3ooL4SyYXjVjLyu53dZ8u+V3QxhDJZS9BFQtH9hkrgmp+MFbH9HyeXzL4A0+t7kB2WlXOYnmo74x4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908534; c=relaxed/simple;
	bh=dcCEzrZwMSfx3DWIcC8GUj8ZmcNyvugLuhei4vuJGKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sNQmCpmHlSHS5mMlAAiggOq5yKWPSjIqwxshm5EIAqrIoqWJyTTCtflbtvo6IpMKfPdy98NcDdN7gMW29dkI+SHjuktXR4MjcZm+0XcsaaUlhfGPQd7DemdSzAOvPW72z7wFw9P+QOQWVGyNvozdzy5N5BzFztsbeSpFNrTSmOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=QImXs0++; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="QImXs0++"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ee37dc91f5so305865a34.3
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784908531; x=1785513331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gFZUN3bOyJenYTXOz12PesK/e4uk1yrjbC3h5hckLZE=;
        b=QImXs0++KH8UsCvffHYMUEy63WrfiyHtL39swTNQGs1uEoSROvs/hUrILtUGPL5CCS
         TMGZ95oE6KhZhlg/6yY/HBSxCImGvMDyaRHYvYnc9yRpJ0aXdarGXwstwk27m1q/mtij
         FlWDdkEj2XSMa8ldle6TlnaYdjHNswb3M0d10nKqXeWOoZuVuQaZbMZ3hYkVQ9DtbEkZ
         nKu08v+g68ldUYK6EDVO2LHsR20m29CVPIZ5T9COamqjPRRz4hNLNRmTCWx1vnpGopyB
         JZoogvyoNBOP2PEByB47eoyr9MNTcyBEPc3G6lr2dPbUUE5JLz7hH/DcdFk+dlRZe6J/
         9BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784908531; x=1785513331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gFZUN3bOyJenYTXOz12PesK/e4uk1yrjbC3h5hckLZE=;
        b=QbHr4+e4Rz6FV9S/SybA0EOuMBVQsKRUxMnPicEiFftARPrxErxDSl3AuSZrj1R24U
         v++mI5bgjr5lAFctSd4rs25y+jfiMgpLZL92ws+Dz2I9739isXTa8BFHZlPPO5/1417d
         7uhQLBcoYVBM/txxQtPusoR6nn94IJXtB+ANTObu5BIZukR8fa1YNC+EgQy9haXljZt4
         +IJJssNhoCprPhUs02IAuYMdU9M9b+dpj+nUAa0yM5qgpoVWe8KCyVsqgjlAndcu0HLo
         KKPP3RiX6m5YChsR+paJ1z6qwhdHpkx5e309KRelLD8o7SU8cK/O8zIESogBgkQd/E+B
         RuUw==
X-Forwarded-Encrypted: i=1; AHgh+Rpzlp91alGvxF8MFLyZLTLh3vIDNa8Z595RKvwtayPbYEWhO8iYxq8AllF1hYbCoJewS/hpUjLX9dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjiS8JC5isdWe9ehHtUJqV0MpdDSTlnoR1SmR0g07pRUY5opsz
	KINtYO1TiEecxoXRmb5KTZ4KrRpiu6L/KheStR7eZNmqqZxkgaVQD/3CuYXiTUq6HyA=
X-Gm-Gg: AR+sD133iNU+XyD23dYUK4hKIEpA+sDrDPa0fPzIuSZQEfD8IyyopreYuud8mlMegn9
	O1U5L0RhB4i/CiGsktH7LZQJdikYQVCD6qD1DQc3E2HVcukAXiH349XTqnpQUkWvzvYToVKWrUr
	NKrp2rR86RMMu+KvrdAs+KbSmYCRj0iEXDc5oPincRLoOgFLguo4fBPd4sMp018ZVL3RoHLOeKF
	f4VTjDb99dy6i/FHar7uAXVCgFxWLn2Teftl4vFP27YwqdqXdqYNGIlS9NXbR79iFYhuG22xBGp
	pkqSDjbCcWJL3e3tHmGCrTQw2hY+/SJbHrQMNm3jQu0aZke0adL+jqRaEqAwLE4hs2Hv3cnufO9
	7/Aq7xqEb5REe2O5AQ01p5B9n+lqvscehbh7U/zDg9PIC3IVsOP533ydOtmND43YMSJTwGtlaJN
	fHmhzvlw==
X-Received: by 2002:a05:6830:3811:b0:7e9:eaf2:ee22 with SMTP id 46e09a7af769-7ee441c4af7mr5475162a34.22.1784908531240;
        Fri, 24 Jul 2026 08:55:31 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b635:d463:c98:cc75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a03eba8sm6160911a34.17.2026.07.24.08.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:55:30 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 24 Jul 2026 10:55:06 -0500
Subject: [PATCH v2 1/2] iio: adc: ti-ads112c14: add support for I2C CRC8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-iio-adc-ti-ads112c14-buffered-read-v2-1-98b06f3d47d9@baylibre.com>
References: <20260724-iio-adc-ti-ads112c14-buffered-read-v2-0-98b06f3d47d9@baylibre.com>
In-Reply-To: <20260724-iio-adc-ti-ads112c14-buffered-read-v2-0-98b06f3d47d9@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7707; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=dcCEzrZwMSfx3DWIcC8GUj8ZmcNyvugLuhei4vuJGKk=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqY4rkVJt4VzKE77SqF2dL5N9xI6w+tQ3kfdTUr
 tz7ezIuh0SJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamOK5AAKCRDCzCAB/wGP
 wOvRB/4v8Ixu5X85dDcdk5PfYz9euxJpR9lG2rB0iL+ytfCQFwVZOWFJRo1owdsOUnuBmbGPLYz
 2KyUpEFDJ7joQJ3xzfaKmYhgipprHsy9bDgzEXT2tJjuSfRTrmOvQ5gMf/hXD8YE9AWsHAzouTZ
 4OoUBW/Ih3sZMnLngF0KZ/4JaTcr5EV6Mvh1vx85lCklk1J/XPh9AwbBUj5fPCp59vCHAOzWKix
 N63mtKCH5n4GPnpixiwFqwHovhoPBsWnJs3HiFSM9OOGm/pe/qxsxOva1whbj3BC+RRh92Hfil8
 SbKxAs5mPiZnZs8fjangv0RGXb33ky9WxfLr3iXl7AL1Zl5v
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for I2C CRC8 to the TI ADS112C14 ADC driver. This verifies
data integrity of all I2C transactions with the device.

For now, it is always enabled, but it could be made optional in the
future if needed (e.g. for higher-speed data acquisition).

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
v2 changes:
* Rebased on iio/testing.
---
 drivers/iio/adc/Kconfig        |   1 -
 drivers/iio/adc/ti-ads112c14.c | 149 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 140 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 642c42b1fae7..4ed6f01386bf 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1802,7 +1802,6 @@ config TI_ADS112C14
 	tristate "Texas Instruments ADS112C14/ADS122C14"
 	depends on I2C
 	select REGMAP
-	select REGMAP_I2C
 	help
 	  If you say yes here you get support for Texas Instruments ADS112C14,
 	  ADS122C14 ADC chips.
diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 3035d45b64b0..80d712049d15 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -10,6 +10,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
+#include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/device/devres.h>
@@ -156,6 +157,9 @@ static const u32 ads112c14_pga_gains_x10[] = {
 	200, 320, 500, 640, 1000, 1280, 2000, 2560,	/* 8 - 15 */
 };
 
+#define ADS112C14_I2C_CRC8_POLYNOMIAL 0x07
+DECLARE_CRC8_TABLE(ads112c14_crc8_table);
+
 struct ads112c14_chip_info {
 	const char *name;
 	u8 device_id;
@@ -241,6 +245,7 @@ struct ads112c14_data {
 	struct regmap *regmap;
 	/* Synchronizes access to register value fields. */
 	struct mutex lock;
+	bool i2c_crc_enabled;
 	u32 avdd_uV;
 	u32 ext_ref_uV;
 	bool refp_is_avdd;
@@ -289,6 +294,120 @@ static const struct reg_default ads112c14_reg_defaults[] = {
 	{ ADS112C14_REG_IDAC_MUX_CFG, FIELD_PREP_CONST(ADS112C14_IDAC_MUX_CFG_I2MUX, 1) },
 };
 
+/**
+ * ads112c14_i2c_read_bytes() - Read bytes from the device over I2C
+ * @client: I2C client for the device
+ * @cmd: Command to send to the device before reading
+ * @buf: Buffer to store the read bytes
+ * @len: Number of bytes to read
+ * @use_crc: Whether to use CRC8 for data integrity check
+ *
+ * If I2C_CRC is enabled, @use_crc may be set to true to perform a CRC8 check
+ * on the received data.
+ */
+static int ads112c14_i2c_read_bytes(struct i2c_client *client, u8 cmd,
+				    u8 *buf, u8 len, bool use_crc)
+{
+	u8 rx_buf[4]; /* Up to 3 data bytes + 1 CRC byte. */
+	u8 rx_len;
+	int ret;
+
+	rx_len = len + (use_crc ? 1 : 0);
+
+	if (rx_len > sizeof(rx_buf))
+		return -EINVAL;
+
+	ret = i2c_smbus_read_i2c_block_data(client, cmd, rx_len, rx_buf);
+	if (ret < 0)
+		return ret;
+
+	if (use_crc) {
+		u8 crc = crc8(ads112c14_crc8_table, rx_buf, len, CRC8_INIT_VALUE);
+
+		if (crc != rx_buf[len])
+			return -EBADMSG;
+	}
+
+	memcpy(buf, rx_buf, len);
+
+	return 0;
+}
+
+/**
+ * ads112c14_regmap_bus_read() - Read a register from the device
+ * @context: Pointer to the device context
+ * @reg_buf: Register address to read
+ * @reg_size: Size of the register address (should be 1)
+ * @val_buf: Buffer to store the read value
+ * @val_size: Size of the value to read
+ *
+ * Custom regmap read function that also does CRC check when enabled.
+ */
+static int ads112c14_regmap_bus_read(void *context, const void *reg_buf,
+				     size_t reg_size, void *val_buf,
+				     size_t val_size)
+{
+	struct ads112c14_data *data = context;
+	struct device *dev = regmap_get_device(data->regmap);
+	struct i2c_client *client = to_i2c_client(dev);
+	const u8 *cmd = reg_buf;
+
+	if (reg_size != 1)
+		return -EINVAL;
+
+	return ads112c14_i2c_read_bytes(client, cmd[0], val_buf, val_size,
+					data->i2c_crc_enabled);
+}
+
+/**
+ * ads112c14_regmap_bus_write() - Write a register to the device
+ * @context: Pointer to the device context
+ * @data_buf: Buffer containing the register address and value to write
+ * @count: Number of bytes to write
+ *
+ * Custom regmap write function that also does readback with CRC check of
+ * nonvolatile registers when CRC is enabled.
+ */
+static int ads112c14_regmap_bus_write(void *context, const void *data_buf,
+				      size_t count)
+{
+	struct ads112c14_data *data = context;
+	struct device *dev = regmap_get_device(data->regmap);
+	struct i2c_client *client = to_i2c_client(dev);
+	const u8 *tx = data_buf;
+	u8 reg, readback;
+	int ret;
+
+	if (count != 2)
+		return -EINVAL;
+
+	ret = i2c_smbus_write_byte_data(client, tx[0], tx[1]);
+	if (ret)
+		return ret;
+
+	reg = tx[0] & ~ADS112C14_CMD_WREG;
+
+	if (!data->i2c_crc_enabled || ads112c14_volatile_reg(dev, reg))
+		return 0;
+
+	ret = ads112c14_i2c_read_bytes(client, reg | ADS112C14_CMD_RREG,
+				       &readback, sizeof(readback), true);
+	if (ret)
+		return ret;
+
+	if (readback != tx[1])
+		return -EIO;
+
+	return 0;
+}
+
+static const struct regmap_bus ads112c14_regmap_bus = {
+	.read = ads112c14_regmap_bus_read,
+	.write = ads112c14_regmap_bus_write,
+	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
+	.val_format_endian_default = REGMAP_ENDIAN_BIG,
+};
+
 static const struct regmap_config ads112c14_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -486,13 +605,9 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 	if (ret)
 		return ret;
 
-	ret = i2c_smbus_read_i2c_block_data(client, ADS112C14_CMD_RDATA,
-					    BITS_TO_BYTES(data->chip_info->resolution_bits),
-					    buf);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return ads112c14_i2c_read_bytes(client, ADS112C14_CMD_RDATA, buf,
+					BITS_TO_BYTES(data->chip_info->resolution_bits),
+					data->i2c_crc_enabled);
 }
 
 static int ads112c14_read_raw(struct iio_dev *indio_dev,
@@ -1121,7 +1236,8 @@ static int ads112c14_probe(struct i2c_client *client)
 	/* It takes some time for the internal reference to stabilize. */
 	fsleep(10 * USEC_PER_MSEC);
 
-	data->regmap = devm_regmap_init_i2c(client, &ads112c14_regmap_config);
+	data->regmap = devm_regmap_init(dev, &ads112c14_regmap_bus, data,
+					&ads112c14_regmap_config);
 	if (IS_ERR(data->regmap))
 		return dev_err_probe(dev, PTR_ERR(data->regmap),
 				     "failed to init regmap\n");
@@ -1158,6 +1274,14 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DIGITAL_CFG,
+				 ADS112C14_DIGITAL_CFG_I2C_CRC_EN,
+				 ADS112C14_DIGITAL_CFG_I2C_CRC_EN);
+	if (ret)
+		return ret;
+
+	data->i2c_crc_enabled = true;
+
 	ret = regmap_read(data->regmap, ADS112C14_REG_DEVICE_ID, &reg_val);
 	if (ret)
 		return ret;
@@ -1209,6 +1333,13 @@ static const struct i2c_device_id ads112c14_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ads112c14_id);
 
+static int ads112c14_i2c_add_driver(struct i2c_driver *driver)
+{
+	crc8_populate_msb(ads112c14_crc8_table, ADS112C14_I2C_CRC8_POLYNOMIAL);
+
+	return i2c_add_driver(driver);
+}
+
 static struct i2c_driver ads112c14_driver = {
 	.driver = {
 		.name = "ads112c14",
@@ -1217,7 +1348,7 @@ static struct i2c_driver ads112c14_driver = {
 	.probe = ads112c14_probe,
 	.id_table = ads112c14_id,
 };
-module_i2c_driver(ads112c14_driver);
+module_driver(ads112c14_driver, ads112c14_i2c_add_driver, i2c_del_driver);
 
 MODULE_AUTHOR("David Lechner (TI) <dlechner@baylibre.com>");
 MODULE_DESCRIPTION("TI ADS112C14 I2C ADC driver");

-- 
2.43.0

