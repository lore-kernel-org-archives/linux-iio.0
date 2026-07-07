Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930E7426D0B;
	Tue,  7 Jul 2026 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433068; cv=none; b=Y+yZXORO0vVQJq7Q6foFaSmZYVo0GXa7DtlsxMXf2qMN0pcxhca6E1m+g3LSAyuYXPTk6rmGUi89e7TY6huJB4vcH+9eRD6DFNXLX84IivZyCRnraG5yGI/z3b6Io+IBH+vuMVn4iOl/kXu++EEmDeWE8XS07LqdrFUHTGCOr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433068; c=relaxed/simple;
	bh=OIvQT0tXx25dyxP73prTJO2JftQ0uW1yk0rlfN5wjPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g5le/l/bhwVu4fUe/abqCEIhl5yQOJRBUSBu44KCfV3rg8JZCSkHpYD+cq0S+PvIP63WTvUNT6q7fZkxSS6g1DRj3CnLuMDF7WkXA17jf0dJHYliOUlg+mXSQrHZzF6T4DrwrVdVps0duSAh3tMsU+XmlBqTMti+QFOqySdMcds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DclFk4RI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DclFk4RI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64DF3C4AF0C;
	Tue,  7 Jul 2026 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783433068;
	bh=OIvQT0tXx25dyxP73prTJO2JftQ0uW1yk0rlfN5wjPM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DclFk4RIJggfcG3uEPETVf23XBvPZ7qLrtW37xSljC+r0fTiQ2FJYToMU+8MhoCb/
	 DwqjE5WHSvMeGckeDaw0fgtkt4KPMsb1AFsj81qpT9780rH9I/1fKFELMy1NscjRnX
	 3gXqW2RSlSKEv5m4ZOznYlHDUqAEt4mJkrtzoma9Drw3W6Har4ipYtwudqbnJqGFLR
	 ez/1IRLh0/w8E02wHkgL8+v5I+R2h+CwGyo2PRHCJdHsbsSWbB6Y91u2zNBk7ZuTEi
	 cPHENMz86FDcq78k+1m/LRd4CV7lNuygx1o2iWBHpLhm6vYGKB/vh3TGUSsbatP4CX
	 sC36T7eDqybfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E78C44501;
	Tue,  7 Jul 2026 14:04:28 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 07 Jul 2026 15:04:35 +0100
Subject: [PATCH v7 14/17] iio: frequency: ad9910: add output shift keying
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-ad9910-iio-driver-v7-14-a4ec30f63700@analog.com>
References: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
In-Reply-To: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783433065; l=10548;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=UCqsHoBd5Eh93CG44GD06F1G6TSHpYhCXLxz7ZCx94w=;
 b=81bH6iA7ATCZ4OCq/0HnbbtIzhUnT5B8BUeq93Pon/hp+7tiZfEnJlSXDoB23+7DLPRtPwSjC
 1EL63+hYq4wCtgSQJ9f+shFPxt1HRSNzejeBFJhKAkMl5+ZXJ4Syxay
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
- Amplitude scale factor readback via IIO_CHAN_INFO_RAW (ASF register);
- Automatic OSK step size configurable through the raw_roc extended
  attribute, which allows for selectable step sizes in raw units:
	- 0: no step, means manual mode (NOT pin controlled)
	- 1: I_FS / 2^14 step, automatic mode (pin controlled)
	- 2: 2 I_FS / 2^14 step, automatic mode (pin controlled)
	- 4: 4 I_FS / 2^14 step, automatic mode (pin controlled)
	- 8: 8 I_FS / 2^14 step, automatic mode (pin controlled)
	- 16383: I_FS step (max), manual mode (pin controlled)

The ASF register is initialized with a default amplitude ramp rate during
device setup to ensure valid readback.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/frequency/ad9910.c | 191 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 191 insertions(+)

diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
index f6550cc9717e..e7d5415b7d07 100644
--- a/drivers/iio/frequency/ad9910.c
+++ b/drivers/iio/frequency/ad9910.c
@@ -242,6 +242,7 @@
  * @AD9910_CHANNEL_DRG_RAMP_UP: DRG ramp up channel
  * @AD9910_CHANNEL_DRG_RAMP_DOWN: DRG ramp down channel
  * @AD9910_CHANNEL_RAM: RAM control output channel
