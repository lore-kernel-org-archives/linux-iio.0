Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E003BBFD5
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 06:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899136; cv=none; b=hHfJFSNKqYKbq7hSbOrMwHL/TJxVXth5pPNdDCtB0p4YKGr+SMeUrnHOOZ/7AKg9HSqTkZyL6NslRbCE9K5z0JtzT9Qc9RZs5S22xGz9r1fhJoMrfwuOf3TQ4B4LpkAnnL58+Y/x9Snkxl9tC3Uuswg9BAINrXdFOFjYWNCcD7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899136; c=relaxed/simple;
	bh=ZMdhvA3VIRtd3kMp5WBL8nG7USOLWbSk+f5oUyciX1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QLc4sNEH47BvZo4h1xnE6DLC0PW5xZBjbeItpjEtS2pgoH3U5I8pPyb8qaL76IzizWLx8dRsHKTXI0zGQlVVdaG2i3DDl3xIeEy0RM93LEX7mSZLgoNbYWmhW7+syy1Iw2+VxFxZTj3Jg4E3f9AjFxdcxzyUCU/KkGLUSs2SENY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r13xozoS; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r13xozoS"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5bf8e1edc3aso547810e0c.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 23:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787899129; x=1788503929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mwsoxe8KhbSfGQ0zwt/NfFnLnBuMn+0YOw8VstSOLRs=;
        b=r13xozoSw3yzO7hWDtNtqz8mxfMdCf4ImFm/QdXjfiOusGyN/ReB9hnNpAgkTKX+qx
         jpmzLiq2mEoURjbG19FXtpwDgpFTr31T+FEoyZoWy/7hb+nh0Th4mHanG/+AbwNwKPOK
         bGFqzfwHIGu2Cil9u+GWJ8Ip2PlWbkbjlyVj1snhBns/2z+CiyOsFIzMqpV/9ihyQ4mg
         nlWYx7F/nJhJ7lzr8Io3rma7UqGHsulB29ovPZlbfZ7zQJVUFIqiPQeSVzJBvtiqQZDV
         A50O5Z73p6bo6z3U41Vvjr5Je/knI/D5w8A+8Og7LcEtM5DNGgSzc2oGjpSaYf89z6NO
         JLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787899129; x=1788503929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mwsoxe8KhbSfGQ0zwt/NfFnLnBuMn+0YOw8VstSOLRs=;
        b=ikGgvu77MnfFDYOXGnKIX2H5AFkJJ+n5QOFnYQJbR1d0gbVwFhUYcTQGpw0xijgzZw
         mXhfK14L5qg7bBoWjWzzgPfzTCWeOT2gwwaIGKU1UwJo5POEbYiVzoJxB3ORmeUoEIR5
         ht49YUzqtrKYSqo6ptb7xkpsUggCnSDL454mxl0tAL2bjpvG2K2R2RRt6BrVkqA287PX
         gmuOflbsRmjGTXQy2r0541+mkvBBV9+5PEmEX0adfUrwVTvy2hbC6vU4w7VPZ82LWbsO
         h3a4wzHy2b7NWhMW+1P8GYhWSmguuU6tzHsCt1E5no0NMbHXPCpU9UWOcPIdjPeTmMyg
         R1Pw==
X-Forwarded-Encrypted: i=1; AHgh+RrmLlkwNlxrpH7yjvAY2JBoSnST0JXoIjxGCJIFqnQcr4kbkHCRFTLLk21kXW3qomCGVwJtqW1QvYM=@vger.kernel.org
X-Gm-Message-State: AFuF++liecP8vLaF2mIhDAZ2QcnZmWN57yUpT6DCMR9qdT6Y4fARNK4w
	BrFQLKjZ38mvPmkW5ziB/MnRsZhItUpC9/EhzrXIAD2MfUuvNy6VadGy+uM1RQ==
