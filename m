Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A4C3806D7
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779659797; cv=none; b=jWN/G9xtR16jQ5gyTSH3CFliKx8HHqZZ1gdphmMxe7DEYfFoinEiKYuyrW0AVESPIIwb5Cu5bi9VnVu+FKNMVqoxqFzvVgwTSVqnYX1a4xEFwFjU0nurnlldnILTubcUGy/iNoAc4AoBlDa4YgOZ3IgvDCQ8CAG4ocIg/pOXhLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779659797; c=relaxed/simple;
	bh=Zw8f5Wm7witufhXEpKjWVeHqRA7CE8TpbWK1NknESs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zvu3FGq/jnGCZh149KCnkmHYMgPrMPIz8Co3sMAktndxeawgGUPniD+0uBLzdcsBnryv9lBmns6tMq0keLlwUDJH+0YIoyj49SDYDkPYoyLMbKNruId/M2U3HqFnEohb384qQqLmeonGiBhJ8KSg+TMMCKsdElmitsC45cMc15g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rvns/tAZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rvns/tAZ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4903f7a90d1so23465685e9.2
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 14:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779659792; x=1780264592; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPEvGZVdB78nhQxjKZAaARniz89YsiEBNtfAphISK20=;
        b=Rvns/tAZ4wnrs9hYmm0TpFMfqm2HXYKMcbmDf73tw1MfcFRxtN8JkURUGtubyJDkb0
         EznHF2EKkGZnLcjH2mUkS7zKBekHjk8xPlKhglt88o8qL/7Hrrs/NHYs4y9RzG+W7e9I
         NzR4wNTV9XjT1unC//qLquM8qM4nb37RG342BdgbzoQq2lazczaFRDxL22plbRwGEV6f
         R9lRGg0oIlfZ9RauwJ4xKluybkIy//0ZuQKMCO01k13NrSKq2LaEGfkd99TZ56UVM4Gm
         vWdRPmlTO90SCwsFPlYWSSuyiNUjHjbhlukhJOr+0NPEfcEoEsCZk0BE7UNfm3k68I39
         kvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779659792; x=1780264592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BPEvGZVdB78nhQxjKZAaARniz89YsiEBNtfAphISK20=;
        b=DQl5VhzmU1co1wL2FmZ99qphmE6kP3lZaMKEDbmR8WgHJZGvYi0Mj2Gk7TtoQDpEuO
         rFUhRSu7aEyOJJ1kbdopZzBFzNa+vzujh2TgBhfdKs781SCO7NenN4X4j1tacJndNOpn
         h+NqwcP7gf6YCnMh1XrnGAVKe7BG+9zYcvwTAByaW1COCX+9a3Au/dpYVRiTccVr3bNu
         MaK7WMY2gbXUNZKXenLofd2Wwc1Wgr8we50MGHiBEZqLINTzXxo2dNX1z5JL2qQOMftV
         kj0o+85t1G6hRzwk3AG+vL+wPxr64CVF+GPZOrXnQNtcx5b7hYjdwW02cvTQTLabX/qH
         AT7Q==
X-Gm-Message-State: AOJu0YySZ4mBtXUELEOvku2ia5j1HfT5YvyRfSm9fxCI81cui0gn4BlD
	epa19fNZIKXVm7LwOYEuFZcQrjyE9WFYu7FgjBcPI5iR3UR7SbjuZUEO
X-Gm-Gg: Acq92OES47LKtaGEmdXce2X3LBL5C5fBvYI06sGWWXIx0FHLqY+FWCH21Wrov8OS5I4
	cx4pCOOVYyuTlXcCrtxn3tJWLjxWMlD6hKHVrWyDYEldzziVsi6mCx3hnLAU1GbmUMSNZxxh0ej
	4wO1Jw9MxSohioCmSPfzhUH8tCv6iEMKnLs7CXEZzjgk+ED3/go7xie7Qy66aHkwEArqNAsktQH
	mDLfV+T9sgPCvT9JMUdudv7if11m2KdkFZCJBTagXX8S0Dw1KB3cMUsma5ccuS9TWF1mg3Ic5Zz
	g6O7PkNPn9+tce54WCSLR3lu+CjQtTdm310x0CFg0a8M6s+pvhKnP4GOePh2ysnAp9old/26YlB
	CZOfuANZKOYTiop/5jKQZyvjzMnp/9PnoR/q1wfYsWcv3r3sD9hKVi6pyT8crHXuUWZcnbZtkoy
	2OarUIm9DTztyqDTrY0w7/nXMk7V66pWjfJNerGt2s89CDgM072GDWAHOhH42fPguIogZVVw==
