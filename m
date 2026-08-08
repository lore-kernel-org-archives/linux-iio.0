Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E6D22A817
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 00:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786148439; cv=none; b=rdtZrIuPMwo/cyXqPYflFUevUxMWRo7QOH2BVq9vmEuKmiDWLbwGuARejMbqU222eSRikfp5K58T9XLSOQc/WeBLd+jeyXKLuDKZtQuVqPcllNhAHUrq96KlcnA6Y+V66cPgxEq6vKfUKBwtr/q8c50DokgUHrDwHDNUr80JfZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786148439; c=relaxed/simple;
	bh=154u7Jk2wf7g0zhyit0KoGAZL+ie3TlzVOfJ6SBf8Kc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gEqH3Mjj6QcICdCivaSSZjHXycVANXnpMdjz3O5JKr8FL/44Wafe1hM5OzviGAfA1CNNMYrrCzjuHnDna7fd8s8Dks6o5e2LPZSkS4/AdAnJ0+Akm0c8VNfajef+h/O8mDq26Vcc+0E+K4h8yU8VZamGT9MxoR0/JZbPzSodva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ITSL1Rix; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ITSL1Rix"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6ae5baaef5dso81922eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 17:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786148436; x=1786753236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lPAkkK7lnRiQLocAijMmBt97fxjS7WIGdRN9v95Ll4E=;
        b=ITSL1RixLsrCzrcU8nGTu/0NybVu8mCrljZnj8ibMTCTBPrt/w0nt9qjMiOGyFMzeL
         7zKvM8XYDpq3pS7n/wOV11qERX1Igkz8C+EeQx1FN/aa2s/yeF7fS9gXcHQTgQ/2lf5J
         PzQp6GqFMttbnXUD+laZp8OzTxY1tw8lKqeZ8Rk+srC1J/SUF2udapJxS/gPOHiay7cA
         yOSKrTPusM9nSV+OgBKZO8d7AyBYWmNd09gFLOqgiOecMq8w/eZ1YrBqZ3s1JG7R12GE
         MuLpp0OSeGQBZjdvhBGhkFcsQoPo9xFKaglUaWtY5isV2modWyS5c+3/JpU/WGbkZWl2
         I9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786148436; x=1786753236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lPAkkK7lnRiQLocAijMmBt97fxjS7WIGdRN9v95Ll4E=;
        b=q4c3qFrxyyhyHQAfQAYY/+rwVSXKAlwRSUx1GGgRAmPHMRuNw8Uyd4pZUQB/TtcG0x
         UgFSIaQQvQupBtS6HQ8lL7nqgm67+AYUAgRAKTc2F6WnWM/7oOlLxoaB+s0P30Qy0UhW
         0jevEmoMk8ISBwj4adBwOHSvtL8DECIlcJmyQIQau2KL5LbNdXhvRapP6gDnSwSD5V0g
         4XaEhJfIhWVhFcGVYdzBtimiqOIAmBe9Nqluthpp85iB0MGoVORL+2KVjh9tcMvKWWva
         iF3LJwZzGmb5NmPuyECBmcI7lfE0zapq5XK3w/HPDUZQgz7fvyV99+MKbKI0YHFUS2mA
         dr/g==
X-Gm-Message-State: AOJu0YxxNGOxZl79ry3yzp/6pKSSoIaE8Sj/zSYCVMm5Z6H3F1l3Yi5Z
	i9Q2sr0nS3LXtoafeFbbFtiZsOF8W0NGUHnEGoRfHkV4sXJ/ccjEFtAdC0HxlG5TOfdQWPs8jZf
	2TQix5cU=
