Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955C4433E80
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071370; cv=none; b=cn5ZMlgzQsoaSpcPkukxu4WRwQSBPXIJ74VeDG4Gc+YJAfDuMoVHwR2FhXKufAP9UkrLA7Fq59aO/akfsA/6k4qop5Eh7cYvWezgUirws6APn2AM3AAnZs2yNc9Arqy+q3uP9goZqbzvErmnYNYGLN7XvMwWntUFDvrvyAuGOtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071370; c=relaxed/simple;
	bh=G65Ti4QAMGB3NTJ8s0MkoDBtHTtbBSTfAKdXE3aAfz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oBpd9DdUGbL/jWHUSasBZDvDOS73XU3vvJETpsYgX3YfDge6LGqFLugM1gJo2zfb0lK4EIFgqmz6jMuMSUsxHQ2Ht1Htj5+Pce1qvNse64FlpL21wyPiJzhxQbIeaEDMzsabEgRWU/zXTzX+16Xtij4bAK1VyM7nvUqrQAs5rwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=CI4KCFTr; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="CI4KCFTr"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4960fb63c75so953045b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784071365; x=1784676165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ss+hmrk11EmJyPlPd6A3156r9SwPO30C/Pjs1VHs3Q=;
        b=CI4KCFTrAvxBhY0ZzLT3VS0qq9p7Z0GnMBCjT6kemyQS8VUGLvDBjZoQEROb7ZJpWP
         2V0mQ3plEFNRF51VbLiuDh6N1rgJ+RylsGXuCeDT+AVrj85gB/t42S7G3bPkB3NkvKHV
         Rlc2blod4RLGFUj2eGqfvvds1uQTATiD+V7oswy+9wVgX205VXBMCH/NcokSJLMNlyP9
         5SgbhaBcqW6JktvlDlPhXevA2sRdmEhVWPw+3rfh6SVbSgXSDyh3HDu8SEMmBaZG32q5
         eXI3PXVse/fdHAQ8VPvh3KipECbhVNxAZIZtsH29boFVy5ONNlcKvVX0YuYN3G8T/NUz
         mz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784071365; x=1784676165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ss+hmrk11EmJyPlPd6A3156r9SwPO30C/Pjs1VHs3Q=;
        b=M9f86N4eBMTyybA+1FKxqVDVWfTYVdQI+kbhSR5MfYIdioNadXoEL1IevWgeV1GI6C
         X5MhZxejYM/OtdEpPeQp7F3J/iVVTlJ0RhmjAl165v7Pdd0H/0PXllPJ/ucdCDYCP7Sn
         JautiihRVuyN0C2uBjOdjsvYWCIbu2zNIdHyvlnlkxol2t5Kjnq8KpCMu23+y/VsG+1l
         0xqyqr8jFe9Hsd54tndBuuVS+NzBkM5aZcBsWPQqqWWvFNCVOL3B3SjQqeWFlxf2dxPW
         lB5LqVIv5SpDqUxOSsLfCkK35wcRBS7QltWSYCV7ozWF+YeD9pOfixAruJZJcZ5SharH
         Xbtw==
X-Forwarded-Encrypted: i=1; AFNElJ+yE9OBUCzgPZc5Yij/mSYknCU2wSMQhZC8M4/ZDRKFtt3bUJ2kxpMp0ZGDWM2pTaw0n6wazX/HHoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwdDrQ8HQ/0L9mKHiAWRAbfXs/wgPzRk6lNz4XCatjCQSKxrN/
	FhxywwJu6RM0BQ7XGCHNrvA5OzLG5CcsMEfr5Yy2G3O8H88hVxw15A2+238TsYEmqGc=
