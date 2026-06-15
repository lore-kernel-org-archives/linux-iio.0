Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A53B6C16
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560885; cv=none; b=pGp07OwznHaqpakGm5Z5sV+AMsjljoezyT4V+JZhyRUITIKmKMBo3dYIwiKoTDMYvnKswef4z2GZZShm1wMjkIT142YXjrM5G0HyL+Zf/GLnQcJywx7Hn2d1eKG1ghHm60hQJq3ur12znFyBYK6SAY9qblaRZAnsSTxINtVorIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560885; c=relaxed/simple;
	bh=Wot0X5sM7W60XK/7A4SLB9FW8RU+5PSWJVYyz9AxsUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FjHLLVGFnRqNQoy7QF352I7mRGb1dmO51CLp5FdLkSi7X7G1JBQvwLYvdxi3vQ2wYUY3jIq3s2zNR7YT7OdPwp56PlPkKIPJFGJx1l36pbGAvddy8x17FUoOHWVy4TfodnUdd1t1UwDzh2FTuBP/scViBuXZLsiSu3OjvJaj/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=gbKfv6fG; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="gbKfv6fG"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-43f1f2b82c6so2310770fac.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 15:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781560876; x=1782165676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVZH06lpazCnDdLB2HaYUQMqWrPKqXrIVmhsIkv9GcA=;
        b=gbKfv6fG5XRb+FzpjCD+sXMJyRZiC2s1855JagAaCHGMnvNbIbEtyLlgOLtZ2TAOkN
         PBZ6rBvopWuRmDQ40D0pyZvZoonbuxxHzdZh2NWOJ/kzLGwxUVMsaBXz6aVswI6LQmXN
         U41LXFU9hDWO+LQUdGHKLyfZp7zgvLmknMqt0M+BGLm4J8pkOoL2AkPFl3Yc66OBS0G9
         cGqios4EzLJZlSUe2k+884tu1TjUm56p3ZvjhTiCwvobFVckMeqzjkCYUmkdqPz8ExHE
         laEDrCS1sPIhstyeMgnYPeZEC1R5O7Z6OhQGo3xlyCvwTy7VJFSUeQjJ1PLzglbMMXwf
         0DQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781560876; x=1782165676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oVZH06lpazCnDdLB2HaYUQMqWrPKqXrIVmhsIkv9GcA=;
        b=He+wQjGbE03M0m9rMmGU4rAwwRpEGpm3jKrvKdL7r/djUVnpUZuVTqGtBfZRxZTFxZ
         inxf7rDPxAJ4srjE3pEbTYmujK+Y7lXrFcO008VGjoV2eYav0Xe+RpeZAA6t4BgoYV70
         jTJ5WYYCN8gut7l3w6IAUcrakpwRxA+YdM379YOM4mCDYfaUyYCRm/KQACUWOybJdQif
         OCUnRINo0qazdsDmfSSZvnrMJmiNDRaW31W4qyxDn4H6nnh0akpsCKPMfLG2isE/2a0I
         +4k9QrT78HVMS5PSBXBlSBIsb78Jh0Kl4GPk8ju7U9VZOvQhMzhcP8a1qtaIVW9dEQZL
         Le0A==
X-Forwarded-Encrypted: i=1; AFNElJ9IocTvwRJkKxVHIhRtauYcH79x8rTmBHrZmmU8ijdUIWHczHn2SRPTWYfj+UfnlBpTxH+g0FVqfxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy6h7+Lv9g0up3gs59GewNWA2LcpD1mlYsmGidI4CwcyPMndxS
	75D3B1qUIH00BzVboj+fFW0SNF8GOJdlapeC6VRDEQEJlqcevpAT+2mnbBFWdi9rw8k=
