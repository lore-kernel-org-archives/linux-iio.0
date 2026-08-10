Received: from out-2z4y-a134.jellyfish.systems (out-2z4y-a134.jellyfish.systems [198.54.127.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934CE397945
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786360215; cv=none; b=n402RKMfAybtg4xvEGpBdeXaBjH0PDSEn/Pv49jathvzGfW1/DfuGsMv/ot8aglV+eWz0NmYjtMUYT3Tj8gbd58E5HftbNOHzfj75D3gczUgaDZJBVMQ3bJfuz5bZlk+Y5EYVEpkX1jdEMMDJvoJ+2i1fuxoqcH9gzxXoUlbcb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786360215; c=relaxed/simple;
	bh=sBvM+tDWMz5O+hEmeCj8uf9pMYKp0SvqXvWOJDd2SQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAcV21Aw4N+8X17OtOVnv9D/8PvgTF04xbu0duK9k50WpCHsDnqzU1MnORQxKXvzlu3zb3HdGh79XCSzQbvIPPEbkw6IT2UsSpPTfJjK/7/eTl0NIdY+dlFtysYechUSmRpOunkz6btl6BFpMoLVOtObvHo3Fipzq2+Xm5jto9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hJX2f5Tmmz8sWP;
	Mon, 10 Aug 2026 11:04:42 +0000 (UTC)
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
Subject: [PATCH 2/3] iio: light: stk3310: add per-chip match data
Date: Mon, 10 Aug 2026 13:04:22 +0200
Message-ID: <20260810110423.41697-3-jorijnvdgraaf@catcrafts.net>
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

Introduce a chip_info structure carrying the device name and channel
specification, attach it to every i2c, OF and ACPI table entry, and let
probe take it from the match data. Clients instantiated through the
sysfs new_device interface under the lowercase compatible-derived name
have no firmware node and do not match the uppercase id table entries,
so absent match data falls back to the original chip data. The channel
data registers move into .address and the shared channel definitions
into macros.

This is a preparatory change for a variant that provides more channels
than the existing parts. No functional change.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 drivers/iio/light/stk3310.c | 107 +++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 7c8a1d2b2ed0..249396b9bf80 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -181,24 +181,48 @@ static const struct iio_chan_spec_ext_info stk3310_ext_info[] = {
 	{ }
 };
 
+#define STK3310_LIGHT_CHANNEL {				\
+	.type = IIO_LIGHT,				\
+	.address = STK3310_REG_ALS_DATA_MSB,		\
+	.info_mask_separate =				\
+		BIT(IIO_CHAN_INFO_RAW) |		\
+		BIT(IIO_CHAN_INFO_SCALE) |		\
+		BIT(IIO_CHAN_INFO_INT_TIME),		\
+}
+
+#define STK3310_PROXIMITY_CHANNEL {			\
+	.type = IIO_PROXIMITY,				\
+	.address = STK3310_REG_PS_DATA_MSB,		\
+	.info_mask_separate =				\
+		BIT(IIO_CHAN_INFO_RAW) |		\
+		BIT(IIO_CHAN_INFO_SCALE) |		\
+		BIT(IIO_CHAN_INFO_INT_TIME),		\
+	.event_spec = stk3310_events,			\
+	.num_event_specs = ARRAY_SIZE(stk3310_events),	\
+	.ext_info = stk3310_ext_info,			\
+}
+
 static const struct iio_chan_spec stk3310_channels[] = {
-	{
-		.type = IIO_LIGHT,
-		.info_mask_separate =
-			BIT(IIO_CHAN_INFO_RAW) |
-			BIT(IIO_CHAN_INFO_SCALE) |
-			BIT(IIO_CHAN_INFO_INT_TIME),
-	},
-	{
-		.type = IIO_PROXIMITY,
-		.info_mask_separate =
-			BIT(IIO_CHAN_INFO_RAW) |
-			BIT(IIO_CHAN_INFO_SCALE) |
-			BIT(IIO_CHAN_INFO_INT_TIME),
-		.event_spec = stk3310_events,
-		.num_event_specs = ARRAY_SIZE(stk3310_events),
-		.ext_info = stk3310_ext_info,
-	}
+	STK3310_LIGHT_CHANNEL,
+	STK3310_PROXIMITY_CHANNEL,
+};
+
+/**
+ * struct stk3310_chip_info - chip-specific data
+ * @name: device name reported to the IIO core
+ * @channels: channel specification
+ * @num_channels: number of channels
+ */
+struct stk3310_chip_info {
+	const char			*name;
+	const struct iio_chan_spec	*channels __counted_by_ptr(num_channels);
+	unsigned int			num_channels;
+};
+
+static const struct stk3310_chip_info stk3310_chip_info = {
+	.name = STK3310_DRIVER_NAME,
+	.channels = stk3310_channels,
+	.num_channels = ARRAY_SIZE(stk3310_channels),
 };
 
 static IIO_CONST_ATTR(in_illuminance_scale_available, STK3310_SCALE_AVAILABLE);
