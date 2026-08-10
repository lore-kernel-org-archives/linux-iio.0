Received: from out-2z4y-a156.jellyfish.systems (out-2z4y-a156.jellyfish.systems [198.54.127.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF0E3955C4
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359911; cv=none; b=WqFKOCaDnYIlnwPvbuhGZSBFgcyQD84AzeKtLj2jBKs1axKDVxeBc+4n7YPOS64EPGPLxZ6EWYbu/KHhkWRIskKFV/H1BQK+0XNKL+M/mrVnS0810TSdQrO5Zj/fH2jo6VHeBWBC4tWqjFSosaJ0Xfg40mlu34fPK7NdWR87hew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359911; c=relaxed/simple;
	bh=bwjCD43E9bjMXAxChdrLhk7PINHWYkrOck/9FWTc4F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEkoaVy5qSOMNYWyDYPC7365DB/Qw1sSShDgdvr7XikyjaAiLrmenQxQRsGN3S/a+qN4pKXDrkjme6ACOaza/Ha+JDE7po57/Fd3DDp3IPgRMACooC/jhEvcjrerPttW3R8CrpqS7Zqf2HnPaNMaFd1CG+N65wd3hapl6SEdoL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hJX2k6PYnz8sWQ;
	Mon, 10 Aug 2026 11:04:46 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Subject: [PATCH 3/3] iio: light: stk3310: support the Sensortek STK36C61
Date: Mon, 10 Aug 2026 13:04:23 +0200
Message-ID: <20260810110423.41697-4-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810110423.41697-1-jorijnvdgraaf@catcrafts.net>
References: <20260810110423.41697-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

The Sensortek STK36C61 is a 3-in-1 ambient light / proximity / RGB
colour sensor (chip ID 0x95) found in the Fairphone 6. Its register
interface is compatible with the feature set this driver uses: the
STATE/FLAG bit layout, the data and threshold registers and the gain
and integration-time fields, verified on that device (the ALS and
proximity readings scale with their gain and integration-time fields,
thresholds written through the event interface read back from the
chip, and the FLAG near/far bit crosses with them). Add its chip ID to
the known-ID list and the device table entries.

Whenever the ALS engine runs, the chip also measures four colour
channels, laid out directly after the ALS data as 16-bit big-endian
values in R (0x15), G (0x17), B (0x19), C (0x1B) order; the R, G and B
assignments were each confirmed by the matching channel dominating
under red, green and blue illumination, and clear by its broadband
response. The ALS data register tracks the green channel exactly.
There is no public datasheet and therefore no counts-to-physical
mapping for the colour channels, so they are exposed as raw-only
intensity channels; the gain field the scale attribute controls does
not govern clear either.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 drivers/iio/light/stk3310.c | 44 ++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 249396b9bf80..288b544a8abb 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -40,6 +40,11 @@
 #define STK3310_REG_PS_DATA_LSB			0x12
 #define STK3310_REG_ALS_DATA_MSB		0x13
 #define STK3310_REG_ALS_DATA_LSB		0x14
+#define STK36C61_REG_RED_DATA_MSB		0x15
+#define STK36C61_REG_GREEN_DATA_MSB		0x17
+#define STK36C61_REG_BLUE_DATA_MSB		0x19
+#define STK36C61_REG_CLEAR_DATA_MSB		0x1B
+#define STK36C61_REG_CLEAR_DATA_LSB		0x1C
 #define STK3310_REG_ID				0x3E
 #define STK3310_MAX_REG				0x80
 
@@ -54,6 +59,7 @@
 #define STK3311S34_CHIP_ID_VAL			0x1E
 #define STK3311X_CHIP_ID_VAL			0x12
 #define STK3335_CHIP_ID_VAL			0x51
+#define STK36C61_CHIP_ID_VAL			0x95
 #define STK3310_PSINT_EN			0x01
 #define STK3310_PS_MAX_VAL			0xFFFF
 
@@ -102,6 +108,7 @@ static const u8 stk3310_chip_ids[] = {
 	STK3311X_CHIP_ID_VAL,
 	STK3311_CHIP_ID_VAL,
 	STK3335_CHIP_ID_VAL,
+	STK36C61_CHIP_ID_VAL,
 };
 
 /* Estimate maximum proximity values with regard to measurement scale. */
@@ -202,11 +209,28 @@ static const struct iio_chan_spec_ext_info stk3310_ext_info[] = {
 	.ext_info = stk3310_ext_info,			\
 }
 
+#define STK36C61_INTENSITY_CHANNEL(_mod, _reg) {	\
+	.type = IIO_INTENSITY,				\
+	.modified = 1,					\
+	.channel2 = IIO_MOD_LIGHT_##_mod,		\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+	.address = _reg,				\
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
@@ -225,6 +249,12 @@ static const struct stk3310_chip_info stk3310_chip_info = {
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
@@ -400,7 +430,8 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
 	struct stk3310_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
 
-	if (chan->type != IIO_LIGHT && chan->type != IIO_PROXIMITY)
+	if (chan->type != IIO_LIGHT && chan->type != IIO_PROXIMITY &&
+	    chan->type != IIO_INTENSITY)
 		return -EINVAL;
 
 	switch (mask) {
@@ -419,8 +450,10 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_INT_TIME:
 		if (chan->type == IIO_LIGHT)
 			ret = regmap_field_read(data->reg_als_it, &index);
-		else
+		else if (chan->type == IIO_PROXIMITY)
 			ret = regmap_field_read(data->reg_ps_it, &index);
+		else
+			return -EINVAL;
 		if (ret < 0)
 			return ret;
 
@@ -430,8 +463,10 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type == IIO_LIGHT)
 			ret = regmap_field_read(data->reg_als_gain, &index);
-		else
+		else if (chan->type == IIO_PROXIMITY)
 			ret = regmap_field_read(data->reg_ps_gain, &index);
+		else
+			return -EINVAL;
 		if (ret < 0)
 			return ret;
 
@@ -567,6 +602,7 @@ static bool stk3310_is_volatile_reg(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case STK3310_REG_ALS_DATA_MSB:
 	case STK3310_REG_ALS_DATA_LSB:
+	case STK36C61_REG_RED_DATA_MSB ... STK36C61_REG_CLEAR_DATA_LSB:
 	case STK3310_REG_PS_DATA_LSB:
 	case STK3310_REG_PS_DATA_MSB:
 	case STK3310_REG_FLAG:
@@ -801,6 +837,7 @@ static const struct i2c_device_id stk3310_i2c_id[] = {
 	{ .name = "STK3310", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
 	{ .name = "STK3311", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
 	{ .name = "STK3335", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
+	{ .name = "STK36C61", .driver_data = (kernel_ulong_t)&stk36c61_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
@@ -819,6 +856,7 @@ static const struct of_device_id stk3310_of_match[] = {
 	{ .compatible = "sensortek,stk3310", .data = &stk3310_chip_info },
 	{ .compatible = "sensortek,stk3311", .data = &stk3310_chip_info },
 	{ .compatible = "sensortek,stk3335", .data = &stk3310_chip_info },
+	{ .compatible = "sensortek,stk36c61", .data = &stk36c61_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, stk3310_of_match);
-- 
2.55.0

