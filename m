Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD6A3CAE73
	for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 12:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789301934; cv=none; b=TliOq4iIjUeTuby1hi6eLpqW9TDBuvlQYBFVAaqkL0VBgCyWzX8aO261ur0IMzc311zgSQrJX7Vay40cIx8k+dmCb9yccMC/PTfVdWkJ0OUSZGGJY9cfntcLQmd4jeTjsJkO7L3In+oKSWP58oA2t6VLRGCcIQiO8NX0/OzODmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789301934; c=relaxed/simple;
	bh=eZrm9VgPDfvj9NnGaY/C3bGlOsNzm2Q/fr2DsEYcE3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G7CalwEDU8OtIFgmxDjd43rZm+dGjG5yus6Yj7LBl3MMgTglt/9tPsSCDX+l1YJNVyW2wijfbZyljMk5pKjLQNA2x65FU6Rr40TzSiMRvkJKEiytkFpu0M76JX0enJQAJCQNWtxKOg+MlQt/y4JiHuVbdtwNuQB1GnuJOxSpNfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tbxihx3w; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tbxihx3w"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dc83so731072f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 05:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789301928; x=1789906728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q8szB8DqOyKitYp7jPFMXf9uh6tzDvRuFilkb29yz70=;
        b=Tbxihx3wStb1K03OaXNqWggND5m/aUaratKs4eY9wXjtAqVCM1mo3jByzCuvT71Yqw
         RxnGCVevMYngdGRKYich5bb2am9Wx5vG5cuxpu4FQ30WEIoiOI0KfThVYOOmX8RRTYYl
         u+dzxyw1u7V0X4ObPYbi2roc1OvbN4yvTlVmiIfU4Bhlp5OtqujgE7mBx0HdJp5uronk
         ogUEQbAOkrZoDXxGIXqM8B6/QygyKIciCQM/2dE3beFA9M3IXxScUHJqrgVcihhLB/ip
         Iz+bVXEzOhFEOISznhlR6IslpW9eZhPV8mQlRdQSLedpND9NKpowv9SW2+74P3EoXEZr
         gXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789301928; x=1789906728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q8szB8DqOyKitYp7jPFMXf9uh6tzDvRuFilkb29yz70=;
        b=ngq4G5FkgUg9C/c6m+rgFVEraRiM2goBsNTtE3EAvL7thaOOADUmDkYst1TffdqKHM
         pTPRWRQ+r5/XQphBUZIqnB1Upknb+bgva/h7zhGlS1bqmMmRrG9yvvy+Khfv88uiv+3g
         62GGhQEDOYrcn2F0x96ydzw1r0V9mV64Siz2rQifQ/LtMHnIyfs60udsgQ97GQ5YAXws
         tjqV3Oqh+CAVAbz4YnFx+AgzpI+SRm0bCupmAPHPZdYtkYLBK91neHI8n2Y3DzXUeHFY
         NChIg+uNjBm2725G8uMrhQ4CWUePZ1qLQfETpMQ3y2bT5klCM2bbmfM8OXvGc5OTK/mv
         5lvQ==
X-Gm-Message-State: AFuF++k5beQNTWXaAZzcZyt4+0Wb3EK8sZ5QB3tV9Jsk8Ivccu1iblQo
	jzD3/O3aC8qJl8tevfSuEy3i3EGJbvnMi3QnfLoVS5hDVKW54tFHZDE3
