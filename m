Received: from out-2z4y-a139.jellyfish.systems (out-2z4y-a139.jellyfish.systems [198.54.127.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB41347142B
	for <linux-iio@vger.kernel.org>; Wed, 26 Aug 2026 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787767670; cv=none; b=ohXEoW5vGSSH3DqQj6DkyJDdE2r+kBvvye0MyD3QFffnEUvb5aMQn+IWin6wpvdRkQ+ujF4g/8NEu8+RO4rM6H0dplsmuQRRQ1V6AYdMKbNR0q4T2lkHg7sk8m487guo4vvfieZpokkdIIdEE6FEdmLWrhED4pev+Eir7MM5jTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787767670; c=relaxed/simple;
	bh=nJdQI8BEZEemf2xtWVmqcjOljCyAezykSB2m5Eya7Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKGiur8KrZeTL6/SUSA9kbXRZ2j2kSoSJWsRY3xN5Hz5n04O7+EHrH/V0ODzOKpNIn4dnoyTE0tlsSsqvLSzkVrnzs2U+W4PpI69y7z6lBGvhVyokdtz90ci4pgulY4adc3F4ibBtOEj+Afaw7FBjEyE0XQFwuabV6kSEh8kPOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hVXN82YGrz8sWP;
	Wed, 26 Aug 2026 17:54:32 +0000 (UTC)
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
Subject: [PATCH v2 4/5] iio: light: stk3310: add per-chip match data
Date: Wed, 26 Aug 2026 19:54:08 +0200
Message-ID: <20260826175409.326131-5-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

Introduce a chip_info structure carrying the device name and channel
specification, attach it to every i2c, OF and ACPI table entry, and
let probe take it from the match data, failing when there is none.
Every firmware bind path carries match data, and with the id names in
lower case a client instantiated through the sysfs new_device
interface under a compatible-derived name receives it through the id
table. The shared channel definitions move into macros.

The ACPI table entries change to named initializers, matching the
other id tables.

This is a preparatory change for a variant that provides more channels
than the existing parts. No functional change for firmware-described
devices; a sysfs client under a name that binds without matching any
id entry (the full compatible string) now fails probe with an error
instead of probing as an stk3310.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 drivers/iio/light/stk3310.c | 95 ++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 156888969366..d632e6447f06 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -181,26 +181,48 @@ static const struct iio_chan_spec_ext_info stk3310_ext_info[] = {
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
-		.address = STK3310_REG_ALS_DATA_MSB,
-		.info_mask_separate =
-			BIT(IIO_CHAN_INFO_RAW) |
-			BIT(IIO_CHAN_INFO_SCALE) |
-			BIT(IIO_CHAN_INFO_INT_TIME),
-	},
-	{
-		.type = IIO_PROXIMITY,
-		.address = STK3310_REG_PS_DATA_MSB,
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
@@ -632,10 +654,16 @@ static irqreturn_t stk3310_irq_event_handler(int irq, void *private)
 
 static int stk3310_probe(struct i2c_client *client)
 {
+	const struct stk3310_chip_info *chip_info;
 	int ret;
 	struct iio_dev *indio_dev;
 	struct stk3310_data *data;
 
+	chip_info = i2c_get_match_data(client);
+	if (!chip_info)
+		return dev_err_probe(&client->dev, -ENODEV,
+				     "missing driver data\n");
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -654,10 +682,10 @@ static int stk3310_probe(struct i2c_client *client)
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
@@ -763,28 +791,27 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend,
 				stk3310_resume);
 
 static const struct i2c_device_id stk3310_i2c_id[] = {
-	{ .name = "stk3013" },
-	{ .name = "stk3310" },
-	{ .name = "stk3311" },
-	{ .name = "stk3335" },
+	{ .name = "stk3013", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
+	{ .name = "stk3310", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
+	{ .name = "stk3311", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
+	{ .name = "stk3335", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
 
 static const struct acpi_device_id stk3310_acpi_id[] = {
-	{"STK3013", 0},
-	{"STK3310", 0},
-	{"STK3311", 0},
+	{ .id = "STK3013", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
+	{ .id = "STK3310", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
+	{ .id = "STK3311", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
 	{ }
 };
-
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