X-Gm-Gg: AR+sD13rWkVrMt63AhMJZW66Fwr87xGDJzZjwn9lHiZsjtdwCAmYnd7op/fYDW+f/c2
	cRwVtK0d45Wbx51vzG3M+MR8WctfbiXR5et7+rD5aJjmjXsBohAT0Ye6oev2OC8zGrQx3+wpYXa
	QCZw19sVfIJn+s13YC98uXzgBKyoaCU0SLkGvzn0edEFxP1K+aS3qfB2J7qKz4EyfUnSRvDk3zU
	3P7qCgqIz1GJVK9duk4WmE85XlExdpR+RxS4495DocFMkdjHXkwkQlCL9ayCNoecOFIjuB007jX
	B+rYXvQa7+BfSF79vk/SmenOaqgyzbiHb+6LNkhOK0LPfCRwsyQWkrERNcko2VZYRYGjjJOepes
	Ax+FWVWGUTAHsuq06LtqEFBBXaFdWvCmzAP9DM6GpEbPpH8keaySXaXjM7SW8j+H7p0MFZhhibq
	3jMtOYIvQ1FZEWPQHn0WvC5s+0aTUhpTE31rSt1fqndtEMI+5djbjYxekaBz483YYe
X-Received: by 2002:a05:6820:811b:b0:6ae:aa9b:b8f1 with SMTP id 006d021491bc7-6b045000e95mr1433320eaf.10.1786148435822;
        Fri, 07 Aug 2026 17:20:35 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b5a7616sm2526147a34.8.2026.08.07.17.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:20:35 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 19:19:47 -0500