+ * @AD9910_CHANNEL_OSK: Output Shift Keying output channel
  */
 enum ad9910_channel {
 	AD9910_CHANNEL_PHY = 100,
@@ -259,6 +260,7 @@ enum ad9910_channel {
 	AD9910_CHANNEL_DRG_RAMP_UP = 131,
 	AD9910_CHANNEL_DRG_RAMP_DOWN = 132,
 	AD9910_CHANNEL_RAM = 140,
+	AD9910_CHANNEL_OSK = 150,
 };
 
 /**
@@ -309,12 +311,14 @@ enum {
 	AD9910_CHAN_IDX_DRG_AMP_RAMP_UP,
 	AD9910_CHAN_IDX_DRG_AMP_RAMP_DOWN,
 	AD9910_CHAN_IDX_RAM,
+	AD9910_CHAN_IDX_OSK,
 };
 
 enum {
 	AD9910_POWERDOWN,
 	AD9910_DWELL_EN,
 	AD9910_ROC,
+	AD9910_ROC_AVAIL,
 };
 
 struct ad9910_data {
@@ -769,6 +773,125 @@ static ssize_t ad9910_drg_roc_write(struct iio_dev *indio_dev,
 	return len;
 }
 
+static const u32 ad9910_osk_raw_step[] = {
+	0,		/* no step: manual mode (NOT pin controlled) */
+	1,		/* step size 1: automatic mode (pin controlled) */
+	2,		/* step size 2: automatic mode (pin controlled) */
+	4,		/* step size 4: automatic mode (pin controlled) */
+	8,		/* step size 8: automatic mode (pin controlled) */
+	GENMASK(13, 0),	/* max step: manual mode (pin controlled) */
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
+	u64 roc64;
+
+	guard(mutex)(&st->lock);
+
+	rate = FIELD_GET(AD9910_ASF_RAMP_RATE_MSK, st->reg[AD9910_REG_ASF].val32);
+	if (!rate)
+		return -ERANGE;
+
+	switch (private) {
+	case AD9910_ROC:
+		auto_en = FIELD_GET(AD9910_CFR1_SELECT_AUTO_OSK_MSK,
+				    st->reg[AD9910_REG_CFR1].val32);
+		pinctrl_en = FIELD_GET(AD9910_CFR1_OSK_MANUAL_EXT_CTL_MSK,
+				       st->reg[AD9910_REG_CFR1].val32);
+		if (auto_en) {
+			step = FIELD_GET(AD9910_ASF_STEP_SIZE_MSK,
+					 st->reg[AD9910_REG_ASF].val32);
+			step = ad9910_osk_raw_step[step + 1];
+		} else if (pinctrl_en) {
+			step = ad9910_osk_raw_step[ARRAY_SIZE(ad9910_osk_raw_step) - 1];
+		} else {
+			step = ad9910_osk_raw_step[0];
+		}
+
+		roc64 = div_u64((u64)step * st->data.sysclk_freq_hz, 4 * rate);
+		return sysfs_emit(buf, "%llu\n", roc64);
+	case AD9910_ROC_AVAIL: {
+		ssize_t len = 0;
+
+		for (unsigned int i = 0; i < ARRAY_SIZE(ad9910_osk_raw_step); i++) {
+			roc64 = div_u64((u64)ad9910_osk_raw_step[i] * st->data.sysclk_freq_hz,
+					4 * rate);
+			len += sysfs_emit_at(buf, len, "%llu ", roc64);
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
+	u32 idx, reg_val, rate;
+	u64 step;
+	int ret;
+
+	ret = kstrtou64(buf, 10, &step);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+
+	rate = FIELD_GET(AD9910_ASF_RAMP_RATE_MSK, st->reg[AD9910_REG_ASF].val32);
+	if (!rate)
+		return -ERANGE;
+
+	switch (private) {
+	case AD9910_ROC:
+		step = ad9910_rational_scale(step, 4 * rate,
+					     st->data.sysclk_freq_hz);
+		step = min(step, AD9910_ASF_MAX);
+		idx = find_closest(step, ad9910_osk_raw_step,
+				   ARRAY_SIZE(ad9910_osk_raw_step));
+		if (idx == ARRAY_SIZE(ad9910_osk_raw_step) - 1) {
+			/* manual mode: pin-controlled */
+			reg_val = AD9910_CFR1_OSK_MANUAL_EXT_CTL_MSK;
+		} else if (idx == 0) {
+			/* manual mode, NOT pin-controlled */
+			reg_val = 0;
+		} else {
+			/* auto mode: pin-controlled */
+			reg_val = FIELD_PREP(AD9910_ASF_STEP_SIZE_MSK, idx - 1);
+			ret = ad9910_reg32_update(st, AD9910_REG_ASF,
+						  AD9910_ASF_STEP_SIZE_MSK,
+						  reg_val, false);
+			if (ret)
+				return ret;
+
+			reg_val = AD9910_CFR1_SELECT_AUTO_OSK_MSK;
+		}
+
+		ret = ad9910_reg32_update(st, AD9910_REG_CFR1,
+					  AD9910_CFR1_SELECT_AUTO_OSK_MSK |
+					  AD9910_CFR1_OSK_MANUAL_EXT_CTL_MSK,
+					  reg_val, true);
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
 static const struct iio_chan_spec_ext_info ad9910_phy_ext_info[] = {
 	{
 		.name = "powerdown",
@@ -798,6 +921,23 @@ static const struct iio_chan_spec_ext_info ad9910_drg_ramp_ext_info[] = {
 	{ }
 };
 
+static const struct iio_chan_spec_ext_info ad9910_osk_ext_info[] = {
+	{
+		.name = "raw_roc",
+		.read = ad9910_osk_attrs_read,
+		.write = ad9910_osk_attrs_write,
+		.private = AD9910_ROC,
+		.shared = IIO_SEPARATE,
+	},
+	{
+		.name = "raw_roc_available",
+		.read = ad9910_osk_attrs_read,
+		.private = AD9910_ROC_AVAIL,
+		.shared = IIO_SEPARATE,
+	},
+	{ }
+};
+
 #define AD9910_PROFILE_CHAN(idx) {				\
 	.type = IIO_ALTCURRENT,					\
 	.indexed = 1,						\
@@ -985,6 +1125,18 @@ static const struct iio_chan_spec ad9910_channels[] = {
 				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.parent = &ad9910_channels[AD9910_CHAN_IDX_PHY],
 	},
+	[AD9910_CHAN_IDX_OSK] = {
+		.type = IIO_ALTCURRENT,
+		.indexed = 1,
+		.output = 1,
+		.channel = AD9910_CHANNEL_OSK,
+		.address = AD9910_CHAN_IDX_OSK,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.ext_info = ad9910_osk_ext_info,
+		.parent = &ad9910_channels[AD9910_CHAN_IDX_PHY],
+	},
 };
 
 static int ad9910_read_raw(struct iio_dev *indio_dev,
@@ -1021,6 +1173,10 @@ static int ad9910_read_raw(struct iio_dev *indio_dev,
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
@@ -1076,6 +1232,10 @@ static int ad9910_read_raw(struct iio_dev *indio_dev,
 					  st->reg[AD9910_REG_DRG_LIMIT].val64);
 			iio_val_s64_decompose(tmp64, val, val2);
 			return IIO_VAL_INT_64;
+		case AD9910_CHANNEL_OSK:
+			*val = FIELD_GET(AD9910_ASF_SCALE_FACTOR_MSK,
+					 st->reg[AD9910_REG_ASF].val32);
+			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
 		}
@@ -1096,6 +1256,10 @@ static int ad9910_read_raw(struct iio_dev *indio_dev,
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
@@ -1257,6 +1421,11 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
 			return ad9910_reg32_update(st, AD9910_REG_CFR1,
 						   AD9910_CFR1_RAM_ENABLE_MSK,
 						   tmp32, true);
+		case AD9910_CHANNEL_OSK:
+			tmp32 = FIELD_PREP(AD9910_CFR1_OSK_ENABLE_MSK, !!val);
+			return ad9910_reg32_update(st, AD9910_REG_CFR1,
+						   AD9910_CFR1_OSK_ENABLE_MSK,
+						   tmp32, true);
 		default:
 			return -EINVAL;
 		}
@@ -1357,6 +1526,15 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
 						   AD9910_DRG_LIMIT_LOWER_MSK,
 						   tmp64, true);
 		}
+		case AD9910_CHANNEL_OSK:
+			if (val < 0)
+				return -EINVAL;
+
+			tmp32 = min_t(u32, val, AD9910_ASF_MAX);
+			tmp32 = FIELD_PREP(AD9910_ASF_SCALE_FACTOR_MSK, tmp32);
+			return ad9910_reg32_update(st, AD9910_REG_ASF,
+						   AD9910_ASF_SCALE_FACTOR_MSK,
+						   tmp32, true);
 		default:
 			return -EINVAL;
 		}
@@ -1396,6 +1574,11 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
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
@@ -1472,6 +1655,7 @@ static int ad9910_write_raw_get_fmt(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->channel) {
 		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
+		case AD9910_CHANNEL_OSK:
 			return IIO_VAL_INT;
 		case AD9910_CHANNEL_DRG_RAMP_UP:
 		case AD9910_CHANNEL_DRG_RAMP_DOWN:
@@ -1563,6 +1747,7 @@ static const char * const ad9910_channel_str[] = {
 	[AD9910_CHAN_IDX_DRG_AMP_RAMP_UP] = "drg_rising_amplitude",
 	[AD9910_CHAN_IDX_DRG_AMP_RAMP_DOWN] = "drg_falling_amplitude",
 	[AD9910_CHAN_IDX_RAM] = "ram",
+	[AD9910_CHAN_IDX_OSK] = "osk",
 };
 
 static int ad9910_read_label(struct iio_dev *indio_dev,
@@ -1830,6 +2015,12 @@ static int ad9910_setup(struct device *dev, struct ad9910_state *st,
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