X-Gm-Gg: Acq92OE+momzHtVkk7hMld4XmmA1grd2lVv/nLxsLpWluYFjNPSbzOYsFkzN4BTuVKr
	VkfwtfONQGX4nhX0NmTyivEKP/cIitfUvBPg3PQcfzEDwQqp7c/vWNAyqxt9p4og8oUnQ+xYFl2
	Ym415mmkI+TQREtRKtNfdlX7R9b7kwDWpeGi9ZWOV3Mv2sEci38DP6V4JzIzKimxkTsUpTXz299
	Fn1b+pIfCQUYzQAIk+VfAtTY3i3qceBqGPSigPSSsKz3A+ql0Pn517Uh9FalQT3jgWbYKiKiqJZ
	kaFFGej2Dgq/sabGNVcfjTLrz4d9L36as9uDyx/oVH7QaasvRp8sLuXMSBFAfoQEVCIsh5hcvrX
	mEvqoB+yaZ0u/jGTJB9x9rRi6CuSsM8bULJrRSro5nPen0/G0G+zoVJS5BOCui9iYHjbNGl7Lj3
	8kaKx9q42xEWL/vQlMwFp2eANB3dHo
X-Received: by 2002:a05:6870:9686:b0:439:b8f6:d2a5 with SMTP id 586e51a60fabf-4430b7848c8mr847363fac.31.1781560875392;
        Mon, 15 Jun 2026 15:01:15 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308fd9221sm826145fac.15.2026.06.15.15.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 15:01:15 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Mon, 15 Jun 2026 17:00:02 -0500
Subject: [PATCH 4/4] iio: adc: ti-ads112c14: add measurement channel
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-iio-adc-ti-ads122c14-v1-4-e6bdadf7cb2b@baylibre.com>
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
In-Reply-To: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=22417;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=Wot0X5sM7W60XK/7A4SLB9FW8RU+5PSWJVYyz9AxsUI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqMHYgFaWE286xZ+v1sjbAq24qdfm0DIpBjI1Qp
 5I6f/MDVsyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCajB2IAAKCRDCzCAB/wGP
 wA38B/0TqvdTC1Fxtt9N3LANn12/tadX0Vt5bvb5V6BeztJ7pYUWZ1VmhvUBNkGqVUlLCl3jE2p
 FygWWMQcpcgE8XyILJWTbND+YAoaCI+vAMR24qebpG00SdIM1t8sYmqYA74p0xUSDgXKlCbeiLi
 yQhQOBvjRbFak6oxvd2OR7k1/TjkoekrRsINxt43U3o61WvM2tZ3tODi04e0Er7kLTG2wfcbPKi
 6nYnalWqicChsa4XfUsUX822KZeVLx/KsM95eO+XLoR1b2YYXAF59RieBpSnkttUtpYbrmg7WZI
 FDCshLhLPOl1v6QbCMFK6t2/McXldkhRPSTNzHaATH59V04H
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
 drivers/iio/adc/ti-ads112c14.c | 486 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 439 insertions(+), 47 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 202a449b4234..d1297445025f 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -9,8 +9,10 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
+#include <linux/device/devres.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
@@ -26,6 +28,8 @@
 #include <linux/unaligned.h>
 #include <linux/units.h>
 
+#include <dt-bindings/iio/adc/ti,ads112c14.h>
+
 /* Datasheet t_d(RST) - time to wait after reset before next I2C use. */
 #define ADS112C14_DELAY_RESET_us 500
 
@@ -89,6 +93,9 @@
 #define   ADS112C14_REFERENCE_CFG_REF_VAL_1_25V		  0
 #define   ADS112C14_REFERENCE_CFG_REF_VAL_2_5V		  1
 #define ADS112C14_REFERENCE_CFG_REF_SEL			GENMASK(1, 0)
+#define   ADS112C14_REFERENCE_CFG_REF_SEL_INTERNAL	  0
+#define   ADS112C14_REFERENCE_CFG_REF_SEL_EXTERNAL	  1
+#define   ADS112C14_REFERENCE_CFG_REF_SEL_AVDD		  2
 
 #define ADS112C14_REG_DIGITAL_CFG			0x0A
 #define ADS112C14_DIGITAL_CFG_REG_MAP_CRC_EN		BIT(6)
