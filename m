Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F0930C60D;
	Mon,  2 Mar 2026 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454134; cv=none; b=MMypg6ngODtkk2d5ZJ8aR/panX0oWJVCFA3RNEHZ6+vlcq+Tn/6mIWdUlfIj1R/KjUgpH8pQGmiQRhUW4JdHEOjwA0aFiRcuniyMsbX/NKFNcK3VxACNMxL2bh1Zwuk8XXgsEP7XqbhUlpvYZujouLELJwKPqh8uyMtW9IQT79Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454134; c=relaxed/simple;
	bh=vX8bM+O1v1bzQ1v6azHW9CfqC+D5J9cgooLMb2ZvNSg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKC4bADaBdPunvHa+dy6klcAoJz3WaSdJi4CHs3UXoY1hUl4OTAwK+LeGmL8AextyMRyNhm71Zy8rgeUwky+hRj+iye4hRHP8pZhxfpKEmK4e19yvDxECUt/LfSNSBRnYltuVFzEwqCKkpdhz3b1nkL8rZgIw4+r4hT1xCufnws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uhwcyWg/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uhwcyWg/"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6228219C1389564;
	Mon, 2 Mar 2026 07:21:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5+z0P
	EV0JhCIDUGtphafoyZDUTUmx7kp3q3YQiIot7w=; b=uhwcyWg/5MUg7+rqaC7UB
	Alkz7h7zn0UnLeUNM+eC0fRgW0Rx1JWVKoR2wm1yj9wS4v81YKrINDw7HIusdb3W
	V4MZH8ySPRGS/1uHJdFOvkjPhZ/Z60Ln9UAh5PrKG814oBtwv4+ui6T+82YiM0fF
	hjk1K++wi3cguccMbVTdwiCcH/UoDnEJxDCkjnBCkws7nTxfBb7dzsUonWAZ29u7
	kad2jsCHUv1vi7U9soFiX8zcOU6mujMKKi+3yKd5p5FSpX9GGzV2a7I5MoWfXWWR
	kUsi1EJkkxiQpCpeTRknXTTHeQlcNA22CFFRb1GGfzEiQHrDEqFwlCuXw3er6yt5
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cku33xw4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 07:21:48 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 622CLlTG002141
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Mar 2026 07:21:47 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Mar 2026 07:21:47 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Mar 2026 07:21:46 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Mar 2026 07:21:46 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.225.130])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 622CLQqZ010564;
	Mon, 2 Mar 2026 07:21:38 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Petre Rodan <petre.rodan@subdimension.ro>,
        Jorge Marques <jorge.marques@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] iio: accel: adxl372: introduce chip_info structure
Date: Mon, 2 Mar 2026 14:20:57 +0200
Message-ID: <20260302122116.1282-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302122116.1282-1-antoniu.miclaus@analog.com>
References: <20260302122116.1282-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: BugsD4NSncdE3zudndrrM4W32knxAvy3
X-Authority-Analysis: v=2.4 cv=DeUaa/tW c=1 sm=1 tr=0 ts=69a580dc cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=Qw_mE6-eBWplbBqItqEA:9
 a=FHz5paCR_PjzkVn5qDnB:22
X-Proofpoint-GUID: BugsD4NSncdE3zudndrrM4W32knxAvy3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEwMyBTYWx0ZWRfXxdz3BLmBsm8F
 QDDj5TdHI77G2/bRiItpOpNZzMpAN+Tz45npS0EniGyCMBF16XfLkj8H5Czwi1N1t+FtouZCCTS
 CSmkcoETAXpP5oyxjzmajfb1E8tzh8W0YrHAxpky9EfFIiJgHNGYSkE3RqSGj3Y/edYfcMl7mej
 aAjPZ1U5RL80MwkwJkt8u2gwvJYSrno+uTaUkP/W4gGDr9M4VeCjQHfh0GheD/mKUvYFjooSbzk
 hhytLvI+w1fMi+mgQIIOWKboYeoNX5U2N3OBgaf7BgoNBKQQNYa5Jarzo7vQaxtqMfugFtRmsiS
 IL0Je0x2ObwTwaRZEQa5+JDaCPzkWJeIjiNGtMJ0Ad0DSknreF2KHxXO3/7tBXPwMSLlYY9Gh67
 DcSZOw3qFoWLsHBFOtpCA6FnGtZiYEfr/I+U4yLHbG6dlTkOPnSWb9knZ2BW/cH1IDgG2NpueTg
 vT91g03hWp9x7eREH3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020103

