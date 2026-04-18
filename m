Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554C2F999F
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776531980; cv=none; b=Sma0ieV38d3V/y9EQ/LNs7wW2Wo9oLnQbEZ2pYaeuwjM1kqNDOktlUAMSgAiIAlSyzOMUylAa4H8rcrUQXcnym8CvbNgFQimQbqKM1pnx3+dimnAgKVeofPd/u3dCS/K+9or+9Qil+TRNyyq7+l8G6ZPwsp9eSHPa+A3t01YBYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776531980; c=relaxed/simple;
	bh=NjGbOzaBwtu+3+N+Vrs/FQrhXNPqjVD105brah3XHGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=btSTc+Vy4SWmk2H1JqFVKY/EH4cjgMgceOqbF/vA6ZErp1GePt4rmtNGj04gcxg8Ntzz6Px/eWnLNULYBhy99HeT3R0p/Ktm8EE7wJiNhL/P06kfpWEtiq0MFGFYSg/xu73SCqKjJ8/vXZY7JQ0Cdz7kQiMstHkdDzcTVR+S4gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=prUr7AgH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prUr7AgH"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f83bd32efso1311045b3a.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776531978; x=1777136778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=htgHWsI2IRQhkfyZbTEU5LWjsWGo9az7zr5oG6dTRaI=;
        b=prUr7AgHQzSSBFgc5XTajxrJjEX78M1ISjjXz6XHtymAaR13GNxA5xDYxzxZqb+wqm
         rqPFaLVb6eH5pZHbtSpUxwjyAkO5H2oD8HeJcjHGx6fDEUHdSZ6gdHwLUaasrzOn2hEZ
         WxNc/sqovfm8f18isoblpbvATpR1sgf9FbRtiihXW/3kYwySarHKFf6js9unAFjYTCge
         MpcjOHHbfuKYWWVUVPDLzvE1O9uBv5qWMOvGg9rryPGgHoD0JRep2mOKLscqJUuuf1AR
         PMkXMRag5Y78aDTT8VNQXtxU0dfPpt5c+IqE1HMZxpgOjcgVXMkw7XwtfLrU8KjiGFB2
         SHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776531978; x=1777136778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htgHWsI2IRQhkfyZbTEU5LWjsWGo9az7zr5oG6dTRaI=;
        b=HIECvGGhFh5T/UxaovZ5YSLn+mXI8OdKUEqD4iEP6uwuwuCXoE/aqtDqDcIEE4RfXO
         AKAacROGLQ8jeJCZec0CHCUTwAdvAfOAkNKCpX4aA1LDGHIa3nSRLZC3gfGXIznXcvRN
         pBpsz2uULyjXynF0sKRqmde7zukunGxVXkwRaAF8CVHZImFvmAEHgTHUwE+KQTb5SuZg
         5o/Rf9IHF+SbrNGg0o+/yUB21U/sJ/ySdRyeNFby2l9tUjgkjjWL0m5mzTHCAnyl7srK
         cfjNEsekAltc1lP/8Mh8XaMcHShDzZ5gsLeubXqIpOpGz8FrSAgfpR4GiddQSAGf8dsr
         D+Iw==
X-Forwarded-Encrypted: i=1; AFNElJ90nMyl1KsIk5g7CVzHN/NqJhIK8p92wwmLD9nwdGLcrSgrcrH2tf3kH3MINNvUV3NB8noDnd4nvCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIsQBiz65788w2a9jt1NrFitM2CGPwKaQWiIGXHAjcW1FtBIDQ
	2rSspCw1XjH9SSA9ZfIYjuZI2aW5f8d1yUOiI3ninCT8o6W8BxmI/oJA
X-Gm-Gg: AeBDietYBfZOAASV/UBAIfk5xp57vglhJAbRUST5EtiPite04mlwN/6/yS23JAazGBO
	mj2LE0TiB3YTrNV/h9LTeJ4mn+/oaZgTB/ZGlE70suo3bJ+Ta2jPBPQuz3nM+YbAjQ+LqmHUzkP
	J9kzYuyz2ZuS+bw/YJAO4OLLmwa74WQVv7ooUje2j9H/tpcKGil21g0tp05xVzGUCbzhPJi+z6U
	8bwjosQ1aN0HKTPAz4Q2grdyy0Cg/3LF/80hBfE2fDNe7I3Nb+TJP3HKeUm6gBMlqYOr0uo/y2R
	Vs5KzQVeIg8mkjGs3t5yUD1rg+oh/E4yJTzQzuiKMXkJc0sKRKqQnuc7+3kx9FCsBGyfpd1S9UJ
	mhXlQhJtr9ZVI/u2TgpBWWYgg2PIjbyrQDIOOM89Iol7jXavRHOfBQ6uskx/EQautJbe1lsgrxM
	l0s4120DBTske0qc5gWrkGfrm7qakdiwe40GQRX215uweMjOMD1SeYQ0KPJNxUFKXovKalZl2Mt
	B/wyr+WtkwwM/DzQq0tRy9uDa9xApxdFxt3CZ90U7J67DRiIbAiwSnwOmzDmw==