X-Gm-Gg: AR+sD12l+9k/5mwiBbpvZTkIhJsFiTOdiEcd8WokmH8B9D6kvzOuuoAGnf8erM4kVkC
	I2tZcjafnq67LhqCaJf6H0r3E3kWb5XbdXd7dfnz9or253ZVUpEt7iwt3WSxWb37eqaNy5NEZ6V
	RKdP4AfO8jtbDEDWa3llA7FzD0JzaftwxfbwqWQhzaSqV8oJjwaJY93muKCrw7/Gb/ecPdirdae
	RyRR5aVOm/iQdpXRdKYOmqnZrk0Lwal6K4WQKAOY3SbRO/b6xfvSbmkQ6z11mBaCUEl3hOI6C6O
	KP9Xubno2GUxaGqJtu4hv2iZzMHdyFYr9EY0lB6vCQPvBlCVKd9ZIM6npYYHnVovl1r1xSszdkB
	pqE7cQD/h5ndfgZTHWR6VPvsPHQnDBAciO79Ga0gIJsXc8X9dzelYBWoi/woD9l5prZVzzV4nix
	zjhfFqIrSlHLkelc9TO+jcHipFmMjI7fmoaVppQMXB9WLsHvTD+9dccQOCJVcFWqNC
X-Received: by 2002:a05:6122:469a:b0:5c6:6c75:81c9 with SMTP id 71dfb90a1353d-5c681776bb2mr2176026e0c.7.1787899129133;
        Thu, 27 Aug 2026 23:38:49 -0700 (PDT)
Received: from [192.168.100.153] ([2800:bf0:61:1127:ab87:5602:531c:8dfb])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97e849d8494sm454195241.1.2026.08.27.23.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 23:38:48 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 28 Aug 2026 01:38:20 -0500
Subject: [PATCH v4 05/10] iio: adc: ti-ads1262: support per-channel
 reference and gain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-ads126x-v4-5-1dc27e9c0260@gmail.com>
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
In-Reply-To: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=24067; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=ZMdhvA3VIRtd3kMp5WBL8nG7USOLWbSk+f5oUyciX1A=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFkTdd7sM2DMe8sRx9F32K7z21OFzVPqmG4rreFaxbCn6
 tfq7U9nd5SyMIhxMciKKbK0Jyz69igq763fgdD7MHNYmUCGMHBxCsBEzhxnZOja8G3q0tZd5i/Y
 P62oe3K/yt1Ycf27WXsrj53tzHeVbV7C8L/iQZGqm17kzoW/989ssLv/eUHBLbe3a0QfpP2/syj
 rVggrAA==
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Allow each channel to select its voltage reference through the
"reference-sources" firmware property. Then, use the reference voltage
to calculate available scales. The PGA bypass handling is intentionally
left out until more information about on its usual applications is
gathered.

The ADS1262 allows single-ended supply configurations or bipolar supply
configurations. In single ended configurations both the analog and
digital rails share the same ground, i.e. AVSS = DGND = 0 V. In bipolar
supply configurations, AVSS can go below ground, e.g. AVSS = -2.5 V. If
AVSS is below ground, the ADC can achieve true bipolar measurements and
the external references can also have voltage levels below ground.

This is currently an issue because the regulator subsystem doesn't
support reading negative voltages. The ad4170-4 driver faces this
problem too and the same workaround is used in this case: assume every
regulator reports magnitudes (absolute values). If the chip has a
bipolar supply configuration, then assume positive references are above
ground (>= 0 V) and negative references are below ground (<= 0 V). This
is not a hardware constraint, but it is the most common wiring.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/ti-ads1262.c | 493 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 468 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index 86ea9b6232d8..c87c0a66119a 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -8,6 +8,7 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/bitmap.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
@@ -18,12 +19,14 @@
 #include <linux/interrupt.h>
 #include <linux/lockdep.h>
 #include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/units.h>
 
@@ -83,6 +86,7 @@
 #define ADS1262_MODE2_REG			0x05
 #define   ADS1262_MODE2_BYPASS_MASK		BIT(7)
 #define   ADS1262_MODE2_GAIN_MASK		GENMASK(6, 4)
+#define     ADS1262_GAIN_COUNT			6
 #define   ADS1262_MODE2_DR_MASK			GENMASK(3, 0)
 #define     ADS1262_DR_2_5_SPS			  0
 #define     ADS1262_DR_5_SPS			  1
@@ -123,7 +127,7 @@
 #define ADS1262_IDACMUX_REG			0x0D
 #define   ADS1262_IDACMUX_MUX2_MASK		GENMASK(7, 4)
 #define   ADS1262_IDACMUX_MUX1_MASK		GENMASK(3, 0)
