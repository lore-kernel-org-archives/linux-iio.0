Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB8728504D
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778444831; cv=none; b=aGWYJpacDk48Cts6A7tdgB26p+so9E6YNBrLYd2UupcIuqUgDISWneRIm32D46tpdHwUU154IerW9uMyZ239EhibsOiN6zKj3YqmUCs8orjO4SxRLnrnZthHFkheMYZYEypBYnEexNb2UPXPs2zKnj25yDyz4ydc/fZCW/8ebDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778444831; c=relaxed/simple;
	bh=yI719AbpDItm5QLKSF7cXjqJwwvZK5DfBOkIkRgOrVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0woZ4rq+ADIuAGNt+aoJnyrN+1k4l3rzxnr/sydx3uUFkZ6Lv2/gMDv8xQuQa02dq4aH+Rbe2rGA8V/ooH9rVWzDrxMLP8AMrAxIMm5RbnE2fiNmTWK8o5UUlrHVQoBm10WkKWO1GYLo7NKNTY2QLFLfIB4rNZTfxX8CJVSgb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+/HRigZ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+/HRigZ"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8021c8c42fso1340946a12.3
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 13:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778444829; x=1779049629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=op2elmZ9t9E3doPcSF3XGeDi060lHA3vYpa7Xkj8Lag=;
        b=p+/HRigZdIt+ZC08X1h5x+SfJi7EIEMW2KrqEhyMTE+m7D8Pnm/2AVS1nRo7qN2xM4
         xd7Hlu0uUO2tw5norzxYjGTRY285tXVckRRVsMRGwAZ79u1U0Mv81BlJmxSq4dDM9HrI
         ZA+m+tcPWoGWQoaY5Kb9Q7gfK5bfpIsFLUAUaX7xvICo7ScKka5aKalyvf8ldlj04Q0B
         AMEhGC57Xov8sPIwFM1WnBsRh/9CBa2EflzKXgcukbOCzqmGXa3pTZn80mN8p1fKCs+x
         bF7Od2j1uGzN4M9aRwEAr73W87S4o2XPkR/p1oE32D3Vi1GclHB9D9vYvCbXP2rBpntU
         o9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778444829; x=1779049629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=op2elmZ9t9E3doPcSF3XGeDi060lHA3vYpa7Xkj8Lag=;
        b=iSANinOS/+MI63iYwf2j+nvjtqPV9e5Ul1VfNxXVMpQkBVKVwOm58IvyNzXKqyh9WX
         Z/eKc2Vs0s8ZFvXCOzkowXhM3lsUuRMM8CWSDgTYtxEYLZpkLha+WeVi1SGhbKACBXZe
         UXPib38ZP+uvK6edWckLGHEz/wNbUMmOc8hfDPYfb0VC6J3MkDamDFYgXj8Kqwshay3V
         ZAc15Vdq4XIGKxX9HF1OJTMnCpIKoOkRXNNuKRyWkM/6eH+C/NsiWQYmYshx77bzwTC4
         REUPeFxl4CbyU2XpPZJEEp3JlJ78aQ4lerya1nnGi9LI+0o/G23mQuThgK83L2Dr2qJU
         kcEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Z003ju4yzJB80vizIZ0n0+Wcz1sdxEffjJn+TxtyjEaG88UYUGBWGPM7SZ2X8mkKkC7Du9PpMHOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx03vGiXU6ivn9/CeXZlxWGe9xRDmJkyP5a9Av0g1G4GxzlFDVS
	zRPT/T51vUoIbKqNM1SFWEXNV0VyUj7HzGwEesIJIzmtgaAMkd5UyGFc
X-Gm-Gg: Acq92OEL2PzN5QB/vG0iwj3dnqPXNG9fF+HrIen4jk7W/3BWBleIoAFhqqw6308QUR8
	iSXHn+LoFhG0qB7j50TjkFgiQgAYeM3hvUiVP2V9lTtNamAmU6qi4tIgMY8iejJFVAsdOqXKNrQ
	hQm5EUIgSjD2Tzz8tQh7l2iJXEYWnhiq7rblJwiHikwJU9BCvTrS7jQWQeo2XFvEe/g73r2T5Vf
	JQGQBuaksGwJU4ytL6v7fDlAJRpebSW73uafj4F/+QkJkKSB2vRarJquT4gcvEmvLJC3UH048Ro
	/8z5x3m1e5clP6NZRR05YvYVsKAz1KQeeVOWbiaRCjNQPnPeeeKN6V32S5UYw3xsrme/NPdOq5G
	UA+blADaju26wZ+WnAy6QndRlonWOsjtkyATloeQNQOCNKd3BMM6BlZLjBxvutJ807lUw17Z2/5
	9ixiayViombduw/L1wsH4ySx3E6iT4BdqD4vilosovX1XLxjklrlSTwFH2eQzREzzjwBH9pRGUl
	P6fvvoCw7rQQjObA8cIbzSFjE9hLeYilTKpd5VrPWSJNn+TDS2omdExiH+4We+woCQRaD8=
