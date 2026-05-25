Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B491A681E;
	Mon, 25 May 2026 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727298; cv=none; b=VYIJ1rysy6FmgqFayGaVPAlcZTMbu5QUzLoDLIqN0kWpmN6oIidS+lodqvQ53NCDvjeKhCr20nPKsZ0fs7iWel2vMu4eghaV2t7f+xMp8PRcCUugXj1xaR3JaRfijJoTYs8HwHqSANNdIBEH7hOWH3RWQoCbPXX3UpazFDWdbI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727298; c=relaxed/simple;
	bh=+Ej+qb4/P6rmQ38NiqwulK1s6WEJNYNuOEWwxYKF/uE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUDp8Pz2tRyVDtoKNKeOB4Jryng3+YJYtkkjuEcY3ZQmFUjdTrvIHbPW8MOvVfk2FmhBXC6OcmrRpY2ZoNFEyedPPK0UxIJORWZLuZNYC92J1+f8+QffzTDzva691K19wUc/CsenU4e1PXM5N5bnvx1jHXEFe+rn2rfsa4dryoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vWlLS3ev; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vWlLS3ev"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PBQ9Ij753521;
	Mon, 25 May 2026 12:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4u19b
	F15aWhMFTJbLM/nX/V+7lOgfpWfDJugEP2NT6I=; b=vWlLS3evoL4bO0q3uWCSU
	C6pmDz6pmQp1MBp4xBXPi3sKvERNSc73527Gv5Y0sv63zxAwAFQZ5nr3NLyeCYwn
	WsJUP40D5U222oZxt/Eixz/D0iFL9zspwX3bSunaBffrcXstY/iNgJE39CzACLui
	sqsEr9kD4bUA/UkRJoU6/NnlwWLfwy8bmh4yrLToGrRrs4MktsBv5ifi0jEkYEnL
	GpwGg5B5pbOh2PZbXuK+P3LSwlH1FBBpYsq9cn4Wmi3fNHSG0c8jU8zJAh1MPsGi
	0hMTNsujnwLRSo7lDEtZmsUxmROen3atsp+jTODDiP15kSjts3o2EHzLGgzjlFQ7
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ecbgtavay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 12:41:33 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64PGfWKQ022298
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 May 2026 12:41:32 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 25 May 2026 12:41:31 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 25 May 2026 12:41:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 25 May 2026 12:41:31 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com ([10.32.226.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64PGevH3028845;
	Mon, 25 May 2026 12:41:24 -0400
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
        Liviu Stan <liviu.stan@analog.com>,
        Francesco Lavra <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
CC: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v4 4/9] iio: temperature: ltc2983: Use local device pointer consistently
Date: Mon, 25 May 2026 19:39:31 +0300
Message-ID: <20260525164013.118614-5-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525164013.118614-1-liviu.stan@analog.com>
References: <20260525164013.118614-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: oUHkMCa7oA-vDfhTb96Ds9jwCMVyBwcd
X-Proofpoint-ORIG-GUID: oUHkMCa7oA-vDfhTb96Ds9jwCMVyBwcd
X-Authority-Analysis: v=2.4 cv=L5EtheT8 c=1 sm=1 tr=0 ts=6a147bbd cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8
 a=WZ6_M-xBb7e6Z6g-aakA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE2OCBTYWx0ZWRfX+z0ZBBq6eDyD
 9vmNZMYxTnj0KI5eshHZJhKUQqkR9kTtQl7EcGyRHIushHmDLwcLnlRP4uELDoT2BcZqJqBYZPq
 ZMdNAHwkDfF8TiU8gGkBKtyYzaJuav/zVjN3ogmxrnIG0NGbTW8DP8n8Mo8/uPJ80Zfqb6zFoo3
 lFJMXyizwTTbeoFwm/3DHtugw/QryPaiSWto391kiucL5DhhI/Xe7gorm/4OCXfDh+3Q7CUiCtq
 qxwwb8pBF69E7dKik4q6z1Ll8q1/1kTdHbndWEqVbFxB4wT75GiG6YulJ3iUUGbZsxeKDC0NQo6
 +aAeB+vV1jLwxmco+RzX/dQC33HZux2nl/085+E9H0/0q25GYhpwT1nwwg8HJPXvWApOEkemkzY
 TpX1viOy5u/uMomVjVL7W7bnhmDZLb2QTFVQ+Onv5ARqDZdhn9S7tgrHBPyTVKrSp0o6Dpk8ALd
 qtJB+6bCvtGvbcPHO4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250168

Some functions define a local 'dev' pointer but still use bare
'&st->spi->dev' in some code paths, and some don't have it at all.
Replace bare references with the local pointer for consistency and
collapse some wrapped lines that now fit within 80 characters.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v4:
- Collapsed some wrapped lines that now fit within 80 characters
- Decided to leave lines that would slightly pass 80 characters
  wrapped since they looked more readable
- Updated commit message to reflect the line consolidation
- Added Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

 drivers/iio/temperature/ltc2983.c | 87 +++++++++++++++++--------------
 1 file changed, 47 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 4bae90f03002..8b0b6b4884f6 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -351,11 +351,11 @@ static int __ltc2983_chan_assign_common(struct ltc2983_data *st,
 					const struct ltc2983_sensor *sensor,
 					u32 chan_val)
 {
+	struct device *dev = &st->spi->dev;
 	u32 reg = LTC2983_CHAN_ASSIGN_ADDR(sensor->chan);
 
 	chan_val |= LTC2983_CHAN_TYPE(sensor->type);
-	dev_dbg(&st->spi->dev, "Assign reg:0x%04X, val:0x%08X\n", reg,
-		chan_val);
+	dev_dbg(dev, "Assign reg:0x%04X, val:0x%08X\n", reg, chan_val);
 	st->chan_val = cpu_to_be32(chan_val);
 	return regmap_bulk_write(st->regmap, reg, &st->chan_val,
 				 sizeof(st->chan_val));
@@ -656,11 +656,12 @@ static struct ltc2983_sensor *
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
 
@@ -687,7 +688,7 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 					LTC2983_THERMOCOUPLE_OC_CURR(3);
 			break;
 		default:
-			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+			return dev_err_ptr_probe(dev, -EINVAL,
 						 "Invalid open circuit current:%u\n",
 						 oc_current);
 		}
@@ -697,7 +698,7 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 	/* validate channel index */
 	if (!(thermo->sensor_config & LTC2983_THERMOCOUPLE_DIFF_MASK) &&
 	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
-		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+		return dev_err_ptr_probe(dev, -EINVAL,
 					 "Invalid chann:%d for differential thermocouple\n",
 					 sensor->chan);
 
@@ -712,7 +713,7 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 			 * This would be caught later but we can just return
 			 * the error right away.
 			 */
-			return dev_err_ptr_probe(&st->spi->dev, ret,
+			return dev_err_ptr_probe(dev, ret,
 						 "Property reg must be given\n");
 	}
 
@@ -823,7 +824,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 	} else {
 		/* same as differential case */
 		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
-			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+			return dev_err_ptr_probe(dev, -EINVAL,
 						 "Invalid chann:%d for RTD\n",
 						 sensor->chan);
 	}
@@ -873,7 +874,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 			rtd->excitation_current = 0x08;
 			break;
 		default:
-			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+			return dev_err_ptr_probe(dev, -EINVAL,
 						 "Invalid value for excitation current(%u)\n",
 						 excitation_current);
 		}
