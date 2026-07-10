Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B332F40911B
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783723931; cv=none; b=SP8GkTmg/PPLJGRaFs1tdS4KNJGllq2pnfNNSqY0H+sZ+EgGsWiZt4oQGVDRqZIySaWhzPKVRmB9t8nmLVbBVncmg9LBX/UrpbTDmjlxyN2LF2e7B0edVAZ/6Tj9tc5cNmLuph6bLJN7Q4lo6pmqdTnADKygrBmmR97cypSH11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783723931; c=relaxed/simple;
	bh=CBbRKCnXS4T7QnBruEu2iDeFsOIZtuaFXHOjwjOJlSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gwL3lhuDXeZTQHZbUABjjrRkBEcOMnX+O/D80cWBb5TDwQlRHM7g58+I26HWOAcDuhTN3Kr2dnwSEO+k9l4Td+WN56vTiVVzcfqSR7CCJP0rWrVHSXjl2PbnDo6AW8gkKLUczrLtkhVGOi6PcXftqqdVP0uIA3PDSUPdfg2orc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=BPVlaAww; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="BPVlaAww"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb5a9f02e8so725272a34.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 15:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783723923; x=1784328723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zs/jvsFxiongXWFi1qj7asY1ESnkzgGH64+AXx4dTko=;
        b=BPVlaAwwogSdiXg4t8DQiDjk/S70HaWryXhcPfgPvq0LKNsAJT31iB7NcHq7IyfIYR
         fJj6L0Dq0dyYn+HxrL4AS8JMKkXhFWrkdFDTBYtqYv+yA4eqriQVNCulY2cgWx5gozRa
         Zb1/k5oHp3jpUuV5Yld0KLWeuJh3py0lQH8pduVqUJINTL0BzQKqURWpTQMWcIVXbabT
         QlUY15/hcq7uH2hLlfWDJ87s5tQms2sH8I3neOV6Hm1tZj9LEzVvgsjXDpuOCicp7kvq
         zqQXdRG9bH3mJwaTj1LbAoBKGFNhT2IBW5X44twXORJdwuUIhBy+H6uMyhx6WtOPo8/y
         tSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783723923; x=1784328723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zs/jvsFxiongXWFi1qj7asY1ESnkzgGH64+AXx4dTko=;
        b=dRdnThwxDWivBfSqWMa80z9hlexJ0ugJqPtUI/ZZjPqAP9B5m5JankC1JkZFZW8/7Y
         /ojRWAEIgwAiq+AirVlUiTtyUidAR/P4OwRbGA5y4XkUfyAR3LrZkg4eG1PeQE/4my/E
         CACe8t+03poKCyBXTSy2dbtPbUqHSxDDrmL80+GUDX6Obm1awVOh7YMgZPkhFrDF3wLF
         taQVGyg3kU8crEE8ICgJbbDj0Lc5KfN5oiH+gEZ3RBvwmC75GMgziwgVT5w/W7toDHva
         AAcM7pfpJj/HtSeCuFNWm5YqnsCMHIReQeG/FZhlsk+P+Aq1/HuQ+fmsbpCLQOp2lpPu
         8vPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+MtqAxP30SV4WvoJy2RYUIIHFbQ5PQIa3uR3W57OrMoXeRWq/UA1vWAz9y1d+DN6UlC/YklMDqdEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+1R/APA9X6w3xOffZIJjtgINFl/TTgMR0AxhMh8VIz131KvL3
	F2+2vnXAtqwLBiJivCtbReS9CrJw7cRGsENGVett9vB93QzLgMGdRwExB2oz0qPlFdo=
X-Gm-Gg: AfdE7ckHC6BjHNUDeOKcAyxbpf4Gfle4L6h+8JCeItFlfyQ55SinKa/gwfJSmv1iI8c
	6W5WEycrkpl/xFlVJsiqEbBZd8j3GGHss033hBmO3HN+E1LNxjqXr9LhA/8W6vPoSCAW2TqmiOw
	2BEFYeYp9yhAqdxxvwHTPtgYhQQyrHAy+oFgQuYDaIT+yt6emylxhobTTuJ1Irymg8j6QtTMjCp
	E2nd7IFdEpuE0llLc+3IQNAwe8vd62Ze1ecVE6Yvamhv7SHLoxP1So5GmH3qSVEngm5ifJY0XIp
	llJhno81/IANtcZTnTGOk/CjhsR+oVAOVcwku3CosO6zvbFm2MrDxS770w5v3w+AQsHHEj9UOv4
	+2qiCS1mLt/OR8oJ+4GgQuJS7rJ6Wc9RCUvD/TebDsRdkvtxVC8cGNBaU64P+wNNB7NcOoVJ/ET
	0qqGB+bcfq50vho7Dz
X-Received: by 2002:a05:6830:82f5:b0:7e6:f31c:47bd with SMTP id 46e09a7af769-7ec09617f33mr447039a34.3.1783723922528;
        Fri, 10 Jul 2026 15:52:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae177c5sm7613512a34.5.2026.07.10.15.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:52:02 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 17:50:41 -0500
