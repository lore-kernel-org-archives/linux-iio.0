Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D365038B7C9
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 05:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777441603; cv=none; b=NPmfsEt1fut7GNeQktq7eUwVA0GTWFKgzlNMYNz+oWIDxSmfiR7EJk7Q7LdKDy6fy1GXQ+6qA1McvW+wDgFUQ8hgahOcaees0IOwJSz0Sk8hPrZdGNStKbN8zzVmOeEfvvCCM3IxL7/hQFxL9EVfm4tkA3qsPEqQVbuqowAH8jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777441603; c=relaxed/simple;
	bh=HJW5D//8BqgWA13tKfLLfTLZaoBlMcHxWPtJHqXciO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qj9ROFKnbfDdDX4YYHBz4mZGBWDTy4q2jRyMuwBJg1SjLX+VS9aM+aC8P4r4HkEJYr6ij3Aht7SODlVN0A6yoi7DpuFG+cwE8QxBYCA+r5krl0/0F0qKqx4NyJcer3OPbZeQtfsXb/BrScJIMgbpuJylTEM0u/loZswLKhqKDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+Y4fD2z; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+Y4fD2z"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b2503753efso125511785ad.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 22:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777441601; x=1778046401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8XRdJotgf4uh9lwezR8ax8dhrSr+4NmvcAw2Ol7yFI=;
        b=X+Y4fD2z1g2OiJ+y3JBv6kCKdkIRCZjKKMJiNcliRtIlUK7rUBsseKBnhtLzmMk8+Q
         wNBpB1U/TBewYunMPfWcJ5A35eN0/J+ss+OWDYZ2rpYsgB3IK5vFT7iBDUH3zOFr3YhL
         IUhcFsBHiKy2JO14LKP6NlWFf2YoYZ1znUPDgZEpbrnp8uA+kXVWANNTEiX60AAX5YkZ
         pFX7sKjhLAbO+EO9VYDXPughapEzzEs9N5YLa5bU0nUkdkOeYmtL1Y2R4RVFitfOJSSB
         i9BnO+hWQx/pGKGf7FINolmPZDfNKSJL7gQtiJXxs6Y55nlYgnfWq8/0Hod4yznWVRVO
         f1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777441601; x=1778046401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C8XRdJotgf4uh9lwezR8ax8dhrSr+4NmvcAw2Ol7yFI=;
        b=bZHyVP1YaOHevq+biXkAKa9tZG3eZZX4XdkOgig3hZATdRwyrh5kWWk12aQWyDcGxg
         lqpzHbC/uJ+xPEft9iVVmSM64LDD6oXggk5250RSyDi7tZX2NSwvs+q/nB8l6yAMAD7e
         IJn4dJS8VCpDzK8NVO7/yQDwhfqvo4PwAnXcZVQBv8J83vgTumV95GsVVexVdROZ2OLx
         e41yVWZsGbAzxow+3iZ13k22mN73Jlm/5tuXNcVwG7ch6wbvGN6EtL5TwBxuqVK/ALW+
         llU7saryu8kopu5QsGd1fFkZylBjjwmCCsW1QxpFpfrvy3TOWeciefn7ioeoxfO0Q3H2
         0e7g==
X-Forwarded-Encrypted: i=1; AFNElJ/ShJqrb024XcllWs9andelP5Pg5chbLUOFPJxhu7UmKC18CjnecclsOsTLR8xOU6IAW5Kcyfil+sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYtz6nW51oGyIDF3p9WAkZ/pzpKavkezU4HbRMBMrYT3uTs9CH
	hIKB/1sudkSVsvhsdP4HQmhJnGiy4SEE3ljc6JulO3BGt/Y7tWxZCoLl
X-Gm-Gg: AeBDiet5VeBoi9uG+SMS9eX4x3MDWHCl8yrjZbz6hoNlGISf/tFeCyhLA2gXC8RvCo+
	kbM7suMNqK+2HyHIbyL6TWR2yXaz2OfZ4d7RewNuagdUEzhHt4/ZODOfmLFXXlxpe6a8Z+kcFmo
	JWvCj5LBaJB5Q1H03Fq1OftKjpszoNBrdjKYvzTHf9TCKc/qhDcT5qUeabM1o+cxNW8GvyEwgg5
	VYFA1idxj2QlugiccceUTNxv6gL+4nxxas8ZaCcSyTEzng3Nod2z5IIWjMgGYvGl1BUDyvDENv+
	lP5ukws6sJHfwqLD5wv2A0umq/DsNEIV2WFnPz3e4PbIEefKNlCMyckeJC8ND8GWj1862hBWnCs
	305Ilm4UUGr8niQqc3elMqOYOk45KqqNcrkMcXy9ybqKQBG0TirBh+MniRPswnWNdmx/P7womWe
	cqpuBcyfzM4S+u0Qx16EbvP0Q4DeKCMF3G/1CDUkw7ajzVuhtj+y0jygM+ZH5+h/Ymhnm3MJwmH
	KkLAOaE0UeC7SB9n0cXGeJASTYvsOcWBTWxb3ABGJfqXH7A2A==