X-Gm-Gg: AYBFou38KZ7quV8GDzcYDFOsgnf0kx1Suk/tqbKRZqwXZ0pr8HkN90cKh92abHhCCSh
	ixXEgIENH9+iOyVyyjXAcH2EKrB07orEGuo7EIThkuPDdeubGCCaVRmrKnkIPcJAZ+cq1QQ5WCb
	+hkwOKICB5PTL2PaEHxKsex+ql9f9E1n7at64V2w0melqM57SswoH5UW8Jky2ljl2Epw4daqTiY
	JrmjCIev0A2+auDOJBF0YL7HbsCJGoZ0ZUK7pGqz+wOkBcQd1bpbghxqJdiLmtYj26RvD/ohKPv
	pbieLkQbpI/8+SPzrGCnraSu+5BjrA5IttYV3ztXGmcl6ielfDvyO9SMLS5sL9/Vl8AB22cwdKI
	8zT2/LC4yOvUdGN5/wH+ViCrdwYhHpoSR1A76rgQKdRZJfgkhcdWxestuARU/eovplIFkQ0O+SZ
	SWWy82YVQQNptXLJ+VGtI+12mss+Ob2/TvAANJU3AFVwqAQimQpY893ycG44ervDTp2WfZrj2Iu
	x7QFehsH5rVYVw=
X-Received: by 2002:a05:6000:402a:b0:486:f4ba:58d6 with SMTP id ffacd0b85a97d-486f6bedeb7mr5941438f8f.12.1789301927305;
        Sun, 13 Sep 2026 05:18:47 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:107:bfd1:de2c:7b4b:8652:b761])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf2esm20241141f8f.2.2026.09.13.05.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 05:18:46 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 13 Sep 2026 14:18:24 +0200
Subject: [PATCH v10 4/4] iio: light: veml6031x00: add support for events
 and trigger
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-veml6031x00-v10-4-adbc26c30d3d@gmail.com>
References: <20260913-veml6031x00-v10-0-adbc26c30d3d@gmail.com>
In-Reply-To: <20260913-veml6031x00-v10-0-adbc26c30d3d@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789301917; l=24576;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=eZrm9VgPDfvj9NnGaY/C3bGlOsNzm2Q/fr2DsEYcE3s=;
 b=Vqhe+v5G6R8Nb72uIY/x7/x3Pa5IL91J/n713RQWTHajvogsN4+CdjD1HZgw/1lcDRbUSJiV0
 WN9VJJTmQD+BJMIkG2dWRNvlOMV4VCMLQ62l7LS/TG9jH407ag6P7TA
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

The device provides a shared interrupt line to notify events and
data ready.

Add support for configurations with and without an interrupt line,
providing events and trigger support when an interrupt line is available.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6031x00.c | 604 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 597 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
index 3d5a27a0baae..085a6e2ff717 100644
--- a/drivers/iio/light/veml6031x00.c
+++ b/drivers/iio/light/veml6031x00.c
@@ -15,6 +15,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/limits.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
@@ -25,6 +26,9 @@
 #include <asm/byteorder.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/events.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/iio-gts-helper.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
@@ -32,16 +36,28 @@
 /* Device registers */
 #define VEML6031X00_REG_CONF0       0x00
 #define VEML6031X00_REG_CONF1       0x01
+#define VEML6031X00_REG_WH_L        0x04
+#define VEML6031X00_REG_WH_H        0x05
+#define VEML6031X00_REG_WL_L        0x06
+#define VEML6031X00_REG_WL_H        0x07
 #define VEML6031X00_REG_ALS_L       0x10
 #define VEML6031X00_REG_ALS_H       0x11
 #define VEML6031X00_REG_IR_L        0x12
 #define VEML6031X00_REG_IR_H        0x13
 #define VEML6031X00_REG_ID_L        0x14
 #define VEML6031X00_REG_ID_H        0x15
+#define VEML6031X00_REG_INT         0x17
 
 /* Bit masks for specific functionality */
 #define VEML6031X00_CONF0_SD        BIT(0)
+#define VEML6031X00_CONF0_AF_TRIG   BIT(2)
+#define VEML6031X00_CONF0_AF        BIT(3)
 #define VEML6031X00_CONF1_IR_SD     BIT(7)
+#define VEML6031X00_INT_TH_H        BIT(1)
+#define VEML6031X00_INT_TH_L        BIT(2)
+#define VEML6031X00_INT_DRDY        BIT(3)
+#define VEML6031X00_INT_MASK \
+	(VEML6031X00_INT_TH_L | VEML6031X00_INT_TH_H | VEML6031X00_INT_DRDY)
 
 #define VEML6031X00_GAIN_SEL(pd_div4, gain) (((pd_div4) << 2) | (gain))
 
