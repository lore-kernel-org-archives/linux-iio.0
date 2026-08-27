Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118337F727
	for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 22:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787869661; cv=none; b=TViu9r11wH5NHhTUROmRHhPneLgJoLDpVVpFlnQv+dGQde+0HlCWwadPSm1GZQxb0whItLtGCkjeJxiBVwmR9mPl8gIjVe0z1/3rti4gDLkcLWv0hrRIv5TOT8BpHndO/dzVwDySXQ9GEO9Ri2NuVIS/OyiEmGmGVDL8H9vSA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787869661; c=relaxed/simple;
	bh=7Uhs0MSax/2UW6OR59jpn2lW4CIqxOIeFaZDQkF77p8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NksTtkPOxIiqjtYYLUhwDq9CLyG6WCdg1cMJgEEfJl7L4JwrxvGafx4f4Rby3b/XEKxCaCD30DFSIhp6tlnmveoL7eq2g9xBkYjx7B9WEd1rvv7uLm9DTC3VVQyWknT8GC5h1KWObti+gRZ6PxjAfic+Rif3nD/tdphDzSZVXUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=S/zAlQKq; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="S/zAlQKq"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-45837e52d8aso567947fac.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 15:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787869650; x=1788474450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=htYJi+oyLOV36C7aJQ/sDgWgRKF7nb1wEToOz4+J7JA=;
        b=S/zAlQKqvMFogmHFVyg4hk72syGdhu9l2CxyggPCyytW6rQFrZD+WMdmf1h08hNIj7
         nwEFuwQ3JOzfGcbAGjX1Rin5+xQyQHgLgnGvWQaS+KMM6gCpuGtlFo4W9xZQwX3fnFTu
         iAHZXjFvVtzKL8hBxquAjytnnWHqo/YkjCmepji5uetVEeR+VVsFSixxaPksUYwM6HXP
         KOkdERKfhmZPxzc9KHtd4zZNmFaaSsfeyNP0Sl9Mg0ynm+PL3bHhFxJZJ0QlthBSIseU
         ZlQ9P4L7eOVMNW0kBzL8TIYHZYXuPWF86VV7FiD+5dtv0ooja2LC53xqR9vRSuAXkPaZ
         XHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787869650; x=1788474450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=htYJi+oyLOV36C7aJQ/sDgWgRKF7nb1wEToOz4+J7JA=;
        b=Vq0MtMg0DcEpVu2ZSSQsy1jaL2aQ69JJ7tFxo4uBagjx8Nkf5XyJAiYm0SLgXVq/d0
         xx1sbcKlOa3ZqP6LE8AvzPLec1NlvO2qwDFm+1xuFUZX3DzLRafQJ/YizdM7PKEZD77/
         1mQz+atd23N4IHk3ORJo+XStEoe4MpiScp5mB1K9Oa2QaVSu4xXXIPc4ixmOAL909Pyh
         rRyTQV4LKKOiX4L7cl0bZxUwmyHvbTWtnqtCLqfPJa/R42dAopBFLEzqFKXIuPgAi03Q
         3CCOrzaSMQoDi9uN+vd20Hi74eIbiFpi48rN6rdAYGib8+bg1/C2Jqmfjd0nVYElC4Rd
         x4KQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq6bmtIAQicf7hP0QBfPsJ+O+fNWkcCt8kIqK+QltgGeSXZAGVrsos+wtji8MmsrF0Ffev0tNx3HAQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kS+qwIfdb2UhDrUsT35qx/qZqkfq8/pXDJDWXsSOIgClf/lWjd
	M0fyLwmknN8/uqsgle6fGl+AYqzHV9t1G3ej96EgGiPOl/oPm/K7WDWFAv7U21jlwkU=
X-Gm-Gg: AR+sD11iTDZI96bM5S1U2GsWcao5A2unK5gbUTJ4iLIiB57uK0Wdan+PsI380z3KdrY
	5f0I4zzxHmG1PCzaKqjUpzq7Bk42d60GMYWXXtXAFCmCVavOEzqXgKBOZziSPmyYENKKWdrvFoN
	lUFTflyZEpoIxfNyLWomf/qmfnVzrjrN+24OQvSF31bQwcdV2cUM5jgKKnVBn74BAWkD+796uSf
	Hm4PGnk3i5kK9gMhYXci2sjxlENyYjxDI7VxQ7X1U/wlHpMzkebuGUtBxJGMef/HglRuNPcoc7f
	e97BKbSLlZ4XGFtNSKwko7sqoowWqPFFVdojui8i6pKiMJXQuwz1d9gCTrqy91uiKEXx9OJHWzr
	Gz3ByDvoMVk3BFNts40NI36gOXnZ8HxN+yV9QFUALrH7pCoO0qD4ViRZjmEKFS0F91TTcTSCk/o
	DofnvID2mAs+DmhFZJtcUVnURiS5QM9+XL0o1/Roj5gNTmd2l4pCjJexl+cS9Vy8l1Yg==
