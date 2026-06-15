Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C0338F935
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560878; cv=none; b=rrxHSlecgI4Jx8W0kisEp4y6ghtN/duH2meokAEDh1t5mNTrniBO1a1TtAZpukjv6pvfU2FYE82Re8+WRNBzVUDZCBqLI/VceSrlefFVSNzvM7YJER144xQB7Jar0HmKNgw7+j0YuQIcFLH8EqGU4hha0CCiMVOqFCFfgE/73+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560878; c=relaxed/simple;
	bh=9Ox9qMzTcOLYvYMxwoNwTWwBTiqAfc826z+sSqFU7wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tXUs61gV54TmDQS7yUO8P6QayQSac2d48rWQs0oTclZKvY2nCcdO76cgGof++66to3Xlhj2RzmU3dtb2FhXCXPFUwQhGMUtO6gRBSi4MAvuvsQhHPahnhhKj8MfZZbvbU49tAGQgRyiwTtmigGnjta10FW9f/UBMP+/DhiWF4gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=KFHI7hg1; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="KFHI7hg1"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-440d9bfa309so2949015fac.2
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 15:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781560874; x=1782165674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxwcdgK6UCUPMSSCo1Vbtj6IzuBL775/aR0ilNqdq3Q=;
        b=KFHI7hg1nQBrYGppxMtgImzMUn6+zge+/3KarUsITpKao3qPWdLuBNgijAi4dswHtR
         4FdfjyPopBiNBs6FuQm3yoAuDxkMlfidnvSYuHGPf+H6MUoTB8QaxJjrrlNlWQBU941s
         sib49gGHZcTrtKr9vw2o5+JSSP6ngctEGiGpmtYFdmZR7k7mcRZifeO3ePVaJ2CUUY98
         lhYCPpLO1asrQ0b3aNwR+fhBTH3JmZ2iWObqv+tN7EjJw+Uvb1nPgJ1B5r1bX6CtQUCn
         1MeXSCKQFwc13XRm6JMWa2G0ynL8arvRdThL/6+CnfRVwmSltHenuB5qlOvPvNz1k/6M
         y9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781560874; x=1782165674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TxwcdgK6UCUPMSSCo1Vbtj6IzuBL775/aR0ilNqdq3Q=;
        b=kmu6e5SqKYfX4Soa9vtQGeUtansTVR96RzyzWM9Oy00FMLONQHEXKawG2FYDqODltY
         1cwQlzXscW/oLiCOMMiqnaqAAPnDUDOu9O55ZJHtb3vsHOMGN9ZGBnBygSUlvDs5aGK2
         F49lhHw+3i9Cv9WP6eAVd4k9zVfb082EyP85RvqB0bQvLi+rSoZrfnAx4V7146yHh1Fz
         +NlM2qU3gK7dIIbUO079OH8o39l9pA2LICR2rGFPZL79vJTbJ7pEGZMBamkxNJpDvclE
         LDBB9pBoXBCTZmCtWqXehQkJY5OgxPlqWAG3k0m4/56U1d7cXALKNStYVId+0CbHZUVc
         Ixwg==
X-Forwarded-Encrypted: i=1; AFNElJ+c0OoG4BQuj5l9x6IVsdlFu8nfLe1WXfPNztlFYDzhqENM7X4wvbBmqKb28ONkUybSFHednSAC64o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiBup5izh121ZDgSTbi+FhFwFlWPQS1czRRCT5PJznz8eLusPx
	B2FaUYN4YJ63iTyNAlnPoT3cnWmieJNR+5phGm9wt8JLL8AH+KL0Bzv7DSsegvestSk=
X-Gm-Gg: Acq92OHNdf/JD0ChyZF5NY1h+auBE+VKV3pWBGHxdsfm7Zl9AAYX/vHMGE5dGRD3eVv
	Hrvr6dlKZGoYKdOSmsuXZ2mKv7KiPbT9dPObHTH3XyygS2sPyS95FRSjrCLbtN2MLB/VYsczRqD
	jKFiPZsSLSGBc0NHvWyyGDHDfHqQ8XZhZ4EJTS+NKujRJV/YYXRwiSD5vILEj2+fVDLxHfNlN8Z
	UdtmX1k2m35JAbNEk5AZJdgUbTR+zWTdE32gGJzGSS8nf6ZquSlEECVSQj4x1VA98R6068dNQwm
	lGrjDgGyi9bXc2UaC/tlHXHSLJMdvCLSidZstIWDADFzAVWw+jkJwMIhEh23jXFaHFPhyfHyXSt
	7zNBm7yZpjvIwMim/DPEehUX/FURsm8RPO4C03X+GevNO8DklE5AF9C91E1sPPmjnMCOMg8Z4Jg
	JA1AQltj5kIoZ2lmG1clN9WmZ4l+uDaRDPeIdi1gg=
