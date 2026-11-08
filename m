Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794174256;
	b=Bl0nbLQMoQTDJDBhrk522h2Rj/j4/nH9hiajTrPFEBemSD3agC7iJLmbbMIiWVAKbEP3
	 VJ4qym6v8LRpDl98sh35sZ1ddSTn3FoUeslFldx0v/dxo5YWEVU0Rb0vGWYS42IYIU7i/
	 /3xH+e31M8exKS7OuhmVRhBkCNz14HzG5raFdj3XyDjo1gYgjhV6LF9MCeMEmPgb8Am/a
	 sM/otOviDZTmAh6qj+421crIazz/ra+4XRPsoDijetXBavOiEj4wDbM+Kdoj5r0Ldr+yf
	 hg+IwOKNIN4tf0RBvDeqIIFpXlnZw49XXnKOxaigclGkREQGwdzMzqEUMqOxmVzDjbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174256;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=hK/dRfus1cAcHMxLKmydGTiBOL/zXDruPXd/E8pMZnM=;
	b=vpdcEGLdk6ACMBXk5pMQgBdyHWnRpBk41GUDBFb6ML4/oiypWrLvwG5hhhJtjtI32577
	 ec3JfLuGwa/aftIN1DpGsZyTJeJHn1fOT3lnT1Z8taVtCbPzjl3h0XCo7ISLQh7ewZw8g
	 c/Q6PRD3B31wnF5uUJ+Z1JD+Y9tRr/fT0o82Nd0sdtIl8y28VaSgf7TMOeS/HakIyT/zI
	 oFPRGFl3SP+wjxrOVMOoXlHEBJ32l4J9zkSOapnMxJUGUiohqYbD5ax192VMpcvb0m2o7
	 xc8z6M52iLFVZS3StcYO5KtJtCAJnCtYUq1jNUXrWADTUyjf6rFbMaHEc3nioB9iNPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1Q1L76j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1A0606A326;
	Sun,  8 Nov 2026 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1Q1L76j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72821F008A4;
	Sun,  8 Nov 2026 21:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794174255;
	bh=hK/dRfus1cAcHMxLKmydGTiBOL/zXDruPXd/E8pMZnM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N1Q1L76j0wh00kB6rL9Pk4Pyjlg1bEji7CQ0koEiI3txHZ+kAtDfhUU7+QGe++1ep
	 wWPrBGawomDNxg+vpItnRVxTxRoDvWrXG9rK9ANmCeRfNDskZ0KW4wqBBU9x5tfn4O
	 dwkGnV0nIREHQEbT2u9To0qxH+mp/lpMyrDmbAIt0NteWHbFSlrjIWGHH3R9KtniT7
	 In/gIOmwJy506yPMUkx1jaF4jtAPJMXMbl/5BAHtdv3yfyrRm3gTaUEZnOfzPlNKKC
	 2wUxII04dbX2tJKYIoMOqgy7LDHwgmbKdKvsWHn81IZvm006ywI2164riAibz5YY6r
	 MNOJCgQY/9ugg==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 08 Nov 2026 22:44:03 +0100
Subject: [PATCH v2 5/5] iio: light: gp2ap020a00f: Add GP2AP030A00F support
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
Message-Id: <20261108-gp2ap030-v2-5-24eaa1b9fe59@kernel.org>
References: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
In-Reply-To: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>
Cc: devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The GP2AP030A00F has the same register addresses and interrupt modes
as the GP2AP020A00F, but does not implement its automatic
illuminance calculation or selectable ambient-light cancellation.

Datasheet: https://jp.sharp/products/device/doc/opto/gp2ap030a00f_appl_e.pdf
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/iio/light/Kconfig        |   6 +--
 drivers/iio/light/gp2ap020a00f.c | 100 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 462fff1ddef2..89fe003371b8 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -259,15 +259,15 @@ config GP2AP002
 	  module will be called gp2ap002.
 
 config GP2AP020A00F
-	tristate "Sharp GP2AP020A00F Proximity/ALS sensor"
+	tristate "Sharp GP2AP020A00F and similar Proximity/ALS sensors"
 	depends on I2C
 	select REGMAP_I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	select IRQ_WORK
 	help
-	  Say Y here if you have a Sharp GP2AP020A00F proximity/ALS combo-chip
-	  hooked to an I2C bus.
+	  Say Y here to enable support for the Sharp GP2AP020A00F and similar
+	  proximity/ALS combo-chips hooked to an I2C bus.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called gp2ap020a00f.
diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 5464311515c7..813a64ee627c 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -54,6 +54,11 @@
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
@@ -137,6 +142,7 @@
 #define GP2AP020A00F_RES_P_6_25ms_x2	0x28
 #define GP2AP020A00F_RES_P_1_56ms_x2	0x30
 #define GP2AP020A00F_RES_P_0_39ms_x2	0x38
