Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EE1409271
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783723930; cv=none; b=GLFk3xKFNdbc7tZsmk1BRDH3JnVzkOcYXbtKOlPQ4+I/yhKVEi4L65JvAM/EgVPNhv/VzB122I4l06cLqTpxifkrR9paHxHa6XGQjyfBewc5mHkg4pJy5pqDAN+mrNZ8zgtRTscXE/tI6+6eaNaGAvliGfH0OMAagjVCriz9aAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783723930; c=relaxed/simple;
	bh=NaAncuSYWqF6nmdvo99yczYBOpGBnm8OEWFDoweaNSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KFVVD3HIxczQWzP8Ko9wDvc+YcDZqg21qxq6XLKKi1kgH/CwruXu05vlnOm5aNp/Q2MYswHbz8LzreOA5OrihvZze1qSMaI2xHe+KUc/mUWw/a/8oPggxhR7Lcy69pFhN/1JOXrkFihWTkdZ0uuiLQga41Kh38CjzXFl8CgEACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MONwGUAl; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="MONwGUAl"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso1163287a34.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 15:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783723921; x=1784328721; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q/7V6KAKuYf2CgnSuXUnVX/oIWc//aiftyNXm6dq4bM=;
        b=MONwGUAloSRB4xCD3zkqpzzLH6ecrfKp1T4HLLbHMkkh2rhIkq+JkxxRzpu0Ud80Lc
         MIwfOcBYY0jKhi+uK0SupsCIrmGz5Pk3uYnPMMIWRusO9VWhjBxymI2zUW+dCBEgtftQ
         h6YdUMBqTMvIZmrTD4Xvzt45LMAUXgdk7oz1FQ9SoCYbpgELWo0wpD9/mKaR8jQxBJPb
         TXNWkpVKAAVBs+2uU1LuA6asDXNSY49UXJijtyvTNFvzhsDRbubiUuxVVeIUB5bIXP01
         7VESBUY+m5r6cZ5lLYas3UkCvmKMXbAow4FC1uxGGZ1XpbMWE8AlGP0j+4YWyLvyqDnW
         mR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783723921; x=1784328721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q/7V6KAKuYf2CgnSuXUnVX/oIWc//aiftyNXm6dq4bM=;
        b=mCqBczTlhsnXrjRprGK39bsSapCPHGaKyty1W6l5EqjJga10m8PG4nWd65nkThILto
         zz8DpgTPyl3XwP7h8ET7GW0obukrnHjvjvcxc12Y+gyrM6TRgR3Boi7qlMZ/dKcwOPec
         aG7DUnQgi1I7m/597Sh10EusFTUeDA1C+/cN6kvwDfyC14fEnCleQSWO517aoJDsTgnk
         jVWTqQSB3Y989docTrrlOFYsH+HNGud6Bl+sREN5TUDpnM2b0YQtdGMoEttWKkRtuV7R
         Sv0A728oJWywCE0ttsRQqOyI6YsgrRueg8KClZlAOKuccZfIZksg427yTyWghD0oVcPI
         9JEQ==
X-Forwarded-Encrypted: i=1; AFNElJ8021I+uYQvrzw3OXu8OokrqhAfAcCvITI6s/TT6BhltDoXJQ4ONrGpDDrLYHh34DHcfFYKyXIuYVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0hSMAwLv4os8PMx9X0Wx9odVzOYSqQnODDJ1MeGi3KzUXvOk
	Vjnsc6ZbKaoYD457+hxUS8uMzR1V+aLI2ucYA2uG4ngngzdhoYjm+gYsPIUBBzgSmL0=
