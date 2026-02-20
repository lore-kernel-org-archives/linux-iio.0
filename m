Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B8A2F363E;
	Fri, 20 Feb 2026 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771605988; cv=none; b=PajqEluBccfd4mCulTvRca+IofrZcZIj+MpmR+QHxWswaIoiOMzLwRoBrWFUE96DsWxzBJIDZZEjmFO/VK+KYTuC+IXsDib8x+dE/sEAgtnZg6ujzbAwa50LlRW/V+aGMO+4Ba9089qnlZeJok/g5c4odx9x793++UKSjWzgmAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771605988; c=relaxed/simple;
	bh=YcTSjqbVWu6Xr9ACczmW9EElxjh+dpTgfi5MEn3LsrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QypRtsS+Jg3C6CdyWhgBtDPLPbrRKjc+dKKXPrS29kTuNKgt1YzLdkJ/KQhW33PMiliezlolQ50jOV/M0AW9cMAW/1stKsZJ7X6WIL2cS1xsyo2EGfV8A3mSzcjS7vIqmArHr3FPtqBY6HBYn76My76BOp6j628QKEqSeKVAG5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsOKHFCz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsOKHFCz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1AEFC2BC9E;
	Fri, 20 Feb 2026 16:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771605987;
	bh=YcTSjqbVWu6Xr9ACczmW9EElxjh+dpTgfi5MEn3LsrI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YsOKHFCzQGRwrKmtR4B9NHQL7zm1DgBuTunsOlpqrp0/8LRxGPO+WMlJquakrMmOh
	 mtaH4GAH3pOnK7Qqmf7y9kbXfE89co4/LwBHxVa7z0YjymYtLHqY2iZkvl5bVWc5rj
	 TtvfJnrOEL5wSW2MF07uRpLPzrjxR4xR4ekk6uFZN1uJJn0AX8nbAH6CoujHacf0/B
	 ibSRyF7K9j+gm6GMJ8H8Tgv7ESPSfgb8GSTWTnM/JCMXA0OQMCLk4MWG1+kwKp6FsD
	 NO46F6JZZ2VxaAJktkbUi1m72d5BIhBhdgnRAbNN5g1LxLGHGtgvnIRaVeRgDtyVkZ
	 hwa/+u4Ujhn4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C20C5ACD3;
	Fri, 20 Feb 2026 16:46:27 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 20 Feb 2026 16:46:07 +0000
Subject: [PATCH RFC 3/8] iio: frequency: ad9910: add simple parallel port
 mode support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-ad9910-iio-driver-v1-3-3b264aa48a10@analog.com>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
In-Reply-To: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771605986; l=8528;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=EK0WTQcP1PVBIImMgpG+WQS3qmLgwZLDh81TfAy8jIo=;
 b=9V6InTEI7nScWJlEQAoe/y073K7EEPKEx1EALAup/arUXNOlyxA2Lapd/0Igo6EUfzn29RNER
 YmWNekMl5D5DFA5orSqQ3WyT0jg+N2yn0gF8eZ7i6cfaZVCUldyJGxp
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add parallel port channel with frequency scale, frequency offset, phase
offset, and amplitude offset extended attributes for configuring the
parallel data path.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/frequency/ad9910.c | 167 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
index 82b817c05975..bb280972e84c 100644
--- a/drivers/iio/frequency/ad9910.c
+++ b/drivers/iio/frequency/ad9910.c
@@ -115,9 +115,13 @@
 /* Auxiliary DAC Control Register Bits */
 #define AD9910_AUX_DAC_FSC_MSK			GENMASK(7, 0)
 
+/* POW Register Bits */
+#define AD9910_POW_PP_LSB_MSK			GENMASK(7, 0)
+
 /* ASF Register Bits */
 #define AD9910_ASF_RAMP_RATE_MSK		GENMASK(31, 16)
 #define AD9910_ASF_SCALE_FACTOR_MSK		GENMASK(15, 2)
+#define AD9910_ASF_SCALE_FACTOR_PP_LSB_MSK	GENMASK(7, 2)
 #define AD9910_ASF_STEP_SIZE_MSK		GENMASK(1, 0)
 
 /* Multichip Sync Register Bits */
@@ -141,7 +145,9 @@
 #define AD9910_MAX_PHASE_MICRORAD	(AD9910_PI_NANORAD / 500)
 
 #define AD9910_ASF_MAX			(BIT(14) - 1)
+#define AD9910_ASF_PP_LSB_MAX		(BIT(6) - 1)
 #define AD9910_POW_MAX			(BIT(16) - 1)
+#define AD9910_POW_PP_LSB_MAX		(BIT(8) - 1)
 #define AD9910_NUM_PROFILES		8
 
 /* PLL constants */
