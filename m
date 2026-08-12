Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957F5399CF2
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566484; cv=none; b=VKKRrREJ3q4ebLdQqG4l4HzSwiVvt7CyY6MPbdTpY/VJp4UjGDXx3/6fK4oLV+nbVzUzWJw98UAAcMSe9TZPEGfmw4/chCgfEwFbfJ/WBXnCqdhdR40yhw9A81lIjWntnSJTcs6ys/1kxxjRRSogIkTO1EIw2LaVjvZu/xeQC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566484; c=relaxed/simple;
	bh=Jmwp5W9ocJLKQIyWVChbhUF2z9e8EYdskBmvhqsv1sM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f6sojlWmZtiXeAbIq10uWBmaYzODRjviEU51bNXDgtHoF6f5GkLFevLX9rvpMMoM2pSzVFRriNDQtrYRltOT32GrRgVDeqxrSawEpwVdRCcnqfxhNlDGx7KuzUJuCND4Bu51cHMq0AU3FQvekfk7Ub7EaUaytdKP4Wjqg7l8/Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2ADshV2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2ADshV2"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49954b88fffso150905e9.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 13:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786566480; x=1787171280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=93CJBJv6OS9Vk7US5Du2ob8OOPoYZ9b/7eod01+bRNI=;
        b=F2ADshV2Y5AQmpuktE/5czgkQ3ZkiYmx33MO5v1Zm/oAIhbthjHAIqg0PR7Jj5FoaP
         /xD/raXMAZPkztHRVA2HrDdhxprC07BO5EWFs2BIo0KA0tFl2iPQ1PHGFu9u5EDB0x6U
         dW0/YGCg+cWSJy38yO2kxD2twd/mHSkocHjkEqATyT+qTtYz4G0jz4dsDdFW+vZ0qkGr
         1V6+9k2leLHaLCobFgIMpJKSut/yYSb9kFwN7qfWo1DhlvNm5oecBHVAFri/1Gu/qAzM
         0m9Wgj8m4vX+QDl+UZDWp7BWk+INu8DZs8cxz0EZD0YueseZB2KUqzouQNg7LXaNQLGB
         kG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566480; x=1787171280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=93CJBJv6OS9Vk7US5Du2ob8OOPoYZ9b/7eod01+bRNI=;
        b=mhdqspxb3jqk1Ywqd19uQ5W66aDzxOf/73hwWpt2pWEVaJtb7vNz7wU/0XV/86pyX/
         +4Hx4R1agv5jHADa7XbHN3DflXymMbP/1Q83157NGrDfcPb+753grzL9sFky3hUtPG00
         OuhlimYUAVJNsoNUTGTy8PBVmbQgxiH9sFoj+qtW40PLS3ebka1+geqDSIHKqomUEuIg
         ESK3yfWYVkgUZHENn2FHJQrxt4gXtsaD/zpblvvZ313Z8QR/jDZknEZS9J3fL1pI/CjD
         /cTNrrqg3aupILl39hTZFuWvorS8LyFShKPhsud4I8pmcw1JrlRxeMevtddTJ1w+AXfO
         LWsg==
X-Gm-Message-State: AOJu0YwRQZfIMw3TVpdlrZ7XZB/N1O+Vc0UarqSUMga7MunOFU1sIJIj
	TNrUHxg5AUBZFTmSUdDJ5Ws9mofOAeK2psjxSCondafz032/iRnynu51
X-Gm-Gg: AR+sD11LqZyDF+yQt7W28YLCaxEf0cJ/5CHoq3a9iVdDsvsJ0wKZYAtcLEvxGn0skZ5
	KFzIBP7eE+AbuWEkO1Cnn2f5CiPyNPfzvaYsXQiaBBypW5mG0j7Ze0u6gVV+2VmSDcli2EvxwIC
	mQCxmtir4QNaJ9x7KIoEAIuP6Tz0EaTBCrMiDAFndCVF3gHTm2CvBSzhfAQnwtk9oaN/9Imbkop
	iAbZUGgJUcNwsFLF9CfU9fgMq3T1HPawNg9oaqd0vqN5agaQVXMO/jj2f5mZULK/V4AMpmljT7u
	Pd51Hw4fjXFTosaJfVI+DZZyOjrIrgaJocmYDp9oisxrj8hOjvO4mqyok9ZrP9SCT/IGZcQitdt
	4z25e04lBCq2hYq/IblfFkU5DinoqVsmp3bpavF9kJ3IL+JoGQbnbG9CZyBgO+/03YKkF1l9qP3
	KwNeKmQxZBVbHCPlnDxipN6SY3Wsx78qxpPKhns3tahC8y6aK1YvHC9R0YUzpidHR69lKJy3TJx
	hO5
