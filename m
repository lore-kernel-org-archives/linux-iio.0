Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2CB433E80
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071365; cv=none; b=E4rubleuRF3DXst5GWiNQdAWgCnwW8ix+NkSLcxjpxqmkzAtWeTjJ6kDsiuYxrs6rHcZgxQaXaMZ06cQqcLRJStOhrniNYcU6rVCCnrlrtCa+ZOAfqNjdavbg03iKh95VOZODizZsChw63ktDS6YVAFXcNTWHFT0GrrTf/XUXSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071365; c=relaxed/simple;
	bh=25WUGK2ba5xnlX7QOGvC2X9iXHAztyjhOtHUdyixIh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gu5q+7oKl0CeuApM9JZgUbJ1pqzNkPMIJLHGttK2OvoLjuU0T0BQhS+I+SbbTpkKJdBLHF9qfyLbO9nTVMefMd5b9xr3KXcUKSZExBky9VGq3qC42sgY+pnaO4j84k76eQL/moNawMIdrE677cz0BspSyKOplevscXckjkLPsw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=e4Nbh58Z; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="e4Nbh58Z"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb68bdf53aso1975897a34.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 16:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784071363; x=1784676163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=77cYFygWbkZlNnS8ldWspgZQcmtsC/v8xPN3lbd2GsM=;
        b=e4Nbh58ZCkHJwS4bZ3hm99fTzjFWf/BsePxZFBJlcA9cWt90HAcC1ibAv0OhQ5U/0h
         KctHltm0FT2zNlmF0FNKHrKeT2XPaE7zwYN+R8N/dx6BAtU/KkCEEiaUwC/ceMf/qODr
         QDRpNGCxeq1TdFBvwB6/yozlpoxqSfsCzzurMqcRBPprCrQdc9TYGtlC4f9FCaP6TRWh
         1gxmnN7Kc+27FqtLY4mtTRz0Jehr34uPVrXRCkWQKH7C+17eacOsrJ13nb6FeE4EMro/
         wmMXHDpqogC9J6hcNlZXGqLPkr3fRboi2kqJbgmTN97BFu6SV5uA6twQr7JLgOugn3XX
         ZYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784071363; x=1784676163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=77cYFygWbkZlNnS8ldWspgZQcmtsC/v8xPN3lbd2GsM=;
        b=RyG8a/l2O6dPR/CV/WurqCljj6bqZPueFS3uEbei0lRwx1HjOaBC/uXddjG7QURsJz
         jC6Dxgd1geR0L4QwOuxDyOYFpXfafUTdMxMfRlRSmFPwCdUBnzOBh2vqaPlDaJzWSlu/
         wqw0Tl9+yRR9wNEaevYcXRx6UpDHqDLVcNPSBti0AuGbbJeN4GdWQ1V8QYcbJNrR7I1f
         W3i24o5xQHSPDMiR6XHAXOiEyTT10SuGkLHfWeJ8uKl37EvHE/6FFn5AG48ZW2Y4zZLc
         UztlwWoVirIxZSjM9RWCN15/f2qi0aSzUFG85KBVRJT60C3wnK0szCIVokAI86Cw+13M
         GZEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/nx4Xs+587T6RyA0yt3Rn2/7I0avrkaIxF0u/27Wmx9tuLx8gXcaP8SLm2lMnb1iqkhE8Y91Riw0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8KCRYMNFT0xiiG+kVVbp5dDFtntDNzkcFYehl6ePPmFACxJp
	tEdg+NgxhxIDa2A4H8WfI0AzmQUc1rWtPI6byDOgX8q8ypPKf/yl6v0lgwNCjwkV4Hk=
