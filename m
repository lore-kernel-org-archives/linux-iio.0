Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354323A0E8B
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141804; cv=none; b=rz3QWV/kf38/p59IkTIG91C5ihHZjNyBpoP4aBibJwlHQ5wjLuOI8dyTSWm3RHgR/vDU+7PDj+KjbNJa5TkYeLj99TcjBfZpcykQ8nuJzBO4L4QEKbGlWkf0M9zcSpj+M5sbFT5c1visd+5Ffa4zTiv056F6Ir83+WRFys1hqZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141804; c=relaxed/simple;
	bh=QREVGmbO0flASHR7B9jWuwtBmy40wR+vMZDh34awweo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyPfJNBEAg6KjfSZMwnPZTcZkbZd3MiaZ5UR4mtXwo7FUBcmZyHnL2omCcwLEtq2VQYCIkF2Gorn7qtpvYd1g+ZkN/HwJYL7AfRlor/C404dS29JeT21RDqFa3tGw0nudAMZVIH5kdvPYC+sEmGtljHhWuPzpHUeLPjyeYsWSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJT8Yipb; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJT8Yipb"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-835386ff122so2979148b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 15:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779141803; x=1779746603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t31rL2+BJeheFfwXTUWp86Cw2iNCjJotlcNbQb/7e1s=;
        b=lJT8YipbsF3NCPTOYgorb4cTDbWGT6VT2g3KWj8mZZj3AFyjpyv62+ZWdJENV3tPRm
         UaweD01brMtA1OoY+UW2Akvs5GliG+kKTDVM78zj/ZBc6GRqRepZXrpqeTsNcCa5lbVy
         JAJh5t+PPYO3fio1yqs6y+p9x/TtBQQBth2b472wZKlLSGlZmw5L3HQueA4gKmCWH59F
         W7vSZrLNeBEuQBsmCqoaok0Swv8cydc7BL3dq8UatjZg3keqaE2Z2Z/urByUFNKyNE7Y
         KZYVwG5P4XZ8ElB3DJ1RT1fYwyTycgWD6NKkxI1YeokvdYNimMFP8GbbKSbIDMJreb+R
         VNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141803; x=1779746603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t31rL2+BJeheFfwXTUWp86Cw2iNCjJotlcNbQb/7e1s=;
        b=QEC+L6XjctLztlGMcS/W0yN/Q/vAasYcAsepkCUkOr8igelJj3qCTyb1OdVeQdn1KX
         vmvuwmaKjXK7P0Xc/RdaTkxxIR+zDMuWHvfFGkLErepfgzmUuTx90EQhvbjEBKEyW6qe
         DSLudE0ctqKMnfzLQ6hXFmFLDPLDQ1d69DisUq9bcYwfbWX/pyxAPRnLLFKTgit/36bT
         IhHmxeA1ILkzQFhJTRVi60g0un+w+0YFgKb5neZWIczeswGknCWuGkEvus7Y9OsCDMnY
         Cnl8N/Q5XsDfOQV1AZbpNDV6kuSC7qZo4kK2uuHSaw7hZiPMCbC0ifEaApGooRqPu8ys
         YC5w==
X-Gm-Message-State: AOJu0YyuqHPpQCd8Ym/OWbm4jENkP3qAgb3BHzeXHnbcNRCOil/n8mMU
	2WByP4uxDmIncrTG4qksGkHR7hoPUBqZ2VzbdcdOS8kGwSJFNvCyaHSQ