X-Received: by 2002:a05:6a00:cc1:b0:82c:2555:b9b2 with SMTP id d2e1a72fcca58-82f8c7db2b1mr8096716b3a.10.1776531978042;
        Sat, 18 Apr 2026 10:06:18 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d016:3ec3:66e6:8cde:aa47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981be6sm6650342b3a.9.2026.04.18.10.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 10:06:17 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: jic23@kernel.org,
	ak@it-klinger.de
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] iio: adc: hx711: add support for HX710B
Date: Sat, 18 Apr 2026 22:36:00 +0530
Message-ID: <20260418170610.312523-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the driver around per-chip configuration so HX711 and HX710B
can share the same core.

Add HX710B channel definitions, pulse-count based channel selection, a
variant-specific iio_info, and fixed-scale handling at probe. Update the
Kconfig text and trim comments so the added support stays focused on the
actual driver behavior.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
 drivers/iio/adc/Kconfig |   9 +-
 drivers/iio/adc/hx711.c | 222 ++++++++++++++++++++++++++++++++--------
 2 files changed, 184 insertions(+), 47 deletions(-)

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
index 1db8b68a8f64..cd251fa9f6b7 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * HX711: analog to digital converter for weight sensor module
+ * HX711/HX710B ADC driver
  *
  * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
  */
@@ -76,13 +76,34 @@ static int hx711_get_scale_to_gain(int scale)
 	return -EINVAL;
 }
 
+/**
+ * struct hx711_chip_info - per-variant static configuration
+ * @name: IIO device name
+ * @channels: channel specification
+ * @num_channels: number of channels
+ * @chan_pulse_count: trailing pulse count for fixed-gain variants
+ * @num_chan_pulses: number of pulse-count entries
+ * @reset_channel: default channel after reset
+ */
+struct hx711_chip_info {
+	const char			*name;
+	const struct iio_chan_spec	*channels;
+	int				num_channels;
+	const int			*chan_pulse_count;
+	int				num_chan_pulses;
+	int				reset_channel;
+};
+
 struct hx711_data {
-	struct device		*dev;
-	struct gpio_desc	*gpiod_pd_sck;
-	struct gpio_desc	*gpiod_dout;
-	int			gain_set;	/* gain set on device */
-	int			gain_chan_a;	/* gain for channel A */
-	struct mutex		lock;
+	struct device			*dev;
+	struct gpio_desc		*gpiod_pd_sck;
+	struct gpio_desc		*gpiod_dout;
+	int				gain_set;	/* HX711 */
+	int				gain_chan_a;	/* HX711 channel A gain */
+	int				channel_set;	/* HX710B */
+	int				scale;		/* HX710B scale */
+	const struct hx711_chip_info	*chip_info;
+	struct mutex			lock;
 	/*
 	 * triggered buffer
 	 * 2x32-bit channel + 64-bit naturally aligned timestamp
@@ -92,13 +113,10 @@ struct hx711_data {
 		aligned_s64 timestamp;
 	} buffer;
 	/*
-	 * delay after a rising edge on SCK until the data is ready DOUT
-	 * this is dependent on the hx711 where the datasheet tells a
-	 * maximum value of 100 ns
-	 * but also on potential parasitic capacities on the wiring
+	 * Delay after SCK rising edge before sampling DOUT.
 	 */
-	u32			data_ready_delay_ns;
-	u32			clock_frequency;
+	u32				data_ready_delay_ns;
+	u32				clock_frequency;
 };
 
 static int hx711_cycle(struct hx711_data *hx711_data)
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
+		if (info->chan_pulse_count)
+			hx711_data->channel_set = info->reset_channel;
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
 
@@ -246,27 +275,52 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 	return 0;
 }
 