X-Received: by 2002:a05:6a20:734b:b0:3a2:ecb8:56db with SMTP id adf61e73a8af0-3aab17b53dbmr12950078637.40.1778444828682;
        Sun, 10 May 2026 13:27:08 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826767bf53sm7060073a12.6.2026.05.10.13.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 13:27:08 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 11/11] iio: adc: hx711: add support for HX710B
Date: Mon, 11 May 2026 01:56:55 +0530
Message-ID: <20260510202657.38326-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510194947.31997-1-piyushpatle228@gmail.com>
References: <20260510194947.31997-1-piyushpatle228@gmail.com>
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
 drivers/iio/adc/Kconfig |   8 +-
 drivers/iio/adc/hx711.c | 179 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 163 insertions(+), 24 deletions(-)

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
index 860f8ef5a7cf..d96915902108 100644
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
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
+#include <linux/types.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
@@ -84,12 +85,16 @@ static int hx711_get_scale_to_gain(const int *gain_scale, int scale)
  * @channels: channel specification array
  * @iio_info: IIO info ops for this variant
  * @num_channels: number of entries in @channels
+ * @fixed_gain_val: fixed PGA gain (used when @has_fixed_gain is true)
+ * @has_fixed_gain: true if the variant has a fixed ADC gain
  */
 struct hx711_chip_info {
 	const char			*name;
 	const struct iio_chan_spec	*channels;
 	const struct iio_info		*iio_info;
 	unsigned int			num_channels;
+	unsigned int			fixed_gain_val;
+	bool				has_fixed_gain;
 };
 
 struct hx711_data {
@@ -99,14 +104,22 @@ struct hx711_data {
 	int			gain_set;	/* gain set on device */
 	int			gain_chan_a;	/* gain for channel A */
 	int			gain_scale[HX711_GAIN_MAX];
+	int			channel_set;	/* HX710B active channel */
 	const struct hx711_chip_info	*chip_info;
 	struct mutex		lock;
 	/*
 	 * triggered buffer
-	 * 2x32-bit channel + 64-bit naturally aligned timestamp
+	 * up to 3x32-bit channels + 64-bit naturally aligned timestamp
+	 *
+	 * aligned_s64 satisfies the 8-byte alignment requirement for the
+	 * timestamp. For HX711 (at most 2 active channels), iio_push_to_
+	 * buffers_with_timestamp() places the timestamp at offset 8
+	 * (scan_bytes=8, already 8-byte aligned), identical to the original
+	 * 2-channel layout. The extra channel slot for HX710B does not affect
+	 * the HX711 ABI.
 	 */
 	struct {
-		u32 channel[2];
+		u32 channel[3];
 		aligned_s64 timestamp;
 	} buffer;
 	/*
@@ -207,6 +220,7 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
 
 static int hx711_reset(struct hx711_data *hx711_data)
 {
+	const struct hx711_chip_info *info = hx711_data->chip_info;
 	int val;
 	val = hx711_wait_for_ready(hx711_data);
 
@@ -226,8 +240,11 @@ static int hx711_reset(struct hx711_data *hx711_data)
 
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
@@ -283,9 +300,36 @@ static int hx711_set_hx711_channel(struct hx711_data *hx711_data,
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
+	if (hx711_data->channel_set == chan->channel)
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
 
@@ -298,9 +342,16 @@ static int hx711_reset_read(struct hx711_data *hx711_data,
 		return -EIO;
 	}
 
-	ret = hx711_set_hx711_channel(hx711_data, chan, &trailing_pulses);
-	if (ret < 0)
-		return ret;
+	if (info->has_fixed_gain) {
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
@@ -462,6 +513,10 @@ static const struct iio_info hx711_iio_info = {
 	.attrs			= &hx711_attribute_group,
 };
 
+static const struct iio_info hx710b_iio_info = {
+	.read_raw		= hx711_read_raw,
+};
+
 static const struct iio_chan_spec hx711_chan_spec[] = {
 	{
 		.type = IIO_VOLTAGE,
@@ -494,6 +549,68 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
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
@@ -501,6 +618,15 @@ static const struct hx711_chip_info hx711_chip = {
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
@@ -543,32 +669,42 @@ static int hx711_probe(struct platform_device *pdev)
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
@@ -607,6 +743,7 @@ static int hx711_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_hx711_match[] = {
+	{ .compatible = "avia,hx710b", .data = &hx710b_chip },
 	{ .compatible = "avia,hx711", .data = &hx711_chip },
 	{ }
 };
@@ -624,7 +761,7 @@ static struct platform_driver hx711_driver = {
 module_platform_driver(hx711_driver);
 
 MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
-MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
+MODULE_DESCRIPTION("HX711 and compatible bitbanging ADC driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:hx711-gpio");
 
-- 
2.43.0