X-Gm-Gg: AfdE7ckT5hrzVTobUl+nn0ZYdsfOR7czqMEb/Pw2gCNAyjOsSFTx75ad/txJ86GTxp1
	nTAgbcEKFOD7qqrrvSRTbeK2dwjUZjkNMmFsvMWQDYwqMUdvMh/GAWe7NWhgCwGSQXcSV93ryNb
	ifZINLjOco5Ua/4CKbFxLPWa6Mxnbr18ucLDcUhhURVBPRj2e17qMnuyewcrfWmrrJrHDuMfs5E
	G7WZr2B0DkXYM0BSFlHXE70Mwwh7Y26i6vF2a+dZ+SC3CZ2E2QYTB+BdW4F67ZiX3w4dLrVPKhC
	mXTftAuHPtqP4d/wjAShUekZ51pNEjUZ2+56sgtVxKrcTwIRPeb3VfgVm1/C3PqezhZtFabvB7b
	HB7rEWdl/PM3pjdjODgcElNahxi64FtznW88gmhPCafDyLaMNdXNn9OeusZP5gNC5NGftUIQ9D0
	tO26wV9AIH75IMqaKa
X-Received: by 2002:a05:6830:2306:b0:7e9:ead3:4449 with SMTP id 46e09a7af769-7ec0967b3e2mr540427a34.6.1783723921078;
        Fri, 10 Jul 2026 15:52:01 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae177c5sm7613512a34.5.2026.07.10.15.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:52:00 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 17:50:40 -0500
Subject: [PATCH v3 7/8] iio: adc: ti-ads112c14: implement gain on internal
 short SYS_MON channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-iio-adc-ti-ads122c14-v3-7-746d52cbf1d0@baylibre.com>
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
In-Reply-To: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7553; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=NaAncuSYWqF6nmdvo99yczYBOpGBnm8OEWFDoweaNSY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqUXdzRx7mynf0JNV0xKiajZ7WTX/6yX+laEKoB
 36b8izNtzuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalF3cwAKCRDCzCAB/wGP
 wEJJB/wOUrBWY3QxJRYL7BTbTEH6JZhsMyJHHPHGz8e/rFhBozE4rWU0v7rVi49+d9VnzBgwMrp
 U6uk6V3DayjEv813KjKbVnv+Ei6mLjkP+C/qZx050Pj3vJ0k39V5+5FP6oYxHMafARmCIUrSy19
 ADSSeCRhtUyPrx4OtNKUJ0l0xZrTXUaGHve3otjGGPRkQzyeZ8sSPEOzrtM+ww0PZbe7Cut9Z7f
 c8kpydIYjg6ZJneHf3Ak5ugJEsyoHYBr8QA3wXMvpiOgJ9yUlJai9oJce/51zEMzxSH5MVk7zd0
 f2Siv1YtOj+UubyUijq8G6fcKwEYQgBQInopM8R7JwFgc95o
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
v3 changes:
* Use IIO_VAL_DECIMAL64_PICO for scale.

v2 changes:
* Make some changes to reduce diff in next patch.
* Add some local variables to reduce line wrap.
---
 drivers/iio/adc/ti-ads112c14.c | 128 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 4d2e7d37be82..2ce4411a0d86 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -126,6 +126,15 @@
 #define ADS112C14_INT_REF0_mV				1250
 #define ADS112C14_INT_REF1_mV				2500
 
+/*
+ * Available gains as tenths (e.g. value 5 == 0.5 gain). Indexes correspond to
+ * ADS112C14_GAIN_CFG_GAIN values.
+ */
+static const u32 ads112c14_pga_gains_x10[] = {
+	5, 10, 20, 40, 50, 80, 100, 160,
+	200, 320, 500, 640, 1000, 1280, 2000, 2560,
+};
+
 struct ads112c14_chip_info {
 	const char *name;
 	u8 device_id;
@@ -187,12 +196,15 @@ static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
 		.address = 1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
 				    | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 	},
 };
 
 struct ads112c14_data {
 	const struct ads112c14_chip_info *chip_info;
 	struct regmap *regmap;
+	u8 sys_mon_chan_short_gain_val;
+	s64 sys_mon_chan_short_scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)];
 };
 
 static bool ads112c14_writeable_reg(struct device *dev, unsigned int reg)
