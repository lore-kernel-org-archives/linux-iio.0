Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC9F24E4C6
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776620842; cv=none; b=oRnsJgR1CeT+s0kwqIWDEzkhEpfD/ZprxYaPy8RllZmvGErNplhg3g/ZJ6KbLmX907iamXVMo0lDOF96kVVcVrvhh4RYc1K7P2uhwXlPtmAbZzeGfE5+dNqoX/hVTQVlHdrsJmrcVrfVbGxv+B82q3cbsO1RLL/BzqeELKPJaw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776620842; c=relaxed/simple;
	bh=IiZoDIW/qSPAQ62PeGLJSQDCBqPv8LFFgyiTz22xvWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHGNpB/tbnu/AbysheqEWfyEMhCLcZibMRYNE7YgKKlAsvqqWHDLmaMOXKrHpRHvb0EzwF05R2u8sAf9y8PmNRVcPXYhmKFAH66NzjENzxwML8RDRlqebumits6mnjuOOXuSKOghDTV3kfFDI/rWkwwjGgj4lTqDB6+84bk+j2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdlPGdUz; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdlPGdUz"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35fc0d7c310so1515298a91.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 10:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776620840; x=1777225640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcvRYGZ1sJJEZCkKcoqV7JaYB5TeC/s9HV7XVT0QOXA=;
        b=JdlPGdUzgatsM4D+RuwfeFTmVjHdaJ654AycGUHTlJe2d+SgmfduLQGwjPfmH0dwxB
         sTrExBvHQBi6dckfk67GRt68qI/NQGalSl3sUpCVQ1XtagNQLDk816j48No4icsQCwiR
         1boATx4cvmRcLKjsh1CpENHaYrZGQNW/YCGXXsRXMq5b4L00YogD9uh3ebF34ypMRcAv
         9DVqzIDKqKZczTlGWBsmBRp4OYO4pCdZVntElodYJTRKkKtgz4Eic6jiISWdoGubRmm6
         f/eqxt3+fmTgWSGhzF0MyM/AUhuYfrPn04dxGFNnUYajAdPozuiYoFAkpNxHzTv4t/oH
         YMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776620840; x=1777225640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WcvRYGZ1sJJEZCkKcoqV7JaYB5TeC/s9HV7XVT0QOXA=;
        b=dvonin54I6oY0En7Ozabxa4h3/FDgcILgzRV1J5UOp1k9rDu0l1AlDqXUfz82NoXCZ
         F9W4iVCB/zuC4T68IBPD741fKDiaKrOX/ei0V8BTgbA1UOqNdAhfUoM7NrsyXqy5iy/m
         TNSPW9j1Vcgr+bPRTHaDKB/t+QaCZgNCClQNYGa/d11mGgqrECAtTaibefD2P1EOHLOx
         +54zB3t31yg7sUCFiaeP89fO5ytokz9YAwnK2GbYOzOg0igiMGPVD3hnqlshecu3TkUq
         iuK0Bv37ZjvhyqZHRSVBZUpWeilq6832z3a96hdooIMYHhbA2dSHBfFeck1Fwlsg/P3s
         lQ3w==
X-Forwarded-Encrypted: i=1; AFNElJ8zk5x2R0DBIltdLwB2aAh8KX4zXiImQL/lEBWCaGkYHK7YEBh+bFLnnOEav/Uld9RxW+00uK7wfpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRpJ+0tMbhZzLL2Wbloc9wi9wizGtg7jIzBld1NFbcwUidlabA
	g/9V1/9Z87+qugFWwxAB4Hf6vRn9KP2SzUUPbXKKbrdQq+JLpm7HsPOv
