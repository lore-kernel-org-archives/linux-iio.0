Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E342248A5
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786148445; cv=none; b=nyiegbqXXXQYIzdhJnj2dKI1M3z18wei1qtxw1Ddla9FQJ+elJULJPriS87z4bJtTUZ1JJzn+ewjt0B2B9aCFyQC8Vm6AAY+lEZun3Ah7tTUe1BjMXlNwyZP79cHiqk+8G1bXvwmvBwnu6aCCUIxPt6MUlp/PXh2MkcPlejD6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786148445; c=relaxed/simple;
	bh=IwnR0LQHwDRPXs6QST6dobuzDg033S2O1RJD1JsTEfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J5/0Jo1FM+fPzbnB8IW6P9LVzlXJBYUeem4BQLZIbCpX79JiHM9GMqvZGgqpfWfW7/c6e5ey1MuLxEUtA3WEAdGptjN2cfTdrmmr/jFabHEA6ZAdf2iP2GYNwq/vQaQuyN6b18C7KiP1nGZZgArauzJhWrn9BNbAkb7v5fKZCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Sa9cYSLv; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Sa9cYSLv"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb787dec99so102988a34.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 17:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786148440; x=1786753240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5VxLVo9Nq9ehTo+s66CGHA4VBpR7u7IyPk4sGMVvasY=;
        b=Sa9cYSLvTH5LWLKMsTkadQIU60Cg1Yk32ozltxSDQZQ/16qlSU4wsCMirmfxYTqRJ9
         N+mg5NMNzd2tndtGjplF2DtrSf2IcCLwRE2vtk2A0SfxJZRiCnmdVt9afws3WBzcTL5f
         JhbuS50uIQ/4LKl5Y3Jf2pgP+q5E1jCo/TlR1hvkfTk97sAJIGUgLG0h+QQB83OMLO/v
         ofmO8PI+NCLqHuZD4WGOHfu16HDr8rQblvlm8gGnZnbZvD7U9EjvHd7zgJjkL1TP52pl
         UtWLwNYYNay3I/KAiRd6XJj0FLLSSs9dwWuMf9Y0Qpqi6rB1Z2EwkMig2cY0HzE3c/me
         5org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786148440; x=1786753240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5VxLVo9Nq9ehTo+s66CGHA4VBpR7u7IyPk4sGMVvasY=;
        b=DqmJ5/AqYhKSlX56lDBl9DfslYgP2Xx+jYwPzyX/Io8lJT8XZHCNBTTwBALSkmNZxv
         54UgmoW2BfInAZszhSSoXjCoEr49f0aPg93dnwE9kc12y6tXZsoCbp8z57GN/DNLkolt
         ke73IGedWNMDOZI7jRvKR8iHHd+qTxo03/ratNJDyVgCuCWxbYx91VR3TNtBNLTFICxA
         mVHhTfLXqLky7JN1/1hkOpiAIhl9ntzF3ttHNoTI8/vjxCYYjOneTRBOBr+XHYLP28rz
         gty5sloRqZiUb8tQOFTzycxIlMR5MUmNvrP6Mq+hOq5D34XHaA10fC1EY4HLG8vS33mt
         SbrA==
X-Gm-Message-State: AOJu0YzHg2zzEuFnyV86RJ4D1etvEXOD2WpC6jBYf0uiccRyvf3nJaLa
	08SSJvSBQMN3h2wePDCIVKzH/oRWzattF/XxCTttCX8Amz/sf1uV1xc4gzZXQ5jx5mD7UnBjwOg
	L6XKjQec=
