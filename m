Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B867476CC0
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781736; cv=none; b=fmhjJq6udigRk/0LrSY5bgVkW+lD+SwhdvJQvXYJ2wT7B5+Vd6KDPbe2RFU7wQwYndj2cbLDGA1bNP8cdtNStmGGeI3NQLakJ3Mix9whvLI4mj7rQ6/bPoSOSgQXYaQFXGxy+eHT6PgdSr2yFdNqMjeYQ02q+dLLyxpRNyOXh6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781736; c=relaxed/simple;
	bh=gxWBCLJmguTcQLUKIt4zYaCgcNR1riDbZROPEYf8mGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FxraIU6wsq+Ate2ldJftbyL/HDh49rNrPk9VtYsXy0IjQKnpqWbcntz5NdwWE2BCdNmJO/H1GceuU4WfQEqpFaAZsDPhggFS/Xvarn69Ew5vRuiFnzx5Pxvch6tTpOWyXT5lTxZ1UGqqzc9p9z4xQJLsDC1SKruN4Kxm9OM0dLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fu09VgTq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu09VgTq"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47de0093c42so3311141f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 04:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788781731; x=1789386531; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OxXGhHCE5Y57hJDRc2bnMA9E2sfOegusqTsRsJCvLhI=;
        b=fu09VgTqlUNFlhpqUCvI/qmm9Hddk4CzGuvL02POmNa0CZPBfNggXDE595N08pXix2
         MakKZLTsQ9qfzhRkajZa+fucxnkq3BenMFZ21fryV15EBLKsougOYUvKGcp/ycLH8d1T
         uxcE4kxs9NbHAJtxZ11Nslfftw/Z4/YFJECXIBuLZnpYitreaH330WCNFsnzmkRX5888
         3ho0iBfHJgxDPM+Uspze67CjYMgVMoEdKqsSHgyeHp/UleFG0y5mEdfH/KPCin6kBSgt
         EEkVXI7Q36+BmbC/wrfsUBDL1Y9u8xTg96AEunKOTFZ1Sl6QsLKLJV1fuGkTJNiNKe//
         YRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788781731; x=1789386531;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OxXGhHCE5Y57hJDRc2bnMA9E2sfOegusqTsRsJCvLhI=;
        b=YReo/deE7x1xzL84CKUoQoQ/HaLq/3w22wEhEv9yYdPsjzZJqfLZwnF9Qmc6xK4r5L
         hzrXSK+0lCSND3U1yemJIz2zYhK/BamPv79k5cYW92oKYhOnRdgBwO3n4m9l6cGN2pBx
         lQ8PQvldUuBSqM/x8xhVsfUuKvcti9w/hmUTeKbznS4TFF1C6p1LCOYzR4CxjLqHhjlD
         RWMgUns95m0ndK3z7jVpCAYQMMo1gV2fW1M6zQZnqZ+kxUDQiqh0QWzS7p49NWsVY53U
         DyZPhJ14PFDuPuN0ADbVVvB719KdDaBGiP/yCdNs6kFzqUDd+RIIGDn1dZcDMUYDtWLR
         JMMg==
X-Gm-Message-State: AFuF++nVCfrNkY9vt1tW3NpuGwVmiXisOacjU/JBdnrTEBHe2lhXotmJ
	z/VmfA0X4CucSk5E8oozqzG1FAxYVlO3WkoqTeHZoDUrmiIRlB1MzVDQ
X-Gm-Gg: AYBFou1qFj9C5z/jnGbCaTY2D3nNsu9B409yuErGcaP+Mvc/Kzki2JZmqOjWEzUltqx
	QQ1bqkx54frRE+GvKt+iJjzLpJeGc5U/nI6AJK3ZTdsI9NvoArWn6Qcudu7ppCwri8i2wZ5MJWw
	4b4V/edUCMzBCFWBLNy5FiiCWNENpZqyqlo2vMuO2wXDn8QUyaG30Feo9Cl/uezFfmE73guQnfM
	BLxzWaCfrMajQ/QJrJR9qbZITNNIybgV32xlnSQYfTQBaP7zc8pcwr+JQIXJ2Np8P6X3sqnuzwd
	x2KGxZDNRgMIEZixh1VVFDbjqiPvsgzyPXLwlNceunvDrzH9wl5UIJEf6USFrFF1dipiaPW1Hgn
	0in3niUOLWrGgXrHmoUo9/1R40TrdhhbHmmbpsWU+8nGXwsOXEsTjz/nZabkGNR37QhSgm5/JBN
	MypRtTp/EkbwcmcIxT4UaMmYdQdm4kf4DzQk9CIfuT9Hq9F4Y4ctAvfgZZ86Bm3w6rlrWWjUAcc
	X4m