X-Gm-Gg: AeBDievgf+L3CanSz8UO8YveoUIgyLcLgiJINYjn4SstZeOBfmo4pM+DWRuiDos6j5f
	OxQVHJ4S1hYJoLhMB5OpGortRzDeudK/FKYPG4UcVDYwQ/qGICNa8DjwlBMiVkj9raer7m2N3Ul
	2PpR2oc0itOPP6GcEr2yt8f5XH811OZ1PRrx/qf9B2Kngm0A2hZ/m/DHz86Qa0UafC1IR6XkKT7
	fWCu4iCCJVGz40fRorYr5eFma7kGCmv+W4YYMebJUTFBvChJRLRGY+ydUZD7/sEyjzIe8tJfJJJ
	6cTbEYTbvEYiAJXGYfWlpmUYmRRUYO0JgyMbhV0ONnvxgMa5M7UjVL2dSIeOMKOLtbdxtEhNBvv
	CxK5W/wfdviVRm2b7ixLk/X8PU7QoRGr0sEYplGByUlU4nPWTxA0WgZA0MJF+xUokrNU2rLtRi4
	EIkbzSRGpsUo41uUpuqZrEI/0B0vD0wkqSWi20NxkISYl/iVz/Z+fFKh2IRn3EXE92KcHeXV31y
	Bla2S44/eAP4qfeHvutBVmqQ6lcHpC7BGoGcPyYUUCSmZNGDF4=
X-Received: by 2002:a17:90b:4c52:b0:35f:b647:d98a with SMTP id 98e67ed59e1d1-361403c3412mr11556760a91.5.1776620840354;
        Sun, 19 Apr 2026 10:47:20 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:1c1e:6c93:8067:7dee])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fe07c7sm7794875a91.5.2026.04.19.10.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 10:47:19 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: jic23@kernel.org,
	ak@it-klinger.de
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: adc: hx711: add support for HX710B
Date: Sun, 19 Apr 2026 23:16:40 +0530
Message-ID: <20260419174654.683692-3-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419174654.683692-1-piyushpatle228@gmail.com>
References: <20260419174654.683692-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HX711 uses trailing SCK pulses after each 24-bit conversion to
select the channel and gain for the next measurement: 1 pulse gives
channel A at gain 128, 2 pulses give channel B at gain 32, and 3 pulses
give channel A at gain 64.

The HX710B works differently: gain is fixed at 128 and the trailing
pulses select only the channel. One trailing pulse selects the
differential input (channel 0, 10 SPS) and two trailing pulses select
the DVDD-AVDD supply monitor (channel 1, 40 SPS).

Refactor the driver around a per-chip hx711_chip_info structure so both
variants can share the same core. Each chip provides its own
iio_chan_spec array and iio_info pointer. The HX710B stores per-channel
trailing pulse counts in chan->address (1 for channel 0, 2 for
channel 1) instead of a separate array. A bool fixed_gain flag and
fixed_gain_val field in hx711_chip_info distinguish the fixed-gain path
from the HX711's user-selectable gain path without conflating unrelated
properties. The HX710B differential input channel is described with
.differential=1 and .channel2=1 as required by the IIO ABI.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
Changes in v2:
- Fix pulse count bug: hx710b values were {25, 26} (total SCK cycles);
  corrected to {1, 2} (trailing-only, hx711_read() clocks 24 data bits)
- Add .differential = 1 and .channel2 = 1 to HX710B channel 0
- Move trailing pulse counts from a separate array to chan->address
  (1 for ch0, 2 for ch1); remove chan_pulse_count / num_chan_pulses
- Replace chan_pulse_count != NULL tests with dedicated bool fixed_gain
  flag; add fixed_gain_val field to hx711_chip_info
- Add const struct iio_info *iio_info to hx711_chip_info; probe sets
  indio_dev->info = chip_info->iio_info directly
- Remove NULL check after device_get_match_data()
- Remove reset_channel from hx711_chip_info (always 0; use literal)
- Change hx711_reset_read() and hx710b_set_channel() to take
  const struct iio_chan_spec * instead of int chan
- Revert hx711_data struct member alignment noise
- Restore trailing blank line at end of file (unrelated removal reverted)
- Sort of_device_id entries alphabetically (hx710b before hx711)
- Expand commit message to explain HX711 vs HX710B trailing-pulse model
- Restore file header to mention weight sensor modules

 drivers/iio/adc/Kconfig |   9 +-
 drivers/iio/adc/hx711.c | 206 ++++++++++++++++++++++++++++++++--------
 2 files changed, 174 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 60038ae8dfc4..ddf981fa72a2 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -784,18 +784,21 @@ config HI8435
 	  called hi8435.
 
 config HX711
