Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B89383323;
	Thu, 21 May 2026 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381916; cv=none; b=mRA2Ztkng6OWBJHBwz/TL8f+IUvK5d/PaPDFnztNOtqLfM8vC9hVVhBxUaUJObvlZN5eQrXJ7YWDHiSIH+JOlaAM+ZAShCQfsldYeMSJ7tZtZorC91zjv9L4SJGorlL+0KJfpWPy+RJS2bew9OdPuadEmA+Rh+4TCoA0NKh3vm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381916; c=relaxed/simple;
	bh=JBuDbGfSWLIIWGh//jAOEyuiLHrbagSV3SUnm7dzEwM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AeXPmqaRf77LD42DVcb5Kc8Z+jE1NFTY9+GKaicQGlBbHJ5nAhjKfzr57KigHufJrj8elGgOVWDR7IDg2/eXHoenHv9tEHtQOmFGcRS5zcBGZ6//IBfJ+alY+gKzwCp5ebSqKclEztouE09/rxbyCqaUqnMvJ3ovLa1O6O+CHNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cKRoQIsi; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cKRoQIsi"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LG03MG601763;
	Thu, 21 May 2026 12:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jQXq2
	hQQLVrD5X8tqbaHK3Yl6kCACOd0kkuSSL4YMlU=; b=cKRoQIsi8d20Cid4iB5lw
	y2K2E6YLzuRpxVv1yYOrTYG06mM15zKDQaZ5kAkdql3tIZ3QIkN2ouNjGhURMpay
	9vALZ6tfLXusEococHBvvWBsi+q1R7bHgUAvAMF46LmSfuidwlWYw7m8WH+8TMNu
	Cx+o4pquQM49TCdMVZdZN5d7fC3INAVAukyiiX9RvWKnUhBWPFZ9AryQXp+jJ95H
	Ry2c/Of/yiHEP3g34eNFzlAaNtPdoqLWNXDAzdL+q5kekANGdZTwPKuIhA1W2Rc0
	qQi/mJFSDKNGSSDs0tcCr8/p9KjfHIPhMaqS/VEhZFO3/nGKXgSizWK/peIfVIu1
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e96sry1dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 12:45:11 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LGjAt5000337
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 May 2026 12:45:10 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 12:45:10 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 12:45:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 12:45:09 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.208])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LGim0m024538;
	Thu, 21 May 2026 12:45:01 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Antoniu
 Miclaus" <antoniu.miclaus@analog.com>,
        Francesco Lavra <flavra@baylibre.com>,
        Liviu Stan <liviu.stan@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 2/8] iio: temperature: ltc2983: Use local device pointer consistently
Date: Thu, 21 May 2026 19:42:55 +0300
Message-ID: <20260521164323.770626-3-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521164323.770626-1-liviu.stan@analog.com>
References: <20260521164323.770626-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: -lX_XGfSE8_bZHYcBt3lbabGvgs4oODS
X-Proofpoint-GUID: -lX_XGfSE8_bZHYcBt3lbabGvgs4oODS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE2OCBTYWx0ZWRfX8S8ONgCMiUYM
 P+89yAl1/BPtG3m5xYct+Iied0wul68HoT7Z8yOJ5QPVx3v7NbOmdIigVz98J6+lGblwKITdCBS
 KGa0cPaUV+EnXR1bFALOzDqGNVupLEldcgqmOi1LdDZaS5MR9LYNyYgKxbJQGSoAucWpoTsefYf
 sVXhcBuj+p2/i7appiSkbq/IsYq3GNxwSGuExacr+AetYEdN/LXmUMOHb+XAmvqxdSNaeAPhVi3
 +s/yUxHy/6x67PpADV1AsjulrvXLX4C2X6RlcA8Jg0mdIexGgDOTu+OJ5B0IhRSTk2/Dm4CWIBZ
 yExgTV/EZy8hbEVCbuC1vBwyryS9hMgiYeiwN9plWZ1NW3XYFaWYIirCyqAWD5xmJ40GEfOPQvV
 PJMNwOY55PaT5aGdkHG7ACy2ii+aRDdSZLWl1R3959KGXv+iGnOCFOlv8ivPAMZ9lCNrunyC8hQ
 IS03ovoMXhl6Ni26RQQ==
X-Authority-Analysis: v=2.4 cv=CZs4Irrl c=1 sm=1 tr=0 ts=6a0f3697 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=yv4WWxIh8xz3Wh6Jmy8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210168

