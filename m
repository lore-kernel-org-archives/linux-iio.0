Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080DE39D6FC
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880774; cv=none; b=RnxIgMUK6Hui8OjbIolywwN4+RpeCgb7wMy7QrE0AuASlsuEZR5REgm+IATHIl8yrY66R4rjjcD1M8oAHFncqGMCVjNVUzYOH7DsYCkgId44BM2ByDIYOB85NIERimG390WMMu/wGPVrafGwlNesafcrMdYrzU9yErrO/KsBxfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880774; c=relaxed/simple;
	bh=PWslvnIp0PlT6M3bafPFkQXf9mBHZUb6tesc0Bm/FCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A618EDm2QpDm96IFqq+2SLtr/+N9Auk1WgJ7zfCbqOF9A8hQ8UJrZ6ZeOkKJo0j+cEnManHc53gfcR/bi7KjwPm1Kr3bIWYYkMFP6ziIeOmDy2r2i0pjHFmNYewELaVDtZ8ZUiILNj8xBf1A8hwmhuhUfCZEe6Z4pAoy6DdRNbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URNEOucW; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URNEOucW"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so3560266a12.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776880772; x=1777485572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0Mpiw2CDpaBtsNVKYQKb60LEod4FHSPV4DukqsY4eg=;
        b=URNEOucWcBJHREiTPO/1S78/wHVj9APS/uwhjpD1zDFxPXxpv+/OV7oEbU0gTgibf8
         x3/5gmSI8C0ATWVWMwS/MSHSykBKsUAa96Nx4S+7bkQTDTqGvGEeL+c1XN/T8yUVMSu1
         sJ5E7YiyYkIAYYC1zB/aR/ZxQEAGEzyC+wr9RT2Ls+uZ+as5RWMKj25M3W5cGthdlRXX
         2UQyf8uzLYeiCMyaxywswX7tNP6F406MCocU19MgCcB1ZnSDBhan59kgLSIA+Nrgk1NJ
         Mk72A7P76Bh9zRzmdU/sIj9uwDlMzBHkHF8RUKAQ17IZFeaMTvSKmy11Yel0taDtXFUT
         R1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776880772; x=1777485572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0Mpiw2CDpaBtsNVKYQKb60LEod4FHSPV4DukqsY4eg=;
        b=tQ/CdQHnSC5DPdZxb7+X/DI0W1xrb/QVQDuTNMUqsOun23Ui1h7Vp95nJoZR3DpUZ0
         6y4Vz1GxBpT68lPQr7TwUKl7SdcPxrRiSUNLCq8GQd4c/VWYq7Z4fe5Kzr9KgThxR2vs
         uwUGPQ7Iw9sLZFE4orrFtOrLeN3OiakOnO59qM0bdD42OFleSxpkHhaprOiEiZfvcaIR
         ETTPvvRvtuengVAWczmEMLQUCUbbgZompjZr3WWvWMMo81ILkiZO3z0EapUa6ed4C9zX
         0WKfknznxD1BIcDknlh9trZjVlM0fYpSZGQc631/wBoGbm9eO0wxuEtxQeIHj9grP+U2
         n6zQ==
X-Forwarded-Encrypted: i=1; AFNElJ/n4njAIevI/kRH/Za1HXzMnQyK8zPUqst05qRNAadmdaP2A34wnVtKkZT4pCWl2XuimWAr26gDFkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzenOEF+q6u5ETSgLYQhurK20eAHX34MXrS3Io9qB3YskX7BLt8
	kZ+EJf966oqEY15G81GvMmDic868Rzp6FOYqaPNt3NV24NSFuQpqN9lo
X-Gm-Gg: AeBDievVTHdM56x7gRRltLVuxy+3KWPH6CDKkSuSQhb6eSdow4oxPLJ3c/vIlYD9Fpu
	r4uhlouz7jNmwyW71oOsy17nD8vGuLm3kJMyCOUmFoSJ0nVu5WmwnlbbJLv0PR1Zr4risxJbtXH
	f9Rus973Pibzz4/XzaQmvmJOiIH6BnK3ONcwlNn4JM1XdEf19IWUAtH3a9VntHbaEpV/Op3/L7S
	G1VzcYFqn70+XfJfeUkmbTU7GacxZqRkdN/TDVjy7p9O4B0Jttgf9sHMOiiFjRghZZ8HW2Bn+Mn
	wnVQ+CqQw/BMa+gWF9WAwkJscLxBAfVLDPmIpwPNxzBdJeOaxp7TwYuIW4TVxFr5E5rK6dCtmcQ
	rtrm5BO+H2TcoRJ1V/0u6bvm83jByhUoYySt+HMaxNmoQNq+qnCDDXhvhTmeh/uC0ek4ubCRqdS
	tQ9uer2mLpWrjaacobLLvEaze4NqEyA2riLGjUDR7ZAKGG4MTDFMBWsAo6HUuVNphU1+b/J9ViS
	Dt994jVNhGV5NZK/LyGdZKYzHHX/S52hsv9XOJZfmHtIjy5jOs=
