Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A252342C50F
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074899; cv=none; b=hcRDskTqgYj4C6gWMIs6lJ6ENuH5LsF7EAMCQitjI3eLre3DgHq9BDpcLYtf1qW218Ut40gvCO6IRlkOuAvEtgF2l/FD0Yt+pKisksE37mZ3XUBM2NwTEDDsbGqMLZDKuIJCFlIoPxStdpqD/iI4VeoTllmyEV75cEfbtzVQ5wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074899; c=relaxed/simple;
	bh=+pJJY4T3JRnbsPKEPsryKioKn/+DD79vyB/fSaDvxHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NpoIbLfEKZldIta0OKHWwhr6m/s7wpBE0pOiWeG94VVD4woBDnQWrheFBqLlNXXzwl0yGBOyFDfKcQGRVLEv6Y99T/YOzZO6RC3MSkIxMuSTfAA7+XTd4SIkVqU1/KNjUB58sge4fHeX5Iv06qXItlQv1WYL4aVR2a/ovzmNvoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=pj8KsLSL; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="pj8KsLSL"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c0766cbe64so182523b6e.3
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 14:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789074885; x=1789679685; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rsh4HQYpeLh3LHOXR0Mo25jgQj3alHd3Q6Y+Zo7F9ts=;
        b=pj8KsLSLPFhm9V9USv1veiH/McsS6ElMAh9QUjHOsz/tpoA8lYnWearu1sJ71ORr1d
         JGPvffNYC4gB94bl6eUl1PPw9OB5Ct1ngA0BAoQOW3TX1FkMkyY05C2H//in4I0c0VJy
         PKQISlsuhrsv4ejxJuXXSzcpvamXolZ/nBrNWnP3wFbXYtV3ot5ZL8gmbPOEDq+uEP0Y
         3bV0LHNCxtwJqiEldtVdHJcoH8GB4obQjA/yPF5g47+NwjydWjXwST5w285sTYX0rawD
         x6ov6VBtWgsL8fZsK3LwYmrETNZ6NpBQZhO7B54S0zd0jqn9kZyRWaEieY7pALxyqYxU
         aLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074885; x=1789679685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rsh4HQYpeLh3LHOXR0Mo25jgQj3alHd3Q6Y+Zo7F9ts=;
        b=UZHVuQICiTyMWCV/Rpm80ugC9Uos4gLY8nRXFsCl/OC3XdJTK3nfb5l953vOJcI4iw
         aXTMKFeEytJR32W65WmIxSofDMamzEPeLu6W31s+CfJ+09+8uImE+KAbybcOPJeyrufr
         d+5VbN6YxbJ5L1sDeM5NyCm0o5f722E0yzdL3x/5Y59YwWMjr6S3i7c5tKFIKH5Xqp3A
         FeTwxHgsxXE0liNgSwOGhfB1Ij39DvC5I2kM5V8c483gmWpaqAv5GZbRIh7Tv4cTiQd2
         2ytgvoTy/aKsVnkCTLdA7wcSf8XiN8fNb8D3llITxoLzm6f7snVuonW8G4I0c8b1YGQV
         pcpw==
X-Forwarded-Encrypted: i=1; AKwUvBxbuKKXABye6t7PPPRNV+BGS6loB5SzVXoNvfWlnlGf7S0gI6JkDG9DIvoYitvfpqb6gPdvT0j4gFQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nElGkZfSa7ge22Px88wMSfrEJyRzus3cx9otGemcuWwQPAWrI7
	AX1j0uAy0JE29KuUEpRprXzs/P7dqPhJlilTz/oGvQCF/DzYjrHccVp1tBT9Gj27HO8=
X-Gm-Gg: AYBFou15KfyF3waqg4Y0fKCYp0F82TRHA2Dudno9wGDtl8aVajkdY3o9+k5FD5H3FU5
	0kvA5T9JRjQs6B4eRddN7YEWuiK47mHBe015Z3KmDfg5hn4GQ06bsAOg0twbjarKNGJ2Jkh1TRE
	medY2VFe3KKOoCBw62P6TCgTigrbMVljoI+BvsPh+gXC8Zi+/09eG7WbQtTh0GwnmDk3iN6kCCb
	z0D8ijigWBvFt3ac2syXSw1GA3+SmZzEgwWvSU+IMlcbxDebM50Scxv6f1Gu9AwCBmRlrqsFJVf
	QShrnJBwGiCVT2Y5ZwvxHqlUswQ+3ZfyORaDdxCItVilRl8cszlsleMoWj/EmGycZwB8MKqsv2v
	JuNnwx93OgNF3mYPwQa2NXXevjHMCJGecvmLGO/gJfKQo/TflhXkQSavrpQXQzXEZ2I9pQr3WXh
	tkzUDtlyhPrQ/L2RqMm2E1M4fZNJpTapv7+y/zbocwhaMohsWGHPHwzt9nxmY+MDKUG8Mt0RJOU
	ujs
