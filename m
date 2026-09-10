Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F30F42AFB2
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074899; cv=none; b=hMAWM3bIanLXAAev9GhRbiobOCS4NIq1BoP88mwibsIEENUIZuzwe1Uwqqa0m107v4sA8FJdxhlnovllqCzqizYZrKcT24aBZ8sCh3Z2ooGYsAJEo6rzoFTsykcfD2BKsROdMiDTIrEM32IMa7UvBMIAjHWWkUJQGqKOu6gCIbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074899; c=relaxed/simple;
	bh=kzUgSvXLi/JZDSr/vK2K0UNxNU3aymUYqEPICh6L/8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y4g/8eIVNQ4IRWE1HHZ/uGeF/K36WfGanRiezWAL0znCiD/VOJPHuNev/lbyzQe43ndmzj2JPIsGB2bk5OtDVS3yG66rXrL2XcIJe/E9fuu4CSjeSlDycEBtXne6FqmaY++hM7U+uvlGdkJKLkVvH9n2fGJeeZtyxn9s6CxpnEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZTlyE/tw; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZTlyE/tw"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4b28db31b89so212382b6e.1
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 14:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789074882; x=1789679682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y9MeiO0bVEuDB8kWxbVFOe6+2iOBgBAXWqHDeoInBkU=;
        b=ZTlyE/twMbdFct47+M2nFaGDRrpFV+FoRfrctctO4OTdFxYw5U6Pkquen6DAQ1VABc
         Kc/uAeWwodec+W7QoCqiPUpfwgQsya6GWRbJscVtJmVu231ktxx0+ZNIOlLfQRa8WXuE
         xf7VfHOhxdbOJpTMZMNOSXfqYKF2k4ViZ3auHoQ0rf+tUvJ5uirTscZsI7MBHep6b4l0
         8dulKqrlkE5ol0oD6ORFfHSzxaG5y3oYXHyLcda7OIixYrLF+Kq0Lmp/vs6ibCPhIVur
         zK+23ZwraRcCfcsMn+07Wk6aQOr6cc+ksfJADq0N1j7JaW89S5ML/pn417MjmuNFbL1k
         hgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074882; x=1789679682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y9MeiO0bVEuDB8kWxbVFOe6+2iOBgBAXWqHDeoInBkU=;
        b=NYr+2E5RdM/iQCjyM7O9fSm6BN/fpKhzxDV54uxw6KeV9TNGUBesCb6/cdg3tyMm/E
         JbiQjbth2IVjzcDjapYq0opMRPK7jU3CeCGjzkxHBIbYDBdsMLdalvZPnGe2rYPMO+FI
         Me/PhCMfZVpdCDuKLlNz9E4Z/fUt6kouK2gt9fOngPwUdVvMRbzf6X6yhR0ByMetGMeS
         /1n6FwPK2kVdu9B+zbwUViiZRJBx/SOcxh1wm8UWaxV9XUxFszTyBlQQQUgtqcivSP8P
         XsoNCf0yzMsF564n5h1WKRu9BoWD2ob0hZhH71VwL37tUuD5FQA6f4kjFm5ipBPtrud7
         6zqw==
X-Forwarded-Encrypted: i=1; AKwUvBztuZOcidKvZ1LmvhK/XAklFT0daGgd+mdmnpwqgFRNOXqYGSnx5JnbcFSs+YY1SetrOfuaJiB3nNo=@vger.kernel.org
X-Gm-Message-State: AFuF++n2bthVVTg0fX87718N8lpGw+lW8CF9o8LTdEITTlkmOWEXvfLK
	oIQcp6s7j1VabZ0Eu3Igr7tvL7/p6OzZV9lGy3tO86MBhYIrqLhtatfRaVNcc9JPtS4=
X-Gm-Gg: AYBFou2sJE7OzwnhBi9Mmgl+MTXeTriUQ1NKz2sFNPj0KFiwPgbmbxgtO7kpxNT2Hfx
	1X4nAcJNh4eCgVNILQLJ65Ite2LqCVBWz/6/MQ7aR+HxqSPstCe7diC2OlHx5ONMWJrjoOn3Zmr
	xocJlPc5BvyvqfE2jGuI5jeu0hRI9IoCSnRrPefODD5l0VIk/fVcJVPStqXROA2HrsWPW1hq5ZB
	TsAF2B2KAT1GsVQTavowVSU3s/lpPuz1ePuzbk3K0WBjdbLtkL79m8irGZSa6zxZ1bd1PG+SEn8
	J3xhHsSl9OmanJH+74fQ4jqR2QocomPmapu14svz/f4zBReMsPPGhaCeZkvTpZQEWrUh/EWhmhO
	2PBC9cOdIoQQHIszSwouCiSUDmsbzeF5S059sE+dvOTF3bfK7FJmZ23QMbyxG6eCNIqWCfj55cN
	XFvCJEAt6XUO//KP5tas7v4Iigg0s+7xn6ACoJhi/La2yLFMOb+gT66WlbolqBLo0rXrBns7jC0
	lm4
