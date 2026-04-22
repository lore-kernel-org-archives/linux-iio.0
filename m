Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7485539B97B
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880770; cv=none; b=L41xmUpDsxvW6z56G09WoUrgzKw29IHTZkkdr9fJHdRmzMh22/FPval4b7sF6oCqbQWb/bGRcCG8tCBBfNQN/XjSAHc7wTj934j3QvERQFbwqZk1C8ce29rruMfjcMCI0ytqC4sQnQzuqf/FGCI3aj/a8hd/acdbKfODFxDvlGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880770; c=relaxed/simple;
	bh=Jum5PzYDFBM/uD40Ud1r3A5PJoqMkSUn/W06zgsAVXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i77Q2Tid0nQlpt/lRCae3q8AacgBeenAuaPRM51Xxy4k4NZTdqFdlxHpO92T61/RSzO5H/cKCgO7cCBX6IzsvyaJQFaLnpbGJR1SdPIh+W0ZGu6bHeS7EZuHFsFpLCc9UASbGfK8gQzeVt48o9IxONhK7+7hCn79USUoAM14MlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS/g0Jao; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS/g0Jao"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c795a47186bso2381948a12.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776880768; x=1777485568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n37RD+E+6djSJ5KaN5Pz6THH1x0Tdc7Kjmf8WQiqgnA=;
        b=CS/g0JaoHY2zBndtAJplR31t37LwuQ89/e6HnnrVr+wdq6BYkPjvqELlLc8iXhGNZZ
         DBGTKkeeJMUw15q9LuG9+ayQtrSo8Q09J0StfkiKAXe9daTEh8PfSmFyz6tXq2U294Vm
         dVQluun3Lc5rRmpFfY9/MW8+T9eztab1D1u9j8rlZ6Piw2qX3KoTrNwCJtjliB/MMWBf
         DvDQMNeUhvSGvrzCTd2ZlrfaQBNTppihm2GBJkEMeynCPS0shi5CaAwwwBwfh79VVbc0
         X4DO9HNThC0EIDiN6Fx+6nqx/3YN9hBvWOlp2pJuX7g4pKh/2/fbMvYFy8TFSKpA3JJY
         Q5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776880768; x=1777485568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n37RD+E+6djSJ5KaN5Pz6THH1x0Tdc7Kjmf8WQiqgnA=;
        b=E0xvVexYT/Fr9x6x0A2nl5t9PcA6T6QNiFW6+QykAjILpxgegvxD6OvQYi9R7iDU13
         4640Mty5ZvNnm5XwAUm8g4U7vSpHVcmf5oHGvKCy6kz2qKnF+ztxAQCVOw+i6thnZxH6
         jgur+OG+ltoEt/PHTIEcbLPnP+7g+iUjOn2ooOI8zQOIhZpRsNS051R18OftkV7HPyiL
         +0O7E+E6HkUAKfkOj/h/ALN2iOQhXAchQx3pGZJq9aynWvnuP1YmIcmRdvgoh1HbHnKl
         l6qJEnPgvEJ9z8AZs65RUNrjeV7/yyH3lpNYHd0ErvDNwrgAcLQmTr7fEMfthRf66bw+
         gD8Q==
X-Forwarded-Encrypted: i=1; AFNElJ9iN5OIK1T9jtGr2Hzyyc1Xp8+cs46KDt6iX5FaxFbCXjiIScdaL4XfeiO73R1AI7TtVmllt2KQw/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUwJEdQ6Sa7XF79znQqMAsYMIaent0rwh1Ep/fYLOK3Ze5SUc
	pGwLf0RLsD1RwuNyahnxcSJ38o2JsYiDiUFWnXdONCaNR23mm5RhI0FJ
X-Gm-Gg: AeBDietFA/qGPyv7vIj1fRHTWWAHJ3Cx6FhI1LE+fqiGSzbvLi+fZLmvlN9LB9jGFef
	MMFQAlNVYI7MRcQerqiw94yJYk3k91VJZFi/QWcUDPyWGi5+PFGWUCZwMmp9YeFf42RwPAuUZCA
	+89saDhOt++OkYnvoR9cPEWn5Q3buvoI2wqbTkx0JWn31vc9aLYpbUKfdyHAy8pBScWh9C4Ij1m
	XmJI3i8hFByv8USVZfLFmBqGeMpk/IKEYRhXrRgUtjwEBeIUyNgqMed+03fYy4qOSIY6oWB4yk7
	Tpc8bFR2VfoJDfI0/ShZ1jDYLcPXKwurIG4jRmFc3kOM8zCmAsfxTVwbe7Q9fpkYdnrNxv0OgOr
	MmbIy7/O7GHCGAjStBzCGU1KJwN8FeC8VIWZCZwTfGx86W19EODPGklSfxdEMKRDrD4ommDhg4K
	tRTD77p57Zpy6sMeFm+wCdXZs9zUefNe4LKWpdFlXKHjHlAM4ngZhQ8RxB25Hj7J/bbEyTSD0ON
	a03RSwz+8rjY4MfQD5u96JUO/emMtPu3Hyqf+9/h4IkWxpVL0A=
