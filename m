Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988EA313E36
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161457; cv=none; b=Xbvn6vnvXLbR6l69KOPgIPf2SbPjbIQRz7aZXblM3vZxh8oUkE2llhhi9d7Jt8kDJ4SreZWv/jxJdORF7O/JNzKVxLnN1e65aOpmNvI+nz4mn6j4c91dJCpXQ7AxGj1yCVSrE5NNbrFydIwnvM5V4AIw0aAniqGJIHHrhgjPBh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161457; c=relaxed/simple;
	bh=uWnAP2LbvdcP6Yf+1fF1qrKIY2JUdai3OgzS72ukHqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oYF1xqMN6ZAxNhuOmFzNb87UNg0E25C9JUILpRm0pC0nYbVQXgaEiuBxsRX57NZKdjKF1i2LKZ6jykHHsJzGi+aMpHuWYipvCKKEYrsNNfZ4GtTKrnd2ENEkqYhPil+dgokeVZtZ4hxfPoe1ntVW5uG0CUgiU8HDCW0eymqdoR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LGbecNtz; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LGbecNtz"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6a198cdc4e4so1198995eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785161444; x=1785766244; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MfP6H4Bb4FYzzCvuX4aX45TcJpR2nYosbcwMTiIpNho=;
        b=LGbecNtz7XAtRicaZ7vY7J35bpqQfZo3dNsnkHdHqceDLKaa/KQ1tr/Q3zL79pVbkH
         AIihpPvd3wH5cgl5oUg7Etxk4pZSO15QhcoJjdhI/s1MMOz4xkFEBikfWxOL1ehWP8jj
         Ud3yqIKR7Q9jMyEpylSkeHs+Xb3CphSkws0uTchcIg0IHTAcrrIeenlpDjuFsxpzVUD5
         pPgsTIzHK85GmfwJ8q3DMoixW79yjDY34sui9gTP+P/hffXnSxIQfuw9FCIGv2VItK2b
         ZKhH+3jimzf9N6DQzpY9netx/rN+NLkcKyuV8NbaGUypvR3SLq1IGxfJ2AwK6zl7z2aD
         FC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785161444; x=1785766244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MfP6H4Bb4FYzzCvuX4aX45TcJpR2nYosbcwMTiIpNho=;
        b=mclYfLfTwp6oKzLYtTQQc/bY/cjoqdyeIMVAWtUFKQxGuO2rfE03xo5fa+9NCh0H3x
         eSPIKQRmi6ojHAV8er1kUNRPbSuf6eACa+22f/yMxme8+dM5ribTajRY8NwSLJyuAslU
         wWCwl4AmPc2g5vwOZ1Kdj3zpenuy6p2O51OjkZDs1EZ7PEQWdxj9aaoYpmfJuUgsaNb2
         tPAvqoxSO82olEPVGCmRAs48SyOd79m+cNg/B1BjtaaIzvVY9jkTBDo/Y7zGUjY0KjmP
         axsVH73d5nvfKrqALeK9ZeBXBrnDaepJdiANeu4S2eNrrMSLeVMveHx3OgtBsjbZQPfO
         axqw==
X-Forwarded-Encrypted: i=1; AHgh+RrZlHJwAfWxzrixnhfTkzBmYbMUK21EGVjOHiOyc9BFi71GtDcKsqMxzA3koUjSdCGVKT1cw1Cr7uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk2Aga2/ZUkTNhFDlzJPuaLEvSYwPWn1YRpikB2X5WBzz/+/G5
	seb6oDKJE6tttxT7seNSoEJyycMDoO8AGC2lEqPt3ZXJ5w++YWFQvkBHDezC393r5iM=
X-Gm-Gg: AR+sD11GNC2GVojUWYC1oFkJaY+OES0rjwEdUKaq1OWudCdslE13N3ph9Pat4v85AM4
	tvGuPBnn44hh7j7yLbdYox7X6ahDmmbelqZr2qDEhBGP4r5EER32f1tWqCl7ajBQp07xY6unJtr
	lxvvy+GNMdYbphSC/057l4cN0EjHtLIu8JbXHU9BgcvTMiiAk7Ec9a9+Mr3Hr906t7oDaAohrkL
	RaXoOSOtL5bFBn48ZNOpLRtZ56nYTHy6wyhJ5jEAYVBUiNSQndoCenZxfigcgrQVGdTeJdPHNxu
	a42DimP6YNBHFzuqojU1eh/Njq2DdKebBdAY62aAxX/xZcOdpJNLSYBVo5+/0FBneQKkWSiHUaO
	HBP1WlFoDJrZ/RUBGCt8DP1dGDVQMjkNowkE1az0ybrpaXsuJXsh6VQcRBd0tHpSDGKB/fxrz+3
	LNZn3qiqY=
