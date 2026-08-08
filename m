Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4830B3B6366
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 03:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786161541; cv=none; b=EgzTAvemUovyV1apfxphK7iCcbYbLKeylvsBCS2m0SfxY7+FDQHmQdthOymS1zQrwIklRAbEpCl8cNdbcXYM6bupdO8qD6uvvc+AzOWNu3k/4z5+9G+4VADL0yUu6ghSdZqBdit4rQX5CCLAlnyuEXZdK1xNoldHpnYtx4r/6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786161541; c=relaxed/simple;
	bh=rKTg6Z6bdmNBcOyQxmrNHPC5g7lyGZef9+Jc/z/tVAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SPNQnguuZcu+Hfjr0avWM0uicd4IVkK1/lmaQ3fYH4Hpq7fOQRdGRvxJW/qWdB04fEMekmnHyfCS3q3vYQEfxjxQXDnFY7+GcXmGXy5oh0I2z5blBXlzA2HCTiw8D0Xm8FoGBlp/ICmeDb41WL6uWFN+Yyc2pm6vCoVwBFAwbw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLAM25eP; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLAM25eP"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c38568d9e1so93625e0c.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 20:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786161538; x=1786766338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7DnKvLjulZND4V/08SqsRVJDgo0f0h8OLuOe9xeaCYg=;
        b=iLAM25eP2vjDmEdr++PyDpgnuJ56kiNaPZlumiq0u+Zi+5MLZq7bWXOm59qS+NZbsL
         8B/fj++cbiw8Avr+vpFn08Du0agD9bi4ZrGNhRR1SL8ilbDa1NHjxiH6uzH+rsNwIPH5
         rQdv4VC0h29v4gGD9knrbtkLGd6plroimX2+BXpg3qP69BIxqo1sgE9aaeerNicsb/4d
         UmeKtQHRmJ38/E5KxQ+EiGQLdjT91rc8LukEoydtrTk6dNDjSXbXR1vNpvx+Sf94vp+r
         kUgS9WNpMEgqJ53RfAe90W4qx/smezLzNktjNYIybHZiQ9bIovkkWk0LpJrRDvmkdOV1
         Sa8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786161538; x=1786766338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7DnKvLjulZND4V/08SqsRVJDgo0f0h8OLuOe9xeaCYg=;
        b=L/IF/d40UxhGSVVcjRhAM1aORfQK20woaqctgKU2+A273Mc0GsQ+n+CCVPL7PMomfB
         0XQ2RDHG/bBJdzXmY/mrWQMQKtdd2ojcXnch3yXjNAqHG1wuZtTWoaYDY/QVGL4qdRJi
         J620ETOj1mm5RL3/z4AHtIss3qxZOwug2LuNQGM5ZWGD7dWEm0Frsut94wNWVdiNiqNY
         6NK/HN4PtsOOAjsqvymEWewCIVR4L/byA6gxtVECDlv6cLWumuR2tFFE7QN7oIltk3Cz
         c3QEt3H48znqrXsLnbJx8KWW0g8CZG5SwFKve9/chgJp3HTmao4H/5AaLtebiAivz1Ru
         of0g==
X-Forwarded-Encrypted: i=1; AHgh+Rq9LVyPnw/EwLojjLyAWsNBdlOou09YLO8sJjIit5B7UUq0qAy0lKUzNpDzceJ989bDN1zaQ1LOQpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyj+cMy0AaYPfWveLoh4ekaxCSx+w+Gc8k2k+a+bPuyR3UB6Z5
	sQp+OZaxBmJRQmtIZHvxenim4Ot8RgLTYz4HGqDmXoRyO9pRAStWt03T
