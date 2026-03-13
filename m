Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6399331E83C;
	Fri, 13 Mar 2026 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402975; cv=none; b=f2GMIZWOI7LvZlNMApfYz3xwlktJMJWOo0MaQwSJQ4xO3t4qZVfwx2SO5cKO8YR4CYbtF64nFWPL8vR+egFVYaxPmHtpf6zvIPLGxUUzYegeFACG1YjRx+5AAoQhxuIvobJbippVgO7Lxk/8X7xRpMace+pcB7qJHBnxYNVr77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402975; c=relaxed/simple;
	bh=1ASgyQknz8fhsZ5x4zc6BSBNqJUQdAiD/r2QWs4NZtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfBMeBiLX/a/bdX9AHxPZckD3Kmu4UDot19laYL2qHM18pcGbtWc4Z2+SWGeCF+N/Z8ip6YWrEU0Oy/w0XsUKRF2oAQJ3MqVcEB5uGjpSKFaHUMy1yNihf3lbnheMywXzpIZ+pTjLIi1DJRNJ8ahKhvss1sqpxuydLlL44mif80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ggbgi1of; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ggbgi1of"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DBdIOo3650902;
	Fri, 13 Mar 2026 07:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YAKLD
	SpxFKirH/ovRIghrMvUsm2BNrRK/q9BMIp/ukk=; b=ggbgi1ofzOvyHW8qE/XRC
	iibssXIYNbrJeLjMX3h6bhfH8zH8Grit8ZUCD5i3ALsKWcFaDuuP/fy0GplSYu0H
	jHEUfcDEY/l0INernwgp3NHBTPgt+IzdmikiicjgwTz3Zh9awTPiFOuUC4Jdv+2h
	gBvtXwEfwukRowsjiu/gRXUzOik0W4Z8Jrtz5qrr+/znLt5yWSRr3iDqIZmkjJCF
	2u50Wgqvy0aIl+VpaxUl2r1eK1uk4alLXlWTSuyHIzJziYicZNzjjRfAHRvHwkWT
	ZOlfDGgVzWvyJdvr78yKek9/10iAbZqQ1otpXifZBnJTsjzt8/mvbmAKSGPpy8qn
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cuh6bf0u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:55:55 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62DBtsbS017339
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Mar 2026 07:55:54 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 13 Mar
 2026 07:55:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Mar 2026 07:55:54 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62DBtTxI024500;
	Fri, 13 Mar 2026 07:55:45 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Petre
 Rodan <petre.rodan@subdimension.ro>,
        Jorge Marques
	<jorge.marques@analog.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 1/4] iio: accel: adxl372: introduce chip_info structure
Date: Fri, 13 Mar 2026 13:54:54 +0200
Message-ID: <20260313115525.85435-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313115525.85435-1-antoniu.miclaus@analog.com>
References: <20260313115525.85435-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Gd76c5x9MJEkLbpvKXE268y0cx9pNesF
X-Authority-Analysis: v=2.4 cv=c6amgB9l c=1 sm=1 tr=0 ts=69b3fb4b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=jxnvQMpmH7UaMOIg134A:9
 a=FHz5paCR_PjzkVn5qDnB:22
X-Proofpoint-GUID: Gd76c5x9MJEkLbpvKXE268y0cx9pNesF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NCBTYWx0ZWRfX/0znBKfeWLF9
 SphaPrP/p++YQuNaiHFXi2wdOr9d4jWdUbfADjd59apU/YG90Ek5KP6732F+EV0WpW4wtvC9oXf
 XFZ129IrZCUAt/SPCD3sgATTShN9iI5zG4f86RcadowsYDbH1s0NOx4RA5WJpNHPLP5bQCUfMc4
 rPm9Elv/J0LwG3yWSkoxawJ1kCyo2hUjGLPbkr95IExNnphJZpnbXiaCKGlUW5hIGR3wsvG6Vub
 ibAzJTSe+47i1RNzwA8BzoyW36yDbMMEwNANyFrwdXN5QSAeaxcZ7hOjVvmgZW4xYWRjgWPqWdV
 G/GQuavoA6ld5Pn/tiRedMU045gUAUWjtAsyVGwIO/+VRSH3CR+61aHlzR8j7WCge7Kn07Kspus
 GY0CFPYE62cFQqcCP6wxJLwdm8zNX3GVg+5mFt67u9XEcEvOuXVbQjklFpxAiBX1zDY2RbNQjlX
 jdOYfqm1IMJuuP/zIRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130094

Introduce a chip_info structure to parameterize device-specific
properties such as ODR/bandwidth frequency tables, activity/inactivity
timer scale factors, and the maximum ODR value. This refactors the
driver to use chip_info lookups instead of hardcoded values, preparing
the driver to support multiple device variants.

The sampling_frequency and filter_low_pass_3db_frequency available
attributes are switched from custom sysfs callbacks to read_avail()
based handling via info_mask_shared_by_type_available. This enforces
consistent formatting through the IIO framework and makes the values
accessible to in-kernel consumers.

The SPI/I2C probe functions are updated to pass a chip_info pointer
instead of a device name string.

No functional change intended.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v3:
 - Use designated initializers for adxl372_bw_freq_tbl[] for
   consistency with the other frequency tables.