X-Gm-Gg: AfdE7clEIrAq7l5kopOx84xZsMKR1ABYJVNO6RTjqD6KZsPf9kvS17rkmS0sWCrBAmY
	tqADnGowW78ikNHKn3xlyiAbeGWET4Vv8PmvPfVHPP+SNjKEV6bvVIrcUWKrYnbDRi8jBK+LHst
	tnrnIw6/b7lypsHRYaue1g7cZnxc6hBgv/3twSsIsmSF0Cd7m7xUYq3fIDMebOdm17jCTr7U4mX
	jEj5RlffBTHYkIb+LQNDW60ZmOwb23uGeywhJWfiwymi6zJHLoaplCws8WtIzl0MzFIBLKUaAFO
	a5nWECQQNcB+d6V+F4EW6lQZxgGeAbLXtPJkZ35x0wvqNz59xHUfCaz6ZC54jxH95S2lgNN5mOn
	ETJ6KqaV600qOfzW28LRrKRKbHhk/UrxhFh995fY3HSHwWf7gRkzPOyCdCCwv4w+qsupIX+c1Ih
	jnLmAX0EvD0T0rGMjbWg==
X-Received: by 2002:a4a:ee08:0:b0:6a3:97db:4917 with SMTP id 006d021491bc7-6a3da095e02mr526641eaf.51.1784071362955;
        Tue, 14 Jul 2026 16:22:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a39af0e953sm7561978eaf.3.2026.07.14.16.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:22:42 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Tue, 14 Jul 2026 18:21:29 -0500
Subject: [PATCH v4 7/8] iio: adc: ti-ads112c14: implement gain on internal
 short SYS_MON channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-iio-adc-ti-ads122c14-v4-7-25f8e3084485@baylibre.com>
References: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
In-Reply-To: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9056; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=25WUGK2ba5xnlX7QOGvC2X9iXHAztyjhOtHUdyixIh4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqVsSlkE+hdncUFraWkbz++l+CEcjrCVyAmFriW
 9pipjI1+2GJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalbEpQAKCRDCzCAB/wGP
 wP7ECACRc+Zv0D7ihFX64vE/p37cV4oPQgydKsBdDee683QTgcwa+sP/sj9RZaXL32743f7ZFiE
 IObVYuYaHRi0b08cOsEttvFNlqG76h+rx6whneklhRVJ/JPtUbYdMfl2SU8wcmE3cWbpbWfa/Ji
 8vtwHB7E2vkbPjzcqoAuxRBV83wdq1HalsN6k9Z+DQQo4lZW+KOp10uS485k5xXbuZxvZCIQ/Vw
 kn3yX26xAvwRime6595qOrUgBDQtTR30k9UVvLEzlGVZKZUaHlg25uuzwBWPgBxjt6JPD515NQM
 oJ/7y46YWovEsjpzJSTjmCfaYzyH4x8K2+DMruBSgM5lWWhu
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
v4 changes:
* Added comments on ads112c14_pga_gains_x10.
* Fix scale storage to be compatible with big-endian.
* Make some changes to reduce diff in next patch.
* Add driver mutex instead of using claim direct mode.

v3 changes:
* Use IIO_VAL_DECIMAL64_PICO for scale.

v2 changes:
* Make some changes to reduce diff in next patch.
* Add some local variables to reduce line wrap.
---
 drivers/iio/adc/ti-ads112c14.c | 152 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 149 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index a69c595ab518..17bb6472a39b 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -9,12 +9,14 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -128,6 +130,15 @@
 #define ADS112C14_INT_REF0_mV				1250
 #define ADS112C14_INT_REF1_mV				2500
 
+/*
+ * Available gains as tenths (e.g. value 5 == 0.5 gain). Indexes correspond to
+ * ADS112C14_GAIN_CFG_GAIN values.
+ */
+static const u32 ads112c14_pga_gains_x10[] = {
+	5, 10, 20, 40, 50, 80, 100, 160,		/* 0 -  7 */
+	200, 320, 500, 640, 1000, 1280, 2000, 2560,	/* 8 - 15 */
+};
+
 struct ads112c14_chip_info {
 	const char *name;
 	u8 device_id;
@@ -189,12 +200,17 @@ static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
 		.address = 1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
 				    | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 	},
 };
 
 struct ads112c14_data {
 	const struct ads112c14_chip_info *chip_info;
 	struct regmap *regmap;
+	/* Synchronizes access to register value fields. */
+	struct mutex lock;
+	u8 sys_mon_chan_short_gain_val;
+	int sys_mon_chan_short_scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)][2];
 };
 
 static bool ads112c14_writeable_reg(struct device *dev, unsigned int reg)
