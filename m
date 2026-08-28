Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F413CF030
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899132; cv=none; b=YxFD30C3kyMWsNgYZa6A6LT8MsHdYICQ75cXW2wyjEhINrzzBFmKALutb9BonzxJPHSTfmNmPkp/OQejd1Oa+kKYtykLL6q1UHxgQrKBWdUUlp5N7iIqIV1rs8ERHmXKeaxaRETw5Yh+lDV6VdSPcd+3HVVcGRdQD4bVVsPDhR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899132; c=relaxed/simple;
	bh=6aZMjagHvcH24IcCEzk87Oit7nVKdoCQ6sPY4en+24w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TSrb58qa6JGeGaAMgcuQg90fR8QyLur1SFJ5+Lvz76ac/LAWW2KjRN7XpioGxkboQcdVGyM1orCoIrLhb19eE3CGCZ824oWD3jEg8XHmmP2cUri2IGM51CbLzBP09qXx3xlUkv+mz6+Nm3M0s/flgzuOZYNObjdXHYbhRlIq2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnVp+Nmj; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnVp+Nmj"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-75e2905c09aso99400137.2
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 23:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787899127; x=1788503927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QHv5wdzqoT+8+ip3D8MQsdcFxzRbRYsfhtpZnwwMeCw=;
        b=mnVp+NmjzqXJ1adMbmQBmRqob7ECNbcU9ZgVWz8tp8aHCW/8I/9Mzf/tqZ6oqxg5Z0
         BOA0PpQvSqQqhcVWAbE2YG2i9yxXJnyivjg796g7RVAtfk/r5uTw2rLxUKIFWsqoIi0z
         X0KfRO2o0F+VwF4pCUYlNSHOdYrjkjfkBBpE89RGhpURjbcHwHeCGV76Ah+nAYL3a7c2
         0eslY+2FqI0Vq3sSCdrwGiTF7T4A11SXnlBYbeXiO1innTSDHYKU2CInf4oTYloIj0Zi
         jEEFPr0MLfZKsvABf41vdcskVGPJEBJjvIS8IxRoFuUGu5WUcpnqqHTMrKK6V3sY5sbR
         m8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787899127; x=1788503927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QHv5wdzqoT+8+ip3D8MQsdcFxzRbRYsfhtpZnwwMeCw=;
        b=Z8wyj7hYgzFMcaVeNEWbgqGhi/etVm3wdjd4Y6eLzUyXjDCkWErzydXDJkaHLAn2PM
         /9u0NbomvJb9JuSC4Svhs709EWnRwOejcCV2VF6YFUNzn9oViC5mCJb+mjFYbzJMl9lT
         Lxd8/nt2p/9VOxIyw7ehb02Sce/k9RZAVCcpxhdIR3/py2DJ5Zlekl5pcIuyIcMpuDfe
         uw/pflULlXbXLasS/h5k57ct3yuuuqSqIhiJ8hLraR8xmLhRmE7n5eLdWBsBR85aDU+R
         jhGCr0yBh5d+HUp4+7QPgwDnDvTU/ztJ4+FEI3wNPzd+Yrrpkjq25sQNsDOpk0GQyUcV
         QMug==
X-Forwarded-Encrypted: i=1; AHgh+RrG5mgS3ZEs5TBN1Mi1o7ZfU1yEtdlkRHbNyuT4IdGXYwsMCVSqYaPRyt7gYM41tInIJmSfN0jmU9w=@vger.kernel.org
X-Gm-Message-State: AFuF++kzIkYQCnj0wNKUjMNv2qHrdvjrtGi5R+DPtUYp+MrnMUbfOKRf
	GV1CMOnMdlGpLIxlBhh9Y7k313/Xvkvw9GemIKEwUnwqMHtTwnLO2Bsa