X-Received: by 2002:a05:6820:824:b0:6ab:140a:7d82 with SMTP id 006d021491bc7-6ab140a830fmr4106007eaf.67.1785161443930;
        Mon, 27 Jul 2026 07:10:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:41b4:f2ef:8a0a:2104])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45767486cf6sm15998645fac.15.2026.07.27.07.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:10:42 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Mon, 27 Jul 2026 09:09:50 -0500
Subject: [PATCH v3 1/2] iio: adc: ti-ads112c14: add support for I2C CRC8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-iio-adc-ti-ads112c14-buffered-read-v3-1-cbbcaf030148@baylibre.com>
References: <20260727-iio-adc-ti-ads112c14-buffered-read-v3-0-cbbcaf030148@baylibre.com>
In-Reply-To: <20260727-iio-adc-ti-ads112c14-buffered-read-v3-0-cbbcaf030148@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7814; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=uWnAP2LbvdcP6Yf+1fF1qrKIY2JUdai3OgzS72ukHqg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqZ2bShnUN6p2nm1FoyE/5pam7g1ph7Kq/Bfm1a
 Pji76YoN26JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamdm0gAKCRDCzCAB/wGP
 wH8UCACMwPe0MGoY5TThgLlmB/zDanS5ypH2LNsycrU2iVL34MxxNke1tlPeVrkVFXlrHOO1ZF9
 ryiRMVJQIjHX49A8w2sUJoItHSrlAFfyggTuvrs873HgwKQuKiohOha2kVVR8EWkNpGTFDjhWgC
 rjzaZ//F+LIwfv285y4cZgnrETboHwmDPvftHURusbhW6XkPrJmeaLLCz1UkH3MRp4HxrgZwfB8
 9jt4rJ59fPPL7F+7e0cIUvI87FZRCli3oUD7cdB7B9LhkswXwCyG8aNWAwNhdq528yMh75WgZLI
 3Br017uW/IedQ7ey3umE4VqgpuisE3zw7NIet1vYrSxLJUkc
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for I2C CRC8 to the TI ADS112C14 ADC driver. This verifies
data integrity of all I2C transactions with the device.

For now, it is always enabled, but it could be made optional in the
future if needed (e.g. for higher-speed data acquisition).

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---

v3 changes:
* Add select CRC8 to Kconfig.
* Use regmap_set_bits() for ADS112C14_DIGITAL_CFG_I2C_CRC_EN.

v2 changes:
* Rebased on iio/testing.
---
 drivers/iio/adc/Kconfig        |   2 +-
 drivers/iio/adc/ti-ads112c14.c | 148 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 140 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 642c42b1fae7..b043c00f8939 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1801,8 +1801,8 @@ config TI_ADS1119
 config TI_ADS112C14
 	tristate "Texas Instruments ADS112C14/ADS122C14"
 	depends on I2C
+	select CRC8
 	select REGMAP
-	select REGMAP_I2C
 	help
 	  If you say yes here you get support for Texas Instruments ADS112C14,
 	  ADS122C14 ADC chips.
diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 3035d45b64b0..5610d16f4467 100644
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
@@ -1158,6 +1274,13 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ret = regmap_set_bits(data->regmap, ADS112C14_REG_DIGITAL_CFG,
+			      ADS112C14_DIGITAL_CFG_I2C_CRC_EN);
+	if (ret)
+		return ret;
+
+	data->i2c_crc_enabled = true;
+
 	ret = regmap_read(data->regmap, ADS112C14_REG_DEVICE_ID, &reg_val);
 	if (ret)
 		return ret;
@@ -1209,6 +1332,13 @@ static const struct i2c_device_id ads112c14_id[] = {
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
@@ -1217,7 +1347,7 @@ static struct i2c_driver ads112c14_driver = {
 	.probe = ads112c14_probe,
 	.id_table = ads112c14_id,
 };
-module_i2c_driver(ads112c14_driver);
+module_driver(ads112c14_driver, ads112c14_i2c_add_driver, i2c_del_driver);
 
 MODULE_AUTHOR("David Lechner (TI) <dlechner@baylibre.com>");
 MODULE_DESCRIPTION("TI ADS112C14 I2C ADC driver");

-- 
2.43.0