X-Received: by 2002:a05:6808:150a:b0:497:df42:1e04 with SMTP id 5614622812f47-4c31c40dfdbmr1118628b6e.18.1789074884597;
        Thu, 10 Sep 2026 14:14:44 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fbf1:d0da:69e0:11a0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c330daa42esm347315b6e.4.2026.09.10.14.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:14:44 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Thu, 10 Sep 2026 16:13:08 -0500
Subject: [PATCH v3 09/10] iio: adc: ti-ads112c14: add settlingtime
 attribute
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-iio-adc-ti-ads112c14-filter-support-v3-9-e5a9b27ddb1a@baylibre.com>
References: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
In-Reply-To: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=16275;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=+pJJY4T3JRnbsPKEPsryKioKn/+DD79vyB/fSaDvxHQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqox2nNNR32jHE9HR3YveksEYtLR3UF5PRY4FNw
 LrQerceOfiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaqMdpwAKCRDCzCAB/wGP
 wHqwB/9LJbqDescPoB0NNt4yTDfiNCK45IsA1kv/sY5Z8bWzk/ar820sNhw1uRalt/m3oaPNKf9
 fkeztfLBckTo8gvr+392E+sjmJQ+fbPPosQ0C/DY0Jt9Zd0qav7YUS9pov/A1qJf8GqTLwwYSBg
 lu1EKu5mJiE5BxzxncZeil/nbke0vrf/Y2hyCN/63gGwImXR8OPkyJZDtZBBKajb1YOsDOOv9Ad
 2NnyTUPy1sEDg+SD059fliIQ2vkXakQhpXEcdWfM5/9CukTqpjdyrPz9ueiA6Q4XCgwcJTStUTT
 aHnCHD6nW9BtoaivNqG04Pes8zoa+hbxM8QXbwmDZeSUArqB
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add per-channel sysfs attributes for settlingtime and
settlingtime_available. These allow adjusting the total settling time
for each channel. The value consists of a fixed t_latency time (based
on the selected filter_type, oversampling_ratio and sampling_frequency)
plus a user-configurable t_delay that determines the value to write to
the DELAY field in the registers.

The allowable values are non-linear integer multiples, so the step size
is just the smallest step size. Writing the attribute will match the
closest matching value for the DELAY field with a time equal to or
greater than the requested settling time (unless the requested time is
larger than the maximum allowable settling time).

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads112c14.c | 336 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 330 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index ee4992b9e029..ec598f82cf7f 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -216,6 +216,24 @@ static const int ads112c14_fmod_div[] = {
 	128, 16, 8, 4
 };
 