X-Received: by 2002:a05:6808:1b21:b0:4b9:e6ab:d083 with SMTP id 5614622812f47-4c31fdda3admr617829b6e.35.1789074881757;
        Thu, 10 Sep 2026 14:14:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fbf1:d0da:69e0:11a0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c330daa42esm347315b6e.4.2026.09.10.14.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:14:40 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Thu, 10 Sep 2026 16:13:06 -0500
Subject: [PATCH v3 07/10] iio: adc: ti-ads112c14: add filter support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-iio-adc-ti-ads112c14-filter-support-v3-7-e5a9b27ddb1a@baylibre.com>
References: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
In-Reply-To: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=26453;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=kzUgSvXLi/JZDSr/vK2K0UNxNU3aymUYqEPICh6L/8A=;
 b=kA0DAAoBwswgAf8Bj8AByyZiAGqjHZqidk7BswbXJcKGkXbD6N+wPO+j3gQin6XNWurkTJbcS
 4kBMwQAAQoAHRYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJqox2aAAoJEMLMIAH/AY/AQmgH/Aqd
 2zP6O+aXGGHNs7bjl0sgCQ2FCQU7z1fy8WziG3xc3IH5clXzpSfB06ru1zKSlBOi5Y6paX8F6Xk
 EgLUmXbBvdp7Y8tVJfmNuB86Ft/fbrDMYH6SYaXSgaxe0JnS0x3MbmJer/Yfz/JXiBEpszG1+Ym
 TbVoZUBTYKxlw3xne/jrCZ6RWVMYTWiHDvdYilpZC1rBdqfp8hKk7YScnLt3EdWgGnp3a85xaAc
 W3AGwv8/G1ZHUONhdlRDUIFQPjaglY/htXU8knW8e1lZLLm86zAnm/tCv/HfxHp8+9N6i+AmHzP
 iR3CxehO8go+znX3vMKKVw9TvVHIy1mAYqcFg24=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for filter_type, oversampling_ratio and sampling_frequency
attributes to the ti-ads112c14 driver.

On these chips, these three controls are interdependent and the
SPEED_MODE register value has a different meaning depending on the
filter type, which makes the interactions a bit complex. As such, the
expectation is that the user will set the filter type first, then
depending on the filter type, either set the oversampling ratio or the
sampling frequency and finally the other of these two.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---

Note: I intend to sumbit a documentation patch later that explains the
"right way" to set these three attributes since it is a bit odd due to
the conditional interdependencies.
---
 drivers/iio/adc/ti-ads112c14.c | 496 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 483 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 0e4584b4675e..ee4992b9e029 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -94,6 +94,14 @@
 #define   ADS112C14_DATA_RATE_CFG_DELAY			GENMASK(7, 4)
 #define   ADS112C14_DATA_RATE_CFG_GC_EN			BIT(3)
 #define   ADS112C14_DATA_RATE_CFG_FLTR_OSR		GENMASK(2, 0)
+#define     ADS112C14_DATA_RATE_CFG_FLTR_OSR_16		  0
+#define     ADS112C14_DATA_RATE_CFG_FLTR_OSR_32		  1
+#define     ADS112C14_DATA_RATE_CFG_FLTR_OSR_128	  2
+#define     ADS112C14_DATA_RATE_CFG_FLTR_OSR_256	  3
+#define     ADS112C14_DATA_RATE_CFG_FLTR_OSR_512	  4
+#define     ADS112C14_DATA_RATE_CFG_FLTR_OSR_1024	  5
+#define     ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS	  6
+#define     ADS112C14_DATA_RATE_CFG_FLTR_OSR_20SPS	  7
 
 #define ADS112C14_REG_MUX_CFG				0x07
 #define   ADS112C14_MUX_CFG_AINP			GENMASK(7, 4)