X-Received: by 2002:a05:6871:e498:b0:466:ad49:d0f6 with SMTP id 586e51a60fabf-468360af5a5mr3894415fac.7.1787869650010;
        Thu, 27 Aug 2026 15:27:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d288:6f77:e285:6925])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46736444b99sm3336392fac.3.2026.08.27.15.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 15:27:28 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Thu, 27 Aug 2026 17:27:02 -0500
Subject: [PATCH v2 1/2] iio: adc: ti-ads112c14: add burnout current support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-iio-adc-ti-ads112c14-burnout-v2-1-00a1fab9e2d1@baylibre.com>
References: <20260827-iio-adc-ti-ads112c14-burnout-v2-0-00a1fab9e2d1@baylibre.com>
In-Reply-To: <20260827-iio-adc-ti-ads112c14-burnout-v2-0-00a1fab9e2d1@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7958; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=7Uhs0MSax/2UW6OR59jpn2lW4CIqxOIeFaZDQkF77p8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqkLm/W0dTqEEAP0+KSrDGou6SX8B7405Mn2/+Z
 bsksv8egdeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapC5vwAKCRDCzCAB/wGP
 wEHAB/9wPfeBzvdN4DKM7L1ReOGn7gZUjWxSGKSv78t6QkVem1ntuAdkn4coLi/+8jPBT98Oi7H
 1aCpjEzsH2pQlGsLMRIrJ7+g0X4upf4u3LoKaU+wfwgFzpcHw2sEGp+xoS99h8m4y6g0ZKCNfGa
 4H3Z+Ypy9blTBot9ywFAN2KWry0x72XRFvXTA15vjealw63Wxc65la4Dy6HdIfBJDPk1tlygxYC
 sgIU7mndZUeeAfsIUuhYTA4sOdGvwkWrg0xcVfrZ0ziAXDmUiRDyemyrSbNbBBrFWquJ2ZRMSl0
 NxVx2FqbxsPvv1IGd7RFnM9OpsLGwkUZcqgjov326Mle9+G6
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
index 878764deffc5..58c815f5faeb 100644
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
@@ -460,7 +466,8 @@ static const struct regmap_config ads112c14_regmap_config = {
 };
 
 static int ads112c14_prepare_measurement_channel(struct ads112c14_data *data,
-						 const struct iio_chan_spec *chan)
+						 const struct iio_chan_spec *chan,
+						 bool en_burnout)
 {
 	struct ads112c14_measurement *measurement = &data->measurements[chan->scan_index];
 	u32 refp_buf_en, refn_buf_en, ref_val, ref_sel;
@@ -514,7 +521,7 @@ static int ads112c14_prepare_measurement_channel(struct ads112c14_data *data,
 	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DATA_RATE_CFG,
 				 ADS112C14_DATA_RATE_CFG_GC_EN,
 				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_GC_EN,
-					    measurement->global_chop));
+					    measurement->global_chop && !en_burnout));
 	if (ret)
 		return ret;
 
@@ -612,10 +619,11 @@ static int ads112c14_prepare_sys_mon_channel(struct ads112c14_data *data,
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
@@ -673,14 +681,14 @@ static int ads112c14_wait_for_conversion_poll(struct ads112c14_data *data)
 
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
 
@@ -734,7 +742,7 @@ static int ads112c14_read_raw(struct iio_dev *indio_dev,
 		if (IIO_DEV_ACQUIRE_FAILED(claim))
 			return -EBUSY;
 
-		ret = ads112c14_single_conversion(data, chan, buf, false);
+		ret = ads112c14_single_conversion(data, chan, buf, false, false);
 		if (ret)
 			return ret;
 
@@ -1009,7 +1017,7 @@ static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
 
 		ret = ads112c14_single_conversion(data, chan,
 						  (u8 *)&data->scan[offset++],
-						  true);
+						  false, true);
 		if (ret) {
 			dev_err_once(indio_dev->dev.parent,
 				     "failed to read channel %d: %pe; additional errors will be suppressed\n",
@@ -1066,7 +1074,7 @@ static int ads112c14_buffer_postenable(struct iio_dev *indio_dev)
 
 	guard(mutex)(&data->lock);
 
-	ret = ads112c14_prepare_channel(data, chan);
+	ret = ads112c14_prepare_channel(data, chan, false);
 	if (ret)
 		return ret;
 
@@ -1117,6 +1125,78 @@ static const struct iio_buffer_setup_ops ads112c14_buffer_setup_ops = {
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
@@ -1285,6 +1365,34 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
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

