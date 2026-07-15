Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C621E8342
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074805; cv=none; b=UpP7etJWCSwwiJO0yhBQf9E8U35ULVfYG/YBcYyKhQ0uWw5cY96BdZ1EclI+TQbLhlY7sRY34ZgIdGPZlQ/NzVu0/m1G7d+QKFv8D2aEEX6qe5Wa6Ums2vffcpWMbGsDZl4ULSU1HjyEup3AXchl2pBDLPud/DS2/4Ey6PrpyJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074805; c=relaxed/simple;
	bh=HFTM3kcFI3bgzN5pSwcDunfYHR7FvwBroXaFieoNilQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MUcViLldybjdfVPIKDK8Bw0AYg0CqKo+TuTGZjwIw/slQwZO1A0VJ4lUSy2Sl6oHnkywlySSW4nuXh5tFC11RBYj4W4QmRtc9+CXBTAdrmLDH2XjuDcpXNz1mSJ7T29QsnEiFl/dTd46AjLnpQo+UL/d5eDaLKg1GptMjQ7xNgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=DTlEv/Ds; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="DTlEv/Ds"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-44cedfaab6bso2098273fac.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 17:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784074803; x=1784679603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JBQ6GE5MoRSLlPltdoc6w/vidWV64cNB5l6S7LWSYEI=;
        b=DTlEv/DsMucFwVA651q2uUIlEf3AWzfJvK6UsSP/vE34ekSqAAS7GhqOlzUsv39eSO
         VW595V3FkeIfVikEgEe2gZqSq0nanMRJqyFhUfx8YfNCKReYbnEA0T/Gr0q+aQE40ak+
         zWWrhSWGXwtAvleD/j6aHhw2Wy9z4Iwwf8iSbY91Qj2GtrRKEpzBDk8JeCVdi0W3AI2Q
         PD6KXfuRl8lG/Nye+OLen7kbYwGpbJbe1ttfIxpSfVuSLQP0Q0fH8x2u2WHpNhwbxfFr
         XX2edC41VX5p02pyzGsBLyYKNxcDXyxTNcey5rAoE5wWP8VIWi1KWb9Fp6yfMr+JIOFg
         lEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784074803; x=1784679603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JBQ6GE5MoRSLlPltdoc6w/vidWV64cNB5l6S7LWSYEI=;
        b=MlK2N+daLRwDuqVaq09OSyuJatNcygg4VCq5WVCclSlGkyC04XUSlyw2qmW+bphbNI
         ZPXkJehAxBOrspDgLLavbGsL/chWWY7FeCJ2e+5ECjH/IpiDEwDG1X2WEXcD8+lST7SS
         mIZ3lTSDTkSn53pNtJJjTgR5ez03Rv/5woZycyaIRGD6VEFDuWl+svjkxY9XWEfMk7Py
         HQcqMYAqxpXlMDA8yKgm8izunzGbtHDc7VCAHDJWj5t863P+WbBIAgJk1FKme2ko3XDt
         eltn35hgPn3v0ns5Nf2Cj7GQGR2QOsOzUCj9uh6OhL23KgC5Kwn0eh4gnQC2r21WBrTF
         6SGg==
X-Forwarded-Encrypted: i=1; AHgh+RoIwJszji4nN1TDQtdA8mLdQu4kGnBxrqH7ihkyknJBHm3HzN/GyoVcboIu6UnNFLM9KdYpa9oQEEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAVjw6DzHh8HlAma5GrrDwCNEVgt+kW3IZajQ6KtDWO722kFFq
	jECt98FDJi2jdBzKhmDbNptCRmXT1R9Ct5Cg6bo+3Q81nrTr3HZdVHXDXqHmz/WZWEox502lbin
	mfDXI
X-Gm-Gg: AfdE7cmBJv8+7JfPkSP89sVV+Z2xipECez7UDVM22mEu/m9LRNKiTnUWE+lRroSKepE
	gG0PiKDcZGf7Ubha7gwAFVP675MCX1byOoi6if4QhICuGrQ4iTgogqCuJ1oSsJWPrpRliU9X12F
	VbWEBOKrK+3kgO1eeVFy/zzOBKX8mnyV1v0L6HTGcc79lCpL1Tavc+TvN6huR3z1kB4+LmgM3i2
	/ZtcAAoiAKQZyi5KnYcloSEXrT6p6J+1wPuiCHhK7NqTlUsmVIjsCEG4wZ5kTjbXCO0VWFV6hHj
	BJj2iksml5MQvW4nDKT3Ic/PKhA3ZAZhYGoHXzJL3oJefq5120h7yV1d/VSEF9OSFJJYHsf/6kv
	BlF/vmkl3g8qN+Ex9dW9iR126IU+AkmBKlukyUD89XRYnqB6un1JJTD86xKM5Wa/fGZHn4fpFGJ
	NQAhnzy8PHXwjA54xb7w==
