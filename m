Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4003C2794
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784926190; cv=none; b=hqLOCqszGxvqOsgupHi5LpwfI1Qb5GHoyGTom6PC+ctU3Yvr7mRyFNn3pJ3MWL4R5V01NXvBM168RmEnZysWerXcjmZehjigChUZw+vJ7NLVFugtKOBdM/MTKBKPJGE8f8N/szBqf/cKy0oB3sL+pSkbm1CuVj0aRlnhFlRNfkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784926190; c=relaxed/simple;
	bh=/O3EoqcRViUtGjq6/YlifFOgEK+K/0YpuReVe3laA4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aiH5XQFu8TuLCmeAQrq6YWlwVGZT/B9XghgsKu7VVEccqHJLJUv2g1gorJWw1ngd3oLAwofmfuB0xtkGyxd/b9HLVr1h2hB1UZeGyMohmrX4CitKqYqr+e79u//yIVaDrmMIE+vkp5HB5TonqVGwx59IOGt0+mflH4cCUXAjquw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Hz+khpob; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Hz+khpob"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6a116bd18ebso548668eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 13:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784926187; x=1785530987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m5r3pErIIW+Ya7EvJ/0/SpArmGfZ5YLMNfVN/ifqXDI=;
        b=Hz+khpob2uaWNGlylsu+9FDavN8A6fCcLxIa5+HPZ49R33p3FBt8hCML7kvHe9svwA
         9AdKlWX/nf6tbw9PbMd5vI401yzP/AmC3nqdsfIRbeAbMXjkXKOcDJ7ccxT+3z9Wxtj2
         85B/NkCw8AoyJ+WyyBPer8oX2eZob8yXGQOxfErvPj89DevLxGjLt3njjgeLddD8Faj8
         i9/K+67cXOc6+SNdHvT0rxWLccur8W3//t1jE9CqRCvoFAkezdbvI/JgKaH9v0ltLSNN
         PN/8FzMaC5ndWFgsdwWZjiIujBZ2QyRtV+eeJIGZKZIBmm8WFRgCkfQ1uxG8S6Lr45Qs
         XNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784926187; x=1785530987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m5r3pErIIW+Ya7EvJ/0/SpArmGfZ5YLMNfVN/ifqXDI=;
        b=j49ptyiLWF8sAespGbyaj0JcPq/S2qWO1z8pfWaNo0plRv1ekTtlzj+rpOiNICLdD2
         cABrS8UXpC9sQR71p1FjyjjjF/XwlldmYmhlOb17RztY/HLVIWNbaNzFIFzbffQdyOWa
         nh4RHyGmJaOHmKlbT8HQkSsk49/9SvWQH58sfsyG7rwhGOE09+aW9dpqIZ/0NW01Vhx7
         NtNupQOvYC5RJb5Anvojtdr0WbLAwOWRRwVO92AMeYaeZ0ekrC49FYquz0zKWePp5+Qf
         8g/K7ZaSfWQudNq+Yd7uC1TK++EQjQ8YPFi4sHaVqXBx/M32Uu2LIbn7nlLK6CK0mz8L
         tzSg==
X-Forwarded-Encrypted: i=1; AHgh+RrzVXDHH6T5lzYMwZQlmM8/vN31w1cJdrHIL5htgLSFegLvmrxCpMRXvzrPJ6gNUf9UKYFLPw7H2Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YypLMvM0wseHzPqulM5k3M65fuODOqdT5vy8MqU6/32eqjplKfp
	RT3Q9At5wJ9XZShG6zz+22jDcTHO3omABK9cbGu+eua5wfgo0As9XgGGC+VcanAxGrkNu674+OR
	RVOzN
X-Gm-Gg: AR+sD10Asqw00Mr+Tp6rV+EFGP7fas6OeaelDHM4dsNUERR66R3KKsDBnFEtC4TfvtD
	uxv0FA+WkYRQ68UHC32SwX6Wx8LbGXWv0OlKXk/wAIj+40Cy22j1YqBK4RJXsp0GSq+UMhjVstj
	6SEaRam4K2aVQHd90kh2mfCRgwXE0THeifzRNDGXyNRsz2P5B3dmQZDDSmDgHZgn79kMWbn2+Im
	A2dN+MNyfyxLpGUsXh/KrxEXSECUrXcOvb4Xc3YLNpEquMdc229cDNiT8s4nUAqoj0OJcvAIrIZ
	u24XkQ8A215xdHzq1xzguG5pBA+hcP6/j6wq57CFy114bJxlb/wQtVy+tglwq1mi/xBHBtR0xye
	PLOE+cXrrr/Jp1u9OeYkchEdsbUhoWLIMax/mtVZovmOO5+HJb4Z0dPG9mTPkoiZynpXpJSkqu0
	rLK4Batw==