X-Gm-Gg: AfdE7cmnomtIEuXV5OPbqltmerlwen/gU4C8QSMbaSJrGeQwZCEFHLknKHrKAM9yaJO
	2nsLadK4knlywM9Hg3Xz3aLOqEziTymIa//D905bd+XKQIzJr3F1zMnzYC3OgmsXK8A2x4H2i4K
	GaYceUnjyBJwa5RdEdGHDfkoFhtpAJFEzxl1aQnFWZBgGXj796qnG/UjKf1UXUzXS0SQSHitbvI
	n8vntEB60eOxApszOYJ3qcEYZSwvuZ1+nCznE0esLU7MDF2x28VtoAWmLI2jA0wiInc53OG3FSa
	9dKL8bxk6Jueey20qr4tkKRoH5wRX0SaOh5GC2JEfWy3OWg3sC6iz3fn2BJFDlHoWxLNoMqPlK+
	ClHoJeG0ZLFAEpAwEjGBEx/DWa7prZV2ps57nXww1LL1TzEnguzptwECRAhEXG84p+EJpG2Eem3
	LtrKyaFRcBtkFVq5tEwg==
X-Received: by 2002:a05:6820:4dc4:b0:6a1:50eb:2118 with SMTP id 006d021491bc7-6a39a71fd1amr8702786eaf.60.1784071365226;
        Tue, 14 Jul 2026 16:22:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a39af0e953sm7561978eaf.3.2026.07.14.16.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:22:44 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Tue, 14 Jul 2026 18:21:30 -0500
Subject: [PATCH v4 8/8] iio: adc: ti-ads112c14: add measurement channel
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260714-iio-adc-ti-ads122c14-v4-8-25f8e3084485@baylibre.com>
References: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
In-Reply-To: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=23271;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=G65Ti4QAMGB3NTJ8s0MkoDBtHTtbBSTfAKdXE3aAfz0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqVsSsGOpLLRkyL75EhoXfjapWiV5aRmiN2f92+
 oxY32wJ2KGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalbErAAKCRDCzCAB/wGP
 wP5KB/9UoD7QNB5aVzupQFrxf3chnOYV3jbbfPQCa+whoueQ3i+ahFG1kJc53A1/qwaehl+00cF
 xBZ2YS0IfYgaRTqvcM8ry+fG/FLdnGMBAO6i74PxOFUQySeZP1EunkdKgQ+gtdGP1L6wuu4cPQh
 eR2CW58K1epbz1EDlGM0/7Tcr9iO4pgv2MIHNeLPEexSL2aBmAicFFpou1ZgccdQvqZYWaMuYkP
 MquNrfPGCvIHfvHSMuPpS3/IjreaNB8g0ruMtjSPxXJlhVmqMTB0Ey4T612JOH6v1A46Y0X4d5Y
 16xca+evu8jvk0wDv92iymvQiPgXqSvvp1oYnttQDFTosVgC
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for parsing devicetree properties for measurement channels
and doing direct reads on these.

There are quite a lot of conditions that have to be met for each
measurement to be made, so quite a bit of state and algorithms are
required to handle it.

Channels are created dynamically since the number of possibilities is
unreasonably large.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
v4 changes:
* Removed burnout code (saving for later).
* Use regmap_assign_bits() for bipolar.
* Use mutex to protect scale state.

v3 changes:
* Checked error when getting "label" property.
* Removed call of fwnode_device_is_available().
* Used IIO_VAL_DECIMAL64_PICO for scale.
* Added switch in ads112c14_read_avail() to reduce future diff.

v2 changes:
* Adapted for changes in DT bindings.
* Fixed bug in IDAC current register value calculation.
* Fix uninitialized variable bug.
* Fix bug in data->num_measurements calculation.
* Use IIO_RESISTANCE instead of IIO_VOLTAGE when external reference is
  used and it is a resistor rather than a voltage source.
* Fix bug with negative input mux selection on single-ended measurements.
* Fixed return checks of devm_regulator_get_enable_read_voltage().
---
 drivers/iio/adc/ti-ads112c14.c | 504 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 493 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 17bb6472a39b..fef3a9c37ced 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -12,9 +12,11 @@
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
+#include <linux/device/devres.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/property.h>
@@ -77,6 +79,7 @@
 #define ADS112C14_REG_MUX_CFG				0x07
 #define   ADS112C14_MUX_CFG_AINP			GENMASK(7, 4)
 #define   ADS112C14_MUX_CFG_AINN			GENMASK(3, 0)
