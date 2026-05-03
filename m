Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64BF3AE715
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810274; cv=none; b=HqSTQki4dOPrh/8PFmnlBw5/QSrmpDdWSOjEAIb0MmSStlkBJck22BhygfPaYErcvrPJTejRwlgmY5D62mLpGY5YOVCmdbl1pS2+VuZQY1Yeobwa2n5/4/wNx6MyCHkcRG2/skb3moCRz+1mEvfZ0KHpDht1rhMu2lAfbFd1Gqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810274; c=relaxed/simple;
	bh=N82Yi/e7uUe+pLWe5IjlXgxLwWAl3x++VD8GG3fQv1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+LZ0Ps9iLm4qUcI88i3gWVjOx5XnCSzXqRpToGksje1L0KAYui+cFwzczab1gpp3HOQcwmT1wcfYZbIxVb9T6cYV4kNZHM+EnGSisBb7l1jfyzozlJsdgTGn4nFd7JHwX47hOej1/1vgDyg8VKItPC2O/fewh9EfXSc25pf/jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLOE603a; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLOE603a"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8367df48711so63107b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 05:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777810272; x=1778415072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8dA9hQTpudJ+CMWQF2MubPcmNSnd9Pje7EvUY+7Oyo=;
        b=YLOE603aj/a+EmhIPzK9q8w/+Jrwb1B5UpYeRh0FYZhIP7I9U7yor4+au8VqXSt/85
         t0jqYqn6mJ+M3HCXyDPAv2sS3ydG5N4JkZHF6z7BJTqkZdVyM1YJEHqTWjeoJdutq1Rd
         Qy6pscBJOURhbrejsyc021ZlYRIxpelgSIzgo16Bsl/a3KL8otajdy3HPL2RWs0WHQbe
         k1gUs74jlZ8kXlKEB7ZcHHleyIbKhzinXyeWlCx8daeG/V09FclcRQOMRWDImG7EWrMT
         PfKqFLZYh8XbCGv8IQNgChBKQWcHwzVdm6VXRQQJ6ZhiLsE8MbVbY3nEvewKx3xTviac
         Y8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777810272; x=1778415072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y8dA9hQTpudJ+CMWQF2MubPcmNSnd9Pje7EvUY+7Oyo=;
        b=PSPYzVRvTogAEX845CxAOEqNFOEP24lrDubgr1C+e1/RPB0903uOMF5uV/Tf46h7nu
         CYdMiQXenEpBJyDtOVwquP+HcxHAefLQA53xhv3LE4U/GJi492+c6jscMOBRuLR4KOid
         e7oJ2zMQpYM6PaaxoCadpj2D1dKsTGF3tirCloT4nMJoMkM3w2jyw2oAPhMLnlNAV3qB
         PIiOfVTCAxA4zCG6uEaQW1vr6LcYKTZ60RK3XDdVcQofXpndNuD5zzJQ6zhw5jwVOMcX
         FmR796ERNMNocuohXFgmCmd0rVQjCc3O9MN6chGCJYLGTboIs2PtP9EpkH5ZrN0c9Mg1
         pbBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+PKQX7I17fAsc5LV9AA74Ap4E2OznNZU3VMfnTY5dcXPcWodpX0AfXdkyAyjis6xzMgR3a2ZrULWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYjOwxBISlvV6h9ekevhRoUpbuL6aJKqSKuHqZEd3neVKm1IzC
	AzCTkWiYDjX8wnEjl5N165I3sA9cJZkNshHbPW2O1oIEX3XKitdn/jlYoVvSew==