X-Received: by 2002:a05:6300:210a:b0:39f:b075:32f with SMTP id adf61e73a8af0-3a08cd4833dmr21613324637.38.1776880767850;
        Wed, 22 Apr 2026 10:59:27 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:48f3:f940:b423:53fc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f9cacasm15174361a12.8.2026.04.22.10.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 10:59:27 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] iio: adc: hx711: refactor to per-chip hx711_chip_info structure
Date: Wed, 22 Apr 2026 23:29:09 +0530
Message-ID: <20260422175910.1258579-3-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422175910.1258579-1-piyushpatle228@gmail.com>
References: <20260422175910.1258579-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce hx711_chip_info to hold per-variant static configuration:
device name, IIO channel spec, channel count, and iio_info pointer.
Store a chip_info pointer in hx711_data and populate indio_dev fields
from it at probe instead of hardcoding them.

Pass trailing pulse count directly to hx711_read() instead of
computing it inside the function, and change hx711_reset_read() to
take a const struct iio_chan_spec * instead of an integer channel
index so callers can pass the full channel descriptor.

Use device_get_match_data() to look up the chip_info from the
of_device_id table. No functional change for existing HX711 users.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
Changes in v3:
- New patch split out from the HX710B support patch.
- Keep this as a standalone refactor for the existing HX711 path.
- Use unsigned int for the channel count and trailing pulse count.
- Use a loop-local unsigned int for the trailing pulse loop.
- Add direct includes for ARRAY_SIZE and basic types.
- Align Kconfig, file header, and module description wording with the
  "HX711 and compatible ADCs" phrasing.

Changes in v2:
- N/A; this standalone refactor patch is new in v3.

 drivers/iio/adc/Kconfig |  7 ++--
 drivers/iio/adc/hx711.c | 92 +++++++++++++++++++++++++++--------------
 2 files changed, 65 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 60038ae8dfc4..f18692aea795 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -784,13 +784,14 @@ config HI8435
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
+	    - HX711
+	  which are used for bridge sensors such as weigh cells.
 
 	  This driver uses two GPIOs, one acts as the clock and controls the
 	  channel selection and gain, the other one is used for the measurement
diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 1db8b68a8f64..a444a2872257 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -1,12 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * HX711: analog to digital converter for weight sensor module
+ * HX711 and compatible ADCs driver for weight sensor modules
  *
  * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
  */
+#include <linux/array_size.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/types.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -76,12 +78,27 @@ static int hx711_get_scale_to_gain(int scale)
 	return -EINVAL;
 }
 