+#define     ADS112C14_MUX_CFG_AIN_GND			  8
 
 #define ADS112C14_REG_GAIN_CFG				0x08
 #define   ADS112C14_GAIN_CFG_SPARE			BIT(7)
@@ -130,6 +133,20 @@
 #define ADS112C14_INT_REF0_mV				1250
 #define ADS112C14_INT_REF1_mV				2500
 
+enum {
+	ADS112C14_VREF_SOURCE_INTERNAL_2_5V,
+	ADS112C14_VREF_SOURCE_INTERNAL_1_25V,
+	ADS112C14_VREF_SOURCE_EXTERNAL,
+	ADS112C14_VREF_SOURCE_AVDD,
+};
+
+static const char * const ads112c14_vref_source_names[] = {
+	[ADS112C14_VREF_SOURCE_INTERNAL_2_5V] = "internal-2.5v",
+	[ADS112C14_VREF_SOURCE_INTERNAL_1_25V] = "internal-1.25v",
+	[ADS112C14_VREF_SOURCE_EXTERNAL] = "external",
+	[ADS112C14_VREF_SOURCE_AVDD] = "avdd",
+};
+
 /*
  * Available gains as tenths (e.g. value 5 == 0.5 gain). Indexes correspond to
  * ADS112C14_GAIN_CFG_GAIN values.
@@ -204,11 +221,33 @@ static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
 	},
 };
 
+struct ads112c14_measurement {
+	const char *label;
+	u32 vref_source;
+	u8 iunit;
+	u8 idac1_mag;
+	u8 idac2_mag;
+	u8 idac1_mux;
+	u8 idac2_mux;
+	u8 iadc_count;
+	u8 gain_val;
+	bool global_chop;
+	bool bipolar;
+	int scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)][2];
+};
+
 struct ads112c14_data {
 	const struct ads112c14_chip_info *chip_info;
 	struct regmap *regmap;
 	/* Synchronizes access to register value fields. */
 	struct mutex lock;
+	u32 avdd_uV;
+	u32 ext_ref_uV;
+	bool refp_is_avdd;
+	bool refn_is_gnd;
+	u32 ext_ref_ohms;
+	struct ads112c14_measurement *measurements;
+	u32 num_measurements;
 	u8 sys_mon_chan_short_gain_val;
 	int sys_mon_chan_short_scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)][2];
 };
@@ -263,12 +302,112 @@ static const struct regmap_config ads112c14_regmap_config = {
 	.cache_type = REGCACHE_MAPLE,
 };
 
