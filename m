Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC3941D202
	for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791615224; cv=none; b=jOzDKY8LcVdNX6gE7HXwj44VeURRFcBxilbdai7YWSpL8fpt98owYe9UmRo8cUpFEZhWvkOWdh5UXuuT67xyRIPBxfDMENgvEyFwAA65xC5d/EwcpdC4O94YcGkLjwfVJIUeKhxCpEV5qBXJfwt6yW+Ug+n7AHx0FUAN2sbDzg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791615224; c=relaxed/simple;
	bh=kpAxzk3BkOIi9S7HPNy5wexG8G31sRUp78El+egjQHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tkH43ThDqqiuxlNnHAlGoDn32Lj+wPMTtoAydm1qN3xGsKjl6jR9pC9lC0JbbLIQ4LDAPKIYJH1n6pt1RQrvzpjPch1u4LazwcKt0++zqJGhBTgGo+CU0Jie6W1bhaO9epmiHEJ/gkHh4xSBT5+jxftnoea+IHikpaNanObtcBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvIlqZ0s; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvIlqZ0s"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3282db206d3so1377044eec.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 23:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791615221; x=1792220021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CqpSUIK1b2gb97wgJ3+/+Ux94HLBmlQXPfqaw5SKIpY=;
        b=SvIlqZ0sumyXsLNawMuIvFiVZEdiY3BCUEnFZcNw++f8ev821PKSwZyPW/oEYIWN5N
         euL1lxunvPCVl5HtVZL5bewHZJSsUvVLa0uXb8PCqRdF1jUKYMSry11iSXEzgwlkjjjj
         tBOgseTC9O15dyqa3lqCodDwtYI1lOFZ5srD4zZwn0ZZ5HnXrDzR7SJfmaDAZzFknFHz
         iLuNngRZJXmCiFx/zDF4qCAFyZBvSb6hRASv8NKdA0aCnLz4UnFKqlWQ1/F0pNeGg5ZC
         /7mVb7XuwlrjJwPQHO1ZP3sSMczKQ2EJxWC2ei1OnoUtynhCxu0TUcARruYoW1LEIdnv
         dR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791615221; x=1792220021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CqpSUIK1b2gb97wgJ3+/+Ux94HLBmlQXPfqaw5SKIpY=;
        b=d+IuAa9iaCqjOPm6H9VWP16BuhQ3rYwRfaXafDtqfrh4yIWkoV+hFs5hWV570uUPRP
         DGwM0JRRh+TVmWNAXzD9jTwOzcB37nHucvXB1A+SGZsoKJGJU9dfW1dNohv/ot1RMREr
         gFxEnuqjCOOG01sKInWPdib5OC4tg5b3dRDLnrM67PFEcjEikbbAyyBXGOgKgUZyWKne
         bCH1SHIQ7SegvmOmMZMqcoZ/bUv4lF8xaQBMeZa95ptalDVCtyEZhFCbyUQJ0raty7n9
         wrd6n8HN2Wosj1EZq5A3lR/LAdIrMqY4DSXtCbn8VJiZS8iTwSWmOtKKh11PdSU+C9KA
         uHaQ==
X-Forwarded-Encrypted: i=1; AKwUvBxU9Ta94PB74fP8oOR0IRrHBlYZIG6AkvRz17JP+GWN5OO1ZdczOmlharPd/mul7w/gzHU4MDCTA94=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkKH1yFepk/Fy8zdqRihMvnIoj38rpT8yAFJUwG9Of6juqMKPu
	dSzEDVkSH0NnTLD40Nx/y+XTZEuSdo2MSjlk8HtkK6mmgZiARVXx8qLZ