+#define ADS112C14_DELAY_MAX FIELD_MAX(ADS112C14_DATA_RATE_CFG_DELAY)
+
+/* Table 7-6 latency in t_MOD for OSR [16, 32, 128, 256, 512, 1024]. */
+static const int ads112c14_sinc_latency_tmod[][ARRAY_SIZE(ads112c14_fmod_div)] = {
+	{ 80, 88, 88, 104 },
+	{ 144, 152, 152, 168 },
+	{ 240, 248, 248, 264 },
+	{ 368, 376, 376, 392 },
+	{ 624, 632, 632, 648 },
+	{ 1136, 1144, 1144, 1160 },
+};
+
+/* Table 7-7 latency in t_MOD for output data rates [25SPS, 20SPS]. */
+static const int ads112c14_fir_latency_tmod[][ARRAY_SIZE(ads112c14_fmod_div)] = {
+	{ 1416, 10384, 20624, 41120 },
+	{ 1736, 12944, 25744, 51360 },
+};
+
 enum ads112c14_filter_type {
 	ADS112C14_FILTER_TYPE_SINC4,
 	ADS112C14_FILTER_TYPE_SINC4_SINC1,
@@ -342,6 +360,7 @@ struct ads112c14_measurement {
 struct ads112c14_channel_state {
 	u8 speed_mode;
 	u8 filter_osr;
+	u8 delay;
 };
 
 struct ads112c14_data {
@@ -368,6 +387,8 @@ struct ads112c14_data {
 	int sinc4_sample_rate_available[ARRAY_SIZE(ads112c14_sinc4_osr_available)][ARRAY_SIZE(ads112c14_fmod_div)][2];
 	int sinc4_sinc1_sample_rate_available[ARRAY_SIZE(ads112c14_sinc4_sinc1_osr_available)][ARRAY_SIZE(ads112c14_fmod_div)][2];
 	int sinc4_sinc1_pf1_sample_rate_available[2][2];
+	int sinc_settling_time_range_available[ARRAY_SIZE(ads112c14_sinc_latency_tmod)][ARRAY_SIZE(ads112c14_fmod_div)][3][2];
+	int fir_settling_time_range_available[ARRAY_SIZE(ads112c14_fir_latency_tmod)][ARRAY_SIZE(ads112c14_fmod_div)][3][2];
 	IIO_DECLARE_BUFFER_WITH_TS(__be32, scan, ADS112C14_MAX_MEASUREMENT_CHANNELS +
 						 ARRAY_SIZE(ads112c14_sys_mon_channels));
 };
@@ -575,6 +596,210 @@ static int ads112c14_get_osr(struct ads112c14_channel_state *channel_state)
 	}
 }
 
+static int ads112c14_get_fmod_Hz(struct ads112c14_data *data,
+				 struct ads112c14_channel_state *channel_state)
+{
+	return data->fclk_Hz / ads112c14_fmod_div[channel_state->speed_mode];
+}
+
+static int ads112c14_delay_to_tmod(u8 delay)
+{
+	if (!delay)
+		return 0;
+
+	return BIT(delay - 1);
+}
+
+static int ads112c14_get_latency_tmod(struct ads112c14_channel_state *channel_state)
+{
+	u8 speed_mode = channel_state->speed_mode;
+	u8 filter_osr = channel_state->filter_osr;
+
+	if (speed_mode >= ARRAY_SIZE(ads112c14_fmod_div))
+		return -EINVAL;
+
+	if (filter_osr <= ADS112C14_DATA_RATE_CFG_FLTR_OSR_1024)
+		return ads112c14_sinc_latency_tmod[filter_osr][speed_mode];
+
+	if (filter_osr == ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS)
+		return ads112c14_fir_latency_tmod[0][speed_mode];
+
+	if (filter_osr == ADS112C14_DATA_RATE_CFG_FLTR_OSR_20SPS)
+		return ads112c14_fir_latency_tmod[1][speed_mode];
+
+	return -EINVAL;
+}
+
+static int ads112c14_get_settling_time_us(struct ads112c14_data *data,
+					  struct ads112c14_channel_state *channel_state,
+					  u8 delay, u32 *settling_time_us)
+{
+	int fmod_Hz, latency_tmod;
+	u64 total_tmod;
+
+	fmod_Hz = ads112c14_get_fmod_Hz(data, channel_state);
+	if (fmod_Hz <= 0)
+		return -EINVAL;
+
+	latency_tmod = ads112c14_get_latency_tmod(channel_state);
+	if (latency_tmod < 0)
+		return latency_tmod;
+
+	total_tmod = latency_tmod + ads112c14_delay_to_tmod(delay);
+	*settling_time_us = div64_u64(total_tmod * USEC_PER_SEC, fmod_Hz);
+
+	return 0;
+}
+
+static int ads112c14_find_delay_for_settling_time_us(struct ads112c14_data *data,
+						     struct ads112c14_channel_state *channel_state,
+						     s64 settling_time_us, u8 *delay)
+{
+	u64 delay_us, delay_tmod_needed;
+	u32 fixed_latency_us;
+	int ret, fmod_Hz;
+	u8 i;
+
+	ret = ads112c14_get_settling_time_us(data, channel_state, 0, &fixed_latency_us);
+	if (ret)
+		return ret;
+
+	if (settling_time_us <= fixed_latency_us) {
+		*delay = 0;
+		return 0;
+	}
+
+	fmod_Hz = ads112c14_get_fmod_Hz(data, channel_state);
+	if (fmod_Hz <= 0)
+		return -EINVAL;
+
+	delay_us = settling_time_us - fixed_latency_us;
+	delay_tmod_needed = DIV_ROUND_UP_ULL(delay_us * fmod_Hz, USEC_PER_SEC);
+
+	for (i = 1; i < ADS112C14_DELAY_MAX; i++) {
+		if (ads112c14_delay_to_tmod(i) >= delay_tmod_needed)
+			break;
+	}
+
+	*delay = i;
+
+	return 0;
+}
+
+static ssize_t ads112c14_read_settling_time(struct iio_dev *indio_dev,
+					    uintptr_t private,
+					    const struct iio_chan_spec *chan,
+					    char *buf)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	struct ads112c14_channel_state *channel_state;
+	u32 settling_time_us;
+	int vals[2];
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	channel_state = &data->channel_states[chan->scan_index];
+
+	ret = ads112c14_get_settling_time_us(data, channel_state,
+					     channel_state->delay,
+					     &settling_time_us);
+	if (ret)
+		return ret;
+
+	iio_val_s64_decompose(settling_time_us, &vals[0], &vals[1]);
+
+	return iio_format_value(buf, IIO_VAL_DECIMAL64_MICRO, ARRAY_SIZE(vals), vals);
+}
+
+static ssize_t ads112c14_write_settling_time(struct iio_dev *indio_dev,
+					     uintptr_t private,
+					     const struct iio_chan_spec *chan,
+					     const char *buf, size_t len)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	struct ads112c14_channel_state *channel_state;
+	s64 settling_time_us;
+	int integer;
+	int fract;
+	u8 delay;
+	int ret;
+
+	ret = iio_str_to_fixpoint(buf, 100000, &integer, &fract);
+	if (ret)
+		return ret;
+
+	settling_time_us = integer * MICRO + fract;
+	if (settling_time_us < 0)
+		return -EINVAL;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	guard(mutex)(&data->lock);
+
+	channel_state = &data->channel_states[chan->scan_index];
+
+	ret = ads112c14_find_delay_for_settling_time_us(data, channel_state,
+							settling_time_us, &delay);
+	if (ret)
+		return ret;
+
+	channel_state->delay = delay;
+
+	return len;
+}
+
+static ssize_t ads112c14_read_settling_time_available(struct iio_dev *indio_dev,
+						      uintptr_t private,
+						      const struct iio_chan_spec *chan,
+						      char *buf)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	struct ads112c14_channel_state *channel_state;
+	u8 filter_osr, speed_mode;
+	const int (*range)[2];
+	size_t len = 0;
+	int i;
+
+	guard(mutex)(&data->lock);
+
+	channel_state = &data->channel_states[chan->scan_index];
+
+	filter_osr = channel_state->filter_osr;
+	speed_mode = channel_state->speed_mode;
+
+	if (speed_mode >= ARRAY_SIZE(ads112c14_fmod_div))
+		return -EINVAL;
+
+	if (filter_osr <= ADS112C14_DATA_RATE_CFG_FLTR_OSR_1024)
+		range = data->sinc_settling_time_range_available[filter_osr][speed_mode];
+	else if (filter_osr == ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS)
+		range = data->fir_settling_time_range_available[0][speed_mode];
+	else if (filter_osr == ADS112C14_DATA_RATE_CFG_FLTR_OSR_20SPS)
+		range = data->fir_settling_time_range_available[1][speed_mode];
+	else
+		return -EINVAL;
+
+	len += sysfs_emit_at(buf, len, "[");
+	for (i = 0; i < 3; i++) {
+		s64 range_val;
+		s32 int_val, rem;
+
+		range_val = iio_val_s64_compose(range[i][0], range[i][1]);
+		int_val = div_s64_rem(range_val, MICRO, &rem);
+
+		if (i)
+			len += sysfs_emit_at(buf, len, " ");
+
+		len += sysfs_emit_at(buf, len, "%d.%06d", int_val, rem);
+	}
+	len += sysfs_emit_at(buf, len, "]\n");
+
+	return len;
+}
+
 static int ads112c14_prepare_measurement_channel(struct ads112c14_data *data,
 						 const struct iio_chan_spec *chan,
 						 bool en_burnout)
