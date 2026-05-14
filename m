Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7259C3955F4;
	Thu, 14 May 2026 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770172; cv=none; b=X4dZ5GTPcj3iJema5iY89nBS6jhdSReh9XQiieoFyYlNsu5ApeHv4Y61HhCQq0TPcEY+R+uWeYXiOtNJ+aOt5dbCyzCjmk21dZ262x/XQaKmGi/auhzilWbcn48SbVNoT4sVU4/P2wcpZgqNHHD4KHsb807HfFqS+9qDM3TfcUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770172; c=relaxed/simple;
	bh=dIGR54g+j/9yoCqVw2BlXyFlQd0JBTGgLT5LEFMHCCs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZKRtFBS57B7WKfMcvodlU0ZvnkmUHrry3vXmrcKuNCDgsaXpRQ1gNxjUXSZmPS1km9OpF5/aO0ZK7kORUJ6WwLRvxqp/qp3TfNscVNzRjD6DSG81dXrNAs7xtbXaT/B72u2VHEwhp+IQBg/XlNOe6t1w9MbqnF2XvpxEKVWCO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nR8wzgMN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nR8wzgMN"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EE2VrN2905295;
	Thu, 14 May 2026 10:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=IYoon
	QSyJ+0IlGtHVpgFXc+0gu5zJqKJ93oSnh/aYLs=; b=nR8wzgMNq328zAF33A3MN
	44KK+U/jtv9hrWG7lgCB06JModNBwRMFYDIM5PFE/zSdpSQx54rS7CN77pPRW2KN
	royuu51TugkL5UKLcK+IDERcmYyvyJ/bhVp3vub4qc6UMTRDZKyPrVXEq31jKr4D
	cjZDH0jIzv2uZxFapWvU050S91p02Hj6WrIbkqadoPwM2nr6g/2frOCnzmRcrkvI
	Z34PKK86EbwZjEZWxii9fi44PZHUS4mgzFHVAqtH3HjCEXXT0s1aAMRNVPWRyP+Y
	NQ64wZeIbB5W558Xf74hkaF1do9L/jc42Mi0ITIYjR4HjJ44o8o9QslL/t3R+hZY
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e4t1xvwbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 10:49:27 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64EEnQbm041731
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 May 2026 10:49:26 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 14 May
 2026 10:49:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 14 May 2026 10:49:26 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.202])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64EEmjAa014051;
	Thu, 14 May 2026 10:49:17 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Antoniu
 Miclaus <antoniu.miclaus@analog.com>,
        Liviu Stan <liviu.stan@analog.com>,
        Francesco Lavra <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 3/7] iio: temperature: ltc2983: Fix inconsistent channel wording in messages
Date: Thu, 14 May 2026 17:46:50 +0300
Message-ID: <20260514144712.64374-4-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514144712.64374-1-liviu.stan@analog.com>
References: <20260514144712.64374-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ie4FAFkXJBVlzenKnbOmK5Nh5CJBFrJn
X-Authority-Analysis: v=2.4 cv=Wbo8rUhX c=1 sm=1 tr=0 ts=6a05e0f7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=ns7QdhbT8QDaN8w0EOgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE1MCBTYWx0ZWRfXyFNwQ2afk3Co
 GZr3V580ZudqjCWrw9HiBl7Ojvb5s2wYt1DL7K3JJ0SpjldJcvdTc9b2uGXmfK2pjMmlkgf7PrJ
 Kb4oWPSQ20XpFazNCKp7wpENQa90IxJokUD0UhI9Qz9zdrGrwOO0M9vuSfd8Pkwxl8DYBDkLrPh
 fM7tOaPMaBWoGrjXhtRHHk4Xyg61uOv8fehjWxzoerMIVg+V9Oe1kGomPcJj1z8fUcRrxR9zSLJ
 xrpk0g15PrKsrfMFmT3SvzWSTfJ9htaqCviCJqJBO+QOIAiutL8CJT/2HvMh16J9FmhFsHdECUX
 CeF5Ye6tdNuTf4q+efQHAOHnYEGqXZB4VxOeAN+NfskT+rvLfnRG2lVKJiLL5iD6n4r/xU4icfV
 aUbA+01l96ihBZOY5WV5LB+Rswa7IuySiGIjpsJ4Q4DB9OZZcJKvwPa59JqNAYWD6NCtZlQQBVF
 GVDsX8mnjCjABuDi1cg==
X-Proofpoint-GUID: ie4FAFkXJBVlzenKnbOmK5Nh5CJBFrJn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140150

Replace all occurrences of the abbreviated 'chann' and 'chan' with
'channel' in error and debug messages throughout the driver.