X-Gm-Gg: AYBFou1jpOlmVjJs7G4qUm4khVDIa3/eFH+rlU5kOnl76XBSRmukmt/Nxm4ZHI3fOKd
	lpQcTq6QA6oOjAplyQdsruUxnm/wPQMoAYnLkN9b89+pRcSBrIhDnkxnPeDxe5Jrfds6PoWfL41
	z5TOGEXekwZq74ilWh9ExOJmFP8rra9w9hkGScLv8kYTeiVg1m5MDi7QFw2UD7m2g4aT1WnuEC5
	12vBAHM1L3IO1FdJp3tPiCWlhw8FdgjY6pTm3pgFwJNJNL8RKl04DcVPCEwwWNxoq45h0bNPq9T
	lMGD50YVDcyIbd6hNs+Z9B/3+CJ5zJ8jazwES1HpoDX/3RgY/uJIy45juxVkUJoorR1WQxibrhQ
	gRqCGILAvQcXvFdaVx+M6jvz+wCqCQ48vePmc3t9vMpvOuEouUk1NBm/U7IurS9nf4ztUVq+kHQ
	3ccttz6gj3wuSZpWIzGjAmytqUzcm2Go6UpX6rltMlrdimTbLN/6jX+Ai6CT/gPiTkld+Gz6H3/
	Pe0vNumyT4yC1HRUAJj/y4ietw6Yz4A1C5pCj8=
X-Received: by 2002:a05:693c:41cb:10b0:351:679e:ba2a with SMTP id 5a478bee46e88-3537e0065cemr5650433eec.23.1791615220731;
        Fri, 09 Oct 2026 23:53:40 -0700 (PDT)