Subject: [PATCH v3 8/8] iio: adc: ti-ads112c14: add measurement channel
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-iio-adc-ti-ads122c14-v3-8-746d52cbf1d0@baylibre.com>
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
In-Reply-To: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=25004;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=CBbRKCnXS4T7QnBruEu2iDeFsOIZtuaFXHOjwjOJlSU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqUXd5tnumH28MC5Djlr/Gfk9crqSOcm/9PKKkS
 ZnXkPwYX0WJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalF3eQAKCRDCzCAB/wGP
 wG1vCACbSk3u67zIq6eqsaOiBH1XmZu1US/XH3iAa7kI6rQejW17tYYacCy4liPo/nB3Yz0Ehge
 DP+M8vcw+lxbO7DtnN+E6V2T406m4mrk8pVTurrk3OXyxAfwtx/rNlYw+AqlS4EtAcjZytmndrA
 ldxDJ7ndrKMDuRlfgMKmgTVIEG0mHLzUbellpbn2X1xSLQljoFRU9lIe7Bv8PztV/WMDIf29J+A
 LiBjz9mRwN/Eh65ILe5MnouwxDJiZhqStYk2Tytk/cGoUG/OBH+F2V+I9i7ZCMWG7yJ70u7brJ8
 ckIFbN77q+tAAVt3Ds0N+dLPhBn2stzpXBYkoT3bzrKImm50
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
 drivers/iio/adc/ti-ads112c14.c | 551 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 533 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 2ce4411a0d86..a310abd69d8f 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -9,11 +9,14 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
+#include <linux/device/devres.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
@@ -61,6 +64,10 @@
 #define   ADS112C14_DEVICE_CFG_PWDN			BIT(7)
 #define   ADS112C14_DEVICE_CFG_STBY_MODE		BIT(6)
 #define   ADS112C14_DEVICE_CFG_BOCS			GENMASK(5, 4)
+#define     ADS112C14_DEVICE_CFG_BOCS_DISABLED		  0
+#define     ADS112C14_DEVICE_CFG_BOCS_200_nA		  1
+#define     ADS112C14_DEVICE_CFG_BOCS_1_uA		  2
+#define     ADS112C14_DEVICE_CFG_BOCS_10_uA		  3
 #define   ADS112C14_DEVICE_CFG_CLK_SEL			BIT(3)
 #define   ADS112C14_DEVICE_CFG_CONV_MODE		BIT(2)
 #define   ADS112C14_DEVICE_CFG_SPEED_MODE		GENMASK(1, 0)
@@ -73,6 +80,7 @@
 #define ADS112C14_REG_MUX_CFG				0x07
 #define   ADS112C14_MUX_CFG_AINP			GENMASK(7, 4)
 #define   ADS112C14_MUX_CFG_AINN			GENMASK(3, 0)
+#define     ADS112C14_MUX_CFG_AIN_GND			  8
 
 #define ADS112C14_REG_GAIN_CFG				0x08
 #define   ADS112C14_GAIN_CFG_SPARE			BIT(7)
@@ -126,6 +134,20 @@
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
@@ -200,9 +222,32 @@ static const struct iio_chan_spec ads112c14_sys_mon_channels[] = {
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
+	u8 burnout;
+	bool global_chop;
+	bool bipolar;
+	s64 scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)];
+};
+
 struct ads112c14_data {
 	const struct ads112c14_chip_info *chip_info;
 	struct regmap *regmap;
+	u32 avdd_uV;
+	u32 ext_ref_uV;
+	bool refp_is_avdd;
+	bool refn_is_gnd;
+	u32 ext_ref_ohms;
+	struct ads112c14_measurement *measurements;
+	u32 num_measurements;
 	u8 sys_mon_chan_short_gain_val;
 	s64 sys_mon_chan_short_scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)];
 };
@@ -257,12 +302,113 @@ static const struct regmap_config ads112c14_regmap_config = {
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
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DIGITAL_CFG,
+				 ADS112C14_DIGITAL_CFG_CODING,
+				 FIELD_PREP(ADS112C14_DIGITAL_CFG_CODING,
+					    measurement->bipolar ? 0 : 1));
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
@@ -318,8 +464,9 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 	int ret;
 
 	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
-		/* Not implemented yet. */
-		return -EINVAL;
+		ret = ads112c14_prepare_measurement_channel(data, chan);
+		if (ret)
+			return ret;
 	} else {
 		ret = ads112c14_prepare_sys_mon_channel(data, chan);
 		if (ret)
@@ -348,6 +495,7 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 			      int *val2, long mask)
 {
 	struct ads112c14_data *data = iio_priv(indio_dev);
+	struct ads112c14_measurement *measurement = NULL;
 	u32 vref_uV, fsr_bits;
 	s64 scale_avail;
 
@@ -355,8 +503,8 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 	vref_uV = ADS112C14_INT_REF1_mV * (MICRO / MILLI);
 
 	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
-		/* Not implemented yet. */
-		return -EINVAL;
+		measurement = &data->measurements[chan->scan_index];
+		fsr_bits = data->chip_info->resolution_bits - measurement->bipolar;
 	} else {
 		/* All SYS_MON channels are using signed coding. */
 		fsr_bits = data->chip_info->resolution_bits - 1;
@@ -386,7 +534,8 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 
-		*val = sign_extend32(*val, fsr_bits);
+		if (!measurement || measurement->bipolar)
+			*val = sign_extend32(*val, fsr_bits);
 
 		return IIO_VAL_INT;
 	}
