Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448AC42BE93
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074892; cv=none; b=Cs2EBtstutV1WE+1Nxv+Li9/DTOe2Xis+1D8XAHhiJ/zIW1yNdzGoV68LD4x9HZkXhRxFn91xDlyroD/CgP/VVyR+7aA0ElDflllA4qBuBpIN6/7MclLbpnnLk6Ay330Vjf3PJpTr+wMyRhLZOXXOL0Dptds50sy0Fi6/vH6lOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074892; c=relaxed/simple;
	bh=KU+4AV+kOnzd5jEsWKuPqEzXiklLnQiKMAGatDLd+aE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VIDZfxtbnCIyJigQ8WyZdoaU4+2s/vzc3aPNMRSHfZJaxpNMNPujjXoi+Zc8UL4kag9yxvXT23R3nYNeY58TiJjZZ0TkTYahHHN5oHCqDnwEmtZ5HYFJVavKpanfxRK7VJNRM2bcEG7jTuvZZ2LYC8b6WVbCB2sE5iA9l8pAaI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hn7LRkLq; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hn7LRkLq"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c13f35cc24so68997b6e.0
        for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 14:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789074876; x=1789679676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y6lYMnoAXwzmgp5VcdAbIKbPvgnPHfrFuyY1q4g3+vs=;
        b=hn7LRkLqV4Kha7XuVyTkws8e8ajy3Bi2cUR0lFRBI5NjVWck71Dyi4j79v6YQtJUGQ
         5G6jvTxsjb4KRC+ItVXKRFeCLryw8k3a58zuGnG3NUsmqV7F7JiqTSk+uvNSCuVwBs2F
         JoNwEXJrNxEZiqa56FWGJpwfUhZBpGnHsQCvUqVtwYLuvtNvH6OL4cpTepzreCF+TEY7
         V4peE0y7HMnCmEeBC1Z7R7Kx98Fnau0fBy4hlU1J7yLILQuSJJat52r+h4eOFTDgCmaE
         Q7A4QjXwwM3PPe1Y32/yEcby2J878pSzjuGl+4LLGsD39pxJW9/6mtmqhUqFmSJf5FN7
         9ZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074876; x=1789679676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y6lYMnoAXwzmgp5VcdAbIKbPvgnPHfrFuyY1q4g3+vs=;
        b=Bnk4uF7j8guvzOx3tPs1R7vSYR9xsGPxaQ8xnjREl1q1TWUIkbR6fQFZjf+/RHzv/5
         cGd2vo/oiyy3k0OIF4Ck1vWP62GfP/jxXjuIl4zSIbai/L0XJo1LTA2nlnXfTKoxKxLZ
         W4pe0m0noZuKEptAE10i8JD3TTJG9zsRfg6rtdd0EipiZclNCDWJZ74UHgqZzBeF88LI
         AUC3M+/V0HGZyVCEiZK4zci8GXrGgS9XVhJpTX2WNKD9JuYE5nH3guJ60FfdLW43mSkn
         mZl93sfSJpdiD9Jc6+bxfccHHCj17nz1CdkbIKzTdI6jSf1AclALhWmxrWxrEYqcPuwR
         iuZA==
X-Forwarded-Encrypted: i=1; AKwUvBy616KVX+kguuRMNdpoMRfy8M1FkTd+NCG7HLGhtxBtJhWQyrqy39zxwZwln9YExqfvfo0cGUYmlPk=@vger.kernel.org
X-Gm-Message-State: AFuF++lntuVfVLL0L/HsEOHI6CX6UXjafc/XX+u1gHNuTmLC0oPqX6QH
	SUeSZINByuZ3f1SoEUs/IjzT5xW0pWuXrV7gsI7ZvGO0WpNh43OSUBoFebqpBFqHtnM=
X-Gm-Gg: AYBFou2vtOuYgFQS6P+Y0uzKOrinalQi4TXEayaJrZgc/oEgGOaV+Nte+g3nB+gKlky
	1mXgHJrSbOM5Ugljn0j7XbSKTCKJcvg98B08oETLF+o+BekI7xHFkuDx+GHcYkP+5OUMoJNmGY+
	NRNZATgFf0/ghYPNamD1xLA9GgBpCv1px3YHgCJXkbD3M5rla84TA1fElbFcf7iZ+veuAllZTvp
	nTPe24P74d41MO+5MkJoZR4QrNslhF1/clS0J4k4Dl4cmV4rjBsxb0jlZqE/+LN3JQ7qlHEBAm6
	45JwaLqXsPQ3oeSQLj0Xnf3GFo6uUk7eDqc70a0Bmm1EZIPxo1irKchjzhzplB+Aglqjha0A3u2
	R6fykwlk1jXP7ScJ5B97DCoAhsXOxIBG7jPs4KGsPS/vXoJz3ISBse9nLN2NBR0/6h94dUCFtr9
	7tFmjn7WpYSzkgosbd1+X7D4c0YbBwu0fZJx4vWWt5+0jjLjIQFrQTi5j3rCYan+xglWep5+7eZ
	VDj
X-Received: by 2002:a05:6808:1450:b0:4b8:46e3:e224 with SMTP id 5614622812f47-4c3087a6c89mr653693b6e.16.1789074875829;
        Thu, 10 Sep 2026 14:14:35 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fbf1:d0da:69e0:11a0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c330daa42esm347315b6e.4.2026.09.10.14.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 14:14:35 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Thu, 10 Sep 2026 16:13:03 -0500
