Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B83410D2D;
	Fri,  8 May 2026 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259635; cv=none; b=CXmwZIdfr+ma2GOH8gX2boZFNLSYFjNlH+l2p8lPyV+CS2ir4gxA3pEEmojJ7iNRx9lEje7a/9c6SBQD37/t1LaJL2EhUQd7YsrhLVqzptcz4K+H1NGkM5u4gWmg+eI0a/7XDfMPoQzIbwHBD3RrrJCAiDfusYoNb1tFTecL4Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259635; c=relaxed/simple;
	bh=X/5e6aNGcY9U5CgmR9lO1LiShBp0lzIvVSNkcungFxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ix8xBB8/4/Pl5qOp24ne8FkymvjN+L5qoibV+1GYSbsjN+F/Q2gDLqOXOK45fcFAxpva0y8rIzoFmHC5EbEhyfr+5uYJT0xcE/sHOhUdQ1x5lgcxBrSh6sqxNIMGGQqoOU+AVaShunE1MjyehEob+fr+lf7mluca2+hsgUQuf6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkkzAG+z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkkzAG+z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6E05C2BCF4;
	Fri,  8 May 2026 17:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778259634;
	bh=X/5e6aNGcY9U5CgmR9lO1LiShBp0lzIvVSNkcungFxo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tkkzAG+z9/W8ksS1ILTNui3OdBpigVED83Krn04+tuWRmVja5CXtyx5v6bATmJlsA
	 2rh+EcNzv8tyCyfs13MM2IujaICIs5c+enBNqRZYtrVLsDBgfbLDWobpOiclenwfjH
	 dS7LzwmnStEnUXeuxgN9UWc8wmqEP+OaHEYgsNi9ONYI/X/rseFIDXHNjWzWWx71Wi
	 8BVk3AkMLqhu5dYyjfLjn6NGSqzNEq3i57AbKzKlSuHqY/ZXizscWCtXqYgH7j6Vhg
	 5qhQXMk7knO3slvPbKBofKxBXl2Ec6VRrz+K9042mBxsZ6p23whyIU12cib0DsTxxa
	 0NJlEL7ZiH3Sw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD0ACD342F;
	Fri,  8 May 2026 17:00:34 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 08 May 2026 18:00:23 +0100
Subject: [PATCH RFC v4 07/10] iio: frequency: ad9910: add output shift
 keying support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-ad9910-iio-driver-v4-7-d26bfd20ee3d@analog.com>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
In-Reply-To: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778259632; l=10875;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=b2CcyxE0Rr3Mz5XNjuTy+cAHMtlJFXE9ZnsfuaQe3Pc=;
 b=wv33V9V3nsckTQDMKhbl3GdsLUM9iS/Ah1zgIVIQLu7gZsoR9smEpOWpMDzbOPby5bcy0/KbK
 LYat35HUxA7DWRUcjeF2NmllLPQJ2YmMVCQYEmQDYBeBgtC4z+4L7qt
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add OSK channel with amplitude envelope control capabilities:
- OSK enable/disable via IIO_CHAN_INFO_ENABLE;
- Amplitude ramp rate control via IIO_CHAN_INFO_SAMP_FREQ;
- Amplitude scale readback via IIO_CHAN_INFO_SCALE (ASF register);
- Automatic OSK step size configurable througth the scale_roc extended
  attribute, which allows for selectable step sizes in nano-units:
	- 0: no step, means manual mode (NOT pin controlled)
	- 61035: 1/2^14 step, automatic mode (pin controlled)
	- 122070: 2/2^14 step, automatic mode (pin controlled)
	- 244141: 4/2^14 step, automatic mode (pin controlled)
	- 488281: 8/2^14 step, automatic mode (pin controlled)
	- 1000000000: 1.0 step, manual mode (pin controlled)

The ASF register is initialized with a default amplitude ramp rate during
device setup to ensure valid readback.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/frequency/ad9910.c | 192 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
index a153cd01e6f5..1fdbaba356d7 100644
--- a/drivers/iio/frequency/ad9910.c
+++ b/drivers/iio/frequency/ad9910.c
@@ -233,6 +233,7 @@
  * @AD9910_CHANNEL_DRG_RAMP_UP: DRG ramp up channel
  * @AD9910_CHANNEL_DRG_RAMP_DOWN: DRG ramp down channel
  * @AD9910_CHANNEL_RAM: RAM control output channel