X-Received: by 2002:a05:6870:2885:b0:455:d4ba:1dc6 with SMTP id 586e51a60fabf-4562b21f1ecmr585764fac.5.1784074802941;
        Tue, 14 Jul 2026 17:20:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-455b767413dsm8047305fac.3.2026.07.14.17.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 17:20:02 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Tue, 14 Jul 2026 19:19:31 -0500
Subject: [PATCH 2/3] iio: adc: ti-ads112c14: add support for I2C CRC8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-2-fe6e1c971288@baylibre.com>
References: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-0-fe6e1c971288@baylibre.com>
In-Reply-To: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-0-fe6e1c971288@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7615; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=HFTM3kcFI3bgzN5pSwcDunfYHR7FvwBroXaFieoNilQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqVtIje8YQ+6c9D8EmeEsx1FWFFibWdlqTR145m
 UNDb0slsMWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalbSIwAKCRDCzCAB/wGP
 wDkdB/9B+9BPJSWFcjpnZ8CL1WwNsx+NPMLDzKecvcCGHah8jZtUmIZNJG1rWqCIzX83z1dKotf
 b+eXiWcS+6+3Kda6gLSqM0a7M7gaNKECRjG0CD7FjfQzEtDBon3DOTfbslSYd5fDLxho+pRQS8b
 eJ0mctfvhhzIUsRtZVk78Liu04fF7jPdQThTWjNoJzmj+tawDScRH2CwhrgTZkqOsAbfOf3DQM4
 06g3zvdWncpJCx3GxVKkzw4S9O8VkOC6pNkYc82viPhL0Xs430LoYET76yfjovjSWB0sgkD66XE
 HYn3dCJTlfUFIP1tQ4CV7sj7VVApXpJUNOVE6SmOTpzDnSNC
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for I2C CRC8 to the TI ADS112C14 ADC driver. This verifies
data integrity of all I2C transactions with the device.

For now, it is always enabled, but it could be made optional in the
future if needed (e.g. for higher-speed data acquisition).

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/Kconfig        |   1 -
 drivers/iio/adc/ti-ads112c14.c | 145 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 140 insertions(+), 6 deletions(-)

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
index 28824c81908e..99ccacd6d56f 100644
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
@@ -486,9 +605,9 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 	if (ret)
 		return ret;
 
-	return i2c_smbus_read_i2c_block_data(client, ADS112C14_CMD_RDATA,
-					     BITS_TO_BYTES(data->chip_info->resolution_bits),
-					     buf);
+	return ads112c14_i2c_read_bytes(client, ADS112C14_CMD_RDATA, buf,
+					BITS_TO_BYTES(data->chip_info->resolution_bits),
+					data->i2c_crc_enabled);
 }
 
 static int ads112c14_read_raw(struct iio_dev *indio_dev,
@@ -1117,7 +1236,8 @@ static int ads112c14_probe(struct i2c_client *client)
 	/* It takes some time for the internal reference to stabilize. */
 	fsleep(10 * USEC_PER_MSEC);
 
-	data->regmap = devm_regmap_init_i2c(client, &ads112c14_regmap_config);
+	data->regmap = devm_regmap_init(dev, &ads112c14_regmap_bus, data,
+					&ads112c14_regmap_config);
 	if (IS_ERR(data->regmap))
 		return dev_err_probe(dev, PTR_ERR(data->regmap),
 				     "failed to init regmap\n");
@@ -1154,6 +1274,14 @@ static int ads112c14_probe(struct i2c_client *client)
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
@@ -1205,6 +1333,13 @@ static const struct i2c_device_id ads112c14_id[] = {
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
@@ -1213,7 +1348,7 @@ static struct i2c_driver ads112c14_driver = {
 	.probe = ads112c14_probe,
 	.id_table = ads112c14_id,
 };
-module_i2c_driver(ads112c14_driver);
+module_driver(ads112c14_driver, ads112c14_i2c_add_driver, i2c_del_driver);
 
 MODULE_AUTHOR("David Lechner (TI) <dlechner@baylibre.com>");
 MODULE_DESCRIPTION("TI ADS112C14 I2C ADC driver");

-- 
2.43.0