@@ -53,8 +69,10 @@ enum veml6031x00_scan {
 
 struct veml6031x00_rf {
 	struct regmap_field *gain;
+	struct regmap_field *int_en;
 	struct regmap_field *it;
 	struct regmap_field *pd_div4;
+	struct regmap_field *pers;
 };
 
 struct veml6031x00_chip {
@@ -65,6 +83,7 @@ struct veml6031x00_chip {
 struct veml6031x00_data {
 	struct iio_gts gts;
 	struct regmap *regmap;
+	struct iio_trigger *trig;
 	struct veml6031x00_rf rf;
 	const struct veml6031x00_chip *chip;
 	/*
@@ -73,6 +92,14 @@ struct veml6031x00_data {
 	 * consistent set.
 	 */
 	struct mutex scale_lock;
+	/*
+	 * Serialize access to irq enable/disable by events and trigger
+	 * (shared line).
+	 */
+	struct mutex irq_lock;
+	unsigned int interrupt_users;
+	bool ev_en;
+	bool trig_en;
 };
 
 static const struct iio_itime_sel_mul veml6031x00_it_sel[] = {
@@ -107,6 +134,17 @@ static const struct iio_gain_sel_pair veml6031x00_gain_sel[] = {
 	GAIN_SCALE_GAIN(16, VEML6031X00_SEL_GAIN_2_000),
 };
 
+static IIO_CONST_ATTR(in_illuminance_thresh_either_period_available, "1 2 4 8");
+
+static struct attribute *veml6031x00_event_attributes[] = {
+	&iio_const_attr_in_illuminance_thresh_either_period_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group veml6031x00_event_attr_group = {
+	.attrs = veml6031x00_event_attributes,
+};
+
 /*
  * The shutdown bits (SD and ALS_IR_SD) are in different registers, and both
  * must be updated when changing the device power state.
@@ -135,6 +173,23 @@ static void veml6031x00_als_shutdown_action(void *data)
 		dev_warn(dev, "Failed to shut down device: %d\n", ret);
 }
 
+static const struct iio_event_spec veml6031x00_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_PERIOD) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 static const struct iio_chan_spec veml6031x00_channels[] = {
 	{
 		.type = IIO_LIGHT,
@@ -169,9 +224,47 @@ static const struct iio_chan_spec veml6031x00_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(VEML6031X00_SCAN_TIMESTAMP),
 };
 
+static const struct iio_chan_spec veml6031x00_channels_irq[] = {
+	{
+		.type = IIO_LIGHT,
+		.address = VEML6031X00_REG_ALS_L,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_INT_TIME) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = veml6031x00_event_spec,
+		.num_event_specs = ARRAY_SIZE(veml6031x00_event_spec),
+		.scan_index = VEML6031X00_SCAN_ALS,
+		.scan_type = {
+			.format = IIO_SCAN_FORMAT_UNSIGNED_INT,
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	{
+		.type = IIO_INTENSITY,
+		.address = VEML6031X00_REG_IR_L,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_IR,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_index = VEML6031X00_SCAN_IR,
+		.scan_type = {
+			.format = IIO_SCAN_FORMAT_UNSIGNED_INT,
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(VEML6031X00_SCAN_TIMESTAMP),
+};
+
 static const struct regmap_range veml6031x00_readable_ranges[] = {
 	regmap_reg_range(VEML6031X00_REG_CONF0, VEML6031X00_REG_CONF1),
+	regmap_reg_range(VEML6031X00_REG_WH_L, VEML6031X00_REG_WL_H),
 	regmap_reg_range(VEML6031X00_REG_ALS_L, VEML6031X00_REG_ID_H),
+	regmap_reg_range(VEML6031X00_REG_INT, VEML6031X00_REG_INT),
 };
 
 static const struct regmap_access_table veml6031x00_readable_table = {
@@ -181,6 +274,7 @@ static const struct regmap_access_table veml6031x00_readable_table = {
 
 static const struct regmap_range veml6031x00_writable_ranges[] = {
 	regmap_reg_range(VEML6031X00_REG_CONF0, VEML6031X00_REG_CONF1),
+	regmap_reg_range(VEML6031X00_REG_WH_L, VEML6031X00_REG_WL_H),
 };
 
 static const struct regmap_access_table veml6031x00_writable_table = {
@@ -192,6 +286,7 @@ static const struct regmap_range veml6031x00_volatile_ranges[] = {
 	/* AF_TRIG in CONF0 is volatile */
 	regmap_reg_range(VEML6031X00_REG_CONF0, VEML6031X00_REG_CONF0),
 	regmap_reg_range(VEML6031X00_REG_ALS_L, VEML6031X00_REG_IR_H),
+	regmap_reg_range(VEML6031X00_REG_INT, VEML6031X00_REG_INT),
 };
 
 static const struct regmap_access_table veml6031x00_volatile_table = {
@@ -199,6 +294,15 @@ static const struct regmap_access_table veml6031x00_volatile_table = {
 	.n_yes_ranges = ARRAY_SIZE(veml6031x00_volatile_ranges),
 };
 
+static const struct regmap_range veml6031x00_precious_ranges[] = {
+	regmap_reg_range(VEML6031X00_REG_INT, VEML6031X00_REG_INT),
+};
+
+static const struct regmap_access_table veml6031x00_precious_table = {
+	.yes_ranges = veml6031x00_precious_ranges,
+	.n_yes_ranges = ARRAY_SIZE(veml6031x00_precious_ranges),
+};
+
 static const struct regmap_config veml6031x00_regmap_config = {
 	.name = "veml6031x00_regmap",
 	.reg_bits = 8,
@@ -206,13 +310,20 @@ static const struct regmap_config veml6031x00_regmap_config = {
 	.rd_table = &veml6031x00_readable_table,
 	.wr_table = &veml6031x00_writable_table,
 	.volatile_table = &veml6031x00_volatile_table,
-	.max_register = VEML6031X00_REG_ID_H,
+	.precious_table = &veml6031x00_precious_table,
+	.max_register = VEML6031X00_REG_INT,
 	.cache_type = REGCACHE_MAPLE,
 };
 
+static const struct reg_field veml6031x00_rf_int_en =
+	REG_FIELD(VEML6031X00_REG_CONF0, 1, 1);
+
 static const struct reg_field veml6031x00_rf_it =
 	REG_FIELD(VEML6031X00_REG_CONF0, 4, 6);
 
+static const struct reg_field veml6031x00_rf_pers =
+	REG_FIELD(VEML6031X00_REG_CONF1, 1, 2);
+
 static const struct reg_field veml6031x00_rf_gain =
 	REG_FIELD(VEML6031X00_REG_CONF1, 3, 4);
 
@@ -236,11 +347,21 @@ static int veml6031x00_regfield_init(struct veml6031x00_data *data)
 		return PTR_ERR(rm_field);
 	rf->it = rm_field;
 
+	rm_field = devm_regmap_field_alloc(dev, map, veml6031x00_rf_int_en);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->int_en = rm_field;
+
 	rm_field = devm_regmap_field_alloc(dev, map, veml6031x00_rf_pd_div4);
 	if (IS_ERR(rm_field))
 		return PTR_ERR(rm_field);
 	rf->pd_div4 = rm_field;
 
+	rm_field = devm_regmap_field_alloc(dev, map, veml6031x00_rf_pers);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->pers = rm_field;
+
 	return 0;
 }
 
@@ -341,6 +462,31 @@ static int veml6031x00_set_it(struct iio_dev *iio, int val, int val2)
 	return veml6031x00_write_gain(data, gain_sel);
 }
 
+static int veml6031x00_read_period(struct iio_dev *iio, int *val)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_field_read(data->rf.pers, &regval);
+	if (ret)
+		return ret;
+
+	*val = BIT(regval);
+
+	return IIO_VAL_INT;
+}
+
+static int veml6031x00_write_period(struct iio_dev *iio, int val)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+
+	if (val < 0 || val > 8 || !is_power_of_2(val))
+		return -EINVAL;
+
+	return regmap_field_write(data->rf.pers, ilog2(val));
+}
+
 static int veml6031x00_set_scale(struct iio_dev *iio, int val, int val2)
 {
 	struct veml6031x00_data *data = iio_priv(iio);
@@ -395,6 +541,55 @@ static int veml6031x00_get_scale(struct veml6031x00_data *data, int *val, int *v
 	return IIO_VAL_INT_PLUS_NANO;
 }
 
+static int veml6031x00_read_th(struct iio_dev *iio, enum iio_event_direction dir,
+			       int *val, int *val2)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	__le16 regval;
+	int ret;
+
+	if (dir == IIO_EV_DIR_RISING)
+		ret = regmap_bulk_read(data->regmap, VEML6031X00_REG_WH_L,
+				       &regval, sizeof(regval));
+	else
+		ret = regmap_bulk_read(data->regmap, VEML6031X00_REG_WL_L,
+				       &regval, sizeof(regval));
+	if (ret)
+		return ret;
+
+	*val = le16_to_cpu(regval);
+
+	return IIO_VAL_INT;
+}
+
+static int veml6031x00_write_th(struct iio_dev *iio, enum iio_event_direction dir,
+				int val, int val2)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = regmap_get_device(data->regmap);
+	__le16 regval;
+	int ret;
+
+	if (val < 0 || val > U16_MAX || val2)
+		return -EINVAL;
+
+	regval = cpu_to_le16(val);
+
+	if (dir == IIO_EV_DIR_RISING) {
+		ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WH_L,
+					&regval, sizeof(regval));
+		if (ret)
+			dev_dbg(dev, "Failed to set high threshold %d\n", ret);
+	} else {
+		ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WL_L,
+					&regval, sizeof(regval));
+		if (ret)
+			dev_dbg(dev, "Failed to set low threshold %d\n", ret);
+	}
+
+	return ret;
+}
+
 static int veml6031x00_single_read(struct iio_dev *iio, enum iio_chan_type type,
 				   int *val)
 {
@@ -509,13 +704,243 @@ static int veml6031x00_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+static int veml6031x00_set_interrupt(struct veml6031x00_data *data, bool state)
+	__must_hold(&data->irq_lock)
+{
+	int ret;
+
+	lockdep_assert_held(&data->irq_lock);
+
+	if (state) {
+		data->interrupt_users++;
+		if (data->interrupt_users > 1)
+			return 0;
+	} else {
+		if (!data->interrupt_users)
+			return 0;
+
+		data->interrupt_users--;
+		if (data->interrupt_users > 0)
+			return 0;
+	}
+
+	ret = regmap_field_write(data->rf.int_en, state);
+	if (ret) {
+		if (state)
+			data->interrupt_users--;
+		else
+			data->interrupt_users++;
+	}
+
+	return ret;
+}
+
+static int veml6031x00_read_event_val(struct iio_dev *iio,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      enum iio_event_info info,
+				      int *val, int *val2)
+{
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		if (dir == IIO_EV_DIR_EITHER && info == IIO_EV_INFO_PERIOD)
+			return veml6031x00_read_period(iio, val);
+
+		return veml6031x00_read_th(iio, dir, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6031x00_write_event_val(struct iio_dev *iio,
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir,
+				       enum iio_event_info info,
+				       int val, int val2)
+{
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		return veml6031x00_write_th(iio, dir, val, val2);
+	case IIO_EV_INFO_PERIOD:
+		return veml6031x00_write_period(iio, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6031x00_read_event_config(struct iio_dev *iio,
+					 const struct iio_chan_spec *chan,
+					 enum iio_event_type type,
+					 enum iio_event_direction dir)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+
+	guard(mutex)(&data->irq_lock);
+
+	return data->ev_en;
+}
+
+static int veml6031x00_event_enable(struct veml6031x00_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	ret = veml6031x00_set_interrupt(data, true);
+	if (ret) {
+		pm_runtime_put_autosuspend(dev);
+		return ret;
+	}
+
+	data->ev_en = true;
+
+	return 0;
+}
+
+static int veml6031x00_event_disable(struct veml6031x00_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	ret = veml6031x00_set_interrupt(data, false);
+	if (ret)
+		return ret;
+
+	data->ev_en = false;
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+static int veml6031x00_write_event_config(struct iio_dev *iio,
+					  const struct iio_chan_spec *chan,
+					  enum iio_event_type type,
+					  enum iio_event_direction dir,
+					  bool state)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+
+	guard(mutex)(&data->irq_lock);
+
+	/* avoid multiple increments/decrements from one source */
+	if (state == data->ev_en)
+		return 0;
+
+	if (state)
+		return veml6031x00_event_enable(data);
+
+	return veml6031x00_event_disable(data);
+}
+
+static void veml6031x00_disable_event_action(void *arg)
+{
+	struct veml6031x00_data *data = arg;
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	guard(mutex)(&data->irq_lock);
+
+	if (!data->ev_en)
+		return;
+
+	ret = veml6031x00_set_interrupt(data, false);
+	if (ret)
+		dev_err(dev, "Failed to disable events: %d\n", ret);
+	else
+		data->ev_en = false;
+
+	pm_runtime_put_sync(dev);
+}
+
 static const struct iio_info veml6031x00_info = {
 	.read_raw = veml6031x00_read_raw,
 	.read_avail = veml6031x00_read_avail,
 	.write_raw = veml6031x00_write_raw,
 	.write_raw_get_fmt = veml6031x00_write_raw_get_fmt,
+	.read_event_value = veml6031x00_read_event_val,
+	.write_event_value = veml6031x00_write_event_val,
+	.read_event_config = veml6031x00_read_event_config,
+	.write_event_config = veml6031x00_write_event_config,
+	.event_attrs = &veml6031x00_event_attr_group,
 };
 
+static const struct iio_info veml6031x00_info_no_irq = {
+	.read_raw = veml6031x00_read_raw,
+	.read_avail = veml6031x00_read_avail,
+	.write_raw = veml6031x00_write_raw,
+	.write_raw_get_fmt = veml6031x00_write_raw_get_fmt,
+};
+
+static irqreturn_t veml6031x00_irq(int irq, void *private)
+{
+	struct iio_dev *iio = private;
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = regmap_get_device(data->regmap);
+	s64 timestamp;
+	unsigned int regval;
+	int ret;
+	bool trigger_poll;
+
+	ret = pm_runtime_get_if_active(dev);
+	if (ret <= 0)
+		return IRQ_NONE;
+
+	scoped_guard(mutex, &data->irq_lock) {
+		ret = regmap_read(data->regmap, VEML6031X00_REG_INT, &regval);
+		if (ret) {
+			dev_dbg(dev, "Failed to read interrupt register %d\n", ret);
+			pm_runtime_put(dev);
+			return IRQ_NONE;
+		}
+
+		if (!(regval & VEML6031X00_INT_MASK)) {
+			pm_runtime_put(dev);
+			return IRQ_NONE;
+		}
+
+		timestamp = iio_get_time_ns(iio);
+
+		if (data->ev_en &&
+		    (regval & (VEML6031X00_INT_TH_H | VEML6031X00_INT_TH_L))) {
+			if (regval & VEML6031X00_INT_TH_H)
+				iio_push_event(iio,
+					       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+								    IIO_EV_TYPE_THRESH,
+								    IIO_EV_DIR_RISING),
+					       timestamp);
+			if (regval & VEML6031X00_INT_TH_L)
+				iio_push_event(iio,
+					       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+								    IIO_EV_TYPE_THRESH,
+								    IIO_EV_DIR_FALLING),
+					       timestamp);
+		}
+
+		trigger_poll = data->trig_en && (regval & VEML6031X00_INT_DRDY);
+	}
+
+	/*
+	 * iio_trigger_poll_nested() must be called with irq_lock released:
+	 * it runs trig_handler() synchronously in this thread, which calls
+	 * reenable() on completion, and that callback also takes irq_lock.
+	 * iio_pollfunc_store_time() is not called for our own trigger, so the
+	 * timestamp is stored here.
+	 */
+	if (trigger_poll) {
+		iio->pollfunc->timestamp = timestamp;
+		iio_trigger_poll_nested(data->trig);
+	}
+
+	pm_runtime_put(dev);
+
+	return IRQ_HANDLED;
+}
+
 static int veml6031x00_buffer_preenable(struct iio_dev *iio)
 {
 	struct veml6031x00_data *data = iio_priv(iio);
@@ -551,11 +976,85 @@ static int veml6031x00_buffer_postdisable(struct iio_dev *iio)
 	return 0;
 }
 
+static int __veml6031x00_set_trigger_state(struct veml6031x00_data *data,
+					   bool state)
+	__must_hold(&data->irq_lock)
+{
+	int ret;
+
+	lockdep_assert_held(&data->irq_lock);
+
+	ret = veml6031x00_set_interrupt(data, state);
+	if (ret)
+		return ret;
+
+	/* The AF bit must be updated before updating AF_TRIG */
+	ret = regmap_assign_bits(data->regmap, VEML6031X00_REG_CONF0,
+				 VEML6031X00_CONF0_AF, state);
+	if (ret)
+		goto disable_trigger;
+
+	ret = regmap_assign_bits(data->regmap, VEML6031X00_REG_CONF0,
+				 VEML6031X00_CONF0_AF_TRIG, state);
+	if (ret) {
+		regmap_assign_bits(data->regmap, VEML6031X00_REG_CONF0,
+				   VEML6031X00_CONF0_AF, false);
+		goto disable_trigger;
+	}
+
+	data->trig_en = state;
+
+	return 0;
+
+disable_trigger:
+	data->trig_en = false;
+	if (state)
+		veml6031x00_set_interrupt(data, false);
+	return ret;
+}
+
+static int veml6031x00_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *iio = iio_trigger_get_drvdata(trig);
+	struct veml6031x00_data *data = iio_priv(iio);
+
+	guard(mutex)(&data->irq_lock);
+
+	if (state == data->trig_en)
+		return 0;
+
+	return __veml6031x00_set_trigger_state(data, state);
+}
+
 static const struct iio_buffer_setup_ops veml6031x00_buffer_setup_ops = {
 	.preenable = veml6031x00_buffer_preenable,
 	.postdisable = veml6031x00_buffer_postdisable,
 };
 
+static void veml6031x00_trigger_reenable(struct iio_trigger *trig)
+{
+	struct iio_dev *iio = iio_trigger_get_drvdata(trig);
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ret;
+
+	guard(mutex)(&data->irq_lock);
+
+	if (!data->trig_en)
+		return;
+
+	ret = regmap_assign_bits(data->regmap, VEML6031X00_REG_CONF0,
+				 VEML6031X00_CONF0_AF_TRIG, true);
+	if (ret)
+		dev_err(regmap_get_device(data->regmap),
+			"Failed to reenable trigger: %d\n", ret);
+}
+
+static const struct iio_trigger_ops veml6031x00_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+	.set_trigger_state = veml6031x00_set_trigger_state,
+	.reenable = veml6031x00_trigger_reenable,
+};
+
 static irqreturn_t veml6031x00_trig_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -609,6 +1108,84 @@ static int veml6031x00_validate_part_id(struct veml6031x00_data *data)
 	return 0;
 }
 