X-Received: by 2002:a05:6871:8304:b0:43d:1151:3742 with SMTP id 586e51a60fabf-4426dce80f7mr9940706fac.8.1781560874437;
        Mon, 15 Jun 2026 15:01:14 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308fd9221sm826145fac.15.2026.06.15.15.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 15:01:14 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Mon, 15 Jun 2026 17:00:01 -0500
Subject: [PATCH 3/4] iio: adc: ti-ads112c14: implement gain on internal
 short SYS_MON channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-iio-adc-ti-ads122c14-v1-3-e6bdadf7cb2b@baylibre.com>
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
In-Reply-To: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7003; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=9Ox9qMzTcOLYvYMxwoNwTWwBTiqAfc826z+sSqFU7wE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqMHYZgdq/W3jr85DkY6Ctxr7aN2mWVHD2XuWVl
 +EcnLY/j9GJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCajB2GQAKCRDCzCAB/wGP
 wG95B/9X1jYmdmIPzw4jhD4dL2slTwgtK7d1CVy3jkLA9Otc+pAD0L7VTkctT8W+VTk1Q6fmYjl
 DFZA76o60ZWpUxGOf9cAwvUxj5Sq3iRhU6eYpRJSEnnLr+wGGVP0mryrE8YMMbkr+Q0+Zwo2Nxw
 +7drIuHBnlHajgjPWf8tA+flQqB/wmrDZsgPxzy55F+VZns8pzsg3nXRT7EE1fsjnRu9NQZl84W
 Xo2qgviPmFavo3KG5CsBrj4agE6UYkxgcdq6Fidx6UP0Aisvjdqyy6HGrb2H4nWW46k+R1v4ptB
 ZS9PMRQPrheX3srX+A2Vtq/nZf0pZiLHe0yy2jWCG1Oh9YQm
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Implement support for the programmable gain amplifier on the internal
short SYS_MON channel. This channel is used for calibration, so it is
useful to be able to set the PGA to the same gain as the external
channels. The gain setting is implemented via the `_scale` attribute.

In the future, we may want to support different reference voltages for
this channel, so the scale_available table is populated during probe
rather than being a static table.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads112c14.c | 131 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 97097ae2a487..202a449b4234 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -122,6 +122,26 @@
 
 #define ADS112C14_REG_REG_MAP_CRC			0x0F
 
+/* Available gains as tenths (x10) */
+static const u32 ads112c14_pga_gains_x10[] = {
+	5, /* 0.5 */
+	10, /* 1 */
+	20, /* 2 */
+	40, /* 4 */
+	50, /* 5 */
+	80, /* 8 */
+	100, /* 10 */
+	160, /* 16 */
+	200, /* 20 */
+	320, /* 32 */
+	500, /* 50 */
+	640, /* 64 */
+	1000, /* 100 */
+	1280, /* 128 */
+	2000, /* 200 */
+	2560, /* 256 */
+};
+
 static bool ads112c14_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -181,6 +201,8 @@ struct ads112c14_data {
 	const struct ads112c14_chip_info *chip_info;
 	struct i2c_client *client;
 	struct regmap *regmap;
+	u8 sys_mon_chan_short_gain_val;
+	int sys_mon_chan_short_scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)][2];
 };
 
 /* Maps REF_VAL to microvolts. */
@@ -239,21 +261,28 @@ static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
 		.address = 1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
 				    | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 	},
 };
 
 static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
 					     const struct iio_chan_spec *chan)
 {
+	u32 gain_val;
 	int ret;
 
-	/* TODO: GAIN is useful for shorted PGA inputs. */
-	/* All SYS_MON channels use GAIN of 1 to keep it simple. */
+	/*
+	 * All SYS_MON channels use GAIN of 1 to keep it simple. Other than
+	 * the internal short channel, where it is useful in practice.
+	 */
+	gain_val = chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT ?
+		   data->sys_mon_chan_short_gain_val : 1;
+
 	ret = regmap_update_bits(data->regmap, ADS112C14_REG_GAIN_CFG,
 				 ADS112C14_GAIN_CFG_SYS_MON |
 				 ADS112C14_GAIN_CFG_GAIN,
 				 FIELD_PREP(ADS112C14_GAIN_CFG_SYS_MON, chan->address) |
-				 FIELD_PREP(ADS112C14_GAIN_CFG_GAIN, 1));
+				 FIELD_PREP(ADS112C14_GAIN_CFG_GAIN, gain_val));
 	if (ret)
 		return ret;
 
