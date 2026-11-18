Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009587;
	b=fGEUv/S1Kfpa+cs1KBqBtjRgWOomoClXE4yC/hSDxwixZ5MRXJGv+oAx/am7qPSxi4C5
	 TD38V+WXOOfkBBBZf1oWWOvfstvMTdOtLx54uPzpxvEVA/c7JV/ZLKOqHf752fw9mInQb
	 EsdUkUnV+woX2wCEtsw6P7sIZdXkEUiaZeaX0DrkKn2gQK8nyJBoI36jcmD0Jfo3ywkEx
	 pr+0fbEn0s5s3Ad5fYE4nGZ2TxwkqXaOPvkZBcqBaD5XZ//hRFtApT1mcenN5sgPlvYed
	 9kzI+j4Qy4xgHtNIUtO7OZZAzKAHQWQfeyLxVEviX70+OcCG5fNne85gWaNTF6eWN2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009587;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=n4oiwp+T/VtLCLAvvQaSEXLTXlko0bhSUJdlY59Zdvk=;
	b=r3V/c0p3TvkwJX2qivIvMYVBC0mwrnRw8MKek+S8ruNKRrVehxVnJU99+77qq6iy6ejM
	 Y7VK9EeG0FePzo8Bk4XrJ1QsiytYhUcdibWjU9j5rMT8d316Eh4EXKaQOznIMEVtWVIDJ
	 IfUbzDa+Hrf8SUSCtYRZG9FypFQD/BvxO2EHFC0mgwdbAIKDitHqUuO54UQ2334m4wdm9
	 dqftPkIm9w/VjFCZIumSlcrxdhKbNDb+8hsG1KE8j6XxbosNaTIPSIKpaQ/EWFc1vtEH3
	 bOMdhPqSVFoXELCJJ5TKPJUT648F4Z6fzYkuThfzWX0Khidx0v3cJRMggiXVYIjLrzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GyMSD6os;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E917606A320;
	Wed, 18 Nov 2026 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GyMSD6os
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CDC1F000C9;
	Wed, 18 Nov 2026 13:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795009586;
	bh=n4oiwp+T/VtLCLAvvQaSEXLTXlko0bhSUJdlY59Zdvk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GyMSD6os8ALDzwyecOn8ysyfqd0qvHpJtM3MseVQdLvGnpRwK03xb1RLqh5MVYDrf
	 lDVjkScu/e3avgO7lfF0+dvzSU/dOEmSU2dulvB/eRLpb+bf25+v0e7TBjz0OO4AvK
	 ABPNWpVn23wbhOY/bsE8N4Ynb8dQ9IAR1+6ixlqMJJwmJpnw+j3xWtkRewaoF/fo5r
	 7XNOW3JMuMmtq9OPNiPeJcO7FoFwA1MiaRpXv1n/SiBLqgVWaYJ4lFc1Rt5hDIOYuD
	 KyLKgzx+aJueS5aYGiYCjFF15Py3DQxTg+lA8ebmk2UrlNfayWuGUz9IYpn4GbDpSg
	 eCBSeZgA7qt9g==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 18 Nov 2026 14:46:12 +0100
Subject: [PATCH v3 5/5] iio: light: gp2ap020a00f: Add GP2AP030A00F support
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-gp2ap030-v3-5-c8df93460110@kernel.org>
References: <20261118-gp2ap030-v3-0-c8df93460110@kernel.org>
In-Reply-To: <20261118-gp2ap030-v3-0-c8df93460110@kernel.org>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>
Cc: devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.16.0

The GP2AP030A00F has the same register addresses and interrupt modes
as the GP2AP020A00F, but does not implement its automatic
illuminance calculation or selectable ambient-light cancellation.

Datasheet: https://jp.sharp/products/device/doc/opto/gp2ap030a00f_appl_e.pdf
Reviewed-by: Joshua Crofts <crofts@kernel.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/iio/light/Kconfig        |   6 +--
 drivers/iio/light/gp2ap020a00f.c | 109 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 462fff1ddef2..49df1210405e 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -259,15 +259,15 @@ config GP2AP002
 	  module will be called gp2ap002.
 
 config GP2AP020A00F
-	tristate "Sharp GP2AP020A00F Proximity/ALS sensor"
+	tristate "Sharp GP2AP020A00F and similar proximity/ALS sensors"
 	depends on I2C
 	select REGMAP_I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	select IRQ_WORK
 	help
-	  Say Y here if you have a Sharp GP2AP020A00F proximity/ALS combo-chip
-	  hooked to an I2C bus.
+	  Say Y here to enable support for the Sharp GP2AP020A00F and
+	  GP2AP030A00F proximity/ALS combo-chips hooked to an I2C bus.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called gp2ap020a00f.
diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 5c8ad1ed6c18..5d9daebc2af0 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1,12 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
+ * Sharp GP2AP020A00F and similar proximity/ALS sensors
+ *
  * Copyright (C) 2013 Samsung Electronics Co., Ltd.
  * Author: Jacek Anaszewski <j.anaszewski@samsung.com>
  *
  * IIO features supported by the driver:
  *
  * Read-only raw channels:
