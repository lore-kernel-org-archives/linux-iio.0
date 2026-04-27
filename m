Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2333C6A56;
	Mon, 27 Apr 2026 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296589; cv=none; b=Dvh8JcEqIjnrRBZtba5Jrz6ajLP/Ub5W1HXpbu2qQBLSNSAps9DTGYVyDPWEvCwD47ANfz6zFY6Bw+OfWhZFGyo70ppqSAyYEDLsEo8GZ7BdXZjqIKf6/S3knuZT2obik3MmkieEmnA/GDk/7mmpNFNJNOjODcFG1gdyKltpdyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296589; c=relaxed/simple;
	bh=McutZREPQMA0xD4Jncn+JADfm18wl1qOIZ9MZxxebxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhPnIGb0Abh7bpqFB66VB7x6O4hpMLeFkJf0DcnoIvdp0K0rAURYrhHSuiNKWpZhITlNJ/hVOLJ0GtbmD0lzPKvJmPwRs4aCTbr5LjHmewrmHaZeYIUzjfDbIreWRkA2+BwgHA6cDfSXw4xLsNnTZl/a5NApvlIAIkoHKxwdsqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vJzEH1Ob; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vJzEH1Ob"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RCVlFs2339258;
	Mon, 27 Apr 2026 09:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Vq14m
	5onGQbWtHsY2qRgr8z/Av2kkXPTYDHa5z2xwIk=; b=vJzEH1OblHrABmMQyFUCM
	8QtAeWUhKtaeVvI1dKMm3OOxUsP4OLAAfmM9EcEOp1eSITGXWHwbGZXuEyiN6pPk
	aDUAbCNl1ktbw2q6mofzfqnbTarLHEF/YZEthP1PJrAdXKmsufisbg/tgW0evep6
	cetezBQnWdOJWvcAgT6zMBQQ53W83rnN3iB+KlWfZ55Sl+OQUpl97IydgWI43JYw
	EVLe6US3C5yNfE5drCogOZmdWRj4dNqP895r3/8v6xkDyOozJ5GTbglZSX5hlQqY
	4h/l/j3QfByChESRLvjYJubEZgBmWb0fUEfmDYa4OzfWzdBV/etJtW3hxnBV87oz
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dsbxcvnya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 09:29:32 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 63RDTVd4003151
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Apr 2026 09:29:31 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 27 Apr
 2026 09:29:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 27 Apr 2026 09:29:30 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.107])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 63RDT8SS028079;
	Mon, 27 Apr 2026 09:29:24 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Liviu Stan <liviu.stan@analog.com>
Subject: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Date: Mon, 27 Apr 2026 16:25:08 +0300
Message-ID: <20260427132526.272716-3-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427132526.272716-1-liviu.stan@analog.com>
References: <20260427132526.272716-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE0NCBTYWx0ZWRfX7N1d6O1bMr2r
 Tl0uPS4bSnDi2Sh6d5lY4Gj31JIbmNPPzSzI0ErZiZ/obBcuOkENEzmlSmPcJeqSjSIAXXwuUO/
 9/O/QrQRRzbs399Ek7qZIxHFr567dw59dQLSTz0H+Ltpfh8pESrhPwKl+X0ISCyjob/xJ3RT9G3
 IUIApJM4GcoRveXRH+FtzbSO2UnM3ka7UT6WotqLulJVNzfXRyHnfWcXNq4ZI841kEzOE1zD1LR
 axp/T0TqzB6sdARB92yG4/eBv1kfu1WdoPi6lUftZDESAyIWeVX8c4r4WUuY7jZHpgaQ+9f8Wav
 jp76qV4bb8xp1jVdkAfQBpJB+yVfOM6f888HQ89tqcKyTO4jmKiY6wB+4KJCQvI5NPx4Vd7aP9e
 sIXk+b+apdCEAKIpZfztGY9/8j/oJ/4X7ib7vOET0yJShFEwpsxv85XRvuk+Dz7VXo21b7J7OUI
 jD56XOAvYlKkgCHSkgw==
