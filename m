Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794094307;
	b=NyEQL1M1XTL0KKyUvDQRDvwCeud2Wiqeu+WIRdPM3rkk+Zt9lwSNcQ9unl8ZLZdx5fog
	 VE4ONC3iE7b8NegxH0XThLW7QVIRYNZXA53LZV57mqqjpbxr2WRHJ/cmd7XtcyA9wMrnW
	 VI4/xXnnGfBstBGIfrTn7jkcXcyHGninh3pE1yQ2mNdvrgksgBOkJIKw/MvUkZ1PW5/Lt
	 VJFhzM4XaURs1mmm6q4oX7FJzthMg4VYjGqQvV4qk4Vs3/4Rg0bvQ0XUMF1iYvYKHlXKa
	 nCtVgoumzsfamOOh9Y/gy5l0BoetMIX2QZCWD04p+6AH6T3XRwsbG0GKgF7+u72Ho3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794094307;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=+yjKM61pk9w42JGqrRYnst1C4Tx415fM6/ei4nV81ok=;
	b=ggAxFa09bAaGAAScWdm8koB7XMpDsl0pTFSo0GVENFBzEArQdzIB8vP5gwvyJKve0eaZ
	 Hd0AY7uWTBcZ8gmoOLsjq7FERh008i4QWA7Y3Fiy6X1UnsVPdnhEuIReG/tJ7DLzjESoN
	 Dd3+ocasru/TJgN7bLjkSVshz4nsHFwM617tn+0c8O5cefZipudwmuunRSSw1h7yirEkU
	 ldSwB5nnLa5CKG1djc10kdAUpsdWQoh0JsyFopjmWLs431g6fzbwqslnEunRzUdPw5XAA
	 a0qwvd3I+NU2CoDNRRJHnDq1/Itwa4byL1f49+Co86qo7j5Y3eXDQ1mUcD4tgGJ4hoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBuzDWM6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212DD606A32F;
	Sat,  7 Nov 2026 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBuzDWM6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA4C1F0089F;
	Sat,  7 Nov 2026 23:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794094307;
	bh=+yjKM61pk9w42JGqrRYnst1C4Tx415fM6/ei4nV81ok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jBuzDWM61+xZjralt4ZqDdPRGpkY/gTWcJ4cQt+29GU5PGyYWEMMv/qTPnvxnrlrv
	 VZTopg3xW/FrGPI6vzrWrFQS7YWhRp94+PYok1uLqGjFBo+vzOa/0NM495KFtpfbDl
	 2IBX1RLViTO46Bc94vv7k69/w5eKheww/HvKZmP6/NoZIcmOkQXLw2+QpBtsc7/3Hb
	 nOGeVLyy9pd1nomZ+OwBjC5HjAGfi+7DNypNOQUgj3F8zCw25S5IxWcp2srIbwM1Kx
	 8gTvTemJo9zjt3MUTBaqz+b+KJGS6xuP//ErT8885ZVRd/+qseb7PLmRP6ReWq6ewI
	 /+Dq2n5IjoQ0Q==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 08 Nov 2026 00:31:36 +0100
Subject: [PATCH 4/4] iio: light: gp2ap020a00f: Add GP2AP030A00F support
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
Message-Id: <20261108-gp2ap030-v1-4-55314eb7055b@kernel.org>
References: <20261108-gp2ap030-v1-0-55314eb7055b@kernel.org>
In-Reply-To: <20261108-gp2ap030-v1-0-55314eb7055b@kernel.org>
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
 drivers/iio/light/Kconfig        |  6 +--
 drivers/iio/light/gp2ap020a00f.c | 80 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 462fff1ddef2..549f644994df 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -259,15 +259,15 @@ config GP2AP002
 	  module will be called gp2ap002.
 
 config GP2AP020A00F
-	tristate "Sharp GP2AP020A00F Proximity/ALS sensor"
+	tristate "Sharp GP2AP020A00F/GP2AP030A00F Proximity/ALS sensors"
 	depends on I2C
 	select REGMAP_I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	select IRQ_WORK
 	help
-	  Say Y here if you have a Sharp GP2AP020A00F proximity/ALS combo-chip
-	  hooked to an I2C bus.
+	  Say Y here if you have a Sharp GP2AP020A00F or GP2AP030A00F
+	  proximity/ALS combo-chip hooked to an I2C bus.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called gp2ap020a00f.
diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 62c4beb20cce..3ea1ec273e7f 100644
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
@@ -234,7 +241,14 @@ enum gp2ap020a00f_thresh_val_id {
 	GP2AP020A00F_THRESH_PH,
 };
 