X-Gm-Gg: AR+sD11gN4BRJX4QUv5nBgvqb8cOlPEYGDSqaX3xJG/WsjNL1c970vajCQkrWDookyR
	Itvelf+woHKAE1XESVWFN71u4h3NCxloiaOOWgihV+NorCmg+JinaoeJ3kHrGnYI6Wzu6QUL5yc
	zXL16zHE9EzT1Mpw8qjszalzYr4AslFjzFazXv9Ri8KmXm7kT8CYFuo9HO9vUFlOSTw79Q8w3Gf
	MSl/bwXuZ8yR25z9Hj3zeb7ytURHgDHF/2fYgyCsWEzhmqDXz2g1cXYmvXBTH2b7FlE8ASDt2o5
	ww8NVXJ6zLm8ZLu0+MGVFvPn38/nWzP8obTOyi33ZAUiUhGncss2GPAV28TvpCRqRlIfNsooaVF
	OYw83+Uxl5An3hM717k1qvymU+ZmL3O7vpe/acvoSyyv6LOlTXBtpUW5+yrCfzm569WPl7s5RR6
	sgI7vxXL1A5huHHCTGWOwelBuR6DJxwTn3qA0OVWKFsdbawmOgbihFMAZITt3IFav3cQ==
X-Received: by 2002:a05:6102:2907:b0:782:de7b:eead with SMTP id ada2fe7eead31-785962b3b4fmr1260614137.1.1787899126966;
        Thu, 27 Aug 2026 23:38:46 -0700 (PDT)
Received: from [192.168.100.153] ([2800:bf0:61:1127:ab87:5602:531c:8dfb])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97e849d8494sm454195241.1.2026.08.27.23.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 23:38:46 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 28 Aug 2026 01:38:19 -0500
Subject: [PATCH v4 04/10] iio: adc: ti-ads1262: support per-channel
 sampling frequency
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-ads126x-v4-4-1dc27e9c0260@gmail.com>
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
In-Reply-To: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12017; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=6aZMjagHvcH24IcCEzk87Oit7nVKdoCQ6sPY4en+24w=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFkTdd7c3/dxzckUQcMH02dZsKxo98m/ps/wmIH1crC5f
 CJLqe3JjlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZjImWxGhiMhAneeKc9aVMMS
 yq35XfGm7X2X1h8x1k3blKSFuWc83MbIsHX5TDb5w1eZnd4nbAx+9WpBQO3HrM8tF19sm6UR733
 iJTcA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add per-channel sampling frequency support. The "available" attribute is
assigned per-channel too, in order to eventually support per-filter
availability.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/ti-ads1262.c | 233 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 228 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index d919144c23cb..86ea9b6232d8 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -25,6 +25,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include <asm/byteorder.h>
 
@@ -99,6 +100,7 @@
 #define     ADS1262_DR_14400_SPS		  13
 #define     ADS1262_DR_19200_SPS		  14
 #define     ADS1262_DR_38400_SPS		  15
+#define     ADS1262_DR_COUNT			  (ADS1262_DR_38400_SPS + 1)
 
 #define ADS1262_INPMUX_REG			0x06
 #define   ADS1262_INPMUX_MUXP_MASK		GENMASK(7, 4)
@@ -166,6 +168,7 @@
 #define ADS1262_POWER_TRANS_USECS		65536
 
 #define ADS1262_NOMINAL_CLK_RATE		7372800
+#define ADS1262_MODULATOR_DIV			8
 
 #define ADS1262_FW_CHANNEL_COUNT		16
 #define ADS1262_MON_CHANNEL_COUNT		4
@@ -174,10 +177,17 @@
 
 #define ADS1262_ADC1_RESOLUTION			32
 