X-Proofpoint-GUID: i6qMn2CqtCGufRU1M1b_4AhmU3T7bniw
X-Authority-Analysis: v=2.4 cv=SbjHsPRu c=1 sm=1 tr=0 ts=69ef64bc cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=bP_FyP252IjlB4FLv3kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: i6qMn2CqtCGufRU1M1b_4AhmU3T7bniw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270144

The ADT7604 shares the same die as the LTC2984. It repurposes the
custom RTD sensor type (18) as a copper trace resistance sensor
and the custom thermistor type (27) as a leak detector, and
removes thermocouple, diode and direct ADC sensor types.

Custom RTD (type 18) becomes the copper trace sensor. Sensor
configuration bits 21:18 are hardcoded to 0b1001 per the
datasheet. Two variants are supported via the new
adi,copper-trace-sub-ohm DT property: sub-ohm traces (< 1 ohm)
have bits 17:0 cleared with no excitation current or custom
table; standard traces (> 1 ohm) accept an optional
resistance-to-temperature table.

Custom thermistor (type 27) becomes the leak detector. Sensor
configuration bits are hardcoded to 0b001. The custom table
uses a resolution of 16 (20+4 bit resistance field) instead of
64, and is specified via the new adi,custom-leak-detector DT
property.

Both sensor types expose an IIO_RESISTANCE channel reading from
the resistance result register bank (0x060-0x00AF), added to
the regmap readable ranges. Scales are 1/1,024,000 for copper
trace (result in mOhm) and 1/1024 for leak detector (result
in Ohm).

A has_copper_trace capability flag is introduced in
ltc2983_chip_info to identify the ADT7604, following the
existing has_temp and has_eeprom pattern.

Tested on EVAL-ADT7604-AZ connected to Raspberry Pi 5 via SPI.

Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 347 +++++++++++++++++++++---------
 1 file changed, 251 insertions(+), 96 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 38e6f8dfd3b8..1966f6fb0305 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -28,6 +28,8 @@
 #define LTC2983_STATUS_REG			0x0000
 #define LTC2983_TEMP_RES_START_REG		0x0010
 #define LTC2983_TEMP_RES_END_REG		0x005F
+#define ADT7604_RES_RES_START_REG		0x0060
+#define ADT7604_RES_RES_END_REG			0x00AF
 #define LTC2983_EEPROM_KEY_REG			0x00B0
 #define LTC2983_EEPROM_READ_STATUS_REG		0x00D0
 #define LTC2983_GLOBAL_CONFIG_REG		0x00F0
@@ -58,8 +60,8 @@
 
 #define LTC2983_CHAN_START_ADDR(chan) \
 			(((chan - 1) * 4) + LTC2983_CHAN_ASSIGN_START_REG)
-#define LTC2983_CHAN_RES_ADDR(chan) \
-			(((chan - 1) * 4) + LTC2983_TEMP_RES_START_REG)
+#define LTC2983_CHAN_RES_ADDR(chan, base) \
+			((((chan) - 1) * 4) + (base))
 #define LTC2983_THERMOCOUPLE_DIFF_MASK		BIT(3)
 #define LTC2983_THERMOCOUPLE_SGL(x) \
 				FIELD_PREP(LTC2983_THERMOCOUPLE_DIFF_MASK, x)