-#define     ADS1262_IDACMUX_NO_CONN		0b1011
+#define     ADS1262_IDACMUX_NO_CONN		  11
 
 #define ADS1262_IDACMAG_REG			0x0E
 #define   ADS1262_IDACMAG_MAG2_MASK		GENMASK(7, 4)
@@ -131,7 +135,17 @@
 
 #define ADS1262_REFMUX_REG			0x0F
 #define   ADS1262_REFMUX_RMUXP_MASK		GENMASK(5, 3)
+#define     ADS1262_RMUXP_INTERNAL		  0
+#define     ADS1262_RMUXP_REFP1			  1
+#define     ADS1262_RMUXP_REFP2			  2
+#define     ADS1262_RMUXP_REFP3			  3
+#define     ADS1262_RMUXP_AVDD			  4
 #define   ADS1262_REFMUX_RMUXN_MASK		GENMASK(2, 0)
+#define     ADS1262_RMUXN_INTERNAL		  0
+#define     ADS1262_RMUXN_REFN1			  1
+#define     ADS1262_RMUXN_REFN2			  2
+#define     ADS1262_RMUXN_REFN3			  3
+#define     ADS1262_RMUXN_AVSS			  4
 
 #define ADS1262_TDACP_REG			0x10
 #define   ADS1262_TDACP_OUTP_MASK		BIT(7)
@@ -169,9 +183,13 @@
 
 #define ADS1262_NOMINAL_CLK_RATE		7372800
 #define ADS1262_MODULATOR_DIV			8
+#define ADS1262_INTERNAL_REFERENCE_uV		2500000
+#define ADS1262_TEMP_SLOPE_uV_C			420ULL
+#define ADS1262_TEMP_ZERO_C			111900ULL
 
 #define ADS1262_FW_CHANNEL_COUNT		16
 #define ADS1262_MON_CHANNEL_COUNT		4
+#define ADS1262_EXT_REF_COUNT			3
 #define ADS1262_REGMAP_WRITE_SZ			8
 #define ADS1262_MONITOR_ADDR_OFFSET		100
 
@@ -180,12 +198,21 @@
 struct ads1262_channel {
 	u8 data_rate;
 	u8 filter;
+	u8 gain;
+	u8 ref_p;
+	u8 ref_n;
+	bool ref_reversal;
+	bool is_resistance;
+	size_t num_scales;
+	int scales[ADS1262_GAIN_COUNT][2];
 };
 
 struct ads1262 {
 	struct spi_device *spi;
 	struct regmap *regmap;
 	struct gpio_desc *start_gpiod;
+	struct regulator *avdd_supply;
+	struct regulator *avss_supply;
 	size_t num_channels;
 	struct ads1262_channel *channels;
 	/* protects concurrent SPI transfers */
@@ -195,8 +222,12 @@ struct ads1262 {
 	struct completion drdy;
 	unsigned long clk_rate;
 	u8 dev_id;
+	bool bipolar_supply;
 	int sampling_freq_table[ADS1262_DR_COUNT][2];
 	int sampling_freq_fir[ADS1262_DR_16_6_SPS + 1][2];
+	u32 rref_ohms[ADS1262_EXT_REF_COUNT][ADS1262_EXT_REF_COUNT];
+	int refp_uV[ADS1262_EXT_REF_COUNT];
+	int refn_uV[ADS1262_EXT_REF_COUNT];
 };
 
 static const char * const ads1262_device_id_to_name[] = {
@@ -217,8 +248,11 @@ static const struct iio_chan_spec ads1262_monitor_chan_specs[] = {
 			.endianness = IIO_BE,
 		},
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
-		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+				      BIT(IIO_CHAN_INFO_OFFSET) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+						BIT(IIO_CHAN_INFO_SCALE),
 	},
 	{
 		.type = IIO_VOLTAGE,
@@ -233,8 +267,10 @@ static const struct iio_chan_spec ads1262_monitor_chan_specs[] = {
 			.endianness = IIO_BE,
 		},
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
-		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+						BIT(IIO_CHAN_INFO_SCALE),
 	},
 	{
 		.type = IIO_VOLTAGE,
@@ -249,8 +285,10 @@ static const struct iio_chan_spec ads1262_monitor_chan_specs[] = {
 			.endianness = IIO_BE,
 		},
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
-		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+						BIT(IIO_CHAN_INFO_SCALE),
 	},
 	{
 		.type = IIO_VOLTAGE,
@@ -266,8 +304,10 @@ static const struct iio_chan_spec ads1262_monitor_chan_specs[] = {
 			.endianness = IIO_BE,
 		},
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
-		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+						BIT(IIO_CHAN_INFO_SCALE),
 	},
 };
 