+ * @AD9910_CHANNEL_OSK: Output Shift Keying output channel
  */
 enum ad9910_channel {
 	AD9910_CHANNEL_PHY = 100,
@@ -249,6 +250,7 @@ enum ad9910_channel {
 	AD9910_CHANNEL_DRG_RAMP_UP = 121,
 	AD9910_CHANNEL_DRG_RAMP_DOWN = 122,
 	AD9910_CHANNEL_RAM = 130,
+	AD9910_CHANNEL_OSK = 140,
 };
 
 /**
@@ -302,6 +304,7 @@ enum {
 	AD9910_CHAN_IDX_DRG_RAMP_UP,
 	AD9910_CHAN_IDX_DRG_RAMP_DOWN,
 	AD9910_CHAN_IDX_RAM,
+	AD9910_CHAN_IDX_OSK,
 };
 
 enum {
@@ -314,6 +317,8 @@ enum {
 	AD9910_DRG_PHASE_ROC,
 	AD9910_DRG_AMP_ROC,
 	AD9910_DRG_DWELL_EN,
+	AD9910_OSK_AUTO_ROC,
+	AD9910_OSK_AUTO_ROC_AVAIL,
 };
 
 struct ad9910_data {
@@ -980,6 +985,134 @@ static ssize_t ad9910_drg_attrs_write(struct iio_dev *indio_dev,
 	return len;
 }
 
+static const u32 ad9910_osk_nstep[] = {
+	0,	/* no step: manual mode (NOT pin controlled) */
+	61035,	/* 1/2^14 step: automatic mode (pin controlled) */
+	122070,	/* 2/2^14 step: automatic mode (pin controlled) */
+	244141,	/* 4/2^14 step: automatic mode (pin controlled) */
+	488281,	/* 8/2^14 step: automatic mode (pin controlled) */
+	NANO,	/* full scale step: manual mode (pin controlled) */
+};
+
+static ssize_t ad9910_osk_attrs_read(struct iio_dev *indio_dev,
+				     uintptr_t private,
+				     const struct iio_chan_spec *chan,
+				     char *buf)
+{
+	struct ad9910_state *st = iio_priv(indio_dev);
+	bool auto_en, pinctrl_en;
+	u32 rate, step;
+	int vals[2];
+	u64 roc64;
+
+	guard(mutex)(&st->lock);
+
+	rate = 4 * FIELD_GET(AD9910_ASF_RAMP_RATE_MSK,
+			     st->reg[AD9910_REG_ASF].val32);
+	if (!rate)
+		return -ERANGE;
+
+	switch (private) {
+	case AD9910_OSK_AUTO_ROC:
+		auto_en = FIELD_GET(AD9910_CFR1_SELECT_AUTO_OSK_MSK,
+				    st->reg[AD9910_REG_CFR1].val32);
+		pinctrl_en = FIELD_GET(AD9910_CFR1_OSK_MANUAL_EXT_CTL_MSK,
+				       st->reg[AD9910_REG_CFR1].val32);
+		if (auto_en) {
+			step = FIELD_GET(AD9910_ASF_STEP_SIZE_MSK,
+					 st->reg[AD9910_REG_ASF].val32);
+			step = ad9910_osk_nstep[step + 1];
+		} else if (pinctrl_en) {
+			step = ad9910_osk_nstep[ARRAY_SIZE(ad9910_osk_nstep) - 1];
+		} else {
+			step = ad9910_osk_nstep[0];
+		}
+
+		roc64 = div_u64((u64)step * st->data.sysclk_freq_hz, rate);
+		vals[0] = div_s64_rem(roc64, NANO, &vals[1]);
+		return iio_format_value(buf, IIO_VAL_INT_PLUS_NANO,
+					ARRAY_SIZE(vals), vals);
+	case AD9910_OSK_AUTO_ROC_AVAIL: {
+		ssize_t len = 0;
+
+		for (unsigned int i = 0; i < ARRAY_SIZE(ad9910_osk_nstep); i++) {
+			roc64 = div_u64((u64)ad9910_osk_nstep[i] *
+					st->data.sysclk_freq_hz, rate);
+			vals[0] = div_s64_rem(roc64, NANO, &vals[1]);
+			if (!vals[1])
+				len += sysfs_emit_at(buf, len, "%d ", vals[0]);
+			else
+				len += sysfs_emit_at(buf, len, "%d.%09d ",
+						     vals[0], vals[1]);
+		}
+
+		buf[len - 1] = '\n'; /* replace last space with a newline */
+		return len;
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t ad9910_osk_attrs_write(struct iio_dev *indio_dev,
+				      uintptr_t private,
+				      const struct iio_chan_spec *chan,
+				      const char *buf, size_t len)
+{
+	struct ad9910_state *st = iio_priv(indio_dev);
+	int val, val2, ret;
+	u32 idx, cfg, rate;
+	u64 nstep;
+
+	ret = iio_str_to_fixpoint(buf, NANO / 10, &val, &val2);
+	if (ret)
+		return ret;
+
+	if (val < 0 || val2 < 0)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+
+	rate = 4 * FIELD_GET(AD9910_ASF_RAMP_RATE_MSK,
+			     st->reg[AD9910_REG_ASF].val32);
+	if (!rate)
+		return -ERANGE;
+
+	switch (private) {
+	case AD9910_OSK_AUTO_ROC:
+		nstep = ad9910_rational_scale((u64)val * NANO + val2, rate,
+					      st->data.sysclk_freq_hz);
+		idx = find_closest(nstep, ad9910_osk_nstep,
+				   ARRAY_SIZE(ad9910_osk_nstep));
+		if (idx == ARRAY_SIZE(ad9910_osk_nstep) - 1) {
+			cfg = AD9910_CFR1_OSK_MANUAL_EXT_CTL_MSK;
+		} else if (idx == 0) {
+			cfg = 0;
+		} else {
+			cfg = FIELD_PREP(AD9910_ASF_STEP_SIZE_MSK, idx - 1);
+			ret = ad9910_reg32_update(st, AD9910_REG_ASF,
+						  AD9910_ASF_STEP_SIZE_MSK,
+						  cfg, false);
+			if (ret)
+				return ret;
+
+			cfg = AD9910_CFR1_SELECT_AUTO_OSK_MSK;
+		}
+
+		ret = ad9910_reg32_update(st, AD9910_REG_CFR1,
+					  AD9910_CFR1_SELECT_AUTO_OSK_MSK |
+					  AD9910_CFR1_OSK_MANUAL_EXT_CTL_MSK,
+					  cfg, true);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return len;
+}
+
 #define AD9910_EXT_INFO_TMPL(_name, _ident, _shared, _fn_desc) { \
 	.name = _name, \
 	.read = ad9910_ ## _fn_desc ## _read, \
@@ -997,6 +1130,9 @@ static ssize_t ad9910_drg_attrs_write(struct iio_dev *indio_dev,
 #define AD9910_DRG_EXT_INFO(_name, _ident) \
 	AD9910_EXT_INFO_TMPL(_name, _ident, IIO_SEPARATE, drg_attrs)
 
+#define AD9910_OSK_EXT_INFO(_name, _ident) \
+	AD9910_EXT_INFO_TMPL(_name, _ident, IIO_SEPARATE, osk_attrs)
+
 static const struct iio_chan_spec_ext_info ad9910_phy_ext_info[] = {
 	AD9910_EXT_INFO("powerdown", AD9910_POWERDOWN, IIO_SEPARATE),
 	{ }
@@ -1018,6 +1154,12 @@ static const struct iio_chan_spec_ext_info ad9910_drg_ramp_ext_info[] = {
 	{ }
 };
 
+static const struct iio_chan_spec_ext_info ad9910_osk_ext_info[] = {
+	AD9910_OSK_EXT_INFO("scale_roc", AD9910_OSK_AUTO_ROC),
+	AD9910_OSK_EXT_INFO("scale_roc_available", AD9910_OSK_AUTO_ROC_AVAIL),
+	{ }
+};
+
 #define AD9910_PROFILE_CHAN(idx) {				\
 	.type = IIO_ALTVOLTAGE,					\
 	.indexed = 1,						\
@@ -1102,6 +1244,17 @@ static const struct iio_chan_spec ad9910_channels[] = {
 				      BIT(IIO_CHAN_INFO_PHASE) |
 				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
+	[AD9910_CHAN_IDX_OSK] = {
+		.type = IIO_ALTVOLTAGE,
+		.indexed = 1,
+		.output = 1,
+		.channel = AD9910_CHANNEL_OSK,
+		.address = AD9910_CHAN_IDX_OSK,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.ext_info = ad9910_osk_ext_info,
+	},
 };
 
 static int ad9910_read_raw(struct iio_dev *indio_dev,
@@ -1134,6 +1287,10 @@ static int ad9910_read_raw(struct iio_dev *indio_dev,
 			*val = FIELD_GET(AD9910_CFR1_RAM_ENABLE_MSK,
 					 st->reg[AD9910_REG_CFR1].val32);
 			break;
+		case AD9910_CHANNEL_OSK:
+			*val = FIELD_GET(AD9910_CFR1_OSK_ENABLE_MSK,
+					 st->reg[AD9910_REG_CFR1].val32);
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1239,6 +1396,12 @@ static int ad9910_read_raw(struct iio_dev *indio_dev,
 			*val = 0;
 			*val2 = tmp64 * NANO >> 32;
 			return IIO_VAL_INT_PLUS_NANO;
+		case AD9910_CHANNEL_OSK:
+			tmp64 = FIELD_GET(AD9910_ASF_SCALE_FACTOR_MSK,
+					  st->reg[AD9910_REG_ASF].val32);
+			*val = 0;
+			*val2 = tmp64 * MICRO >> 14;
+			return IIO_VAL_INT_PLUS_MICRO;
 		default:
 			return -EINVAL;
 		}
@@ -1259,6 +1422,10 @@ static int ad9910_read_raw(struct iio_dev *indio_dev,
 			tmp32 = FIELD_GET(AD9910_PROFILE_RAM_STEP_RATE_MSK,
 					  ad9910_ram_profile_val(st));
 			break;
+		case AD9910_CHANNEL_OSK:
+			tmp32 = FIELD_GET(AD9910_ASF_RAMP_RATE_MSK,
+					  st->reg[AD9910_REG_ASF].val32);
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1326,6 +1493,11 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
 			return ad9910_reg32_update(st, AD9910_REG_CFR1,
 						   AD9910_CFR1_RAM_ENABLE_MSK,
 						   tmp32, true);
+		case AD9910_CHANNEL_OSK:
+			tmp32 = FIELD_PREP(AD9910_CFR1_OSK_ENABLE_MSK, val);
+			return ad9910_reg32_update(st, AD9910_REG_CFR1,
+						   AD9910_CFR1_OSK_ENABLE_MSK,
+						   tmp32, true);
 		default:
 			return -EINVAL;
 		}
@@ -1495,6 +1667,14 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
 			return ad9910_reg64_update(st, AD9910_REG_DRG_LIMIT,
 						   AD9910_DRG_LIMIT_LOWER_MSK,
 						   tmp64, true);
+		case AD9910_CHANNEL_OSK:
+			tmp64 = ((u64)val * MICRO + val2) << 14;
+			tmp64 = DIV_U64_ROUND_CLOSEST(tmp64, MICRO);
+			tmp32 = min(tmp64, AD9910_ASF_MAX);
+			tmp32 = FIELD_PREP(AD9910_ASF_SCALE_FACTOR_MSK, tmp32);
+			return ad9910_reg32_update(st, AD9910_REG_ASF,
+						   AD9910_ASF_SCALE_FACTOR_MSK,
+						   tmp32, true);
 		default:
 			return -EINVAL;
 		}
@@ -1531,6 +1711,11 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
 			return ad9910_reg64_update(st, AD9910_REG_PROFILE(st->profile),
 						   AD9910_PROFILE_RAM_STEP_RATE_MSK,
 						   tmp64, true);
+		case AD9910_CHANNEL_OSK:
+			return ad9910_reg32_update(st, AD9910_REG_ASF,
+						   AD9910_ASF_RAMP_RATE_MSK,
+						   FIELD_PREP(AD9910_ASF_RAMP_RATE_MSK, tmp32),
+						   true);
 		default:
 			return -EINVAL;
 		}
@@ -1630,6 +1815,7 @@ static const char * const ad9910_channel_str[] = {
 	[AD9910_CHAN_IDX_DRG_RAMP_UP] = "digital_ramp_up",
 	[AD9910_CHAN_IDX_DRG_RAMP_DOWN] = "digital_ramp_down",
 	[AD9910_CHAN_IDX_RAM] = "ram_control",
+	[AD9910_CHAN_IDX_OSK] = "output_shift_keying",
 };
 
 static int ad9910_read_label(struct iio_dev *indio_dev,
@@ -1873,6 +2059,12 @@ static int ad9910_setup(struct device *dev, struct ad9910_state *st,
 		return ret;
 
 	/* configure step rate with default values */
+	ret = ad9910_reg32_write(st, AD9910_REG_ASF,
+				 FIELD_PREP(AD9910_ASF_RAMP_RATE_MSK, 1),
+				 false);
+	if (ret)
+		return ret;
+
 	ret = ad9910_reg32_write(st, AD9910_REG_DRG_RATE,
 				 FIELD_PREP(AD9910_DRG_RATE_DEC_MSK, 1) |
 				 FIELD_PREP(AD9910_DRG_RATE_INC_MSK, 1),

-- 
2.43.0