@@ -214,6 +216,7 @@ struct ltc2983_chip_info {
 	unsigned int max_channels_nr;
 	bool has_temp;
 	bool has_eeprom;
+	bool has_copper_trace;
 };
 
 struct ltc2983_data {
@@ -272,6 +275,7 @@ struct ltc2983_rtd {
 	u32 r_sense_chan;
 	u32 excitation_current;
 	u32 rtd_curve;
+	bool sub_ohm;
 };
 
 struct ltc2983_thermistor {
@@ -575,6 +579,10 @@ static int ltc2983_rtd_assign_chan(struct ltc2983_data *st,
 		if (ret)
 			return ret;
 	}
+
+	if (rtd->sub_ohm)
+		chan_val &= ~GENMASK(17, 0);
+
 	return __ltc2983_chan_assign_common(st, sensor, chan_val);
 }
 
@@ -758,83 +766,113 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 		return dev_err_ptr_probe(dev, ret,
 					 "Property reg must be given\n");
 
-	ret = fwnode_property_read_u32(child, "adi,number-of-wires", &n_wires);
-	if (!ret) {
-		switch (n_wires) {
-		case 2:
-			rtd->sensor_config = LTC2983_RTD_N_WIRES(0);
-			break;
-		case 3:
-			rtd->sensor_config = LTC2983_RTD_N_WIRES(1);
-			break;
-		case 4:
-			rtd->sensor_config = LTC2983_RTD_N_WIRES(2);
-			break;
-		case 5:
-			/* 4 wires, Kelvin Rsense */
-			rtd->sensor_config = LTC2983_RTD_N_WIRES(3);
-			break;
-		default:
+	/* ADT7604 requires hardcoding sensor configuration bits to 0b1001 */
+	if (st->info->has_copper_trace &&
+	    sensor->type == LTC2983_SENSOR_RTD_CUSTOM) {
+		rtd->sensor_config = 0x9;
+		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
 			return dev_err_ptr_probe(dev, -EINVAL,
-						 "Invalid number of wires:%u\n",
-						 n_wires);
+						 "Invalid chann:%d for copper trace\n",
+						 sensor->chan);
+	} else {
+		ret = fwnode_property_read_u32(child, "adi,number-of-wires", &n_wires);
+		if (!ret) {
+			switch (n_wires) {
+			case 2:
+				rtd->sensor_config = LTC2983_RTD_N_WIRES(0);
+				break;
+			case 3:
+				rtd->sensor_config = LTC2983_RTD_N_WIRES(1);
+				break;
+			case 4:
+				rtd->sensor_config = LTC2983_RTD_N_WIRES(2);
+				break;
+			case 5:
+				/* 4 wires, Kelvin Rsense */
+				rtd->sensor_config = LTC2983_RTD_N_WIRES(3);
+				break;
+			default:
+				return dev_err_ptr_probe(dev, -EINVAL,
+							 "Invalid number of wires:%u\n",
+							 n_wires);
+			}
 		}
-	}
 
-	if (fwnode_property_read_bool(child, "adi,rsense-share")) {
-		/* Current rotation is only available with rsense sharing */
-		if (fwnode_property_read_bool(child, "adi,current-rotate")) {
-			if (n_wires == 2 || n_wires == 3)
+		if (fwnode_property_read_bool(child, "adi,rsense-share")) {
+			/* Current rotation is only available with rsense sharing */
+			if (fwnode_property_read_bool(child, "adi,current-rotate")) {
+				if (n_wires == 2 || n_wires == 3)
+					return dev_err_ptr_probe(dev, -EINVAL,
+								 "Rotation not allowed for 2/3 Wire RTDs\n");
+
+				rtd->sensor_config |= LTC2983_RTD_C_ROTATE(1);
+			} else {
+				rtd->sensor_config |= LTC2983_RTD_R_SHARE(1);
+			}
+		}
+		/*
+		 * rtd channel indexes are a bit more complicated to validate.
+		 * For 4wire RTD with rotation, the channel selection cannot be
+		 * >=19 since the chann + 1 is used in this configuration.
+		 * For 4wire RTDs with kelvin rsense, the rsense channel cannot be
+		 * <=1 since chanel - 1 and channel - 2 are used.
+		 */
+		if (rtd->sensor_config & LTC2983_RTD_4_WIRE_MASK) {
+			/* 4-wire */
+			u8 min = LTC2983_DIFFERENTIAL_CHAN_MIN,
+				max = st->info->max_channels_nr;
+
+			if (rtd->sensor_config & LTC2983_RTD_ROTATION_MASK)
+				max = st->info->max_channels_nr - 1;
+
+			if ((rtd->sensor_config & LTC2983_RTD_KELVIN_R_SENSE_MASK)
+			     == LTC2983_RTD_KELVIN_R_SENSE_MASK &&
+			    rtd->r_sense_chan <= min)
+				/* kelvin rsense*/
 				return dev_err_ptr_probe(dev, -EINVAL,
-							 "Rotation not allowed for 2/3 Wire RTDs\n");
+							 "Invalid rsense chann:%d to use in kelvin rsense\n",
+							 rtd->r_sense_chan);
 
-			rtd->sensor_config |= LTC2983_RTD_C_ROTATE(1);
+			if (sensor->chan < min || sensor->chan > max)
+				return dev_err_ptr_probe(dev, -EINVAL,
+							 "Invalid chann:%d for the rtd config\n",
+							 sensor->chan);
 		} else {
-			rtd->sensor_config |= LTC2983_RTD_R_SHARE(1);
+			/* same as differential case */
+			if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+				return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
+							 "Invalid chann:%d for RTD\n",
+							 sensor->chan);
 		}
 	}
-	/*
-	 * rtd channel indexes are a bit more complicated to validate.
-	 * For 4wire RTD with rotation, the channel selection cannot be
-	 * >=19 since the chann + 1 is used in this configuration.
-	 * For 4wire RTDs with kelvin rsense, the rsense channel cannot be
-	 * <=1 since channel - 1 and channel - 2 are used.
-	 */
-	if (rtd->sensor_config & LTC2983_RTD_4_WIRE_MASK) {
-		/* 4-wire */
-		u8 min = LTC2983_DIFFERENTIAL_CHAN_MIN,
-			max = st->info->max_channels_nr;
-
-		if (rtd->sensor_config & LTC2983_RTD_ROTATION_MASK)
-			max = st->info->max_channels_nr - 1;
-
-		if (((rtd->sensor_config & LTC2983_RTD_KELVIN_R_SENSE_MASK)
-		     == LTC2983_RTD_KELVIN_R_SENSE_MASK) &&
-		    (rtd->r_sense_chan <=  min))
-			/* kelvin rsense*/
-			return dev_err_ptr_probe(dev, -EINVAL,
-						 "Invalid rsense chann:%d to use in kelvin rsense\n",
-						 rtd->r_sense_chan);
-
-		if (sensor->chan < min || sensor->chan > max)
-			return dev_err_ptr_probe(dev, -EINVAL,
-						 "Invalid chann:%d for the rtd config\n",
-						 sensor->chan);
-	} else {
-		/* same as differential case */
-		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
-			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,
-						 "Invalid chann:%d for RTD\n",
-						 sensor->chan);
-	}
 
 	/* check custom sensor */
 	if (sensor->type == LTC2983_SENSOR_RTD_CUSTOM) {
-		rtd->custom = __ltc2983_custom_sensor_new(st, child,
-							  "adi,custom-rtd",
-							  false, 2048, false);
-		if (IS_ERR(rtd->custom))
-			return ERR_CAST(rtd->custom);
+		if (st->info->has_copper_trace) {
+			if (fwnode_property_present(child, "adi,custom-rtd")) {
+				rtd->custom = __ltc2983_custom_sensor_new(st, child,
+									  "adi,custom-rtd",
+									  false, 2048,
+									  false);
+				if (IS_ERR(rtd->custom))
+					return ERR_CAST(rtd->custom);
+			}
+		} else {
+			rtd->custom = __ltc2983_custom_sensor_new(st, child,
+								  "adi,custom-rtd",
+								  false, 2048, false);
+			if (IS_ERR(rtd->custom))
+				return ERR_CAST(rtd->custom);
+		}
+	}
+
+	if (st->info->has_copper_trace &&
+	    sensor->type == LTC2983_SENSOR_RTD_CUSTOM) {
+		rtd->sub_ohm = fwnode_property_read_bool(child,
+							 "adi,copper-trace-sub-ohm");
+		if (rtd->sub_ohm && rtd->custom)
+			return dev_err_ptr_probe(dev, -EINVAL,
+						 "sub-ohm copper trace cannot have a custom table\n");
 	}
 
 	/* set common parameters */
