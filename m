Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4784446EE
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 22:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559883; cv=none; b=kYSZkFXvlvUkPNeXTkCthBLtloEURaTqPkUjTsc7PBb66HEH+/OB8bdJxVzWzSXHqieCztqUlvUef0cANCH8e7V8mI3LQxz//NrRiMO73SfN93kPxfWW9MLBvyI+ArwSoCx0JPIwguaTB2gXdToJMcDRV3AiZlcnTM5LoF4CJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559883; c=relaxed/simple;
	bh=Deeaer94Jcor75gpy0lfZKp/okGWx/opCeDuktVE8UE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HcD0fHIA4QY+kOkKSYEYllkos0+t7nWxC8aQgQDKyapEnsbmBo4Iu6mwBdyzCbT02F3x4tsjKY+KlByvThDXQvQaPvHwKNTLAOolE3zbZHUBqGfg/pYNzC44BfGeizjQWIt0O48qw7r7STrs3i8fJuUYes/A/Hoh6EyE0aW3glA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Mkgb7hR0; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Mkgb7hR0"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4a46a53abc9so1671197b6e.3
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 15:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788559878; x=1789164678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9HoM0Lsd38dzgIye43DGA6aABLqWH/nbPq1XRZEAe5E=;
        b=Mkgb7hR0v1OGhQmCiMzs9hEAtpgHYfnziMakyvMHpvyrzc9u+mh9pNXmPV0htOB/b1
         Fj2PnEGf5kfnEEgs6Fh7vkhosgpxloPa/PiaQ5o3N/uQYVo9smS6JDBDcnKI2WCC8MSl
         eUL3YrqbkxeClTKm1yeg0S5REXxBMlcZixVvDapru4PPlA/qONKZrQ5ykAKx63zUbd8L
         wDunw2zTZZKgh7SYnx2WXfjWfDJQNpgksjpnl0N00rDwgESMrxbDsmYP3OWBANxIKwLB
         Wazg50muZBPRVBeUeiRNbj6VLjaKZXSlg99B+Hmp82JKN3KkLxm8/m6Z5Tn+uxnlJ54i
         he/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788559878; x=1789164678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9HoM0Lsd38dzgIye43DGA6aABLqWH/nbPq1XRZEAe5E=;
        b=iJPHJjMiP6z0Ny9lXiTc6SavzDdZFQNt/Dizu7pSX3pgRTi6jRJZWm03F/OUneqY6E
         8q0KHHfU2efYbJ2OOTFmkzbATvm91NVEE6y8PX82RMpMnbuvCjP2psy1yTqrIPqLkJkl
         G7cw5L+aXFo4ipKy/3X0P7rj8cV5c+TxslAtLEKSBqrAfpAHnQ3b2N+nj0Y3kvNAUu9D
         phf9m3bOiSCIlW7xU41zpG2Ul/qRAHfO3xiA6NFMeYiFjyNpN2TCpYnTSGE39ObXbtl2
         fqWerkQCpJde33miQ3QlB7QalP8/ODexH8VYexu3zJRYFhKf7FBTAIc1oMq0SNoxzynj
         87xQ==
X-Forwarded-Encrypted: i=1; AKwUvBzppyctJ7ZjyB9i8xOY5Imc43fNPiZV3zNEgwCKitwyv2Y9U0i4q+mrF4BIiGbk4RlW19l6S9PQUOo=@vger.kernel.org
X-Gm-Message-State: AFuF++nt4uOkZXNxxzZ7lTz2sG9Mi8b/s5SRItCxdfc7XkXYd40Zz3p+
	2JcSCOxktoOXh4EOj7DATbYsLkhpIINbNf7276z0U3zpIp3/XXm7FIK7atOq1syucaU=
X-Gm-Gg: AYBFou1bDRfhXvpKIm22Mw3BPvRW0tCK0/7sQwk/qpPy2HYqr0eb6Cv5t52F2Ob6PwT
	aoDnVuMCP5IGKxYkVW5CZB4dLkSWu/Rq30xgOVL+VRmCxkSftfZlNMDkudMHppC5SHSjM01bL4Q
	2kveVDr2Qf7+SG2TAGAKsi0pqMBpdCDrZng0KYfAFKctoEmyTLgpWkRbRy0e3UThULS2cnN4HXP
	fpOeL7t28/6QJ0S706LPaGmb22h9xKcvtEBjr+XxI/QVdS2RGFmEZpfFoOooRfUSAxuAN0q2ryv
	p/jtLKA8v9zwebe9HL11rxssX5n6vDh/Cujbm1Qq3BiMbqLqCGDyg1El1GRiY3WS2bBh3Z09GAK
	HZE3axKy/k46it4ml3gn6OkEV752UUJ08AGlKOj2mNw1ENJs8TW8LratmZh9adKJYyQcjtfUPg2
	/BTAAxsArR3JBy9TMCiYzbIwSQ6xjtK2BXhy0GGl36y6er8TTQXJpeST3lICSdaYosmQ==
X-Received: by 2002:a05:6808:1450:b0:4b9:e5fa:8906 with SMTP id 5614622812f47-4b9e5fa8e2dmr3891282b6e.25.1788559878050;
        Fri, 04 Sep 2026 15:11:18 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4324:3ccf:e2bf:d545])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b970d1ff95sm3187113b6e.6.2026.09.04.15.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 15:11:17 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 04 Sep 2026 17:09:49 -0500
Subject: [PATCH v2 04/10] iio: adc: ti-ads112c14: add burnout current
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-iio-adc-ti-ads112c14-filter-support-v2-4-f86592360658@baylibre.com>
References: <20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com>
In-Reply-To: <20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8219; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Deeaer94Jcor75gpy0lfZKp/okGWx/opCeDuktVE8UE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqm0HLI/LcF2uFgi749qeP4XAV2xYp7pM+IL06m
 ltn56+eUyuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaptBywAKCRDCzCAB/wGP
 wNCXB/4kmgkZ2SJO9DpFYZJFLGhp5F1aWWkv/W80bs4CftaqCZePRqw6lv565QMYQ7IZN4z58n7
 FbKlDkJ+igL6/1kUhrSi8W/bP1ZTXOYKTvwbew9ow6wsUlInSnIzvaxidp7P9GiUdDch67taS+M
 x4eamqR5D/ZhA79lQTHIZB3zRNipSVK+yHabX27ufWbpUA+1BjW7KiyNMp0mtiEUx6J9C45u7bX
 r057J0D7dlNeCZuQvgEWIIwY/SPPclATdBxhXGVju9oU7rqvmqtl8YSzSCY8aaWKrrbBrJx3oh4
 aI/pNNcM+LuE+sUViOtXJlFCy04eknaVuCAFgNz3Ck0YDTAb
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
index 06b962fbde5e..c03789c3d95e 100644
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