X-Received: by 2002:a05:600c:a4b:b0:495:5858:8101 with SMTP id 5b1f17b1804b1-499821f2e1bmr2793175e9.15.1786566479456;
        Wed, 12 Aug 2026 13:27:59 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:16f:15e0:179c:a67f:8487:260])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b03e70sm13911725e9.3.2026.08.12.13.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:27:59 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 12 Aug 2026 22:27:43 +0200
Subject: [PATCH v6 4/4] iio: light: veml6031x00: add support for events and
 trigger
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-veml6031x00-v6-4-7eef6e4ce290@gmail.com>
References: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
In-Reply-To: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786566469; l=22805;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=Jmwp5W9ocJLKQIyWVChbhUF2z9e8EYdskBmvhqsv1sM=;
 b=hfq1S71HuBtV/GpXjFytfpkpXR7ejD7hha2jTwXsd6Uofd2/5/0jEQGfXeMobkR3xlWF+AAuM
 +jUtNoGtZW6DhA+u8Qyhn/fSdvnRvI9ZZQK2CBY6l6Tr3v+FwJXUCJL
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

The device provides a shared interrupt line for to notify events and
data ready, which can be used as a trigger. The interrupt line is not a
requirement for the device to work. Implement variants for the cases
whether the interrupt line is provided or not.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6031x00.c | 545 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 539 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
index 43a701f62aea..6dc7ea7e8a4f 100644
--- a/drivers/iio/light/veml6031x00.c
+++ b/drivers/iio/light/veml6031x00.c
@@ -25,6 +25,9 @@
 #include <asm/byteorder.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/events.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/iio-gts-helper.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
@@ -32,16 +35,28 @@
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
 
