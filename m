Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B57426407;
	Tue,  7 Jul 2026 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433068; cv=none; b=slDdqipTO+dfQkoqiso0RSjwe57x72AX+u4yZ6O8wsSI5l4i6bLggxU++PR369M9gwcdMaLZyLKIVz5pwc9mZV7lmCZ2x+K+fkFAJXZdO53kM88S55vSFuyIRdxFX6xVDDFilrBnn3GtY5iWWqH1U3I+ggwHlQ0RE3yYmKliVJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433068; c=relaxed/simple;
	bh=O8sV7+Q6gXNggfuREMnUMxicA4oTDIjTCpD1B8XiBEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nduOZmD57fRcrGZqDbSSDYI0EEWNHpThoMjVJh9ZSU37xehwov11x/+3dz2OMU6WZ9u+x2S5IG9XvV55/OTtPwFEnFNUfZ67l9uRDqkeHYu6Q9nMjZIv9227gMxePOdT916BP90P7cLgcbRD2wmJapZQuGOaAVTnxQJGhkS6p6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQC0PLRV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQC0PLRV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5054DC4AF17;
	Tue,  7 Jul 2026 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783433068;
	bh=O8sV7+Q6gXNggfuREMnUMxicA4oTDIjTCpD1B8XiBEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WQC0PLRVw95psRoOYI4L0p8YECFblXeXmeAisTnrKGTLXyOlx/Rhz4leHNRhVlJjY
	 uW3BE9zUfxpmxQ0bCBMroF0BtbZNC98InaoyPVuC+nN7rH98bd7lyHdpIQ14zMTA2V
	 3q4ONSTRZ7rPTTWqwxZJlnnr81tBH9jfSr8C87Yq9sDtfiL3o5Z4Eu9hrIFDO9XXq6
	 gdjgnluBOSl+gjmmrHXfX/gIqS5yY4arVtSGtb97molXTAu80MC2dAEMaU5CblH9+K
	 A3nbJslRunCD6h7rIXm2oC2wlngSIKvJKjTX58nBL96fbv6ZHfURfQzj2fYamGTGRV
	 iwsJDTcytKmTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A4CC43602;
	Tue,  7 Jul 2026 14:04:28 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 07 Jul 2026 15:04:34 +0100
Subject: [PATCH v7 13/17] iio: frequency: ad9910: add RAM mode support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-ad9910-iio-driver-v7-13-a4ec30f63700@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783433065; l=19682;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=MwclCv+3Q3UBe00EYtsJ+mgnmt3jUB9tgJCmW8JGqhM=;
 b=MIq3BP1E0jHNMobKR+02Y35bD+Yp7tjMSN8uK3na9hCX9F62suSisukjq8J9O7CR9psRSCnHt
 1CDfgYEkRMEC26q8jLF1UWGpERyxvsfZOMJnRhHsC2SJNc07CS10ace
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add RAM control channel, which includes:
- RAM data loading via firmware upload interface;
- Per-profile configuration and DDS core parameter destination as firmware
  metadata;
- Profile switching relying on profile channels;
- Sampling frequency control of the active profile;
- ram-enable-aware read/write paths that redirect single tone
  frequency/phase/amplitude access through reg_profile cache when RAM is
  active;

When RAM is enabled, the DDS profile parameters (frequency, phase,
amplitude) for the single tone mode are sourced from a shadow register
cache (reg_profile[]) since the profile registers are repurposed for RAM
control.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/frequency/Kconfig  |   3 +
 drivers/iio/frequency/ad9910.c | 336 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 332 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index 6033f9155b4f..994d199080eb 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -29,6 +29,9 @@ config AD9910
 	tristate "Analog Devices AD9910 Direct Digital Synthesizer"
 	depends on SPI
 	depends on GPIOLIB
+	select CRC32
+	select FW_LOADER
+	select FW_UPLOAD
 	help
 	  Say yes here to build support for Analog Devices AD9910
 	  1 GSPS, 14-Bit DDS with integrated DAC.
diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
index a37e3dab105b..f6550cc9717e 100644
--- a/drivers/iio/frequency/ad9910.c
+++ b/drivers/iio/frequency/ad9910.c
@@ -8,9 +8,12 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/crc32.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/device/devres.h>
 #include <linux/err.h>
+#include <linux/firmware.h>
 #include <linux/gpio/consumer.h>
 #include <linux/log2.h>
 #include <linux/math64.h>
@@ -147,6 +150,15 @@
 #define AD9910_PROFILE_ST_POW_MSK		GENMASK_ULL(47, 32)
 #define AD9910_PROFILE_ST_FTW_MSK		GENMASK_ULL(31, 0)
 
+/* Profile Register Format (RAM Mode) */
+#define AD9910_PROFILE_RAM_OPEN_MSK		GENMASK_ULL(61, 56)
+#define AD9910_PROFILE_RAM_STEP_RATE_MSK	GENMASK_ULL(55, 40)
+#define AD9910_PROFILE_RAM_END_ADDR_MSK		GENMASK_ULL(39, 30)
+#define AD9910_PROFILE_RAM_START_ADDR_MSK	GENMASK_ULL(23, 14)
+#define AD9910_PROFILE_RAM_NO_DWELL_HIGH_MSK	BIT_ULL(5)
+#define AD9910_PROFILE_RAM_ZERO_CROSSING_MSK	BIT_ULL(3)
+#define AD9910_PROFILE_RAM_MODE_CONTROL_MSK	GENMASK_ULL(2, 0)
+
 /* Device constants */
 #define AD9910_PI_NANORAD		3141592653UL
 #define AD9910_PI_PICORAD		3141592653590ULL
@@ -161,6 +173,16 @@
 #define AD9910_STEP_RATE_MAX		FIELD_MAX(AD9910_DRG_RATE_DEC_MSK)
 #define AD9910_NUM_PROFILES		8
 
+#define AD9910_RAM_FW_MAGIC		0x00AD9910
+#define AD9910_RAM_FW_V1		0x0001
+#define AD9910_RAM_SIZE_MAX_WORDS	1024
+#define AD9910_RAM_WORD_SIZE		sizeof(u32)
+#define AD9910_RAM_SIZE_MAX_BYTES	(AD9910_RAM_SIZE_MAX_WORDS * AD9910_RAM_WORD_SIZE)
+#define AD9910_RAM_ADDR_MAX		(AD9910_RAM_SIZE_MAX_WORDS - 1)
+
+#define AD9910_RAM_ENABLED(st)		\
+	FIELD_GET(AD9910_CFR1_RAM_ENABLE_MSK, (st)->reg[AD9910_REG_CFR1].val32)
+
 /* PLL constants */
 #define AD9910_PLL_MIN_N		12
 #define AD9910_PLL_MAX_N		127
@@ -197,7 +219,7 @@
 #define AD9910_RESET_DELAY_us		1	/* 5 sysclk cycles: < 1us */
 
 #define AD9910_SPI_DATA_IDX		1
-#define AD9910_SPI_DATA_LEN_MAX		sizeof(__be64)
+#define AD9910_SPI_DATA_LEN_MAX		AD9910_RAM_SIZE_MAX_BYTES
 #define AD9910_SPI_MESSAGE_LEN_MAX	(AD9910_SPI_DATA_IDX + AD9910_SPI_DATA_LEN_MAX)
 #define AD9910_SPI_READ_MSK		BIT(7)
 #define AD9910_SPI_ADDR_MSK		GENMASK(4, 0)
@@ -219,6 +241,7 @@
  * @AD9910_CHANNEL_DRG: Digital Ramp Generator output channel
  * @AD9910_CHANNEL_DRG_RAMP_UP: DRG ramp up channel
  * @AD9910_CHANNEL_DRG_RAMP_DOWN: DRG ramp down channel