X-Gm-Gg: Acq92OHsNXIRgNu0BY1KOTVk+4s8fsbDY9lJHRxFzK8y/hMe6YEGDGRI25ib82L6Iw8
	dBvRaajzqBFUcy827gxt65bWTCr8qLv013PqrA0F6kcFh4xj5vUAfDY7VvBFF4hXaUTKcf0hZb3
	/kpMebjQDeSs5UbcU8tkiPpO4tiQLuXcICh6vrUMeVeZpbSVP20UDYa+TPhcwAeCKeGsxHTZ828
	15QBkvDRbMuswZAACAhJjpIsfqlSh6BPN/oa1FPObW7BDVqJ0iiu1udNDzL6K4+56YZIDygp81H
	/59VapMNw20eYi/EGlny08ZrL/Be6i2FSM8FCWOtLZj9U4g5LB+Cr8FMMHeDtSoDV7LgfAz06o8
	RSIMAl/MZGK1kdX5YRP9CnlT8WU6vrMprQu9MMiruhnTT51s7V/6YoMny5mF5+wPfop1ws1QAU5
	hSwW3etzb9JZ2PrcpNlq1oR/Cqxr7dpwmN9my2a+5wi2BMWGrWhAvzb0N1mDIVYHAz5NwWOjQV3
	+UPeoQPDsAamQ4O7D/RaoaSA4gJHg9404ujSKVPN1zN6cCXmUGrzN9VqBcG
X-Received: by 2002:a05:6a00:c93:b0:81f:3fa0:8c38 with SMTP id d2e1a72fcca58-83f33b4d8a6mr17293228b3a.20.1779141802541;
        Mon, 18 May 2026 15:03:22 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1977b128sm15772960b3a.22.2026.05.18.15.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:03:22 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v9 11/11] iio: adc: hx711: add support for HX710B
Date: Tue, 19 May 2026 03:32:27 +0530
Message-ID: <20260518220228.63322-12-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518220228.63322-1-piyushpatle228@gmail.com>
References: <20260518220228.63322-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the AVIA HX710B ADC, which shares the HX711 GPIO
interface but uses trailing PD_SCK pulses to select the active mode.

Model the HX710B with variant-specific channel tables and IIO info,
track the active channel across conversions, and use the fixed gain
value when computing scale.

Also update the adjacent Kconfig text, file header, and module
description so the driver text matches the newly supported variant.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
Changes from v8:

Channel layout redesign (Jonathan Cameron):
  HX710B modes 1 and 3 both read the same physical differential input
  (only the sample rate differs: 10 vs 40 SPS).  Exposing them as two
  separate IIO channels was incorrect.  They are now collapsed into a
  single channel (in_voltage0-voltage1) with IIO_CHAN_INFO_SAMP_FREQ;
  userspace reads/writes sampling_frequency to select 10 or 40 SPS.
  The hx710b_write_raw() and hx710b_read_avail() callbacks are added
  to hx710b_iio_info to support this.

  The channel spec no longer uses .address to carry the trailing pulse
  count.  A new hx710b_trailing_pulses() helper derives the count from
  hx711_data.samp_freq (1 for 10 SPS, 3 for 40 SPS) and the channel
  type (2 for the supply monitor, which is always 40 SPS).

  The IIO_DECLARE_BUFFER_WITH_TS() slot count is reduced from 3 to 2
  to reflect that both HX711 and HX710B now have at most 2 physical
  channels.

channel_set ordering fix (Sashiko Suzuki):
  hx711_set_hx710b_channel() previously updated channel_set after
  hx711_wait_for_ready(), meaning a timeout would leave the field out
  of sync with the hardware.  The hardware mode is committed once
  hx711_read() sends the trailing pulses, so channel_set is now
  updated immediately after hx711_read() returns successfully, before
  the ready-wait.

Trigger error handling (Jonathan Cameron):
  hx711_trigger() was silently casting negative error codes from
  hx711_reset_read() to u32 and pushing them to the buffer.  The
  handler now checks the return value, logs the error with
  dev_err_ratelimited(), and skips the push via goto out_unlock.

 drivers/iio/adc/Kconfig |   8 +-
 drivers/iio/adc/hx711.c | 240 ++++++++++++++++++++++++++++++++++------
 2 files changed, 212 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb46..38ba8cae13f1 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -791,13 +791,15 @@ config HI8435
 	  called hi8435.
 
 config HX711
-	tristate "AVIA HX711 ADC for weight cells"
+	tristate "AVIA HX711 and compatible ADCs"
 	depends on GPIOLIB
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	  If you say yes here you get support for AVIA HX711 ADC which is used
-	  for weigh cells
+	  If you say Y here you get support for the following AVIA ADCs:
+	    - HX710B
+	    - HX711
+	  which are used for bridge sensors such as weigh cells.
 
 	  This driver uses two GPIOs, one acts as the clock and controls the
 	  channel selection and gain, the other one is used for the measurement
diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 183568196d52..d5c977b4669b 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * HX711: analog to digital converter for weight sensor module
+ * HX711 and compatible ADCs driver for weigh sensor modules
  *
  * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
  */
@@ -15,6 +15,8 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
+#include <linux/types.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
@@ -84,12 +86,16 @@ static int hx711_get_scale_to_gain(const int *gain_scale, int scale)
  * @channels: channel specification array
  * @num_channels: number of entries in @channels
  * @iio_info: IIO info ops for this variant
+ * @fixed_gain_val: fixed PGA gain (used when @has_fixed_gain is true)
+ * @has_fixed_gain: true if the variant has a fixed ADC gain
  */
 struct hx711_chip_info {
 	const char			*name;
 	const struct iio_chan_spec	*channels __counted_by_ptr(num_channels);
 	unsigned int			num_channels;
 	const struct iio_info		*iio_info;
+	unsigned int			fixed_gain_val;
+	bool				has_fixed_gain;
 };
 
 struct hx711_data {
@@ -99,16 +105,12 @@ struct hx711_data {
 	int			gain_set;	/* gain set on device */
 	int			gain_chan_a;	/* gain for channel A */
 	int			gain_scale[HX711_GAIN_MAX];
+	int			channel_set;	/* HX710B active channel */
+	unsigned int		samp_freq;	/* HX710B differential channel sample rate */
 	const struct hx711_chip_info	*chip_info;
 	struct mutex		lock;
-	/*
-	 * triggered buffer
-	 * 2x32-bit channel + 64-bit naturally aligned timestamp
-	 */
-	struct {
-		u32 channel[2];
-		aligned_s64 timestamp;
-	} buffer;
+	/* 2x32-bit channels + 64-bit naturally aligned timestamp */
+	IIO_DECLARE_BUFFER_WITH_TS(u32, buffer, 2);
 	/*
 	 * delay after a rising edge on SCK until the data is ready DOUT
 	 * this is dependent on the hx711 where the datasheet tells a
@@ -207,6 +209,7 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
 
 static int hx711_reset(struct hx711_data *hx711_data)
 {
+	const struct hx711_chip_info *info = hx711_data->chip_info;
 	int val;
 
 	val = hx711_wait_for_ready(hx711_data);
@@ -227,8 +230,11 @@ static int hx711_reset(struct hx711_data *hx711_data)
 
 		val = hx711_wait_for_ready(hx711_data);
 
-		/* after a reset the gain is 128 */
-		hx711_data->gain_set = HX711_RESET_GAIN;
+		if (info->has_fixed_gain)
+			hx711_data->channel_set = 0;
+		else
+			/* after a reset the gain is 128 */
+			hx711_data->gain_set = HX711_RESET_GAIN;
 	}
 
 	return val;
@@ -284,9 +290,51 @@ static int hx711_set_hx711_channel(struct hx711_data *hx711_data,
 	return 0;
 }
 
+/*
+ * Return the trailing pulse count for an HX710B channel (Table 3 in
+ * the datasheet).  The supply-monitor channel always uses 2 trailing
+ * pulses; the differential channel uses 1 (10 SPS) or 3 (40 SPS).
+ */
+static int hx710b_trailing_pulses(const struct hx711_data *hx711_data,
+				  const struct iio_chan_spec *chan)
+{
+	if (!chan->differential)
+		return 2;
+	return hx711_data->samp_freq == 10 ? 1 : 3;
+}
+
+/*
+ * Switch the HX710B to the requested channel for the next conversion.
+ * channel_set tracks the trailing pulse count that was last sent to the
+ * chip; it is updated immediately after hx711_read() commits the new
+ * mode in hardware, before waiting for the chip to be ready again.
+ */
+static int hx711_set_hx710b_channel(struct hx711_data *hx711_data,
+				    const struct iio_chan_spec *chan)
+{
+	int trailing_pulses = hx710b_trailing_pulses(hx711_data, chan);
+	int ret;
+
+	if (hx711_data->channel_set == trailing_pulses)
+		return 0;
+
+	ret = hx711_read(hx711_data, trailing_pulses);
+	if (ret < 0)
+		return ret;
+
+	hx711_data->channel_set = trailing_pulses;
+
+	ret = hx711_wait_for_ready(hx711_data);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int hx711_reset_read(struct hx711_data *hx711_data,
 			    const struct iio_chan_spec *chan)
 {
+	const struct hx711_chip_info *info = hx711_data->chip_info;
 	int trailing_pulses;
 	int ret;
 
@@ -299,9 +347,16 @@ static int hx711_reset_read(struct hx711_data *hx711_data,
 		return -EIO;
 	}
 
-	ret = hx711_set_hx711_channel(hx711_data, chan, &trailing_pulses);
-	if (ret < 0)
-		return ret;
+	if (info->has_fixed_gain) {
+		ret = hx711_set_hx710b_channel(hx711_data, chan);
+		if (ret < 0)
+			return ret;
+		trailing_pulses = hx710b_trailing_pulses(hx711_data, chan);
+	} else {
+		ret = hx711_set_hx711_channel(hx711_data, chan, &trailing_pulses);
+		if (ret < 0)
+			return ret;
+	}
 
 	return hx711_read(hx711_data, trailing_pulses);
 }
@@ -323,6 +378,9 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
 		if (*val < 0)
 			return *val;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = hx711_data->samp_freq;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		mutex_lock(&hx711_data->lock);
@@ -400,20 +458,26 @@ static irqreturn_t hx711_trigger(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct hx711_data *hx711_data = iio_priv(indio_dev);
 	int i, j = 0;
+	int ret;
 
 	mutex_lock(&hx711_data->lock);
 
-	memset(&hx711_data->buffer, 0, sizeof(hx711_data->buffer));
+	memset(hx711_data->buffer, 0, sizeof(hx711_data->buffer));
 
 	iio_for_each_active_channel(indio_dev, i) {
-		hx711_data->buffer.channel[j] =
-			hx711_reset_read(hx711_data, &indio_dev->channels[i]);
-		j++;
+		ret = hx711_reset_read(hx711_data, &indio_dev->channels[i]);
+		if (ret < 0) {
+			dev_err_ratelimited(hx711_data->dev,
+					    "read failed: %d\n", ret);
+			goto out_unlock;
+		}
+		hx711_data->buffer[j++] = ret;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &hx711_data->buffer,
-							pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, hx711_data->buffer,
+					   pf->timestamp);
 
+out_unlock:
 	mutex_unlock(&hx711_data->lock);
 
 	iio_trigger_notify_done(indio_dev->trig);
@@ -463,6 +527,50 @@ static const struct iio_info hx711_iio_info = {
 	.attrs			= &hx711_attribute_group,
 };
 
+static const int hx710b_samp_freq_avail[] = { 10, 40 };
+
+static int hx710b_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = hx710b_samp_freq_avail;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(hx710b_samp_freq_avail);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int hx710b_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct hx711_data *hx711_data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val != 10 && val != 40)
+			return -EINVAL;
+		mutex_lock(&hx711_data->lock);
+		hx711_data->samp_freq = val;
+		hx711_data->channel_set = 0;
+		mutex_unlock(&hx711_data->lock);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info hx710b_iio_info = {
+	.read_raw		= hx711_read_raw,
+	.write_raw		= hx710b_write_raw,
+	.read_avail		= hx710b_read_avail,
+};
+
 static const struct iio_chan_spec hx711_chan_spec[] = {
 	{
 		.type = IIO_VOLTAGE,
@@ -495,6 +603,51 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+/*
+ * HX710B channels (Table 3 in datasheet).
+ * 25 pulses (1 trailing): differential input, 10 SPS
+ * 26 pulses (2 trailing): DVDD-AVDD supply monitor, 40 SPS
+ * 27 pulses (3 trailing): differential input, 40 SPS
+ * Channel 0 exposes both differential rates via IIO_CHAN_INFO_SAMP_FREQ.
+ * Channel 2 is used for the supply monitor to avoid aliasing the
+ * channel2 terminal of the differential pair.
+ */
+static const struct iio_chan_spec hx710b_chan_spec[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.differential = 1,
+		.channel = 0,
+		.channel2 = 1,
+		.indexed = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 24,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
+	},
+	{
+		.type = IIO_VOLTAGE,
+		.channel = 2,
+		.indexed = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 24,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
+};
+
 static const struct hx711_chip_info hx711_chip = {
 	.name		= "hx711",
 	.channels	= hx711_chan_spec,
@@ -502,6 +655,15 @@ static const struct hx711_chip_info hx711_chip = {
 	.num_channels	= ARRAY_SIZE(hx711_chan_spec),
 };
 
+static const struct hx711_chip_info hx710b_chip = {
+	.name		= "hx710b",
+	.channels	= hx710b_chan_spec,
+	.iio_info	= &hx710b_iio_info,
+	.num_channels	= ARRAY_SIZE(hx710b_chan_spec),
+	.fixed_gain_val	= 128,
+	.has_fixed_gain	= true,
+};
+
 static int hx711_probe(struct platform_device *pdev)
 {
 	const struct hx711_chip_info *chip_info;
@@ -544,32 +706,43 @@ static int hx711_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(hx711_data->gpiod_dout),
 				     "failed to get dout-gpiod\n");
 
-	ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
+	if (chip_info->has_fixed_gain)
+		ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+	else
+		ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
 	if (ret < 0)
 		return ret;
 
 	/*
-	 * with
-	 * full scale differential input range: AVDD / GAIN
+	 * With
+	 * full scale differential input range: reference / GAIN
 	 * full scale output data: 2^24
 	 * we can say:
-	 *     AVDD / GAIN = 2^24
+	 *     reference / GAIN = 2^24
 	 * therefore:
-	 *     1 LSB = AVDD / GAIN / 2^24
-	 * AVDD is in uV, but we need 10^-9 mV
+	 *     1 LSB = reference / GAIN / 2^24
+	 * reference is in uV, but we need 10^-9 mV
 	 * approximately to fit into a 32 bit number:
-	 * 1 LSB = (AVDD * 100) / GAIN / 1678 [10^-9 mV]
+	 * 1 LSB = (reference * 100) / GAIN / 1678 [10^-9 mV]
 	 */
 
 	/* we need 10^-9 mV */
 	ret *= 100;
 
-	for (i = 0; i < HX711_GAIN_MAX; i++)
-		hx711_data->gain_scale[i] =
-			ret / hx711_gain_to_scale[i].gain / 1678;
+	if (chip_info->has_fixed_gain) {
+		for (i = 0; i < HX711_GAIN_MAX; i++)
+			hx711_data->gain_scale[i] =
+				ret / chip_info->fixed_gain_val / 1678;
+		hx711_data->gain_set = chip_info->fixed_gain_val;
+		hx711_data->samp_freq = 10;
+	} else {
+		for (i = 0; i < HX711_GAIN_MAX; i++)
+			hx711_data->gain_scale[i] =
+				ret / hx711_gain_to_scale[i].gain / 1678;
 
-	hx711_data->gain_set = 128;
-	hx711_data->gain_chan_a = 128;
+		hx711_data->gain_set = 128;
+		hx711_data->gain_chan_a = 128;
+	}
 
 	hx711_data->clock_frequency = 400000;
 	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
@@ -608,6 +781,7 @@ static int hx711_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_hx711_match[] = {
+	{ .compatible = "avia,hx710b", .data = &hx710b_chip },
 	{ .compatible = "avia,hx711", .data = &hx711_chip },
 	{ }
 };
@@ -625,7 +799,7 @@ static struct platform_driver hx711_driver = {
 module_platform_driver(hx711_driver);
 
 MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
-MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
+MODULE_DESCRIPTION("HX711 and compatible bitbanging ADC driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:hx711-gpio");
 
-- 
2.43.0