X-Received: by 2002:a17:902:d482:b0:2b2:9d60:5eaf with SMTP id d9443c01a7336-2b97c406c53mr65944585ad.6.1777441601148;
        Tue, 28 Apr 2026 22:46:41 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:5fb:20b2:c2f6:85bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98879656dsm9346365ad.25.2026.04.28.22.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 22:46:40 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/11] iio: adc: hx711: add support for HX710B
Date: Wed, 29 Apr 2026 11:15:44 +0530
Message-ID: <20260429054544.123862-12-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429054544.123862-1-piyushpatle228@gmail.com>
References: <20260429054544.123862-1-piyushpatle228@gmail.com>
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
---
Changes in v5:
- Fold the Kconfig help text, file header, and MODULE_DESCRIPTION
  updates into the final new-hardware support patch.
- Add linux/types.h here where the fixed-gain fields become needed.
- Keep a single gain_scale[] path for HX710B instead of introducing a
  separate per-device scale field.
- Add hx711_set_hx710b_channel() alongside the existing HX711 helper and
  update comments and formatting per review.
- Read the HX710B ADC reference from vref-supply and require it in the
  binding instead of describing an implicit AVDD fallback.
Changes in v4:
- Add the third HX710B channel (27 pulses, differential 40 SPS).
- Use .channel = 2 for the supply monitor to avoid the differential-pair
  indexing clash.
- Update channel_set only after both hx711_read() and
  hx711_wait_for_ready() succeed.
- Keep a single fixed-gain scale derived from gain 128.
Changes in v3:
- Add HX710B support on top of the separate hx711_chip_info refactor.
- Keep chan->address for HX710B trailing pulse counts and describe the
  first HX710B channel as a differential IIO channel.
- Use unsigned state where appropriate and verify chip_info layout with
  pahole.
Changes in v2:
- Fix the pulse-count bug by storing trailing pulse counts instead of
  total SCK cycles.
- Add .differential/.channel2 for HX710B input channels.
- Replace the old channel-pulse tests with explicit fixed-gain support.
---
drivers/iio/adc/Kconfig |   8 +-
drivers/iio/adc/hx711.c | 173 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 157 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 60038ae8dfc4..09a1b29fbd9c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -784,13 +784,15 @@ config HI8435
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
index e72f3c2cdbcf..4c087e8b9abf 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * HX711: analog to digital converter for weight sensor module
+ * HX711 and compatible ADCs driver for weight sensor modules
  *
  * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
  */
@@ -9,6 +9,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/types.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -82,12 +83,16 @@ static int hx711_get_scale_to_gain(const int *gain_scale, int scale)
  * @channels: channel specification array
  * @iio_info: IIO info ops for this variant
  * @num_channels: number of entries in @channels