@@ -908,17 +946,27 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 		return dev_err_ptr_probe(dev, ret,
 					 "rsense channel must be configured...\n");
 
-	if (fwnode_property_read_bool(child, "adi,single-ended")) {
-		thermistor->sensor_config = LTC2983_THERMISTOR_SGL(1);
-	} else if (fwnode_property_read_bool(child, "adi,rsense-share")) {
-		/* rotation is only possible if sharing rsense */
-		if (fwnode_property_read_bool(child, "adi,current-rotate"))
-			thermistor->sensor_config =
-						LTC2983_THERMISTOR_C_ROTATE(1);
-		else
-			thermistor->sensor_config =
-						LTC2983_THERMISTOR_R_SHARE(1);
+	if (st->info->has_copper_trace &&
+	    sensor->type == LTC2983_SENSOR_THERMISTOR_CUSTOM) {
+		thermistor->sensor_config = LTC2983_THERMISTOR_C_ROTATE(1);
+		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+			return dev_err_ptr_probe(dev, -EINVAL,
+						 "Invalid chann:%d for leak detector\n",
+						 sensor->chan);
+	} else {
+		if (fwnode_property_read_bool(child, "adi,single-ended")) {
+			thermistor->sensor_config = LTC2983_THERMISTOR_SGL(1);
+		} else if (fwnode_property_read_bool(child, "adi,rsense-share")) {
+			/* rotation is only possible if sharing rsense */
+			if (fwnode_property_read_bool(child, "adi,current-rotate"))
+				thermistor->sensor_config =
+							LTC2983_THERMISTOR_C_ROTATE(1);
+			else
+				thermistor->sensor_config =
+							LTC2983_THERMISTOR_R_SHARE(1);
+		}
 	}
+
 	/* validate channel index */
 	if (!(thermistor->sensor_config & LTC2983_THERMISTOR_DIFF_MASK) &&
 	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
@@ -928,23 +976,36 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 
 	/* check custom sensor */
 	if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART) {
-		bool steinhart = false;
-		const char *propname;
-
-		if (sensor->type == LTC2983_SENSOR_THERMISTOR_STEINHART) {
-			steinhart = true;
-			propname = "adi,custom-steinhart";
+		if (st->info->has_copper_trace &&
+		    sensor->type == LTC2983_SENSOR_THERMISTOR_CUSTOM) {
+			if (fwnode_property_present(child, "adi,custom-leak-detector")) {
+				thermistor->custom =
+					__ltc2983_custom_sensor_new(st, child,
+								    "adi,custom-leak-detector",
+								    false, 16, false);
+				if (IS_ERR(thermistor->custom))
+					return ERR_CAST(thermistor->custom);
+			}
 		} else {
-			propname = "adi,custom-thermistor";
+			bool steinhart = false;
+			const char *propname;
+
+			if (sensor->type == LTC2983_SENSOR_THERMISTOR_STEINHART) {
+				steinhart = true;
+				propname = "adi,custom-steinhart";
+			} else {
+				propname = "adi,custom-thermistor";
+			}
+
+			thermistor->custom = __ltc2983_custom_sensor_new(st, child,
+									 propname,
+									 steinhart,
+									 64, false);
+			if (IS_ERR(thermistor->custom))
+				return ERR_CAST(thermistor->custom);
 		}
-
-		thermistor->custom = __ltc2983_custom_sensor_new(st, child,
-								 propname,
-								 steinhart,
-								 64, false);
-		if (IS_ERR(thermistor->custom))
-			return ERR_CAST(thermistor->custom);
 	}
+
 	/* set common parameters */
 	thermistor->sensor.fault_handler = ltc2983_common_fault_handler;
 	thermistor->sensor.assign_chan = ltc2983_thermistor_assign_chan;
@@ -1167,7 +1228,8 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
 }
 
 static int ltc2983_chan_read(struct ltc2983_data *st,
-			const struct ltc2983_sensor *sensor, int *val)
+			const struct ltc2983_sensor *sensor,
+			u32 base_reg, int *val)
 {
 	u32 start_conversion = 0;
 	int ret;
@@ -1197,13 +1259,23 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
 	}
 
 	/* read the converted data */