@@ -183,6 +191,43 @@ static const u32 ads112c14_pga_gains_x10[] = {
 
 #define ADS112C14_INTERNAL_CLK_Hz 4096000
 
+/* Index corresponds to first 2 ADS112C14_DATA_RATE_CFG_FLTR_OSR values. */
+static const int ads112c14_sinc4_osr_available[] = {
+	16, 32
+};
+
+/* Index corresponds to next 4 ADS112C14_DATA_RATE_CFG_FLTR_OSR values. */
+static const int ads112c14_sinc4_sinc1_osr_available[] = {
+	128, 256, 512, 1024
+};
+
+/* Index corresponds to ADS112C14_DEVICE_CFG_SPEED_MODE value. */
+static const int ads112c14_sinc4_sinc1_pf1_20sps_osr_available[] = {
+	1600, 12800, 25600, 51200
+};
+
+/* Index corresponds to ADS112C14_DEVICE_CFG_SPEED_MODE value. */
+static const int ads112c14_sinc4_sinc1_pf1_25sps_osr_available[] = {
+	1280, 10240, 20480, 40960
+};
+
+/* Index corresponds to ADS112C14_DEVICE_CFG_SPEED_MODE value. */
+static const int ads112c14_fmod_div[] = {
+	128, 16, 8, 4
+};
+
+enum ads112c14_filter_type {
+	ADS112C14_FILTER_TYPE_SINC4,
+	ADS112C14_FILTER_TYPE_SINC4_SINC1,
+	ADS112C14_FILTER_TYPE_SINC4_SINC1_PF1,
+};
+
+static const char * const ads112c14_filter_type_names[] = {
+	[ADS112C14_FILTER_TYPE_SINC4] = "sinc4",
+	[ADS112C14_FILTER_TYPE_SINC4_SINC1] = "sinc4+sinc1",
+	[ADS112C14_FILTER_TYPE_SINC4_SINC1_PF1] = "sinc4+sinc1+pf1",
+};
+
 #define ADS112C14_I2C_CRC8_POLYNOMIAL 0x07
 DECLARE_CRC8_TABLE(ads112c14_crc8_table);
 
@@ -204,6 +249,8 @@ enum {
 	ADS112C14_SYS_MON_CHANNEL_SHORT,
 };
 
+static const struct iio_chan_spec_ext_info ads112c14_ext_info[];
+
 static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
 	{
 		.type = IIO_TEMP,
@@ -212,7 +259,12 @@ static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
 		.address = 2,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
 				    | BIT(IIO_CHAN_INFO_SCALE)
-				    | BIT(IIO_CHAN_INFO_OFFSET),
+				    | BIT(IIO_CHAN_INFO_OFFSET)
+				    | BIT(IIO_CHAN_INFO_SAMP_FREQ)
+				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ)
+				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.ext_info = ads112c14_ext_info,
 	},
 	{
 		.type = IIO_VOLTAGE,
@@ -220,7 +272,12 @@ static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
 		.channel = ADS112C14_SYS_MON_CHANNEL_EXT_REF,
 		.address = 3,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
-				    | BIT(IIO_CHAN_INFO_SCALE),
+				    | BIT(IIO_CHAN_INFO_SCALE)
+				    | BIT(IIO_CHAN_INFO_SAMP_FREQ)
+				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ)
+				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.ext_info = ads112c14_ext_info,
 	},
 	{
 		.type = IIO_VOLTAGE,
@@ -228,7 +285,12 @@ static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
 		.channel = ADS112C14_SYS_MON_CHANNEL_AVDD,
 		.address = 4,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
-				    | BIT(IIO_CHAN_INFO_SCALE),
+				    | BIT(IIO_CHAN_INFO_SCALE)
+				    | BIT(IIO_CHAN_INFO_SAMP_FREQ)
+				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ)
+				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.ext_info = ads112c14_ext_info,
 	},
 	{
 		.type = IIO_VOLTAGE,
@@ -236,7 +298,12 @@ static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
 		.channel = ADS112C14_SYS_MON_CHANNEL_DVDD,
 		.address = 5,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
-				    | BIT(IIO_CHAN_INFO_SCALE),
+				    | BIT(IIO_CHAN_INFO_SCALE)
+				    | BIT(IIO_CHAN_INFO_SAMP_FREQ)
+				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ)
+				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.ext_info = ads112c14_ext_info,
 	},
 	{
 		.type = IIO_VOLTAGE,
@@ -246,8 +313,13 @@ static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
 		.differential = 1,
 		.address = 1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
-				    | BIT(IIO_CHAN_INFO_SCALE),
-		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
+				    | BIT(IIO_CHAN_INFO_SCALE)
+				    | BIT(IIO_CHAN_INFO_SAMP_FREQ)
+				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE)
+				    | BIT(IIO_CHAN_INFO_SAMP_FREQ)
+				    | BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.ext_info = ads112c14_ext_info,
 	},
 };
 