X-Received: by 2002:a4a:e84b:0:b0:6a3:7761:b50d with SMTP id 006d021491bc7-6aad4172a88mr5668843eaf.55.1784926186945;
        Fri, 24 Jul 2026 13:49:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b635:d463:c98:cc75])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45766e66674sm7255201fac.3.2026.07.24.13.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 13:49:45 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 24 Jul 2026 15:49:17 -0500
Subject: [PATCH 1/2] iio: adc: ti-ads112c14: add burnout current support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-iio-adc-ti-ads112c14-burnout-v1-1-f0204cecbe3a@baylibre.com>
References: <20260724-iio-adc-ti-ads112c14-burnout-v1-0-f0204cecbe3a@baylibre.com>
In-Reply-To: <20260724-iio-adc-ti-ads112c14-burnout-v1-0-f0204cecbe3a@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8042; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=/O3EoqcRViUtGjq6/YlifFOgEK+K/0YpuReVe3laA4c=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqY8/XOWDlp56Ao1YvgihFXkVOYfQ6VZ6Dmemae
 ed9EE/96n+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamPP1wAKCRDCzCAB/wGP
 wGprB/4sHjSpLYkgrqjHM3CSfkW678O2/strrdrxn7ACeRLyZWrSaSgmviY/26x83zUowYqp7Sr
 CZjTEgcg7chSJumamrBlcHEVWyyPYDbFYHTUr3iG+Vo5m1WZH2PfpkgRZLH+jh7ojZiN9vyQbox
 SZgO5titsB2VRSwEC4DVgG+eHYnfmHZAQAXI7yyH8EFL3FFL/Oh9ThsP+7pY2/7DDwGjWIEbIuW
 S9Wb4AgqGKoUajosQZdpoTho9QOYKXDG2sNM7Mr2bKY5mfJsD1FWe0UHAgBhp/F0oNI3FcGc+4/
 kbEScY7i1wtRxTMGvxj6AeYx7aLTQdoZHUXm9Kz3IS2irXKy
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a custom attribute via ext_info when a channel has a burnout current
specified in the devicetree. This adds an in_{voltageY,resistanceY,
voltageY-voltageX}_burnoutraw sysfs attribute for the channel that
performs a single conversion (same as _raw attribute) except that it
enables the burnout current. The chip also has a restriction that input
chopping cannot be enabled when burnout current is enabled, so we also
disable input chopping when burnout current is active.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads112c14.c | 126 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 117 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index f3a2eba55362..0c79bfc0607a 100644
--- a/drivers/iio/adc/ti-ads112c14.c
+++ b/drivers/iio/adc/ti-ads112c14.c
@@ -76,6 +76,11 @@
 #define   ADS112C14_DEVICE_CFG_PWDN			BIT(7)
 #define   ADS112C14_DEVICE_CFG_STBY_MODE		BIT(6)
 #define   ADS112C14_DEVICE_CFG_BOCS			GENMASK(5, 4)
+#define     ADS112C14_DEVICE_CFG_BOCS_DISABLED		  0
+#define     ADS112C14_DEVICE_CFG_BOCS_200_nA		  1
+#define     ADS112C14_DEVICE_CFG_BOCS_1_uA		  2
+#define     ADS112C14_DEVICE_CFG_BOCS_10_uA		  3
+
 #define   ADS112C14_DEVICE_CFG_CLK_SEL			BIT(3)
 #define   ADS112C14_DEVICE_CFG_CONV_MODE		BIT(2)
 #define     ADS112C14_DEVICE_CFG_CONV_MODE_CONTINUOUS	  0
@@ -251,6 +256,7 @@ struct ads112c14_measurement {
 	u8 idac2_mux;
 	u8 iadc_count;
 	u8 gain_val;
+	u8 burnout;
 	bool global_chop;
 	bool bipolar;
 	int scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)][2];
@@ -474,7 +480,8 @@ static const struct regmap_config ads112c14_regmap_config = {
 };
 
 static int ads112c14_prepare_measurement_channel(struct ads112c14_data *data,
-						 const struct iio_chan_spec *chan)
+						 const struct iio_chan_spec *chan,
+						 bool en_burnout)
 {
 	struct ads112c14_measurement *measurement = &data->measurements[chan->scan_index];
 	u32 refp_buf_en, refn_buf_en, ref_val, ref_sel;
@@ -528,7 +535,7 @@ static int ads112c14_prepare_measurement_channel(struct ads112c14_data *data,
 	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DATA_RATE_CFG,
 				 ADS112C14_DATA_RATE_CFG_GC_EN,
 				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_GC_EN,
-					    measurement->global_chop));
+					    measurement->global_chop && !en_burnout));
 	if (ret)
 		return ret;
 
@@ -626,10 +633,11 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
 }
 
 static int ads112c14_prepare_channel(struct ads112c14_data *data,
-				     const struct iio_chan_spec *chan)
+				     const struct iio_chan_spec *chan,
+				     bool en_burnout)
 {
 	if (chan->channel < ADS112C14_SYS_MON_CHANNEL_BASE)
-		return ads112c14_prepare_measurement_channel(data, chan);
+		return ads112c14_prepare_measurement_channel(data, chan, en_burnout);
 
 	return ads112c14_prepare_sys_mon_channel(data, chan);
 }