-	ret = regmap_bulk_read(st->regmap, LTC2983_CHAN_RES_ADDR(sensor->chan),
+	ret = regmap_bulk_read(st->regmap, LTC2983_CHAN_RES_ADDR(sensor->chan, base_reg),
 			       &st->temp, sizeof(st->temp));
 	if (ret)
 		return ret;
 
 	*val = __be32_to_cpu(st->temp);
 
+	if (base_reg == ADT7604_RES_RES_START_REG) {
+		/*
+		 * Resistance result register gives a plain unsigned value,
+		 * D31 is always 0, no valid bit, no fault bits. Read bits[30:0]
+		 * directly — the temperature result format does not apply here.
+		 */
+		*val &= GENMASK(30, 0);
+		return 0;
+	}
+
 	if (!(LTC2983_RES_VALID_MASK & *val)) {
 		dev_err(&st->spi->dev, "Invalid conversion detected\n");
 		return -EIO;
@@ -1214,6 +1286,7 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
 		return ret;
 
 	*val = sign_extend32((*val) & LTC2983_DATA_MASK, LTC2983_DATA_SIGN_BIT);
+
 	return 0;
 }
 
@@ -1234,7 +1307,12 @@ static int ltc2983_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&st->lock);
-		ret = ltc2983_chan_read(st, st->sensors[chan->address], val);
+		if (chan->type == IIO_RESISTANCE)
+			ret = ltc2983_chan_read(st, st->sensors[chan->address],
+						ADT7604_RES_RES_START_REG, val);
+		else
+			ret = ltc2983_chan_read(st, st->sensors[chan->address],
+						LTC2983_TEMP_RES_START_REG, val);
 		mutex_unlock(&st->lock);
 		return ret ?: IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