@@ -370,7 +394,6 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
 {
-	u8 reg;
 	__be16 buf;
 	int ret;
 	unsigned int index;
@@ -382,13 +405,9 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (chan->type == IIO_LIGHT)
-			reg = STK3310_REG_ALS_DATA_MSB;
-		else
-			reg = STK3310_REG_PS_DATA_MSB;
-
 		mutex_lock(&data->lock);
-		ret = regmap_bulk_read(data->regmap, reg, &buf, sizeof(buf));
+		ret = regmap_bulk_read(data->regmap, chan->address, &buf,
+				       sizeof(buf));
 		if (ret < 0) {
 			dev_err(&client->dev, "register read failed\n");
 			mutex_unlock(&data->lock);
@@ -635,10 +654,22 @@ static irqreturn_t stk3310_irq_event_handler(int irq, void *private)
 
 static int stk3310_probe(struct i2c_client *client)
 {
+	const struct stk3310_chip_info *chip_info;
 	int ret;
 	struct iio_dev *indio_dev;
 	struct stk3310_data *data;
 
+	chip_info = i2c_get_match_data(client);
+	if (!chip_info) {
+		/*
+		 * Clients instantiated through the sysfs new_device
+		 * interface under the lowercase compatible-derived name
+		 * have no firmware node and do not match the uppercase
+		 * id table entries.
+		 */
+		chip_info = &stk3310_chip_info;
+	}
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -657,10 +688,10 @@ static int stk3310_probe(struct i2c_client *client)
 		return ret;
 
 	indio_dev->info = &stk3310_info;
-	indio_dev->name = STK3310_DRIVER_NAME;
+	indio_dev->name = chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = stk3310_channels;
-	indio_dev->num_channels = ARRAY_SIZE(stk3310_channels);
+	indio_dev->channels = chip_info->channels;
+	indio_dev->num_channels = chip_info->num_channels;
 
 	ret = stk3310_init(indio_dev);
 	if (ret < 0)
@@ -766,28 +797,28 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend,
 				stk3310_resume);
 
 static const struct i2c_device_id stk3310_i2c_id[] = {
-	{ .name = "STK3013" },
-	{ .name = "STK3310" },
-	{ .name = "STK3311" },
-	{ .name = "STK3335" },
+	{ .name = "STK3013", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
+	{ .name = "STK3310", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
+	{ .name = "STK3311", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
+	{ .name = "STK3335", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
 
 static const struct acpi_device_id stk3310_acpi_id[] = {
-	{"STK3013", 0},
-	{"STK3310", 0},
-	{"STK3311", 0},
+	{"STK3013", (kernel_ulong_t)&stk3310_chip_info},
+	{"STK3310", (kernel_ulong_t)&stk3310_chip_info},
+	{"STK3311", (kernel_ulong_t)&stk3310_chip_info},
 	{ }
 };
 
 MODULE_DEVICE_TABLE(acpi, stk3310_acpi_id);
 
 static const struct of_device_id stk3310_of_match[] = {
-	{ .compatible = "sensortek,stk3013", },
-	{ .compatible = "sensortek,stk3310", },
-	{ .compatible = "sensortek,stk3311", },
-	{ .compatible = "sensortek,stk3335", },
+	{ .compatible = "sensortek,stk3013", .data = &stk3310_chip_info },
+	{ .compatible = "sensortek,stk3310", .data = &stk3310_chip_info },
+	{ .compatible = "sensortek,stk3311", .data = &stk3310_chip_info },
+	{ .compatible = "sensortek,stk3335", .data = &stk3310_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, stk3310_of_match);
-- 
2.55.0