@@ -653,7 +661,7 @@ static int ads112c14_scan_read(struct ads112c14_data *data, u8 *buf)
 
 static int ads112c14_single_conversion(struct ads112c14_data *data,
 				       const struct iio_chan_spec *chan,
-				       u8 *buf, bool for_scan)
+				       u8 *buf, bool en_burnout, bool for_scan)
 {
 	struct i2c_client *client = to_i2c_client(regmap_get_device(data->regmap));
 	u32 reg_val;
@@ -661,7 +669,7 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
 
 	guard(mutex)(&data->lock);
 
-	ret = ads112c14_prepare_channel(data, chan);
+	ret = ads112c14_prepare_channel(data, chan, en_burnout);
 	if (ret)
 		return ret;
 
@@ -736,7 +744,7 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 		if (IIO_DEV_ACQUIRE_FAILED(claim))
 			return -EBUSY;
 
-		ret = ads112c14_single_conversion(data, chan, buf, false);
+		ret = ads112c14_single_conversion(data, chan, buf, false, false);
 		if (ret)
 			return ret;
 
@@ -999,7 +1007,7 @@ static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
 
 		ret = ads112c14_single_conversion(data, chan,
 						  (u8 *)&data->scan[offset++],
-						  true);
+						  false, true);
 		if (ret) {
 			dev_err_once(indio_dev->dev.parent,
 				     "failed to read channel %d: %pe; additional errors will be suppressed\n",
@@ -1060,7 +1068,7 @@ static int ads112c14_buffer_postenable(struct iio_dev *indio_dev)
 
 	guard(mutex)(&data->lock);
 
-	ret = ads112c14_prepare_channel(data, chan);
+	ret = ads112c14_prepare_channel(data, chan, false);
 	if (ret)
 		return ret;
 
@@ -1109,6 +1117,78 @@ static const struct iio_buffer_setup_ops ads112c14_buffer_setup_ops = {
 	.validate_scan_mask = ads112c14_validate_scan_mask,
 };
 
+static ssize_t ads112c14_read_burnout_raw(struct iio_dev *indio_dev,
+					  uintptr_t private,
+					  struct iio_chan_spec const *chan,
+					  char *buf)
+{
+	struct ads112c14_data *data = iio_priv(indio_dev);
+	struct ads112c14_measurement *measurement;
+	int ret, ret2, val;
+	u8 raw_buf[3];
+
+	if (chan->channel >= ADS112C14_SYS_MON_CHANNEL_BASE)
+		return -EINVAL;
+
+	measurement = &data->measurements[chan->scan_index];
+
+	if (!measurement->burnout)
+		return -EINVAL;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
+				 ADS112C14_DEVICE_CFG_BOCS,
+				 FIELD_PREP(ADS112C14_DEVICE_CFG_BOCS,
+					    measurement->burnout));
+	if (ret)
+		return ret;
+
+	ret = ads112c14_single_conversion(data, chan, raw_buf, true, false);
+
+	/*
+	 * Important to always turn off burnout current even if the conversion
+	 * fails so that it does not affect subsequent measurements. This error
+	 * also takes precedence over the conversion error since the device may
+	 * be left in a bad state.
+	 */
+	ret2 = regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
+				  ADS112C14_DEVICE_CFG_BOCS,
+				  FIELD_PREP(ADS112C14_DEVICE_CFG_BOCS,
+					     ADS112C14_DEVICE_CFG_BOCS_DISABLED));
+	if (ret2)
+		return ret2;
+
+	if (ret < 0)
+		return ret;
+
+	switch (data->chip_info->resolution_bits) {
+	case 16:
+		val = get_unaligned_be16(raw_buf);
+		break;
+	case 24:
+		val = get_unaligned_be24(raw_buf);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (measurement->bipolar)
+		val = sign_extend32(val, data->chip_info->resolution_bits - 1);
+
+	return sysfs_emit(buf, "%d\n", val);
+}
+
+static const struct iio_chan_spec_ext_info ads112c14_ext_info_burnout[] = {
+	{
+		.name = "burnoutraw",
+		.read = ads112c14_read_burnout_raw,
+	},
+	{ }
+};
+
 static int ads112c14_populate_idac_mag(u32 current_nA, u8 *idac_mag)
 {
 	u32 current_uA = current_nA / (NANO / MICRO);
@@ -1277,6 +1357,34 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 		measurement->global_chop = fwnode_property_read_bool(child,
 								     "input-chopping");
 
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
+
+			if (measurement->burnout)
+				spec->ext_info = ads112c14_ext_info_burnout;
+		}
+
 		if (fwnode_property_present(child, "reference-sources")) {
 			ret = fwnode_property_match_property_string(child,
 				"reference-sources", ads112c14_vref_source_names,

-- 
2.43.0