+static int ads112c14_prepare_measurement_channel(struct ads112c14_data *data,
+						 const struct iio_chan_spec *chan)
+{
+	struct ads112c14_measurement *measurement = &data->measurements[chan->scan_index];
+	u32 refp_buf_en, refn_buf_en, ref_val, ref_sel;
+	int ret;
+
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_MUX_CFG,
+				 ADS112C14_MUX_CFG_AINP | ADS112C14_MUX_CFG_AINN,
+				 FIELD_PREP(ADS112C14_MUX_CFG_AINP, chan->channel) |
+				 FIELD_PREP(ADS112C14_MUX_CFG_AINN, chan->channel2));
+	if (ret)
+		return ret;
+
+	ret = regmap_assign_bits(data->regmap, ADS112C14_REG_DIGITAL_CFG,
+				 ADS112C14_DIGITAL_CFG_CODING,
+				 !measurement->bipolar);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_GAIN_CFG,
+				 ADS112C14_GAIN_CFG_SYS_MON |
+				 ADS112C14_GAIN_CFG_GAIN,
+				 FIELD_PREP(ADS112C14_GAIN_CFG_SYS_MON, 0) |
+				 FIELD_PREP(ADS112C14_GAIN_CFG_GAIN,
+					    measurement->gain_val));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_IDAC_MAG_CFG,
+				 ADS112C14_IDAC_MAG_CFG_I2MAG |
+				 ADS112C14_IDAC_MAG_CFG_I1MAG,
+				 FIELD_PREP(ADS112C14_IDAC_MAG_CFG_I2MAG,
+					    measurement->idac2_mag) |
+				 FIELD_PREP(ADS112C14_IDAC_MAG_CFG_I1MAG,
+					    measurement->idac1_mag));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_IDAC_MUX_CFG,
+				 ADS112C14_IDAC_MUX_CFG_IUNIT |
+				 ADS112C14_IDAC_MUX_CFG_I2MUX |
+				 ADS112C14_IDAC_MUX_CFG_I1MUX,
+				 FIELD_PREP(ADS112C14_IDAC_MUX_CFG_IUNIT,
+					    measurement->iunit) |
+				 FIELD_PREP(ADS112C14_IDAC_MUX_CFG_I2MUX,
+					    measurement->idac2_mux) |
+				 FIELD_PREP(ADS112C14_IDAC_MUX_CFG_I1MUX,
+					    measurement->idac1_mux));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DATA_RATE_CFG,
+				 ADS112C14_DATA_RATE_CFG_GC_EN,
+				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_GC_EN,
+					    measurement->global_chop));
+	if (ret)
+		return ret;
+
+	refp_buf_en = !data->refp_is_avdd &&
+		      measurement->vref_source == ADS112C14_VREF_SOURCE_EXTERNAL;
+	refn_buf_en = !data->refn_is_gnd &&
+		      measurement->vref_source == ADS112C14_VREF_SOURCE_EXTERNAL;
+
+	ref_val = measurement->vref_source == ADS112C14_VREF_SOURCE_INTERNAL_2_5V ?
+		ADS112C14_REFERENCE_CFG_REF_VAL_2_5V :
+		ADS112C14_REFERENCE_CFG_REF_VAL_1_25V;
+
+	switch (measurement->vref_source) {
+	case ADS112C14_VREF_SOURCE_AVDD:
+		ref_sel = ADS112C14_REFERENCE_CFG_REF_SEL_AVDD;
+		break;
+	case ADS112C14_VREF_SOURCE_EXTERNAL:
+		ref_sel = ADS112C14_REFERENCE_CFG_REF_SEL_EXTERNAL;
+		break;
+	default:
+		ref_sel = ADS112C14_REFERENCE_CFG_REF_SEL_INTERNAL;
+		break;
+	}
+
+	return regmap_update_bits(data->regmap, ADS112C14_REG_REFERENCE_CFG,
+				  ADS112C14_REFERENCE_CFG_REFP_BUF_EN |
+				  ADS112C14_REFERENCE_CFG_REFN_BUF_EN |
+				  ADS112C14_REFERENCE_CFG_REF_VAL |
+				  ADS112C14_REFERENCE_CFG_REF_SEL,
+				  FIELD_PREP(ADS112C14_REFERENCE_CFG_REFP_BUF_EN,
+					     refp_buf_en) |
+				  FIELD_PREP(ADS112C14_REFERENCE_CFG_REFN_BUF_EN,
+					     refn_buf_en) |
+				  FIELD_PREP(ADS112C14_REFERENCE_CFG_REF_VAL,
+					     ref_val) |
+				  FIELD_PREP(ADS112C14_REFERENCE_CFG_REF_SEL,
+					     ref_sel));
+}
+
 static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
 					     const struct iio_chan_spec *chan)
 {
 	u32 gain_val;
 	int ret;
 
+	/*
+	 * NB: IDAC registers are left as-is in case they are generating current
+	 * needed for the external reference measurement.
+	 */
+
 	/*
 	 * All SYS_MON channels use GAIN of 1 to keep it simple. Other than
 	 * the internal short channel, where it is useful in practice.
@@ -326,8 +465,9 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 	guard(mutex)(&data->lock);
 
 	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
-		/* Not implemented yet. */
-		return -EINVAL;
+		ret = ads112c14_prepare_measurement_channel(data, chan);
+		if (ret)
+			return ret;
 	} else {
 		ret = ads112c14_prepare_sys_mon_channel(data, chan);
 		if (ret)
@@ -356,6 +496,7 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 			      int *val, int *val2, long mask)
 {
 	struct ads112c14_data *data = iio_priv(indio_dev);
+	struct ads112c14_measurement *measurement = NULL;
 	const int *scale_avail;
 	u32 vref_uV, fsr_bits;
 
@@ -363,8 +504,8 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 	vref_uV = ADS112C14_INT_REF1_mV * (MICRO / MILLI);
 
 	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
-		/* Not implemented yet. */
-		return -EINVAL;
+		measurement = &data->measurements[chan->scan_index];
+		fsr_bits = data->chip_info->resolution_bits - measurement->bipolar;
 	} else {
 		/* All SYS_MON channels are using signed coding. */
 		fsr_bits = data->chip_info->resolution_bits - 1;
@@ -394,7 +535,8 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 
-		*val = sign_extend32(*val, fsr_bits);
+		if (!measurement || measurement->bipolar)
+			*val = sign_extend32(*val, fsr_bits);
 
 		return IIO_VAL_INT;
 	}