+struct gp2ap020a00f_chip_info {
+	const char *name;
+	const u8 *reg_init_tab;
+	bool has_als_auto;
+};
+
 struct gp2ap020a00f_data {
+	const struct gp2ap020a00f_chip_info *chip_info;
 	struct i2c_client *client;
 	struct mutex lock;
 	char *buffer;
@@ -268,6 +282,28 @@ static const u8 gp2ap020a00f_reg_init_tab[] = {
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
+static const struct gp2ap020a00f_chip_info gp2ap020a00f_chip_info = {
+	.name = "gp2ap020a00f",
+	.reg_init_tab = gp2ap020a00f_reg_init_tab,
+	.has_als_auto = true,
+};
+
+static const struct gp2ap020a00f_chip_info gp2ap030a00f_chip_info = {
+	.name = "gp2ap030a00f",
+	.reg_init_tab = gp2ap030a00f_reg_init_tab,
+};
+
 static bool gp2ap020a00f_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -364,6 +400,7 @@ static int gp2ap020a00f_set_operation_mode(struct gp2ap020a00f_data *data,
 					enum gp2ap020a00f_opmode op)
 {
 	unsigned int op_reg_val;
+	u8 op_reg = opmode_regs_settings[op].op_reg;
 	int err;
 
 	if (op != GP2AP020A00F_OPMODE_SHUTDOWN) {
@@ -401,12 +438,16 @@ static int gp2ap020a00f_set_operation_mode(struct gp2ap020a00f_data *data,
 			return err;
 	}
 
+	/* Bit 0 is reserved on the GP2AP030A00F. */
+	if (!data->chip_info->has_als_auto)
+		op_reg &= ~GP2AP020A00F_TYPE_MASK;
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
 
@@ -438,6 +479,8 @@ static int gp2ap020a00f_write_event_threshold(struct gp2ap020a00f_data *data,
 
 	if (!enable)
 		thresh_reg_val = 0;
+	else if (!data->chip_info->has_als_auto)
+		thresh_reg_val = min(data->thresh_val[th_val_id], 65535U);
 	else if (test_bit(GP2AP020A00F_FLAG_LUX_MODE_HI, &data->flags) &&
 		 th_val_id != GP2AP020A00F_THRESH_PL &&
 		 th_val_id != GP2AP020A00F_THRESH_PH)
@@ -701,6 +744,10 @@ static bool gp2ap020a00f_adjust_lux_mode(struct gp2ap020a00f_data *data,
 	u8 new_range = 0xff;
 	int err;
 
+	/* GP2AP030A00F thresholds and samples are raw counts at a fixed range. */
+	if (!data->chip_info->has_als_auto)
+		return false;
+
 	if (!test_bit(GP2AP020A00F_FLAG_LUX_MODE_HI, &data->flags)) {
 		if (output_val > 16000) {
 			set_bit(GP2AP020A00F_FLAG_LUX_MODE_HI, &data->flags);
@@ -1401,7 +1448,7 @@ static const struct iio_buffer_setup_ops gp2ap020a00f_buffer_setup_ops = {
 
 static int gp2ap020a00f_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	struct iio_chan_spec *channels;
 	struct device *dev = &client->dev;
 	struct gp2ap020a00f_data *data;
 	struct iio_dev *indio_dev;
@@ -1413,6 +1460,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
+	data->chip_info = i2c_get_match_data(client);
 
 	err = devm_regulator_get_enable_optional(dev, "vdd");
 	if (err && err != -ENODEV)
@@ -1437,9 +1485,12 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 		goto error_regulator_disable;
 	}
 
+	if (!data->chip_info->has_als_auto)
+		usleep_range(1000, 2000);
+
 	/* Initialize device registers */
 	err = regmap_bulk_write(regmap, GP2AP020A00F_OP_REG,
-			gp2ap020a00f_reg_init_tab,
+			data->chip_info->reg_init_tab,
 			ARRAY_SIZE(gp2ap020a00f_reg_init_tab));
 
 	if (err < 0) {
@@ -1456,9 +1507,20 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 
 	mutex_init(&data->lock);
 	indio_dev->channels = gp2ap020a00f_channels;
+	if (!data->chip_info->has_als_auto) {
+		channels = devm_kmemdup(dev, gp2ap020a00f_channels,
+					sizeof(gp2ap020a00f_channels), GFP_KERNEL);
+		if (!channels) {
+			err = -ENOMEM;
+			goto error_regulator_disable;
+		}
+		channels[GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR].scan_type.realbits = 16;
+		channels[GP2AP020A00F_SCAN_MODE_LIGHT_IR].scan_type.realbits = 16;
+		indio_dev->channels = channels;
+	}
 	indio_dev->num_channels = ARRAY_SIZE(gp2ap020a00f_channels);
 	indio_dev->info = &gp2ap020a00f_info;
-	indio_dev->name = id->name;
+	indio_dev->name = data->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Allocate buffer */
@@ -1534,13 +1596,17 @@ static void gp2ap020a00f_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id gp2ap020a00f_id[] = {
-	{ .name = "gp2ap020a00f" },
+	{ .name = "gp2ap020a00f",
+	  .driver_data = (kernel_ulong_t)&gp2ap020a00f_chip_info },
+	{ .name = "gp2ap030a00f",
+	  .driver_data = (kernel_ulong_t)&gp2ap030a00f_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, gp2ap020a00f_id);
 
 static const struct of_device_id gp2ap020a00f_of_match[] = {
-	{ .compatible = "sharp,gp2ap020a00f" },
+	{ .compatible = "sharp,gp2ap020a00f", .data = &gp2ap020a00f_chip_info },
+	{ .compatible = "sharp,gp2ap030a00f", .data = &gp2ap030a00f_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, gp2ap020a00f_of_match);
@@ -1557,5 +1623,5 @@ static struct i2c_driver gp2ap020a00f_driver = {
 module_i2c_driver(gp2ap020a00f_driver);
 
 MODULE_AUTHOR("Jacek Anaszewski <j.anaszewski@samsung.com>");
-MODULE_DESCRIPTION("Sharp GP2AP020A00F Proximity/ALS sensor driver");
+MODULE_DESCRIPTION("Sharp GP2AP020A00F/GP2AP030A00F proximity/ALS sensor driver");
 MODULE_LICENSE("GPL v2");

-- 
2.56.0

