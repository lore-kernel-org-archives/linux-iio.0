Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA9F3F54CC;
	Mon, 25 May 2026 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727302; cv=none; b=qCZqa8AXkac2A9YppWk0bED8szRZRiVBzw8+aEOd2+hRRjT8HvZO1coUD73miaRgrVUW1hHbn2SRKJ+TZZ/VZUMnyffVvBR/AVzpfQR/M7bgRvmQVf3HRzWlOGPhhrZpS7/jTjWgPI4o+ACjIu6zIxwNEZs6unP5F6/SGf0pHDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727302; c=relaxed/simple;
	bh=jVRk4v/HEYaMRwQzQJdbJXitSJIzy2V79PnAvS73wcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bL45IoCP0601eQmNrFo5GlguINKsLt+pyjyXIWkwHgIMBo6zIByxQEaIA/bigD9RGtRoJQsOgVU/q3G2YOUsgcIUXJkYDF6KOtR6H2Xy1ZB4w0n7Bd37diHCsg5x+wt6DUF71JIzABJAyWBeBiP8sqfH/MwWcCtOW+BCiIAXmZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=e23yUl64; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="e23yUl64"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PAiY0C2477671;
	Mon, 25 May 2026 12:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=140iH
	kuUvVj0oOJXbJo0HxFLGcdbV/GVziW5p2fkL7s=; b=e23yUl64aEKNmC1gTy9iR
	6uxacWhXKu2B515+Ug8zta9abQKfrU3W/suiqLEGxx8toIA4Y3aEk6GP4Mdv4LNw
	na9v7Sgp5LZ7tEUA9U8qN6NmyYAVzpjtqorBaEeF7+B3uX3YFrpHTPL6v66gQNSC
	xX9lzcGTvA9N1WwKVLayHPvgiaKCpzoTVXpKV/epfEzC1se4krz4RudSOmZgWYZO
	AdEvvJQAjoWV5iVhmYsrWw4Yk6WHgpnr7G+oKmGXa5tqYAZuRu0h/Coiagu48Ha+
	mKYwJ/PRtDwY2NDE7HJX8kHBzmXtIyPTRKCvDrF18e3D9XJTpvACs1zHn/cBGYC1
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ecbgqawh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 12:41:37 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64PGfa6J022301
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 May 2026 12:41:36 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 25 May 2026 12:41:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 25 May 2026 12:41:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 25 May 2026 12:41:36 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com ([10.32.226.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64PGevH4028845;
	Mon, 25 May 2026 12:41:31 -0400
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
Subject: [PATCH v4 5/9] iio: temperature: ltc2983: Fix inconsistent channel wording in messages
Date: Mon, 25 May 2026 19:39:32 +0300
Message-ID: <20260525164013.118614-6-liviu.stan@analog.com>
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
X-Proofpoint-GUID: ZkzHj8A3TdH6tsyIaDgs8JEuE8PK6Ciq
X-Authority-Analysis: v=2.4 cv=N5cZ0W9B c=1 sm=1 tr=0 ts=6a147bc1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8
 a=AdEO_u_nCXX3MimJr_gA:9
X-Proofpoint-ORIG-GUID: ZkzHj8A3TdH6tsyIaDgs8JEuE8PK6Ciq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE2OCBTYWx0ZWRfX6AQN7sVWbXRa
 ttHfpYWFXQdmwvPF2266cEJqUdsJDihSWS/TUK0GHuO7iPN/lBvfHjOn7jlvMO5om6HU9m1d0/1
 dCYH6RZeaLXb9g6vs1WejUj5UIx6iqpLsEDHS+QHYhjhvvaZJXYX4S4z7WRWOAJVJN6u28IuY8l
 rZHnCtZ1pFCT3xlKWO0jwBvb8mgTvw/M+czM3/zvbiB2106x/EfVRDJjoGq3Q5tyiEfqQcMJwNH
 U113/RQnk+7FaAopWIJXWzYpe/KArtkgYTyYhArn91JrjpfTH0GUFuRJ+XTi8SfHmim6lsnzfma
 6Tyv20vm5qBAfXNPDUsQjbhtC3h8gt+sXJEbDPhzXdo0NuwrvglxGpd1LbAxzrux6cADTFZE24q
 Uc0kLKfpNNhwDw4Jj3ZJt6T4XTC1/2qjfU97M5QLQiJ5cA6qit6DdlwXLm/rxaU6agR4IRt+iFe
 Jcpo1HwvHcnH8C/1imQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1011 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250168

Replace occurrences of the abbreviated 'chann' and 'chan' with
'channel' in error and debug messages throughout the driver.
Also changed the diode invalid channel error message from
"thermistor" to "diode".

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v4:
- Added Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

 drivers/iio/temperature/ltc2983.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 8b0b6b4884f6..fc904c0a42b4 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -699,7 +699,7 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 	if (!(thermo->sensor_config & LTC2983_THERMOCOUPLE_DIFF_MASK) &&
 	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
 		return dev_err_ptr_probe(dev, -EINVAL,
-					 "Invalid chann:%d for differential thermocouple\n",
+					 "Invalid channel %d for differential thermocouple\n",
 					 sensor->chan);
 
 	struct fwnode_handle *ref __free(fwnode_handle) =
@@ -797,7 +797,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 	/*
 	 * rtd channel indexes are a bit more complicated to validate.
 	 * For 4wire RTD with rotation, the channel selection cannot be
-	 * >=19 since the chann + 1 is used in this configuration.
+	 * >=19 since the channel + 1 is used in this configuration.
 	 * For 4wire RTDs with kelvin rsense, the rsense channel cannot be
 	 * <=1 since channel - 1 and channel - 2 are used.
 	 */
@@ -814,18 +814,18 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
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
 
@@ -924,7 +924,7 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 	if (!(thermistor->sensor_config & LTC2983_THERMISTOR_DIFF_MASK) &&
 	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
 		return dev_err_ptr_probe(dev, -EINVAL,
-					 "Invalid chann:%d for differential thermistor\n",
+					 "Invalid channel %d for differential thermistor\n",
 					 sensor->chan);
 
 	/* check custom sensor */
@@ -1039,7 +1039,7 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
 	if (!(diode->sensor_config & LTC2983_DIODE_DIFF_MASK) &&
 	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
 		return dev_err_ptr_probe(dev, -EINVAL,
-					 "Invalid chann:%d for differential thermistor\n",
+					 "Invalid channel %d for differential diode\n",
 					 sensor->chan);
 
 	/* set common parameters */
@@ -1093,7 +1093,7 @@ static struct ltc2983_sensor *ltc2983_r_sense_new(struct fwnode_handle *child,
 	/* validate channel index */
 	if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
 		return dev_err_ptr_probe(dev, -EINVAL,
-					 "Invalid chann:%d for r_sense\n",
+					 "Invalid channel %d for r_sense\n",
 					 sensor->chan);
 
 	ret = fwnode_property_read_u32(child, "adi,rsense-val-milli-ohms", &temp);
@@ -1130,7 +1130,7 @@ static struct ltc2983_sensor *ltc2983_adc_new(struct fwnode_handle *child,
 
 	if (!adc->single_ended && sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
 		return dev_err_ptr_probe(dev, -EINVAL,
-					 "Invalid chan:%d for differential adc\n",
+					 "Invalid channel %d for differential ADC\n",
 					 sensor->chan);
 
 	/* set common parameters */
@@ -1156,7 +1156,7 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
 
 	if (!temp->single_ended && sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
 		return dev_err_ptr_probe(dev, -EINVAL,
-					 "Invalid chan:%d for differential temp\n",
+					 "Invalid channel %d for differential temp\n",
 					 sensor->chan);
 
 	temp->custom = __ltc2983_custom_sensor_new(st, child, "adi,custom-temp",
@@ -1181,7 +1181,7 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
 
 	start_conversion = LTC2983_STATUS_START(true);
 	start_conversion |= LTC2983_STATUS_CHAN_SEL(sensor->chan);
-	dev_dbg(dev, "Start conversion on chan:%d, status:%02X\n",
+	dev_dbg(dev, "Start conversion on channel:%d, status:%02X\n",
 		sensor->chan, start_conversion);
 	reinit_completion(&st->completion);
 	/* start conversion */
@@ -1232,7 +1232,7 @@ static int ltc2983_read_raw(struct iio_dev *indio_dev,
 
 	/* sanity check */
 	if (chan->address >= st->num_channels) {
-		dev_err(dev, "Invalid chan address:%ld", chan->address);
+		dev_err(dev, "Invalid channel address: %ld\n", chan->address);
 		return -EINVAL;
 	}
 
@@ -1329,14 +1329,14 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
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
@@ -1344,7 +1344,7 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 			return dev_err_probe(dev, ret,
 				"adi,sensor-type property must given for child nodes\n");
 
-		dev_dbg(dev, "Create new sensor, type %u, chann %u",
+		dev_dbg(dev, "Create new sensor, type %u, channel %u",
 			sensor.type, sensor.chan);
 
 		if (sensor.type >= LTC2983_SENSOR_THERMOCOUPLE &&
-- 
2.43.0