Some functions define a local 'dev' pointer but still use bare
'&st->spi->dev' in some code paths, and some don't have it at all.
Replace bare references with the local pointer for consistency.

Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v3:
- Dropped the Fixes: tag
- Fixed one remaining dev_dbg() call in __ltc2983_chan_assign_common()
  that was still using the raw device pointer instead of the dev local
  variable introduced by this patch

 drivers/iio/temperature/ltc2983.c | 83 +++++++++++++++++--------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 67a09934c5bd..d9dcf3e86696 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -351,10 +351,11 @@ static int __ltc2983_chan_assign_common(struct ltc2983_data *st,
 					const struct ltc2983_sensor *sensor,
 					u32 chan_val)
 {
+	struct device *dev = &st->spi->dev;
 	u32 reg = LTC2983_CHAN_ASSIGN_ADDR(sensor->chan);
 
 	chan_val |= LTC2983_CHAN_TYPE(sensor->type);
-	dev_dbg(&st->spi->dev, "Assign reg:0x%04X, val:0x%08X\n", reg,
+	dev_dbg(dev, "Assign reg:0x%04X, val:0x%08X\n", reg,
 		chan_val);
 	st->chan_val = cpu_to_be32(chan_val);
 	return regmap_bulk_write(st->regmap, reg, &st->chan_val,
@@ -656,11 +657,12 @@ static struct ltc2983_sensor *
 ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 			 const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_thermocouple *thermo;
 	u32 oc_current;
 	int ret;
 
-	thermo = devm_kzalloc(&st->spi->dev, sizeof(*thermo), GFP_KERNEL);
+	thermo = devm_kzalloc(dev, sizeof(*thermo), GFP_KERNEL);
 	if (!thermo)
 		return ERR_PTR(-ENOMEM);
 
@@ -687,7 +689,7 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 					LTC2983_THERMOCOUPLE_OC_CURR(3);
 			break;
 		default:
-			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+			return dev_err_ptr_probe(dev, -EINVAL,
 						 "Invalid open circuit current:%u\n",
 						 oc_current);
 		}
@@ -697,7 +699,7 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 	/* validate channel index */
 	if (!(thermo->sensor_config & LTC2983_THERMOCOUPLE_DIFF_MASK) &&
 	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
-		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+		return dev_err_ptr_probe(dev, -EINVAL,
 					 "Invalid chann:%d for differential thermocouple\n",
 					 sensor->chan);
 
@@ -712,7 +714,7 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 			 * This would be caught later but we can just return
 			 * the error right away.
 			 */
-			return dev_err_ptr_probe(&st->spi->dev, ret,
+			return dev_err_ptr_probe(dev, ret,
 						 "Property reg must be given\n");
 	}
 
@@ -823,7 +825,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 	} else {
 		/* same as differential case */
 		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
-			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+			return dev_err_ptr_probe(dev, -EINVAL,
 						 "Invalid chann:%d for RTD\n",
 						 sensor->chan);
 	}
@@ -873,7 +875,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 			rtd->excitation_current = 0x08;
 			break;
 		default:
-			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+			return dev_err_ptr_probe(dev, -EINVAL,
 						 "Invalid value for excitation current(%u)\n",
 						 excitation_current);
 		}
@@ -922,7 +924,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 	/* validate channel index */
 	if (!(thermistor->sensor_config & LTC2983_THERMISTOR_DIFF_MASK) &&
 	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
-		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+		return dev_err_ptr_probe(dev, -EINVAL,
 					 "Invalid chann:%d for differential thermistor\n",
 					 sensor->chan);
 
@@ -964,7 +966,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 		case 0:
 			/* auto range */
 			if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART)
-				return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+				return dev_err_ptr_probe(dev, -EINVAL,
 							 "Auto Range not allowed for custom sensors\n");
 
 			thermistor->excitation_current = 0x0c;
@@ -1003,7 +1005,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 			thermistor->excitation_current = 0x0b;
 			break;
 		default:
-			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+			return dev_err_ptr_probe(dev, -EINVAL,
 						 "Invalid value for excitation current(%u)\n",
 						 excitation_current);
 		}
@@ -1016,11 +1018,12 @@ static struct ltc2983_sensor *
 ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *st,
 		  const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_diode *diode;
 	u32 temp = 0, excitation_current = 0;
 	int ret;
 
-	diode = devm_kzalloc(&st->spi->dev, sizeof(*diode), GFP_KERNEL);
+	diode = devm_kzalloc(dev, sizeof(*diode), GFP_KERNEL);
 	if (!diode)
 		return ERR_PTR(-ENOMEM);
 