@@ -267,6 +339,11 @@ struct ads112c14_measurement {
 	int scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)][2];
 };
 
+struct ads112c14_channel_state {
+	u8 speed_mode;
+	u8 filter_osr;
+};
+
 struct ads112c14_data {
 	const struct ads112c14_chip_info *chip_info;
 	struct regmap *regmap;
@@ -284,9 +361,13 @@ struct ads112c14_data {
 	bool refn_is_gnd;
 	u32 ext_ref_ohms;
 	struct ads112c14_measurement *measurements;
+	struct ads112c14_channel_state *channel_states;
 	u32 num_measurements;
 	u8 sys_mon_chan_short_gain_val;
 	int sys_mon_chan_short_scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)][2];
+	int sinc4_sample_rate_available[ARRAY_SIZE(ads112c14_sinc4_osr_available)][ARRAY_SIZE(ads112c14_fmod_div)][2];
+	int sinc4_sinc1_sample_rate_available[ARRAY_SIZE(ads112c14_sinc4_sinc1_osr_available)][ARRAY_SIZE(ads112c14_fmod_div)][2];
+	int sinc4_sinc1_pf1_sample_rate_available[2][2];
 	IIO_DECLARE_BUFFER_WITH_TS(__be32, scan, ADS112C14_MAX_MEASUREMENT_CHANNELS +
 						 ARRAY_SIZE(ads112c14_sys_mon_channels));
 };
@@ -472,14 +553,46 @@ static const struct regmap_config ads112c14_regmap_config = {
 	.cache_type = REGCACHE_MAPLE,
 };
 
+static int ads112c14_get_osr(struct ads112c14_channel_state *channel_state)
+{
+	u8 i;
+
+	switch (channel_state->filter_osr) {
+	case ADS112C14_DATA_RATE_CFG_FLTR_OSR_16...ADS112C14_DATA_RATE_CFG_FLTR_OSR_32:
+		i = channel_state->filter_osr;
+		return ads112c14_sinc4_osr_available[i];
+	case ADS112C14_DATA_RATE_CFG_FLTR_OSR_128...ADS112C14_DATA_RATE_CFG_FLTR_OSR_1024:
+		i = channel_state->filter_osr - ADS112C14_DATA_RATE_CFG_FLTR_OSR_128;
+		return ads112c14_sinc4_sinc1_osr_available[i];
+	case ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS:
+		i = channel_state->speed_mode;
+		return ads112c14_sinc4_sinc1_pf1_25sps_osr_available[i];
+	case ADS112C14_DATA_RATE_CFG_FLTR_OSR_20SPS:
+		i = channel_state->speed_mode;
+		return ads112c14_sinc4_sinc1_pf1_20sps_osr_available[i];
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ads112c14_prepare_measurement_channel(struct ads112c14_data *data,
 						 const struct iio_chan_spec *chan,
 						 bool en_burnout)
 {
 	struct ads112c14_measurement *measurement = &data->measurements[chan->scan_index];
+	struct ads112c14_channel_state *channel_state;
 	u32 refp_buf_en, refn_buf_en, ref_val, ref_sel;
 	int ret;
 
+	channel_state = &data->channel_states[chan->scan_index];
+
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
+				 ADS112C14_DEVICE_CFG_SPEED_MODE,
+				 FIELD_PREP(ADS112C14_DEVICE_CFG_SPEED_MODE,
+					    channel_state->speed_mode));
+	if (ret)
+		return ret;
+
 	ret = regmap_update_bits(data->regmap, ADS112C14_REG_MUX_CFG,
 				 ADS112C14_MUX_CFG_AINP | ADS112C14_MUX_CFG_AINN,
 				 FIELD_PREP(ADS112C14_MUX_CFG_AINP, chan->channel) |
@@ -526,10 +639,13 @@ static int ads112c14_prepare_measurement_channel(struct ads112c14_data *data,
 		return ret;
 
 	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DATA_RATE_CFG,
-				 ADS112C14_DATA_RATE_CFG_GC_EN,
+				 ADS112C14_DATA_RATE_CFG_GC_EN |
+				 ADS112C14_DATA_RATE_CFG_FLTR_OSR,
 				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_GC_EN,
 					    (measurement->global_chop &&
-					     !en_burnout) ? 1 : 0));
+					     !en_burnout) ? 1 : 0) |
+				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_FLTR_OSR,
+					    channel_state->filter_osr));
 	if (ret)
 		return ret;
 