-	tristate "AVIA HX711 ADC for weight cells"
+	tristate "AVIA HX711 and HX710B ADC"
 	depends on GPIOLIB
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	  If you say yes here you get support for AVIA HX711 ADC which is used
-	  for weigh cells
+	  If you say yes here you get support for AVIA HX711 and HX710B ADCs
+	  which are used for bridge sensors such as weigh cells.
 
 	  This driver uses two GPIOs, one acts as the clock and controls the
 	  channel selection and gain, the other one is used for the measurement
 	  data
 
+	  The HX710B is a variant with fixed gain and a different channel
+	  selection scheme.
+
 	  Currently the raw value is read from the chip and delivered.
 	  To get an actual weight one needs to subtract the
 	  zero offset and multiply by a scale factor.
diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 1db8b68a8f64..b024fb341b2e 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * HX711: analog to digital converter for weight sensor module
+ * HX711/HX710B: ADC driver for weight sensor modules
  *
  * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
  */
@@ -76,12 +76,33 @@ static int hx711_get_scale_to_gain(int scale)
 	return -EINVAL;
 }
 
+/**
+ * struct hx711_chip_info - per-variant static configuration
+ * @name: IIO device name
+ * @channels: channel specification
+ * @num_channels: number of channels
+ * @iio_info: IIO info ops for this variant
+ * @fixed_gain: true if the variant has a fixed ADC gain (e.g. HX710B)
+ * @fixed_gain_val: the fixed gain value used to compute scale (when fixed_gain)
+ */
+struct hx711_chip_info {
+	const char			*name;
+	const struct iio_chan_spec	*channels;
+	int				num_channels;
+	const struct iio_info		*iio_info;
+	bool				fixed_gain;
+	int				fixed_gain_val;
+};
+
 struct hx711_data {
 	struct device		*dev;
 	struct gpio_desc	*gpiod_pd_sck;
 	struct gpio_desc	*gpiod_dout;
 	int			gain_set;	/* gain set on device */
 	int			gain_chan_a;	/* gain for channel A */
+	int			channel_set;	/* HX710B current channel */
+	int			scale;		/* HX710B fixed scale */
+	const struct hx711_chip_info *chip_info;
 	struct mutex		lock;
 	/*
 	 * triggered buffer
@@ -92,10 +113,7 @@ struct hx711_data {
 		aligned_s64 timestamp;
 	} buffer;
 	/*
-	 * delay after a rising edge on SCK until the data is ready DOUT
-	 * this is dependent on the hx711 where the datasheet tells a
-	 * maximum value of 100 ns
-	 * but also on potential parasitic capacities on the wiring
+	 * Delay after SCK rising edge before sampling DOUT.
 	 */
 	u32			data_ready_delay_ns;
 	u32			clock_frequency;
@@ -139,7 +157,11 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	return gpiod_get_value(hx711_data->gpiod_dout);
 }
 