X-Received: by 2002:a05:6a20:3d19:b0:3a2:d838:bfdb with SMTP id adf61e73a8af0-3a2d8393b61mr14140642637.29.1776880772239;
        Wed, 22 Apr 2026 10:59:32 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:48f3:f940:b423:53fc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f9cacasm15174361a12.8.2026.04.22.10.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 10:59:31 -0700 (PDT)
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
Subject: [PATCH v3 3/3] iio: adc: hx711: add support for HX710B
Date: Wed, 22 Apr 2026 23:29:10 +0530
Message-ID: <20260422175910.1258579-4-piyushpatle228@gmail.com>
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

Add support for the AVIA HX710B ADC, which shares the HX711 GPIO
interface but has a fixed gain of 128 and uses trailing PD_SCK pulses
to select between the differential input and the DVDD-AVDD supply
monitor.

Model the HX710B with its own channel specification and iio_info.
Store the HX710B trailing pulse counts in chan->address and add
fixed-gain handling so the HX711 selectable-gain path remains
separate from the HX710B fixed-gain path.

The HX710B datasheet documents a single fixed PGA gain of 128 and
does not provide configurable gain selection like the HX711.

Order hx711_chip_info as pointers first, then unsigned int fields, then
bool. pahole then reports no internal holes in the structure; the
remaining padding is tail padding from 8-byte alignment.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
Changes in v3:
- Add HX710B support on top of the separate hx711_chip_info refactor.
- Update channel_set only after hx711_read() and hx711_wait_for_ready()
  both succeed.
- Keep a single HX710B fixed-gain scale based on the datasheet's fixed
  PGA gain of 128; do not apply the HX711 channel-B gain of 32 to the
  HX710B supply monitor path.
- Use unsigned int for channel state and fixed-gain scale storage.
- Keep HX710B trailing pulse counts in chan->address.
- Describe HX710B channel 0 as a differential IIO channel.
- Reorder hx711_chip_info fields based on pahole output so the
  structure has no internal holes.

Changes in v2:
- Fix pulse count bug: HX710B values were {25, 26} total SCK cycles;
  corrected to {1, 2} trailing pulses because hx711_read() already
  clocks the 24 data bits.
- Add .differential = 1 and .channel2 = 1 to HX710B channel 0.
- Move trailing pulse counts from a separate array to chan->address.
- Replace chan_pulse_count tests with a dedicated fixed_gain flag.
- Add fixed_gain_val to hx711_chip_info.
- Add the iio_info pointer to hx711_chip_info and assign
  indio_dev->info from chip_info.
- Remove the NULL check after device_get_match_data().
- Remove reset_channel from hx711_chip_info.
- Change hx711_reset_read() and hx710b_set_channel() to take
  const struct iio_chan_spec *.
- Revert unrelated hx711_data struct member alignment noise.
- Sort of_device_id entries alphabetically.
- Expand the commit message to explain HX711 versus HX710B trailing
  pulse behaviour.
- Restore the file header to mention weight sensor modules.

 drivers/iio/adc/Kconfig |   1 +
 drivers/iio/adc/hx711.c | 134 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 120 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f18692aea795..09a1b29fbd9c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -790,6 +790,7 @@ config HX711
 	select IIO_TRIGGERED_BUFFER
 	help
 	  If you say Y here you get support for the following AVIA ADCs:
+	    - HX710B
 	    - HX711
 	  which are used for bridge sensors such as weigh cells.
 
diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index a444a2872257..d7050bec53b4 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -82,14 +82,18 @@ static int hx711_get_scale_to_gain(int scale)
  * struct hx711_chip_info - per-variant static configuration
  * @name: IIO device name
  * @channels: channel specification
- * @num_channels: number of channels
  * @iio_info: IIO info ops for this variant