+static int veml6031x00_hw_init(struct veml6031x00_data *data)
+{
+	struct regmap *map = data->regmap;
+	struct device *dev = regmap_get_device(map);
+	unsigned int val;
+	__le16 regval;
+	int ret;
+
+	ret = regmap_assign_bits(data->regmap, VEML6031X00_REG_CONF0,
+				 VEML6031X00_CONF0_AF | VEML6031X00_CONF0_AF_TRIG, 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to disable trigger\n");
+
+	regval = 0;
+	ret = regmap_bulk_write(map, VEML6031X00_REG_WL_L, &regval, sizeof(regval));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set low threshold\n");
+
+	regval = cpu_to_le16(U16_MAX);
+	ret = regmap_bulk_write(map, VEML6031X00_REG_WH_L, &regval, sizeof(regval));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set high threshold\n");
+
+	ret = regmap_field_write(data->rf.int_en, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(map, VEML6031X00_REG_INT, &val);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to clear interrupts\n");
+
+	return 0;
+}
+
+static int veml6031x00_setup_trigger(struct iio_dev *iio)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = regmap_get_device(data->regmap);
+
+	data->trig = devm_iio_trigger_alloc(dev, "%s-drdy%d",
+					    iio->name, iio_device_id(iio));
+	if (!data->trig)
+		return -ENOMEM;
+
+	data->trig->ops = &veml6031x00_trigger_ops;
+	iio_trigger_set_drvdata(data->trig, iio);
+
+	return devm_iio_trigger_register(dev, data->trig);
+}
+
+static int veml6031x00_init_iiodev(struct i2c_client *i2c, struct iio_dev *iio)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	iio->name = data->chip->name;
+	iio->modes = INDIO_DIRECT_MODE;
+
+	if (!i2c->irq) {
+		iio->channels = veml6031x00_channels;
+		iio->num_channels = ARRAY_SIZE(veml6031x00_channels);
+		iio->info = &veml6031x00_info_no_irq;
+
+		return 0;
+	}
+
+	iio->channels = veml6031x00_channels_irq;
+	iio->num_channels = ARRAY_SIZE(veml6031x00_channels_irq);
+	iio->info = &veml6031x00_info;
+
+	ret = veml6031x00_setup_trigger(iio);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, veml6031x00_disable_event_action, data);
+}
+
 static int veml6031x00_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