X-Gm-Gg: AeBDietym+kEBLbtvnPqz5AQ+PwoYLjGuCnfMmZkmGVIz2io+NJjxFqxTrZ56+v6iMj
	Pap5lUrdwx1BUDjz/pjBXKsr2Rtxq/0Fbi8YLuP7KGjpPBfEPgrQLbfz35Ph5Xaszo+4++9JIkl
	CK7VmeaF4XLG1WzWOHQcIbSBTPJPaPQolZ2ahWcc85iGP3lRrWM4JMLNTfETfFS9m2y9kOYy32J
	jX/Lo/2TCalQTrASIJVIAr4FK66HbtwGANGPtbQI2zLmV6rSqnXBc76HG7WGy9MQRu8pjgUJ0q3
	TNbzczzNLtxD6k4ITIZZWn/VauMnPCQR311gW9xKnT53bQQt8pKv6K/ojhhH60F03mPYn0KeUMd
	sXuC3YhZyokaKSBlGLptliVaedB9nED+riTAick5TbwgUnkMBQhaJZWxXHtrWW0Stb3aZe+w8m0
	c2EKTX/rklNwQ/tiy4USowYq3vre0IsCGK/GcU99JghmVjVFEL+XZkNvsvVCoM93pARklKR0OjD
	+DLoBEddssdVwyOmLNhXeN/UktjbPwgWVHVEX7HtXpTeiOO1YN5ThMLd7ddVn+yx8v2tGU=
X-Received: by 2002:a05:6a00:80e:b0:82f:b519:a5d0 with SMTP id d2e1a72fcca58-8352d24d68emr5786337b3a.39.1777810272216;
        Sun, 03 May 2026 05:11:12 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8357c4f4530sm1474364b3a.9.2026.05.03.05.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 05:11:11 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/11] iio: adc: hx711: add support for HX710B
Date: Sun,  3 May 2026 17:39:40 +0530
Message-ID: <20260503120949.80292-12-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260503120949.80292-1-piyushpatle228@gmail.com>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
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
index 2229df17f350..521244bd6a7b 100644
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
@@ -83,12 +84,16 @@ static int hx711_get_scale_to_gain(const int *gain_scale, int scale)
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
@@ -98,14 +103,16 @@ struct hx711_data {
 	int			gain_set;	/* gain set on device */
 	int			gain_chan_a;	/* gain for channel A */
 	int			gain_scale[HX711_GAIN_MAX];
+	int			channel_set;	/* HX710B active channel */
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
@@ -207,6 +214,7 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
 
 static int hx711_reset(struct hx711_data *hx711_data)
 {
+	const struct hx711_chip_info *info = hx711_data->chip_info;
 	int val;
 
 	val = hx711_wait_for_ready(hx711_data);
@@ -227,8 +235,11 @@ static int hx711_reset(struct hx711_data *hx711_data)
 
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
@@ -283,9 +294,36 @@ static int hx711_set_hx711_channel(struct hx711_data *hx711_data,
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
 
@@ -298,9 +336,16 @@ static int hx711_reset_read(struct hx711_data *hx711_data,
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
@@ -462,6 +507,10 @@ static const struct iio_info hx711_iio_info = {
 	.attrs			= &hx711_attribute_group,
 };
 
+static const struct iio_info hx710b_iio_info = {
+	.read_raw		= hx711_read_raw,
+};
+
 static const struct iio_chan_spec hx711_chan_spec[] = {
 	{
 		.type = IIO_VOLTAGE,
@@ -494,6 +543,68 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
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
@@ -501,6 +612,15 @@ static const struct hx711_chip_info hx711_chip = {
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
@@ -543,32 +663,42 @@ static int hx711_probe(struct platform_device *pdev)
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
@@ -607,6 +737,7 @@ static int hx711_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_hx711_match[] = {
+	{ .compatible = "avia,hx710b", .data = &hx710b_chip },
 	{ .compatible = "avia,hx711", .data = &hx711_chip },
 	{ }
 };
@@ -624,6 +755,6 @@ static struct platform_driver hx711_driver = {
 module_platform_driver(hx711_driver);
 
 MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
-MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
+MODULE_DESCRIPTION("HX711 and compatible bitbanging ADC driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:hx711-gpio");
-- 
2.43.0