Subject: [PATCH v3 04/10] iio: adc: ti-ads112c14: add burnout current
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-iio-adc-ti-ads112c14-filter-support-v3-4-e5a9b27ddb1a@baylibre.com>
References: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
In-Reply-To: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8219; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=KU+4AV+kOnzd5jEsWKuPqEzXiklLnQiKMAGatDLd+aE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqox2GIPeBzEgCBZBs9wKq2h1JkAQwnOQAZCm8T
 o1EhSE+Ju2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaqMdhgAKCRDCzCAB/wGP
 wBWdCACLUs10qRIsxUSKVSKMw23ml0dDS6NDxbGIz7DnfS7xMKx9NjBQPiSjgKWCgzzDs3rLB9Z
 Rc6CGEgwZCXa5S/WntKFnLkudrGVBtWB/wO1eiEd2UazGMTKNUnAuf9H2YucTXYAQOjk7HL9G8S
 ALA+6ww4jB9k+BeMe/PxMiT8SHLSD3XvpI6qg1QlrvfKjycutxPJUDODuCFoz9VEp437CC8j4/u
 lvgi/W0LJ/jrC88FCpb57Pg4/bfKB+PWRolF7Q2GbdhRl4BRcwVo2bGlcpmjZc3zvpHA0phGUy2
 yLekPt95ku5nJQGenAbwFeUnQRfyzRPpBeHqx3EcmCEHejgJ
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
 drivers/iio/adc/ti-ads112c14.c | 125 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 116 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
index 09807ea4fb18..efea1e22d067 100644
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
@@ -461,7 +467,8 @@ static const struct regmap_config ads112c14_regmap_config = {
 };
 
 static int ads112c14_prepare_measurement_channel(struct ads112c14_data *data,
-						 const struct iio_chan_spec *chan)
+						 const struct iio_chan_spec *chan,
+						 bool en_burnout)
 {
 	struct ads112c14_measurement *measurement = &data->measurements[chan->scan_index];
 	u32 refp_buf_en, refn_buf_en, ref_val, ref_sel;
@@ -515,7 +522,8 @@ static int ads112c14_prepare_measurement_channel(struct ads112c14_data *data,
 	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DATA_RATE_CFG,
 				 ADS112C14_DATA_RATE_CFG_GC_EN,
 				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_GC_EN,
-					    measurement->global_chop));
+					    (measurement->global_chop &&
+					     !en_burnout) ? 1 : 0));
 	if (ret)
 		return ret;
 
@@ -613,10 +621,11 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
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
@@ -674,14 +683,14 @@ static int ads112c14_wait_for_conversion_poll(struct ads112c14_data *data)
 
 static int ads112c14_single_conversion(struct ads112c14_data *data,
 				       const struct iio_chan_spec *chan,
-				       u8 *buf, bool for_scan)
+				       u8 *buf, bool en_burnout, bool for_scan)
 {
 	struct i2c_client *client = to_i2c_client(regmap_get_device(data->regmap));
 	int ret;
 
 	guard(mutex)(&data->lock);
 
-	ret = ads112c14_prepare_channel(data, chan);
+	ret = ads112c14_prepare_channel(data, chan, en_burnout);
 	if (ret)
 		return ret;
 
@@ -742,7 +751,7 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 		if (IIO_DEV_ACQUIRE_FAILED(claim))
 			return -EBUSY;
 
-		ret = ads112c14_single_conversion(data, chan, buf, false);
+		ret = ads112c14_single_conversion(data, chan, buf, false, false);
 		if (ret)
 			return ret;
 
@@ -1030,7 +1039,7 @@ static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
 
 		ret = ads112c14_single_conversion(data, chan,
 						  (u8 *)&data->scan[offset++],
-						  true);
+						  false, true);
 		if (ret) {
 			dev_err_once(indio_dev->dev.parent,
 				     "failed to read channel %d: %pe; additional errors will be suppressed\n",
@@ -1072,7 +1081,7 @@ static int ads112c14_buffer_postenable(struct iio_dev *indio_dev)
 
 	guard(mutex)(&data->lock);
 
-	ret = ads112c14_prepare_channel(data, chan);
+	ret = ads112c14_prepare_channel(data, chan, false);
 	if (ret)
 		return ret;
 
@@ -1127,6 +1136,74 @@ static const struct iio_buffer_setup_ops ads112c14_buffer_setup_ops = {
 	.predisable = ads112c14_buffer_predisable,
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
+	 * fails so that it does not affect subsequent measurements.
+	 */
+	ret2 = regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
+				  ADS112C14_DEVICE_CFG_BOCS,
+				  FIELD_PREP(ADS112C14_DEVICE_CFG_BOCS,
+					     ADS112C14_DEVICE_CFG_BOCS_DISABLED));
+	if (ret < 0)
+		return ret;
+	if (ret2)
+		return ret2;
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
@@ -1172,6 +1249,7 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 	device_for_each_named_child_node_scoped(dev, child, "channel") {
 		struct ads112c14_measurement *measurement = &data->measurements[i];
 		struct iio_chan_spec *spec = &channels[i];
+		const char *propname;
 
 		spec->indexed = 1;
 		spec->scan_index = i;
@@ -1295,6 +1373,35 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
 		measurement->global_chop = fwnode_property_read_bool(child,
 								     "input-chopping");
 
+		propname = "burn-out-current-nanoamp";
+		if (fwnode_property_present(child, propname)) {
+			u32 burnout_nA;
+
+			ret = fwnode_property_read_u32(child, propname, &burnout_nA);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "failed to read %s property\n",
+						     propname);
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
+						     "invalid %s value\n", propname);
+			}
+
+			if (measurement->burnout != ADS112C14_DEVICE_CFG_BOCS_DISABLED)
+				spec->ext_info = ads112c14_ext_info_burnout;
+		}
+
 		if (fwnode_property_present(child, "reference-sources")) {
 			ret = fwnode_property_match_property_string(child,
 				"reference-sources", ads112c14_vref_source_names,

-- 
2.43.0