@@ -631,17 +1208,15 @@ static int veml6031x00_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;
 
+	ret = devm_mutex_init(dev, &data->irq_lock);
+	if (ret)
+		return ret;
+
 	data->regmap = devm_regmap_init_i2c(i2c, &veml6031x00_regmap_config);
 	if (IS_ERR(data->regmap))
 		return dev_err_probe(dev, PTR_ERR(data->regmap),
 				     "Failed to set regmap\n");
 
-	iio->name = data->chip->name;
-	iio->channels = veml6031x00_channels;
-	iio->num_channels = ARRAY_SIZE(veml6031x00_channels);
-	iio->modes = INDIO_DIRECT_MODE;
-	iio->info = &veml6031x00_info;
-
 	ret = veml6031x00_regfield_init(data);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to init regfield\n");
@@ -669,6 +1244,10 @@ static int veml6031x00_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;
 
+	ret = veml6031x00_hw_init(data);
+	if (ret)
+		return ret;
+
 	/* Max resolution = 6.9632 lx/cnt for gain = 0.125 and IT = 3.125ms */
 	ret = devm_iio_init_iio_gts(dev, 6, 963200000,
 				    veml6031x00_gain_sel,
@@ -679,6 +1258,10 @@ static int veml6031x00_probe(struct i2c_client *i2c)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to init IIO GTS\n");
 
+	ret = veml6031x00_init_iiodev(i2c, iio);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize IIO device\n");
+
 	ret = devm_iio_triggered_buffer_setup(dev, iio,
 					      iio_pollfunc_store_time,
 					      veml6031x00_trig_handler,
@@ -686,6 +1269,13 @@ static int veml6031x00_probe(struct i2c_client *i2c)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to register triggered buffer\n");
 
+	if (i2c->irq) {
+		ret = devm_request_threaded_irq(dev, i2c->irq, NULL, veml6031x00_irq,
+						IRQF_ONESHOT, iio->name, iio);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to request IRQ\n");
+	}
+
 	ret = devm_iio_device_register(dev, iio);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to register IIO device\n");

-- 
2.43.0