+#define GP2AP030A00F_RES_P_1_56ms_x2	0x18
 #define GP2AP020A00F_RANGE_P_MASK	0x07 /* PS: Max measurable range */
 #define GP2AP020A00F_RANGE_P_x1		0x00
 #define GP2AP020A00F_RANGE_P_x2		0x01
@@ -158,6 +164,7 @@
 #define GP2AP020A00F_IS_27_5mA		0x10
 #define GP2AP020A00F_IS_55mA		0x20
 #define GP2AP020A00F_IS_110mA		0x30
+#define GP2AP030A00F_IS_130mA		0x30
 #define GP2AP020A00F_PIN_MASK		0x0c /* INT terminal setting */
 #define GP2AP020A00F_PIN_ALS_OR_PS	0x00
 #define GP2AP020A00F_PIN_ALS		0x04
@@ -239,6 +246,7 @@ struct gp2ap020a00f_chip_info {
 	const u8 *reg_init_tab;
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
+	bool has_als_auto;
 };
 
 struct gp2ap020a00f_data {
@@ -276,6 +284,17 @@ static const u8 gp2ap020a00f_reg_init_tab[] = {
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
@@ -371,6 +390,7 @@ static const struct gp2ap020a00f_mutable_config_regs {
 static int gp2ap020a00f_set_operation_mode(struct gp2ap020a00f_data *data,
 					enum gp2ap020a00f_opmode op)
 {
+	u8 op_reg = opmode_regs_settings[op].op_reg;
 	unsigned int op_reg_val;
 	int err;
 
@@ -409,12 +429,16 @@ static int gp2ap020a00f_set_operation_mode(struct gp2ap020a00f_data *data,
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
 
@@ -446,6 +470,8 @@ static int gp2ap020a00f_write_event_threshold(struct gp2ap020a00f_data *data,
 
 	if (!enable)
 		thresh_reg_val = 0;
+	else if (!data->chip_info->has_als_auto)
+		thresh_reg_val = min(data->thresh_val[th_val_id], 65535U);
 	else if (test_bit(GP2AP020A00F_FLAG_LUX_MODE_HI, &data->flags) &&
 		 th_val_id != GP2AP020A00F_THRESH_PL &&
 		 th_val_id != GP2AP020A00F_THRESH_PH)
@@ -709,6 +735,10 @@ static bool gp2ap020a00f_adjust_lux_mode(struct gp2ap020a00f_data *data,
 	u8 new_range = 0xff;
 	int err;
 
+	/* GP2AP030A00F thresholds and samples are raw counts at a fixed range. */
+	if (!data->chip_info->has_als_auto)
+		return false;
+
 	if (!test_bit(GP2AP020A00F_FLAG_LUX_MODE_HI, &data->flags)) {
 		if (output_val > 16000) {
 			set_bit(GP2AP020A00F_FLAG_LUX_MODE_HI, &data->flags);
@@ -1317,11 +1347,71 @@ static const struct iio_chan_spec gp2ap020a00f_channels[] = {
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
+			.shift = 0,
+			.storagebits = 32,
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
+			.shift = 0,
+			.storagebits = 32,
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
+			.shift = 0,
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
@@ -1450,6 +1540,9 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 		goto error_regulator_disable;
 	}
 
+	if (!data->chip_info->has_als_auto)
+		fsleep(1000);
+
 	/* Initialize device registers */
 	err = regmap_bulk_write(regmap, GP2AP020A00F_OP_REG,
 			data->chip_info->reg_init_tab,
@@ -1549,12 +1642,15 @@ static void gp2ap020a00f_remove(struct i2c_client *client)
 static const struct i2c_device_id gp2ap020a00f_id[] = {
 	{ .name = "gp2ap020a00f",
 	  .driver_data = (kernel_ulong_t)&gp2ap020a00f_chip_info },
+	{ .name = "gp2ap030a00f",
+	  .driver_data = (kernel_ulong_t)&gp2ap030a00f_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, gp2ap020a00f_id);
 
 static const struct of_device_id gp2ap020a00f_of_match[] = {
 	{ .compatible = "sharp,gp2ap020a00f", .data = &gp2ap020a00f_chip_info },
+	{ .compatible = "sharp,gp2ap030a00f", .data = &gp2ap030a00f_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, gp2ap020a00f_of_match);
@@ -1571,5 +1667,5 @@ static struct i2c_driver gp2ap020a00f_driver = {
 module_i2c_driver(gp2ap020a00f_driver);
 
 MODULE_AUTHOR("Jacek Anaszewski <j.anaszewski@samsung.com>");
-MODULE_DESCRIPTION("Sharp GP2AP020A00F Proximity/ALS sensor driver");
+MODULE_DESCRIPTION("Sharp GP2AP020A00F and similar proximity/ALS sensor driver");
 MODULE_LICENSE("GPL v2");

-- 
2.56.0