@@ -53,8 +68,10 @@ enum veml6031x00_scan {
 
 struct veml6031x00_rf {
 	struct regmap_field *gain;
+	struct regmap_field *int_en;
 	struct regmap_field *it;
 	struct regmap_field *pd_div4;
+	struct regmap_field *pers;
 };
 
 struct veml6031x00_chip {
@@ -65,6 +82,7 @@ struct veml6031x00_chip {
 struct veml6031x00_data {
 	struct iio_gts gts;
 	struct regmap *regmap;
+	struct iio_trigger *trig;
 	struct veml6031x00_rf rf;
 	const struct veml6031x00_chip *chip;
 	/*
@@ -73,6 +91,14 @@ struct veml6031x00_data {
 	 * consistent set.
 	 */
 	struct mutex scale_lock;
+	/*
+	 * Serialize access to irq enable/disable by events and trigger
+	 * (shared line).
+	 */
+	struct mutex irq_lock;
+	int int_users;
+	bool ev_en;
+	bool trig_en;
 };
 
 static const struct iio_itime_sel_mul veml6031x00_it_sel[] = {
@@ -107,6 +133,17 @@ static const struct iio_gain_sel_pair veml6031x00_gain_sel[] = {
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
@@ -137,6 +174,23 @@ static void veml6031x00_als_shutdown_action(void *data)
 			 "Failed to shut down device: %d\n", ret);
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
@@ -171,9 +225,47 @@ static const struct iio_chan_spec veml6031x00_channels[] = {
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
@@ -182,7 +274,7 @@ static const struct regmap_access_table veml6031x00_readable_table = {
 };
 
 static const struct regmap_range veml6031x00_writable_ranges[] = {
-	regmap_reg_range(VEML6031X00_REG_CONF0, VEML6031X00_REG_CONF1),
+	regmap_reg_range(VEML6031X00_REG_CONF0, VEML6031X00_REG_WL_H),
 };
 
 static const struct regmap_access_table veml6031x00_writable_table = {
@@ -194,6 +286,7 @@ static const struct regmap_range veml6031x00_volatile_ranges[] = {
 	/* AF_TRIG in CONF0 is volatile */
 	regmap_reg_range(VEML6031X00_REG_CONF0, VEML6031X00_REG_CONF0),
 	regmap_reg_range(VEML6031X00_REG_ALS_L, VEML6031X00_REG_IR_H),
+	regmap_reg_range(VEML6031X00_REG_INT, VEML6031X00_REG_INT),
 };
 
 static const struct regmap_access_table veml6031x00_volatile_table = {
@@ -201,6 +294,15 @@ static const struct regmap_access_table veml6031x00_volatile_table = {
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
@@ -208,13 +310,20 @@ static const struct regmap_config veml6031x00_regmap_config = {
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
 
@@ -237,11 +346,21 @@ static int veml6031x00_regfield_init(struct veml6031x00_data *data)
 		return PTR_ERR(rm_field);
 	rf->it = rm_field;
 
+	rm_field = devm_regmap_field_alloc(dev, data->regmap, veml6031x00_rf_int_en);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->int_en = rm_field;
+
 	rm_field = devm_regmap_field_alloc(dev, data->regmap, veml6031x00_rf_pd_div4);
 	if (IS_ERR(rm_field))
 		return PTR_ERR(rm_field);
 	rf->pd_div4 = rm_field;
 
+	rm_field = devm_regmap_field_alloc(dev, data->regmap, veml6031x00_rf_pers);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->pers = rm_field;
+
 	return 0;
 }
 
@@ -340,6 +459,31 @@ static int veml6031x00_set_it(struct iio_dev *iio, int val, int val2)
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
+	if (val < 0 || val > 8 || hweight8(val) != 1)
+		return -EINVAL;
+
+	return regmap_field_write(data->rf.pers, ffs(val) - 1);
+}
+
 static int veml6031x00_set_scale(struct iio_dev *iio, int val, int val2)
 {
 	struct veml6031x00_data *data = iio_priv(iio);
@@ -394,6 +538,53 @@ static int veml6031x00_get_scale(struct veml6031x00_data *data, int *val,
 	return IIO_VAL_INT_PLUS_NANO;
 }
 
+static int veml6031x00_read_th(struct iio_dev *iio, int *val, int *val2, int dir)
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
+static int veml6031x00_write_th(struct iio_dev *iio, int val, int val2, int dir)
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
@@ -507,13 +698,221 @@ static int veml6031x00_write_raw_get_fmt(struct iio_dev *indio_dev,
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
+		data->int_users++;
+		if (data->int_users > 1)
+			return 0;
+	} else {
+		data->int_users--;
+		if (data->int_users > 0)
+			return 0;
+	}
+
+	ret = regmap_field_write(data->rf.int_en, state);
+	if (ret) {
+		if (state)
+			data->int_users--;
+		else
+			data->int_users++;
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
+		return veml6031x00_read_th(iio, val, val2, dir);
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
+		return veml6031x00_write_th(iio, val, val2, dir);
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
+static int veml6031x00_write_event_config(struct iio_dev *iio,
+					  const struct iio_chan_spec *chan,
+					  enum iio_event_type type,
+					  enum iio_event_direction dir,
+					  bool state)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	guard(mutex)(&data->irq_lock);
+
+	/* avoid multiple increments/decrements from one source */
+	if (state == data->ev_en)
+		return 0;
+
+	if (state) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret)
+			return ret;
+	}
+
+	ret = veml6031x00_set_interrupt(data, state);
+	if (ret) {
+		if (state)
+			pm_runtime_put_autosuspend(dev);
+		return ret;
+	}
+
+	data->ev_en = state;
+
+	if (!state)
+		pm_runtime_put_autosuspend(dev);
+
+	return 0;
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
+
+	data->ev_en = false;
+	pm_runtime_put_autosuspend(dev);
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
+		if ((regval & (VEML6031X00_INT_TH_H | VEML6031X00_INT_TH_L)) &&
+		    data->ev_en) {
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
+		trigger_poll = (regval & VEML6031X00_INT_DRDY) && data->trig_en;
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
@@ -549,11 +948,78 @@ static int veml6031x00_buffer_postdisable(struct iio_dev *iio)
 	return 0;
 }
 
+static int veml6031x00_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *iio = iio_trigger_get_drvdata(trig);
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ret;
+
+	guard(mutex)(&data->irq_lock);
+
+	if (state == data->trig_en)
+		return 0;
+
+	ret = veml6031x00_set_interrupt(data, state);
+	if (ret)
+		return ret;
+
+	/* The AF bit must be updated before updating AF_TRIG */
+	ret = regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
+				 VEML6031X00_CONF0_AF,
+				 FIELD_PREP(VEML6031X00_CONF0_AF, state));
+	if (ret) {
+		veml6031x00_set_interrupt(data, !state);
+
+		return ret;
+	}
+
+	ret = regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
+				 VEML6031X00_CONF0_AF_TRIG,
+				 FIELD_PREP(VEML6031X00_CONF0_AF_TRIG, state));
+	if (ret) {
+		regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
+				   VEML6031X00_CONF0_AF,
+				   FIELD_PREP(VEML6031X00_CONF0_AF, !state));
+		veml6031x00_set_interrupt(data, !state);
+
+		return ret;
+	}
+
+	data->trig_en = state;
+
+	return 0;
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
+	ret = regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
+				 VEML6031X00_CONF0_AF_TRIG,
+				 FIELD_PREP(VEML6031X00_CONF0_AF_TRIG, true));
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
@@ -612,7 +1078,8 @@ static int veml6031x00_hw_init(struct iio_dev *iio)
 {
 	struct veml6031x00_data *data = iio_priv(iio);
 	struct device *dev = regmap_get_device(data->regmap);
-	int ret;
+	int ret, val;
+	__le16 regval;
 
 	/* Max resolution = 6.9632 lx/cnt for gain = 0.125 and IT = 3.125ms */
 	ret = devm_iio_init_iio_gts(dev, 6, 963200000,
@@ -624,9 +1091,54 @@ static int veml6031x00_hw_init(struct iio_dev *iio)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to init IIO GTS\n");
 
+	regval = 0;
+	ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WL_L, &regval,
+				sizeof(regval));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set low threshold\n");
+
+	regval = cpu_to_le16(U16_MAX);
+	ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WH_L, &regval,
+				sizeof(regval));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set high threshold\n");
+
+	ret = regmap_field_write(data->rf.int_en, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, VEML6031X00_REG_INT, &val);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to clear interrupts\n");
+
 	return 0;
 }
 
+static int veml6031x00_setup_irq(struct i2c_client *i2c, struct iio_dev *iio)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	data->trig = devm_iio_trigger_alloc(dev, "%s-drdy%d",
+					    iio->name, iio_device_id(iio));
+	if (!data->trig)
+		return -ENOMEM;
+
+	data->trig->ops = &veml6031x00_trigger_ops;
+	iio_trigger_set_drvdata(data->trig, iio);
+
+	ret = devm_iio_trigger_register(dev, data->trig);
+	if (ret)
+		return ret;
+
+	iio->trig = iio_trigger_get(data->trig);
+
+	return devm_request_threaded_irq(dev, i2c->irq,
+					NULL, veml6031x00_irq,
+					IRQF_ONESHOT, iio->name, iio);
+}
+
 static int veml6031x00_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
@@ -651,15 +1163,16 @@ static int veml6031x00_probe(struct i2c_client *i2c)
 				     "Failed to set regmap\n");
 
 	iio->name = data->chip->name;