Received: from [192.168.100.70] (host-200-61-172-117.iplanisp.com.ar. [200.61.172.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb5e9sm13009650eec.20.2026.10.09.23.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 23:53:40 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 10 Oct 2026 03:52:43 -0300
Subject: [PATCH v5 04/10] iio: adc: ti-ads1262: support per-channel
 sampling frequency
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-ads126x-v5-4-49e331cb2fed@gmail.com>
References: <20261010-ads126x-v5-0-49e331cb2fed@gmail.com>
In-Reply-To: <20261010-ads126x-v5-0-49e331cb2fed@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11744; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=kpAxzk3BkOIi9S7HPNy5wexG8G31sRUp78El+egjQHg=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFknHzyNuv/5XflJW829rs+LglUS+dP+Cp33bp/A7LSc2
 +8z55arHaUsDGJcDLJiiiztCYu+PYrKe+t3IPQ+zBxWJpAhDFycAjCRWnFGhrdcGvbLupN5+0+F
 7TdiWGPr8/w+ky13zgNO8esa624wLGdkuF6upVu+YV7QiakhYS0FahPr+lZnzk1eeliCRZe34GA
 kKwA=
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
index a54f78e88012..7a6fa009ddad 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -24,6 +24,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include <asm/byteorder.h>
 
@@ -98,6 +99,7 @@
 #define     ADS1262_DR_14400_SPS		  13
 #define     ADS1262_DR_19200_SPS		  14
 #define     ADS1262_DR_38400_SPS		  15
+#define     ADS1262_DR_COUNT			  (ADS1262_DR_38400_SPS + 1)
 
 #define ADS1262_INPMUX_REG			0x06
 #define   ADS1262_INPMUX_MUXP_MASK		GENMASK(7, 4)
@@ -165,6 +167,7 @@
 #define ADS1262_POWER_TRANS_US			65536
 
 #define ADS1262_NOMINAL_CLK_RATE_HZ		7372800
+#define ADS1262_MODULATOR_DIV			8
 
 #define ADS1262_FW_CHANNEL_COUNT		16
 #define ADS1262_MON_CHANNEL_COUNT		4
@@ -176,16 +179,25 @@ struct ads1262_chip_info {
 	const char *name;
 };
 
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
+	struct ads1262_channel *channels __counted_by_ptr(num_channels);
 	/* protects concurrent SPI transfers */
 	struct mutex xfer_lock;
 	/* protects channel state */
 	struct mutex chan_lock;
 	struct completion drdy;
 	unsigned long clk_rate_hz;
+	int sampling_freq_table[ADS1262_DR_COUNT][2];
+	int sampling_freq_fir[ADS1262_DR_16_6_SPS + 1][2];
 };
 
 static const struct iio_chan_spec ads1262_monitor_chan_specs[] = {
@@ -199,7 +211,9 @@ static const struct iio_chan_spec ads1262_monitor_chan_specs[] = {
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
@@ -212,7 +226,9 @@ static const struct iio_chan_spec ads1262_monitor_chan_specs[] = {
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
@@ -225,7 +241,9 @@ static const struct iio_chan_spec ads1262_monitor_chan_specs[] = {
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
@@ -239,10 +257,66 @@ static const struct iio_chan_spec ads1262_monitor_chan_specs[] = {
 			.storagebits = 32,
 			.endianness = IIO_BE,
 		},
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 };
 
+#define ads1262_default_channel ((struct ads1262_channel) {	\
+	.data_rate = ADS1262_DR_20_SPS,				\
+	.filter = ADS1262_FILTER_FIR,				\
+})
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
@@ -367,9 +441,18 @@ static int ads1262_wait_for_conversion(struct ads1262 *st)
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
@@ -421,6 +504,8 @@ static int ads1262_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int *val,
 			    int *val2, long mask)
 {
+	struct ads1262 *st = iio_priv(indio_dev);
+	struct ads1262_channel *chan_data = &st->channels[chan->scan_index];
 	__be32 raw;
 	int ret;
 
@@ -433,6 +518,83 @@ static int ads1262_read_raw(struct iio_dev *indio_dev,
 
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
@@ -472,6 +634,8 @@ static int ads1262_fwnode_xlate(struct iio_dev *indio_dev,
 
 static const struct iio_info ads1262_iio_info = {
 	.read_raw = ads1262_read_raw,
+	.read_avail = ads1262_read_avail,
+	.write_raw = ads1262_write_raw,
 	.debugfs_reg_access = ads1262_debugfs_reg_access,
 	.fwnode_xlate = ads1262_fwnode_xlate,
 };
@@ -678,6 +842,49 @@ static const struct regmap_bus ads1262_regmap_bus = {
 	.max_raw_write = ADS1262_REGMAP_WRITE_SZ,
 };
 
+static void ads1262_populate_samp_freqs(struct ads1262 *st)
+{
+	u64 freq_Hz, freq_uHz;
+	u32 freq_rem;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(st->sampling_freq_table); i++) {
+		freq_uHz = div_u64(mul_u32_u32(st->clk_rate_hz, MICRO),
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
@@ -744,9 +951,18 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
 	if (!chan_specs)
 		return -ENOMEM;
 
+	st->num_channels = num_fw_channels + ADS1262_MON_CHANNEL_COUNT;
+	st->channels = devm_kcalloc(dev, st->num_channels, sizeof(*st->channels),
+				    GFP_KERNEL);
+	if (!st->channels)
+		return -ENOMEM;
+
 	i = 0;
 	device_for_each_named_child_node_scoped(dev, node, "channel") {
 		struct iio_chan_spec *spec = &chan_specs[i];
+		struct ads1262_channel *chan = &st->channels[i];
+
+		*chan = ads1262_default_channel;
 
 		ret = ads1262_parse_channel_node(st, spec, node);
 		if (ret)
@@ -767,7 +983,9 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
 			.storagebits = 32,
 			.endianness = IIO_BE,
 		};
-		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+					   BIT(IIO_CHAN_INFO_SAMP_FREQ);
+		spec->info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ);
 
 		i++;
 	}
@@ -776,6 +994,7 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
 	       sizeof(ads1262_monitor_chan_specs));
 
 	for (unsigned int mon = 0; mon < ADS1262_MON_CHANNEL_COUNT; mon++) {
+		st->channels[i] = ads1262_default_channel;
 		chan_specs[i].scan_index = i;
 		i++;
 	}
@@ -875,6 +1094,10 @@ static int ads1262_spi_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to configure device\n");
 
+	ret = ads1262_populate_tables(indio_dev);
+	if (ret)
+		return ret;
+
 	/*
 	 * REVISIT: This chip has software polling capabilities, which could be
 	 * used to stop depending on the DRDY signal.

-- 
2.55.0