+/**
+ * struct hx711_chip_info - per-variant static configuration
+ * @name: IIO device name
+ * @channels: channel specification
+ * @num_channels: number of channels
+ * @iio_info: IIO info ops for this variant
+ */
+struct hx711_chip_info {
+	const char			*name;
+	const struct iio_chan_spec	*channels;
+	unsigned int			num_channels;
+	const struct iio_info		*iio_info;
+};
+
 struct hx711_data {
 	struct device		*dev;
 	struct gpio_desc	*gpiod_pd_sck;
 	struct gpio_desc	*gpiod_dout;
 	int			gain_set;	/* gain set on device */
 	int			gain_chan_a;	/* gain for channel A */
+	const struct hx711_chip_info *chip_info;
 	struct mutex		lock;
 	/*
 	 * triggered buffer
@@ -92,10 +109,7 @@ struct hx711_data {
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
@@ -139,9 +153,13 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	return gpiod_get_value(hx711_data->gpiod_dout);
 }
 
-static int hx711_read(struct hx711_data *hx711_data)
+/*
+ * Clock out 24 data bits and then send trailing pulses to select the
+ * next channel/gain state.
+ */
+static int hx711_read(struct hx711_data *hx711_data, unsigned int trailing_pulses)
 {
-	int i, ret;
+	int ret;
 	int value = 0;
 	int val = gpiod_get_value(hx711_data->gpiod_dout);
 
@@ -149,7 +167,7 @@ static int hx711_read(struct hx711_data *hx711_data)
 	if (val)
 		return -EIO;
 
-	for (i = 0; i < 24; i++) {
+	for (int i = 0; i < 24; i++) {
 		value <<= 1;
 		ret = hx711_cycle(hx711_data);
 		if (ret)
@@ -158,7 +176,7 @@ static int hx711_read(struct hx711_data *hx711_data)
 
 	value ^= 0x800000;
 
-	for (i = 0; i < hx711_get_gain_to_pulse(hx711_data->gain_set); i++)
+	for (unsigned int i = 0; i < trailing_pulses; i++)
 		hx711_cycle(hx711_data);
 
 	return value;
@@ -213,6 +231,7 @@ static int hx711_reset(struct hx711_data *hx711_data)
 	return val;
 }
 
+/* Select HX711 channel/gain for the next conversion. */
 static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 {
 	int ret;
@@ -221,7 +240,8 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 		if (hx711_data->gain_set == 32) {
 			hx711_data->gain_set = hx711_data->gain_chan_a;
 
-			ret = hx711_read(hx711_data);
+			ret = hx711_read(hx711_data,
+					 hx711_get_gain_to_pulse(hx711_data->gain_set));
 			if (ret < 0)
 				return ret;
 
@@ -233,7 +253,8 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 		if (hx711_data->gain_set != 32) {
 			hx711_data->gain_set = 32;
 
-			ret = hx711_read(hx711_data);
+			ret = hx711_read(hx711_data,
+					 hx711_get_gain_to_pulse(hx711_data->gain_set));
 			if (ret < 0)
 				return ret;
 
@@ -246,27 +267,24 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 	return 0;
 }
 
-static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
+static int hx711_reset_read(struct hx711_data *hx711_data,
+			    const struct iio_chan_spec *chan)
 {
+	unsigned int trailing_pulses;
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
+	ret = hx711_set_gain_for_channel(hx711_data, chan->channel);
 	if (ret < 0)
 		return ret;
 
-	val = hx711_read(hx711_data);
-
-	return val;
+	trailing_pulses = hx711_get_gain_to_pulse(hx711_data->gain_set);
+	return hx711_read(hx711_data, trailing_pulses);
 }
 
 static int hx711_read_raw(struct iio_dev *indio_dev,
@@ -279,7 +297,7 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&hx711_data->lock);
 
-		*val = hx711_reset_read(hx711_data, chan->channel);
+		*val = hx711_reset_read(hx711_data, chan);
 
 		mutex_unlock(&hx711_data->lock);
 
@@ -332,7 +350,8 @@ static int hx711_write_raw(struct iio_dev *indio_dev,
 			if (gain != 32)
 				hx711_data->gain_chan_a = gain;
 
-			ret = hx711_read(hx711_data);
+			ret = hx711_read(hx711_data,
+					 hx711_get_gain_to_pulse(hx711_data->gain_set));
 			if (ret < 0) {
 				mutex_unlock(&hx711_data->lock);
 				return ret;
@@ -368,7 +387,7 @@ static irqreturn_t hx711_trigger(int irq, void *p)
 
 	iio_for_each_active_channel(indio_dev, i) {
 		hx711_data->buffer.channel[j] = hx711_reset_read(hx711_data,
-					indio_dev->channels[i].channel);
+					&indio_dev->channels[i]);
 		j++;
 	}
 
@@ -455,10 +474,18 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+static const struct hx711_chip_info hx711_chip = {
+	.name		= "hx711",
+	.channels	= hx711_chan_spec,
+	.num_channels	= ARRAY_SIZE(hx711_chan_spec),
+	.iio_info	= &hx711_iio_info,
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
@@ -472,6 +499,9 @@ static int hx711_probe(struct platform_device *pdev)
 
 	mutex_init(&hx711_data->lock);
 
+	chip_info = device_get_match_data(dev);
+	hx711_data->chip_info = chip_info;
+
 	/*
 	 * PD_SCK stands for power down and serial clock input of HX711
 	 * in the driver it is an output
@@ -517,6 +547,8 @@ static int hx711_probe(struct platform_device *pdev)
 	hx711_data->gain_set = 128;
 	hx711_data->gain_chan_a = 128;
 
+	indio_dev->info = chip_info->iio_info;
+
 	hx711_data->clock_frequency = 400000;
 	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
 					&hx711_data->clock_frequency);
@@ -533,11 +565,10 @@ static int hx711_probe(struct platform_device *pdev)
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
@@ -554,7 +585,7 @@ static int hx711_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_hx711_match[] = {
-	{ .compatible = "avia,hx711", },
+	{ .compatible = "avia,hx711", .data = &hx711_chip },
 	{ }
 };
 
@@ -571,7 +602,6 @@ static struct platform_driver hx711_driver = {
 module_platform_driver(hx711_driver);
 
 MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
-MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
+MODULE_DESCRIPTION("HX711 and compatible bitbanging ADC driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:hx711-gpio");
-
-- 
2.43.0