Introduce a chip_info structure to parameterize device-specific
properties such as ODR/bandwidth frequency tables, activity/inactivity
timer scale factors, and the maximum ODR value. This refactors the
driver to use chip_info lookups instead of hardcoded values, preparing
the driver to support multiple device variants.

The sampling_frequency_available sysfs attribute is changed from a
static const string to a dynamic callback that reads from chip_info,
and the SPI/I2C probe functions are updated to pass a chip_info
pointer instead of a device name string.

No functional change intended.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/accel/adxl372.c     | 94 ++++++++++++++++++++++-----------
 drivers/iio/accel/adxl372.h     | 16 +++++-
 drivers/iio/accel/adxl372_i2c.c | 12 +++--
 drivers/iio/accel/adxl372_spi.c | 12 +++--
 4 files changed, 93 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 28a8793a53b6..d1f957adea64 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -222,6 +222,19 @@ static const int adxl372_bw_freq_tbl[5] = {
 	200, 400, 800, 1600, 3200,
 };
 
+const struct adxl372_chip_info adxl372_chip_info = {
+	.name = "adxl372",
+	.samp_freq_tbl = adxl372_samp_freq_tbl,
+	.bw_freq_tbl = adxl372_bw_freq_tbl,
+	.num_freqs = ARRAY_SIZE(adxl372_samp_freq_tbl),
+	.act_time_scale_us = 3300,
+	.act_time_scale_low_us = 6600,
+	.inact_time_scale_ms = 13,
+	.inact_time_scale_low_ms = 26,
+	.max_odr = ADXL372_ODR_6400HZ,
+};
+EXPORT_SYMBOL_NS_GPL(adxl372_chip_info, "IIO_ADXL372");
+
 struct adxl372_axis_lookup {
 	unsigned int bits;
 	enum adxl372_fifo_format fifo_format;
@@ -279,6 +292,7 @@ static const struct iio_chan_spec adxl372_channels[] = {
 };
 
 struct adxl372_state {
+	const struct adxl372_chip_info	*chip_info;
 	int				irq;
 	struct device			*dev;
 	struct regmap			*regmap;
@@ -471,13 +485,14 @@ static int adxl372_set_activity_time_ms(struct adxl372_state *st,
 	int ret;
 
 	/*
-	 * 3.3 ms per code is the scale factor of the TIME_ACT register for
-	 * ODR = 6400 Hz. It is 6.6 ms per code for ODR = 3200 Hz and below.
+	 * The scale factor of the TIME_ACT register depends on the ODR.
+	 * A higher scale factor is used at the maximum ODR and a lower
+	 * one at all other rates.
 	 */
-	if (st->odr == ADXL372_ODR_6400HZ)
-		scale_factor = 3300;
+	if (st->odr == st->chip_info->max_odr)
+		scale_factor = st->chip_info->act_time_scale_us;
 	else
-		scale_factor = 6600;
+		scale_factor = st->chip_info->act_time_scale_low_us;
 
 	reg_val = DIV_ROUND_CLOSEST(act_time_ms * 1000, scale_factor);
 
@@ -501,13 +516,14 @@ static int adxl372_set_inactivity_time_ms(struct adxl372_state *st,
 	int ret;
 
 	/*
-	 * 13 ms per code is the scale factor of the TIME_INACT register for
-	 * ODR = 6400 Hz. It is 26 ms per code for ODR = 3200 Hz and below.
+	 * The scale factor of the TIME_INACT register depends on the ODR.
+	 * A higher scale factor is used at the maximum ODR and a lower
+	 * one at all other rates.
 	 */
-	if (st->odr == ADXL372_ODR_6400HZ)
-		scale_factor = 13;
+	if (st->odr == st->chip_info->max_odr)
+		scale_factor = st->chip_info->inact_time_scale_ms;
 	else
-		scale_factor = 26;
+		scale_factor = st->chip_info->inact_time_scale_low_ms;
 
 	res = DIV_ROUND_CLOSEST(inact_time_ms, scale_factor);
 	reg_val_h = (res >> 8) & 0xFF;
@@ -717,7 +733,7 @@ static int adxl372_setup(struct adxl372_state *st)
 	if (ret < 0)
 		return ret;
 
-	ret = adxl372_set_odr(st, ADXL372_ODR_6400HZ);
+	ret = adxl372_set_odr(st, st->chip_info->max_odr);
 	if (ret < 0)
 		return ret;
 
@@ -777,10 +793,10 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 		*val2 = ADXL372_USCALE;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = adxl372_samp_freq_tbl[st->odr];
+		*val = st->chip_info->samp_freq_tbl[st->odr];
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		*val = adxl372_bw_freq_tbl[st->bw];
+		*val = st->chip_info->bw_freq_tbl[st->bw];
 		return IIO_VAL_INT;
 	}
 
@@ -796,23 +812,17 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		odr_index = adxl372_find_closest_match(adxl372_samp_freq_tbl,
-					ARRAY_SIZE(adxl372_samp_freq_tbl),
-					val);
+		odr_index = adxl372_find_closest_match(st->chip_info->samp_freq_tbl,
+						       st->chip_info->num_freqs,
+						       val);
 		ret = adxl372_set_odr(st, odr_index);
 		if (ret < 0)
 			return ret;
-		/*
-		 * The timer period depends on the ODR selected.
-		 * At 3200 Hz and below, it is 6.6 ms; at 6400 Hz, it is 3.3 ms
-		 */
+		/* Recalculate activity time as the timer period depends on ODR */
 		ret = adxl372_set_activity_time_ms(st, st->act_time_ms);
 		if (ret < 0)
 			return ret;
-		/*
-		 * The timer period depends on the ODR selected.
-		 * At 3200 Hz and below, it is 26 ms; at 6400 Hz, it is 13 ms
-		 */
+		/* Recalculate inactivity time as the timer period depends on ODR */
 		ret = adxl372_set_inactivity_time_ms(st, st->inact_time_ms);
 		if (ret < 0)
 			return ret;
@@ -825,9 +835,9 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
 
 		return ret;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		bw_index = adxl372_find_closest_match(adxl372_bw_freq_tbl,
-					ARRAY_SIZE(adxl372_bw_freq_tbl),
-					val);
+		bw_index = adxl372_find_closest_match(st->chip_info->bw_freq_tbl,
+						      st->chip_info->num_freqs,
+						      val);
 		return adxl372_set_bandwidth(st, bw_index);
 	default:
 		return -EINVAL;
@@ -968,7 +978,7 @@ static ssize_t adxl372_show_filter_freq_avail(struct device *dev,
 
 	for (i = 0; i <= st->odr; i++)
 		len += scnprintf(buf + len, PAGE_SIZE - len,
-				 "%d ", adxl372_bw_freq_tbl[i]);
+				 "%d ", st->chip_info->bw_freq_tbl[i]);
 
 	buf[len - 1] = '\n';
 
@@ -1142,12 +1152,31 @@ static const struct iio_trigger_ops adxl372_peak_data_trigger_ops = {
 	.set_trigger_state = adxl372_peak_dready_trig_set_state,
 };
 
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
+static ssize_t adxl372_show_samp_freq_avail(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int i;
+	size_t len = 0;
+
+	for (i = 0; i < st->chip_info->num_freqs; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len,
+				 "%d ", st->chip_info->samp_freq_tbl[i]);
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(sampling_frequency_available,
+		       0444, adxl372_show_samp_freq_avail, NULL, 0);
 static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
 		       0444, adxl372_show_filter_freq_avail, NULL, 0);
 
 static struct attribute *adxl372_attributes[] = {
-	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	NULL,
 };
@@ -1176,7 +1205,7 @@ bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg)
 EXPORT_SYMBOL_NS_GPL(adxl372_readable_noinc_reg, "IIO_ADXL372");
 
 int adxl372_probe(struct device *dev, struct regmap *regmap,
-		  int irq, const char *name)
+		  int irq, const struct adxl372_chip_info *chip_info)
 {
 	struct iio_dev *indio_dev;
 	struct adxl372_state *st;
@@ -1192,13 +1221,14 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
 	st->dev = dev;
 	st->regmap = regmap;
 	st->irq = irq;
+	st->chip_info = chip_info;
 
 	mutex_init(&st->threshold_m);
 
 	indio_dev->channels = adxl372_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl372_channels);
 	indio_dev->available_scan_masks = adxl372_channel_masks;
-	indio_dev->name = name;
+	indio_dev->name = chip_info->name;
 	indio_dev->info = &adxl372_info;
 	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 
diff --git a/drivers/iio/accel/adxl372.h b/drivers/iio/accel/adxl372.h
index 80a0aa9714fc..3ce06609446c 100644
--- a/drivers/iio/accel/adxl372.h
+++ b/drivers/iio/accel/adxl372.h
@@ -10,8 +10,22 @@
 
 #define ADXL372_REVID	0x03
 
+struct adxl372_chip_info {
+	const char *name;
+	const int *samp_freq_tbl;
+	const int *bw_freq_tbl;
+	unsigned int num_freqs;
+	unsigned int act_time_scale_us;
+	unsigned int act_time_scale_low_us;
+	unsigned int inact_time_scale_ms;
+	unsigned int inact_time_scale_low_ms;
+	unsigned int max_odr;
+};
+
+extern const struct adxl372_chip_info adxl372_chip_info;
+
 int adxl372_probe(struct device *dev, struct regmap *regmap,
-		  int irq, const char *name);
+		  int irq, const struct adxl372_chip_info *chip_info);
 bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg);
 
 #endif /* _ADXL372_H_ */