+ * @num_channels: number of channels
+ * @fixed_gain: true if the variant has a fixed ADC gain (e.g. HX710B)
+ * @fixed_gain_val: the fixed gain value used to compute scale (when fixed_gain)
  */
 struct hx711_chip_info {
 	const char			*name;
 	const struct iio_chan_spec	*channels;
-	unsigned int			num_channels;
 	const struct iio_info		*iio_info;
+	unsigned int			num_channels;
+	unsigned int			fixed_gain_val;
+	bool				fixed_gain;
 };
 
 struct hx711_data {
@@ -98,6 +102,8 @@ struct hx711_data {
 	struct gpio_desc	*gpiod_dout;
 	int			gain_set;	/* gain set on device */
 	int			gain_chan_a;	/* gain for channel A */
+	unsigned int		channel_set;	/* HX710B current channel */
+	unsigned int		scale;		/* HX710B fixed scale */
 	const struct hx711_chip_info *chip_info;
 	struct mutex		lock;
 	/*
@@ -206,6 +212,7 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
 
 static int hx711_reset(struct hx711_data *hx711_data)
 {
+	const struct hx711_chip_info *info = hx711_data->chip_info;
 	int val = hx711_wait_for_ready(hx711_data);
 
 	if (val) {
@@ -224,8 +231,11 @@ static int hx711_reset(struct hx711_data *hx711_data)
 
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
@@ -267,9 +277,32 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 	return 0;
 }
 
+/* Select HX710B channel for the next conversion. */
+static int hx710b_set_channel(struct hx711_data *hx711_data,
+			      const struct iio_chan_spec *chan)
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
 	unsigned int trailing_pulses;
 	int ret;
 
@@ -279,11 +312,18 @@ static int hx711_reset_read(struct hx711_data *hx711_data,
 		return -EIO;
 	}
 
-	ret = hx711_set_gain_for_channel(hx711_data, chan->channel);
-	if (ret < 0)
-		return ret;
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
 
-	trailing_pulses = hx711_get_gain_to_pulse(hx711_data->gain_set);
 	return hx711_read(hx711_data, trailing_pulses);
 }
 
@@ -292,6 +332,7 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
 				int *val, int *val2, long mask)
 {
 	struct hx711_data *hx711_data = iio_priv(indio_dev);
+	const struct hx711_chip_info *info = hx711_data->chip_info;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -308,7 +349,10 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		mutex_lock(&hx711_data->lock);
 
-		*val2 = hx711_get_gain_to_scale(hx711_data->gain_set);
+		if (info->fixed_gain)
+			*val2 = hx711_data->scale;
+		else
+			*val2 = hx711_get_gain_to_scale(hx711_data->gain_set);
 
 		mutex_unlock(&hx711_data->lock);
 
@@ -442,6 +486,10 @@ static const struct iio_info hx711_iio_info = {
 	.attrs			= &hx711_attribute_group,
 };
 
+static const struct iio_info hx710b_iio_info = {
+	.read_raw		= hx711_read_raw,
+};
+
 static const struct iio_chan_spec hx711_chan_spec[] = {
 	{
 		.type = IIO_VOLTAGE,
@@ -474,6 +522,48 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
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
 static const struct hx711_chip_info hx711_chip = {
 	.name		= "hx711",
 	.channels	= hx711_chan_spec,
@@ -481,6 +571,15 @@ static const struct hx711_chip_info hx711_chip = {
 	.iio_info	= &hx711_iio_info,
 };
 
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
@@ -540,12 +639,16 @@ static int hx711_probe(struct platform_device *pdev)
 	/* we need 10^-9 mV */
 	ret *= 100;
 
-	for (i = 0; i < HX711_GAIN_MAX; i++)
-		hx711_gain_to_scale[i].scale =
-			ret / hx711_gain_to_scale[i].gain / 1678;
+	if (chip_info->fixed_gain) {
+		hx711_data->scale = ret / chip_info->fixed_gain_val / 1678;
+	} else {
+		for (i = 0; i < HX711_GAIN_MAX; i++)
+			hx711_gain_to_scale[i].scale =
+				ret / hx711_gain_to_scale[i].gain / 1678;
 
-	hx711_data->gain_set = 128;
-	hx711_data->gain_chan_a = 128;
+		hx711_data->gain_set = 128;
+		hx711_data->gain_chan_a = 128;
+	}
 
 	indio_dev->info = chip_info->iio_info;
 
@@ -585,7 +688,8 @@ static int hx711_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_hx711_match[] = {
-	{ .compatible = "avia,hx711", .data = &hx711_chip },
+	{ .compatible = "avia,hx710b", .data = &hx710b_chip },
+	{ .compatible = "avia,hx711",  .data = &hx711_chip  },
 	{ }
 };
 
-- 
2.43.0