-	iio->channels = veml6031x00_channels;
-	iio->num_channels = ARRAY_SIZE(veml6031x00_channels);
 	iio->modes = INDIO_DIRECT_MODE;
-	iio->info = &veml6031x00_info;
 
 	ret = devm_mutex_init(dev, &data->scale_lock);
 	if (ret)
 		return ret;
 
+	ret = devm_mutex_init(dev, &data->irq_lock);
+	if (ret)
+		return ret;
+
 	ret = veml6031x00_regfield_init(data);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to init regfield\n");
@@ -685,6 +1198,12 @@ static int veml6031x00_probe(struct i2c_client *i2c)
 
 	pm_runtime_get_noresume(dev);
 
+	ret = devm_add_action_or_reset(dev, veml6031x00_disable_event_action, data);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to add event cleanup action\n");
+		goto err_pm_put;
+	}
+
 	ret = veml6031x00_validate_part_id(data);
 	if (ret)
 		goto err_pm_put;
@@ -693,6 +1212,20 @@ static int veml6031x00_probe(struct i2c_client *i2c)
 	if (ret)
 		goto err_pm_put;
 
+	if (i2c->irq) {
+		iio->channels = veml6031x00_channels_irq;
+		iio->num_channels = ARRAY_SIZE(veml6031x00_channels_irq);
+		ret = veml6031x00_setup_irq(i2c, iio);
+		if (ret)
+			goto err_pm_put;
+
+		iio->info = &veml6031x00_info;
+	} else {
+		iio->channels = veml6031x00_channels;
+		iio->num_channels = ARRAY_SIZE(veml6031x00_channels);
+		iio->info = &veml6031x00_info_no_irq;
+	}
+
 	pm_runtime_put_autosuspend(dev);
 
 	ret = devm_iio_triggered_buffer_setup(dev, iio,

-- 
2.43.0

