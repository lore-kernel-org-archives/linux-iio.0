Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E91385535;
	Thu, 21 May 2026 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381938; cv=none; b=COMRXyeoZ5eYDgkrcMjRrOi6KFYGPTOapPXAZ5pZFJNHHKgXA8ADO08Z0L0Vnjf1ME+QIftlRMW/cj8CushPXPN49/6jzngf9G6hxp3x10Bqcf0N2ri6u4Df88bmboPfgdGhafYOWutJx+sZc3jsGNeNW+dtquippGBDG0OBF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381938; c=relaxed/simple;
	bh=42OC1Xa9MGIsajSY3C/7o/ptKyJohx7pCvJk/4hFBD8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkJBMrTikwRDrh+yrzEHCvWZwm1CPeLgEqemAubngggwi1UlGY6rVJxiu66OVcRlTKlShCPzJMHpAgVi6GSZovrXcS8lBfnQKYTIUNnB4ZHtrLML8/gj2se5ZSw/yNpAbbJM4m9RL8+G5BLmbxK/epbyb38bqcIRK1IUwzo1ZNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EiruO+3m; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EiruO+3m"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LDqFpa416979;
	Thu, 21 May 2026 12:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4Wxxd
	35DS7OslAxwdJCDYtaSy+CtvU3LAMJRpQrxjBU=; b=EiruO+3mpZkxYMUKJZhLH
	jAmjfFdJGfyRLGuzirMYK86bwWdTqTa9fLnb4Vw2cbTIPofn8rdSb4uSAwy96TYz
	23tfnu93jiuMBmeOL9QKWSgMP9r9Hh9eHmSZKodIS/lPa4RbQBBqy8PhK2u+Nsm9
	qZgT2qojmUI8zCzlX6zGKrYpvcvbwD4VTnteV1NP3vx9xIY7FVz/+o034SPElih/
	6EwZYdo8qVAxtxB2iN3PuznKPfMzQW60uqBiVq4eQswG0fnnfLPV+bXSwrf4YgIX
	MqvB4ZAHWYjDwMLg/LW5bA38jr9x00bLiqcCE8/93fMkgA7mpIR7CKvfBq6HtV0+
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e9e6wwajf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 12:45:32 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LGjVn3000425
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 May 2026 12:45:31 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 21 May
 2026 12:45:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 12:45:31 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.208])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LGim0s024538;
	Thu, 21 May 2026 12:45:24 -0400
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
        Francesco Lavra <flavra@baylibre.com>,
        Liviu Stan <liviu.stan@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 8/8] iio: temperature: ltc2983: Add support for ADT7604
Date: Thu, 21 May 2026 19:43:01 +0300
Message-ID: <20260521164323.770626-9-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521164323.770626-1-liviu.stan@analog.com>
References: <20260521164323.770626-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: DhBcsCscVXI8FV1lDkFUNtzzjyRu94K6
X-Proofpoint-ORIG-GUID: DhBcsCscVXI8FV1lDkFUNtzzjyRu94K6
X-Authority-Analysis: v=2.4 cv=K8gS2SWI c=1 sm=1 tr=0 ts=6a0f36ac cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=TlbCvaWkEPsthiUEuOIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE2OCBTYWx0ZWRfXzoKQrg2y8/a3
 hdXCvqSTXjEpiMCHUxZIQk0xzXqzFe0naXHJATrItjklhQbusCTp7Z6iNtXcmjZjpO5d/AR4+OY
 sXjw0FDbLt1To7yo25r1pl+dvXX5rFF4YdpDxLrNRW7u4543RhRoICeG3xKyknTC5ZCuCLwKh5+
 CwqNkXB1Kba249k1twpWNsYGcRMnwUJYi9A7ZP22UohNhuiuYO4ICnKtvqMQQwfW4DMeipisLk4
 UegqxXz04J5duUhT+e+D3BKxxm0xrI+uIDwLuzFifAHJmAxl2M2FxTIO9p68H+KeG1G2FFJDPb3
 YvZnnn9V+NiPZPaVVv2OFAlSd18HX4ekiHT7TmXjF+mB1sDgyjC9SWBQwgaaOrpeVslS40KBWKv
 3NbNFUF7AWyLOXaIDisAn6OrsXtEgi0FTtlH0196JV9ER+2o07ct2edOvrZh/rZ8OwKubKUoofv
 lh7lXMQKzZ4a/klLh6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210168

