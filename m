Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523CD3793B4
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215631; cv=none; b=DJXbDS+JHIh4w9HHBRj6AxdUF8kTQdIOS2RbdEDpJP13D0/WvbqbirA9Vaey2QVU5rAZBSB4ZbRpUtBgFAFkXquVrSSKCnTAF3+uYNR3br/sQRXsGoGK7YOnpc8TvQP9BjZpdu6rozaKfJeZLLzebMiAjk+DWUwfbJK2Bvs46K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215631; c=relaxed/simple;
	bh=l9Q45b3Na0r37AULknN0n4Ws7BStWk9ckJ7bJVedIH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cz3A4nXDRuir7+GbbixCibY43bw7SJMhBbEEWjfH3OX/VCnW7ZjFz9O/cYAoiaVlibWHr8s1gpp8gKAHkuo3yZkGR7JAJerLKPyH1VD2U0t+n//k/ocr3h9+mJ3yjOqARS0OXHgV5Jtqx+jsEptYx+b03vJDtkOgK8DJWWoAftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=gNi1i6IV; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="gNi1i6IV"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f4f3683fbcso418645a34.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 15:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788215628; x=1788820428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CkINITabsJkMFaMz+O6WBQXk3MjQkP9P7TfGAk4KvJ8=;
        b=gNi1i6IV3dG4epcJfUbss/9HaJPKAixHz668vmeHy2jgWmdwmK/QSbXQ+mCufXhmDG
         heArvqmehf1b0FUGKvJYxX/eaDxoLDvSTRD/9zE1c80rWWd/5c7JazdSsLGejMzzmieO
         OOe1TXLMWnmfm2AiPx1eterdY04IdZhM51yAER06jJ51zYms7qWh8bGUIml22RD3pMD7
         TFV7lw6M5e58dLbwKYTogIWQdUoi22YocS8Iek09tqFVG9oVQYXqOEJ/AbL68EBMG8XO
         Mg5xmLXhM3j0qhlz4jgz8OCdEpHSFsqppsFSPuVu98sYIJbezEVhR8CFycMFaRTMqbCY
         QpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788215628; x=1788820428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CkINITabsJkMFaMz+O6WBQXk3MjQkP9P7TfGAk4KvJ8=;
        b=R2H04rfzqUOWiYCVvUKfciEHXBgnMW83tLwcb8NwRHPcfbTC3HCxlgAgVGLe1a+xt4
         I6mmnjlpPf98zYC7HZTFCAx71GvfCEjsNnraEDO/sfI421W/uQpzK7PV/29dKHePuXt/
         wixtReanRfjGv5BQFM/Kcn5nUXfT5vqTBJbUQfmyuIJlMl6NdXnD4IO9avb7iIrqovkv
         MHQXq1MPeaIyq0k/9cDamWdKka5Tu/oy4YiDwj+e/730Jcv+E1cT9XFR0NM0vtMs6SBH
         TH5x5a+ZozLhzG6fN6ja2+djsN8a09S3znckqA2GA+G6BN4a4Ix0zQobVPl7mhlK6qRp
         tgDw==
X-Forwarded-Encrypted: i=1; AHgh+RoBAiEEms2jP1B7jrRNAkzN8FZQEQipjPoLxgudf7ejgdZpDmqPZHwcTjr4v8E4kFxjB8/76/MNDhg=@vger.kernel.org
X-Gm-Message-State: AFuF++mnkTRa9HILUcnBQbLcZHtQJGb/Qxj0IIqMzoFT/GHdP7gLfTvJ
	I8fsf3OD7R9oTZRYwCbR+wDsPrFXNO0S1957YjaMNrbl4gF4jI5hMUrfKpLlSOn8SYI=
X-Gm-Gg: AR+sD13Ppb/RkxQ12v759BE7DOF3DHYtIZygncjckSTrsJg92//R9kLC03VPZN0Afry
	hNNXv2Kpqj4t0Z467QTlwZCGfEiAS3snHBMfekrvfZmI60vu/O7PBDIUFBPG8MFSFmzNGEz/xX0
	+4TjAuttFB1oG9vv2BzfLqD5J8NY4Ysvx4dovatg/W+GcEoRswIxeu1SnGEMRXytygkLw6RY9EM
	iXbgRapsvwT2FmOKPfXxoQxoodCdyPcZ7g2UFNaUgO3pCZs4+73LL0b6e4QHyVHE7atIlcKsV0v
	neR5P01AQGQ586XurQIrEErMjiv4NvVi0zcUzglW8h+MJghpvq2z7kF16zWKm+l2PhseTViyDEo
	K4BOzcqviTn7cjo+axW1AensrqHIUbkBfKDM5AuqbYxJYmhtW7Tp0DXmYHi5+iEwtOjNdQ/tSVz
	xZWHeLBbiIG4vW9IBAoArUdAhUWhGID3CB43z3GbC5+13LKbv9QxJxO1iLawIwP5SH