X-Gm-Gg: AR+sD12UgAZAZzX8+uLZ5gSBeYaDnqkORy/Y8OoAiItrkh/Nbgcy6tCZiwHigG69MAu
	GYTxP62SMtuIz0igl4OGDPBehwg4Bi+xFKDRAO6a+tRiYIlVuzoWMqiPtrdQ0/v0ehpRvgI7Jfa
	F1ocdRQKTCu/caMtJNAT+9eXLye+dbSfYyeqw6lxunVbu2aMsg5Tlj/9gjy+dvrPkj3i1nGt3hB
	E+aVFSR6SIAV7Bu+M6y3qBND4sfKL9xS9NdcwXxwiUrYWvgPyyP056Mk+n9Q15b4YnLff5iI7Jx
	v1mVAAUTPO11Yr1dCz8Ok9sU3YwmL+XzPF0fEkxSShKYf3zNc1W2dIQajeWV9vW4cY+3oLts3V1
	T0fn+t+oLCY+Ut6yYKgI79Z3EGETjaTvsu7KAqyl7tTsePgHkwIYjwGTwPCgLtWToxKcARPJeL5
	1SOsXrNLdgDdx02y02Yqsdn9WxavgXRwDPsNhs4vPQ15tb5+ueE2oNscNaMDk=
X-Received: by 2002:a05:6102:c10:b0:75f:e517:ec96 with SMTP id ada2fe7eead31-760e3194fc4mr6814637137.0.1786161537974;
        Fri, 07 Aug 2026 20:58:57 -0700 (PDT)
Received: from [192.168.100.6] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c40b212fa6sm1432936e0c.16.2026.08.07.20.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 20:58:57 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 07 Aug 2026 22:58:26 -0500
Subject: [PATCH v3 4/9] iio: adc: ti-ads1262: support per-channel reference
 and gain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-ads126x-v3-4-f89925d72792@gmail.com>
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
In-Reply-To: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=19827; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=rKTg6Z6bdmNBcOyQxmrNHPC5g7lyGZef9+Jc/z/tVAQ=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFllK8tfNJ+55t2tx6H0p5Tj4jkmue6l7Rf9g3ZtnJ574
 tzdlM7sjlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZjIAS6Gf2YP/vh+az5Swybc
 uuekuJaG1zONb89/vy50ubmAPSzuywVGhlVXubse1R2e+8l7ycat+v0zuyW+2/5IYp287MpujyO
 d7MwA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Allow each channel to select its voltage reference through the
"reference-sources" firmware property. Then, use the reference voltage
to calculate available scales.

The ADS1262 allows single-ended supply configurations or bipolar supply
configurations. In single ended configurations both the analog and
digital rails share the same ground, i.e. AVSS = DGND = 0 V. In bipolar
supply configurations, AVSS can go below ground, e.g. AVSS = -2.5 V.

If AVSS is below ground, the ADC can achieve true bipolar measurements
and the external references can also have voltage levels below ground.
This is currently an issue because the regulator subsystem doesn't
support negative voltages.

The ad4170-4 driver faces this problem too and the same workaround is
used in this case: assume every regulator reports magnitudes (absolute
values). If the chip has a bipolar supply configuration, then assume
positive references are above ground (>= 0 V) and negative references
are below ground (<= 0 V). This is not a hardware constraint, but it is
the most common wiring.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/ti-ads1262.c | 417 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 406 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index b3b7b1249102..360ce01a5871 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -8,6 +8,7 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/bitmap.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
@@ -18,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/lockdep.h>
 #include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
@@ -25,6 +27,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/units.h>
 
@@ -97,6 +100,9 @@
 #define ADS1262_IDACMAG_REG			0x0E
 
 #define ADS1262_REFMUX_REG			0x0F
+#define   ADS1262_REFMUX_RMUXP_MASK		GENMASK(5, 3)
+#define   ADS1262_REFMUX_RMUXN_MASK		GENMASK(2, 0)
+
 #define ADS1262_TDACP_REG			0x10
 #define ADS1262_TDACN_REG			0x11
 #define ADS1262_GPIOCON_REG			0x12
@@ -117,8 +123,12 @@
 
 #define ADS1262_MAX_CHANNEL_COUNT		16
 #define ADS1262_MAX_REGMAP_WRITE		8
+#define ADS1262_EXT_REF_COUNT			3
 #define ADS1262_ADC1_RESOLUTION			32
 