The ADT7604 shares the same die as the LTC2984. It repurposes the
custom RTD sensor type (18) as a copper trace resistance sensor
and the custom thermistor type (27) as a leak detector, and
removes thermocouple, diode and direct ADC sensor types.

Two new software sensor type values are introduced
(LTC2983_SENSOR_COPPER_TRACE = 32, LTC2983_SENSOR_LEAK_DETECTOR = 33)
that map to the hardware register values 18 and 27 respectively.
Dedicated structs (ltc2983_copper_trace, ltc2983_leak_detector) and
parser functions are added rather than extending the existing RTD and
thermistor paths, as the hardware configuration bits are fully
hardcoded and several RTD/thermistor properties would need to be
explicitly forbidden or ignored.

Custom RTD (type 18) becomes the copper trace sensor. Sensor
configuration bits are hardcoded to 0b1001 per the datasheet.
Two variants are supported via the adi,copper-trace-sub-ohm DT
property: sub-ohm traces (< 1 ohm) have bits 17:0 cleared with no
excitation current or custom table; standard traces (> 1 ohm) have
a required resistance-to-temperature table.

Custom thermistor (type 27) becomes the leak detector. Sensor
configuration bits are hardcoded to 0b001. The custom table uses
a resolution of 16 instead of 64, and is specified via the
required adi,custom-leak-detector DT property.

Both sensor types expose an IIO_RESISTANCE channel reading from
the resistance result register bank (0x0060-0x00AF). Added a
"base" parameter to the LTC2983_RESULT_ADDR macro and a "base_reg"
parameter to the ltc2983_chan_read function so we can read from
both result register banks. The resistance register encodes the
measured resistance with 10 fractional bits, so dividing by 1024
gives ohms. Since the sense resistor is specified in ohms, the
output is in ohms for both sensor types and a single 1/1024
scale applies to both. For > 1 ohm copper traces and for leak
detectors, a secondary channel also appears: IIO_TEMP
(millidegrees Celsius) for copper trace and IIO_COVERAGE (percent)
for leak detector.

The ltc2983_chip_info struct is extended with a u64 supported_sensors
bitmask using BIT_ULL() to safely represent the new sensor type bits
32 and 33 on 32-bit builds. A LTC2983_SENSOR_NUM sentinel is added
to the enum so that the bounds check uses >= LTC2983_SENSOR_NUM
rather than hardcoding the last sensor type.

Tested on EVAL-ADT7604-AZ connected to Raspberry Pi 5 via SPI.

Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v3:
- Relocated the "base" parameter addition from patch 1 to this one since
  the resistance result memory region is (currently) ADT7604-specific
- Updated the commit message to mention the base and base_reg parameters
  added to the result-bank read helpers
- Stacked the IIO_RESISTANCE and IIO_COVERAGE case labels in
  ltc2983_read_raw()
- Added LTC2983_SENSOR_NUM sentinel at the end of the sensor-type enum
- Changed the sensor-type bounds check from > LTC2983_SENSOR_LEAK_DETECTOR
  to >= LTC2983_SENSOR_NUM
- Reordered the ltm2985_chip_info_data struct initializer so has_eeprom
  doesn't look like it was added to the ltm2985 in the diff
- Changed the custom leak detector table encoding, users now specify
  plain coverage percentage values (0-100) in the device tree and the
  driver applies the +273.15 C offset internally before writing the
  hardware table
- Changed custom-rtd to custom-copper-trace to better represent the
  copper trace custom table, and made it required for > 1 ohm variants
- Made custom-leak-detector required for leak detector sensors, _new
  and _assign_chan functions were updated for both sensor types
- Updated commit message to reflect the changes
- Removed "..." from "rsense channel must be configured" error message
  from ltc2983_leak_detector_new()
- Removed blank line before hw_type declaration in
  __ltc2983_chan_assign_common

 drivers/iio/temperature/ltc2983.c | 413 ++++++++++++++++++++++++++++--
 1 file changed, 394 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 326f843f4271..e2ffeee026ee 100644
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
 
 #define LTC2983_CHAN_ASSIGN_ADDR(chan) \
 			((((chan) - 1) * 4) + LTC2983_CHAN_ASSIGN_START_REG)