@@ -250,15 +266,21 @@ static const struct regmap_config ads112c14_regmap_config = {
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
 
@@ -301,6 +323,8 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 	u32 reg_val;
 	int ret;
 
+	guard(mutex)(&data->lock);
+
 	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
 		/* Not implemented yet. */
 		return -EINVAL;
@@ -332,6 +356,7 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 			      int *val, int *val2, long mask)
 {
 	struct ads112c14_data *data = iio_priv(indio_dev);
+	const int *scale_avail;
 	u32 vref_uV, fsr_bits;
 
 	/* Selecting V_REF source is not implemented yet. */
@@ -381,6 +406,19 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_FRACTIONAL_LOG2;
 		}
 
+		if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
+			u8 idx;
+
+			guard(mutex)(&data->lock);
+
+			idx = data->sys_mon_chan_short_gain_val;
+			scale_avail = data->sys_mon_chan_short_scale_available[idx];
+			*val = scale_avail[0];
+			*val2 = scale_avail[1];
+
+			return IIO_VAL_DECIMAL64_PICO;
+		}
+
 		*val = vref_uV / (MICRO / MILLI);
 
 		/*
@@ -413,6 +451,75 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int ads112c14_read_avail(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan, const int **vals,
+				int *type, int *length, long mask)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
+			guard(mutex)(&data->lock);
+
+			*vals = (const int *)data->sys_mon_chan_short_scale_available;
+			*length = 2 * ARRAY_SIZE(data->sys_mon_chan_short_scale_available);
+			*type = IIO_VAL_DECIMAL64_PICO;
+			return IIO_AVAIL_LIST;
+		}
+
+		return -EINVAL;
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
+	const int (*scale_avail)[2];
+	u8 *gain_val;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE: {
+		guard(mutex)(&data->lock);
+
+		if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
+			scale_avail = data->sys_mon_chan_short_scale_available;
+			gain_val = &data->sys_mon_chan_short_gain_val;
+		} else {
+			return -EINVAL;
+		}
+
+		for (u32 i = 0; i < ARRAY_SIZE(ads112c14_pga_gains_x10); i++) {
+			if (iio_val_s64_compose(val, val2) ==
+			    iio_val_s64_compose(scale_avail[i][0], scale_avail[i][1])) {
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
@@ -444,9 +551,39 @@ static int ads112c14_read_label(struct iio_dev *indio_dev,
 
 static const struct iio_info ads112c14_info = {
 	.read_raw = ads112c14_read_raw,
+	.read_avail = ads112c14_read_avail,
+	.write_raw = ads112c14_write_raw,
+	.write_raw_get_fmt = ads112c14_write_raw_get_fmt,
 	.read_label = ads112c14_read_label,
 };
 
+static void ads112c14_populate_scale_available(int (*scale_avail)[2],
+					       u32 full_scale, u32 fsr_bits)
+{
+	for (u32 i = 0; i < ARRAY_SIZE(ads112c14_pga_gains_x10); i++) {
+		u64 gain_x10 = ads112c14_pga_gains_x10[i];
+		s64 scale;
+
+		scale = div64_u64((u64)PICO * 10U * full_scale,
+				  gain_x10 * BIT(fsr_bits));
+
+		iio_val_s64_decompose(scale, &scale_avail[i][0],
+				      &scale_avail[i][1]);
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
@@ -467,6 +604,10 @@ static int ads112c14_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	data->chip_info = info;
 
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
+
 	ret = devm_regulator_get_enable(dev, "dvdd");
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to get dvdd regulator\n");
@@ -502,6 +643,9 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (FIELD_GET(ADS112C14_STATUS_MSB_RESETN, reg_val))
 		return dev_err_probe(dev, -EIO, "reset failed\n");
 
+	/* Default gain after reset is 1. */
+	data->sys_mon_chan_short_gain_val = 1;
+
 	/*
 	 * Clear reset bit to prepare for next probe. And clear AVDD fault since
 	 * that happens on every reset.
@@ -528,6 +672,8 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ads112c14_populate_tables(data);
+
 	indio_dev->name = info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ads112c14_sys_mon_channels;

-- 
2.43.0

