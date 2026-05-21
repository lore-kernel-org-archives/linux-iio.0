Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9294C3815DE;
	Thu, 21 May 2026 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381917; cv=none; b=VmWZfQcOJIJn9BJ0q4Glb8TL+lUMwqK1MLWTC6yw2IQfnZCgv3tRhv2KiwBJNjPuJK1CnqMf7tGzoAD6v+IXbUYhqiRhZwLrlmI9GdlCA9LPkMGc4+uzbCcz5QWw7I5yR+8nN5Ty2mTXULMfHhAySZJuKAW0rHRsDZVwjzHEMF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381917; c=relaxed/simple;
	bh=+y1dMQgw5sfTwuvx9tWUOJaUdFHqEkRilOGlLWQGpZA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYeau1JkJzgCVPDY3DkT2+Z3Ob3kG0Sw9wUR0F87JeUUqtDOiDgbL9btYEFW9NvDZAjr99gmqzfjdFlqFfOjuhTnzDLryZDXrX5E1DcLuXVEgSLiF0NcyS+YFlACCv5/mnD10azQ7LumQxt6HH6IaboqzQ7Mut6Pxq8/oB5TR3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RHJHyPG7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RHJHyPG7"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LFG62B1703719;
	Thu, 21 May 2026 12:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=nY11L
	rQtq2f66/N9uimsjAX/hAOL/4gl9n415I6n+xY=; b=RHJHyPG78ubiK5hXS7egt
	Qv6/SGGEUa8J88W5ryDhukViD/UFyfC0FylHd7gamyhfFZkxAmdVBDj0UGqhhsVL
	btte6qlmJYlI+1oHWNxDKVdSS8dMxZ2fRXg2Ty9Q2MHiC+tnQYRJ4hXzopRuSLYa
	Y6cmUoqDDJHQLw29lnskPYOyniSzXaWxAsuPjFoefL/lXzUt8EOUzl+agfG8Raqd
	bbEOC+IfBdYcucAHWYVd0H490KTGwXAlBnBLf52gMq4iyJpSO1mF6g5DeqFLliJq
	UXZ+hpVq5QdqU6P7rFJqOhNBi+XAjig5CDFLzN+ZJStfVmm4TgqQGdA7bMU+FUFw
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e9701f2nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 12:45:12 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LGjBvN000348
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 May 2026 12:45:11 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 21 May
 2026 12:45:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 12:45:11 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.208])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LGim0n024538;
	Thu, 21 May 2026 12:45:05 -0400
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
Subject: [PATCH v3 3/8] iio: temperature: ltc2983: Fix inconsistent channel wording in messages
Date: Thu, 21 May 2026 19:42:56 +0300
Message-ID: <20260521164323.770626-4-liviu.stan@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE2OCBTYWx0ZWRfX9qdx5wWNeOr3
 0Lth1U3DhdNE0RWAVmVu3ZjR9coTI3gTWn+bjJor5K1Owz+z+LzjIGTmXW2cugNoM/IdXPayES2
 SEbAKkuQw5WENbzFwWSB5sDmEzwin8ph9N+ge6x76Z8RaDT4LdhYc91/q/eAWfrNASo4Q1WDOa6
 I+usoZ6xmyhKQH8aPjSc0nVBtaupL4qhKz6v2cbZPyaUWBPVZ6IKGVPajPHuCbsssPMv0Hl1wvf
 gy5mCpc1sdwxJVzhrfsvJtUJKHpg/5L+YCl43h34yGOZgUJTmH01F+cliqXfx2eBH15fXDhzWXZ
 K8MZdsKJJ51/kmWgoIDyxB+Uq+SsHXE+DSGJvMLD03kZrhtJMMWkctL4VLQiKBlo9ae9Q3RtXrw
 F6bprSgPGjL/hwyeaj+5qT6Wh356+Nl9i9tD/F3llbYnOIsNhuGfD2iQ+58FidvF9dHxd8YQTl3
 C7zrKG3BotwgJQd124w==
X-Authority-Analysis: v=2.4 cv=CsaPtH4D c=1 sm=1 tr=0 ts=6a0f3698 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=AdEO_u_nCXX3MimJr_gA:9
X-Proofpoint-ORIG-GUID: nqNynNkcuLnRDn3Uaw2e_3XXNNqwUyx5
X-Proofpoint-GUID: nqNynNkcuLnRDn3Uaw2e_3XXNNqwUyx5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210168

Replace occurrences of the abbreviated 'chann' and 'chan' with
'channel' in error and debug messages throughout the driver.
Also changed the diode invalid channel error message from
"thermistor" to "diode".

Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v3:
- Dropped both Fixes: tags
- Removed the "all" from "all occurrences" in the commit message
- Fixed some missed "chan" / "chann" occurrences

 drivers/iio/temperature/ltc2983.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index d9dcf3e86696..0b9e5f761bd8 100644
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
+					 "Invalid channel %d for differential diode\n",
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
@@ -1332,14 +1332,14 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 		if (sensor.chan < LTC2983_MIN_CHANNELS_NR ||
 		    sensor.chan > st->info->max_channels_nr)
 			return dev_err_probe(dev, -EINVAL,
-					     "chan:%d must be from %u to %u\n",
+					     "channel:%d must be from %u to %u\n",
 					     sensor.chan,
 					     LTC2983_MIN_CHANNELS_NR,
 					     st->info->max_channels_nr);
 
 		if (channel_avail_mask & BIT(sensor.chan))
 			return dev_err_probe(dev, -EINVAL,
-					     "chan:%d already in use\n",
+					     "channel:%d already in use\n",
 					     sensor.chan);
 
 		ret = fwnode_property_read_u32(child, "adi,sensor-type", &sensor.type);
@@ -1347,7 +1347,7 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 			return dev_err_probe(dev, ret,
 				"adi,sensor-type property must given for child nodes\n");
 
-		dev_dbg(dev, "Create new sensor, type %u, chann %u",
+		dev_dbg(dev, "Create new sensor, type %u, channel %u",
 			sensor.type, sensor.chan);
 
 		if (sensor.type >= LTC2983_SENSOR_THERMOCOUPLE &&
-- 
2.43.0