@@ -639,8 +864,11 @@ static int ads112c14_prepare_measurement_channel(struct ads112c14_data *data,
 		return ret;
 
 	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DATA_RATE_CFG,
+				 ADS112C14_DATA_RATE_CFG_DELAY |
 				 ADS112C14_DATA_RATE_CFG_GC_EN |
 				 ADS112C14_DATA_RATE_CFG_FLTR_OSR,
+				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_DELAY,
+					    channel_state->delay) |
 				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_GC_EN,
 					    (measurement->global_chop &&
 					     !en_burnout) ? 1 : 0) |
@@ -728,8 +956,11 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
 		return ret;
 
 	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DATA_RATE_CFG,
+				 ADS112C14_DATA_RATE_CFG_DELAY |
 				 ADS112C14_DATA_RATE_CFG_GC_EN |
 				 ADS112C14_DATA_RATE_CFG_FLTR_OSR,
+				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_DELAY,
+					    channel_state->delay) |
 				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_GC_EN, 0) |
 				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_FLTR_OSR,
 					    channel_state->filter_osr));
@@ -788,7 +1019,8 @@ static int ads112c14_scan_read(struct ads112c14_data *data, u8 *buf)
 	return 0;
 }
 
-static int ads112c14_wait_for_conversion_irq(struct ads112c14_data *data)
+static int ads112c14_wait_for_conversion_irq(struct ads112c14_data *data,
+					     u32 settle_time_us)
 {
 	unsigned long remaining;
 	int ret;
@@ -800,13 +1032,16 @@ static int ads112c14_wait_for_conversion_irq(struct ads112c14_data *data)
 	if (ret)
 		return ret;
 
+	/* Give it 1ms more than calculated settling time. */
 	remaining = wait_for_completion_timeout(&data->drdy_completion,
-						msecs_to_jiffies(100));
+						usecs_to_jiffies(settle_time_us +
+								 1 * USEC_PER_MSEC));
 
 	return remaining ? 0 : -ETIMEDOUT;
 }
 