@@ -197,10 +204,30 @@ struct ads112c14_chip_info {
 	u32 resolution_bits;
 };
 
+struct ads112c14_measurement {
+	const char *label;
+	u32 vref_source;
+	u32 idac_current_uA;
+	u8 iadc_count;
+	u8 idac1_mux;
+	u8 idac2_mux;
+	bool current_chop;
+	bool bipolar;
+	u8 gain_val;
+	int scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)][2];
+};
+
 struct ads112c14_data {
 	const struct ads112c14_chip_info *chip_info;
 	struct i2c_client *client;
 	struct regmap *regmap;
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
@@ -265,12 +292,106 @@ static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
 	},
 };
 
+static int ads112c14_prepare_measurement_channel(struct ads112c14_data *data,
+						 const struct iio_chan_spec *chan)
+{
+	struct ads112c14_measurement *measurement = &data->measurements[chan->scan_index];
+	bool iunit = measurement->idac_current_uA > 100;
+	u32 idac1_val = measurement->iadc_count > 0 ?
+		measurement->idac_current_uA / (iunit ? 100 : 10) : 0;
+	u32 idac2_val = measurement->iadc_count > 1 ? idac1_val : 0;
+	u32 refp_buf_en, refn_buf_en;
+	u32 ref_val, ref_sel;
+	int ret;
+
+	ret = regmap_write(data->regmap, ADS112C14_REG_MUX_CFG,
+			   FIELD_PREP(ADS112C14_MUX_CFG_AINP, chan->channel) |
+			   FIELD_PREP(ADS112C14_MUX_CFG_AINN, chan->channel2));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DIGITAL_CFG,
+				 ADS112C14_DIGITAL_CFG_CODING,
+				 FIELD_PREP(ADS112C14_DIGITAL_CFG_CODING,
+					    measurement->bipolar ? 0 : 1));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_GAIN_CFG,
+				 ADS112C14_GAIN_CFG_SYS_MON | ADS112C14_GAIN_CFG_GAIN,
+				 FIELD_PREP(ADS112C14_GAIN_CFG_SYS_MON, 0) |
+				 FIELD_PREP(ADS112C14_GAIN_CFG_GAIN,
+					    measurement->gain_val));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, ADS112C14_REG_IDAC_MAG_CFG,
+			   FIELD_PREP(ADS112C14_IDAC_MAG_CFG_I2MAG, idac2_val) |
+			   FIELD_PREP(ADS112C14_IDAC_MAG_CFG_I1MAG, idac1_val));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, ADS112C14_REG_IDAC_MUX_CFG,
+			   (iunit ? ADS112C14_IDAC_MUX_CFG_IUNIT : 0) |
+			   FIELD_PREP(ADS112C14_IDAC_MUX_CFG_I2MUX,
+				      measurement->idac2_mux) |
+			   FIELD_PREP(ADS112C14_IDAC_MUX_CFG_I1MUX,
+				      measurement->idac1_mux));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DATA_RATE_CFG,
+				 ADS112C14_DATA_RATE_CFG_GC_EN,
+				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_GC_EN,
+					    measurement->current_chop));
+	if (ret)
+		return ret;
+
+	refp_buf_en = !data->refp_is_avdd &&
+		      measurement->vref_source == ADS112C14_VREF_SOURCE_EXTERNAL;
+	refn_buf_en = !data->refn_is_gnd &&
+		      measurement->vref_source == ADS112C14_VREF_SOURCE_EXTERNAL;
+
+	ref_val = measurement->vref_source == ADS112C14_VREF_SOURCE_INTERNAL_2_5V;
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
@@ -320,13 +441,14 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 	u32 reg_val;
 	int ret;
 