@@ -1251,6 +1329,18 @@ static int ltc2983_read_raw(struct iio_dev *indio_dev,
 			/* 2^21 */
 			*val2 = 2097152;
 			return IIO_VAL_FRACTIONAL;
+		case IIO_RESISTANCE:
+			/* value in ohm */
+			*val = 1;
+			/*
+			 * Copper trace result is in milliohm with 10 fractional
+			 * bits: divide by 2^10 * 1000 = 1024000.
+			 * Leak detector result is in ohm with 10 fractional
+			 * bits: divide by 2^10 = 1024.
+			 */
+			*val2 = (st->sensors[chan->address]->type == LTC2983_SENSOR_RTD_CUSTOM) ?
+				1024000 : 1024;
+			return IIO_VAL_FRACTIONAL;
 		default:
 			return -EINVAL;
 		}
@@ -1292,6 +1382,17 @@ static irqreturn_t ltc2983_irq_handler(int irq, void *data)
 	__chan; \
 })
 
+#define LTC2983_RESISTANCE_CHAN(index, __address) ({ \
+	struct iio_chan_spec __chan = { \
+		.type = IIO_RESISTANCE, \
+		.indexed = 1, \
+		.channel = index, \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE), \
+		.address = __address, \
+	}; \
+	__chan; \
+})
+
 static int ltc2983_parse_fw(struct ltc2983_data *st)
 {
 	struct device *dev = &st->spi->dev;
@@ -1339,6 +1440,16 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 			return dev_err_probe(dev, ret,
 				"adi,sensor-type property must given for child nodes\n");
 
+		if (st->info->has_copper_trace) {
+			if ((sensor.type >= LTC2983_SENSOR_THERMOCOUPLE &&
+			     sensor.type <= LTC2983_SENSOR_THERMOCOUPLE_CUSTOM) ||
+			     sensor.type == LTC2983_SENSOR_DIODE ||
+			     sensor.type == LTC2983_SENSOR_DIRECT_ADC)
+				return dev_err_probe(dev, -EINVAL,
+			 "sensor type %d not supported on %s\n",
+			 sensor.type, st->info->name);
+		}
+
 		dev_dbg(dev, "Create new sensor, type %u, chann %u",
 			sensor.type, sensor.chan);
 
@@ -1380,6 +1491,15 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 		st->sensors[chan]->chan = sensor.chan;
 		st->sensors[chan]->type = sensor.type;
 
+		if (st->info->has_copper_trace) {
+			if (st->sensors[chan]->type == LTC2983_SENSOR_THERMISTOR_CUSTOM &&
+			    to_thermistor(st->sensors[chan])->custom)
+				st->iio_channels++;
+			else if (st->sensors[chan]->type == LTC2983_SENSOR_RTD_CUSTOM &&
+				 to_rtd(st->sensors[chan])->custom)
+				st->iio_channels++;
+		}
+
 		channel_avail_mask |= BIT(sensor.chan);
 		chan++;
 	}