X-Received: by 2002:a05:6830:380c:b0:7f5:b445:d830 with SMTP id 46e09a7af769-7f68f81e792mr1405861a34.14.1788215627884;
        Mon, 31 Aug 2026 15:33:47 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:778b:da9:a8a1:bc78])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa7efe09sm9190551a34.11.2026.08.31.15.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 15:33:47 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Mon, 31 Aug 2026 17:33:07 -0500
Subject: [PATCH v5 3/3] iio: adc: ti-ads112c14: add continuous mode support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-iio-adc-ti-ads112c14-continuous-mode-v5-3-76f80a04b94f@baylibre.com>
References: <20260831-iio-adc-ti-ads112c14-continuous-mode-v5-0-76f80a04b94f@baylibre.com>
In-Reply-To: <20260831-iio-adc-ti-ads112c14-continuous-mode-v5-0-76f80a04b94f@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8104; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=l9Q45b3Na0r37AULknN0n4Ws7BStWk9ckJ7bJVedIH4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqlgE4KhjYkFlMzTFVs/Nrso7TWSrX6XuRUPU9D
 1uvxHQy8UaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapYBOAAKCRDCzCAB/wGP
 wAygCACCVvJbYxLpCkYkPFxmBBrIa+wHl+YRDQ9/B4V9aeWvfO+c84Ksw+eqHOPSMrBnc+dzeya
 KQBuNjJQowB/yJxyL0cN7jBLRTVpIipW8N/6f6yivgMbTCtVcHGXUh908x4o7Cqa6se26Z6lQi/
 gI2ClpHXHBVPML0Cb8nfWPNrITXpVpDODb4b+Yn4qt6c/euOJxWRL0N+UMhBlpFiQ7wqITe/+WC
 zsq/bByXNgKho6vUZv5LOzfrrx11GBLYpGNEt/HPKWioZWB/f2e1onj0qrP/KWdVYDMky0HqFaQ
 sJOPEzqDoSLRFD7I8QJI9bv3Dflh6CzBxaOnaDBVLcQJZmX5
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for continuous mode in the TI ADS112C14 ADC driver. In this
mode the ADC itself is starting each conversion, so we add a trigger
based on the DRDY interrupt to read each sample. This mode is also
limited in that only one channel can be enabled at a time since the
chip does not have a sequencer or simultaneous sampling capability.
Continuous mode will only be used when this new trigger is the current
trigger.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads112c14.c | 153 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 23f15be303fb..06b962fbde5e 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bitmap.h>
 #include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/crc8.h>
@@ -18,6 +19,7 @@
 #include <linux/i2c.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/interrupt.h>
@@ -257,10 +259,12 @@ struct ads112c14_measurement {
 struct ads112c14_data {
 	const struct ads112c14_chip_info *chip_info;
 	struct regmap *regmap;
+	struct iio_trigger *drdy_trig;
 	/* Synchronizes access to register value fields. */
 	struct mutex lock;
 	int drdy_irq;
 	struct completion drdy_completion;
+	bool continuous_mode;
 	bool i2c_crc_enabled;
 	u32 avdd_uV;
 	u32 ext_ref_uV;
@@ -280,11 +284,18 @@ static irqreturn_t ads112c14_drdy_irq_handler(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct ads112c14_data *data = iio_priv(indio_dev);
 
-	complete(&data->drdy_completion);
+	if (READ_ONCE(data->continuous_mode))
+		iio_trigger_poll(data->drdy_trig);
+	else
+		complete(&data->drdy_completion);
 
 	return IRQ_HANDLED;
 }
 
+static const struct iio_trigger_ops ads112c14_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+};
+
 static bool ads112c14_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -695,6 +706,13 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 					data->i2c_crc_enabled);
 }
 
+static bool ads112c14_using_drdy_trigger(struct iio_dev *indio_dev)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+
+	return data->drdy_trig && indio_dev->trig == data->drdy_trig;
+}
+
 static int ads112c14_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int *val, int *val2, long mask)