@@ -922,7 +923,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 	/* validate channel index */
 	if (!(thermistor->sensor_config & LTC2983_THERMISTOR_DIFF_MASK) &&
 	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
-		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+		return dev_err_ptr_probe(dev, -EINVAL,
 					 "Invalid chann:%d for differential thermistor\n",
 					 sensor->chan);
 
@@ -964,7 +965,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 		case 0:
 			/* auto range */
 			if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART)
-				return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+				return dev_err_ptr_probe(dev, -EINVAL,
 							 "Auto Range not allowed for custom sensors\n");
 
 			thermistor->excitation_current = 0x0c;
@@ -1003,7 +1004,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 			thermistor->excitation_current = 0x0b;
 			break;
 		default:
-			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+			return dev_err_ptr_probe(dev, -EINVAL,
 						 "Invalid value for excitation current(%u)\n",
 						 excitation_current);
 		}
@@ -1016,11 +1017,12 @@ static struct ltc2983_sensor *
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
 
@@ -1036,7 +1038,7 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
 	/* validate channel index */
 	if (!(diode->sensor_config & LTC2983_DIODE_DIFF_MASK) &&
 	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
-		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+		return dev_err_ptr_probe(dev, -EINVAL,
 					 "Invalid chann:%d for differential thermistor\n",
 					 sensor->chan);
 
@@ -1061,7 +1063,7 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
 			diode->excitation_current = 0x03;
 			break;
 		default:
-			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+			return dev_err_ptr_probe(dev, -EINVAL,
 						 "Invalid value for excitation current(%u)\n",
 						 excitation_current);
 		}