X-Received: by 2002:a05:6000:1863:b0:485:83a6:b296 with SMTP id ffacd0b85a97d-485872b8d76mr26817835f8f.19.1788781731128;
        Mon, 07 Sep 2026 04:48:51 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:178:2f30:d3da:48f5:116c:5642])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c5bc5sm29597421f8f.24.2026.09.07.04.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:48:50 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 07 Sep 2026 13:48:42 +0200
Subject: [PATCH v9 4/4] iio: light: veml6031x00: add support for events and
 trigger
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-veml6031x00-v9-4-8c93a6c66a4d@gmail.com>
References: <20260907-veml6031x00-v9-0-8c93a6c66a4d@gmail.com>
In-Reply-To: <20260907-veml6031x00-v9-0-8c93a6c66a4d@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788781720; l=24322;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=gxWBCLJmguTcQLUKIt4zYaCgcNR1riDbZROPEYf8mGg=;
 b=03hZhQJ564QEAYvAYGh3gJzNmBHeptLw88uAD9TzJg4ljJstGsnL7kZdXT6403/EuSBMilCSj
 TSmUX5fsKeSDk2IEbiaIUJM3OYjewTaZGNiPqJn3YkikqwMuyJvPubC
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

The device provides a shared interrupt line to notify events and
data ready.

Add support for configurations with and without an interrupt line,
providing events and trigger support when an interrupt line is available.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6031x00.c | 597 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 590 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
index 3d5a27a0baae..110f59625a5b 100644
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
@@ -551,11 +976,83 @@ static int veml6031x00_buffer_postdisable(struct iio_dev *iio)
 	return 0;
 }
 
+static int __veml6031x00_set_trigger_state(struct veml6031x00_data *data, bool state)
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
+		goto clear_interrupt;
+
+	ret = regmap_assign_bits(data->regmap, VEML6031X00_REG_CONF0,
+				 VEML6031X00_CONF0_AF_TRIG, state);
+	if (ret) {
+		regmap_assign_bits(data->regmap, VEML6031X00_REG_CONF0,
+				   VEML6031X00_CONF0_AF, !state);
+		goto clear_interrupt;
+	}
+
+	data->trig_en = state;
+
+	return 0;
+
+clear_interrupt:
+	veml6031x00_set_interrupt(data, !state);
+
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
@@ -609,6 +1106,79 @@ static int veml6031x00_validate_part_id(struct veml6031x00_data *data)
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
@@ -631,17 +1201,15 @@ static int veml6031x00_probe(struct i2c_client *i2c)
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
@@ -669,6 +1237,10 @@ static int veml6031x00_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;
 
+	ret = veml6031x00_hw_init(data);
+	if (ret)
+		return ret;
+
 	/* Max resolution = 6.9632 lx/cnt for gain = 0.125 and IT = 3.125ms */
 	ret = devm_iio_init_iio_gts(dev, 6, 963200000,
 				    veml6031x00_gain_sel,
@@ -679,6 +1251,10 @@ static int veml6031x00_probe(struct i2c_client *i2c)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to init IIO GTS\n");
 
+	ret = veml6031x00_init_iiodev(i2c, iio);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize IIO device\n");
+
 	ret = devm_iio_triggered_buffer_setup(dev, iio,
 					      iio_pollfunc_store_time,
 					      veml6031x00_trig_handler,
@@ -686,6 +1262,13 @@ static int veml6031x00_probe(struct i2c_client *i2c)
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