@@ -898,6 +916,19 @@ static int ads112c14_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+static int ads112c14_update_scan_mode(struct iio_dev *indio_dev,
+				      const unsigned long *scan_mask)
+{
+	/* Only continuous mode is limited to a single channel. */
+	if (!ads112c14_using_drdy_trigger(indio_dev))
+		return 0;
+
+	if (!iio_validate_scan_mask_onehot(indio_dev, scan_mask))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int ads112c14_debugfs_reg_access(struct iio_dev *indio_dev,
 					unsigned int reg,
 					unsigned int writeval,
@@ -952,6 +983,19 @@ static int ads112c14_read_label(struct iio_dev *indio_dev,
 	return sysfs_emit(label, "%s\n", label_source);
 }
 
+static const struct iio_chan_spec *
+ads112c14_first_active_channel(struct iio_dev *indio_dev)
+{
+	unsigned int scan_mask_len = iio_get_masklength(indio_dev);
+	unsigned int i;
+
+	i = find_first_bit(indio_dev->active_scan_mask, scan_mask_len);
+	if (i == scan_mask_len)
+		return NULL;
+
+	return &indio_dev->channels[i];
+}
+
 static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
 {
 	struct iio_poll_func *pf = private;
@@ -961,6 +1005,26 @@ static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
 	u32 i;
 	int ret;
 
+	if (ads112c14_using_drdy_trigger(indio_dev)) {
+		const struct iio_chan_spec *chan;
+
+		chan = ads112c14_first_active_channel(indio_dev);
+		if (!chan)
+			goto out;
+
+		ret = ads112c14_scan_read(data, (u8 *)&data->scan[0]);
+		if (ret) {
+			dev_err_once(indio_dev->dev.parent,
+				     "failed to read channel %d: %pe; additional errors will be suppressed\n",
+				     chan->channel, ERR_PTR(ret));
+			goto out;
+		}
+
+		iio_push_to_buffers_with_ts(indio_dev, data->scan,
+					    sizeof(data->scan), pf->timestamp);
+		goto out;
+	}
+
 	iio_for_each_active_channel(indio_dev, i) {
 		const struct iio_chan_spec *chan = &indio_dev->channels[i];
 
@@ -988,10 +1052,81 @@ static const struct iio_info ads112c14_info = {
 	.read_avail = ads112c14_read_avail,
 	.write_raw = ads112c14_write_raw,
 	.write_raw_get_fmt = ads112c14_write_raw_get_fmt,
+	.update_scan_mode = ads112c14_update_scan_mode,
 	.debugfs_reg_access = ads112c14_debugfs_reg_access,
 	.read_label = ads112c14_read_label,
 };
 
+static int ads112c14_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	const struct iio_chan_spec *chan;
+	int ret;
+
+	if (!ads112c14_using_drdy_trigger(indio_dev))
+		return 0;
+
+	chan = ads112c14_first_active_channel(indio_dev);
+	if (!chan)
+		return -EINVAL;
+
+	guard(mutex)(&data->lock);
+
+	ret = ads112c14_prepare_channel(data, chan);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
+				 ADS112C14_DEVICE_CFG_CONV_MODE,
+				 FIELD_PREP(ADS112C14_DEVICE_CFG_CONV_MODE,
+					    ADS112C14_DEVICE_CFG_CONV_MODE_CONTINUOUS));
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(data->continuous_mode, true);
+
+	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
+			   ADS112C14_CONVERSION_CTRL_START);
+	if (ret) {
+		WRITE_ONCE(data->continuous_mode, false);
+		regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
+				   ADS112C14_DEVICE_CFG_CONV_MODE,
+				   FIELD_PREP(ADS112C14_DEVICE_CFG_CONV_MODE,
+					      ADS112C14_DEVICE_CFG_CONV_MODE_SINGLE_SHOT));
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ads112c14_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (!ads112c14_using_drdy_trigger(indio_dev))
+		return 0;
+
+	guard(mutex)(&data->lock);
+
+	WRITE_ONCE(data->continuous_mode, false);
+
+	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
+			   ADS112C14_CONVERSION_CTRL_STOP);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
+				  ADS112C14_DEVICE_CFG_CONV_MODE,
+				  FIELD_PREP(ADS112C14_DEVICE_CFG_CONV_MODE,
+					     ADS112C14_DEVICE_CFG_CONV_MODE_SINGLE_SHOT));
+}
+
+static const struct iio_buffer_setup_ops ads112c14_buffer_setup_ops = {
+	.postenable = ads112c14_buffer_postenable,
+	.predisable = ads112c14_buffer_predisable,
+};
+
 static int ads112c14_populate_idac_mag(u32 current_nA, u8 *idac_mag)
 {
 	u32 current_uA = current_nA / (NANO / MICRO);
@@ -1480,6 +1615,19 @@ static int ads112c14_probe(struct i2c_client *client)
 				       0, dev_name(dev), indio_dev);
 		if (ret)
 			return ret;
+
+		data->drdy_trig = devm_iio_trigger_alloc(dev, "%s-dev%d-drdy",
+							 info->name,
+							 iio_device_id(indio_dev));
+		if (!data->drdy_trig)
+			return -ENOMEM;
+
+		data->drdy_trig->ops = &ads112c14_trigger_ops;
+		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
+
+		ret = devm_iio_trigger_register(dev, data->drdy_trig);
+		if (ret)
+			return ret;
 	}
 
 	ads112c14_populate_tables(data);
@@ -1490,7 +1638,8 @@ static int ads112c14_probe(struct i2c_client *client)
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
-					      ads112c14_trigger_handler, NULL);
+					      ads112c14_trigger_handler,
+					      &ads112c14_buffer_setup_ops);
 	if (ret)
 		return ret;
 

-- 
2.43.0