-	if (chan->channel >= 100) {
-		ret = ads112c14_prepare_sys_mon_channel(data, chan);
+	if (chan->channel < 100) {
+		ret = ads112c14_prepare_measurement_channel(data, chan);
 		if (ret)
 			return ret;
 	} else {
-		/* Not implemented yet. */
-		return -EINVAL;
+		ret = ads112c14_prepare_sys_mon_channel(data, chan);
+		if (ret)
+			return ret;
 	}
 
 	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
@@ -351,13 +473,20 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 			      int *val2, long mask)
 {
 	struct ads112c14_data *data = iio_priv(indio_dev);
+	struct ads112c14_measurement *measurement;
 	u32 vref_uV, fsr_bits;
+	int *scale_avail;
 
 	/* Selecting V_REF source is not implemented yet. */
 	vref_uV = ads112c14_internal_ref_uV[ADS112C14_REFERENCE_CFG_REF_VAL_2_5V];
 
-	/* Currently, everything is using signed data. */
-	fsr_bits = data->chip_info->resolution_bits - 1;
+	if (chan->channel < 100) {
+		measurement = &data->measurements[chan->scan_index];
+		fsr_bits = data->chip_info->resolution_bits - measurement->bipolar;
+	} else {
+		/* All SYS_MON channels are using signed coding. */
+		fsr_bits = data->chip_info->resolution_bits - 1;
+	}
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW: {
@@ -383,7 +512,8 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 
-		*val = sign_extend32(*val, fsr_bits);
+		if (!measurement || measurement->bipolar)
+			*val = sign_extend32(*val, fsr_bits);
 
 		return IIO_VAL_INT;
 	}
@@ -396,7 +526,7 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 		}
 
 		if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
-			int *scale_avail = data->sys_mon_chan_short_scale_available[
+			scale_avail = data->sys_mon_chan_short_scale_available[
 				data->sys_mon_chan_short_gain_val
 			];
 
@@ -406,13 +536,23 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT_PLUS_NANO;
 		}
 
-		*val = vref_uV / (MICRO / MILLI);
-		/*
-		 * Last 3 SYS_MON channels (ext ref, AVDD, DVDD) need to be
-		 * multiplied by 8 to account for internal attenuation of / 8.
-		 */
-		*val2 = fsr_bits - (chan->address >= 3 ? 3 : 0);
-		return IIO_VAL_FRACTIONAL_LOG2;
+		if (chan->channel > 100) {
+			*val = vref_uV / (MICRO / MILLI);
+			/*
+			 * Last 3 SYS_MON channels (ext ref, AVDD, DVDD) need to
+			 * be multiplied by 8 to account for internal attenuation
+			 * of / 8.
+			 */
+			*val2 = fsr_bits - (chan->address >= 3 ? 3 : 0);
+
+			return IIO_VAL_FRACTIONAL_LOG2;
+		}
+
+		scale_avail = measurement->scale_available[measurement->gain_val];
+		*val = scale_avail[0];
+		*val2 = scale_avail[1];
+
+		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_OFFSET:
 		/* Only the temperature channel has an offset. */
 		if (chan->type != IIO_TEMP)