X-Gm-Gg: AR+sD10TDK5gclA0bSq3oNj7yacKoMDDHTASPdqSksmyTLrK+6NtrGocPAudj1u/M8v
	L5ZrdOUPGKdlCrrSEp1PZp964oBfPV0/Ij266XIdgJmFshm2eCych4Jg5UxVLy1NDWgaAFgaNBV
	WqLiI+1fOYuEAVG3iO29/Q3mnVdrBb/APnjxtO/C+TlgF4wB3+a8J0wRsw0lrXJ2M7TYXxhnIhk
	EFq/Ix/bHJbo87yq27JfOIsUz4PoB0tCh5FFpm+btlla1RT8iR106AhggQcXBY5aHFYY0+mpcPT
	C+PKMYNDdRS/rAWGcM70Hpu2U2/btR9gQ+UinUnJh7rJvsZV4ZbO6381oN85M0nqXfbE/acY0KZ
	Cl7BHACi8fK09HXWF8B4TRFNfAhb/nwpD70nV8eqWvO4LkodQTWQthB+2QNNVbCUunRHDokEImI
	pSFSVPRP6t2AjvU1H2OsC0VjiyrLXJZVLHlZbj8lmLl+6q3sAFObE8nT0rCodi9WAgI53fyqKtU
	BY=
X-Received: by 2002:a05:6830:6284:b0:7e9:dd7f:7a83 with SMTP id 46e09a7af769-7f1e59bc269mr18776793a34.0.1786148439685;
        Fri, 07 Aug 2026 17:20:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b5a7616sm2526147a34.8.2026.08.07.17.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:20:39 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 19:19:49 -0500