+#define ADS1262_TEMP_SLOPE_uV_C			420ULL
+#define ADS1262_TEMP_ZERO_C			111900ULL
+
 enum {
 	ADS1262_RUNMODE_CONTINUOUS,
 	ADS1262_RUNMODE_PULSE,
@@ -171,12 +181,38 @@ enum {
 	ADS1262_INPMUX_FLOAT,
 };
 
+enum {
+	ADS1262_RMUXP_INTERNAL,
+	ADS1262_RMUXP_REFP1,
+	ADS1262_RMUXP_REFP2,
+	ADS1262_RMUXP_REFP3,
+	ADS1262_RMUXP_AVDD,
+	ADS1262_RMUXP_COUNT
+};
+
+enum {
+	ADS1262_RMUXN_INTERNAL,
+	ADS1262_RMUXN_REFN1,
+	ADS1262_RMUXN_REFN2,
+	ADS1262_RMUXN_REFN3,
+	ADS1262_RMUXN_AVSS,
+	ADS1262_RMUXN_COUNT
+};
+
 struct ads1262_chip_info {
 	const char *name;
 };
 
 struct ads1262_channel {
 	u8 data_rate;
+	u8 gain;
+	u8 ref_p;
+	u8 ref_n;
+	bool ref_reversal;
+	bool is_resistance;
+	int offset;
+	int scales[6][2];
+	size_t num_scales;
 	int samp_freqs[ADS1262_DR_COUNT][2];
 };
 
@@ -192,6 +228,12 @@ struct ads1262 {
 	unsigned int num_channels;
 	struct ads1262_channel *channels;
 	struct completion drdy;
+	u32 rref_ohms[ADS1262_EXT_REF_COUNT][ADS1262_EXT_REF_COUNT];
+	int refp_uV[ADS1262_RMUXP_COUNT];
+	int refn_uV[ADS1262_RMUXN_COUNT];
+	bool need_avdd_uV;
+	bool need_avss_uV;
+	bool bipolar_supply;
 
 	/* Protects transfer buffers and concurrent SPI transfers */
 	struct mutex xfer_lock;
@@ -216,6 +258,24 @@ static const u32 ads1262_data_rate_div[] = {
 	[ADS1262_DR_38400_SPS]	= 8 * 24 * 1,
 };
 
+static const char * const ads1262_ref_sources_pos[] = {
+	[ADS1262_RMUXP_INTERNAL] = "internal",
+	[ADS1262_RMUXP_REFP1] = "refp1",
+	[ADS1262_RMUXP_REFP2] = "refp2",
+	[ADS1262_RMUXP_REFP3] = "refp3",
+	[ADS1262_RMUXP_AVDD] = "avdd",
+	NULL
+};
+
+static const char * const ads1262_ref_sources_neg[] = {
+	[ADS1262_RMUXN_INTERNAL] = "internal",
+	[ADS1262_RMUXN_REFN1] = "refn1",
+	[ADS1262_RMUXN_REFN2] = "refn2",
+	[ADS1262_RMUXN_REFN3] = "refn3",
+	[ADS1262_RMUXN_AVSS] = "avss",
+	NULL
+};
+
 static int ads1262_find_two(const int (*array)[2], size_t num_elements, int val,
 			    int val2)
 {
@@ -231,6 +291,12 @@ static int ads1262_find_two(const int (*array)[2], size_t num_elements, int val,
 	return i;
 }
 
+static bool ads1262_ref_is_external(int ref_p, int ref_n)
+{
+	return in_range(ref_p, ADS1262_RMUXP_REFP1, ADS1262_EXT_REF_COUNT) &&
+	       in_range(ref_n, ADS1262_RMUXN_REFN1, ADS1262_EXT_REF_COUNT);
+}
+
 static int ads1262_dev_cmd(struct ads1262 *st, u8 opcode)
 {
 	guard(mutex)(&st->xfer_lock);
@@ -365,17 +431,33 @@ static int ads1262_channel_enable(struct ads1262 *st,
 	guard(mutex)(&st->xfer_lock);
 	guard(mutex)(&st->chan_lock);
 
-	val = FIELD_PREP(ADS1262_MODE2_DR_MASK, chan->data_rate);
+	val = FIELD_PREP(ADS1262_MODE0_REFREV_MASK, chan->ref_reversal);
+	ret = regmap_update_bits(st->regmap, ADS1262_MODE0_REG,
+				 ADS1262_MODE0_REFREV_MASK, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(ADS1262_MODE2_DR_MASK, chan->data_rate) |
+	      FIELD_PREP(ADS1262_MODE2_GAIN_MASK, chan->gain);
 	ret = regmap_update_bits(st->regmap, ADS1262_MODE2_REG,
-				 ADS1262_MODE2_DR_MASK, val);
+				 ADS1262_MODE2_DR_MASK |
+				 ADS1262_MODE2_GAIN_MASK, val);
 	if (ret)
 		return ret;
 
 	val = FIELD_PREP(ADS1262_INPMUX_MUXN_MASK, spec->channel2) |
 	      FIELD_PREP(ADS1262_INPMUX_MUXP_MASK, spec->channel);
-	return regmap_update_bits(st->regmap, ADS1262_INPMUX_REG,
+	ret = regmap_update_bits(st->regmap, ADS1262_INPMUX_REG,
 				 ADS1262_INPMUX_MUXN_MASK |
 				 ADS1262_INPMUX_MUXP_MASK, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(ADS1262_REFMUX_RMUXN_MASK, chan->ref_n) |
+	      FIELD_PREP(ADS1262_REFMUX_RMUXP_MASK, chan->ref_p);
+	return regmap_update_bits(st->regmap, ADS1262_REFMUX_REG,
+				  ADS1262_REFMUX_RMUXN_MASK |
+				  ADS1262_REFMUX_RMUXP_MASK, val);
 }
 
 static int ads1262_set_runmode(struct ads1262 *st, u8 runmode)
@@ -436,6 +518,26 @@ static int ads1262_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 
+	case IIO_CHAN_INFO_SCALE: {
+		guard(mutex)(&st->chan_lock);
+
+		*val = chan_data->scales[chan_data->gain][0];
+		*val2 = chan_data->scales[chan_data->gain][1];
+
+		return IIO_VAL_DECIMAL64_PICO;
+	}
+
+	case IIO_CHAN_INFO_OFFSET: {
+		if (chan->type != IIO_TEMP)
+			return -EPERM;
+
+		guard(mutex)(&st->chan_lock);
+
+		*val = chan_data->offset;
+
+		return IIO_VAL_INT;
+	}
+
 	case IIO_CHAN_INFO_SAMP_FREQ: {
 		guard(mutex)(&st->chan_lock);
 
@@ -458,6 +560,12 @@ static int ads1262_read_avail(struct iio_dev *indio_dev,
 	struct ads1262_channel *chan_data = &st->channels[chan->scan_index];
 
 	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*type = IIO_VAL_DECIMAL64_PICO;
+		*vals = (const int *)chan_data->scales;
+		*length = chan_data->num_scales * 2;
+		return IIO_AVAIL_LIST;
+
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		*vals = (const int *)chan_data->samp_freqs;
@@ -484,6 +592,16 @@ static int ads1262_write_raw(struct iio_dev *indio_dev,
 	guard(mutex)(&st->chan_lock);
 
 	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		ret = ads1262_find_two(chan_data->scales, chan_data->num_scales,
+				       val, val2);
+		if (ret < 0)
+			return ret;
+
+		chan_data->gain = ret;
+
+		return 0;
+
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = ads1262_find_two(chan_data->samp_freqs,
 				       ARRAY_SIZE(chan_data->samp_freqs),
@@ -513,10 +631,22 @@ static int ads1262_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int re
 	return regmap_write(st->regmap, reg, writeval);
 }
 
+static int ads1262_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_DECIMAL64_PICO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
 static const struct iio_info ads1262_iio_info = {
 	.read_raw = ads1262_read_raw,
 	.read_avail = ads1262_read_avail,
 	.write_raw = ads1262_write_raw,
+	.write_raw_get_fmt = ads1262_write_raw_get_fmt,
 	.debugfs_reg_access = ads1262_debugfs_reg_access,
 };
 
@@ -688,6 +818,91 @@ static const struct regmap_bus ads1262_regmap_bus = {
 	.max_raw_write = ADS1262_MAX_REGMAP_WRITE,
 };
 
+static void ads1262_calculate_scales(int (*scales)[2], size_t num_scales,
+				     u32 full_scale, u64 mult,
+				     u32 resolution)
+{
+	unsigned int i;
+	s64 val;
+
+	for (i = 0; i < num_scales; i++) {
+		val = mul_u64_u64_shr(full_scale, mult, resolution - 1 + i);
+		iio_val_s64_decompose(val, &scales[i][0], &scales[i][1]);
+	}
+}
+
+static int ads1262_populate_scales_resistance(struct ads1262 *st,
+					      const struct iio_chan_spec *spec)
+{
+	struct ads1262_channel *chan = &st->channels[spec->scan_index];
+	u32 full_scale;
+
+	if (WARN_ON(!ads1262_ref_is_external(chan->ref_p, chan->ref_n)))
+		return -EINVAL;
+
+	full_scale = st->rref_ohms[chan->ref_p - 1][chan->ref_n - 1];
+
+	chan->num_scales = ARRAY_SIZE(chan->scales);
+
+	ads1262_calculate_scales(chan->scales, chan->num_scales, full_scale,
+				 PICO, ADS1262_ADC1_RESOLUTION);
+
+	return 0;
+}
+
+static int ads1262_populate_scales_temp(struct ads1262 *st,
+					const struct iio_chan_spec *spec)
+{
+	struct device *dev = &st->spi->dev;
+	struct ads1262_channel *chan = &st->channels[spec->scan_index];
+	u32 full_scale;
+	u64 mult;
+
+	full_scale = abs(st->refp_uV[chan->ref_p] - st->refn_uV[chan->ref_n]);
+	if (full_scale < 900000)
+		return dev_err_probe(dev, -EINVAL, "channel@%u: reference voltage below 0.9V\n",
+				     spec->scan_index);
+
+	chan->offset = -div_s64(ADS1262_TEMP_ZERO_C <<
+				(ADS1262_ADC1_RESOLUTION - 1), full_scale);
+
+	chan->num_scales = 1;
+
+	mult = PICO * MILLIDEGREE_PER_DEGREE / ADS1262_TEMP_SLOPE_uV_C;
+	ads1262_calculate_scales(chan->scales, chan->num_scales, full_scale,
+				 mult, ADS1262_ADC1_RESOLUTION);
+
+	return 0;
+}
+
+static int ads1262_populate_scales_voltage(struct ads1262 *st,
+					   const struct iio_chan_spec *spec)
+{
+	struct device *dev = &st->spi->dev;
+	struct ads1262_channel *chan = &st->channels[spec->scan_index];
+	u32 full_scale;
+	u64 mult;
+
+	full_scale = abs(st->refp_uV[chan->ref_p] - st->refn_uV[chan->ref_n]);
+	if (full_scale < 900000)
+		return dev_err_probe(dev, -EINVAL, "channel@%u: reference voltage below 0.9V\n",
+				     spec->scan_index);
+
+	if (spec->channel >= ADS1262_INPMUX_AVDD &&
+	    spec->channel <= ADS1262_INPMUX_DVDD) {
+		chan->num_scales = 1;
+		mult = 4;
+	} else {
+		chan->num_scales = ARRAY_SIZE(chan->scales);
+		mult = 1;
+	}
+
+	ads1262_calculate_scales(chan->scales, chan->num_scales, full_scale,
+				 NANO * mult, ADS1262_ADC1_RESOLUTION);
+
+	return 0;
+}
+
 static void ads1262_populate_samp_freqs(struct ads1262 *st,
 					struct ads1262_channel *chan)
 {
@@ -707,12 +922,102 @@ static void ads1262_populate_samp_freqs(struct ads1262 *st,
 static int ads1262_populate_tables(struct iio_dev *indio_dev)
 {
 	struct ads1262 *st = iio_priv(indio_dev);
+	const struct iio_chan_spec *spec;
 	struct ads1262_channel *chan;
+	int ret;
+
 
 	for (unsigned int i = 0; i < st->num_channels; i++) {
+		spec = &indio_dev->channels[i];
 		chan = &st->channels[i];
 
 		ads1262_populate_samp_freqs(st, chan);
+
+		switch (spec->type) {
+		case IIO_VOLTAGE:
+			ret = ads1262_populate_scales_voltage(st, spec);
+			if (ret)
+				return ret;
+			break;
+		case IIO_TEMP:
+			ret = ads1262_populate_scales_temp(st, spec);
+			if (ret)
+				return ret;
+			break;
+		case IIO_RESISTANCE:
+			ret = ads1262_populate_scales_resistance(st, spec);
+			if (ret)
+				return ret;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
+static int ads1262_parse_references(struct ads1262 *st)
+{
+	struct device *dev = &st->spi->dev;
+	unsigned int i, j;
+	char name[sizeof("ti,refpN-refnM-resistor-ohms")];
+	u32 ohms;
+	int ret;
+
+	st->refp_uV[ADS1262_RMUXP_INTERNAL] = st->refn_uV[ADS1262_RMUXN_AVSS] + 2500000;
+	st->refn_uV[ADS1262_RMUXN_INTERNAL] = st->refn_uV[ADS1262_RMUXN_AVSS];
+
+	for (i = ADS1262_RMUXP_REFP1; i <= ADS1262_RMUXP_REFP3; i++) {
+		scnprintf(name, sizeof(name), "refp%u", i);
+		ret = devm_regulator_get_enable_read_voltage(dev, name);
+		if (ret < 0 && ret != -ENODEV)
+			return dev_err_probe(dev, ret, "failed to read reference voltage: %s\n",
+					     name);
+
+		st->refp_uV[i] = ret == -ENODEV ? 0 : ret;
+	}
+
+	for (i = ADS1262_RMUXN_REFN1; i <= ADS1262_RMUXN_REFN3; i++) {
+		scnprintf(name, sizeof(name), "refn%u", i);
+		ret = devm_regulator_get_enable_read_voltage(dev, name);
+		if (ret < 0 && ret != -ENODEV)
+			return dev_err_probe(dev, ret, "failed to read reference voltage: %s\n",
+					     name);
+
+		/*
+		 * REVISIT: Currently the regulator subsystem doesn't support
+		 * reading negative voltages. If we have a bipolar supply
+		 * configuration (AVSS < 0), then we are forced to assume that
+		 * negative references are either 0V (no regulator) or below
+		 * ground magnitudes.
+		 */
+		if (st->bipolar_supply)
+			st->refn_uV[i] = ret == -ENODEV ? 0 : -ret;
+		else
+			st->refn_uV[i] = ret == -ENODEV ? 0 : ret;
+	}
+
+	for (i = ADS1262_RMUXP_REFP1; i <= ADS1262_RMUXP_REFP3; i++) {
+		for (j = ADS1262_RMUXN_REFN1; j <= ADS1262_RMUXN_REFN3; j++) {
+			scnprintf(name, sizeof(name),
+				  "ti,refp%u-refn%u-resistor-ohms", i, j);
+
+			if (!device_property_present(dev, name))
+				continue;
+
+			ret = device_property_read_u32(dev, name, &ohms);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "failed to read reference resistor: %s\n",
+						     name);
+			if (!ohms)
+				return dev_err_probe(dev, -EINVAL,
+						     "reference resistor can't be 0 ohms: %s\n",
+						     name);
+
+			st->rref_ohms[i - 1][j - 1] = ohms;
+		}
 	}
 
 	return 0;
@@ -745,7 +1050,10 @@ static int ads1262_parse_channel_node(struct ads1262 *st,
 				      struct iio_chan_spec *spec,
 				      struct fwnode_handle *node)
 {
+	struct ads1262_channel *chan = &st->channels[spec->scan_index];
 	struct device *dev = &st->spi->dev;
+	const char *sources[2];
+	char name[sizeof("ti,refpN-refnM-resistor-ohms")];
 	u32 pins[2];
 	int ret;
 
@@ -785,6 +1093,49 @@ static int ads1262_parse_channel_node(struct ads1262 *st,
 	spec->channel = pins[0];
 	spec->channel2 = pins[1];
 
+	if (fwnode_property_present(node, "reference-sources")) {
+		ret = fwnode_property_read_string_array(node, "reference-sources",
+							sources, ARRAY_SIZE(sources));
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "%s: failed to read reference-sources\n",
+					     fwnode_get_name(node));
+		if (ret < 2)
+			return dev_err_probe(dev, -EINVAL, "%s: missing reference-sources\n",
+					     fwnode_get_name(node));
+
+		ret = match_string(ads1262_ref_sources_pos, -1, sources[0]);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "%s: invalid positive reference source\n",
+					     fwnode_get_name(node));
+		chan->ref_p = ret;
+
+		ret = match_string(ads1262_ref_sources_neg, -1, sources[1]);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "%s: invalid negative reference source\n",
+					     fwnode_get_name(node));
+		chan->ref_n = ret;
+
+		if ((chan->ref_p == ADS1262_RMUXP_INTERNAL ||
+		     chan->ref_n == ADS1262_RMUXN_INTERNAL) && chan->ref_p != chan->ref_n)
+			return dev_err_probe(dev, -EINVAL,
+					     "%s: the internal reference must be selected symmetrically\n",
+					     fwnode_get_name(node));
+
+		if (chan->ref_p == ADS1262_RMUXP_AVDD)
+			st->need_avdd_uV = true;
+		if (chan->ref_n == ADS1262_RMUXN_AVSS)
+			st->need_avss_uV = true;
+
+		if (ads1262_ref_is_external(chan->ref_p, chan->ref_n)) {
+			scnprintf(name, sizeof(name), "ti,refp%u-refn%u-resistor-ohms",
+				  chan->ref_p, chan->ref_n);
+			if (device_property_present(dev, name))
+				chan->is_resistance = true;
+		}
+	}
+
+	chan->ref_reversal = fwnode_property_read_bool(node, "ti,reference-reversal");
+
 	return 0;
 }
 
@@ -845,6 +1196,8 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
 
 		if (specs[reg].channel == ADS1262_INPMUX_TEMP)
 			specs[reg].type = IIO_TEMP;
+		else if (st->channels[reg].is_resistance)
+			specs[reg].type = IIO_RESISTANCE;
 		else
 			specs[reg].type = IIO_VOLTAGE;
 
@@ -852,9 +1205,14 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
 			specs[reg].indexed = true;
 
 		specs[reg].info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-						BIT(IIO_CHAN_INFO_SAMP_FREQ);
+						BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+						BIT(IIO_CHAN_INFO_SCALE);
+		if (specs[reg].channel == ADS1262_INPMUX_TEMP)
+			specs[reg].info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
+
 		specs[reg].info_mask_separate_available =
-				BIT(IIO_CHAN_INFO_SAMP_FREQ);
+			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+			BIT(IIO_CHAN_INFO_SCALE);
 	}
 
 	specs[num_specs - 1] = IIO_CHAN_SOFT_TIMESTAMP(num_specs - 1);
@@ -874,13 +1232,46 @@ static int ads1262_supply_setup(struct ads1262 *st)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to get dvdd regulator\n");
 
-	ret = devm_regulator_get_enable(dev, "avdd");
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "failed to get avdd regulator\n");
+	if (st->need_avdd_uV) {
+		ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "failed to get avdd voltage\n");
 
-	ret = devm_regulator_get_enable_optional(dev, "avss");
-	if (ret < 0 && ret != -ENODEV)
-		return dev_err_probe(dev, ret, "failed to get avss regulator\n");
+		st->refp_uV[ADS1262_RMUXP_AVDD] = ret;
+	} else {
+		ret = devm_regulator_get_enable(dev, "avdd");
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "failed to get avdd regulator\n");
+	}
+
+	/*
+	 * REVISIT: The AVSS supply has a minimum of -2.5V and maximum of 0V.
+	 * Currently the regulator subsystem doesn't support negative voltages,
+	 * so we assume the value returned here is actually the magnitude
+	 * (absolute value).
+	 *
+	 * This limitation forces us to assume that, if we have a bipolar supply
+	 * (AVSS < 0V), all negative references are below ground (REFN <= 0V)
+	 * and positive references are above ground (REFP >= 0V), as this is the
+	 * most common configuration.
+	 */
+	if (st->need_avss_uV) {
+		ret = devm_regulator_get_enable_read_voltage(dev, "avss");
+		if (ret < 0 && ret != -ENODEV)
+			return dev_err_probe(dev, ret, "failed to get avss voltage\n");
+
+		if (ret != -ENODEV) {
+			st->refn_uV[ADS1262_RMUXN_AVSS] = -ret;
+			st->bipolar_supply = true;
+		}
+	} else {
+		ret = devm_regulator_get_enable_optional(dev, "avss");
+		if (ret < 0 && ret != -ENODEV)
+			return dev_err_probe(dev, ret, "failed to get avss regulator\n");
+
+		if (ret != -ENODEV)
+			st->bipolar_supply = true;
+	}
 
 	return 0;
 }
@@ -939,6 +1330,10 @@ static int ads1262_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = ads1262_parse_references(st);
+	if (ret)
+		return ret;
+
 	ret = ads1262_populate_tables(indio_dev);
 	if (ret)
 		return ret;

-- 
2.55.0