@@ -314,6 +354,24 @@ static const u32 ads1262_mod_decimator_b[] = {
 	[ADS1262_DR_38400_SPS]	= 1,
 };
 
+static const char * const ads1262_ref_sources_pos[] = {
+	[ADS1262_RMUXP_INTERNAL] = "internal-p",
+	[ADS1262_RMUXP_REFP1] = "refp1",
+	[ADS1262_RMUXP_REFP2] = "refp2",
+	[ADS1262_RMUXP_REFP3] = "refp3",
+	[ADS1262_RMUXP_AVDD] = "avdd",
+	NULL
+};
+
+static const char * const ads1262_ref_sources_neg[] = {
+	[ADS1262_RMUXN_INTERNAL] = "internal-n",
+	[ADS1262_RMUXN_REFN1] = "refn1",
+	[ADS1262_RMUXN_REFN2] = "refn2",
+	[ADS1262_RMUXN_REFN3] = "refn3",
+	[ADS1262_RMUXN_AVSS] = "avss",
+	NULL
+};
+
 static int ads1262_find_two(const int (*array)[2], size_t num_elements, int val,
 			    int val2)
 {
@@ -325,6 +383,12 @@ static int ads1262_find_two(const int (*array)[2], size_t num_elements, int val,
 	return -EINVAL;
 }
 
+static bool ads1262_reference_is_external(int ref_p, int ref_n)
+{
+	return in_range(ref_p, ADS1262_RMUXP_REFP1, ADS1262_EXT_REF_COUNT) &&
+	       in_range(ref_n, ADS1262_RMUXN_REFN1, ADS1262_EXT_REF_COUNT);
+}
+
 static int ads1262_dev_send_cmd(struct ads1262 *st, u8 opcode)
 {
 	guard(mutex)(&st->xfer_lock);
@@ -455,17 +519,33 @@ static int ads1262_channel_enable(struct ads1262 *st,
 	guard(mutex)(&st->xfer_lock);
 	guard(mutex)(&st->chan_lock);
 
-	ret = regmap_update_bits(st->regmap, ADS1262_MODE2_REG,
-				 ADS1262_MODE2_DR_MASK,
-				 FIELD_PREP(ADS1262_MODE2_DR_MASK, chan->data_rate));
+	ret = regmap_update_bits(st->regmap, ADS1262_MODE0_REG,
+				 ADS1262_MODE0_REFREV_MASK,
+				 FIELD_PREP(ADS1262_MODE0_REFREV_MASK, chan->ref_reversal));
 	if (ret)
 		return ret;
 
-	return regmap_update_bits(st->regmap, ADS1262_INPMUX_REG,
-				  ADS1262_INPMUX_MUXN_MASK |
-				  ADS1262_INPMUX_MUXP_MASK,
-				  FIELD_PREP(ADS1262_INPMUX_MUXN_MASK, spec->channel2) |
-				  FIELD_PREP(ADS1262_INPMUX_MUXP_MASK, spec->channel));
+	ret = regmap_update_bits(st->regmap, ADS1262_MODE2_REG,
+				 ADS1262_MODE2_DR_MASK |
+				 ADS1262_MODE2_GAIN_MASK,
+				 FIELD_PREP(ADS1262_MODE2_DR_MASK, chan->data_rate) |
+				 FIELD_PREP(ADS1262_MODE2_GAIN_MASK, chan->gain));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADS1262_INPMUX_REG,
+				 ADS1262_INPMUX_MUXN_MASK |
+				 ADS1262_INPMUX_MUXP_MASK,
+				 FIELD_PREP(ADS1262_INPMUX_MUXN_MASK, spec->channel2) |
+				 FIELD_PREP(ADS1262_INPMUX_MUXP_MASK, spec->channel));
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->regmap, ADS1262_REFMUX_REG,
+				  ADS1262_REFMUX_RMUXN_MASK |
+				  ADS1262_REFMUX_RMUXP_MASK,
+				  FIELD_PREP(ADS1262_REFMUX_RMUXN_MASK, chan->ref_n) |
+				  FIELD_PREP(ADS1262_REFMUX_RMUXP_MASK, chan->ref_p));
 }
 
 static int ads1262_set_runmode(struct ads1262 *st, u8 runmode)