@@ -248,15 +260,21 @@ static const struct regmap_config ads112c14_regmap_config = {
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
 
@@ -331,6 +349,7 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 {
 	struct ads112c14_data *data = iio_priv(indio_dev);
 	u32 vref_uV, fsr_bits;
+	s64 scale_avail;
 
 	/* Selecting V_REF source is not implemented yet. */
 	vref_uV = ADS112C14_INT_REF1_mV * (MICRO / MILLI);
@@ -379,6 +398,15 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_FRACTIONAL_LOG2;
 		}
 
+		if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
+			u8 idx = data->sys_mon_chan_short_gain_val;
+
+			scale_avail = data->sys_mon_chan_short_scale_available[idx];
+			iio_val_s64_decompose(scale_avail, val, val2);
+
+			return IIO_VAL_DECIMAL64_PICO;
+		}
+
 		*val = vref_uV / (MICRO / MILLI);
 		/*
 		 * Last 3 SYS_MON channels (ext ref, AVDD, DVDD) need to be
@@ -402,6 +430,69 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int ads112c14_read_avail(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan, const int **vals,
+				int *type, int *length, long mask)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+
+	if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
+		*vals = (const int *)data->sys_mon_chan_short_scale_available;
+		*length = 2 * ARRAY_SIZE(data->sys_mon_chan_short_scale_available);
+		*type = IIO_VAL_DECIMAL64_PICO;
+		return IIO_AVAIL_LIST;
+	}
+
+	return -EINVAL;
+}
+
+static int ads112c14_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan, int val,
+			       int val2, long mask)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	const s64 *scale_avail;
+	u8 *gain_val;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE: {
+		if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
+			scale_avail = data->sys_mon_chan_short_scale_available;
+			gain_val = &data->sys_mon_chan_short_gain_val;
+		} else {
+			return -EINVAL;
+		}
+
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		for (u32 i = 0; i < ARRAY_SIZE(ads112c14_pga_gains_x10); i++) {
+			if (iio_val_s64_compose(val, val2) == scale_avail[i]) {
+				*gain_val = i;
+				return 0;
+			}
+		}
+
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
+		return IIO_VAL_DECIMAL64_PICO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
 static int ads112c14_read_label(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan, char *label)
 {
@@ -433,9 +524,35 @@ static int ads112c14_read_label(struct iio_dev *indio_dev,
 
 static const struct iio_info ads112c14_info = {
 	.read_raw = ads112c14_read_raw,
+	.read_avail = ads112c14_read_avail,
+	.write_raw = ads112c14_write_raw,
+	.write_raw_get_fmt = ads112c14_write_raw_get_fmt,
 	.read_label = ads112c14_read_label,
 };
 
+static void ads112c14_populate_scale_available(s64 *scale_avail, u32 full_scale,
+					       u32 fsr_bits)
+{
+	for (u32 i = 0; i < ARRAY_SIZE(ads112c14_pga_gains_x10); i++) {
+		u64 gain_x10 = ads112c14_pga_gains_x10[i];
+
+		scale_avail[i] = div64_u64((u64)PICO * 10U * full_scale,
+					   gain_x10 * BIT(fsr_bits));
+	}
+}
+
+static void ads112c14_populate_tables(struct ads112c14_data *data)
+{
+	u32 full_scale, fsr_bits;
+
+	/* For now, assuming all sys_mon channels are using 2.5V reference. */
+	full_scale = ADS112C14_INT_REF1_mV;
+	fsr_bits = data->chip_info->resolution_bits - 1;
+
+	ads112c14_populate_scale_available(data->sys_mon_chan_short_scale_available,
+					   full_scale, fsr_bits);
+}
+
 static int ads112c14_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -491,6 +608,9 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (FIELD_GET(ADS112C14_STATUS_MSB_RESETN, reg_val))
 		return dev_err_probe(dev, -EIO, "reset failed\n");
 
+	/* Default gain after reset is 1. */
+	data->sys_mon_chan_short_gain_val = 1;
+
 	/*
 	 * Clear reset bit to prepare for next probe. And clear AVDD fault since
 	 * that happens on every reset.
@@ -516,6 +636,8 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ads112c14_populate_tables(data);
+
 	indio_dev->name = info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ads112c14_sys_mon_channels;

-- 
2.43.0

