Received: from out-2uec-a94.jellyfish.systems (out-2uec-a94.jellyfish.systems [63.250.43.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185FB38399A
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 00:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223930; cv=none; b=MQL+FUl6pb+IaUB9rAqUDxapODPFPUTyWdAEAh0P637quiEJxQffkGm++YxxUF0O3I91kopojfYARRNg3bbeQZs7k4oK6j+SAy/Git7DDv71QG5mFvRRtULhAVgmFP853fz0ktErxVizVaXn2ZWgSSc7MiTPYdIRcIc2KuyOWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223930; c=relaxed/simple;
	bh=Qz7Zxt5XRekgabE4gfhDyrP59snWbTlwpwIyvAO6zSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYv+aHgBspa++Q+92oMbK0NOVoS7ruLFCDANiX0qqi9APYF0DaqQ+ez+CxnOozRLisvYbTkl6O/rbVbA57tycBYSypZwsLQOjDyhzREJ86QPXbDYJFP9HWXp+fVnHumsbaAWyhfVTKLW4t05c7MW0X4WnVYzLzP/2zM5PA8UnAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=63.250.43.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hYnPV3Qmxz2x9D;
	Tue, 01 Sep 2026 00:51:58 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Subject: [PATCH v3 5/5] iio: light: stk3310: support the Sensortek STK36C61
Date: Tue,  1 Sep 2026 02:51:14 +0200
Message-ID: <20260901005114.203062-6-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901005114.203062-1-jorijnvdgraaf@catcrafts.net>
References: <20260901005114.203062-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

The Sensortek STK36C61 is a 3-in-1 ambient light / proximity / RGB
colour sensor. Its register interface is compatible with the feature
set this driver uses. Add its chip ID to the known-ID list and the
device table entries.

Whenever the ALS engine runs, the chip also measures four colour
channels: red, green, blue and clear, laid out directly after the
ALS data as 16-bit big-endian values.

R, G and B are gained by the same ALSCTRL gain field the illuminance
channel uses, clear by its own gain field in the GAINCTRL register,
and the whole colour block integrates over the ALS integration time.
Expose the channels with per-channel scale and a shared integration
time, as suggested by Jonathan Cameron for the green channel.

The scales reuse the driver's existing gain-only table: green equals
the ALS data, so its scale must read identically to the pre-existing
in_illuminance_scale.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 Documentation/ABI/testing/sysfs-bus-iio |   1 +
 drivers/iio/light/stk3310.c             | 101 ++++++++++++++++++++----
 2 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a4f5595722ad..08a8de215814 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -507,6 +507,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_z_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_clear_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflow_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_scale
diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index f5782a1e19bb..0a16e326e939 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -40,7 +40,13 @@
 #define STK3310_REG_PS_DATA_LSB			0x12
 #define STK3310_REG_ALS_DATA_MSB		0x13
 #define STK3310_REG_ALS_DATA_LSB		0x14
+#define STK36C61_REG_RED_DATA_MSB		0x15
+#define STK36C61_REG_GREEN_DATA_MSB		0x17
+#define STK36C61_REG_BLUE_DATA_MSB		0x19
+#define STK36C61_REG_CLEAR_DATA_MSB		0x1B
+#define STK36C61_REG_CLEAR_DATA_LSB		0x1C
 #define STK3310_REG_ID				0x3E
+#define STK36C61_REG_GAINCTRL			0x4E
 #define STK3310_MAX_REG				0x80
 
 #define STK3310_STATE_EN_PS			BIT(0)
@@ -54,6 +60,7 @@
 #define STK3311S34_CHIP_ID_VAL			0x1E
 #define STK3311X_CHIP_ID_VAL			0x12
 #define STK3335_CHIP_ID_VAL			0x51
+#define STK36C61_CHIP_ID_VAL			0x95
 #define STK3310_PSINT_EN			0x01
 #define STK3310_PS_MAX_VAL			0xFFFF
 
@@ -83,6 +90,8 @@ static const struct reg_field stk3310_reg_field_als_gain =
 				REG_FIELD(STK3310_REG_ALSCTRL, 4, 5);
 static const struct reg_field stk3310_reg_field_ps_gain =
 				REG_FIELD(STK3310_REG_PSCTRL, 4, 5);
+static const struct reg_field stk3310_reg_field_clear_gain =
+				REG_FIELD(STK36C61_REG_GAINCTRL, 4, 5);
 static const struct reg_field stk3310_reg_field_als_it =
 				REG_FIELD(STK3310_REG_ALSCTRL, 0, 3);
 static const struct reg_field stk3310_reg_field_ps_it =
@@ -102,6 +111,7 @@ static const u8 stk3310_chip_ids[] = {
 	STK3311X_CHIP_ID_VAL,
 	STK3311_CHIP_ID_VAL,
 	STK3335_CHIP_ID_VAL,
+	STK36C61_CHIP_ID_VAL,
 };
 
 /* Estimate maximum proximity values with regard to measurement scale. */
@@ -132,6 +142,7 @@ struct stk3310_data {
 	struct regmap_field *reg_state;
 	struct regmap_field *reg_als_gain;
 	struct regmap_field *reg_ps_gain;
+	struct regmap_field *reg_clear_gain;
 	struct regmap_field *reg_als_it;
 	struct regmap_field *reg_ps_it;
 	struct regmap_field *reg_int_ps;
@@ -202,11 +213,35 @@ static const struct iio_chan_spec_ext_info stk3310_ext_info[] = {
 	.ext_info = stk3310_ext_info,			\
 }
 
+#define STK36C61_INTENSITY_CHANNEL(_mod, _reg) {	\
+	.type = IIO_INTENSITY,				\
+	.address = _reg,				\
+	.modified = 1,					\
+	.channel2 = IIO_MOD_LIGHT_##_mod,		\
+	.info_mask_separate =				\
+		BIT(IIO_CHAN_INFO_RAW) |		\
+		BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type =			\
+		BIT(IIO_CHAN_INFO_INT_TIME),		\
+	.info_mask_shared_by_type_available =		\
+		BIT(IIO_CHAN_INFO_SCALE) |		\
+		BIT(IIO_CHAN_INFO_INT_TIME),		\
+}
+
 static const struct iio_chan_spec stk3310_channels[] = {
 	STK3310_LIGHT_CHANNEL,
 	STK3310_PROXIMITY_CHANNEL,
 };
 
+static const struct iio_chan_spec stk36c61_channels[] = {
+	STK3310_LIGHT_CHANNEL,
+	STK3310_PROXIMITY_CHANNEL,
+	STK36C61_INTENSITY_CHANNEL(RED, STK36C61_REG_RED_DATA_MSB),
+	STK36C61_INTENSITY_CHANNEL(GREEN, STK36C61_REG_GREEN_DATA_MSB),
+	STK36C61_INTENSITY_CHANNEL(BLUE, STK36C61_REG_BLUE_DATA_MSB),
+	STK36C61_INTENSITY_CHANNEL(CLEAR, STK36C61_REG_CLEAR_DATA_MSB),
+};
+
 /**
  * struct stk3310_chip_info - chip-specific data
  * @name: device name reported to the IIO core
@@ -225,6 +260,12 @@ static const struct stk3310_chip_info stk3310_chip_info = {
 	.num_channels = ARRAY_SIZE(stk3310_channels),
 };
 
+static const struct stk3310_chip_info stk36c61_chip_info = {
+	.name = "stk36c61",
+	.channels = stk36c61_channels,
+	.num_channels = ARRAY_SIZE(stk36c61_channels),
+};
+
 static IIO_CONST_ATTR(in_illuminance_scale_available, STK3310_SCALE_AVAILABLE);
 
 static IIO_CONST_ATTR(in_proximity_scale_available, STK3310_SCALE_AVAILABLE);
@@ -401,7 +442,8 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
 	struct i2c_client *client = data->client;
 	struct regmap *map = data->regmap;
 
-	if (chan->type != IIO_LIGHT && chan->type != IIO_PROXIMITY)
+	if (chan->type != IIO_LIGHT && chan->type != IIO_PROXIMITY &&
+	    chan->type != IIO_INTENSITY)
 		return -EINVAL;
 
 	switch (mask) {
@@ -417,10 +459,10 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&data->lock);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_INT_TIME:
-		if (chan->type == IIO_LIGHT)
-			ret = regmap_field_read(data->reg_als_it, &index);
-		else
+		if (chan->type == IIO_PROXIMITY)
 			ret = regmap_field_read(data->reg_ps_it, &index);
+		else
+			ret = regmap_field_read(data->reg_als_it, &index);
 		if (ret < 0)
 			return ret;
 
@@ -428,10 +470,12 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
 		*val2 = stk3310_it_table[index][1];
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SCALE:
-		if (chan->type == IIO_LIGHT)
-			ret = regmap_field_read(data->reg_als_gain, &index);
-		else
+		if (chan->type == IIO_PROXIMITY)
 			ret = regmap_field_read(data->reg_ps_gain, &index);
+		else if (chan->channel2 == IIO_MOD_LIGHT_CLEAR)
+			ret = regmap_field_read(data->reg_clear_gain, &index);
+		else
+			ret = regmap_field_read(data->reg_als_gain, &index);
 		if (ret < 0)
 			return ret;
 
@@ -451,7 +495,8 @@ static int stk3310_write_raw(struct iio_dev *indio_dev,
 	int index;
 	struct stk3310_data *data = iio_priv(indio_dev);
 
-	if (chan->type != IIO_LIGHT && chan->type != IIO_PROXIMITY)
+	if (chan->type != IIO_LIGHT && chan->type != IIO_PROXIMITY &&
+	    chan->type != IIO_INTENSITY)
 		return -EINVAL;
 
 	switch (mask) {
@@ -462,10 +507,10 @@ static int stk3310_write_raw(struct iio_dev *indio_dev,
 		if (index < 0)
 			return -EINVAL;
 		mutex_lock(&data->lock);
-		if (chan->type == IIO_LIGHT)
-			ret = regmap_field_write(data->reg_als_it, index);
-		else
+		if (chan->type == IIO_PROXIMITY)
 			ret = regmap_field_write(data->reg_ps_it, index);
+		else
+			ret = regmap_field_write(data->reg_als_it, index);
 		if (ret < 0)
 			dev_err(&data->client->dev,
 				"sensor configuration failed\n");
@@ -479,10 +524,12 @@ static int stk3310_write_raw(struct iio_dev *indio_dev,
 		if (index < 0)
 			return -EINVAL;
 		mutex_lock(&data->lock);
-		if (chan->type == IIO_LIGHT)
-			ret = regmap_field_write(data->reg_als_gain, index);
-		else
+		if (chan->type == IIO_PROXIMITY)
 			ret = regmap_field_write(data->reg_ps_gain, index);
+		else if (chan->channel2 == IIO_MOD_LIGHT_CLEAR)
+			ret = regmap_field_write(data->reg_clear_gain, index);
+		else
+			ret = regmap_field_write(data->reg_als_gain, index);
 		if (ret < 0)
 			dev_err(&data->client->dev,
 				"sensor configuration failed\n");
@@ -493,9 +540,31 @@ static int stk3310_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int stk3310_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)stk3310_scale_table;
+		*length = 2 * ARRAY_SIZE(stk3310_scale_table);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_INT_TIME:
+		*vals = (const int *)stk3310_it_table;
+		*length = 2 * ARRAY_SIZE(stk3310_it_table);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info stk3310_info = {
 	.read_raw		= stk3310_read_raw,
 	.write_raw		= stk3310_write_raw,
+	.read_avail		= stk3310_read_avail,
 	.attrs			= &stk3310_attribute_group,
 	.read_event_value	= stk3310_read_event,
 	.write_event_value	= stk3310_write_event,
@@ -567,6 +636,7 @@ static bool stk3310_is_volatile_reg(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case STK3310_REG_ALS_DATA_MSB:
 	case STK3310_REG_ALS_DATA_LSB:
+	case STK36C61_REG_RED_DATA_MSB ... STK36C61_REG_CLEAR_DATA_LSB:
 	case STK3310_REG_PS_DATA_LSB:
 	case STK3310_REG_PS_DATA_MSB:
 	case STK3310_REG_FLAG:
@@ -601,6 +671,7 @@ static int stk3310_regmap_init(struct stk3310_data *data)
 	STK3310_REGFIELD(state);
 	STK3310_REGFIELD(als_gain);
 	STK3310_REGFIELD(ps_gain);
+	STK3310_REGFIELD(clear_gain);
 	STK3310_REGFIELD(als_it);
 	STK3310_REGFIELD(ps_it);
 	STK3310_REGFIELD(int_ps);
@@ -795,6 +866,7 @@ static const struct i2c_device_id stk3310_i2c_id[] = {
 	{ .name = "stk3310", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
 	{ .name = "stk3311", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
 	{ .name = "stk3335", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
+	{ .name = "stk36c61", .driver_data = (kernel_ulong_t)&stk36c61_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
@@ -812,6 +884,7 @@ static const struct of_device_id stk3310_of_match[] = {
 	{ .compatible = "sensortek,stk3310", .data = &stk3310_chip_info },
 	{ .compatible = "sensortek,stk3311", .data = &stk3310_chip_info },
 	{ .compatible = "sensortek,stk3335", .data = &stk3310_chip_info },
+	{ .compatible = "sensortek,stk36c61", .data = &stk36c61_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, stk3310_of_match);
-- 
2.55.0