Changes in v2:
 - Switch sampling_frequency and filter_low_pass_3db_frequency available
   attributes from custom sysfs callbacks to read_avail() with
   info_mask_shared_by_type_available.

 drivers/iio/accel/adxl372.c     | 146 ++++++++++++++++++--------------
 drivers/iio/accel/adxl372.h     |  16 +++-
 drivers/iio/accel/adxl372_i2c.c |  12 ++-
 drivers/iio/accel/adxl372_spi.c |  12 ++-
 4 files changed, 113 insertions(+), 73 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 28a8793a53b6..d7c580bc9e49 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -180,6 +180,7 @@ enum adxl372_odr {
 	ADXL372_ODR_1600HZ,
 	ADXL372_ODR_3200HZ,
 	ADXL372_ODR_6400HZ,
+	ADXL372_ODR_NUM,
 };
 
 enum adxl372_bandwidth {
@@ -214,14 +215,35 @@ enum adxl372_fifo_mode {
 	ADXL372_FIFO_OLD_SAVED
 };
 
-static const int adxl372_samp_freq_tbl[5] = {
-	400, 800, 1600, 3200, 6400,
+static const int adxl372_samp_freq_tbl[ADXL372_ODR_NUM] = {
+	[ADXL372_ODR_400HZ] = 400,
+	[ADXL372_ODR_800HZ] = 800,
+	[ADXL372_ODR_1600HZ] = 1600,
+	[ADXL372_ODR_3200HZ] = 3200,
+	[ADXL372_ODR_6400HZ] = 6400,
 };
 
-static const int adxl372_bw_freq_tbl[5] = {
-	200, 400, 800, 1600, 3200,
+static const int adxl372_bw_freq_tbl[ADXL372_ODR_NUM] = {
+	[ADXL372_BW_200HZ] = 200,
+	[ADXL372_BW_400HZ] = 400,
+	[ADXL372_BW_800HZ] = 800,
+	[ADXL372_BW_1600HZ] = 1600,
+	[ADXL372_BW_3200HZ] = 3200,
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
@@ -260,6 +282,9 @@ static const struct iio_event_spec adxl372_events[] = {
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 				    BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
 		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
+	.info_mask_shared_by_type_available =				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |				\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
 	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
@@ -279,6 +304,7 @@ static const struct iio_chan_spec adxl372_channels[] = {
 };
 
 struct adxl372_state {
+	const struct adxl372_chip_info	*chip_info;
 	int				irq;
 	struct device			*dev;
 	struct regmap			*regmap;
@@ -471,13 +497,14 @@ static int adxl372_set_activity_time_ms(struct adxl372_state *st,
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
 
@@ -501,13 +528,14 @@ static int adxl372_set_inactivity_time_ms(struct adxl372_state *st,
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
@@ -717,7 +745,7 @@ static int adxl372_setup(struct adxl372_state *st)
 	if (ret < 0)
 		return ret;
 
-	ret = adxl372_set_odr(st, ADXL372_ODR_6400HZ);
+	ret = adxl372_set_odr(st, st->chip_info->max_odr);
 	if (ret < 0)
 		return ret;
 
@@ -777,10 +805,10 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
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
 
@@ -796,23 +824,17 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
 
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
@@ -825,9 +847,9 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
 
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
@@ -957,24 +979,6 @@ static int adxl372_write_event_config(struct iio_dev *indio_dev, const struct ii
 	return adxl372_set_interrupts(st, st->int1_bitmask, 0);
 }
 
-static ssize_t adxl372_show_filter_freq_avail(struct device *dev,
-					      struct device_attribute *attr,
-					      char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct adxl372_state *st = iio_priv(indio_dev);
-	int i;
-	size_t len = 0;
-
-	for (i = 0; i <= st->odr; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-				 "%d ", adxl372_bw_freq_tbl[i]);
-
-	buf[len - 1] = '\n';
-
-	return len;
-}
-
 static ssize_t adxl372_get_fifo_enabled(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
@@ -1142,25 +1146,38 @@ static const struct iio_trigger_ops adxl372_peak_data_trigger_ops = {
 	.set_trigger_state = adxl372_peak_dready_trig_set_state,
 };
 
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
-static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
-		       0444, adxl372_show_filter_freq_avail, NULL, 0);
-
-static struct attribute *adxl372_attributes[] = {
-	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
-	NULL,
-};
+static int adxl372_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
 
-static const struct attribute_group adxl372_attrs_group = {
-	.attrs = adxl372_attributes,
-};
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = st->chip_info->samp_freq_tbl;
+		*type = IIO_VAL_INT;
+		*length = st->chip_info->num_freqs;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*vals = st->chip_info->bw_freq_tbl;
+		*type = IIO_VAL_INT;
+		/*
+		 * Bandwidth cannot exceed half the sampling frequency
+		 * (Nyquist), so limit available values based on current ODR.
+		 */
+		*length = st->odr + 1;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
 
 static const struct iio_info adxl372_info = {
 	.validate_trigger = &adxl372_validate_trigger,
-	.attrs = &adxl372_attrs_group,
 	.read_raw = adxl372_read_raw,
 	.write_raw = adxl372_write_raw,
+	.read_avail = adxl372_read_avail,
 	.read_event_config = adxl372_read_event_config,
 	.write_event_config = adxl372_write_event_config,
 	.read_event_value = adxl372_read_event_value,
@@ -1176,7 +1193,7 @@ bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg)
 EXPORT_SYMBOL_NS_GPL(adxl372_readable_noinc_reg, "IIO_ADXL372");
 
 int adxl372_probe(struct device *dev, struct regmap *regmap,
-		  int irq, const char *name)
+		  int irq, const struct adxl372_chip_info *chip_info)
 {
 	struct iio_dev *indio_dev;
 	struct adxl372_state *st;
@@ -1192,13 +1209,14 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
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