- *   - illuminance_clear [lux]
+ *   - illuminance_clear [lux on GP2AP020A00F, raw counts on GP2AP030A00F]
  *   - illuminance_ir
  *   - proximity
  *
@@ -54,6 +56,11 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
+/*
+ * The GP2AP030A00F shares the register layout, but has no TYPE or ALC bit.
+ * Its D0 and D1 registers always contain raw clear and infrared counts.
+ */
+
 /* Registers */
 #define GP2AP020A00F_OP_REG	0x00 /* Basic operations */
 #define GP2AP020A00F_ALS_REG	0x01 /* ALS related settings */
@@ -137,6 +144,7 @@
 #define GP2AP020A00F_RES_P_6_25ms_x2	0x28
 #define GP2AP020A00F_RES_P_1_56ms_x2	0x30
 #define GP2AP020A00F_RES_P_0_39ms_x2	0x38
+#define GP2AP030A00F_RES_P_1_56ms_x2	0x18
 #define GP2AP020A00F_RANGE_P_MASK	0x07 /* PS: Max measurable range */
 #define GP2AP020A00F_RANGE_P_x1		0x00
 #define GP2AP020A00F_RANGE_P_x2		0x01
@@ -158,6 +166,7 @@
 #define GP2AP020A00F_IS_27_5mA		0x10
 #define GP2AP020A00F_IS_55mA		0x20
 #define GP2AP020A00F_IS_110mA		0x30
+#define GP2AP030A00F_IS_130mA		0x30
 #define GP2AP020A00F_PIN_MASK		0x0c /* INT terminal setting */
 #define GP2AP020A00F_PIN_ALS_OR_PS	0x00
 #define GP2AP020A00F_PIN_ALS		0x04