diff --git a/drivers/iio/accel/adxl372_i2c.c b/drivers/iio/accel/adxl372_i2c.c
index 186d4fe9a556..3f97126a87a1 100644
--- a/drivers/iio/accel/adxl372_i2c.c
+++ b/drivers/iio/accel/adxl372_i2c.c
@@ -20,11 +20,15 @@ static const struct regmap_config adxl372_regmap_config = {
 
 static int adxl372_i2c_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const struct adxl372_chip_info *chip_info;
 	struct regmap *regmap;
 	unsigned int regval;
 	int ret;
 
+	chip_info = i2c_get_match_data(client);
+	if (!chip_info)
+		return -ENODEV;
+
 	regmap = devm_regmap_init_i2c(client, &adxl372_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
@@ -38,17 +42,17 @@ static int adxl372_i2c_probe(struct i2c_client *client)
 		dev_warn(&client->dev,
 		"I2C might not work properly with other devices on the bus");
 
-	return adxl372_probe(&client->dev, regmap, client->irq, id->name);
+	return adxl372_probe(&client->dev, regmap, client->irq, chip_info);
 }
 
 static const struct i2c_device_id adxl372_i2c_id[] = {
-	{ "adxl372" },
+	{ "adxl372", (kernel_ulong_t)&adxl372_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adxl372_i2c_id);
 
 static const struct of_device_id adxl372_of_match[] = {
-	{ .compatible = "adi,adxl372" },
+	{ .compatible = "adi,adxl372", .data = &adxl372_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adxl372_of_match);
diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
index 39941b519c3b..0e199feb405e 100644
--- a/drivers/iio/accel/adxl372_spi.c
+++ b/drivers/iio/accel/adxl372_spi.c
@@ -22,24 +22,28 @@ static const struct regmap_config adxl372_spi_regmap_config = {
 
 static int adxl372_spi_probe(struct spi_device *spi)
 {
-	const struct spi_device_id *id = spi_get_device_id(spi);
+	const struct adxl372_chip_info *chip_info;
 	struct regmap *regmap;
 
+	chip_info = spi_get_device_match_data(spi);
+	if (!chip_info)
+		return -ENODEV;
+
 	regmap = devm_regmap_init_spi(spi, &adxl372_spi_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return adxl372_probe(&spi->dev, regmap, spi->irq, id->name);
+	return adxl372_probe(&spi->dev, regmap, spi->irq, chip_info);
 }
 
 static const struct spi_device_id adxl372_spi_id[] = {
-	{ "adxl372", 0 },
+	{ "adxl372", (kernel_ulong_t)&adxl372_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adxl372_spi_id);
 
 static const struct of_device_id adxl372_of_match[] = {
-	{ .compatible = "adi,adxl372" },
+	{ .compatible = "adi,adxl372", .data = &adxl372_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adxl372_of_match);
-- 
2.43.0