-static int hx711_read(struct hx711_data *hx711_data)
+/*
+ * Clock out 24 data bits and then send trailing pulses to select the
+ * next channel/gain state.
+ */
+static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 {
 	int i, ret;
 	int value = 0;
@@ -158,7 +180,7 @@ static int hx711_read(struct hx711_data *hx711_data)
 
 	value ^= 0x800000;
 
-	for (i = 0; i < hx711_get_gain_to_pulse(hx711_data->gain_set); i++)
+	for (i = 0; i < trailing_pulses; i++)
 		hx711_cycle(hx711_data);
 
 	return value;
@@ -188,6 +210,7 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
 
 static int hx711_reset(struct hx711_data *hx711_data)
 {
+	const struct hx711_chip_info *info = hx711_data->chip_info;
 	int val = hx711_wait_for_ready(hx711_data);
 
 	if (val) {
@@ -206,13 +229,17 @@ static int hx711_reset(struct hx711_data *hx711_data)
 
 		val = hx711_wait_for_ready(hx711_data);
 
-		/* after a reset the gain is 128 */
-		hx711_data->gain_set = HX711_RESET_GAIN;
+		/* Restore variant default after reset. */
+		if (info->fixed_gain)
+			hx711_data->channel_set = 0;
+		else
+			hx711_data->gain_set = HX711_RESET_GAIN;
 	}
 
 	return val;
 }
 
+/* Select HX711 channel/gain for the next conversion. */
 static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 {
 	int ret;
@@ -221,7 +248,8 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 		if (hx711_data->gain_set == 32) {
 			hx711_data->gain_set = hx711_data->gain_chan_a;
 
-			ret = hx711_read(hx711_data);
+			ret = hx711_read(hx711_data,
+					 hx711_get_gain_to_pulse(hx711_data->gain_set));
 			if (ret < 0)
 				return ret;
 
@@ -233,7 +261,8 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 		if (hx711_data->gain_set != 32) {
 			hx711_data->gain_set = 32;
 
-			ret = hx711_read(hx711_data);
+			ret = hx711_read(hx711_data,
+					 hx711_get_gain_to_pulse(hx711_data->gain_set));
 			if (ret < 0)
 				return ret;
 
@@ -246,27 +275,50 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 	return 0;
 }
 
-static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
+/* Select HX710B channel for the next conversion. */
+static int hx710b_set_channel(struct hx711_data *hx711_data,
+			      const struct iio_chan_spec *chan)
 {
 	int ret;
-	int val;
 
-	/*
-	 * hx711_reset() must be called from here
-	 * because it could be calling hx711_read() by itself
-	 */
+	if (hx711_data->channel_set == chan->channel)
+		return 0;
+
+	hx711_data->channel_set = chan->channel;
+
+	ret = hx711_read(hx711_data, chan->address);
+	if (ret < 0)
+		return ret;
+
+	return hx711_wait_for_ready(hx711_data);
+}
+
+static int hx711_reset_read(struct hx711_data *hx711_data,
+			    const struct iio_chan_spec *chan)
+{
+	const struct hx711_chip_info *info = hx711_data->chip_info;
+	int trailing_pulses;
+	int ret;
+
+	/* Reset first so the read starts from a known chip state. */
 	if (hx711_reset(hx711_data)) {
 		dev_err(hx711_data->dev, "reset failed!");
 		return -EIO;
 	}
 
-	ret = hx711_set_gain_for_channel(hx711_data, chan);
-	if (ret < 0)
-		return ret;
-
-	val = hx711_read(hx711_data);
+	if (info->fixed_gain) {
+		ret = hx710b_set_channel(hx711_data, chan);
+		if (ret < 0)
+			return ret;
+		trailing_pulses = chan->address;
+	} else {
+		ret = hx711_set_gain_for_channel(hx711_data, chan->channel);
+		if (ret < 0)
+			return ret;
+		trailing_pulses = hx711_get_gain_to_pulse(hx711_data->gain_set);
+	}
 
-	return val;
+	return hx711_read(hx711_data, trailing_pulses);
 }
 
 static int hx711_read_raw(struct iio_dev *indio_dev,
@@ -274,12 +326,13 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
 				int *val, int *val2, long mask)
 {
 	struct hx711_data *hx711_data = iio_priv(indio_dev);
+	const struct hx711_chip_info *info = hx711_data->chip_info;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&hx711_data->lock);
 
-		*val = hx711_reset_read(hx711_data, chan->channel);
+		*val = hx711_reset_read(hx711_data, chan);
 
 		mutex_unlock(&hx711_data->lock);
 
@@ -290,7 +343,10 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		mutex_lock(&hx711_data->lock);
 
-		*val2 = hx711_get_gain_to_scale(hx711_data->gain_set);
+		if (info->fixed_gain)
+			*val2 = hx711_data->scale;
+		else
+			*val2 = hx711_get_gain_to_scale(hx711_data->gain_set);
 
 		mutex_unlock(&hx711_data->lock);
 
@@ -332,7 +388,8 @@ static int hx711_write_raw(struct iio_dev *indio_dev,
 			if (gain != 32)
 				hx711_data->gain_chan_a = gain;
 
-			ret = hx711_read(hx711_data);
+			ret = hx711_read(hx711_data,
+					 hx711_get_gain_to_pulse(hx711_data->gain_set));
 			if (ret < 0) {
 				mutex_unlock(&hx711_data->lock);
 				return ret;
@@ -368,7 +425,7 @@ static irqreturn_t hx711_trigger(int irq, void *p)
 
 	iio_for_each_active_channel(indio_dev, i) {
 		hx711_data->buffer.channel[j] = hx711_reset_read(hx711_data,
-					indio_dev->channels[i].channel);
+					&indio_dev->channels[i]);
 		j++;
 	}
 
@@ -423,6 +480,10 @@ static const struct iio_info hx711_iio_info = {
 	.attrs			= &hx711_attribute_group,
 };
 
+static const struct iio_info hx710b_iio_info = {
+	.read_raw		= hx711_read_raw,
+};
+
 static const struct iio_chan_spec hx711_chan_spec[] = {
 	{
 		.type = IIO_VOLTAGE,
@@ -455,10 +516,69 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+/*
+ * HX710B channels.
+ * Channel 0: differential input (IN+ vs IN-), 10 SPS, 1 trailing pulse.
+ * Channel 1: DVDD-AVDD supply monitor,         40 SPS, 2 trailing pulses.
+ * .address holds the trailing pulse count used by hx710b_set_channel().
+ */
+static const struct iio_chan_spec hx710b_chan_spec[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.differential = 1,
+		.channel = 0,
+		.channel2 = 1,
+		.indexed = 1,
+		.address = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
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
+		.channel = 1,
+		.indexed = 1,
+		.address = 2,
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
+static const struct hx711_chip_info hx711_chip = {
+	.name		= "hx711",
+	.channels	= hx711_chan_spec,
+	.num_channels	= ARRAY_SIZE(hx711_chan_spec),
+	.iio_info	= &hx711_iio_info,
+};
+
+static const struct hx711_chip_info hx710b_chip = {
+	.name		= "hx710b",
+	.channels	= hx710b_chan_spec,
+	.num_channels	= ARRAY_SIZE(hx710b_chan_spec),
+	.iio_info	= &hx710b_iio_info,
+	.fixed_gain	= true,
+	.fixed_gain_val	= 128,
+};
+
 static int hx711_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct hx711_data *hx711_data;
+	const struct hx711_chip_info *chip_info;
 	struct iio_dev *indio_dev;
 	int ret;
 	int i;
@@ -472,6 +592,9 @@ static int hx711_probe(struct platform_device *pdev)
 
 	mutex_init(&hx711_data->lock);
 
+	chip_info = device_get_match_data(dev);
+	hx711_data->chip_info = chip_info;
+
 	/*
 	 * PD_SCK stands for power down and serial clock input of HX711
 	 * in the driver it is an output
@@ -510,12 +633,19 @@ static int hx711_probe(struct platform_device *pdev)
 	/* we need 10^-9 mV */
 	ret *= 100;
 
-	for (i = 0; i < HX711_GAIN_MAX; i++)
-		hx711_gain_to_scale[i].scale =
-			ret / hx711_gain_to_scale[i].gain / 1678;
+	if (chip_info->fixed_gain) {
+		/* Fixed-gain variant: compute scale once at probe. */
+		hx711_data->scale = ret / chip_info->fixed_gain_val / 1678;
+	} else {
+		for (i = 0; i < HX711_GAIN_MAX; i++)
+			hx711_gain_to_scale[i].scale =
+				ret / hx711_gain_to_scale[i].gain / 1678;
+
+		hx711_data->gain_set = 128;
+		hx711_data->gain_chan_a = 128;
+	}
 
-	hx711_data->gain_set = 128;
-	hx711_data->gain_chan_a = 128;
+	indio_dev->info = chip_info->iio_info;
 
 	hx711_data->clock_frequency = 400000;
 	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
@@ -533,11 +663,10 @@ static int hx711_probe(struct platform_device *pdev)
 	hx711_data->data_ready_delay_ns =
 				1000000000 / hx711_data->clock_frequency;
 
-	indio_dev->name = "hx711";
-	indio_dev->info = &hx711_iio_info;
+	indio_dev->name = chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = hx711_chan_spec;
-	indio_dev->num_channels = ARRAY_SIZE(hx711_chan_spec);
+	indio_dev->channels = chip_info->channels;
+	indio_dev->num_channels = chip_info->num_channels;
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
@@ -554,7 +683,8 @@ static int hx711_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_hx711_match[] = {
-	{ .compatible = "avia,hx711", },
+	{ .compatible = "avia,hx710b", .data = &hx710b_chip },
+	{ .compatible = "avia,hx711",  .data = &hx711_chip  },
 	{ }
 };
 
@@ -571,7 +701,7 @@ static struct platform_driver hx711_driver = {
 module_platform_driver(hx711_driver);
 
 MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
-MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
+MODULE_DESCRIPTION("HX711/HX710B GPIO ADC driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:hx711-gpio");
 
-- 
2.43.0