@@ -1426,7 +1546,7 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 
 static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 {
-	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status;
+	u32 iio_chan_t = 0, iio_chan_v = 0, iio_chan_r = 0, chan, iio_idx = 0, status;
 	int ret;
 
 	/* make sure the device is up: start bit (7) is 0 and done bit (6) is 1 */
@@ -1473,6 +1593,26 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 		    !assign_iio)
 			continue;
 
+		/*
+		 * Copper trace and leak detector sensors without a custom table
+		 * produce only a resistance result; the chip does not populate
+		 * the temperature result register. Emit only an IIO_RESISTANCE
+		 * channel in this case.
+		 */
+		if (st->info->has_copper_trace) {
+			bool resistance_only =
+				(st->sensors[chan]->type == LTC2983_SENSOR_RTD_CUSTOM &&
+				 !to_rtd(st->sensors[chan])->custom) ||
+				(st->sensors[chan]->type == LTC2983_SENSOR_THERMISTOR_CUSTOM &&
+				 !to_thermistor(st->sensors[chan])->custom);
+
+			if (resistance_only) {
+				st->iio_chan[iio_idx++] =
+					LTC2983_RESISTANCE_CHAN(iio_chan_r++, chan);
+				continue;
+			}
+		}
+
 		/* assign iio channel */
 		if (st->sensors[chan]->type != LTC2983_SENSOR_DIRECT_ADC) {
 			chan_type = IIO_TEMP;
@@ -1488,6 +1628,11 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 		 */
 		st->iio_chan[iio_idx++] = LTC2983_CHAN(chan_type, (*iio_chan)++,
 						       chan);
+
+		if (st->info->has_copper_trace &&
+		    (st->sensors[chan]->type == LTC2983_SENSOR_RTD_CUSTOM ||
+		     st->sensors[chan]->type == LTC2983_SENSOR_THERMISTOR_CUSTOM))
+			st->iio_chan[iio_idx++] = LTC2983_RESISTANCE_CHAN(iio_chan_r++, chan);
 	}
 
 	return 0;
@@ -1496,6 +1641,7 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 static const struct regmap_range ltc2983_reg_ranges[] = {
 	regmap_reg_range(LTC2983_STATUS_REG, LTC2983_STATUS_REG),
 	regmap_reg_range(LTC2983_TEMP_RES_START_REG, LTC2983_TEMP_RES_END_REG),
+	regmap_reg_range(ADT7604_RES_RES_START_REG, ADT7604_RES_RES_END_REG),
 	regmap_reg_range(LTC2983_EEPROM_KEY_REG, LTC2983_EEPROM_KEY_REG),
 	regmap_reg_range(LTC2983_EEPROM_READ_STATUS_REG,
 			 LTC2983_EEPROM_READ_STATUS_REG),
@@ -1659,11 +1805,19 @@ static const struct ltc2983_chip_info ltm2985_chip_info_data = {
 	.has_eeprom = true,
 };
 
+static const struct ltc2983_chip_info adt7604_chip_info_data = {
+	.name = "adt7604",
+	.max_channels_nr = 20,
+	.has_eeprom = true,
+	.has_copper_trace = true,
+};
+
 static const struct spi_device_id ltc2983_id_table[] = {
 	{ "ltc2983", (kernel_ulong_t)&ltc2983_chip_info_data },
 	{ "ltc2984", (kernel_ulong_t)&ltc2984_chip_info_data },
 	{ "ltc2986", (kernel_ulong_t)&ltc2986_chip_info_data },
 	{ "ltm2985", (kernel_ulong_t)&ltm2985_chip_info_data },
+	{ "adt7604", (kernel_ulong_t)&adt7604_chip_info_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ltc2983_id_table);
@@ -1673,6 +1827,7 @@ static const struct of_device_id ltc2983_of_match[] = {
 	{ .compatible = "adi,ltc2984", .data = &ltc2984_chip_info_data },
 	{ .compatible = "adi,ltc2986", .data = &ltc2986_chip_info_data },
 	{ .compatible = "adi,ltm2985", .data = &ltm2985_chip_info_data },
+	{ .compatible = "adi,adt7604", .data = &adt7604_chip_info_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2983_of_match);
-- 
2.43.0