@@ -366,6 +395,17 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_FRACTIONAL_LOG2;
 		}
 
+		if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
+			int *scale_avail = data->sys_mon_chan_short_scale_available[
+				data->sys_mon_chan_short_gain_val
+			];
+
+			*val = scale_avail[0];
+			*val2 = scale_avail[1];
+
+			return IIO_VAL_INT_PLUS_NANO;
+		}
+
 		*val = vref_uV / (MICRO / MILLI);
 		/*
 		 * Last 3 SYS_MON channels (ext ref, AVDD, DVDD) need to be
@@ -387,6 +427,61 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int ads112c14_read_avail(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan, const int **vals,
+				int *type, int *length, long mask)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+
+	switch (chan->channel) {
+	case ADS112C14_SYS_MON_CHANNEL_SHORT:
+		*vals = (const int *)data->sys_mon_chan_short_scale_available;
+		*length = 2 * ARRAY_SIZE(data->sys_mon_chan_short_scale_available);
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads112c14_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan, int val,
+			       int val2, long mask)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+
+	switch (chan->channel) {
+	case ADS112C14_SYS_MON_CHANNEL_SHORT: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		for (u32 i = 0; i < ARRAY_SIZE(data->sys_mon_chan_short_scale_available); i++) {
+			if (val == data->sys_mon_chan_short_scale_available[i][0] &&
+			    val2 == data->sys_mon_chan_short_scale_available[i][1]) {
+				data->sys_mon_chan_short_gain_val = i;
+				return 0;
+			}
+		}
+		return -EINVAL;
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads112c14_write_raw_get_fmt(struct iio_dev *indio_dev,
+				       struct iio_chan_spec const *chan,
+				       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
 static int ads112c14_read_label(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan, char *label)
 {
@@ -418,9 +513,34 @@ static int ads112c14_read_label(struct iio_dev *indio_dev,
 
 static const struct iio_info ads112c14_info = {
 	.read_raw = ads112c14_read_raw,
+	.read_avail = ads112c14_read_avail,
+	.write_raw = ads112c14_write_raw,
+	.write_raw_get_fmt = ads112c14_write_raw_get_fmt,
 	.read_label = ads112c14_read_label,
 };
 
+static void ads112c14_populate_tables(struct ads112c14_data *data)
+{
+	u32 vref_uV, fsr_bits;
+	int i;
+
+	/* For now, assuming we are using 2.5V reference. */
+	vref_uV = ads112c14_internal_ref_uV[ADS112C14_REFERENCE_CFG_REF_VAL_2_5V];
+	fsr_bits = data->chip_info->resolution_bits - 1;
+
+	for (i = 0; i < ARRAY_SIZE(ads112c14_pga_gains_x10); i++) {
+		int *scale_avail = &data->sys_mon_chan_short_scale_available[i][0];
+		u32 gain_x10 = ads112c14_pga_gains_x10[i];
+
+		/* NB: slightly odd arrangement to avoid overflow. */
+		scale_avail[0] = div_u64_rem(div_u64((u64)NANO * 10 /
+						     (MICRO / MILLI) * vref_uV /
+						     gain_x10,
+						     BIT(fsr_bits)),
+					     NANO, &scale_avail[1]);
+	}
+}
+
 static int ads112c14_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -472,6 +592,9 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (FIELD_GET(ADS112C14_STATUS_MSB_RESETN, reg_val))
 		return dev_err_probe(dev, -EIO, "reset failed\n");
 
+	/* Default gain after reset is 1. */
+	data->sys_mon_chan_short_gain_val = 1;
+
 	/*
 	 * Clear reset bit to prepare for next probe. And clear AVDD fault since
 	 * that happens on every reset.
@@ -488,6 +611,8 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ads112c14_populate_tables(data);
+
 	indio_dev->name = info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ads112c14_sys_mon_channels;

-- 
2.43.0