@@ -1036,7 +1039,7 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
 	/* validate channel index */
 	if (!(diode->sensor_config & LTC2983_DIODE_DIFF_MASK) &&
 	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
-		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+		return dev_err_ptr_probe(dev, -EINVAL,
 					 "Invalid chann:%d for differential thermistor\n",
 					 sensor->chan);
 
@@ -1061,7 +1064,7 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
 			diode->excitation_current = 0x03;
 			break;
 		default:
-			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+			return dev_err_ptr_probe(dev, -EINVAL,
 						 "Invalid value for excitation current(%u)\n",
 						 excitation_current);
 		}
@@ -1079,23 +1082,24 @@ static struct ltc2983_sensor *ltc2983_r_sense_new(struct fwnode_handle *child,
 					struct ltc2983_data *st,
 					const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_rsense *rsense;
 	int ret;
 	u32 temp;
 
-	rsense = devm_kzalloc(&st->spi->dev, sizeof(*rsense), GFP_KERNEL);
+	rsense = devm_kzalloc(dev, sizeof(*rsense), GFP_KERNEL);
 	if (!rsense)
 		return ERR_PTR(-ENOMEM);
 
 	/* validate channel index */
 	if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
-		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+		return dev_err_ptr_probe(dev, -EINVAL,
 					 "Invalid chann:%d for r_sense\n",
 					 sensor->chan);
 
 	ret = fwnode_property_read_u32(child, "adi,rsense-val-milli-ohms", &temp);
 	if (ret)
-		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+		return dev_err_ptr_probe(dev, -EINVAL,
 					 "Property adi,rsense-val-milli-ohms missing\n");
 	/*
 	 * Times 1000 because we have milli-ohms and __convert_to_raw
@@ -1115,9 +1119,10 @@ static struct ltc2983_sensor *ltc2983_adc_new(struct fwnode_handle *child,
 					 struct ltc2983_data *st,
 					 const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_adc *adc;
 
-	adc = devm_kzalloc(&st->spi->dev, sizeof(*adc), GFP_KERNEL);
+	adc = devm_kzalloc(dev, sizeof(*adc), GFP_KERNEL);
 	if (!adc)
 		return ERR_PTR(-ENOMEM);
 
@@ -1125,7 +1130,7 @@ static struct ltc2983_sensor *ltc2983_adc_new(struct fwnode_handle *child,
 		adc->single_ended = true;
 
 	if (!adc->single_ended && sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
-		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+		return dev_err_ptr_probe(dev, -EINVAL,
 					 "Invalid chan:%d for differential adc\n",
 					 sensor->chan);
 
@@ -1140,9 +1145,10 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
 					       struct ltc2983_data *st,
 					       const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_temp *temp;
 
-	temp = devm_kzalloc(&st->spi->dev, sizeof(*temp), GFP_KERNEL);
+	temp = devm_kzalloc(dev, sizeof(*temp), GFP_KERNEL);
 	if (!temp)
 		return ERR_PTR(-ENOMEM);
 
@@ -1150,7 +1156,7 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
 		temp->single_ended = true;
 
 	if (!temp->single_ended && sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
-		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+		return dev_err_ptr_probe(dev, -EINVAL,
 					 "Invalid chan:%d for differential temp\n",
 					 sensor->chan);
 
@@ -1169,13 +1175,14 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
 static int ltc2983_chan_read(struct ltc2983_data *st,
 			const struct ltc2983_sensor *sensor, int *val)
 {
+	struct device *dev = &st->spi->dev;
 	u32 start_conversion = 0;
 	int ret;
 	unsigned long time;
 
 	start_conversion = LTC2983_STATUS_START(true);
 	start_conversion |= LTC2983_STATUS_CHAN_SEL(sensor->chan);
-	dev_dbg(&st->spi->dev, "Start conversion on chan:%d, status:%02X\n",
+	dev_dbg(dev, "Start conversion on chan:%d, status:%02X\n",
 		sensor->chan, start_conversion);
 	/* start conversion */
 	ret = regmap_write(st->regmap, LTC2983_STATUS_REG, start_conversion);
@@ -1192,7 +1199,7 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
 	time = wait_for_completion_timeout(&st->completion,
 					   msecs_to_jiffies(300));
 	if (!time) {
-		dev_warn(&st->spi->dev, "Conversion timed out\n");
+		dev_warn(dev, "Conversion timed out\n");
 		return -ETIMEDOUT;
 	}
 
@@ -1205,7 +1212,7 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
 	*val = __be32_to_cpu(st->temp);
 
 	if (!(LTC2983_RES_VALID_MASK & *val)) {
-		dev_err(&st->spi->dev, "Invalid conversion detected\n");
+		dev_err(dev, "Invalid conversion detected\n");
 		return -EIO;
 	}
 
@@ -1222,11 +1229,12 @@ static int ltc2983_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct ltc2983_data *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
 	int ret;
 
 	/* sanity check */
 	if (chan->address >= st->num_channels) {
-		dev_err(&st->spi->dev, "Invalid chan address:%ld",
+		dev_err(dev, "Invalid chan address:%ld",
 			chan->address);
 		return -EINVAL;
 	}
@@ -1303,7 +1311,7 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 
 	st->num_channels = device_get_child_node_count(dev);
 	if (!st->num_channels)
-		return dev_err_probe(&st->spi->dev, -EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "At least one channel must be given!\n");
 
 	st->sensors = devm_kcalloc(dev, st->num_channels, sizeof(*st->sensors),
@@ -1391,6 +1399,7 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 			      unsigned int wait_time, unsigned int status_reg,
 			      unsigned long status_fail_mask)
 {
+	struct device *dev = &st->spi->dev;
 	unsigned long time;
 	unsigned int val;
 	int ret;
@@ -1410,7 +1419,7 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 	time = wait_for_completion_timeout(&st->completion,
 					   msecs_to_jiffies(wait_time));
 	if (!time)
-		return dev_err_probe(&st->spi->dev, -ETIMEDOUT,
+		return dev_err_probe(dev, -ETIMEDOUT,
 				     "EEPROM command timed out\n");
 
 	ret = regmap_read(st->regmap, status_reg, &val);
@@ -1418,7 +1427,7 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 		return ret;
 
 	if (val & status_fail_mask)
-		return dev_err_probe(&st->spi->dev, -EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "EEPROM command failed: 0x%02X\n", val);
 
 	return 0;
@@ -1427,6 +1436,7 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 {
 	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status;
+	struct device *dev = &st->spi->dev;
 	int ret;
 
 	/* make sure the device is up: start bit (7) is 0 and done bit (6) is 1 */
@@ -1434,7 +1444,7 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 				       LTC2983_STATUS_UP(status) == 1, 25000,
 				       25000 * 10);
 	if (ret)
-		return dev_err_probe(&st->spi->dev, ret,
+		return dev_err_probe(dev, ret,
 				     "Device startup timed out\n");
 
 	ret = regmap_update_bits(st->regmap, LTC2983_GLOBAL_CONFIG_REG,
@@ -1535,12 +1545,13 @@ static const struct  iio_info ltc2983_iio_info = {
 
 static int ltc2983_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct ltc2983_data *st;
 	struct iio_dev *indio_dev;
 	struct gpio_desc *gpio;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1552,7 +1563,7 @@ static int ltc2983_probe(struct spi_device *spi)
 
 	st->regmap = devm_regmap_init_spi(spi, &ltc2983_regmap_config);
 	if (IS_ERR(st->regmap))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "Failed to initialize regmap\n");
 
 	mutex_init(&st->lock);
@@ -1565,11 +1576,11 @@ static int ltc2983_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_regulator_get_enable(&spi->dev, "vdd");
+	ret = devm_regulator_get_enable(dev, "vdd");
 	if (ret)
 		return ret;
 
-	gpio = devm_gpiod_get_optional(&st->spi->dev, "reset", GPIOD_OUT_HIGH);
+	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
@@ -1579,7 +1590,7 @@ static int ltc2983_probe(struct spi_device *spi)
 		gpiod_set_value_cansleep(gpio, 0);
 	}
 
-	st->iio_chan = devm_kzalloc(&spi->dev,
+	st->iio_chan = devm_kzalloc(dev,
 				    st->iio_channels * sizeof(*st->iio_chan),
 				    GFP_KERNEL);
 	if (!st->iio_chan)
@@ -1589,10 +1600,10 @@ static int ltc2983_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_request_irq(&spi->dev, spi->irq, ltc2983_irq_handler,
+	ret = devm_request_irq(dev, spi->irq, ltc2983_irq_handler,
 			       IRQF_TRIGGER_RISING, st->info->name, st);
 	if (ret)
-		return dev_err_probe(&spi->dev, ret,
+		return dev_err_probe(dev, ret,
 				     "failed to request an irq\n");
 
 	if (st->info->has_eeprom) {
@@ -1610,7 +1621,7 @@ static int ltc2983_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ltc2983_iio_info;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int ltc2983_resume(struct device *dev)
-- 
2.43.0