@@ -572,9 +688,12 @@ static int ads112c14_prepare_measurement_channel(struct ads112c14_data *data,
 static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
 					     const struct iio_chan_spec *chan)
 {
+	struct ads112c14_channel_state *channel_state;
 	u32 gain_val;
 	int ret;
 
+	channel_state = &data->channel_states[chan->scan_index];
+
 	/*
 	 * NB: IDAC registers are left as-is in case they are generating current
 	 * needed for the external reference measurement.
@@ -601,6 +720,22 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
 	if (ret)
 		return ret;
 
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
+				 ADS112C14_DEVICE_CFG_SPEED_MODE,
+				 FIELD_PREP(ADS112C14_DEVICE_CFG_SPEED_MODE,
+					    channel_state->speed_mode));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DATA_RATE_CFG,
+				 ADS112C14_DATA_RATE_CFG_GC_EN |
+				 ADS112C14_DATA_RATE_CFG_FLTR_OSR,
+				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_GC_EN, 0) |
+				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_FLTR_OSR,
+					    channel_state->filter_osr));
+	if (ret)
+		return ret;
+
 	/*
 	 * REVISIT: if we implement regulator support for the REFOUT pin, we
 	 * might need to make this voltage match what is required by that. In
@@ -835,6 +970,45 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 		 */
 		*val = div_s64((s64)(25 * 405 - 119500) * BIT(fsr_bits), vref_uV);
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		struct ads112c14_channel_state *channel_state;
+		const int (*available)[2];
+		u8 i, j;
+
+		guard(mutex)(&data->lock);
+
+		channel_state = &data->channel_states[chan->scan_index];
+
+		switch (channel_state->filter_osr) {
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_16...ADS112C14_DATA_RATE_CFG_FLTR_OSR_32:
+			j = channel_state->filter_osr;
+			available = data->sinc4_sample_rate_available[j];
+			i = channel_state->speed_mode;
+			break;
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_128...ADS112C14_DATA_RATE_CFG_FLTR_OSR_1024:
+			j = channel_state->filter_osr - ADS112C14_DATA_RATE_CFG_FLTR_OSR_128;
+			available = data->sinc4_sinc1_sample_rate_available[j];
+			i = channel_state->speed_mode;
+			break;
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS:
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_20SPS:
+			available = data->sinc4_sinc1_pf1_sample_rate_available;
+			i = channel_state->filter_osr - ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		*val = available[i][0];
+		*val2 = available[i][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
+		guard(mutex)(&data->lock);
+
+		*val = ads112c14_get_osr(&data->channel_states[chan->scan_index]);
+		return IIO_VAL_INT;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -845,6 +1019,9 @@ static int ads112c14_read_avail(struct iio_dev *indio_dev,
 				int *type, int *length, long mask)
 {
 	struct ads112c14_data *data = iio_priv(indio_dev);
+	struct ads112c14_channel_state *channel_state;
+
+	channel_state = &data->channel_states[chan->scan_index];
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -870,6 +1047,58 @@ static int ads112c14_read_avail(struct iio_dev *indio_dev,
 		}
 
 		return -EINVAL;
+
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&data->lock);
+
+		switch (channel_state->filter_osr) {
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_16...ADS112C14_DATA_RATE_CFG_FLTR_OSR_32:
+			*vals = (const int *)data->sinc4_sample_rate_available[channel_state->filter_osr];
+			*length = 2 * ARRAY_SIZE(data->sinc4_sample_rate_available[0]);
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_AVAIL_LIST;
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_128...ADS112C14_DATA_RATE_CFG_FLTR_OSR_1024:
+			*vals = (const int *)data->sinc4_sinc1_sample_rate_available[channel_state->filter_osr - ADS112C14_DATA_RATE_CFG_FLTR_OSR_128];
+			*length = 2 * ARRAY_SIZE(data->sinc4_sinc1_sample_rate_available[0]);
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_AVAIL_LIST;
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS...ADS112C14_DATA_RATE_CFG_FLTR_OSR_20SPS:
+			*vals = (const int *)data->sinc4_sinc1_pf1_sample_rate_available;
+			*length = 2 * ARRAY_SIZE(data->sinc4_sinc1_pf1_sample_rate_available);
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
+	}
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
+		guard(mutex)(&data->lock);
+
+		switch (channel_state->filter_osr) {
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_16...ADS112C14_DATA_RATE_CFG_FLTR_OSR_32:
+			*vals = ads112c14_sinc4_osr_available;
+			*length = ARRAY_SIZE(ads112c14_sinc4_osr_available);
+			*type = IIO_VAL_INT;
+			return IIO_AVAIL_LIST;
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_128...ADS112C14_DATA_RATE_CFG_FLTR_OSR_1024:
+			*vals = ads112c14_sinc4_sinc1_osr_available;
+			*length = ARRAY_SIZE(ads112c14_sinc4_sinc1_osr_available);
+			*type = IIO_VAL_INT;
+			return IIO_AVAIL_LIST;
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS:
+			*vals = ads112c14_sinc4_sinc1_pf1_25sps_osr_available;
+			*length = ARRAY_SIZE(ads112c14_sinc4_sinc1_pf1_25sps_osr_available);
+			*type = IIO_VAL_INT;
+			return IIO_AVAIL_LIST;
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_20SPS:
+			*vals = ads112c14_sinc4_sinc1_pf1_20sps_osr_available;
+			*length = ARRAY_SIZE(ads112c14_sinc4_sinc1_pf1_20sps_osr_available);
+			*type = IIO_VAL_INT;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
+	}
 	default:
 		return -EINVAL;
 	}
@@ -914,6 +1143,99 @@ static int ads112c14_write_raw(struct iio_dev *indio_dev,
 
 		return -EINVAL;
 	}
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		struct ads112c14_channel_state *channel_state;
+		const int (*available)[2];
+
+		guard(mutex)(&data->lock);
+
+		channel_state = &data->channel_states[chan->scan_index];
+
+		switch (channel_state->filter_osr) {
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_16...ADS112C14_DATA_RATE_CFG_FLTR_OSR_1024:
+			if (channel_state->filter_osr < ADS112C14_DATA_RATE_CFG_FLTR_OSR_128) {
+				u8 idx = channel_state->filter_osr;
+
+				available = data->sinc4_sample_rate_available[idx];
+			} else {
+				u8 idx = channel_state->filter_osr - ADS112C14_DATA_RATE_CFG_FLTR_OSR_128;
+
+				available = data->sinc4_sinc1_sample_rate_available[idx];
+			}
+
+			for (unsigned int i = 0; i < ARRAY_SIZE(ads112c14_fmod_div); i++) {
+				if (val == available[i][0] && val2 == available[i][1]) {
+					channel_state->speed_mode = i;
+					return 0;
+				}
+			}
+
+			return -EINVAL;
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS:
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_20SPS: {
+			available = data->sinc4_sinc1_pf1_sample_rate_available;
+
+			for (unsigned int i = 0; i < ARRAY_SIZE(data->sinc4_sinc1_pf1_sample_rate_available); i++) {
+				if (val == available[i][0] && val2 == available[i][1]) {
+					channel_state->filter_osr = i + ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS;
+					return 0;
+				}
+			}
+
+			return -EINVAL;
+		}
+		default:
+			return -EINVAL;
+		}
+	}
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO: {
+		struct ads112c14_channel_state *channel_state;
+
+		guard(mutex)(&data->lock);
+
+		channel_state = &data->channel_states[chan->scan_index];
+
+		switch (channel_state->filter_osr) {
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_16...ADS112C14_DATA_RATE_CFG_FLTR_OSR_32:
+			for (unsigned int i = 0; i < ARRAY_SIZE(ads112c14_sinc4_osr_available); i++) {
+				if (val == ads112c14_sinc4_osr_available[i]) {
+					channel_state->filter_osr = i;
+					return 0;
+				}
+			}
+
+			return -EINVAL;
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_128...ADS112C14_DATA_RATE_CFG_FLTR_OSR_1024:
+			for (unsigned int i = 0; i < ARRAY_SIZE(ads112c14_sinc4_sinc1_osr_available); i++) {
+				if (val == ads112c14_sinc4_sinc1_osr_available[i]) {
+					channel_state->filter_osr = i + ADS112C14_DATA_RATE_CFG_FLTR_OSR_128;
+					return 0;
+				}
+			}
+
+			return -EINVAL;
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS:
+			for (unsigned int i = 0; i < ARRAY_SIZE(ads112c14_sinc4_sinc1_pf1_25sps_osr_available); i++) {
+				if (val == ads112c14_sinc4_sinc1_pf1_25sps_osr_available[i]) {
+					channel_state->speed_mode = i;
+					return 0;
+				}
+			}
+
+			return -EINVAL;
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_20SPS:
+			for (unsigned int i = 0; i < ARRAY_SIZE(ads112c14_sinc4_sinc1_pf1_20sps_osr_available); i++) {
+				if (val == ads112c14_sinc4_sinc1_pf1_20sps_osr_available[i]) {
+					channel_state->speed_mode = i;
+					return 0;
+				}
+			}
+
+			return -EINVAL;
+		default:
+			return -EINVAL;
+		}
+	}
 	default:
 		return -EINVAL;
 	}