+ * @AD9910_CHANNEL_RAM: RAM control output channel
  */
 enum ad9910_channel {
 	AD9910_CHANNEL_PHY = 100,
@@ -235,8 +258,32 @@ enum ad9910_channel {
 	AD9910_CHANNEL_DRG = 130,
 	AD9910_CHANNEL_DRG_RAMP_UP = 131,
 	AD9910_CHANNEL_DRG_RAMP_DOWN = 132,
+	AD9910_CHANNEL_RAM = 140,
 };
 
+/**
+ * struct ad9910_ram_fw - AD9910 RAM firmware format
+ * @magic:	Magic number for RAM firmware validation
+ * @version:	Firmware version number
+ * @wcount:	Number of RAM words to be written
+ * @crc:	CRC32 checksum of the RAM data for integrity verification
+ * @cfr1:	Value of CFR1 register to be configured (not all fields are
+ *		used, but this is included here for convenience)
+ * @profiles:	Array of RAM profile configurations
+ * @words:	Array of RAM words to be written. Data pattern should be set in
+ *		reverse order and wcount specifies the number of words in this
+ *		array
+ */
+struct ad9910_ram_fw {
+	__be32 magic;
+	__be16 version;
+	__be16 wcount;
+	__be32 crc;
+	__be32 cfr1;
+	__be64 profiles[AD9910_NUM_PROFILES];
+	__be32 words[] __counted_by_be(wcount);
+} __packed;
+
 enum {
 	AD9910_CHAN_IDX_PHY,
 	AD9910_CHAN_IDX_PROFILE_0,
@@ -261,6 +308,7 @@ enum {
 	AD9910_CHAN_IDX_DRG_PHASE_RAMP_DOWN,
 	AD9910_CHAN_IDX_DRG_AMP_RAMP_UP,
 	AD9910_CHAN_IDX_DRG_AMP_RAMP_DOWN,
+	AD9910_CHAN_IDX_RAM,
 };
 
 enum {
@@ -287,6 +335,7 @@ union ad9910_reg {
 struct ad9910_state {
 	struct spi_device *spi;
 	struct clk *refclk;
+	struct fw_upload *ram_fwu;
 
 	struct gpio_desc *gpio_pwdown;
 	struct gpio_desc *gpio_update;
@@ -295,12 +344,22 @@ struct ad9910_state {
 	/* cached registers */
 	union ad9910_reg reg[AD9910_REG_NUM_CACHED];
 
+	/*
+	 * alternate profile registers used to store RAM profile settings when
+	 * RAM mode is disabled and Single Tone profile settings when RAM mode
+	 * is enabled.
+	 */
+	u64 reg_profile[AD9910_NUM_PROFILES];
+
 	/* Lock for accessing device registers and state variables */
 	struct mutex lock;
 
 	struct ad9910_data data;
 	u8 profile;
 
+	bool ram_fwu_cancel;
+	char ram_fwu_name[20];
+
 	/*
 	 * RAM loading requires a reasonable amount of bytes, at the same time
 	 * DMA capable SPI drivers requires the transfer buffers to live in
@@ -324,6 +383,22 @@ static inline u64 ad9910_rational_scale(u64 input, u64 scale, u64 reference)
 	return mul_u64_add_u64_div_u64(input, scale, reference >> 1, reference);
 }
 
+static inline u64 ad9910_ram_profile_val(struct ad9910_state *st)
+{
+	if (AD9910_RAM_ENABLED(st))
+		return st->reg[AD9910_REG_PROFILE(st->profile)].val64;
+	else
+		return st->reg_profile[st->profile];
+}
+
+static inline u64 ad9910_st_profile_val(struct ad9910_state *st, u8 profile)
+{
+	if (AD9910_RAM_ENABLED(st))
+		return st->reg_profile[profile];
+	else
+		return st->reg[AD9910_REG_PROFILE(profile)].val64;
+}
+
 static int ad9910_io_update(struct ad9910_state *st)
 {
 	if (st->gpio_update) {
@@ -898,6 +973,18 @@ static const struct iio_chan_spec ad9910_channels[] = {
 		.ext_info = ad9910_drg_ramp_ext_info,
 		.parent = &ad9910_channels[AD9910_CHAN_IDX_DRG_AMP],
 	},
+	[AD9910_CHAN_IDX_RAM] = {
+		.type = IIO_ALTCURRENT,
+		.indexed = 1,
+		.output = 1,
+		.channel = AD9910_CHANNEL_RAM,
+		.address = AD9910_CHAN_IDX_RAM,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE) |
+				      BIT(IIO_CHAN_INFO_FREQUENCY) |
+				      BIT(IIO_CHAN_INFO_PHASE) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.parent = &ad9910_channels[AD9910_CHAN_IDX_PHY],
+	},
 };
 
 static int ad9910_read_raw(struct iio_dev *indio_dev,
@@ -930,6 +1017,10 @@ static int ad9910_read_raw(struct iio_dev *indio_dev,
 			else
 				*val = 0;
 			break;
+		case AD9910_CHANNEL_RAM:
+			*val = FIELD_GET(AD9910_CFR1_RAM_ENABLE_MSK,
+					 st->reg[AD9910_REG_CFR1].val32);
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -939,7 +1030,10 @@ static int ad9910_read_raw(struct iio_dev *indio_dev,
 		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
 			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
 			tmp64 = FIELD_GET(AD9910_PROFILE_ST_FTW_MSK,
-					  st->reg[AD9910_REG_PROFILE(tmp32)].val64);
+					  ad9910_st_profile_val(st, tmp32));
+			break;
+		case AD9910_CHANNEL_RAM:
+			tmp64 = st->reg[AD9910_REG_FTW].val32;
 			break;
 		default:
 			return -EINVAL;
@@ -953,7 +1047,10 @@ static int ad9910_read_raw(struct iio_dev *indio_dev,
 		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
 			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
 			tmp64 = FIELD_GET(AD9910_PROFILE_ST_POW_MSK,
-					  st->reg[AD9910_REG_PROFILE(tmp32)].val64);
+					  ad9910_st_profile_val(st, tmp32));
+			break;
+		case AD9910_CHANNEL_RAM:
+			tmp64 = st->reg[AD9910_REG_POW].val16;
 			break;
 		default:
 			return -EINVAL;
@@ -967,7 +1064,7 @@ static int ad9910_read_raw(struct iio_dev *indio_dev,
 		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
 			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
 			*val = FIELD_GET(AD9910_PROFILE_ST_ASF_MSK,
-					 st->reg[AD9910_REG_PROFILE(tmp32)].val64);
+					 ad9910_st_profile_val(st, tmp32));
 			return IIO_VAL_INT;
 		case AD9910_CHANNEL_DRG_RAMP_UP:
 			tmp64 = FIELD_GET(AD9910_DRG_LIMIT_UPPER_MSK,
@@ -995,6 +1092,10 @@ static int ad9910_read_raw(struct iio_dev *indio_dev,
 			tmp32 = FIELD_GET(AD9910_DRG_RATE_DEC_MSK,
 					  st->reg[AD9910_REG_DRG_RATE].val32);
 			break;
+		case AD9910_CHANNEL_RAM:
+			tmp32 = FIELD_GET(AD9910_PROFILE_RAM_STEP_RATE_MSK,
+					  ad9910_ram_profile_val(st));
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1084,7 +1185,7 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
 	struct ad9910_state *st = iio_priv(indio_dev);
 	u64 tmp64;
 	u32 tmp32;
-	int ret;
+	int ret, i;
 
 	guard(mutex)(&st->lock);
 
@@ -1121,6 +1222,41 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
 						   AD9910_CFR2_DRG_DEST_MSK |
 						   AD9910_CFR2_DRG_ENABLE_MSK,
 						   tmp32, true);
+		case AD9910_CHANNEL_RAM:
+			if (AD9910_RAM_ENABLED(st) == !!val)
+				return 0;
+
+			/* swap profile configs */
+			for (i = 0; i < AD9910_NUM_PROFILES; i++) {
+				tmp64 = st->reg[AD9910_REG_PROFILE(i)].val64;
+				ret = ad9910_reg64_write(st,
+							 AD9910_REG_PROFILE(i),
+							 st->reg_profile[i],
+							 false);
+				if (ret)
+					break;
+				st->reg_profile[i] = tmp64;
+			}
+
+			if (ret) {
+				/*
+				 * After the write failure, profiles 0..i-1 were
+				 * already swapped in SW, but Hw registers are
+				 * still pending an IO update, so swap them back
+				 * in SW to keep the state consistent.
+				 */
+				while (i--) {
+					tmp64 = st->reg[AD9910_REG_PROFILE(i)].val64;
+					st->reg[AD9910_REG_PROFILE(i)].val64 = st->reg_profile[i];
+					st->reg_profile[i] = tmp64;
+				}
+				return ret;
+			}
+
+			tmp32 = FIELD_PREP(AD9910_CFR1_RAM_ENABLE_MSK, !!val);
+			return ad9910_reg32_update(st, AD9910_REG_CFR1,
+						   AD9910_CFR1_RAM_ENABLE_MSK,
+						   tmp32, true);
 		default:
 			return -EINVAL;
 		}
@@ -1134,10 +1270,17 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
 		switch (chan->channel) {
 		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
 			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
+			if (AD9910_RAM_ENABLED(st)) {
+				FIELD_MODIFY(AD9910_PROFILE_ST_FTW_MSK,
+					     &st->reg_profile[tmp32], tmp64);
+				return 0;
+			}
 			tmp64 = FIELD_PREP(AD9910_PROFILE_ST_FTW_MSK, tmp64);
 			return ad9910_reg64_update(st, AD9910_REG_PROFILE(tmp32),
 						   AD9910_PROFILE_ST_FTW_MSK,
 						   tmp64, true);
+		case AD9910_CHANNEL_RAM:
+			return ad9910_reg32_write(st, AD9910_REG_FTW, tmp64, true);
 		default:
 			return -EINVAL;
 		}
@@ -1155,10 +1298,19 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
 		switch (chan->channel) {
 		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
 			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
+
+			if (AD9910_RAM_ENABLED(st)) {
+				FIELD_MODIFY(AD9910_PROFILE_ST_POW_MSK,
+					     &st->reg_profile[tmp32], tmp64);
+				return 0;
+			}
+
 			tmp64 = FIELD_PREP(AD9910_PROFILE_ST_POW_MSK, tmp64);
 			return ad9910_reg64_update(st, AD9910_REG_PROFILE(tmp32),
 						   AD9910_PROFILE_ST_POW_MSK,
 						   tmp64, true);
+		case AD9910_CHANNEL_RAM:
+			return ad9910_reg16_write(st, AD9910_REG_POW, tmp64, true);
 		default:
 			return -EINVAL;
 		}
@@ -1169,8 +1321,15 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
 				return -EINVAL;
 
 			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
-			tmp64 = FIELD_PREP(AD9910_PROFILE_ST_ASF_MSK,
-					   min_t(u64, val, AD9910_ASF_MAX));
+			tmp64 = min_t(u64, val, AD9910_ASF_MAX);
+
+			if (AD9910_RAM_ENABLED(st)) {
+				FIELD_MODIFY(AD9910_PROFILE_ST_ASF_MSK,
+					     &st->reg_profile[tmp32], tmp64);
+				return 0;
+			}
+
+			tmp64 = FIELD_PREP(AD9910_PROFILE_ST_ASF_MSK, tmp64);
 			return ad9910_reg64_update(st, AD9910_REG_PROFILE(tmp32),
 						   AD9910_PROFILE_ST_ASF_MSK,
 						   tmp64, true);
@@ -1226,6 +1385,17 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
 			return ad9910_reg32_update(st, AD9910_REG_DRG_RATE,
 						   AD9910_DRG_RATE_DEC_MSK,
 						   tmp32, true);
+		case AD9910_CHANNEL_RAM:
+			if (!AD9910_RAM_ENABLED(st)) {
+				FIELD_MODIFY(AD9910_PROFILE_RAM_STEP_RATE_MSK,
+					     &st->reg_profile[st->profile], tmp32);
+				return 0;
+			}
+
+			tmp64 = FIELD_PREP(AD9910_PROFILE_RAM_STEP_RATE_MSK, tmp32);
+			return ad9910_reg64_update(st, AD9910_REG_PROFILE(st->profile),
+						   AD9910_PROFILE_RAM_STEP_RATE_MSK,
+						   tmp64, true);
 		default:
 			return -EINVAL;
 		}
@@ -1392,6 +1562,7 @@ static const char * const ad9910_channel_str[] = {
 	[AD9910_CHAN_IDX_DRG_PHASE_RAMP_DOWN] = "drg_falling_phase",
 	[AD9910_CHAN_IDX_DRG_AMP_RAMP_UP] = "drg_rising_amplitude",
 	[AD9910_CHAN_IDX_DRG_AMP_RAMP_DOWN] = "drg_falling_amplitude",
+	[AD9910_CHAN_IDX_RAM] = "ram",
 };
 
 static int ad9910_read_label(struct iio_dev *indio_dev,
@@ -1401,6 +1572,137 @@ static int ad9910_read_label(struct iio_dev *indio_dev,
 	return sysfs_emit(label, "%s\n", ad9910_channel_str[chan->address]);
 }
 
+static enum fw_upload_err ad9910_ram_fwu_prepare(struct fw_upload *fw_upload,
+						 const u8 *data, u32 size)
+{
+	struct ad9910_state *st = fw_upload->dd_handle;
+	const struct ad9910_ram_fw *fw_data = (const struct ad9910_ram_fw *)data;
+	size_t wcount, bcount;
+
+	if (size < sizeof(struct ad9910_ram_fw))
+		return FW_UPLOAD_ERR_INVALID_SIZE;
+
+	if (get_unaligned_be32(&fw_data->magic) != AD9910_RAM_FW_MAGIC)
+		return FW_UPLOAD_ERR_FW_INVALID;
+
+	if (get_unaligned_be16(&fw_data->version) != AD9910_RAM_FW_V1)
+		return FW_UPLOAD_ERR_FW_INVALID;
+
+	wcount = get_unaligned_be16(&fw_data->wcount);
+	bcount = size - sizeof(struct ad9910_ram_fw);
+	if (wcount > AD9910_RAM_SIZE_MAX_WORDS ||
+	    bcount != (wcount * AD9910_RAM_WORD_SIZE))
+		return FW_UPLOAD_ERR_INVALID_SIZE;
+
+	bcount += sizeof(fw_data->cfr1) + sizeof(fw_data->profiles);
+	if (crc32(0, &fw_data->cfr1, bcount) != get_unaligned_be32(&fw_data->crc))
+		return FW_UPLOAD_ERR_FW_INVALID;
+
+	guard(mutex)(&st->lock);
+	if (st->ram_fwu_cancel)
+		return FW_UPLOAD_ERR_CANCELED;
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err ad9910_ram_fwu_write(struct fw_upload *fw_upload,
+					       const u8 *data, u32 offset,
+					       u32 size, u32 *written)
+{
+	const struct ad9910_ram_fw *fw_data = (const struct ad9910_ram_fw *)data;
+	struct ad9910_state *st = fw_upload->dd_handle;
+	int ret, ret2, idx, wcount;
+	u64 tmp64, backup;
+
+	if (offset != 0)
+		return FW_UPLOAD_ERR_INVALID_SIZE;
+
+	guard(mutex)(&st->lock);
+
+	if (st->ram_fwu_cancel)
+		return FW_UPLOAD_ERR_CANCELED;
+
+	if (AD9910_RAM_ENABLED(st))
+		return FW_UPLOAD_ERR_HW_ERROR;
+
+	for (idx = 0; idx < AD9910_NUM_PROFILES; idx++)
+		st->reg_profile[idx] = get_unaligned_be64(&fw_data->profiles[idx]) |
+				       AD9910_PROFILE_RAM_OPEN_MSK;
+
+	ret = ad9910_reg32_update(st, AD9910_REG_CFR1,
+				  AD9910_CFR1_RAM_PLAYBACK_DEST_MSK |
+				  AD9910_CFR1_INT_PROFILE_CTL_MSK,
+				  get_unaligned_be32(&fw_data->cfr1), true);
+	if (ret)
+		return FW_UPLOAD_ERR_RW_ERROR;
+
+	wcount = get_unaligned_be16(&fw_data->wcount);
+	if (!wcount) {
+		*written = size;
+		return FW_UPLOAD_ERR_NONE; /* nothing else to write */
+	}
+
+	ret = ad9910_profile_set(st, st->profile);
+	if (ret)
+		return FW_UPLOAD_ERR_HW_ERROR;
+
+	/* backup profile register and update it with required address range */
+	backup = st->reg[AD9910_REG_PROFILE(st->profile)].val64;
+	tmp64 = AD9910_PROFILE_RAM_STEP_RATE_MSK |
+		FIELD_PREP(AD9910_PROFILE_RAM_START_ADDR_MSK, 0) |
+		FIELD_PREP(AD9910_PROFILE_RAM_END_ADDR_MSK, wcount - 1);
+	ret = ad9910_reg64_write(st, AD9910_REG_PROFILE(st->profile), tmp64, true);
+	if (ret)
+		return FW_UPLOAD_ERR_RW_ERROR;
+
+	memcpy(&st->tx_buf[1], fw_data->words, wcount * AD9910_RAM_WORD_SIZE);
+
+	/* write ram data and restore profile register */
+	ret = ad9910_spi_write(st, AD9910_REG_RAM,
+			       wcount * AD9910_RAM_WORD_SIZE, false);
+	ret2 = ad9910_reg64_write(st, AD9910_REG_PROFILE(st->profile), backup, true);
+	if (ret || ret2)
+		return FW_UPLOAD_ERR_RW_ERROR;
+
+	*written = size;
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err ad9910_ram_fwu_poll_complete(struct fw_upload *fw_upload)
+{
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static void ad9910_ram_fwu_cancel(struct fw_upload *fw_upload)
+{
+	struct ad9910_state *st = fw_upload->dd_handle;
+
+	guard(mutex)(&st->lock);
+	st->ram_fwu_cancel = true;
+}
+
+static void ad9910_ram_fwu_cleanup(struct fw_upload *fw_upload)
+{
+	struct ad9910_state *st = fw_upload->dd_handle;
+
+	guard(mutex)(&st->lock);
+	st->ram_fwu_cancel = false;
+}
+
+static void ad9910_ram_fwu_unregister(void *data)
+{
+	firmware_upload_unregister(data);
+}
+
+static const struct fw_upload_ops ad9910_ram_fwu_ops = {
+	.prepare = ad9910_ram_fwu_prepare,
+	.write = ad9910_ram_fwu_write,
+	.poll_complete = ad9910_ram_fwu_poll_complete,
+	.cancel = ad9910_ram_fwu_cancel,
+	.cleanup = ad9910_ram_fwu_cleanup,
+};
+
 static const struct iio_info ad9910_info = {
 	.read_raw = ad9910_read_raw,
 	.write_raw = ad9910_write_raw,
@@ -1535,6 +1837,13 @@ static int ad9910_setup(struct device *dev, struct ad9910_state *st,
 	if (ret)
 		return ret;
 
+	for (unsigned int i = 0; i < AD9910_NUM_PROFILES; i++) {
+		st->reg_profile[i] = AD9910_PROFILE_RAM_OPEN_MSK;
+		st->reg_profile[i] |= FIELD_PREP(AD9910_PROFILE_RAM_STEP_RATE_MSK, 1);
+		st->reg_profile[i] |= FIELD_PREP(AD9910_PROFILE_RAM_END_ADDR_MSK,
+						 AD9910_RAM_ADDR_MAX);
+	}
+
 	return ad9910_io_update(st);
 }
 
@@ -1628,6 +1937,19 @@ static int ad9910_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(dev, ret, "device setup failed\n");
 
+	snprintf(st->ram_fwu_name, sizeof(st->ram_fwu_name), "%s:ram",
+		 dev_name(&indio_dev->dev));
+	st->ram_fwu = firmware_upload_register(THIS_MODULE, dev, st->ram_fwu_name,
+					       &ad9910_ram_fwu_ops, st);
+	if (IS_ERR(st->ram_fwu))
+		return dev_err_probe(dev, PTR_ERR(st->ram_fwu),
+				     "failed to register ram upload ops\n");
+
+	ret = devm_add_action_or_reset(dev, ad9910_ram_fwu_unregister, st->ram_fwu);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to add ram upload unregister action\n");
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 

-- 
2.43.0