@@ -514,6 +594,7 @@ static int ads1262_read_raw(struct iio_dev *indio_dev,
 {
 	struct ads1262 *st = iio_priv(indio_dev);
 	struct ads1262_channel *chan_data = &st->channels[chan->scan_index];
+	u64 scale, offset;
 	__be32 raw;
 	int ret;
 
@@ -526,6 +607,34 @@ static int ads1262_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 
+	case IIO_CHAN_INFO_SCALE: {
+		guard(mutex)(&st->chan_lock);
+
+		*val = chan_data->scales[chan_data->gain][0];
+		*val2 = chan_data->scales[chan_data->gain][1];
+
+		return IIO_VAL_DECIMAL64_PICO;
+	}
+
+	case IIO_CHAN_INFO_OFFSET: {
+		guard(mutex)(&st->chan_lock);
+
+		scale = iio_val_s64_compose(chan_data->scales[chan_data->gain][0],
+					    chan_data->scales[chan_data->gain][1]);
+
+		switch (chan->type) {
+		case IIO_TEMP:
+			offset = -mul_u64_u64_div_u64(ADS1262_TEMP_ZERO_C,
+						      PICO * MILLIDEGREE_PER_DEGREE,
+						      scale * ADS1262_TEMP_SLOPE_uV_C);
+			iio_val_s64_decompose(offset, val, val2);
+
+			return IIO_VAL_INT_64;
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
+
 	case IIO_CHAN_INFO_SAMP_FREQ: {
 		guard(mutex)(&st->chan_lock);
 
@@ -548,6 +657,12 @@ static int ads1262_read_avail(struct iio_dev *indio_dev,
 	struct ads1262_channel *chan_data = &st->channels[chan->scan_index];
 
 	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*type = IIO_VAL_DECIMAL64_PICO;
+		*vals = (const int *)chan_data->scales;
+		*length = chan_data->num_scales * 2;
+		return IIO_AVAIL_LIST;
+
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*type = IIO_VAL_INT_PLUS_MICRO;
 
@@ -580,6 +695,16 @@ static int ads1262_write_raw(struct iio_dev *indio_dev,
 	guard(mutex)(&st->chan_lock);
 
 	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		ret = ads1262_find_two(chan_data->scales, chan_data->num_scales,
+				       val, val2);
+		if (ret < 0)
+			return ret;
+
+		chan_data->gain = ret;
+
+		return 0;
+
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		switch (chan_data->filter) {
 		case ADS1262_FILTER_FIR:
@@ -621,6 +746,17 @@ static int ads1262_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int re
 	return regmap_write(st->regmap, reg, writeval);
 }
 
+static int ads1262_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_DECIMAL64_PICO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
 static int ads1262_fwnode_xlate(struct iio_dev *indio_dev,
 				const struct fwnode_reference_args *iiospec)
 {
@@ -643,6 +779,7 @@ static const struct iio_info ads1262_iio_info = {
 	.read_raw = ads1262_read_raw,
 	.read_avail = ads1262_read_avail,
 	.write_raw = ads1262_write_raw,
+	.write_raw_get_fmt = ads1262_write_raw_get_fmt,
 	.debugfs_reg_access = ads1262_debugfs_reg_access,
 	.fwnode_xlate = ads1262_fwnode_xlate,
 };
@@ -895,20 +1032,246 @@ static void ads1262_populate_samp_freqs(struct ads1262 *st)
 	}
 }
 
+static void ads1262_calculate_scales(int (*scales)[2], size_t num_scales,
+				     u32 full_scale, u64 mult,
+				     u32 resolution)
+{
+	unsigned int i;
+	s64 val;
+
+	/*
+	 * Each scale in the table corresponds to a PGA gain configuration,
+	 * which are given in powers of 2.
+	 */
+	for (i = 0; i < num_scales; i++) {
+		val = mul_u64_u64_shr(full_scale, mult, resolution - 1 + i);
+		iio_val_s64_decompose(val, &scales[i][0], &scales[i][1]);
+	}
+}
+
+static int ads1262_populate_scales_resistance(struct ads1262 *st,
+					      const struct iio_chan_spec *spec)
+{
+	struct ads1262_channel *chan = &st->channels[spec->scan_index];
+	u32 full_scale;
+
+	if (!ads1262_reference_is_external(chan->ref_p, chan->ref_n))
+		return -EINVAL;
+
+	full_scale = st->rref_ohms[chan->ref_p - 1][chan->ref_n - 1];
+
+	chan->num_scales = ARRAY_SIZE(chan->scales);
+
+	ads1262_calculate_scales(chan->scales, chan->num_scales, full_scale,
+				 PICO, ADS1262_ADC1_RESOLUTION);
+
+	return 0;
+}
+
+static int ads1262_populate_scales_temp(struct ads1262 *st,
+					const struct iio_chan_spec *spec)
+{
+	struct ads1262_channel *chan = &st->channels[spec->scan_index];
+	u32 full_scale;
+	u64 mult;
+
+	full_scale = ADS1262_INTERNAL_REFERENCE_uV;
+	mult = PICO * MILLIDEGREE_PER_DEGREE / ADS1262_TEMP_SLOPE_uV_C;
+
+	chan->num_scales = 1;
+
+	ads1262_calculate_scales(chan->scales, chan->num_scales, full_scale,
+				 mult, ADS1262_ADC1_RESOLUTION);
+
+	return 0;
+}
+
+static int ads1262_populate_scales_voltage(struct ads1262 *st,
+					   const struct iio_chan_spec *spec)
+{
+	struct device *dev = &st->spi->dev;
+	struct ads1262_channel *chan = &st->channels[spec->scan_index];
+	int refp_uV, refn_uV;
+	u32 full_scale_uV;
+	u64 mult;
+	int ret;
+
+	switch (chan->ref_p) {
+	case ADS1262_RMUXP_INTERNAL:
+		ret = st->avss_supply ? regulator_get_voltage(st->avss_supply) : 0;
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "channel@%u: failed to get avss voltage\n",
+					     spec->scan_index);
+
+		/* The internal reference negative is AVSS */
+		refp_uV = -ret + ADS1262_INTERNAL_REFERENCE_uV;
+		break;
+
+	case ADS1262_RMUXP_REFP1 ... ADS1262_RMUXP_REFP3:
+		refp_uV = st->refp_uV[chan->ref_p - 1];
+		break;
+
+	case ADS1262_RMUXP_AVDD:
+		ret = regulator_get_voltage(st->avdd_supply);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "channel@%u: failed to get avdd voltage\n",
+					     spec->scan_index);
+		refp_uV = ret;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	switch (chan->ref_n) {
+	case ADS1262_RMUXN_INTERNAL:
+	case ADS1262_RMUXN_AVSS:
+		ret = st->avss_supply ? regulator_get_voltage(st->avss_supply) : 0;
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "channel@%u: failed to get avss voltage\n",
+					     spec->scan_index);
+		refn_uV = -ret;
+		break;
+
+	case ADS1262_RMUXN_REFN1 ... ADS1262_RMUXN_REFN3:
+		refn_uV = st->refn_uV[chan->ref_n - 1];
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	full_scale_uV = abs(refp_uV - refn_uV);
+	if (full_scale_uV < 900000)
+		return dev_err_probe(dev, -EINVAL, "channel@%u: reference voltage below 0.9V\n",
+				     spec->scan_index);
+
+	if (spec->channel >= ADS1262_INPMUX_AVDD &&
+	    spec->channel <= ADS1262_INPMUX_DVDD) {
+		/* The power supply monitors are scaled down by a factor of 4 */
+		mult = 4;
+		chan->num_scales = 1;
+	} else {
+		mult = 1;
+		chan->num_scales = ARRAY_SIZE(chan->scales);
+	}
+
+	ads1262_calculate_scales(chan->scales, chan->num_scales, full_scale_uV,
+				 NANO * mult, ADS1262_ADC1_RESOLUTION);
+
+	return 0;
+}
+
+static int ads1262_parse_references(struct ads1262 *st)
+{
+	struct device *dev = &st->spi->dev;
+	unsigned int i, j;
+	char name[sizeof("ti,refpN-refnM-resistor-ohms")];
+	u32 ohms;
+	int ret;
+
+	for (i = ADS1262_RMUXP_REFP1; i <= ADS1262_RMUXP_REFP3; i++) {
+		scnprintf(name, sizeof(name), "refp%u", i);
+		ret = devm_regulator_get_enable_read_voltage(dev, name);
+		if (ret < 0 && ret != -ENODEV)
+			return dev_err_probe(dev, ret, "failed to read reference voltage: %s\n",
+					     name);
+
+		st->refp_uV[i - 1] = ret == -ENODEV ? 0 : ret;
+	}
+
+	for (i = ADS1262_RMUXN_REFN1; i <= ADS1262_RMUXN_REFN3; i++) {
+		scnprintf(name, sizeof(name), "refn%u", i);
+		ret = devm_regulator_get_enable_read_voltage(dev, name);
+		if (ret < 0 && ret != -ENODEV)
+			return dev_err_probe(dev, ret, "failed to read reference voltage: %s\n",
+					     name);
+
+		/*
+		 * REVISIT: Currently the regulator subsystem doesn't support
+		 * reading negative voltages. If we have a bipolar supply
+		 * configuration (AVSS < 0), then we are forced to assume that
+		 * negative references are either 0V (no regulator) or below
+		 * ground magnitudes.
+		 */
+		if (st->bipolar_supply)
+			st->refn_uV[i - 1] = ret == -ENODEV ? 0 : -ret;
+		else
+			st->refn_uV[i - 1] = ret == -ENODEV ? 0 : ret;
+	}
+
+	for (i = ADS1262_RMUXP_REFP1; i <= ADS1262_RMUXP_REFP3; i++) {
+		for (j = ADS1262_RMUXN_REFN1; j <= ADS1262_RMUXN_REFN3; j++) {
+			scnprintf(name, sizeof(name),
+				  "ti,refp%u-refn%u-resistor-ohms", i, j);
+
+			if (!device_property_present(dev, name))
+				continue;
+
+			ret = device_property_read_u32(dev, name, &ohms);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "failed to read reference resistor: %s\n",
+						     name);
+			if (!ohms)
+				return dev_err_probe(dev, -EINVAL,
+						     "reference resistor can't be 0 ohms: %s\n",
+						     name);
+
+			st->rref_ohms[i - 1][j - 1] = ohms;
+		}
+	}
+
+	return 0;
+}
+
 static int ads1262_populate_tables(struct iio_dev *indio_dev)
 {
 	struct ads1262 *st = iio_priv(indio_dev);
+	const struct iio_chan_spec *spec;
+	int ret;
 
 	ads1262_populate_samp_freqs(st);
 
+	ret = ads1262_parse_references(st);
+	if (ret)
+		return ret;
+
+	for (unsigned int i = 0; i < st->num_channels; i++) {
+		spec = &indio_dev->channels[i];
+
+		switch (spec->type) {
+		case IIO_VOLTAGE:
+			ret = ads1262_populate_scales_voltage(st, spec);
+			if (ret)
+				return ret;
+			break;
+		case IIO_TEMP:
+			ret = ads1262_populate_scales_temp(st, spec);
+			if (ret)
+				return ret;
+			break;
+		case IIO_RESISTANCE:
+			ret = ads1262_populate_scales_resistance(st, spec);
+			if (ret)
+				return ret;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
+
 	return 0;
 }
 
 static int ads1262_parse_channel_node(struct ads1262 *st,
 				      struct iio_chan_spec *spec,
+				      struct ads1262_channel *chan,
 				      struct fwnode_handle *node)
 {
 	struct device *dev = &st->spi->dev;
+	const char *sources[2];
+	char name[sizeof("ti,refpN-refnM-resistor-ohms")];
 	u32 pins[2];
 	int ret;
 
@@ -947,6 +1310,38 @@ static int ads1262_parse_channel_node(struct ads1262 *st,
 	spec->channel = pins[0];
 	spec->channel2 = pins[1];
 
+	if (fwnode_property_present(node, "reference-sources")) {
+		ret = fwnode_property_read_string_array(node, "reference-sources",
+							sources, ARRAY_SIZE(sources));
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "%pfwP: failed to read reference-sources\n",
+					     node);
+		if (ret < 2)
+			return dev_err_probe(dev, -EINVAL, "%pfwP: missing reference-sources\n",
+					     node);
+
+		ret = match_string(ads1262_ref_sources_pos, -1, sources[0]);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "%pfwP: invalid positive reference source\n",
+					     node);
+		chan->ref_p = ret;
+
+		ret = match_string(ads1262_ref_sources_neg, -1, sources[1]);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "%pfwP: invalid negative reference source\n",
+					     node);
+		chan->ref_n = ret;
+
+		if (ads1262_reference_is_external(chan->ref_p, chan->ref_n)) {
+			scnprintf(name, sizeof(name), "ti,refp%u-refn%u-resistor-ohms",
+				  chan->ref_p, chan->ref_n);
+			if (device_property_present(dev, name))
+				chan->is_resistance = true;
+		}
+	}
+
+	chan->ref_reversal = fwnode_property_read_bool(node, "ti,reference-reversal");
+
 	return 0;
 }
 
@@ -988,11 +1383,11 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
 
 		*chan = (struct ads1262_channel)ads1262_default_channel;
 
-		ret = ads1262_parse_channel_node(st, spec, node);
+		ret = ads1262_parse_channel_node(st, spec, chan, node);
 		if (ret)
 			return ret;
 
-		spec->type = IIO_VOLTAGE;
+		spec->type = chan->is_resistance ? IIO_RESISTANCE : IIO_VOLTAGE;
 		spec->indexed = true;
 		spec->scan_index = i;
 		spec->address = reg;
@@ -1003,8 +1398,10 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
 			.endianness = IIO_BE,
 		};
 		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-					   BIT(IIO_CHAN_INFO_SAMP_FREQ);
-		spec->info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ);
+					   BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_SCALE);
+		spec->info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+						     BIT(IIO_CHAN_INFO_SCALE);
 
 		i++;
 	}