Subject: [PATCH 2/5] iio: adc: ti-ads112c14: add filter support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-iio-adc-ti-ads112c14-filter-support-v1-2-4d3ba00caf18@baylibre.com>
References: <20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com>
In-Reply-To: <20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=26790;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=154u7Jk2wf7g0zhyit0KoGAZL+ie3TlzVOfJ6SBf8Kc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqdnY2Fv53h/nqHt/7Sm5RECB+Z6I/2lAMD2xLg
 1z9h7I8BHWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanZ2NgAKCRDCzCAB/wGP
 wAIcCACayUfQL5XkSHt/8JRrttppNgw7jR6lQPUEo6mN+jLq2kegSPULnvP450EfkwxP66ONTRr
 SDq0U4+R0XN8prDB+GHgdVD007W2Fjl93gAiYTYcdmx7yj+ayqBVexA7RJ7/XzMWRq45iEpY+m+
 4l1Dj7pb3CuurMnF+1TJ02ZkiJvaF930uZ6Xic8ZohBZA/6k8Tgs05/ZxVc0gbEuk6Fy6JPBdtZ
 mqhTA+N6YgSl7OovrDkfIarOsaT08o7ynGk2mLFq5lQ0sCHwKou5Ew3vjb/xeVZh+FjnposD6JS
 vg6PhFEvnbH3VpzonM2eNahAiw3HwP/QI+C96jA8MSZvessc
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
 drivers/iio/adc/ti-ads112c14.c | 493 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 480 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 5f03e6985efa..a73c0d6f0f65 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -92,6 +92,14 @@
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
@@ -181,6 +189,43 @@ static const u32 ads112c14_pga_gains_x10[] = {
 
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
 
@@ -202,6 +247,8 @@ enum {
 	ADS112C14_SYS_MON_CHANNEL_SHORT,
 };
 
+static const struct iio_chan_spec_ext_info ads112c14_ext_info[];
+
 static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
 	{
 		.type = IIO_TEMP,
@@ -210,7 +257,12 @@ static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
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
@@ -218,7 +270,12 @@ static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
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
@@ -226,7 +283,12 @@ static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
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
@@ -234,7 +296,12 @@ static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
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
@@ -244,8 +311,13 @@ static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
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
 
@@ -265,6 +337,11 @@ struct ads112c14_measurement {
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
@@ -281,9 +358,13 @@ struct ads112c14_data {
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
@@ -469,14 +550,46 @@ static const struct regmap_config ads112c14_regmap_config = {
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
@@ -523,9 +636,12 @@ static int ads112c14_prepare_measurement_channel(struct ads112c14_data *data,
 		return ret;
 
 	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DATA_RATE_CFG,
-				 ADS112C14_DATA_RATE_CFG_GC_EN,
+				 ADS112C14_DATA_RATE_CFG_GC_EN |
+				 ADS112C14_DATA_RATE_CFG_FLTR_OSR,
 				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_GC_EN,
-					    measurement->global_chop && !en_burnout));
+					    measurement->global_chop && !en_burnout) |
+				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_FLTR_OSR,
+					    channel_state->filter_osr));
 	if (ret)
 		return ret;
 
@@ -568,9 +684,12 @@ static int ads112c14_prepare_measurement_channel(struct ads112c14_data *data,
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
@@ -597,6 +716,22 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
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
@@ -824,6 +959,45 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
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
@@ -834,6 +1008,9 @@ static int ads112c14_read_avail(struct iio_dev *indio_dev,
 				int *type, int *length, long mask)
 {
 	struct ads112c14_data *data = iio_priv(indio_dev);
+	struct ads112c14_channel_state *channel_state;
+
+	channel_state = &data->channel_states[chan->scan_index];
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -859,6 +1036,58 @@ static int ads112c14_read_avail(struct iio_dev *indio_dev,
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
@@ -871,6 +1100,7 @@ static int ads112c14_write_raw(struct iio_dev *indio_dev,
 	struct ads112c14_data *data = iio_priv(indio_dev);
 	const int (*scale_avail)[2];
 	u8 *gain_val;
+	u32 i;
 
 	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
 	if (IIO_DEV_ACQUIRE_FAILED(claim))
@@ -903,6 +1133,99 @@ static int ads112c14_write_raw(struct iio_dev *indio_dev,
 
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
+			for (i = 0; i < ARRAY_SIZE(ads112c14_fmod_div); i++) {
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
+			for (i = 0; i < ARRAY_SIZE(data->sinc4_sinc1_pf1_sample_rate_available); i++) {
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
+			for (i = 0; i < ARRAY_SIZE(ads112c14_sinc4_osr_available); i++) {
+				if (val == ads112c14_sinc4_osr_available[i]) {
+					channel_state->filter_osr = i;
+					return 0;
+				}
+			}
+
+			return -EINVAL;
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_128...ADS112C14_DATA_RATE_CFG_FLTR_OSR_1024:
+			for (i = 0; i < ARRAY_SIZE(ads112c14_sinc4_sinc1_osr_available); i++) {
+				if (val == ads112c14_sinc4_sinc1_osr_available[i]) {
+					channel_state->filter_osr = i + ADS112C14_DATA_RATE_CFG_FLTR_OSR_128;
+					return 0;
+				}
+			}
+
+			return -EINVAL;
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS:
+			for (i = 0; i < ARRAY_SIZE(ads112c14_sinc4_sinc1_pf1_25sps_osr_available); i++) {
+				if (val == ads112c14_sinc4_sinc1_pf1_25sps_osr_available[i]) {
+					channel_state->speed_mode = i;
+					return 0;
+				}
+			}
+
+			return -EINVAL;
+		case ADS112C14_DATA_RATE_CFG_FLTR_OSR_20SPS:
+			for (i = 0; i < ARRAY_SIZE(ads112c14_sinc4_sinc1_pf1_20sps_osr_available); i++) {
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
@@ -1035,6 +1358,85 @@ static const struct iio_info ads112c14_info = {
 	.read_label = ads112c14_read_label,
 };
 
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
 static bool ads112c14_using_drdy_trigger(struct iio_dev *indio_dev)
 {
 	struct ads112c14_data *data = iio_priv(indio_dev);
@@ -1182,11 +1584,19 @@ static ssize_t ads112c14_read_burnout_raw(struct iio_dev *indio_dev,
 	return sysfs_emit(buf, "%d\n", val);
 }
 
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
 
@@ -1212,7 +1622,7 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 	struct ads112c14_data *data = iio_priv(indio_dev);
 	struct device *dev = indio_dev->dev.parent;
 	struct iio_chan_spec *channels;
-	u32 num_child_nodes, i, pair[2];
+	u32 num_child_nodes, num_data_chans, i, pair[2];
 	int ret;
 
 	*need_avdd_ref = false;
@@ -1225,8 +1635,15 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
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
@@ -1238,7 +1655,9 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 
 		spec->indexed = 1;
 		spec->scan_index = i;
+		spec->ext_info = ads112c14_ext_info;
 		measurement->gain_val = 1;
+		data->channel_states[i].filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_16;
 
 		if (fwnode_property_present(child, "label")) {
 			ret = fwnode_property_read_string(child, "label", &measurement->label);
@@ -1402,8 +1821,13 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
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
@@ -1437,6 +1861,10 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 
 	for (u32 j = 0; j < ARRAY_SIZE(ads112c14_sys_mon_channels); j++) {
 		struct iio_chan_spec *spec = &channels[i];
+		struct ads112c14_channel_state *channel_state;
+
+		channel_state = &data->channel_states[i];
+		channel_state->filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_16;
 
 		/* Update the template that was already copied with dynamic values. */
 		spec->scan_index = i;
@@ -1475,6 +1903,44 @@ static void ads112c14_populate_scale_available(int (*scale_avail)[2],
 	}
 }
 
+static void ads112c14_populate_odr_tables(struct ads112c14_data *data)
+{
+	int *available;
+	u32 osr, fmod_Hz;
+	u64 odr_uHz;
+	u32 i, j;
+
+	for (i = 0; i < ARRAY_SIZE(ads112c14_sinc4_osr_available); i++) {
+		osr = ads112c14_sinc4_osr_available[i];
+
+		for (j = 0; j < ARRAY_SIZE(ads112c14_fmod_div); j++) {
+			fmod_Hz = data->fclk_Hz / ads112c14_fmod_div[j];
+			odr_uHz = div_u64((u64)fmod_Hz * MICRO, osr);
+			available = data->sinc4_sample_rate_available[i][j];
+			available[0] = div_u64_rem(odr_uHz, MICRO, &available[1]);
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ads112c14_sinc4_sinc1_osr_available); i++) {
+		osr = ads112c14_sinc4_sinc1_osr_available[i];
+
+		for (j = 0; j < ARRAY_SIZE(ads112c14_fmod_div); j++) {
+			fmod_Hz = data->fclk_Hz / ads112c14_fmod_div[j];
+			odr_uHz = div_u64((u64)fmod_Hz * MICRO, osr);
+			available = data->sinc4_sinc1_sample_rate_available[i][j];
+			available[0] = div_u64_rem(odr_uHz, MICRO, &available[1]);
+		}
+	}
+
+	odr_uHz = div_u64((u64)25 * data->fclk_Hz * MICRO, ADS112C14_INTERNAL_CLK_Hz);
+	available = data->sinc4_sinc1_pf1_sample_rate_available[0];
+	available[0] = div_u64_rem(odr_uHz, MICRO, &available[1]);
+
+	odr_uHz = div_u64((u64)20 * data->fclk_Hz * MICRO, ADS112C14_INTERNAL_CLK_Hz);
+	available = data->sinc4_sinc1_pf1_sample_rate_available[1];
+	available[0] = div_u64_rem(odr_uHz, MICRO, &available[1]);
+}
+
 static void ads112c14_populate_tables(struct ads112c14_data *data)
 {
 	u32 full_scale, fsr_bits;
@@ -1512,6 +1978,7 @@ static void ads112c14_populate_tables(struct ads112c14_data *data)
 
 	ads112c14_populate_scale_available(data->sys_mon_chan_short_scale_available,
 					   full_scale, fsr_bits);
+	ads112c14_populate_odr_tables(data);
 }
 
 static int ads112c14_probe(struct i2c_client *client)

-- 
2.43.0