+/* Select HX710B channel for the next conversion. */
+static int hx710b_set_channel(struct hx711_data *hx711_data, int chan)
+{
+	const struct hx711_chip_info *info = hx711_data->chip_info;
+	int ret;
+
+	if (chan >= info->num_chan_pulses)
+		return -EINVAL;
+
+	if (hx711_data->channel_set == chan)
+		return 0;
+
+	hx711_data->channel_set = chan;
+
+	ret = hx711_read(hx711_data, info->chan_pulse_count[chan]);
+	if (ret < 0)
+		return ret;
+
+	return hx711_wait_for_ready(hx711_data);
+}
+
 static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
 {
+	const struct hx711_chip_info *info = hx711_data->chip_info;
+	int trailing_pulses;
 	int ret;
-	int val;
 
-	/*
-	 * hx711_reset() must be called from here
-	 * because it could be calling hx711_read() by itself
-	 */
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
+	if (info->chan_pulse_count) {
+		ret = hx710b_set_channel(hx711_data, chan);
+		if (ret < 0)
+			return ret;
+		trailing_pulses = info->chan_pulse_count[chan];
+	} else {
+		ret = hx711_set_gain_for_channel(hx711_data, chan);
+		if (ret < 0)
+			return ret;
+		trailing_pulses = hx711_get_gain_to_pulse(hx711_data->gain_set);
+	}
 
-	return val;
+	return hx711_read(hx711_data, trailing_pulses);
 }
 
 static int hx711_read_raw(struct iio_dev *indio_dev,
@@ -274,6 +328,7 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
 				int *val, int *val2, long mask)
 {
 	struct hx711_data *hx711_data = iio_priv(indio_dev);
+	const struct hx711_chip_info *info = hx711_data->chip_info;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -290,7 +345,10 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		mutex_lock(&hx711_data->lock);
 
-		*val2 = hx711_get_gain_to_scale(hx711_data->gain_set);
+		if (info->chan_pulse_count)
+			*val2 = hx711_data->scale;
+		else
+			*val2 = hx711_get_gain_to_scale(hx711_data->gain_set);
 
 		mutex_unlock(&hx711_data->lock);
 
@@ -332,7 +390,8 @@ static int hx711_write_raw(struct iio_dev *indio_dev,
 			if (gain != 32)
 				hx711_data->gain_chan_a = gain;
 
-			ret = hx711_read(hx711_data);
+			ret = hx711_read(hx711_data,
+					 hx711_get_gain_to_pulse(hx711_data->gain_set));
 			if (ret < 0) {
 				mutex_unlock(&hx711_data->lock);
 				return ret;
@@ -423,6 +482,10 @@ static const struct iio_info hx711_iio_info = {
 	.attrs			= &hx711_attribute_group,
 };
 
+static const struct iio_info hx710b_iio_info = {
+	.read_raw		= hx711_read_raw,
+};
+
 static const struct iio_chan_spec hx711_chan_spec[] = {
 	{
 		.type = IIO_VOLTAGE,
@@ -455,10 +518,69 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+/* HX710B channels: differential input and DVDD-AVDD measurement. */
+static const struct iio_chan_spec hx710b_chan_spec[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.channel = 0,
+		.indexed = 1,
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
+/*
+ * HX710B trailing pulse counts.
+ * 25 selects differential input, 26 selects DVDD-AVDD.
+ */
+static const int hx710b_pulse_counts[] = {
+	25,	/* channel 0: differential input, 10 SPS */
+	26,	/* channel 1: DVDD-AVDD voltage,   40 SPS */
+};
+
+static const struct hx711_chip_info hx711_chip = {
+	.name			= "hx711",
+	.channels		= hx711_chan_spec,
+	.num_channels		= ARRAY_SIZE(hx711_chan_spec),
+	.chan_pulse_count	= NULL,
+};
+
+static const struct hx711_chip_info hx710b_chip = {
+	.name			= "hx710b",
+	.channels		= hx710b_chan_spec,
+	.num_channels		= ARRAY_SIZE(hx710b_chan_spec),
+	.chan_pulse_count	= hx710b_pulse_counts,
+	.num_chan_pulses	= ARRAY_SIZE(hx710b_pulse_counts),
+	.reset_channel		= 0,
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
@@ -472,6 +594,11 @@ static int hx711_probe(struct platform_device *pdev)
 
 	mutex_init(&hx711_data->lock);
 
+	chip_info = device_get_match_data(dev);
+	if (!chip_info)
+		return -ENODEV;
+	hx711_data->chip_info = chip_info;
+
 	/*
 	 * PD_SCK stands for power down and serial clock input of HX711
 	 * in the driver it is an output
@@ -510,12 +637,20 @@ static int hx711_probe(struct platform_device *pdev)
 	/* we need 10^-9 mV */
 	ret *= 100;
 
-	for (i = 0; i < HX711_GAIN_MAX; i++)
-		hx711_gain_to_scale[i].scale =
-			ret / hx711_gain_to_scale[i].gain / 1678;
+	if (chip_info->chan_pulse_count) {
+		/* HX710B uses a fixed gain, so compute scale once at probe. */
+		hx711_data->scale = ret / 128 / 1678;
+		hx711_data->channel_set = chip_info->reset_channel;
+		indio_dev->info = &hx710b_iio_info;
+	} else {
+		for (i = 0; i < HX711_GAIN_MAX; i++)
+			hx711_gain_to_scale[i].scale =
+				ret / hx711_gain_to_scale[i].gain / 1678;
 
-	hx711_data->gain_set = 128;
-	hx711_data->gain_chan_a = 128;
+		hx711_data->gain_set = 128;
+		hx711_data->gain_chan_a = 128;
+		indio_dev->info = &hx711_iio_info;
+	}
 
 	hx711_data->clock_frequency = 400000;
 	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
@@ -533,11 +668,10 @@ static int hx711_probe(struct platform_device *pdev)
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
@@ -554,7 +688,8 @@ static int hx711_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_hx711_match[] = {
-	{ .compatible = "avia,hx711", },
+	{ .compatible = "avia,hx711",  .data = &hx711_chip  },
+	{ .compatible = "avia,hx710b", .data = &hx710b_chip },
 	{ }
 };
 
@@ -571,7 +706,6 @@ static struct platform_driver hx711_driver = {
 module_platform_driver(hx711_driver);
 
 MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
-MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
+MODULE_DESCRIPTION("HX711/HX710B GPIO ADC driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:hx711-gpio");
-
-- 
2.43.0