@@ -406,6 +548,16 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_FRACTIONAL_LOG2;
 		}
 
+		if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
+			guard(mutex)(&data->lock);
+
+			scale_avail = measurement->scale_available[measurement->gain_val];
+			*val = scale_avail[0];
+			*val2 = scale_avail[1];
+
+			return IIO_VAL_DECIMAL64_PICO;
+		}
+
 		if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
 			u8 idx;
 
@@ -459,6 +611,18 @@ static int ads112c14_read_avail(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
+		if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
+			struct ads112c14_measurement *measurement;
+
+			guard(mutex)(&data->lock);
+
+			measurement = &data->measurements[chan->scan_index];
+			*vals = (const int *)measurement->scale_available;
+			*length = 2 * ARRAY_SIZE(measurement->scale_available);
+			*type = IIO_VAL_DECIMAL64_PICO;
+			return IIO_AVAIL_LIST;
+		}
+
 		if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
 			guard(mutex)(&data->lock);
 
@@ -486,7 +650,13 @@ static int ads112c14_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE: {
 		guard(mutex)(&data->lock);
 
-		if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
+		if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
+			struct ads112c14_measurement *measurement;
+
+			measurement = &data->measurements[chan->scan_index];
+			scale_avail = measurement->scale_available;
+			gain_val = &measurement->gain_val;
+		} else if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
 			scale_avail = data->sys_mon_chan_short_scale_available;
 			gain_val = &data->sys_mon_chan_short_gain_val;
 		} else {
@@ -523,8 +693,20 @@ static int ads112c14_write_raw_get_fmt(struct iio_dev *indio_dev,
 static int ads112c14_read_label(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan, char *label)
 {
+	struct ads112c14_data *data = iio_priv(indio_dev);
 	const char *label_source;
 
+	/* measurement channels */
+	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
+		struct ads112c14_measurement *measurement;
+
+		measurement = &data->measurements[chan->scan_index];
+		if (!measurement->label)
+			return -EINVAL;
+
+		return sysfs_emit(label, "%s\n", measurement->label);
+	}
+
 	/* System monitor channels. */
 	switch (chan->channel) {
 	case ADS112C14_SYS_MON_CHANNEL_TEMP:
@@ -557,6 +739,215 @@ static const struct iio_info ads112c14_info = {
 	.read_label = ads112c14_read_label,
 };
 
+static int ads112c14_populate_idac_mag(u32 current_nA, u8 *idac_mag)
+{
+	u32 current_uA = current_nA / (NANO / MICRO);
+
+	/* Convert microamps to IMAG bits */
+	if (current_uA == 1)
+		*idac_mag = 1;
+	else if (in_range(current_uA, 10, 100) && current_uA % 10 == 0)
+		*idac_mag = current_uA / 10 + 1;
+	else
+		return dev_err_probe(NULL, -EINVAL,
+				     "invalid excitation-current-nanoamp value\n");
+
+	return 0;
+}
+
+static int ads112c14_parse_channels(struct iio_dev *indio_dev,
+				    bool *need_avdd_ref, bool *need_ext_ref)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
+	struct iio_chan_spec *channels;
+	u32 num_child_nodes, i, pair[2];
+	int ret;
+
+	*need_avdd_ref = false;
+	*need_ext_ref = false;
+
+	num_child_nodes = device_get_named_child_node_count(dev, "channel");
+
+	data->measurements = devm_kcalloc(dev, num_child_nodes,
+					  sizeof(*data->measurements), GFP_KERNEL);
+	if (!data->measurements)
+		return -ENOMEM;
+
+	channels = devm_kcalloc(dev, num_child_nodes +
+				ARRAY_SIZE(ads112c14_sys_mon_channels),
+				sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	i = 0;
+	device_for_each_named_child_node_scoped(dev, child, "channel") {
+		struct ads112c14_measurement *measurement = &data->measurements[i];
+		struct iio_chan_spec *spec = &channels[i];
+
+		spec->indexed = 1;
+		spec->scan_index = i;
+		measurement->gain_val = 1;
+
+		if (fwnode_property_present(child, "label")) {
+			ret = fwnode_property_read_string(child, "label", &measurement->label);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "failed to read label property\n");
+		}
+
+		if (fwnode_property_present(child, "single-channel")) {
+			ret = fwnode_property_read_u32(child, "single-channel",
+						       &pair[0]);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "failed to read single-channel property\n");
+
+			if (pair[0] >= 8)
+				return dev_err_probe(dev, -EINVAL,
+						     "single-channel value must be between 0 and 7\n");
+
+			spec->channel = pair[0];
+			/*
+			 * NB: channel2 is unused by iio core code in this case.
+			 * Let's us avoid special case for negative input mux
+			 * for single-ended channels when taking measurements.
+			 */
+			spec->channel2 = ADS112C14_MUX_CFG_AIN_GND;
+		} else if (fwnode_property_present(child, "diff-channels")) {
+			ret = fwnode_property_read_u32_array(child, "diff-channels",
+							     pair, ARRAY_SIZE(pair));
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "failed to read diff-channels property\n");
+
+			if (pair[0] >= 8 || pair[1] >= 8)
+				return dev_err_probe(dev, -EINVAL,
+						     "diff-channels values must be between 0 and 7\n");
+
+			spec->differential = 1;
+			spec->channel = pair[0];
+			spec->channel2 = pair[1];
+		} else {
+			return dev_err_probe(dev, -EINVAL,
+					     "channel node missing channel type property\n");
+		}
+
+		if (fwnode_property_present(child, "excitation-channels")) {
+			ret = fwnode_property_count_u32(child, "excitation-channels");
+			if (ret < 0)
+				return dev_err_probe(dev, ret,
+						     "failed to read excitation-channels property\n");
+
+			if (ret < 1 || ret > 2)
+				return dev_err_probe(dev, -EINVAL,
+						     "excitation-channels property must have 1 or 2 values\n");
+
+			measurement->iadc_count = ret;
+			pair[1] = 0;
+
+			ret = fwnode_property_read_u32_array(child, "excitation-channels",
+							     pair, measurement->iadc_count);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "failed to read excitation-channels property\n");
+
+			if (pair[0] >= 8 || pair[1] >= 8)
+				return dev_err_probe(dev, -EINVAL,
+						     "excitation-channels values must be between 0 and 7\n");
+
+			measurement->idac1_mux = pair[0];
+			measurement->idac2_mux = measurement->iadc_count > 1 ? pair[1] : 0;
+
+			ret = fwnode_property_read_u32_array(child, "excitation-current-nanoamp",
+							     pair, measurement->iadc_count);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "failed to read excitation-current-nanoamp property\n");
+
+			if (pair[0] <= 100 * (NANO / MICRO) &&
+			    (measurement->iadc_count == 1 || pair[1] <= 100 * (NANO / MICRO))) {
+				/*
+				 * If both values are 100µA or less, then we can
+				 * use IUNIT = 1µA for better precision.
+				 */
+				ret = ads112c14_populate_idac_mag(pair[0],
+								  &measurement->idac1_mag);
+				if (ret)
+					return ret;
+
+				if (measurement->iadc_count > 1) {
+					ret = ads112c14_populate_idac_mag(pair[1],
+									  &measurement->idac2_mag);
+					if (ret)
+						return ret;
+				}
+			} else {
+				/*
+				 * Otherwise, IUINT is 10µA (flag set) and so
+				 * IxMAG is 1/10 of the actual current.
+				 */
+				measurement->iunit = 1;
+
+				ret = ads112c14_populate_idac_mag(pair[0] / 10,
+								  &measurement->idac1_mag);
+				if (ret)
+					return ret;
+
+				if (measurement->iadc_count > 1) {
+					ret = ads112c14_populate_idac_mag(pair[1] / 10,
+									  &measurement->idac2_mag);
+					if (ret)
+						return ret;
+				}
+			}
+		}
+
+		measurement->bipolar = fwnode_property_read_bool(child, "bipolar");
+		measurement->global_chop = fwnode_property_read_bool(child,
+								     "input-chopping");
+
+		if (fwnode_property_present(child, "reference-sources")) {
+			ret = fwnode_property_match_property_string(child,
+				"reference-sources", ads112c14_vref_source_names,
+				ARRAY_SIZE(ads112c14_vref_source_names));
+			if (ret < 0)
+				return dev_err_probe(dev, ret,
+						     "invalid reference-sources value\n");
+
+			measurement->vref_source = ret;
+		}
+
+		if (measurement->vref_source == ADS112C14_VREF_SOURCE_AVDD)
+			*need_avdd_ref = true;
+		if (measurement->vref_source == ADS112C14_VREF_SOURCE_EXTERNAL)
+			*need_ext_ref = true;
+
+		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE);
+		spec->info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE);
+
+		/*
+		 * If reference source is resistor rather than voltage supply,
+		 * then the measurement is effectively a resistance measurement.
+		 */
+		spec->type = (measurement->vref_source == ADS112C14_VREF_SOURCE_EXTERNAL &&
+			      data->ext_ref_ohms) ? IIO_RESISTANCE : IIO_VOLTAGE;
+
+		if (spec->type == IIO_RESISTANCE)
+			spec->differential = 0;
+
+		i++;
+	}
+
+	data->num_measurements = i;
+	memcpy(channels + i, ads112c14_sys_mon_channels, sizeof(ads112c14_sys_mon_channels));
+
+	indio_dev->channels = channels;
+	indio_dev->num_channels = i + ARRAY_SIZE(ads112c14_sys_mon_channels);
+
+	return 0;
+}
+
 static void ads112c14_populate_scale_available(int (*scale_avail)[2],
 					       u32 full_scale, u32 fsr_bits)
 {
@@ -576,6 +967,33 @@ static void ads112c14_populate_tables(struct ads112c14_data *data)
 {
 	u32 full_scale, fsr_bits;
 
+	for (u32 i = 0; i < data->num_measurements; i++) {
+		struct ads112c14_measurement *measurement = &data->measurements[i];
+
+		switch (measurement->vref_source) {
+		case ADS112C14_VREF_SOURCE_EXTERNAL:
+			if (data->ext_ref_ohms)
+				full_scale = data->ext_ref_ohms;
+			else
+				full_scale = data->ext_ref_uV / (MICRO / MILLI);
+			break;
+		case ADS112C14_VREF_SOURCE_AVDD:
+			full_scale = data->avdd_uV / (MICRO / MILLI);
+			break;
+		case ADS112C14_VREF_SOURCE_INTERNAL_1_25V:
+			full_scale = ADS112C14_INT_REF0_mV;
+			break;
+		default:
+			full_scale = ADS112C14_INT_REF1_mV;
+			break;
+		}
+
+		fsr_bits = data->chip_info->resolution_bits - measurement->bipolar;
+
+		ads112c14_populate_scale_available(measurement->scale_available,
+						   full_scale, fsr_bits);
+	}
+
 	/* For now, assuming all sys_mon channels are using 2.5V reference. */
 	full_scale = ADS112C14_INT_REF1_mV;
 	fsr_bits = data->chip_info->resolution_bits - 1;
@@ -590,6 +1008,9 @@ static int ads112c14_probe(struct i2c_client *client)
 	const struct ads112c14_chip_info *info;
 	struct iio_dev *indio_dev;
 	struct ads112c14_data *data;
+	bool need_avdd_ref, need_ext_ref;
+	u32 refp_uV = 0;
+	u32 refn_uV = 0;
 	u32 reg_val;
 	int ret;
 
@@ -608,13 +1029,76 @@ static int ads112c14_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	if (device_property_present(dev, "ti,refp-refn-resistor-ohms")) {
+		ret = device_property_read_u32(dev, "ti,refp-refn-resistor-ohms",
+					       &data->ext_ref_ohms);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to read ti,refp-refn-resistor-ohms property\n");
+	}
+
+	ret = ads112c14_parse_channels(indio_dev, &need_avdd_ref, &need_ext_ref);
+	if (ret)
+		return ret;
+
 	ret = devm_regulator_get_enable(dev, "dvdd");
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to get dvdd regulator\n");
 
-	ret = devm_regulator_get_enable(dev, "avdd");
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to get avdd regulator\n");
+	if (need_avdd_ref) {
+		ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "failed to get avdd voltage\n");
+
+		data->avdd_uV = ret;
+	} else {
+		ret = devm_regulator_get_enable(dev, "avdd");
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to get avdd regulator\n");
+	}
+
+	if (device_property_present(dev, "refp-supply")) {
+		ret = devm_regulator_get_enable_read_voltage(dev, "refp");
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "failed to get refp voltage\n");
+
+		refp_uV = ret;
+
+		struct fwnode_handle *refp_fwnode __free(fwnode_handle) =
+			fwnode_find_reference(dev->fwnode, "refp-supply", 0);
+		if (IS_ERR(refp_fwnode))
+			return dev_err_probe(dev, PTR_ERR(refp_fwnode),
+					     "failed to get refp fwnode\n");
+
+		struct fwnode_handle *avdd_fwnode __free(fwnode_handle) =
+			fwnode_find_reference(dev->fwnode, "avdd-supply", 0);
+		if (IS_ERR(avdd_fwnode))
+			return dev_err_probe(dev, PTR_ERR(avdd_fwnode),
+					     "failed to get avdd fwnode\n");
+
+		/* REFP buffer should not be enabled when connected to AVDD */
+		data->refp_is_avdd = refp_fwnode == avdd_fwnode;
+	}
+
+	if (device_property_present(dev, "refn-supply")) {
+		ret = devm_regulator_get_enable_read_voltage(dev, "refn");
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "failed to get refn voltage\n");
+
+		refn_uV = ret;
+	} else {
+		data->refn_is_gnd = true;
+	}
+
+	data->ext_ref_uV = refp_uV - refn_uV;
+
+	if (data->ext_ref_uV && data->ext_ref_ohms)
+		return dev_err_probe(dev, -EINVAL,
+				     "ti,refp-refn-resistor-ohms property should not be present when refp-supply or refn-supply is present\n");
+
+	if (need_ext_ref && !data->ext_ref_uV && !data->ext_ref_ohms)
+		return dev_err_probe(dev, -EINVAL,
+				     "external reference measurements require either refp-supply or ti,refp-refn-resistor-ohms property\n");
 
 	/* It takes some time for the internal reference to stabilize. */
 	fsleep(10 * USEC_PER_MSEC);
@@ -676,8 +1160,6 @@ static int ads112c14_probe(struct i2c_client *client)
 
 	indio_dev->name = info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = ads112c14_sys_mon_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ads112c14_sys_mon_channels);
 	indio_dev->info = &ads112c14_info;
 
 	return devm_iio_device_register(dev, indio_dev);

-- 
2.43.0