-#define LTC2983_RESULT_ADDR(chan) \
-			((((chan) - 1) * 4) + LTC2983_TEMP_RES_START_REG)
+#define LTC2983_RESULT_ADDR(chan, base) \
+			((((chan) - 1) * 4) + (base))
 #define LTC2983_THERMOCOUPLE_DIFF_MASK		BIT(3)
 #define LTC2983_THERMOCOUPLE_SGL(x) \
 				FIELD_PREP(LTC2983_THERMOCOUPLE_DIFF_MASK, x)
@@ -186,17 +188,44 @@ enum {
 	LTC2983_SENSOR_SENSE_RESISTOR = 29,
 	LTC2983_SENSOR_DIRECT_ADC = 30,
 	LTC2983_SENSOR_ACTIVE_TEMP = 31,
+	/* Sensor types for some parts only; map to RTD_CUSTOM/THERMISTOR_CUSTOM in HW */
+	LTC2983_SENSOR_COPPER_TRACE = 32,
+	LTC2983_SENSOR_LEAK_DETECTOR = 33,
+	LTC2983_SENSOR_NUM,
 };
 
+/* Bitmask of sensor types supported by LTC2983/LTC2984 and derivatives */
+#define LTC2983_COMMON_SENSORS \
+	(GENMASK_ULL(LTC2983_SENSOR_THERMOCOUPLE_CUSTOM, LTC2983_SENSOR_THERMOCOUPLE) | \
+	 GENMASK_ULL(LTC2983_SENSOR_RTD_CUSTOM, LTC2983_SENSOR_RTD) | \
+	 GENMASK_ULL(LTC2983_SENSOR_THERMISTOR_CUSTOM, LTC2983_SENSOR_THERMISTOR) | \
+	 BIT_ULL(LTC2983_SENSOR_DIODE) | \
+	 BIT_ULL(LTC2983_SENSOR_SENSE_RESISTOR) | \
+	 BIT_ULL(LTC2983_SENSOR_DIRECT_ADC))
+
+/* Bitmask of sensor types supported by ADT7604 */
+#define ADT7604_SENSORS \
+	(GENMASK_ULL(LTC2983_SENSOR_RTD_CUSTOM - 1, LTC2983_SENSOR_RTD) | \
+	 GENMASK_ULL(LTC2983_SENSOR_THERMISTOR_CUSTOM - 1, LTC2983_SENSOR_THERMISTOR) | \
+	 BIT_ULL(LTC2983_SENSOR_SENSE_RESISTOR) | \
+	 BIT_ULL(LTC2983_SENSOR_COPPER_TRACE) | \
+	 BIT_ULL(LTC2983_SENSOR_LEAK_DETECTOR))
+
 #define to_thermocouple(_sensor) \
 		container_of(_sensor, struct ltc2983_thermocouple, sensor)
 
 #define to_rtd(_sensor) \
 		container_of(_sensor, struct ltc2983_rtd, sensor)
 
+#define to_copper_trace(_sensor) \
+		container_of(_sensor, struct ltc2983_copper_trace, sensor)
+
 #define to_thermistor(_sensor) \
 		container_of(_sensor, struct ltc2983_thermistor, sensor)
 
+#define to_leak_detector(_sensor) \
+		container_of(_sensor, struct ltc2983_leak_detector, sensor)
+
 #define to_diode(_sensor) \
 		container_of(_sensor, struct ltc2983_diode, sensor)
 