@@ -433,6 +573,16 @@ static int ads112c14_read_avail(struct iio_dev *indio_dev,
 {
 	struct ads112c14_data *data = iio_priv(indio_dev);
 
+	if (chan->channel < 100) {
+		struct ads112c14_measurement *measurement =
+			&data->measurements[chan->scan_index];
+
+		*vals = (const int *)measurement->scale_available;
+		*length = 2 * ARRAY_SIZE(measurement->scale_available);
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_LIST;
+	}
+
 	switch (chan->channel) {
 	case ADS112C14_SYS_MON_CHANNEL_SHORT:
 		*vals = (const int *)data->sys_mon_chan_short_scale_available;
@@ -449,25 +599,31 @@ static int ads112c14_write_raw(struct iio_dev *indio_dev,
 			       int val2, long mask)
 {
 	struct ads112c14_data *data = iio_priv(indio_dev);
+	const int (*scale_avail)[2];
+	u8 *gain_val;
+
+	if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
+		scale_avail = data->sys_mon_chan_short_scale_available;
+		gain_val = &data->sys_mon_chan_short_gain_val;
+	} else if (chan->channel < 100) {
+		scale_avail = data->measurements[chan->scan_index].scale_available;
+		gain_val = &data->measurements[chan->scan_index].gain_val;
+	} else {
+		return -EINVAL;
+	}
 
-	switch (chan->channel) {
-	case ADS112C14_SYS_MON_CHANNEL_SHORT: {
-		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
-		if (IIO_DEV_ACQUIRE_FAILED(claim))
-			return -EBUSY;
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
 
-		for (u32 i = 0; i < ARRAY_SIZE(data->sys_mon_chan_short_scale_available); i++) {
-			if (val == data->sys_mon_chan_short_scale_available[i][0] &&
-			    val2 == data->sys_mon_chan_short_scale_available[i][1]) {
-				data->sys_mon_chan_short_gain_val = i;
-				return 0;
-			}
+	for (u32 i = 0; i < ARRAY_SIZE(ads112c14_pga_gains_x10); i++) {
+		if (val == scale_avail[i][0] && val2 == scale_avail[i][1]) {
+			*gain_val = i;
+			return 0;
 		}
-		return -EINVAL;
-	}
-	default:
-		return -EINVAL;
 	}
+
+	return -EINVAL;
 }
 
 static int ads112c14_write_raw_get_fmt(struct iio_dev *indio_dev,
@@ -485,8 +641,20 @@ static int ads112c14_write_raw_get_fmt(struct iio_dev *indio_dev,
 static int ads112c14_read_label(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan, char *label)
 {
+	struct ads112c14_data *data = iio_priv(indio_dev);
 	const char *label_source;
 
+	/* measurement channels */
+	if (chan->channel < 100) {
+		struct ads112c14_measurement *measurement =
+			&data->measurements[chan->scan_index];
+
+		if (!measurement->label)
+			return -EINVAL;
+
+		return sysfs_emit(label, "%s\n", measurement->label);
+	}
+
 	/* System monitor channels. */
 	switch (chan->channel) {
 	case ADS112C14_SYS_MON_CHANNEL_TEMP:
@@ -519,26 +687,187 @@ static const struct iio_info ads112c14_info = {
 	.read_label = ads112c14_read_label,
 };
 
+static int ads112c14_parse_channels(struct iio_dev *indio_dev,
+				    bool *need_avdd_ref, bool *need_ext_ref)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+	struct iio_chan_spec *channels;
+	u32 pair[2];
+	int i = 0;
+	int ret;
+
+	*need_avdd_ref = false;
+	*need_ext_ref = false;
+
+	data->num_measurements = device_get_named_child_node_count(dev, "channel");
+
+	data->measurements = devm_kcalloc(dev, data->num_measurements,
+					  sizeof(*data->measurements), GFP_KERNEL);
+	if (!data->measurements)
+		return -ENOMEM;
+
+	data->num_measurements += ARRAY_SIZE(ads112c14_sys_mon_channels);
+
+	channels = devm_kcalloc(dev, data->num_measurements +
+				ARRAY_SIZE(ads112c14_sys_mon_channels),
+				sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	device_for_each_named_child_node_scoped(dev, child, "channel") {
+		struct ads112c14_measurement *measurement = &data->measurements[i];
+		struct iio_chan_spec *spec = &channels[i];
+
+		if (!fwnode_device_is_available(child))
+			continue;
+
+		spec->type = IIO_VOLTAGE;
+		spec->indexed = 1;
+		spec->scan_index = i;
+		measurement->gain_val = 1;
+
+		fwnode_property_read_string(child, "label", &measurement->label);
+
+		if (fwnode_property_present(child, "single-channel")) {
+			ret = fwnode_property_read_u32(child, "single-channel", &spec->channel);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "failed to read single-channel property\n");
+
+			if (spec->channel >= 8)
+				return dev_err_probe(dev, -EINVAL,
+						     "single-channel value must be between 0 and 7\n");
+		} else if (fwnode_property_present(child, "diff-channels")) {
+			ret = fwnode_property_read_u32_array(child, "diff-channels", pair, ARRAY_SIZE(pair));
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "failed to read diff-channels property\n");
+
+			if (pair[0] >= 8 || pair[1] >= 8)
+				return dev_err_probe(dev, -EINVAL,
+						     "diff-channels values must be between 0 and 7\n");
+
+			spec->channel = pair[0];
+			spec->channel2 = pair[1];
+			spec->differential = 1;
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
+			ret = fwnode_property_read_u32_array(child, "excitation-channels", pair, measurement->iadc_count);
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
+			ret = fwnode_property_read_u32(child, "excitation-current-microamp",
+						       &measurement->idac_current_uA);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "failed to read excitation-current-microamp property\n");
+
+			measurement->current_chop = fwnode_property_read_bool(child, "current-chopping");
+		}
+
+		measurement->bipolar = fwnode_property_read_bool(child, "bipolar");
+
+		fwnode_property_read_u32(child, "ti,vref-source", &measurement->vref_source);
+		if (measurement->vref_source > ADS112C14_VREF_SOURCE_AVDD)
+			return dev_err_probe(dev, -EINVAL,
+					     "invalid vref-source value\n");
+
+		if (measurement->vref_source == ADS112C14_VREF_SOURCE_AVDD)
+			*need_avdd_ref = true;
+		if (measurement->vref_source == ADS112C14_VREF_SOURCE_EXTERNAL)
+			*need_ext_ref = true;
+
+		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE);
+		spec->info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE);
+
+		i++;
+	}
+
+	memcpy(channels + i, ads112c14_sys_mon_channels, sizeof(ads112c14_sys_mon_channels));
+
+	indio_dev->channels = channels;
+	indio_dev->num_channels = i + ARRAY_SIZE(ads112c14_sys_mon_channels);
+
+	return 0;
+}
+
+static void ads112c14_populate_scale_available(int scale_avail[][2],
+					       u32 vref_uV, u32 fsr_bits)
+{
+	for (u32 i = 0; i < ARRAY_SIZE(ads112c14_pga_gains_x10); i++) {
+		int *entry = scale_avail[i];
+		u32 gain_x10 = ads112c14_pga_gains_x10[i];
+
+		entry[0] = div_u64_rem(div64_u64((u64)(NANO * 10 /
+						       (MICRO / MILLI)) * vref_uV,
+						 (u64)gain_x10 * BIT(fsr_bits)),
+				       NANO, &entry[1]);
+	}
+}
+
 static void ads112c14_populate_tables(struct ads112c14_data *data)
 {
 	u32 vref_uV, fsr_bits;
-	int i;
+
+	for (u32 i = 0; i < data->num_measurements; i++) {
+		struct ads112c14_measurement *measurement = &data->measurements[i];
+
+		switch (measurement->vref_source) {
+		case ADS112C14_VREF_SOURCE_EXTERNAL:
+			if (data->ext_ref_ohms)
+				vref_uV = measurement->idac_current_uA *
+					  measurement->iadc_count * data->ext_ref_ohms;
+			else
+				vref_uV = data->ext_ref_uV;
+			break;
+		case ADS112C14_VREF_SOURCE_AVDD:
+			vref_uV = data->avdd_uV;
+			break;
+		case ADS112C14_VREF_SOURCE_INTERNAL_1_25V:
+			vref_uV = ads112c14_internal_ref_uV[ADS112C14_REFERENCE_CFG_REF_VAL_1_25V];
+			break;
+		default:
+			vref_uV = ads112c14_internal_ref_uV[ADS112C14_REFERENCE_CFG_REF_VAL_2_5V];
+			break;
+		}
+
+		fsr_bits = data->chip_info->resolution_bits - measurement->bipolar;
+
+		ads112c14_populate_scale_available(measurement->scale_available,
+						   vref_uV, fsr_bits);
+	}
 
 	/* For now, assuming we are using 2.5V reference. */
 	vref_uV = ads112c14_internal_ref_uV[ADS112C14_REFERENCE_CFG_REF_VAL_2_5V];
 	fsr_bits = data->chip_info->resolution_bits - 1;
 
-	for (i = 0; i < ARRAY_SIZE(ads112c14_pga_gains_x10); i++) {
-		int *scale_avail = &data->sys_mon_chan_short_scale_available[i][0];
-		u32 gain_x10 = ads112c14_pga_gains_x10[i];
-
-		/* NB: slightly odd arrangement to avoid overflow. */
-		scale_avail[0] = div_u64_rem(div_u64((u64)NANO * 10 /
-						     (MICRO / MILLI) * vref_uV /
-						     gain_x10,
-						     BIT(fsr_bits)),
-					     NANO, &scale_avail[1]);
-	}
+	ads112c14_populate_scale_available(data->sys_mon_chan_short_scale_available,
+					   vref_uV, fsr_bits);
 }
 
 static int ads112c14_probe(struct i2c_client *client)
@@ -547,6 +876,9 @@ static int ads112c14_probe(struct i2c_client *client)
 	const struct ads112c14_chip_info *info;
 	struct iio_dev *indio_dev;
 	struct ads112c14_data *data;
+	bool need_avdd_ref, need_ext_ref;
+	u32 refp_uV = 0;
+	u32 refn_uV = 0;
 	u32 reg_val;
 	int ret;
 
@@ -560,13 +892,75 @@ static int ads112c14_probe(struct i2c_client *client)
 	data->chip_info = info;
 	data->client = client;
 
+	ret = ads112c14_parse_channels(indio_dev, &need_avdd_ref, &need_ext_ref);
+	if (ret)
+		return ret;
+
 	ret = devm_regulator_get_enable(&client->dev, "dvdd");
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to get dvdd regulator\n");
 
-	ret = devm_regulator_get_enable(&client->dev, "avdd");
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to get avdd regulator\n");
+	if (need_avdd_ref) {
+		ret = devm_regulator_get_enable_read_voltage(&client->dev, "avdd");
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to get avdd voltage\n");
+
+		data->avdd_uV = ret;
+	} else {
+		ret = devm_regulator_get_enable(&client->dev, "avdd");
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to get avdd regulator\n");
+	}
+
+	if (device_property_present(dev, "refp-supply")) {
+		ret = devm_regulator_get_enable_read_voltage(&client->dev, "refp");
+		if (ret)
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
+		data->refp_is_avdd = refp_fwnode == avdd_fwnode;
+	}
+
+	if (device_property_present(dev, "refn-supply")) {
+		ret = devm_regulator_get_enable_read_voltage(&client->dev, "refn");
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to get refn voltage\n");
+
+		refn_uV = ret;
+	} else {
+		data->refn_is_gnd = true;
+	}
+
+	data->ext_ref_uV = refp_uV - refn_uV;
+
+	if (device_property_present(dev, "refp-refn-resistor-ohms")) {
+		if (refp_uV != 0 || refn_uV != 0)
+			return dev_err_probe(dev, -EINVAL,
+					     "refp-refn-resistor-ohms property should not be present when refp-supply or refn-supply is present\n");
+
+		ret = device_property_read_u32(dev, "refp-refn-resistor-ohms",
+					       &data->ext_ref_ohms);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to read refp-refn-resistor-ohms property\n");
+	} else {
+		if (need_ext_ref && data->ext_ref_uV == 0)
+			return dev_err_probe(dev, -EINVAL,
+					     "external reference measurements require either refp-supply or refp-refn-resistor-ohms property\n");
+	}
 
 	data->regmap = devm_regmap_init_i2c(client, &ads112c14_regmap_config);
 	if (IS_ERR(data->regmap))
@@ -615,8 +1009,6 @@ static int ads112c14_probe(struct i2c_client *client)
 
 	indio_dev->name = info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = ads112c14_sys_mon_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ads112c14_sys_mon_channels);
 	indio_dev->info = &ads112c14_info;
 
 	return devm_iio_device_register(&client->dev, indio_dev);

-- 
2.43.0