Fixes: f110f3188e5639c81c457b2b831d40dfe3891bdb ("iio: temperature: Add support for LTC2983")
Fixes: a00838cae079b9b9b90969c2b7b031b1bfd9ab3a ("iio: temperature: ltc2983: convert to dev_err_probe()")
Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v2:
- New patch.

 drivers/iio/temperature/ltc2983.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index e74ea4f87ec9..f42777c1f3c2 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -700,7 +700,7 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 	if (!(thermo->sensor_config & LTC2983_THERMOCOUPLE_DIFF_MASK) &&
 	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
 		return dev_err_ptr_probe(dev, -EINVAL,
-					 "Invalid chann:%d for differential thermocouple\n",
+					 "Invalid channel %d for differential thermocouple\n",
 					 sensor->chan);
 
 	struct fwnode_handle *ref __free(fwnode_handle) =
@@ -798,7 +798,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 	/*
 	 * rtd channel indexes are a bit more complicated to validate.
 	 * For 4wire RTD with rotation, the channel selection cannot be
-	 * >=19 since the chann + 1 is used in this configuration.
+	 * >=19 since the channel + 1 is used in this configuration.
 	 * For 4wire RTDs with kelvin rsense, the rsense channel cannot be
 	 * <=1 since channel - 1 and channel - 2 are used.
 	 */
@@ -815,18 +815,18 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 		    (rtd->r_sense_chan <=  min))
 			/* kelvin rsense*/
 			return dev_err_ptr_probe(dev, -EINVAL,
-						 "Invalid rsense chann:%d to use in kelvin rsense\n",
+						 "Invalid channel %d for kelvin rsense\n",
 						 rtd->r_sense_chan);
 
 		if (sensor->chan < min || sensor->chan > max)
 			return dev_err_ptr_probe(dev, -EINVAL,
-						 "Invalid chann:%d for the rtd config\n",
+						 "Invalid channel %d for RTD config\n",
 						 sensor->chan);
 	} else {
 		/* same as differential case */
 		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
 			return dev_err_ptr_probe(dev, -EINVAL,
-						 "Invalid chann:%d for RTD\n",
+						 "Invalid channel %d for RTD\n",
 						 sensor->chan);
 	}
 
@@ -925,7 +925,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 	if (!(thermistor->sensor_config & LTC2983_THERMISTOR_DIFF_MASK) &&
 	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
 		return dev_err_ptr_probe(dev, -EINVAL,
-					 "Invalid chann:%d for differential thermistor\n",
+					 "Invalid channel %d for differential thermistor\n",
 					 sensor->chan);
 
 	/* check custom sensor */
@@ -1040,7 +1040,7 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
 	if (!(diode->sensor_config & LTC2983_DIODE_DIFF_MASK) &&
 	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
 		return dev_err_ptr_probe(dev, -EINVAL,
-					 "Invalid chann:%d for differential thermistor\n",
+					 "Invalid channel %d for differential thermistor\n",
 					 sensor->chan);
 
 	/* set common parameters */
@@ -1094,7 +1094,7 @@ static struct ltc2983_sensor *ltc2983_r_sense_new(struct fwnode_handle *child,
 	/* validate channel index */
 	if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
 		return dev_err_ptr_probe(dev, -EINVAL,
-					 "Invalid chann:%d for r_sense\n",
+					 "Invalid channel %d for r_sense\n",
 					 sensor->chan);
 
 	ret = fwnode_property_read_u32(child, "adi,rsense-val-milli-ohms", &temp);
@@ -1131,7 +1131,7 @@ static struct ltc2983_sensor *ltc2983_adc_new(struct fwnode_handle *child,
 
 	if (!adc->single_ended && sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
 		return dev_err_ptr_probe(dev, -EINVAL,
-					 "Invalid chan:%d for differential adc\n",
+					 "Invalid channel %d for differential ADC\n",
 					 sensor->chan);
 
 	/* set common parameters */
@@ -1157,7 +1157,7 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
 
 	if (!temp->single_ended && sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
 		return dev_err_ptr_probe(dev, -EINVAL,
-					 "Invalid chan:%d for differential temp\n",
+					 "Invalid channel %d for differential temp\n",
 					 sensor->chan);
 
 	temp->custom = __ltc2983_custom_sensor_new(st, child, "adi,custom-temp",
@@ -1182,7 +1182,7 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
 
 	start_conversion = LTC2983_STATUS_START(true);
 	start_conversion |= LTC2983_STATUS_CHAN_SEL(sensor->chan);
-	dev_dbg(dev, "Start conversion on chan:%d, status:%02X\n",
+	dev_dbg(dev, "Start conversion on channel:%d, status:%02X\n",
 		sensor->chan, start_conversion);
 	/* start conversion */
 	ret = regmap_write(st->regmap, LTC2983_STATUS_REG, start_conversion);
@@ -1234,7 +1234,7 @@ static int ltc2983_read_raw(struct iio_dev *indio_dev,
 
 	/* sanity check */
 	if (chan->address >= st->num_channels) {
-		dev_err(dev, "Invalid chan address:%ld",
+		dev_err(dev, "Invalid channel address: %ld\n",
 			chan->address);
 		return -EINVAL;
 	}
-- 
2.43.0