-static int ads112c14_wait_for_conversion_poll(struct ads112c14_data *data)
+static int ads112c14_wait_for_conversion_poll(struct ads112c14_data *data,
+					      u32 settle_time_us)
 {
 	u32 reg_val;
 	int ret;
@@ -816,10 +1051,12 @@ static int ads112c14_wait_for_conversion_poll(struct ads112c14_data *data)
 	if (ret)
 		return ret;
 
+	/* Give it 1ms more than calculated settling time. */
 	return regmap_read_poll_timeout(data->regmap,
 					ADS112C14_REG_STATUS_MSB, reg_val,
 					FIELD_GET(ADS112C14_STATUS_MSB_DRDY, reg_val),
-					1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
+					1 * USEC_PER_MSEC,
+					settle_time_us + 1 * USEC_PER_MSEC);
 }
 
 static int ads112c14_single_conversion(struct ads112c14_data *data,
@@ -827,6 +1064,8 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 				       u8 *buf, bool en_burnout, bool for_scan)
 {
 	struct i2c_client *client = to_i2c_client(regmap_get_device(data->regmap));
+	struct ads112c14_channel_state *channel_state;
+	u32 settle_time_us;
 	int ret;
 
 	guard(mutex)(&data->lock);
@@ -835,10 +1074,26 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 	if (ret)
 		return ret;
 
+	channel_state = &data->channel_states[chan->scan_index];
+	ret = ads112c14_get_settling_time_us(data, channel_state,
+					     channel_state->delay,
+					     &settle_time_us);
+	if (ret)
+		return ret;
+
+	ret = regmap_test_bits(data->regmap, ADS112C14_REG_DATA_RATE_CFG,
+			       ADS112C14_DATA_RATE_CFG_GC_EN);
+	if (ret < 0)
+		return ret;
+
+	/* Input chopping doubles the settling time. */
+	if (ret)
+		settle_time_us *= 2;
+
 	if (data->drdy_irq)
-		ret = ads112c14_wait_for_conversion_irq(data);
+		ret = ads112c14_wait_for_conversion_irq(data, settle_time_us);
 	else
-		ret = ads112c14_wait_for_conversion_poll(data);
+		ret = ads112c14_wait_for_conversion_poll(data, settle_time_us);
 	if (ret)
 		return ret;
 
@@ -1604,6 +1859,17 @@ static const struct iio_enum ads112c14_filter_type_enum = {
 };
 
 static const struct iio_chan_spec_ext_info ads112c14_ext_info[] = {
+	{
+		.name = "settlingtime",
+		.read = ads112c14_read_settling_time,
+		.write = ads112c14_write_settling_time,
+		.shared = IIO_SEPARATE,
+	},
+	{
+		.name = "settlingtime_available",
+		.read = ads112c14_read_settling_time_available,
+		.shared = IIO_SEPARATE,
+	},
 	IIO_ENUM("filter_type", IIO_SEPARATE, &ads112c14_filter_type_enum),
 	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE, &ads112c14_filter_type_enum),
 	{ }
@@ -1614,6 +1880,17 @@ static const struct iio_chan_spec_ext_info ads112c14_ext_info_burnout[] = {
 		.name = "burnoutraw",
 		.read = ads112c14_read_burnout_raw,
 	},
+	{
+		.name = "settlingtime",
+		.read = ads112c14_read_settling_time,
+		.write = ads112c14_write_settling_time,
+		.shared = IIO_SEPARATE,
+	},
+	{
+		.name = "settlingtime_available",
+		.read = ads112c14_read_settling_time_available,
+		.shared = IIO_SEPARATE,
+	},
 	IIO_ENUM("filter_type", IIO_SEPARATE, &ads112c14_filter_type_enum),
 	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE, &ads112c14_filter_type_enum),
 	{ }