+struct ads1262_channel {
+	u8 data_rate;
+	u8 filter;
+};
+
 struct ads1262 {
 	struct spi_device *spi;
 	struct regmap *regmap;
 	struct gpio_desc *start_gpiod;
+	size_t num_channels;
+	struct ads1262_channel *channels;
 	/* protects concurrent SPI transfers */
 	struct mutex xfer_lock;
 	/* protects channel state */
@@ -185,6 +195,8 @@ struct ads1262 {
 	struct completion drdy;
 	unsigned long clk_rate;
 	u8 dev_id;
+	int sampling_freq_table[ADS1262_DR_COUNT][2];
+	int sampling_freq_fir[ADS1262_DR_16_6_SPS + 1][2];
 };
 
 static const char * const ads1262_device_id_to_name[] = {
@@ -204,7 +216,9 @@ static const struct iio_chan_spec ads1262_monitor_chan_specs[] = {
 			.storagebits = 32,
 			.endianness = IIO_BE,
 		},
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 	{
 		.type = IIO_VOLTAGE,
@@ -218,7 +232,9 @@ static const struct iio_chan_spec ads1262_monitor_chan_specs[] = {
 			.storagebits = 32,
 			.endianness = IIO_BE,
 		},
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 	{
 		.type = IIO_VOLTAGE,
@@ -232,7 +248,9 @@ static const struct iio_chan_spec ads1262_monitor_chan_specs[] = {
 			.storagebits = 32,
 			.endianness = IIO_BE,
 		},
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 	{
 		.type = IIO_VOLTAGE,
@@ -247,10 +265,66 @@ static const struct iio_chan_spec ads1262_monitor_chan_specs[] = {
 			.storagebits = 32,
 			.endianness = IIO_BE,
 		},
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 };
 
+static const struct ads1262_channel ads1262_default_channel = {
+	.data_rate = ADS1262_DR_20_SPS,
+	.filter = ADS1262_FILTER_FIR,
+};
+
+static const u32 ads1262_mod_decimator_a[] = {
+	[ADS1262_DR_2_5_SPS]	= 64,
+	[ADS1262_DR_5_SPS]	= 64,
+	[ADS1262_DR_10_SPS]	= 64,
+	[ADS1262_DR_16_6_SPS]	= 64,
+	[ADS1262_DR_20_SPS]	= 64,
+	[ADS1262_DR_50_SPS]	= 64,
+	[ADS1262_DR_60_SPS]	= 64,
+	[ADS1262_DR_100_SPS]	= 64,
+	[ADS1262_DR_400_SPS]	= 64,
+	[ADS1262_DR_1200_SPS]	= 64,
+	[ADS1262_DR_2400_SPS]	= 64,
+	[ADS1262_DR_4800_SPS]	= 64,
+	[ADS1262_DR_7200_SPS]	= 64,
+	[ADS1262_DR_14400_SPS]	= 64,
+	[ADS1262_DR_19200_SPS]	= 48,
+	[ADS1262_DR_38400_SPS]	= 24,
+};
+
+static const u32 ads1262_mod_decimator_b[] = {
+	[ADS1262_DR_2_5_SPS]	= 5760,
+	[ADS1262_DR_5_SPS]	= 2880,
+	[ADS1262_DR_10_SPS]	= 1440,
+	[ADS1262_DR_16_6_SPS]	= 864,
+	[ADS1262_DR_20_SPS]	= 720,
+	[ADS1262_DR_50_SPS]	= 288,
+	[ADS1262_DR_60_SPS]	= 240,
+	[ADS1262_DR_100_SPS]	= 144,
+	[ADS1262_DR_400_SPS]	= 36,
+	[ADS1262_DR_1200_SPS]	= 12,
+	[ADS1262_DR_2400_SPS]	= 6,
+	[ADS1262_DR_4800_SPS]	= 3,
+	[ADS1262_DR_7200_SPS]	= 2,
+	[ADS1262_DR_14400_SPS]	= 1,
+	[ADS1262_DR_19200_SPS]	= 1,
+	[ADS1262_DR_38400_SPS]	= 1,
+};
+
+static int ads1262_find_two(const int (*array)[2], size_t num_elements, int val,
+			    int val2)
+{
+	for (unsigned int i = 0; i < num_elements; i++) {
+		if (val == array[i][0] && val2 == array[i][1])
+			return i;
+	}
+
+	return -EINVAL;
+}
+
 static int ads1262_dev_send_cmd(struct ads1262 *st, u8 opcode)
 {
 	guard(mutex)(&st->xfer_lock);
@@ -375,9 +449,18 @@ static int ads1262_wait_for_conversion(struct ads1262 *st)
 static int ads1262_channel_enable(struct ads1262 *st,
 				  const struct iio_chan_spec *spec)
 {
+	struct ads1262_channel *chan = &st->channels[spec->scan_index];
+	int ret;
+
 	guard(mutex)(&st->xfer_lock);
 	guard(mutex)(&st->chan_lock);
 
+	ret = regmap_update_bits(st->regmap, ADS1262_MODE2_REG,
+				 ADS1262_MODE2_DR_MASK,
+				 FIELD_PREP(ADS1262_MODE2_DR_MASK, chan->data_rate));
+	if (ret)
+		return ret;
+
 	return regmap_update_bits(st->regmap, ADS1262_INPMUX_REG,
 				  ADS1262_INPMUX_MUXN_MASK |
 				  ADS1262_INPMUX_MUXP_MASK,
@@ -429,6 +512,8 @@ static int ads1262_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int *val,
 			    int *val2, long mask)
 {
+	struct ads1262 *st = iio_priv(indio_dev);
+	struct ads1262_channel *chan_data = &st->channels[chan->scan_index];
 	__be32 raw;
 	int ret;
 
@@ -441,6 +526,83 @@ static int ads1262_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&st->chan_lock);
+
+		*val = st->sampling_freq_table[chan_data->data_rate][0];
+		*val2 = st->sampling_freq_table[chan_data->data_rate][1];
+
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ads1262_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, const int **vals,
+			      int *type, int *length, long mask)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+	struct ads1262_channel *chan_data = &st->channels[chan->scan_index];
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT_PLUS_MICRO;
+
+		switch (chan_data->filter) {
+		case ADS1262_FILTER_FIR:
+			*vals = (const int *)st->sampling_freq_fir;
+			*length = ARRAY_SIZE(st->sampling_freq_fir) * 2;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EOPNOTSUPP;
+		}
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ads1262_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+	struct ads1262_channel *chan_data = &st->channels[chan->scan_index];
+	int ret;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	guard(mutex)(&st->chan_lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		switch (chan_data->filter) {
+		case ADS1262_FILTER_FIR:
+			ret = ads1262_find_two(st->sampling_freq_fir,
+					       ARRAY_SIZE(st->sampling_freq_fir),
+					       val, val2);
+			if (ret < 0)
+				return ret;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		ret = ads1262_find_two(st->sampling_freq_table,
+				       ARRAY_SIZE(st->sampling_freq_table),
+				       val, val2);
+		if (ret < 0)
+			return ret;
+
+		chan_data->data_rate = ret;
+
+		return 0;
+
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -479,6 +641,8 @@ static int ads1262_fwnode_xlate(struct iio_dev *indio_dev,
 
 static const struct iio_info ads1262_iio_info = {
 	.read_raw = ads1262_read_raw,
+	.read_avail = ads1262_read_avail,
+	.write_raw = ads1262_write_raw,
 	.debugfs_reg_access = ads1262_debugfs_reg_access,
 	.fwnode_xlate = ads1262_fwnode_xlate,
 };
@@ -697,6 +861,49 @@ static const struct regmap_bus ads1262_regmap_bus = {
 	.max_raw_write = ADS1262_REGMAP_WRITE_SZ,
 };
 
+static void ads1262_populate_samp_freqs(struct ads1262 *st)
+{
+	u64 freq_Hz, freq_uHz;
+	u32 freq_rem;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(st->sampling_freq_table); i++) {
+		freq_uHz = div_u64(mul_u32_u32(st->clk_rate, MICRO),
+				   ADS1262_MODULATOR_DIV *
+				   ads1262_mod_decimator_a[i] *
+				   ads1262_mod_decimator_b[i]);
+		freq_Hz = div_u64_rem(freq_uHz, MICRO, &freq_rem);
+
+		st->sampling_freq_table[i][0] = (int)freq_Hz;
+		st->sampling_freq_table[i][1] = (int)freq_rem;
+	}
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(st->sampling_freq_fir); i++) {
+		/*
+		 * The FIR filter does not support the 16.6 SPS data rate so it
+		 * gets mapped to 20 SPS instead.
+		 */
+		switch (i) {
+		case ADS1262_DR_2_5_SPS ... ADS1262_DR_10_SPS:
+			st->sampling_freq_fir[i][0] = st->sampling_freq_table[i][0];
+			st->sampling_freq_fir[i][1] = st->sampling_freq_table[i][1];
+			break;
+		case ADS1262_DR_16_6_SPS:
+			st->sampling_freq_fir[i][0] = st->sampling_freq_table[ADS1262_DR_20_SPS][0];
+			st->sampling_freq_fir[i][1] = st->sampling_freq_table[ADS1262_DR_20_SPS][1];
+			break;
+		}
+	}
+}
+
+static int ads1262_populate_tables(struct iio_dev *indio_dev)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+
+	ads1262_populate_samp_freqs(st);
+
+	return 0;
+}
+
 static int ads1262_parse_channel_node(struct ads1262 *st,
 				      struct iio_chan_spec *spec,
 				      struct fwnode_handle *node)
@@ -763,8 +970,15 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
 	if (!chan_specs)
 		return -ENOMEM;
 
+	st->num_channels = num_fw_channels + ADS1262_MON_CHANNEL_COUNT;
+	st->channels = devm_kcalloc(dev, st->num_channels, sizeof(*st->channels),
+				    GFP_KERNEL);
+	if (!st->channels)
+		return -ENOMEM;
+
 	device_for_each_named_child_node_scoped(dev, node, "channel") {
 		struct iio_chan_spec *spec = &chan_specs[i];
+		struct ads1262_channel *chan = &st->channels[i];
 
 		ret = fwnode_property_read_u32(node, "reg", &reg);
 		if (ret)
@@ -772,6 +986,8 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
 		if (reg >= ADS1262_MONITOR_ADDR_OFFSET)
 			return dev_err_probe(dev, -EINVAL, "%pfwP: reg out of range\n", node);
 
+		*chan = (struct ads1262_channel)ads1262_default_channel;
+
 		ret = ads1262_parse_channel_node(st, spec, node);
 		if (ret)
 			return ret;
@@ -786,7 +1002,9 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
 			.storagebits = 32,
 			.endianness = IIO_BE,
 		};
-		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+					   BIT(IIO_CHAN_INFO_SAMP_FREQ);
+		spec->info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ);
 
 		i++;
 	}
@@ -795,6 +1013,7 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
 	       sizeof(ads1262_monitor_chan_specs));
 
 	for (unsigned int mon = 0; mon < ADS1262_MON_CHANNEL_COUNT; mon++) {
+		st->channels[i] = (struct ads1262_channel)ads1262_default_channel;
 		chan_specs[i].scan_index = i;
 		i++;
 	}
@@ -890,6 +1109,10 @@ static int ads1262_spi_probe(struct spi_device *spi)
 
 	indio_dev->name = ads1262_device_id_to_name[st->dev_id];
 
+	ret = ads1262_populate_tables(indio_dev);
+	if (ret)
+		return ret;
+
 	/*
 	 * REVISIT: This chip has software polling capabilities, which could be
 	 * used to stop depending on the DRDY signal.

-- 
2.55.0