@@ -185,11 +191,16 @@
  */
 enum ad9910_channel {
 	AD9910_CHANNEL_SINGLE_TONE,
+	AD9910_CHANNEL_PARALLEL_PORT,
 };
 
 enum {
 	AD9910_PROFILE,
 	AD9910_POWERDOWN,
+	AD9910_PP_FREQ_SCALE,
+	AD9910_PP_FREQ_OFFSET,
+	AD9910_PP_PHASE_OFFSET,
+	AD9910_PP_AMP_OFFSET,
 };
 
 struct ad9910_data {
@@ -388,6 +399,10 @@ static ssize_t ad9910_ext_info_read(struct iio_dev *indio_dev,
 		val = !!FIELD_GET(AD9910_CFR1_SOFT_POWER_DOWN_MSK,
 				  st->reg[AD9910_REG_CFR1].val32);
 		break;
+	case AD9910_PP_FREQ_SCALE:
+		val = BIT(FIELD_GET(AD9910_CFR2_FM_GAIN_MSK,
+				    st->reg[AD9910_REG_CFR2].val32));
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -423,6 +438,15 @@ static ssize_t ad9910_ext_info_write(struct iio_dev *indio_dev,
 					  AD9910_CFR1_SOFT_POWER_DOWN_MSK,
 					  val32, true);
 		break;
+	case AD9910_PP_FREQ_SCALE:
+		if (val32 > BIT(15) || !is_power_of_2(val32))
+			return -EINVAL;
+
+		val32 = FIELD_PREP(AD9910_CFR2_FM_GAIN_MSK, ilog2(val32));
+		ret = ad9910_reg32_update(st, AD9910_REG_CFR2,
+					  AD9910_CFR2_FM_GAIN_MSK,
+					  val32, true);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -430,20 +454,126 @@ static ssize_t ad9910_ext_info_write(struct iio_dev *indio_dev,
 	return ret ?: len;
 }
 
-#define AD9910_EXT_INFO(_name, _ident, _shared) { \
+static ssize_t ad9910_pp_attrs_read(struct iio_dev *indio_dev,
+				    uintptr_t private,
+				    const struct iio_chan_spec *chan,
+				    char *buf)
+{
+	struct ad9910_state *st = iio_priv(indio_dev);
+	int vals[2];
+	u32 tmp32;
+	u64 tmp64;
+
+	guard(mutex)(&st->lock);
+
+	switch (private) {
+	case AD9910_PP_FREQ_OFFSET:
+		tmp64 = (u64)st->reg[AD9910_REG_FTW].val32 * st->data.sysclk_freq_hz;
+		vals[0] = upper_32_bits(tmp64);
+		vals[1] = upper_32_bits((u64)lower_32_bits(tmp64) * MICRO);
+		break;
+	case AD9910_PP_PHASE_OFFSET:
+		tmp32 = FIELD_GET(AD9910_POW_PP_LSB_MSK,
+				  st->reg[AD9910_REG_POW].val16);
+		tmp32 = (tmp32 * AD9910_MAX_PHASE_MICRORAD) >> 16;
+		vals[0] = tmp32 / MICRO;
+		vals[1] = tmp32 % MICRO;
+		break;
+	case AD9910_PP_AMP_OFFSET:
+		tmp32 = FIELD_GET(AD9910_ASF_SCALE_FACTOR_PP_LSB_MSK,
+				  st->reg[AD9910_REG_ASF].val32);
+		vals[0] = 0;
+		vals[1] = (u64)tmp32 * MICRO >> 14;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(vals), vals);
+}
+
+static ssize_t ad9910_pp_attrs_write(struct iio_dev *indio_dev,
+				     uintptr_t private,
+				     const struct iio_chan_spec *chan,
+				     const char *buf, size_t len)
+{
+	struct ad9910_state *st = iio_priv(indio_dev);
+	int val, val2;
+	u32 tmp32;
+	int ret;
+
+	ret = iio_str_to_fixpoint(buf, MICRO / 10, &val, &val2);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+
+	switch (private) {
+	case AD9910_PP_FREQ_OFFSET:
+		if (val < 0 || val >= st->data.sysclk_freq_hz / 2)
+			return -EINVAL;
+
+		tmp32 = ad9910_rational_scale((u64)val * MICRO + val2, BIT_ULL(32),
+					      (u64)MICRO * st->data.sysclk_freq_hz);
+		ret = ad9910_reg32_write(st, AD9910_REG_FTW, tmp32, true);
+		break;
+	case AD9910_PP_PHASE_OFFSET:
+		if (val != 0 || val2 < 0 || val2 >= (AD9910_MAX_PHASE_MICRORAD >> 8))
+			return -EINVAL;
+
+		tmp32 = DIV_ROUND_CLOSEST((u32)val2 << 16, AD9910_MAX_PHASE_MICRORAD);
+		tmp32 = min(tmp32, AD9910_POW_PP_LSB_MAX);
+		tmp32 = FIELD_PREP(AD9910_POW_PP_LSB_MSK, tmp32);
+		ret = ad9910_reg16_update(st, AD9910_REG_POW,
+					  AD9910_POW_PP_LSB_MSK,
+					  tmp32, true);
+		break;
+	case AD9910_PP_AMP_OFFSET:
+		if (val != 0 || val2 < 0 || val2 >= (MICRO >> 8))
+			return -EINVAL;
+
+		tmp32 = DIV_ROUND_CLOSEST((u32)val2 << 14, MICRO);
+		tmp32 = min(tmp32, AD9910_ASF_PP_LSB_MAX);
+		tmp32 = FIELD_PREP(AD9910_ASF_SCALE_FACTOR_PP_LSB_MSK, tmp32);
+		ret = ad9910_reg32_update(st, AD9910_REG_ASF,
+					  AD9910_ASF_SCALE_FACTOR_PP_LSB_MSK,
+					  tmp32, true);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret ?: len;
+}
+
+#define AD9910_EXT_INFO_TMPL(_name, _ident, _shared, _fn_desc) { \
 	.name = _name, \
-	.read = ad9910_ext_info_read, \
-	.write = ad9910_ext_info_write, \
+	.read = ad9910_ ## _fn_desc ## _read, \
+	.write = ad9910_ ## _fn_desc ## _write, \
 	.private = _ident, \
 	.shared = _shared, \
 }
 
+#define AD9910_EXT_INFO(_name, _ident, _shared) \
+	AD9910_EXT_INFO_TMPL(_name, _ident, _shared, ext_info)
+
+#define AD9910_PP_EXT_INFO(_name, _ident) \
+	AD9910_EXT_INFO_TMPL(_name, _ident, IIO_SEPARATE, pp_attrs)
+
 static const struct iio_chan_spec_ext_info ad9910_shared_ext_info[] = {
 	AD9910_EXT_INFO("profile", AD9910_PROFILE, IIO_SHARED_BY_TYPE),
 	AD9910_EXT_INFO("powerdown", AD9910_POWERDOWN, IIO_SHARED_BY_TYPE),
 	{ },
 };
 
+static const struct iio_chan_spec_ext_info ad9910_pp_ext_info[] = {
+	AD9910_EXT_INFO("frequency_scale", AD9910_PP_FREQ_SCALE, IIO_SEPARATE),
+	AD9910_PP_EXT_INFO("frequency_offset", AD9910_PP_FREQ_OFFSET),
+	AD9910_PP_EXT_INFO("phase_offset", AD9910_PP_PHASE_OFFSET),
+	AD9910_PP_EXT_INFO("scale_offset", AD9910_PP_AMP_OFFSET),
+	{ },
+};
+
 static const struct iio_chan_spec ad9910_channels[] = {
 	[AD9910_CHANNEL_SINGLE_TONE] = {
 		.type = IIO_ALTVOLTAGE,
@@ -456,6 +586,14 @@ static const struct iio_chan_spec ad9910_channels[] = {
 				      BIT(IIO_CHAN_INFO_SCALE),
 		.ext_info = ad9910_shared_ext_info,
 	},
+	[AD9910_CHANNEL_PARALLEL_PORT] = {
+		.type = IIO_ALTVOLTAGE,
+		.indexed = 1,
+		.output = 1,
+		.channel = AD9910_CHANNEL_PARALLEL_PORT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE),
+		.ext_info = ad9910_pp_ext_info,
+	},
 };
 
 static int ad9910_read_raw(struct iio_dev *indio_dev,
@@ -469,6 +607,16 @@ static int ad9910_read_raw(struct iio_dev *indio_dev,
 	guard(mutex)(&st->lock);
 
 	switch (info) {
+	case IIO_CHAN_INFO_ENABLE:
+		switch (chan->channel) {
+		case AD9910_CHANNEL_PARALLEL_PORT:
+			*val = FIELD_GET(AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
+					 st->reg[AD9910_REG_CFR2].val32);
+			break;
+		default:
+			return -EINVAL;
+		}
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_FREQUENCY:
 		tmp32 = FIELD_GET(AD9910_PROFILE_ST_FTW_MSK,
 				  st->reg[AD9910_REG_PROFILE(st->profile)].val64);
@@ -506,6 +654,17 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
 	guard(mutex)(&st->lock);
 
 	switch (info) {
+	case IIO_CHAN_INFO_ENABLE:
+		val = val ? 1 : 0;
+		switch (chan->channel) {
+		case AD9910_CHANNEL_PARALLEL_PORT:
+			tmp32 = FIELD_PREP(AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK, val);
+			return ad9910_reg32_update(st, AD9910_REG_CFR2,
+						   AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
+						   tmp32, true);
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_FREQUENCY:
 		if (val < 0 || val >= st->data.sysclk_freq_hz / 2)
 			return -EINVAL;
@@ -548,6 +707,8 @@ static int ad9910_write_raw_get_fmt(struct iio_dev *indio_dev,
 				    long mask)
 {
 	switch (mask) {
+	case IIO_CHAN_INFO_ENABLE:
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_FREQUENCY:
 	case IIO_CHAN_INFO_PHASE:
 	case IIO_CHAN_INFO_SCALE:

-- 
2.43.0