@@ -1079,23 +1081,24 @@ static struct ltc2983_sensor *ltc2983_r_sense_new(struct fwnode_handle *child,
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
@@ -1115,9 +1118,10 @@ static struct ltc2983_sensor *ltc2983_adc_new(struct fwnode_handle *child,
 					 struct ltc2983_data *st,
 					 const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_adc *adc;
 
-	adc = devm_kzalloc(&st->spi->dev, sizeof(*adc), GFP_KERNEL);
+	adc = devm_kzalloc(dev, sizeof(*adc), GFP_KERNEL);
 	if (!adc)
 		return ERR_PTR(-ENOMEM);
 
@@ -1125,7 +1129,7 @@ static struct ltc2983_sensor *ltc2983_adc_new(struct fwnode_handle *child,
 		adc->single_ended = true;
 
 	if (!adc->single_ended && sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
-		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+		return dev_err_ptr_probe(dev, -EINVAL,
 					 "Invalid chan:%d for differential adc\n",
 					 sensor->chan);
 
@@ -1140,9 +1144,10 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
 					       struct ltc2983_data *st,
 					       const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_temp *temp;
 
-	temp = devm_kzalloc(&st->spi->dev, sizeof(*temp), GFP_KERNEL);
+	temp = devm_kzalloc(dev, sizeof(*temp), GFP_KERNEL);
 	if (!temp)
 		return ERR_PTR(-ENOMEM);
 
@@ -1150,7 +1155,7 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
 		temp->single_ended = true;
 
 	if (!temp->single_ended && sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
-		return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+		return dev_err_ptr_probe(dev, -EINVAL,
 					 "Invalid chan:%d for differential temp\n",
 					 sensor->chan);
 
@@ -1169,13 +1174,14 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
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
 	reinit_completion(&st->completion);
 	/* start conversion */
@@ -1191,7 +1197,7 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
 	time = wait_for_completion_timeout(&st->completion,
 					   msecs_to_jiffies(300));
 	if (!time) {
-		dev_warn(&st->spi->dev, "Conversion timed out\n");
+		dev_warn(dev, "Conversion timed out\n");
 		return -ETIMEDOUT;
 	}
 
@@ -1204,7 +1210,7 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
 	*val = __be32_to_cpu(st->temp);
 
 	if (!(LTC2983_RES_VALID_MASK & *val)) {
-		dev_err(&st->spi->dev, "Invalid conversion detected\n");
+		dev_err(dev, "Invalid conversion detected\n");
 		return -EIO;
 	}
 
@@ -1221,12 +1227,12 @@ static int ltc2983_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct ltc2983_data *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
 	int ret;
 
 	/* sanity check */
 	if (chan->address >= st->num_channels) {
-		dev_err(&st->spi->dev, "Invalid chan address:%ld",
-			chan->address);
+		dev_err(dev, "Invalid chan address:%ld", chan->address);
 		return -EINVAL;
 	}
 
@@ -1302,7 +1308,7 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 
 	st->num_channels = device_get_child_node_count(dev);
 	if (!st->num_channels)
-		return dev_err_probe(&st->spi->dev, -EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "At least one channel must be given!\n");
 
 	st->sensors = devm_kcalloc(dev, st->num_channels, sizeof(*st->sensors),
@@ -1390,6 +1396,7 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 			      unsigned int wait_time, unsigned int status_reg,
 			      unsigned long status_fail_mask)
 {
+	struct device *dev = &st->spi->dev;
 	unsigned long time;
 	unsigned int val;
 	int ret;
@@ -1409,7 +1416,7 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 	time = wait_for_completion_timeout(&st->completion,
 					   msecs_to_jiffies(wait_time));
 	if (!time)
-		return dev_err_probe(&st->spi->dev, -ETIMEDOUT,
+		return dev_err_probe(dev, -ETIMEDOUT,
 				     "EEPROM command timed out\n");
 
 	ret = regmap_read(st->regmap, status_reg, &val);
@@ -1417,7 +1424,7 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 		return ret;
 
 	if (val & status_fail_mask)
-		return dev_err_probe(&st->spi->dev, -EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "EEPROM command failed: 0x%02X\n", val);
 
 	return 0;
@@ -1426,6 +1433,7 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 {
 	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status;
+	struct device *dev = &st->spi->dev;
 	int ret;
 
 	/* make sure the device is up: start bit (7) is 0 and done bit (6) is 1 */
@@ -1433,8 +1441,7 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 				       LTC2983_STATUS_UP(status) == 1, 25000,
 				       25000 * 10);
 	if (ret)
-		return dev_err_probe(&st->spi->dev, ret,
-				     "Device startup timed out\n");
+		return dev_err_probe(dev, ret, "Device startup timed out\n");
 
 	ret = regmap_update_bits(st->regmap, LTC2983_GLOBAL_CONFIG_REG,
 				 LTC2983_NOTCH_FREQ_MASK,
@@ -1534,12 +1541,13 @@ static const struct  iio_info ltc2983_iio_info = {
 
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
 
@@ -1551,7 +1559,7 @@ static int ltc2983_probe(struct spi_device *spi)
 
 	st->regmap = devm_regmap_init_spi(spi, &ltc2983_regmap_config);
 	if (IS_ERR(st->regmap))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "Failed to initialize regmap\n");
 
 	mutex_init(&st->lock);
@@ -1564,11 +1572,11 @@ static int ltc2983_probe(struct spi_device *spi)
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
 
@@ -1578,7 +1586,7 @@ static int ltc2983_probe(struct spi_device *spi)
 		gpiod_set_value_cansleep(gpio, 0);
 	}
 
-	st->iio_chan = devm_kzalloc(&spi->dev,
+	st->iio_chan = devm_kzalloc(dev,
 				    st->iio_channels * sizeof(*st->iio_chan),
 				    GFP_KERNEL);
 	if (!st->iio_chan)
@@ -1588,11 +1596,10 @@ static int ltc2983_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_request_irq(&spi->dev, spi->irq, ltc2983_irq_handler,
+	ret = devm_request_irq(dev, spi->irq, ltc2983_irq_handler,
 			       IRQF_TRIGGER_RISING, st->info->name, st);
 	if (ret)
-		return dev_err_probe(&spi->dev, ret,
-				     "failed to request an irq\n");
+		return dev_err_probe(dev, ret, "failed to request an irq\n");
 
 	if (st->info->has_eeprom) {
 		ret = ltc2983_eeprom_cmd(st, LTC2983_EEPROM_WRITE_CMD,
@@ -1609,7 +1616,7 @@ static int ltc2983_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ltc2983_iio_info;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int ltc2983_resume(struct device *dev)
-- 
2.43.0