@@ -212,7 +241,7 @@ enum {
 struct ltc2983_chip_info {
 	const char *name;
 	unsigned int max_channels_nr;
-	bool has_temp;
+	u64 supported_sensors;
 	bool has_eeprom;
 };
 
@@ -247,6 +276,8 @@ struct ltc2983_sensor {
 	u32 chan;
 	/* sensor type */
 	u32 type;
+	/* number of IIO channels this sensor produces */
+	u8 n_iio_chan;
 };
 
 struct ltc2983_custom_sensor {
@@ -274,6 +305,25 @@ struct ltc2983_rtd {
 	u32 rtd_curve;
 };
 
+struct ltc2983_copper_trace {
+	struct ltc2983_sensor sensor;
+	struct ltc2983_custom_sensor *custom;
+	u32 r_sense_chan;
+	u32 excitation_current;
+	/* selects the <1Ω variant: bits 17:0 of the channel word are zeroed,
+	 * disabling excitation current and custom table fields (ADT7604
+	 * datasheet Table 26)
+	 */
+	bool is_sub_ohm;
+};
+
+struct ltc2983_leak_detector {
+	struct ltc2983_sensor sensor;
+	struct ltc2983_custom_sensor *custom;
+	u32 r_sense_chan;
+	u32 excitation_current;
+};
+
 struct ltc2983_thermistor {
 	struct ltc2983_sensor sensor;
 	struct ltc2983_custom_sensor *custom;
@@ -353,8 +403,14 @@ static int __ltc2983_chan_assign_common(struct ltc2983_data *st,
 {
 	struct device *dev = &st->spi->dev;
 	u32 reg = LTC2983_CHAN_ASSIGN_ADDR(sensor->chan);
+	u32 hw_type = sensor->type;
 
-	chan_val |= LTC2983_CHAN_TYPE(sensor->type);
+	if (hw_type == LTC2983_SENSOR_COPPER_TRACE)
+		hw_type = LTC2983_SENSOR_RTD_CUSTOM;
+	else if (hw_type == LTC2983_SENSOR_LEAK_DETECTOR)
+		hw_type = LTC2983_SENSOR_THERMISTOR_CUSTOM;
+
+	chan_val |= LTC2983_CHAN_TYPE(hw_type);
 	dev_dbg(dev, "Assign reg:0x%04X, val:0x%08X\n", reg,
 		chan_val);
 	st->chan_val = cpu_to_be32(chan_val);
@@ -486,6 +542,14 @@ __ltc2983_custom_sensor_new(struct ltc2983_data *st, const struct fwnode_handle
 		for (index = 0; index < n_entries; index++) {
 			u64 temp = ((u64 *)new_custom->table)[index];
 
+			/*
+			 * Users specify plain coverage percentage (0-100). Convert
+			 * to µK so __convert_to_raw() produces the correct hardware
+			 * encoding: P + 273.15 K.
+			 */
+			if ((index % 2) != 0 && !strcmp(propname, "adi,custom-leak-detector"))
+				temp = temp * 1000000 + 273150000;
+
 			if ((index % 2) != 0)
 				temp = __convert_to_raw(temp, 1024);
 			else if (has_signed && (s64)temp < 0)
@@ -579,6 +643,31 @@ static int ltc2983_rtd_assign_chan(struct ltc2983_data *st,
 	return __ltc2983_chan_assign_common(st, sensor, chan_val);
 }
 
+static int ltc2983_copper_trace_assign_chan(struct ltc2983_data *st,
+					    const struct ltc2983_sensor *sensor)
+{
+	struct ltc2983_copper_trace *ct = to_copper_trace(sensor);
+	u32 chan_val;
+
+	chan_val = LTC2983_CHAN_ASSIGN(ct->r_sense_chan);
+	/* Sensor config bits 21:18 must be 0b1001 (ADT7604 datasheet Table 26) */
+	chan_val |= LTC2983_RTD_CFG(0x9);
+
+	if (ct->is_sub_ohm) {
+		chan_val &= ~GENMASK(17, 0);
+	} else {
+		int ret;
+
+		chan_val |= LTC2983_RTD_EXC_CURRENT(ct->excitation_current);
+		ret = __ltc2983_chan_custom_sensor_assign(st, ct->custom,
+							  &chan_val);
+		if (ret)
+			return ret;
+	}
+
+	return __ltc2983_chan_assign_common(st, sensor, chan_val);
+}
+
 static int ltc2983_thermistor_assign_chan(struct ltc2983_data *st,
 					  const struct ltc2983_sensor *sensor)
 {
@@ -602,6 +691,25 @@ static int ltc2983_thermistor_assign_chan(struct ltc2983_data *st,
 	return __ltc2983_chan_assign_common(st, sensor, chan_val);
 }
 
+static int ltc2983_leak_detector_assign_chan(struct ltc2983_data *st,
+					     const struct ltc2983_sensor *sensor)
+{
+	struct ltc2983_leak_detector *ld = to_leak_detector(sensor);
+	u32 chan_val;
+	int ret;
+
+	chan_val = LTC2983_CHAN_ASSIGN(ld->r_sense_chan);
+	/* bits 21:19 must be 0b001 (ADT7604 datasheet Table 38) */
+	chan_val |= LTC2983_THERMISTOR_CFG(1);
+	chan_val |= LTC2983_THERMISTOR_EXC_CURRENT(ld->excitation_current);
+
+	ret = __ltc2983_chan_custom_sensor_assign(st, ld->custom, &chan_val);
+	if (ret)
+		return ret;
+
+	return __ltc2983_chan_assign_common(st, sensor, chan_val);
+}
+
 static int ltc2983_diode_assign_chan(struct ltc2983_data *st,
 				     const struct ltc2983_sensor *sensor)
 {
@@ -1037,6 +1145,195 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 	return &thermistor->sensor;
 }
 
+static struct ltc2983_sensor *
+ltc2983_copper_trace_new(const struct fwnode_handle *child, struct ltc2983_data *st,
+			 const struct ltc2983_sensor *sensor)
+{
+	struct device *dev = &st->spi->dev;
+	struct ltc2983_copper_trace *ct;
+	int ret;
+
+	if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_err_ptr_probe(dev, -EINVAL,
+					 "Invalid channel %d for copper trace\n",
+					 sensor->chan);
+
+	ct = devm_kzalloc(dev, sizeof(*ct), GFP_KERNEL);
+	if (!ct)
+		return ERR_PTR(-ENOMEM);
+
+	struct fwnode_handle *ref __free(fwnode_handle) =
+		fwnode_find_reference(child, "adi,rsense-handle", 0);
+	if (IS_ERR(ref))
+		return dev_err_cast_probe(dev, ref,
+					  "Property adi,rsense-handle missing or invalid\n");
+
+	ret = fwnode_property_read_u32(ref, "reg", &ct->r_sense_chan);
+	if (ret)
+		return dev_err_ptr_probe(dev, ret, "Property reg must be given\n");
+
+	ct->is_sub_ohm = fwnode_property_read_bool(child, "adi,copper-trace-sub-ohm");
+
+	if (ct->is_sub_ohm && fwnode_property_present(child, "adi,custom-copper-trace"))
+		return dev_err_ptr_probe(dev, -EINVAL,
+					 "sub-ohm copper trace cannot have a custom table\n");
+
+	if (!ct->is_sub_ohm) {
+		u32 excitation_current = 0;
+
+		if (!fwnode_property_present(child, "adi,custom-copper-trace"))
+			return dev_err_ptr_probe(dev, -EINVAL,
+						 "adi,custom-copper-trace is required for >1 ohm copper trace\n");
+
+		ct->custom = __ltc2983_custom_sensor_new(st, child, "adi,custom-copper-trace",
+							 false, 2048, false);
+		if (IS_ERR(ct->custom))
+			return ERR_CAST(ct->custom);
+
+		if (fwnode_property_present(child, "adi,excitation-current-microamp")) {
+			ret = fwnode_property_read_u32(child, "adi,excitation-current-microamp",
+						       &excitation_current);
+			if (ret)
+				return dev_err_ptr_probe(dev, ret,
+							 "Failed to read adi,excitation-current-microamp\n");
+
+			switch (excitation_current) {
+			case 5:
+				ct->excitation_current = 0x01;
+				break;
+			case 10:
+				ct->excitation_current = 0x02;
+				break;
+			case 25:
+				ct->excitation_current = 0x03;
+				break;
+			case 50:
+				ct->excitation_current = 0x04;
+				break;
+			case 100:
+				ct->excitation_current = 0x05;
+				break;
+			case 250:
+				ct->excitation_current = 0x06;
+				break;
+			case 500:
+				ct->excitation_current = 0x07;
+				break;
+			case 1000:
+				ct->excitation_current = 0x08;
+				break;
+			default:
+				return dev_err_ptr_probe(dev, -EINVAL,
+							 "Invalid value for excitation current(%u)\n",
+							 excitation_current);
+			}
+		} else {
+			/* default to 1mA per datasheet recommendation for copper trace */
+			ct->excitation_current = 0x08;
+		}
+	}
+
+	ct->sensor.fault_handler = ltc2983_common_fault_handler;
+	ct->sensor.assign_chan = ltc2983_copper_trace_assign_chan;
+	if (ct->is_sub_ohm)
+		ct->sensor.n_iio_chan = 1;
+	else
+		ct->sensor.n_iio_chan = 2;
+
+	return &ct->sensor;
+}
+
+static struct ltc2983_sensor *
+ltc2983_leak_detector_new(const struct fwnode_handle *child, struct ltc2983_data *st,
+			  const struct ltc2983_sensor *sensor)
+{
+	struct device *dev = &st->spi->dev;
+	struct ltc2983_leak_detector *ld;
+	int ret;
+	u32 excitation_current = 0;
+
+	if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_err_ptr_probe(dev, -EINVAL,
+					 "Invalid channel %d for leak detector\n",
+					 sensor->chan);
+
+	ld = devm_kzalloc(dev, sizeof(*ld), GFP_KERNEL);
+	if (!ld)
+		return ERR_PTR(-ENOMEM);
+
+	struct fwnode_handle *ref __free(fwnode_handle) =
+		fwnode_find_reference(child, "adi,rsense-handle", 0);
+	if (IS_ERR(ref))
+		return dev_err_cast_probe(dev, ref,
+					  "Property adi,rsense-handle missing or invalid\n");
+
+	ret = fwnode_property_read_u32(ref, "reg", &ld->r_sense_chan);
+	if (ret)
+		return dev_err_ptr_probe(dev, ret,
+					 "rsense channel must be configured\n");
+
+	if (!fwnode_property_present(child, "adi,custom-leak-detector"))
+		return dev_err_ptr_probe(dev, -EINVAL,
+					 "adi,custom-leak-detector is required for leak detectors\n");
+
+	ld->custom = __ltc2983_custom_sensor_new(st, child, "adi,custom-leak-detector",
+						 false, 16, false);
+	if (IS_ERR(ld->custom))
+		return ERR_CAST(ld->custom);
+
+	ret = fwnode_property_read_u32(child, "adi,excitation-current-nanoamp",
+				       &excitation_current);
+	if (ret)
+		return dev_err_ptr_probe(dev, ret,
+					 "adi,excitation-current-nanoamp is required for leak detectors\n");
+
+	switch (excitation_current) {
+	case 250:
+		ld->excitation_current = 0x01;
+		break;
+	case 500:
+		ld->excitation_current = 0x02;
+		break;
+	case 1000:
+		ld->excitation_current = 0x03;
+		break;
+	case 5000:
+		ld->excitation_current = 0x04;
+		break;
+	case 10000:
+		ld->excitation_current = 0x05;
+		break;
+	case 25000:
+		ld->excitation_current = 0x06;
+		break;
+	case 50000:
+		ld->excitation_current = 0x07;
+		break;
+	case 100000:
+		ld->excitation_current = 0x08;
+		break;
+	case 250000:
+		ld->excitation_current = 0x09;
+		break;
+	case 500000:
+		ld->excitation_current = 0x0a;
+		break;
+	case 1000000:
+		ld->excitation_current = 0x0b;
+		break;
+	default:
+		return dev_err_ptr_probe(dev, -EINVAL,
+					 "Invalid value for excitation current(%u)\n",
+					 excitation_current);
+	}
+
+	ld->sensor.fault_handler = ltc2983_common_fault_handler;
+	ld->sensor.assign_chan = ltc2983_leak_detector_assign_chan;
+	ld->sensor.n_iio_chan = 2;
+
+	return &ld->sensor;
+}
+
 static struct ltc2983_sensor *
 ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *st,
 		  const struct ltc2983_sensor *sensor)
@@ -1205,7 +1502,8 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
 }
 
 static int ltc2983_chan_read(struct ltc2983_data *st,
-			const struct ltc2983_sensor *sensor, int *val)
+			const struct ltc2983_sensor *sensor,
+			u32 base_reg, int *val)
 {
 	struct device *dev = &st->spi->dev;
 	u32 start_conversion = 0;
@@ -1236,13 +1534,23 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
 	}
 
 	/* read the converted data */
-	ret = regmap_bulk_read(st->regmap, LTC2983_RESULT_ADDR(sensor->chan),
+	ret = regmap_bulk_read(st->regmap, LTC2983_RESULT_ADDR(sensor->chan, base_reg),
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
 		dev_err(dev, "Invalid conversion detected\n");
 		return -EIO;
@@ -1274,7 +1582,16 @@ static int ltc2983_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&st->lock);
-		ret = ltc2983_chan_read(st, st->sensors[chan->address], val);
+		switch (chan->type) {
+		case IIO_RESISTANCE:
+			ret = ltc2983_chan_read(st, st->sensors[chan->address],
+						ADT7604_RES_RES_START_REG, val);
+			break;
+		default:
+			ret = ltc2983_chan_read(st, st->sensors[chan->address],
+						LTC2983_TEMP_RES_START_REG, val);
+			break;
+		}
 		mutex_unlock(&st->lock);
 		return ret ?: IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
@@ -1291,6 +1608,13 @@ static int ltc2983_read_raw(struct iio_dev *indio_dev,
 			/* 2^21 */
 			*val2 = 2097152;
 			return IIO_VAL_FRACTIONAL;
+		case IIO_RESISTANCE:
+		case IIO_COVERAGE:
+			/* value in ohm/percent */
+			*val = 1;
+			/* 2^10 */
+			*val2 = 1024;
+			return IIO_VAL_FRACTIONAL;
 		default:
 			return -EINVAL;
 		}
@@ -1351,7 +1675,7 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 	if (!st->sensors)
 		return -ENOMEM;
 
-	st->iio_channels = st->num_channels;
+	st->iio_channels = 0;
 	device_for_each_child_node_scoped(dev, child) {
 		struct ltc2983_sensor sensor;
 
@@ -1379,6 +1703,12 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 			return dev_err_probe(dev, ret,
 				"adi,sensor-type property must given for child nodes\n");
 
+		if (sensor.type >= LTC2983_SENSOR_NUM ||
+		    !(st->info->supported_sensors & BIT_ULL(sensor.type)))
+			return dev_err_probe(dev, -EINVAL,
+					     "sensor type %d not supported on %s\n",
+					     sensor.type, st->info->name);
+
 		dev_dbg(dev, "Create new sensor, type %u, channel %u",
 			sensor.type, sensor.chan);
 
@@ -1399,13 +1729,14 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 		} else if (sensor.type == LTC2983_SENSOR_SENSE_RESISTOR) {
 			st->sensors[chan] = ltc2983_r_sense_new(child, st,
 								&sensor);
-			/* don't add rsense to iio */
-			st->iio_channels--;
 		} else if (sensor.type == LTC2983_SENSOR_DIRECT_ADC) {
 			st->sensors[chan] = ltc2983_adc_new(child, st, &sensor);
-		} else if (st->info->has_temp &&
-			   sensor.type == LTC2983_SENSOR_ACTIVE_TEMP) {
+		} else if (sensor.type == LTC2983_SENSOR_ACTIVE_TEMP) {
 			st->sensors[chan] = ltc2983_temp_new(child, st, &sensor);
+		} else if (sensor.type == LTC2983_SENSOR_COPPER_TRACE) {
+			st->sensors[chan] = ltc2983_copper_trace_new(child, st, &sensor);
+		} else if (sensor.type == LTC2983_SENSOR_LEAK_DETECTOR) {
+			st->sensors[chan] = ltc2983_leak_detector_new(child, st, &sensor);
 		} else {
 			return dev_err_probe(dev, -EINVAL,
 					     "Unknown sensor type %d\n",
@@ -1420,6 +1751,16 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 		st->sensors[chan]->chan = sensor.chan;
 		st->sensors[chan]->type = sensor.type;
 
+		/*
+		 * Dedicated functions set n_iio_chan themselves; for all other
+		 * sensor types rsense produces 0 channels, everything else 1.
+		 */
+		if (!st->sensors[chan]->n_iio_chan) {
+			if (sensor.type != LTC2983_SENSOR_SENSE_RESISTOR)
+				st->sensors[chan]->n_iio_chan = 1;
+		}
+		st->iio_channels += st->sensors[chan]->n_iio_chan;
+
 		channel_avail_mask |= BIT(sensor.chan);
 		chan++;
 	}
@@ -1467,8 +1808,9 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 
 static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 {
-	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status;
 	struct device *dev = &st->spi->dev;
+	u32 iio_chan_t = 0, iio_chan_v = 0, iio_chan_r = 0, iio_chan_c = 0;
+	u32 chan, iio_idx = 0, status;
 	int ret;
 
 	/* make sure the device is up: start bit (7) is 0 and done bit (6) is 1 */
@@ -1516,12 +1858,33 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 			continue;
 
 		/* assign iio channel */
-		if (st->sensors[chan]->type != LTC2983_SENSOR_DIRECT_ADC) {
-			chan_type = IIO_TEMP;
-			iio_chan = &iio_chan_t;
-		} else {
+		switch (st->sensors[chan]->type) {
+		case LTC2983_SENSOR_COPPER_TRACE:
+			if (st->sensors[chan]->n_iio_chan == 1) {
+				/* sub-ohm copper traces produce only a resistance result */
+				st->iio_chan[iio_idx++] =
+					LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
+			} else {
+				st->iio_chan[iio_idx++] =
+					LTC2983_CHAN(IIO_TEMP, iio_chan_t++, chan);
+				st->iio_chan[iio_idx++] =
+					LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
+			}
+			continue;
+		case LTC2983_SENSOR_LEAK_DETECTOR:
+			st->iio_chan[iio_idx++] =
+				LTC2983_CHAN(IIO_COVERAGE, iio_chan_c++, chan);
+			st->iio_chan[iio_idx++] =
+				LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
+			continue;
+		case LTC2983_SENSOR_DIRECT_ADC:
 			chan_type = IIO_VOLTAGE;
 			iio_chan = &iio_chan_v;
+			break;
+		default:
+			chan_type = IIO_TEMP;
+			iio_chan = &iio_chan_t;
+			break;
 		}
 
 		/*
@@ -1538,6 +1901,7 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 static const struct regmap_range ltc2983_reg_ranges[] = {
 	regmap_reg_range(LTC2983_STATUS_REG, LTC2983_STATUS_REG),
 	regmap_reg_range(LTC2983_TEMP_RES_START_REG, LTC2983_TEMP_RES_END_REG),
+	regmap_reg_range(ADT7604_RES_RES_START_REG, ADT7604_RES_RES_END_REG),
 	regmap_reg_range(LTC2983_EEPROM_KEY_REG, LTC2983_EEPROM_KEY_REG),
 	regmap_reg_range(LTC2983_EEPROM_READ_STATUS_REG,
 			 LTC2983_EEPROM_READ_STATUS_REG),
@@ -1680,26 +2044,35 @@ static DEFINE_SIMPLE_DEV_PM_OPS(ltc2983_pm_ops, ltc2983_suspend,
 static const struct ltc2983_chip_info ltc2983_chip_info_data = {
 	.name = "ltc2983",
 	.max_channels_nr = 20,
+	.supported_sensors = LTC2983_COMMON_SENSORS,
 };
 
 static const struct ltc2983_chip_info ltc2984_chip_info_data = {
 	.name = "ltc2984",
 	.max_channels_nr = 20,
 	.has_eeprom = true,
+	.supported_sensors = LTC2983_COMMON_SENSORS,
 };
 
 static const struct ltc2983_chip_info ltc2986_chip_info_data = {
 	.name = "ltc2986",
 	.max_channels_nr = 10,
-	.has_temp = true,
 	.has_eeprom = true,
+	.supported_sensors = LTC2983_COMMON_SENSORS | BIT_ULL(LTC2983_SENSOR_ACTIVE_TEMP),
 };
 
 static const struct ltc2983_chip_info ltm2985_chip_info_data = {
 	.name = "ltm2985",
 	.max_channels_nr = 10,
-	.has_temp = true,
 	.has_eeprom = true,
+	.supported_sensors = LTC2983_COMMON_SENSORS | BIT_ULL(LTC2983_SENSOR_ACTIVE_TEMP),
+};
+
+static const struct ltc2983_chip_info adt7604_chip_info_data = {
+	.name = "adt7604",
+	.max_channels_nr = 20,
+	.has_eeprom = true,
+	.supported_sensors = ADT7604_SENSORS,
 };
 
 static const struct spi_device_id ltc2983_id_table[] = {
@@ -1707,6 +2080,7 @@ static const struct spi_device_id ltc2983_id_table[] = {
 	{ "ltc2984", (kernel_ulong_t)&ltc2984_chip_info_data },
 	{ "ltc2986", (kernel_ulong_t)&ltc2986_chip_info_data },
 	{ "ltm2985", (kernel_ulong_t)&ltm2985_chip_info_data },
+	{ "adt7604", (kernel_ulong_t)&adt7604_chip_info_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ltc2983_id_table);
@@ -1716,6 +2090,7 @@ static const struct of_device_id ltc2983_of_match[] = {
 	{ .compatible = "adi,ltc2984", .data = &ltc2984_chip_info_data },
 	{ .compatible = "adi,ltc2986", .data = &ltc2986_chip_info_data },
 	{ .compatible = "adi,ltm2985", .data = &ltm2985_chip_info_data },
+	{ .compatible = "adi,adt7604", .data = &adt7604_chip_info_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2983_of_match);
-- 
2.43.0