Subject: [PATCH 4/5] iio: adc: ti-ads112c14: add settlingtime attribute
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-iio-adc-ti-ads112c14-filter-support-v1-4-4d3ba00caf18@baylibre.com>
References: <20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com>
In-Reply-To: <20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=16366;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=IwnR0LQHwDRPXs6QST6dobuzDg033S2O1RJD1JsTEfU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqdnZD/pGI5iz3Z8wQEUjq4wFYLKV3/VH4+q4rl
 O/G93igzymJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanZ2QwAKCRDCzCAB/wGP
 wKbaB/9GTOM4ElhpJ2Mdoc0ZKg5aYbPRuCBgNOFS8Wu0UtReRTqLhmmtbRKimYh+wyZKPzSxX9K
 7TaawmtmyZycpw+uC+eQAUX6oSB3hGYc4yD5ReG6jbNne+cD++eLq2qjKp58CZ7bqaPC5G0u7dI
 PnS780v/lgMdWxTFeC60lIkukoqSI0dhYNv+QzXW58RFRl+JheeQvzqGvQ0SiMwQOZXAXfkwqDb
 kgw2WrvBwlFCO4Vy+F4er2VP/gG/o9J2hJ6XK61g59LiCZsAsUhTTdOiQ8TLaopCFjvM0x2oMUY
 pR1M0s1xoPuMkypUI1g3NFJ7zvpmZWFydr9AqedrQtgibJTo
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
 drivers/iio/adc/ti-ads112c14.c | 337 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 331 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index ff22d0716abe..4cac552bb522 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -214,6 +214,24 @@ static const int ads112c14_fmod_div[] = {
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
@@ -340,6 +358,7 @@ struct ads112c14_measurement {
 struct ads112c14_channel_state {
 	u8 speed_mode;
 	u8 filter_osr;
+	u8 delay;
 };
 
 struct ads112c14_data {
@@ -365,6 +384,8 @@ struct ads112c14_data {
 	int sinc4_sample_rate_available[ARRAY_SIZE(ads112c14_sinc4_osr_available)][ARRAY_SIZE(ads112c14_fmod_div)][2];
 	int sinc4_sinc1_sample_rate_available[ARRAY_SIZE(ads112c14_sinc4_sinc1_osr_available)][ARRAY_SIZE(ads112c14_fmod_div)][2];
 	int sinc4_sinc1_pf1_sample_rate_available[2][2];
+	int sinc_settling_time_range_available[ARRAY_SIZE(ads112c14_sinc_latency_tmod)][ARRAY_SIZE(ads112c14_fmod_div)][3][2];
+	int fir_settling_time_range_available[ARRAY_SIZE(ads112c14_fir_latency_tmod)][ARRAY_SIZE(ads112c14_fmod_div)][3][2];
 	IIO_DECLARE_BUFFER_WITH_TS(__be32, scan, ADS112C14_MAX_MEASUREMENT_CHANNELS +
 						 ARRAY_SIZE(ads112c14_sys_mon_channels));
 };
@@ -572,6 +593,211 @@ static int ads112c14_get_osr(struct ads112c14_channel_state *channel_state)
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
+	u32 fixed_latency_us, delay_us;
+	u64 delay_tmod_needed;
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
+	delay_tmod_needed = DIV_ROUND_UP_ULL((u64)delay_us * fmod_Hz,
+					     USEC_PER_SEC);
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
@@ -636,8 +862,11 @@ static int ads112c14_prepare_measurement_channel(struct ads112c14_data *data,
 		return ret;
 
 	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DATA_RATE_CFG,
+				 ADS112C14_DATA_RATE_CFG_DELAY |
 				 ADS112C14_DATA_RATE_CFG_GC_EN |
 				 ADS112C14_DATA_RATE_CFG_FLTR_OSR,
+				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_DELAY,
+					    channel_state->delay) |
 				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_GC_EN,
 					    measurement->global_chop && !en_burnout) |
 				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_FLTR_OSR,
@@ -724,8 +953,11 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
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
@@ -784,7 +1016,8 @@ static int ads112c14_scan_read(struct ads112c14_data *data, u8 *buf)
 	return 0;
 }
 
-static int ads112c14_wait_for_conversion_irq(struct ads112c14_data *data)
+static int ads112c14_wait_for_conversion_irq(struct ads112c14_data *data,
+					     u32 settle_time_us)
 {
 	unsigned long remaining;
 	int ret;
@@ -796,13 +1029,16 @@ static int ads112c14_wait_for_conversion_irq(struct ads112c14_data *data)
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
@@ -812,10 +1048,12 @@ static int ads112c14_wait_for_conversion_poll(struct ads112c14_data *data)
 	if (ret)
 		return ret;
 
+	/* Give it 1ms more than calculated settling time. */
 	return regmap_read_poll_timeout(data->regmap,
 					ADS112C14_REG_STATUS_MSB, reg_val,
 					FIELD_GET(ADS112C14_STATUS_MSB_DRDY, reg_val),
-					1 * USEC_PER_MSEC, 100 * USEC_PER_MSEC);
+					1 * USEC_PER_MSEC, settle_time_us +
+							   1 * USEC_PER_MSEC);
 }
 
 static int ads112c14_single_conversion(struct ads112c14_data *data,
@@ -823,6 +1061,8 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 				       u8 *buf, bool en_burnout, bool for_scan)
 {
 	struct i2c_client *client = to_i2c_client(regmap_get_device(data->regmap));
+	struct ads112c14_channel_state *channel_state;
+	u32 settle_time_us;
 	int ret;
 
 	guard(mutex)(&data->lock);
@@ -831,10 +1071,26 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
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
 
@@ -1585,6 +1841,17 @@ static const struct iio_enum ads112c14_filter_type_enum = {
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
@@ -1595,6 +1862,17 @@ static const struct iio_chan_spec_ext_info ads112c14_ext_info_burnout[] = {
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
@@ -1941,6 +2219,52 @@ static void ads112c14_populate_odr_tables(struct ads112c14_data *data)
 	available[0] = div_u64_rem(odr_uHz, MICRO, &available[1]);
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
@@ -1979,6 +2303,7 @@ static void ads112c14_populate_tables(struct ads112c14_data *data)
 	ads112c14_populate_scale_available(data->sys_mon_chan_short_scale_available,
 					   full_scale, fsr_bits);
 	ads112c14_populate_odr_tables(data);
+	ads112c14_populate_settling_range_tables(data);
 }
 
 static int ads112c14_probe(struct i2c_client *client)

-- 
2.43.0