X-Received: by 2002:a7b:cde1:0:b0:489:1f04:96c3 with SMTP id 5b1f17b1804b1-4904248b137mr121322745e9.2.1779659792219;
        Sun, 24 May 2026 14:56:32 -0700 (PDT)
Received: from [127.0.1.1] (213-225-2-150.nat.highway.a1.net. [213.225.2.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904527f7f7sm300779285e9.7.2026.05.24.14.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 14:56:31 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 24 May 2026 23:53:58 +0200
Subject: [PATCH v3 4/4] iio: light: veml6031x00: add support for events and
 trigger
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-veml6031x00-v3-4-29165609b2b5@gmail.com>
References: <20260524-veml6031x00-v3-0-29165609b2b5@gmail.com>
In-Reply-To: <20260524-veml6031x00-v3-0-29165609b2b5@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779659783; l=19949;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=Zw8f5Wm7witufhXEpKjWVeHqRA7CE8TpbWK1NknESs4=;
 b=P9pBJS5i/fggXlVwdN0WLVwOmTZJfUKW+2uVmfE6fM+BjS2IaM0hz+/BDIsAjrsSKGu40pvtp
 2nTvCHFXxL9D+KUD/W83wqFUK8GhulM9gssR8z1dRWRHXeeBy1G+ANx
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

The device provides a shared interrupt line for to notify events and
data ready, which can be used as a trigger. The interrupt line is not a
requirement for the device to work. Implement variants for the cases
whether the interrupt line is provided or not.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6031x00.c | 442 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 438 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
index 9968d4414dc9..c57aaa29abf3 100644
--- a/drivers/iio/light/veml6031x00.c
+++ b/drivers/iio/light/veml6031x00.c
@@ -7,12 +7,16 @@
 
 #include <linux/bitfield.h>
 #include <linux/i2c.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/units.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/events.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/iio-gts-helper.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
@@ -20,16 +24,29 @@
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
+#define VEML6031X00_INT_MASK        (VEML6031X00_INT_TH_L | \
+				     VEML6031X00_INT_TH_H | \
+				     VEML6031X00_INT_DRDY)
 
 enum veml6031x00_scan {
 	VEML6031X00_SCAN_ALS,
@@ -39,8 +56,10 @@ enum veml6031x00_scan {
 
 struct veml6031x00_rf {
 	struct regmap_field *gain;
+	struct regmap_field *int_en;
 	struct regmap_field *it;
 	struct regmap_field *pd_div4;
+	struct regmap_field *pers;
 };
 
 struct veml6031x00_chip {
@@ -52,8 +71,14 @@ struct veml6031x00_data {
 	struct device *dev;
 	struct iio_gts gts;
 	struct regmap *regmap;
+	struct iio_trigger *trig;
 	struct veml6031x00_rf rf;
 	const struct veml6031x00_chip *chip;
+	/* serialize access to irq enable/disable by events and trigger */
+	struct mutex lock;
+	int int_users;
+	bool ev_en;
+	bool trig_en;
 };
 
 static const struct iio_itime_sel_mul veml6031x00_it_sel[] = {
@@ -88,6 +113,17 @@ static const struct iio_gain_sel_pair veml6031x00_gain_sel[] = {
 	GAIN_SCALE_GAIN(16, VEML6031X00_SEL_MILLI_GAIN_X2000),
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
  * Two shutdown bits (SD and ALS_IR_SD) must be cleared to power on
  * the device.
@@ -127,6 +163,23 @@ static void veml6031x00_als_shutdown_action(void *data)
 	veml6031x00_als_shutdown(data);
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
@@ -136,6 +189,8 @@ static const struct iio_chan_spec veml6031x00_channels[] = {
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
 		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = veml6031x00_event_spec,
+		.num_event_specs = ARRAY_SIZE(veml6031x00_event_spec),
 		.scan_index = VEML6031X00_SCAN_ALS,
 		.scan_type = {
 			.sign = 'u',
@@ -166,7 +221,9 @@ static const struct iio_chan_spec veml6031x00_channels[] = {
 
 static const struct regmap_range veml6031x00_readable_ranges[] = {
 	regmap_reg_range(VEML6031X00_REG_CONF0, VEML6031X00_REG_CONF1),
+	regmap_reg_range(VEML6031X00_REG_WH_L, VEML6031X00_REG_WL_H),
 	regmap_reg_range(VEML6031X00_REG_ALS_L, VEML6031X00_REG_ID_H),
+	regmap_reg_range(VEML6031X00_REG_INT, VEML6031X00_REG_INT),
 };
 
 static const struct regmap_access_table veml6031x00_readable_table = {
@@ -175,7 +232,7 @@ static const struct regmap_access_table veml6031x00_readable_table = {
 };
 
 static const struct regmap_range veml6031x00_writable_ranges[] = {
-	regmap_reg_range(VEML6031X00_REG_CONF0, VEML6031X00_REG_CONF1),
+	regmap_reg_range(VEML6031X00_REG_CONF0, VEML6031X00_REG_WL_H),
 };
 
 static const struct regmap_access_table veml6031x00_writable_table = {
@@ -185,6 +242,7 @@ static const struct regmap_access_table veml6031x00_writable_table = {
 
 static const struct regmap_range veml6031x00_volatile_ranges[] = {
 	regmap_reg_range(VEML6031X00_REG_ALS_L, VEML6031X00_REG_IR_H),
+	regmap_reg_range(VEML6031X00_REG_INT, VEML6031X00_REG_INT),
 };
 
 static const struct regmap_access_table veml6031x00_volatile_table = {
@@ -192,6 +250,15 @@ static const struct regmap_access_table veml6031x00_volatile_table = {
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
@@ -199,13 +266,20 @@ static const struct regmap_config veml6031x00_regmap_config = {
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
 
@@ -224,6 +298,11 @@ static int veml6031x00_regfield_init(struct veml6031x00_data *data)
 		return PTR_ERR(rm_field);
 	rf->gain = rm_field;
 
+	rm_field = devm_regmap_field_alloc(dev, regmap, veml6031x00_rf_int_en);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->int_en = rm_field;
+
 	rm_field = devm_regmap_field_alloc(dev, regmap, veml6031x00_rf_it);
 	if (IS_ERR(rm_field))
 		return PTR_ERR(rm_field);
@@ -234,6 +313,11 @@ static int veml6031x00_regfield_init(struct veml6031x00_data *data)
 		return PTR_ERR(rm_field);
 	rf->pd_div4 = rm_field;
 
+	rm_field = devm_regmap_field_alloc(dev, regmap, veml6031x00_rf_pers);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->pers = rm_field;
+
 	return 0;
 }
 
@@ -313,6 +397,30 @@ static int veml6031x00_set_it(struct iio_dev *iio, int val, int val2)
 	return regmap_field_write(data->rf.gain, gain_sel & 0x03);
 }
 
+static int veml6031x00_read_period(struct iio_dev *iio, int *val)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ret, reg;
+
+	ret = regmap_field_read(data->rf.pers, &reg);
+	if (ret)
+		return ret;
+
+	*val = 1 << reg;
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
@@ -367,6 +475,51 @@ static int veml6031x00_get_scale(struct veml6031x00_data *data, int *val,
 	return IIO_VAL_INT_PLUS_NANO;
 }
 
+static int veml6031x00_read_th(struct iio_dev *iio, int *val, int *val2, int dir)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	__le16 reg;
+	int ret;
+
+	if (dir == IIO_EV_DIR_RISING)
+		ret = regmap_bulk_read(data->regmap, VEML6031X00_REG_WH_L,
+				       &reg, sizeof(reg));
+	else
+		ret = regmap_bulk_read(data->regmap, VEML6031X00_REG_WL_L,
+				       &reg, sizeof(reg));
+	if (ret)
+		return ret;
+
+	*val = le16_to_cpu(reg);
+
+	return IIO_VAL_INT;
+}
+
+static int veml6031x00_write_th(struct iio_dev *iio, int val, int val2, int dir)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = data->dev;
+	__le16 reg = cpu_to_le16(val);
+	int ret;
+
+	if (val < 0 || val > U16_MAX || val2)
+		return -EINVAL;
+
+	if (dir == IIO_EV_DIR_RISING) {
+		ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WH_L,
+					&reg, sizeof(reg));
+		if (ret)
+			dev_dbg(dev, "Failed to set high threshold %d\n", ret);
+	} else {
+		ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WL_L,
+					&reg, sizeof(reg));
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
@@ -477,13 +630,189 @@ static int veml6031x00_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+static int veml6031x00_set_interrupt(struct veml6031x00_data *data, bool state)
+	__must_hold(&data->lock)
+{
+	int ret;
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
+	guard(mutex)(&data->lock);
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
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	/* avoid multiple increments/decrements from one source */
+	if (state == data->ev_en)
+		return 0;
+
+	if (state) {
+		ret = pm_runtime_resume_and_get(data->dev);
+		if (ret)
+			return ret;
+	}
+
+	ret = veml6031x00_set_interrupt(data, state);
+	if (ret) {
+		if (state)
+			pm_runtime_put_autosuspend(data->dev);
+		return ret;
+	}
+
+	data->ev_en = state;
+
+	if (!state)
+		pm_runtime_put_autosuspend(data->dev);
+
+	return 0;
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
+};
+
+static const struct iio_info veml6031x00_info_no_irq = {
+	.read_raw = veml6031x00_read_raw,
+	.read_avail = veml6031x00_read_avail,
+	.write_raw = veml6031x00_write_raw,
+	.write_raw_get_fmt = veml6031x00_write_raw_get_fmt,
 };
 
+/* AF_TRIG is reset by hardware, but the rest of the fields are persistent */
+static int veml6031x00_set_af_trig(struct veml6031x00_data *data, bool state)
+{
+	regcache_drop_region(data->regmap, VEML6031X00_REG_CONF0,
+			     VEML6031X00_REG_CONF0);
+
+	return regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
+				  VEML6031X00_CONF0_AF_TRIG,
+				  FIELD_PREP(VEML6031X00_CONF0_AF_TRIG, state));
+}
+
+static irqreturn_t veml6031x00_interrupt(int irq, void *private)
+{
+	struct iio_dev *iio = private;
+	struct veml6031x00_data *data = iio_priv(iio);
+	s64 timestamp;
+	int ret, reg;
+
+	ret = regmap_read(data->regmap, VEML6031X00_REG_INT, &reg);
+	if (ret) {
+		dev_err(data->dev,
+			"Failed to read interrupt register %d\n", ret);
+		return IRQ_NONE;
+	}
+
+	if (!(reg & VEML6031X00_INT_MASK))
+		return IRQ_NONE;
+
+	guard(mutex)(&data->lock);
+
+	if ((reg & (VEML6031X00_INT_TH_H | VEML6031X00_INT_TH_L)) && data->ev_en) {
+		timestamp = iio_get_time_ns(iio);
+
+		if (reg & VEML6031X00_INT_TH_H)
+			iio_push_event(iio, IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+								 IIO_EV_TYPE_THRESH,
+								 IIO_EV_DIR_RISING),
+				       timestamp);
+		if (reg & VEML6031X00_INT_TH_L)
+			iio_push_event(iio, IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+								 IIO_EV_TYPE_THRESH,
+								 IIO_EV_DIR_FALLING),
+				       timestamp);
+	}
+
+	if ((reg & VEML6031X00_INT_DRDY) && data->trig_en) {
+		iio_trigger_poll_nested(data->trig);
+		ret = veml6031x00_set_af_trig(data, true);
+		if (ret)
+			dev_err(data->dev, "Failed to set trigger %d\n", ret);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int veml6031x00_buffer_preenable(struct iio_dev *iio)
 {
 	struct veml6031x00_data *data = iio_priv(iio);
@@ -518,11 +847,54 @@ static int veml6031x00_buffer_postdisable(struct iio_dev *iio)
 	return 0;
 }
 
+static int veml6031x00_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *iio = iio_trigger_get_drvdata(trig);
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	if (state == data->trig_en)
+		return 0;
+
+	ret = veml6031x00_set_interrupt(data, state);
+	if (ret)
+		return ret;
+
+	/* The AF bit must be set before setting AF_TRIG */
+	ret = regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
+				 VEML6031X00_CONF0_AF,
+				 FIELD_PREP(VEML6031X00_CONF0_AF, state));
+	if (ret)
+		goto err_disable_interrupt;
+
+	ret = veml6031x00_set_af_trig(data, state);
+	if (ret)
+		goto err_clear_af;
+
+	data->trig_en = state;
+
+	return 0;
+
+err_clear_af:
+	regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
+			   VEML6031X00_CONF0_AF,
+			   FIELD_PREP(VEML6031X00_CONF0_AF, !state));
+err_disable_interrupt:
+	veml6031x00_set_interrupt(data, !state);
+	return ret;
+}
+
 static const struct iio_buffer_setup_ops veml6031x00_buffer_setup_ops = {
 	.preenable = veml6031x00_buffer_preenable,
 	.postdisable = veml6031x00_buffer_postdisable,
 };
 
+static const struct iio_trigger_ops veml6031x00_trigger_ops = {
+	.set_trigger_state = veml6031x00_set_trigger_state,
+};
+
 static irqreturn_t veml6031x00_trig_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -581,7 +953,8 @@ static int veml6031x00_hw_init(struct iio_dev *iio)
 {
 	struct veml6031x00_data *data = iio_priv(iio);
 	struct device *dev = data->dev;
-	int ret;
+	int ret, val;
+	__le16 reg;
 
 	/* Max resolution = 6.9632 lx/cnt for gain = 0.125 and IT = 3.125ms */
 	ret = devm_iio_init_iio_gts(dev, 6, 963200000,
@@ -593,6 +966,54 @@ static int veml6031x00_hw_init(struct iio_dev *iio)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to init iio gts\n");
 
+	reg = 0;
+	ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WL_L, &reg, sizeof(reg));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set low threshold\n");
+
+	reg = cpu_to_le16(U16_MAX);
+	ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WH_L, &reg, sizeof(reg));
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
+	return 0;
+}
+
+static int veml6031x00_setup_irq(struct i2c_client *i2c, struct iio_dev *iio)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = data->dev;
+	int ret;
+
+	data->trig = devm_iio_trigger_alloc(dev, "%s-drdy%d", iio->name,
+					    iio_device_id(iio));
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
+	ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
+					veml6031x00_interrupt,
+					IRQF_ONESHOT,
+					iio->name, iio);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request irq %d\n",
+				     i2c->irq);
+
 	return 0;
 }
 
@@ -618,6 +1039,10 @@ static int veml6031x00_probe(struct i2c_client *i2c)
 	data->dev = dev;
 	data->regmap = regmap;
 
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
+
 	ret = veml6031x00_regfield_init(data);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to init regfield\n");
@@ -657,12 +1082,21 @@ static int veml6031x00_probe(struct i2c_client *i2c)
 	iio->channels = veml6031x00_channels;
 	iio->num_channels = ARRAY_SIZE(veml6031x00_channels);
 	iio->modes = INDIO_DIRECT_MODE;
-	iio->info = &veml6031x00_info;
 
 	ret = veml6031x00_hw_init(iio);
 	if (ret)
 		return ret;
 
+	if (i2c->irq) {
+		ret = veml6031x00_setup_irq(i2c, iio);
+		if (ret)
+			return ret;
+
+		iio->info = &veml6031x00_info;
+	} else {
+		iio->info = &veml6031x00_info_no_irq;
+	}
+
 	ret = devm_iio_triggered_buffer_setup(dev, iio, NULL,
 					      veml6031x00_trig_handler,
 					      &veml6031x00_buffer_setup_ops);

-- 
2.43.0