+ * @fixed_gain_val: fixed PGA gain (used when @fixed_gain is true)
+ * @fixed_gain: true if the variant has a fixed ADC gain
  */
 struct hx711_chip_info {
 	const char			*name;
 	const struct iio_chan_spec	*channels;
 	const struct iio_info		*iio_info;
 	unsigned int			num_channels;
+	unsigned int			fixed_gain_val;
+	bool				fixed_gain;
 };
 
 struct hx711_data {
@@ -97,14 +102,16 @@ struct hx711_data {
 	int			gain_set;	/* gain set on device */
 	int			gain_chan_a;	/* gain for channel A */
 	int			gain_scale[HX711_GAIN_MAX];
+	unsigned int		channel_set;	/* HX710B active channel */
 	const struct hx711_chip_info	*chip_info;
 	struct mutex		lock;
 	/*
 	 * triggered buffer
-	 * 2x32-bit channel + 64-bit naturally aligned timestamp
+	 * up to 3x32-bit channels + pad + 64-bit naturally aligned timestamp
 	 */
 	struct {
-		u32 channel[2];
+		u32 channel[3];
+		u32 pad;
 		aligned_s64 timestamp;
 	} buffer;
 	/*
@@ -204,6 +211,7 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
 
 static int hx711_reset(struct hx711_data *hx711_data)
 {
+	const struct hx711_chip_info *info = hx711_data->chip_info;
 	int val;
 
 	val = hx711_wait_for_ready(hx711_data);
@@ -224,8 +232,11 @@ static int hx711_reset(struct hx711_data *hx711_data)
 
 		val = hx711_wait_for_ready(hx711_data);
 
-		/* after a reset the gain is 128 */
-		hx711_data->gain_set = HX711_RESET_GAIN;
+		if (info->fixed_gain)
+			hx711_data->channel_set = 0;
+		else
+			/* after a reset the gain is 128 */
+			hx711_data->gain_set = HX711_RESET_GAIN;
 	}
 
 	return val;
@@ -280,9 +291,36 @@ static int hx711_set_hx711_channel(struct hx711_data *hx711_data,
 	return 0;
 }
 
+/*
+ * Switch the HX710B to the requested channel for the next conversion.
+ * chan->address holds the trailing pulse count (Table 3 in datasheet).
+ * channel_set is updated only after both reads succeed.
+ */
+static int hx711_set_hx710b_channel(struct hx711_data *hx711_data,
+				    const struct iio_chan_spec *chan)
+{
+	int ret;
+
+	if (hx711_data->channel_set == (unsigned int)chan->channel)
+		return 0;
+
+	ret = hx711_read(hx711_data, chan->address);
+	if (ret < 0)
+		return ret;
+
+	ret = hx711_wait_for_ready(hx711_data);
+	if (ret)
+		return ret;
+
+	hx711_data->channel_set = chan->channel;
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
 
@@ -295,9 +333,16 @@ static int hx711_reset_read(struct hx711_data *hx711_data,
 		return -EIO;
 	}
 
-	ret = hx711_set_hx711_channel(hx711_data, chan, &trailing_pulses);
-	if (ret < 0)
-		return ret;
+	if (info->fixed_gain) {
+		ret = hx711_set_hx710b_channel(hx711_data, chan);
+		if (ret < 0)
+			return ret;
+		trailing_pulses = chan->address;
+	} else {
+		ret = hx711_set_hx711_channel(hx711_data, chan, &trailing_pulses);
+		if (ret < 0)
+			return ret;
+	}
 
 	return hx711_read(hx711_data, trailing_pulses);
 }
@@ -459,6 +504,10 @@ static const struct iio_info hx711_iio_info = {
 	.attrs			= &hx711_attribute_group,
 };
 
+static const struct iio_info hx710b_iio_info = {
+	.read_raw		= hx711_read_raw,
+};
+
 static const struct iio_chan_spec hx711_chan_spec[] = {
 	{
 		.type = IIO_VOLTAGE,
@@ -491,6 +540,68 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+/*
+ * HX710B channels (Table 3 in datasheet).
+ * 25 pulses (1 trailing): differential input, 10 SPS -> channel 0
+ * 26 pulses (2 trailing): DVDD-AVDD supply monitor, 40 SPS -> channel 2
+ * 27 pulses (3 trailing): differential input, 40 SPS -> channel 3
+ * .address stores the trailing pulse count for hx711_set_hx710b_channel().
+ * Channel 2 is used for the supply monitor to avoid aliasing the
+ * channel2 terminal of the first differential pair.
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
+		.channel = 2,
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
+	{
+		.type = IIO_VOLTAGE,
+		.differential = 1,
+		.channel = 3,
+		.channel2 = 4,
+		.indexed = 1,
+		.address = 3,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 2,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 24,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
 static const struct hx711_chip_info hx711_chip = {
 	.name		= "hx711",
 	.channels	= hx711_chan_spec,
@@ -498,6 +609,15 @@ static const struct hx711_chip_info hx711_chip = {
 	.num_channels	= ARRAY_SIZE(hx711_chan_spec),
 };
 
+static const struct hx711_chip_info hx710b_chip = {
+	.name		= "hx710b",
+	.channels	= hx710b_chan_spec,
+	.iio_info	= &hx710b_iio_info,
+	.num_channels	= ARRAY_SIZE(hx710b_chan_spec),
+	.fixed_gain_val	= 128,
+	.fixed_gain	= true,
+};
+
 static int hx711_probe(struct platform_device *pdev)
 {
 	const struct hx711_chip_info *chip_info;
@@ -540,32 +660,42 @@ static int hx711_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(hx711_data->gpiod_dout),
 				     "failed to get dout-gpiod\n");
 
-	ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
+	if (chip_info->fixed_gain)
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
+	if (chip_info->fixed_gain) {
+		for (i = 0; i < HX711_GAIN_MAX; i++)
+			hx711_data->gain_scale[i] =
+				ret / chip_info->fixed_gain_val / 1678;
+		hx711_data->gain_set = chip_info->fixed_gain_val;
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
@@ -604,6 +734,7 @@ static int hx711_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_hx711_match[] = {
+	{ .compatible = "avia,hx710b", .data = &hx710b_chip },
 	{ .compatible = "avia,hx711", .data = &hx711_chip },
 	{ }
 };
@@ -621,6 +752,6 @@ static struct platform_driver hx711_driver = {
 module_platform_driver(hx711_driver);
 
 MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
-MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
+MODULE_DESCRIPTION("HX711 and compatible bitbanging ADC driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:hx711-gpio");
-- 
2.43.0