@@ -398,6 +547,13 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_FRACTIONAL_LOG2;
 		}
 
+		if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
+			scale_avail = measurement->scale_available[measurement->gain_val];
+			iio_val_s64_decompose(scale_avail, val, val2);
+
+			return IIO_VAL_DECIMAL64_PICO;
+		}
+
 		if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
 			u8 idx = data->sys_mon_chan_short_gain_val;
 
@@ -436,14 +592,29 @@ static int ads112c14_read_avail(struct iio_dev *indio_dev,
 {
 	struct ads112c14_data *data = iio_priv(indio_dev);
 
-	if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
-		*vals = (const int *)data->sys_mon_chan_short_scale_available;
-		*length = 2 * ARRAY_SIZE(data->sys_mon_chan_short_scale_available);
-		*type = IIO_VAL_DECIMAL64_PICO;
-		return IIO_AVAIL_LIST;
-	}
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE) {
+			struct ads112c14_measurement *measurement;
+
+			measurement = &data->measurements[chan->scan_index];
+			*vals = (const int *)measurement->scale_available;
+			*length = 2 * ARRAY_SIZE(measurement->scale_available);
+			*type = IIO_VAL_DECIMAL64_PICO;
+			return IIO_AVAIL_LIST;
+		}
+
+		if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
+			*vals = (const int *)data->sys_mon_chan_short_scale_available;
+			*length = 2 * ARRAY_SIZE(data->sys_mon_chan_short_scale_available);
+			*type = IIO_VAL_DECIMAL64_PICO;
+			return IIO_AVAIL_LIST;
+		}
 
-	return -EINVAL;
+		return -EINVAL;
+	default:
+		return -EINVAL;
+	}
 }
 
 static int ads112c14_write_raw(struct iio_dev *indio_dev,
@@ -456,7 +627,13 @@ static int ads112c14_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE: {
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
@@ -496,8 +673,21 @@ static int ads112c14_write_raw_get_fmt(struct iio_dev *indio_dev,
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
@@ -530,6 +720,240 @@ static const struct iio_info ads112c14_info = {
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
+			if (pair[0] <= 100000 && (measurement->iadc_count == 1 || pair[1] <= 100000)) {
+				/*
+				 * If both values are 100uA or less, then we can
+				 * use IUNIT = 1uA for better precision.
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
+				 * Otherwise, IUINT is 10uA (flag set) and so
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
+		measurement->global_chop = fwnode_property_read_bool(child,
+								     "input-chopping");
+
+		if (fwnode_property_present(child, "burn-out-current-nanoamp")) {
+			u32 burnout_nA;
+
+			ret = fwnode_property_read_u32(child, "burn-out-current-nanoamp",
+						       &burnout_nA);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "failed to read burn-out-current-nanoamp property\n");
+
+			switch (burnout_nA) {
+			case 200:
+				measurement->burnout = ADS112C14_DEVICE_CFG_BOCS_200_nA;
+				break;
+			case 1000:
+				measurement->burnout = ADS112C14_DEVICE_CFG_BOCS_1_uA;
+				break;
+			case 10000:
+				measurement->burnout = ADS112C14_DEVICE_CFG_BOCS_10_uA;
+				break;
+			default:
+				return dev_err_probe(dev, -EINVAL,
+						     "invalid burn-out-current-nanoamp value\n");
+			}
+		}
+
+		measurement->bipolar = fwnode_property_read_bool(child, "bipolar");
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
 static void ads112c14_populate_scale_available(s64 *scale_avail, u32 full_scale,
 					       u32 fsr_bits)
 {
@@ -545,6 +969,33 @@ static void ads112c14_populate_tables(struct ads112c14_data *data)
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
@@ -559,6 +1010,9 @@ static int ads112c14_probe(struct i2c_client *client)
 	const struct ads112c14_chip_info *info;
 	struct iio_dev *indio_dev;
 	struct ads112c14_data *data;
+	bool need_avdd_ref, need_ext_ref;
+	u32 refp_uV = 0;
+	u32 refn_uV = 0;
 	u32 reg_val;
 	int ret;
 
@@ -573,13 +1027,76 @@ static int ads112c14_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	data->chip_info = info;
 
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
 
 	data->regmap = devm_regmap_init_i2c(client, &ads112c14_regmap_config);
 	if (IS_ERR(data->regmap))
@@ -640,8 +1157,6 @@ static int ads112c14_probe(struct i2c_client *client)
 
 	indio_dev->name = info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = ads112c14_sys_mon_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ads112c14_sys_mon_channels);
 	indio_dev->info = &ads112c14_info;
 
 	return devm_iio_device_register(dev, indio_dev);

-- 
2.43.0