@@ -1027,6 +1424,14 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static void ads1262_regulator_disable(void *data)
+{
+	struct regulator *supply = data;
+
+	if (supply)
+		regulator_disable(supply);
+}
+
 static int ads1262_supply_setup(struct ads1262 *st)
 {
 	struct device *dev = &st->spi->dev;
@@ -1036,14 +1441,52 @@ static int ads1262_supply_setup(struct ads1262 *st)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to get dvdd regulator\n");
 
-	ret = devm_regulator_get_enable(dev, "avdd");
-	if (ret < 0)
+	st->avdd_supply = devm_regulator_get(dev, "avdd");
+	ret = PTR_ERR_OR_ZERO(st->avdd_supply);
+	if (ret)
 		return dev_err_probe(dev, ret, "failed to get avdd regulator\n");
 
-	ret = devm_regulator_get_enable_optional(dev, "avss");
-	if (ret < 0 && ret != -ENODEV)
+	ret = regulator_enable(st->avdd_supply);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, ads1262_regulator_disable,
+				       st->avdd_supply);
+	if (ret)
+		return ret;
+
+	/*
+	 * REVISIT: The AVSS supply has a minimum of -2.5V and maximum of 0V.
+	 * Currently the regulator subsystem doesn't support negative voltages,
+	 * so we assume the value returned here is actually the magnitude
+	 * (absolute value).
+	 *
+	 * This limitation forces us to assume that, if we have a bipolar supply
+	 * (AVSS < 0V), all negative references are below ground (REFN <= 0V)
+	 * and positive references are above ground (REFP >= 0V), as this is the
+	 * most common configuration.
+	 */
+	st->avss_supply = devm_regulator_get_optional(dev, "avss");
+	ret = PTR_ERR_OR_ZERO(st->avss_supply);
+	if (ret && ret != -ENODEV)
 		return dev_err_probe(dev, ret, "failed to get avss regulator\n");
 
+	if (ret != -ENODEV) {
+		ret = regulator_enable(st->avss_supply);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(dev, ads1262_regulator_disable,
+					       st->avss_supply);
+		if (ret)
+			return ret;
+
+		st->bipolar_supply = true;
+	} else  {
+		st->avss_supply = NULL;
+		st->bipolar_supply = false;
+	}
+
 	fsleep(ADS1262_POWER_TRANS_USECS);
 
 	return 0;

-- 
2.55.0