@@ -239,6 +248,7 @@ struct gp2ap020a00f_chip_info {
 	const u8 *reg_init_tab;
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
+	bool has_als_auto;
 };
 
 struct gp2ap020a00f_data {
@@ -276,6 +286,17 @@ static const u8 gp2ap020a00f_reg_init_tab[] = {
 	[GP2AP020A00F_PH_H_REG] = 0,
 };
 
+static const u8 gp2ap030a00f_reg_init_tab[ARRAY_SIZE(gp2ap020a00f_reg_init_tab)] = {
+	[GP2AP020A00F_OP_REG] = GP2AP020A00F_OP3_SHUTDOWN,
+	[GP2AP020A00F_ALS_REG] = GP2AP020A00F_RES_A_100ms |
+				 GP2AP020A00F_RANGE_A_x8,
+	[GP2AP020A00F_PS_REG] = GP2AP030A00F_RES_P_1_56ms_x2 |
+				GP2AP020A00F_RANGE_P_x4,
+	[GP2AP020A00F_LED_REG] = GP2AP020A00F_INTVAL_0 |
+				 GP2AP030A00F_IS_130mA |
+				 GP2AP020A00F_FREQ_327_5kHz,
+};
+
 static bool gp2ap020a00f_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -371,6 +392,7 @@ static const struct gp2ap020a00f_mutable_config_regs {
 static int gp2ap020a00f_set_operation_mode(struct gp2ap020a00f_data *data,
 					enum gp2ap020a00f_opmode op)
 {
+	u8 op_reg = opmode_regs_settings[op].op_reg;
 	unsigned int op_reg_val;
 	int err;
 
@@ -409,12 +431,16 @@ static int gp2ap020a00f_set_operation_mode(struct gp2ap020a00f_data *data,
 			return err;
 	}
 
+	if (!data->chip_info->has_als_auto)
+		op_reg = (op_reg & ~GP2AP020A00F_TYPE_MASK) |
+			 GP2AP020A00F_TYPE_MANUAL_CALC;
+
 	/* Set OP_REG and apply operation mode (power on / off) */
 	err = regmap_update_bits(data->regmap,
 				 GP2AP020A00F_OP_REG,
 				 GP2AP020A00F_OP_MASK | GP2AP020A00F_OP2_MASK |
 				 GP2AP020A00F_OP3_MASK | GP2AP020A00F_TYPE_MASK,
-				 opmode_regs_settings[op].op_reg);
+				 op_reg);
 	if (err < 0)
 		return err;
 
@@ -446,6 +472,8 @@ static int gp2ap020a00f_write_event_threshold(struct gp2ap020a00f_data *data,
 
 	if (!enable)
 		thresh_reg_val = 0;
+	else if (!data->chip_info->has_als_auto)
+		thresh_reg_val = min(data->thresh_val[th_val_id], 65535U);
 	else if (test_bit(GP2AP020A00F_FLAG_LUX_MODE_HI, &data->flags) &&
 		 th_val_id != GP2AP020A00F_THRESH_PL &&
 		 th_val_id != GP2AP020A00F_THRESH_PH)
@@ -709,6 +737,10 @@ static bool gp2ap020a00f_adjust_lux_mode(struct gp2ap020a00f_data *data,
 	u8 new_range = 0xff;
 	int err;
 
+	/* GP2AP030A00F thresholds and samples are raw counts at a fixed range. */
+	if (!data->chip_info->has_als_auto)
+		return false;
+
 	if (!test_bit(GP2AP020A00F_FLAG_LUX_MODE_HI, &data->flags)) {
 		if (output_val > 16000) {
 			set_bit(GP2AP020A00F_FLAG_LUX_MODE_HI, &data->flags);
@@ -960,8 +992,9 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
 		if (ret < 0)
 			goto done;
 
-		if (i == GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR ||
-		    i == GP2AP020A00F_SCAN_MODE_LIGHT_IR) {
+		if (priv->chip_info->has_als_auto &&
+		    (i == GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR ||
+		     i == GP2AP020A00F_SCAN_MODE_LIGHT_IR)) {
 			out_val = get_unaligned_le16(&priv->buffer[d_size]);
 			gp2ap020a00f_output_to_lux(priv, &out_val);
 			put_unaligned_le32(out_val, &priv->buffer[d_size]);
@@ -1317,11 +1350,68 @@ static const struct iio_chan_spec gp2ap020a00f_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(GP2AP020A00F_CHAN_TIMESTAMP),
 };
 
+static const struct iio_chan_spec gp2ap030a00f_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.channel2 = IIO_MOD_LIGHT_CLEAR,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+		.scan_index = GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR,
+		.address = GP2AP020A00F_D0_L_REG,
+		.event_spec = gp2ap020a00f_event_spec_light,
+		.num_event_specs = ARRAY_SIZE(gp2ap020a00f_event_spec_light),
+	},
+	{
+		.type = IIO_LIGHT,
+		.channel2 = IIO_MOD_LIGHT_IR,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+		.scan_index = GP2AP020A00F_SCAN_MODE_LIGHT_IR,
+		.address = GP2AP020A00F_D1_L_REG,
+	},
+	{
+		.type = IIO_PROXIMITY,
+		.modified = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+		.scan_index = GP2AP020A00F_SCAN_MODE_PROXIMITY,
+		.address = GP2AP020A00F_D2_L_REG,
+		.event_spec = gp2ap020a00f_event_spec_prox,
+		.num_event_specs = ARRAY_SIZE(gp2ap020a00f_event_spec_prox),
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(GP2AP020A00F_CHAN_TIMESTAMP),
+};
+
 static const struct gp2ap020a00f_chip_info gp2ap020a00f_chip_info = {
 	.name = "gp2ap020a00f",
 	.reg_init_tab = gp2ap020a00f_reg_init_tab,
 	.channels = gp2ap020a00f_channels,
 	.num_channels = ARRAY_SIZE(gp2ap020a00f_channels),
+	.has_als_auto = true,
+};
+
+static const struct gp2ap020a00f_chip_info gp2ap030a00f_chip_info = {
+	.name = "gp2ap030a00f",
+	.reg_init_tab = gp2ap030a00f_reg_init_tab,
+	.channels = gp2ap030a00f_channels,
+	.num_channels = ARRAY_SIZE(gp2ap030a00f_channels),
 };
 
 static const struct iio_info gp2ap020a00f_info = {
@@ -1450,6 +1540,10 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 		goto error_regulator_disable;
 	}
 
+	/* GP2AP030A00F application note, section 4.2: wait 1 ms after power-on. */
+	if (!data->chip_info->has_als_auto)
+		fsleep(1 * USEC_PER_MSEC);
+
 	/* Initialize device registers */
 	err = regmap_bulk_write(regmap, GP2AP020A00F_OP_REG,
 			data->chip_info->reg_init_tab,
@@ -1551,12 +1645,17 @@ static const struct i2c_device_id gp2ap020a00f_id[] = {
 		.name = "gp2ap020a00f",
 		.driver_data = (kernel_ulong_t)&gp2ap020a00f_chip_info,
 	},
+	{
+		.name = "gp2ap030a00f",
+		.driver_data = (kernel_ulong_t)&gp2ap030a00f_chip_info,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, gp2ap020a00f_id);
 
 static const struct of_device_id gp2ap020a00f_of_match[] = {
 	{ .compatible = "sharp,gp2ap020a00f", .data = &gp2ap020a00f_chip_info },
+	{ .compatible = "sharp,gp2ap030a00f", .data = &gp2ap030a00f_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, gp2ap020a00f_of_match);
@@ -1573,5 +1672,5 @@ static struct i2c_driver gp2ap020a00f_driver = {
 module_i2c_driver(gp2ap020a00f_driver);
 
 MODULE_AUTHOR("Jacek Anaszewski <j.anaszewski@samsung.com>");
-MODULE_DESCRIPTION("Sharp GP2AP020A00F Proximity/ALS sensor driver");
+MODULE_DESCRIPTION("Sharp GP2AP020A00F and similar proximity/ALS sensors");
 MODULE_LICENSE("GPL v2");

-- 
2.56.0