@@ -1202,11 +1524,98 @@ static ssize_t ads112c14_read_burnout_raw(struct iio_dev *indio_dev,
 	return sysfs_emit(buf, "%d\n", val);
 }
 
+static int ads112c14_get_filter_type_from_state(struct ads112c14_channel_state *channel_state)
+{
+	switch (channel_state->filter_osr) {
+	case ADS112C14_DATA_RATE_CFG_FLTR_OSR_16...ADS112C14_DATA_RATE_CFG_FLTR_OSR_32:
+		return ADS112C14_FILTER_TYPE_SINC4;
+	case ADS112C14_DATA_RATE_CFG_FLTR_OSR_128...ADS112C14_DATA_RATE_CFG_FLTR_OSR_1024:
+		return ADS112C14_FILTER_TYPE_SINC4_SINC1;
+	case ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS...ADS112C14_DATA_RATE_CFG_FLTR_OSR_20SPS:
+		return ADS112C14_FILTER_TYPE_SINC4_SINC1_PF1;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads112c14_set_filter_type(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     unsigned int val)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	struct ads112c14_channel_state *channel_state;
+	int ret;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	guard(mutex)(&data->lock);
+
+	channel_state = &data->channel_states[chan->scan_index];
+
+	ret = ads112c14_get_filter_type_from_state(channel_state);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * channel_state->filter_osr affects multiple attributes, so don't modify
+	 * it if the filter type is already set to the requested value.
+	 */
+	if (ret == val)
+		return 0;
+
+	/* Otherwise, pick an arbitrary default for each type. */
+	switch (val) {
+	case ADS112C14_FILTER_TYPE_SINC4:
+		channel_state->filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_16;
+		break;
+	case ADS112C14_FILTER_TYPE_SINC4_SINC1:
+		channel_state->filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_128;
+		break;
+	case ADS112C14_FILTER_TYPE_SINC4_SINC1_PF1:
+		channel_state->filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ads112c14_get_filter_type(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	struct ads112c14_channel_state *channel_state;
+
+	guard(mutex)(&data->lock);
+
+	channel_state = &data->channel_states[chan->scan_index];
+
+	return ads112c14_get_filter_type_from_state(channel_state);
+}
+
+static const struct iio_enum ads112c14_filter_type_enum = {
+	.items = ads112c14_filter_type_names,
+	.num_items = ARRAY_SIZE(ads112c14_filter_type_names),
+	.set = ads112c14_set_filter_type,
+	.get = ads112c14_get_filter_type,
+};
+
+static const struct iio_chan_spec_ext_info ads112c14_ext_info[] = {
+	IIO_ENUM("filter_type", IIO_SEPARATE, &ads112c14_filter_type_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE, &ads112c14_filter_type_enum),
+	{ }
+};
+
 static const struct iio_chan_spec_ext_info ads112c14_ext_info_burnout[] = {
 	{
 		.name = "burnoutraw",
 		.read = ads112c14_read_burnout_raw,
 	},
+	IIO_ENUM("filter_type", IIO_SEPARATE, &ads112c14_filter_type_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE, &ads112c14_filter_type_enum),
 	{ }
 };
 
@@ -1232,7 +1641,7 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 	struct ads112c14_data *data = iio_priv(indio_dev);
 	struct device *dev = indio_dev->dev.parent;
 	struct iio_chan_spec *channels;
-	u32 num_child_nodes, i, pair[2];
+	u32 num_child_nodes, num_data_chans, i, pair[2];
 	int ret;
 
 	*need_avdd_ref = false;
@@ -1245,8 +1654,15 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 	if (!data->measurements)
 		return -ENOMEM;
 
-	channels = devm_kcalloc(dev, num_child_nodes +
-				ARRAY_SIZE(ads112c14_sys_mon_channels) + 1,
+	num_data_chans = num_child_nodes + ARRAY_SIZE(ads112c14_sys_mon_channels);
+
+	data->channel_states = devm_kcalloc(dev, num_data_chans,
+					    sizeof(*data->channel_states),
+					    GFP_KERNEL);
+	if (!data->channel_states)
+		return -ENOMEM;
+
+	channels = devm_kcalloc(dev, num_data_chans + 1,
 				sizeof(*channels), GFP_KERNEL);
 	if (!channels)
 		return -ENOMEM;
@@ -1259,7 +1675,9 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 
 		spec->indexed = 1;
 		spec->scan_index = i;
+		spec->ext_info = ads112c14_ext_info;
 		measurement->gain_val = 1;
+		data->channel_states[i].filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_16;
 
 		if (fwnode_property_present(child, "label")) {
 			ret = fwnode_property_read_string(child, "label", &measurement->label);
@@ -1424,8 +1842,13 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 		if (measurement->vref_source == ADS112C14_VREF_SOURCE_EXTERNAL)
 			*need_ext_ref = true;
 
-		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE);
-		spec->info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE);
+		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+					   BIT(IIO_CHAN_INFO_SCALE) |
+					   BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
+		spec->info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE) |
+						     BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+						     BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
 
 		/*
 		 * If reference source is resistor rather than voltage supply,
@@ -1459,6 +1882,10 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 
 	for (u32 j = 0; j < ARRAY_SIZE(ads112c14_sys_mon_channels); j++) {
 		struct iio_chan_spec *spec = &channels[i];
+		struct ads112c14_channel_state *channel_state;
+
+		channel_state = &data->channel_states[i];
+		channel_state->filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_16;
 
 		/* Update the template that was already copied with dynamic values. */
 		spec->scan_index = i;
@@ -1497,6 +1924,48 @@ static void ads112c14_populate_scale_available(int (*scale_avail)[2],
 	}
 }
 
+static void ads112c14_populate_odr_tables(struct ads112c14_data *data)
+{
+	int *available;
+	u32 osr, fmod_Hz;
+	u64 odr_uHz;
+	u32 rem;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(ads112c14_sinc4_osr_available); i++) {
+		osr = ads112c14_sinc4_osr_available[i];
+
+		for (unsigned int j = 0; j < ARRAY_SIZE(ads112c14_fmod_div); j++) {
+			fmod_Hz = data->fclk_Hz / ads112c14_fmod_div[j];
+			odr_uHz = div_u64((u64)fmod_Hz * MICRO, osr);
+			available = data->sinc4_sample_rate_available[i][j];
+			available[0] = div_u64_rem(odr_uHz, MICRO, &rem);
+			available[1] = rem;
+		}
+	}
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(ads112c14_sinc4_sinc1_osr_available); i++) {
+		osr = ads112c14_sinc4_sinc1_osr_available[i];
+
+		for (unsigned int j = 0; j < ARRAY_SIZE(ads112c14_fmod_div); j++) {
+			fmod_Hz = data->fclk_Hz / ads112c14_fmod_div[j];
+			odr_uHz = div_u64((u64)fmod_Hz * MICRO, osr);
+			available = data->sinc4_sinc1_sample_rate_available[i][j];
+			available[0] = div_u64_rem(odr_uHz, MICRO, &rem);
+			available[1] = rem;
+		}
+	}
+
+	odr_uHz = div_u64((u64)25 * data->fclk_Hz * MICRO, ADS112C14_INTERNAL_CLK_Hz);
+	available = data->sinc4_sinc1_pf1_sample_rate_available[0];
+	available[0] = div_u64_rem(odr_uHz, MICRO, &rem);
+	available[1] = rem;
+
+	odr_uHz = div_u64((u64)20 * data->fclk_Hz * MICRO, ADS112C14_INTERNAL_CLK_Hz);
+	available = data->sinc4_sinc1_pf1_sample_rate_available[1];
+	available[0] = div_u64_rem(odr_uHz, MICRO, &rem);
+	available[1] = rem;
+}
+
 static void ads112c14_populate_tables(struct ads112c14_data *data)
 {
 	u32 full_scale, fsr_bits;
@@ -1534,6 +2003,7 @@ static void ads112c14_populate_tables(struct ads112c14_data *data)
 
 	ads112c14_populate_scale_available(data->sys_mon_chan_short_scale_available,
 					   full_scale, fsr_bits);
+	ads112c14_populate_odr_tables(data);
 }
 
 static int ads112c14_probe(struct i2c_client *client)

-- 
2.43.0