@@ -1966,6 +2243,52 @@ static void ads112c14_populate_odr_tables(struct ads112c14_data *data)
 	available[1] = rem;
 }
 
+static void ads112c14_populate_settling_range_tables(struct ads112c14_data *data)
+{
+	s32 (*avail)[2];
+	u32 i, j;
+
+	for (i = 0; i < ARRAY_SIZE(ads112c14_sinc_latency_tmod); i++) {
+		for (j = 0; j < ARRAY_SIZE(ads112c14_fmod_div); j++) {
+			u64 fmod_Hz = data->fclk_Hz / ads112c14_fmod_div[j];
+			u64 start_tmod = ads112c14_sinc_latency_tmod[i][j];
+			u64 step_tmod = ads112c14_delay_to_tmod(1);
+			u64 stop_tmod = start_tmod + ads112c14_delay_to_tmod(ADS112C14_DELAY_MAX);
+			s64 start_us, step_us, stop_us;
+
+			start_us = DIV_ROUND_CLOSEST_ULL(start_tmod * USEC_PER_SEC, fmod_Hz);
+			step_us = DIV_ROUND_CLOSEST_ULL(step_tmod * USEC_PER_SEC, fmod_Hz);
+			stop_us = DIV_ROUND_CLOSEST_ULL(stop_tmod * USEC_PER_SEC, fmod_Hz);
+
+			avail = data->sinc_settling_time_range_available[i][j];
+
+			iio_val_s64_decompose(start_us, &avail[0][0], &avail[0][1]);
+			iio_val_s64_decompose(step_us, &avail[1][0], &avail[1][1]);
+			iio_val_s64_decompose(stop_us, &avail[2][0], &avail[2][1]);
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ads112c14_fir_latency_tmod); i++) {
+		for (j = 0; j < ARRAY_SIZE(ads112c14_fmod_div); j++) {
+			u64 fmod_Hz = data->fclk_Hz / ads112c14_fmod_div[j];
+			u64 start_tmod = ads112c14_fir_latency_tmod[i][j];
+			u64 step_tmod = ads112c14_delay_to_tmod(1);
+			u64 stop_tmod = start_tmod + ads112c14_delay_to_tmod(ADS112C14_DELAY_MAX);
+			s64 start_us, step_us, stop_us;
+
+			start_us = DIV_ROUND_CLOSEST_ULL(start_tmod * USEC_PER_SEC, fmod_Hz);
+			step_us = DIV_ROUND_CLOSEST_ULL(step_tmod * USEC_PER_SEC, fmod_Hz);
+			stop_us = DIV_ROUND_CLOSEST_ULL(stop_tmod * USEC_PER_SEC, fmod_Hz);
+
+			avail = data->fir_settling_time_range_available[i][j];
+
+			iio_val_s64_decompose(start_us, &avail[0][0], &avail[0][1]);
+			iio_val_s64_decompose(step_us, &avail[1][0], &avail[1][1]);
+			iio_val_s64_decompose(stop_us, &avail[2][0], &avail[2][1]);
+		}
+	}
+}
+
 static void ads112c14_populate_tables(struct ads112c14_data *data)
 {
 	u32 full_scale, fsr_bits;
@@ -2004,6 +2327,7 @@ static void ads112c14_populate_tables(struct ads112c14_data *data)
 	ads112c14_populate_scale_available(data->sys_mon_chan_short_scale_available,
 					   full_scale, fsr_bits);
 	ads112c14_populate_odr_tables(data);
+	ads112c14_populate_settling_range_tables(data);
 }
 
 static int ads112c14_probe(struct i2c_client *client)

-- 
2.43.0

