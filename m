Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A832F423163;
	Thu, 14 May 2026 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770187; cv=none; b=T5av+a0ZlficRHfUG/5kyM4o0iKukFQSrwYGKygHwR1wrsDc7v6njbOo1w2CmzG70fLpv+GCcSrp9HlXqsntJ3b7kYXBCuLs47dtosiHwl12BZrVfCV25PNebmGVckaqtFtSOwUeaVGeWhT7t2FXJ6SmfysrvoKK28hfMEzbL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770187; c=relaxed/simple;
	bh=SdKfnvDu9O1sScGHVDV6sgkWtshqWHLpT+q5N5cYaHg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kR9vZI64PfqrXwUTLnuGCHfwJAcnNB5Xw95IdZHMdPmttcC4vFz0IC9WH22K6cmDG/yuqc01CP6Sj4f8mc5SOPR42Eub89CJhorBJiWpMi5aauDBLCC/rCjT1uKjGKb82htqas9/PcownwycYt6RzsBvHPZdGwrnXXGfGeAIGko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WHX2AN0t; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WHX2AN0t"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ECXCn31715259;
	Thu, 14 May 2026 10:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3F5Gq
	Dgf4iCteKE8Ey1g5zl7GZ6N+TrukPmImTE2VEI=; b=WHX2AN0t8SjHcCDQHrTiG
	tEEnIoX2aYFC5qABGZrwldS1W7zb+Ji5TBYqDPqJnw315ODH/TRWHmvfP0XBfgAy
	UccH7MidQqV807kjCLAByzlAjio027w+Y5BbWkumLgQWsyRZv2S04J7mEEA5ztaX
	CiZuaVLLugAhA68NvtPTv0Tu9sfVmKmKcAzWdJXlrbLG07lwnSzPMviKmh38/HRi
	GalWElzG+m0bKIrFKn51rqi7UP2WbFmdXo1hC+AxOo6KzY5br7bmgWcWn1ECNTML
	nwxpalM39TmitgRaWSYTUiuPKPP4J7eKo7Bsjqu6PKlvgdYFObaNzg0uLp8zFSKz
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e54xgtj5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 10:49:41 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64EEneDf041764
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 May 2026 10:49:40 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 14 May
 2026 10:49:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 14 May 2026 10:49:40 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.202])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64EEmjAe014051;
	Thu, 14 May 2026 10:49:33 -0400
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
Subject: [PATCH v2 7/7] iio: temperature: ltc2983: Add support for ADT7604
Date: Thu, 14 May 2026 17:46:54 +0300
Message-ID: <20260514144712.64374-8-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514144712.64374-1-liviu.stan@analog.com>
References: <20260514144712.64374-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE1MCBTYWx0ZWRfX16CJ+woh0CL2
 +EVI+5YZwvI6UeNr4dGEiEzezZjTcBJPu1/MSw3Z9sY90IJtaDRC6n/ZH291EuQkRcJ6fga6kLF
 XyHR3VZQqcuWdHo/pfMZtk5wBJO934hGhBVl+D5VZHTbAjS8z2HY+HiZ3MZd+SXrsDWNyC3Tu//
 eCjkGedS+UQt4eSo6GHYe3DO15j6s7d0j3UeVkrQ0x/XcFzwGB+xoipPns5QWWgTllJ4HCCTJ2+
 Z+dI8LqancwG46ZTu043R9ETU2u1dYkOfpNTguE/dThzCiN4NqUnz6dYQv8aQSbecwynx27bMZl
 irBJhJEurrVud9o2eqQxTzNTUBXxui1dPn9iC1MpkbMhUt29UNwZiWA4sMLaCwUHE4PCHoTvDSc
 8J91rjkmpbFjO9qg2SVVkVp7mYfaCZ5Fe21+M89R60VJJ8FBwNuQK0LKVXjm8EuVmXuhCEH8XtJ
 lzYMXWjcwtrbIgmHSRQ==
X-Proofpoint-GUID: nEZOub8HetdM0-yo81oRv34HJZUePLTL
X-Proofpoint-ORIG-GUID: nEZOub8HetdM0-yo81oRv34HJZUePLTL
X-Authority-Analysis: v=2.4 cv=MMFQXsZl c=1 sm=1 tr=0 ts=6a05e106 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=TvmM-eMmwrNWMyJAHKIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140150

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
excitation current or custom table; standard traces (> 1 ohm) accept
an optional resistance-to-temperature table.

Custom thermistor (type 27) becomes the leak detector. Sensor
configuration bits are hardcoded to 0b001. The custom table uses
a resolution of 16 instead of 64, and is specified via the
adi,custom-leak-detector DT property.

Both sensor types expose an IIO_RESISTANCE channel reading from
the resistance result register bank (0x0060-0x00AF). The register
encodes the measured resistance with 10 fractional bits, so
dividing by 1024 gives ohms. Since the sense resistor is specified
in ohms, the output is in ohms for both sensor types and a single
1/1024 scale applies to both. When a custom table is provided,
a secondary channel also appears: IIO_TEMP (millidegrees Celsius)
for copper trace and IIO_COVERAGE_PERCENT (percent) for leak
detector.

The ltc2983_chip_info struct is extended with a u64 supported_sensors
bitmask using BIT_ULL() to safely represent the new sensor type bits
32 and 33 on 32-bit builds.

Tested on EVAL-ADT7604-AZ connected to Raspberry Pi 5 via SPI.

Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v2:
- New software sensor type values LTC2983_SENSOR_COPPER_TRACE = 32 and
  LTC2983_SENSOR_LEAK_DETECTOR = 33 map to hardware register values 18
  and 27 internally; v1 exposed 18 and 27 directly as adi,sensor-type
  values.
- Added n_iio_chan to struct ltc2983_sensor; set in the dedicated
  parser functions and used in ltc2983_parse_fw() and ltc2983_setup()
  to count and assign IIO channels, removing to_rtd()/to_thermistor()
  casts from the common path.
- Replaced has_copper_trace guards in ltc2983_rtd_new() and
  ltc2983_thermistor_new() with dedicated structs and functions for
  the new sensor types.
- Replaced has_copper_trace bool with u64 supported_sensors bitmask
  in ltc2983_chip_info.
- Fixed IIO_RESISTANCE scale: both sensor types now use 1/1024 (ohms);
  v1 used 1/1,024,000 for copper trace. But since the sense resistor
  value is written in ohms to the register, the output will also be
  in ohms for a scale of 1/1024.
- Replaced IIO_TEMP with IIO_COVERAGE_PERCENT for the leak detector
  coverage output.
- Renamed sub_ohm to is_sub_ohm.
- Used switch() for IIO_CHAN_INFO_RAW base register selection.
- Used BIT_ULL() checks against supported_sensors for sensor type
  validation.

 drivers/iio/temperature/ltc2983.c | 401 ++++++++++++++++++++++++++++--
 1 file changed, 386 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index bf435e965c6d..acd043ed62f5 100644
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
@@ -186,17 +188,43 @@ enum {
 	LTC2983_SENSOR_SENSE_RESISTOR = 29,
 	LTC2983_SENSOR_DIRECT_ADC = 30,
 	LTC2983_SENSOR_ACTIVE_TEMP = 31,
+	/* Sensor types for some parts only; map to RTD_CUSTOM/THERMISTOR_CUSTOM in HW */
+	LTC2983_SENSOR_COPPER_TRACE = 32,
+	LTC2983_SENSOR_LEAK_DETECTOR = 33,
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
 
@@ -212,7 +240,7 @@ enum {
 struct ltc2983_chip_info {
 	const char *name;
 	unsigned int max_channels_nr;
-	bool has_temp;
+	u64 supported_sensors;
 	bool has_eeprom;
 };
 
@@ -247,6 +275,8 @@ struct ltc2983_sensor {
 	u32 chan;
 	/* sensor type */
 	u32 type;
+	/* number of IIO channels this sensor produces */
+	u8 n_iio_chan;
 };
 
 struct ltc2983_custom_sensor {
@@ -274,6 +304,25 @@ struct ltc2983_rtd {
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
@@ -354,8 +403,15 @@ static int __ltc2983_chan_assign_common(struct ltc2983_data *st,
 	struct device *dev = &st->spi->dev;
 	u32 reg = LTC2983_CHAN_ASSIGN_ADDR(sensor->chan);
 
-	chan_val |= LTC2983_CHAN_TYPE(sensor->type);
-	dev_dbg(&st->spi->dev, "Assign reg:0x%04X, val:0x%08X\n", reg,
+	u32 hw_type = sensor->type;
+
+	if (hw_type == LTC2983_SENSOR_COPPER_TRACE)
+		hw_type = LTC2983_SENSOR_RTD_CUSTOM;
+	else if (hw_type == LTC2983_SENSOR_LEAK_DETECTOR)
+		hw_type = LTC2983_SENSOR_THERMISTOR_CUSTOM;
+
+	chan_val |= LTC2983_CHAN_TYPE(hw_type);
+	dev_dbg(dev, "Assign reg:0x%04X, val:0x%08X\n", reg,
 		chan_val);
 	st->chan_val = cpu_to_be32(chan_val);
 	return regmap_bulk_write(st->regmap, reg, &st->chan_val,
@@ -579,6 +635,32 @@ static int ltc2983_rtd_assign_chan(struct ltc2983_data *st,
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
+	chan_val |= LTC2983_RTD_EXC_CURRENT(ct->excitation_current);
+
+	if (ct->custom) {
+		int ret;
+
+		ret = __ltc2983_chan_custom_sensor_assign(st, ct->custom,
+							  &chan_val);
+		if (ret)
+			return ret;
+	}
+
+	if (ct->is_sub_ohm)
+		chan_val &= ~GENMASK(17, 0);
+
+	return __ltc2983_chan_assign_common(st, sensor, chan_val);
+}
+
 static int ltc2983_thermistor_assign_chan(struct ltc2983_data *st,
 					  const struct ltc2983_sensor *sensor)
 {
@@ -602,6 +684,29 @@ static int ltc2983_thermistor_assign_chan(struct ltc2983_data *st,
 	return __ltc2983_chan_assign_common(st, sensor, chan_val);
 }
 
+static int ltc2983_leak_detector_assign_chan(struct ltc2983_data *st,
+					     const struct ltc2983_sensor *sensor)
+{
+	struct ltc2983_leak_detector *ld = to_leak_detector(sensor);
+	u32 chan_val;
+
+	chan_val = LTC2983_CHAN_ASSIGN(ld->r_sense_chan);
+	/* bits 21:19 must be 0b001 (ADT7604 datasheet Table 38) */
+	chan_val |= LTC2983_THERMISTOR_CFG(1);
+	chan_val |= LTC2983_THERMISTOR_EXC_CURRENT(ld->excitation_current);
+
+	if (ld->custom) {
+		int ret;
+
+		ret = __ltc2983_chan_custom_sensor_assign(st, ld->custom,
+							  &chan_val);
+		if (ret)
+			return ret;
+	}
+
+	return __ltc2983_chan_assign_common(st, sensor, chan_val);
+}
+
 static int ltc2983_diode_assign_chan(struct ltc2983_data *st,
 				     const struct ltc2983_sensor *sensor)
 {
@@ -1024,6 +1129,191 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
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
+	if (fwnode_property_present(child, "adi,custom-rtd")) {
+		if (ct->is_sub_ohm)
+			return dev_err_ptr_probe(dev, -EINVAL,
+						 "sub-ohm copper trace cannot have a custom table\n");
+		ct->custom = __ltc2983_custom_sensor_new(st, child, "adi,custom-rtd",
+							 false, 2048, false);
+		if (IS_ERR(ct->custom))
+			return ERR_CAST(ct->custom);
+	}
+
+	if (!ct->is_sub_ohm) {
+		u32 excitation_current = 0;
+
+		ret = fwnode_property_read_u32(child,
+					       "adi,excitation-current-microamp",
+					       &excitation_current);
+		if (ret) {
+			/* default to 1mA per datasheet recommendation for copper trace */
+			ct->excitation_current = 0x08;
+		} else {
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
+		}
+	}
+
+	ct->sensor.fault_handler = ltc2983_common_fault_handler;
+	ct->sensor.assign_chan = ltc2983_copper_trace_assign_chan;
+	if (ct->custom)
+		ct->sensor.n_iio_chan = 2;
+	else
+		ct->sensor.n_iio_chan = 1;
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
+					 "rsense channel must be configured...\n");
+
+	if (fwnode_property_present(child, "adi,custom-leak-detector")) {
+		ld->custom = __ltc2983_custom_sensor_new(st, child,
+							 "adi,custom-leak-detector",
+							 false, 16, false);
+		if (IS_ERR(ld->custom))
+			return ERR_CAST(ld->custom);
+	}
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
+	if (ld->custom)
+		ld->sensor.n_iio_chan = 2;
+	else
+		ld->sensor.n_iio_chan = 1;
+
+	return &ld->sensor;
+}
+
 static struct ltc2983_sensor *
 ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *st,
 		  const struct ltc2983_sensor *sensor)
@@ -1183,7 +1473,8 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
 }
 
 static int ltc2983_chan_read(struct ltc2983_data *st,
-			const struct ltc2983_sensor *sensor, int *val)
+			const struct ltc2983_sensor *sensor,
+			u32 base_reg, int *val)
 {
 	struct device *dev = &st->spi->dev;
 	u32 start_conversion = 0;
@@ -1221,6 +1512,16 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
 
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
@@ -1252,7 +1553,16 @@ static int ltc2983_read_raw(struct iio_dev *indio_dev,
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
@@ -1269,6 +1579,16 @@ static int ltc2983_read_raw(struct iio_dev *indio_dev,
 			/* 2^21 */
 			*val2 = 2097152;
 			return IIO_VAL_FRACTIONAL;
+		case IIO_RESISTANCE:
+			/* value in ohm, 10 fractional bits: divide by 2^10 */
+			*val = 1;
+			*val2 = 1024;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_COVERAGE_PERCENT:
+			/* value in percent, 10 fractional bits: divide by 2^10 */
+			*val = 1;
+			*val2 = 1024;
+			return IIO_VAL_FRACTIONAL;
 		default:
 			return -EINVAL;
 		}
@@ -1329,7 +1649,7 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 	if (!st->sensors)
 		return -ENOMEM;
 
-	st->iio_channels = st->num_channels;
+	st->iio_channels = 0;
 	device_for_each_child_node_scoped(dev, child) {
 		struct ltc2983_sensor sensor;
 
@@ -1357,7 +1677,13 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 			return dev_err_probe(dev, ret,
 				"adi,sensor-type property must given for child nodes\n");
 
-		dev_dbg(dev, "Create new sensor, type %u, chann %u",
+		if (sensor.type > LTC2983_SENSOR_LEAK_DETECTOR ||
+		    !(st->info->supported_sensors & BIT_ULL(sensor.type)))
+			return dev_err_probe(dev, -EINVAL,
+					     "sensor type %d not supported on %s\n",
+					     sensor.type, st->info->name);
+
+		dev_dbg(dev, "Create new sensor, type %u, channel %u",
 			sensor.type, sensor.chan);
 
 		if (sensor.type >= LTC2983_SENSOR_THERMOCOUPLE &&
@@ -1377,13 +1703,14 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
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
@@ -1398,6 +1725,16 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
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
@@ -1445,8 +1782,9 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 
 static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 {
-	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status;
 	struct device *dev = &st->spi->dev;
+	u32 iio_chan_t = 0, iio_chan_v = 0, iio_chan_r = 0, iio_chan_c = 0;
+	u32 chan, iio_idx = 0, status;
 	int ret;
 
 	/* make sure the device is up: start bit (7) is 0 and done bit (6) is 1 */
@@ -1493,8 +1831,26 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 		    !assign_iio)
 			continue;
 
+		/*
+		 * Copper trace and leak detector sensors without a custom table
+		 * produce only a resistance result; the chip does not populate
+		 * the temperature result register. Emit only an IIO_RESISTANCE
+		 * channel in this case.
+		 */
+		if (st->sensors[chan]->type == LTC2983_SENSOR_COPPER_TRACE ||
+		    st->sensors[chan]->type == LTC2983_SENSOR_LEAK_DETECTOR) {
+			if (st->sensors[chan]->n_iio_chan == 1) {
+				st->iio_chan[iio_idx++] =
+					LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
+				continue;
+			}
+		}
+
 		/* assign iio channel */
-		if (st->sensors[chan]->type != LTC2983_SENSOR_DIRECT_ADC) {
+		if (st->sensors[chan]->type == LTC2983_SENSOR_LEAK_DETECTOR) {
+			chan_type = IIO_COVERAGE_PERCENT;
+			iio_chan = &iio_chan_c;
+		} else if (st->sensors[chan]->type != LTC2983_SENSOR_DIRECT_ADC) {
 			chan_type = IIO_TEMP;
 			iio_chan = &iio_chan_t;
 		} else {
@@ -1508,6 +1864,9 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 		 */
 		st->iio_chan[iio_idx++] = LTC2983_CHAN(chan_type, (*iio_chan)++,
 						       chan);
+
+		if (st->sensors[chan]->n_iio_chan == 2)
+			st->iio_chan[iio_idx++] = LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
 	}
 
 	return 0;
@@ -1516,6 +1875,7 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 static const struct regmap_range ltc2983_reg_ranges[] = {
 	regmap_reg_range(LTC2983_STATUS_REG, LTC2983_STATUS_REG),
 	regmap_reg_range(LTC2983_TEMP_RES_START_REG, LTC2983_TEMP_RES_END_REG),
+	regmap_reg_range(ADT7604_RES_RES_START_REG, ADT7604_RES_RES_END_REG),
 	regmap_reg_range(LTC2983_EEPROM_KEY_REG, LTC2983_EEPROM_KEY_REG),
 	regmap_reg_range(LTC2983_EEPROM_READ_STATUS_REG,
 			 LTC2983_EEPROM_READ_STATUS_REG),
@@ -1658,25 +2018,34 @@ static DEFINE_SIMPLE_DEV_PM_OPS(ltc2983_pm_ops, ltc2983_suspend,
 static const struct ltc2983_chip_info ltc2983_chip_info_data = {
 	.name = "ltc2983",
 	.max_channels_nr = 20,
+	.supported_sensors = LTC2983_COMMON_SENSORS,
 };
 
 static const struct ltc2983_chip_info ltc2984_chip_info_data = {
 	.name = "ltc2984",
 	.max_channels_nr = 20,
+	.supported_sensors = LTC2983_COMMON_SENSORS,
 	.has_eeprom = true,
 };
 
 static const struct ltc2983_chip_info ltc2986_chip_info_data = {
 	.name = "ltc2986",
 	.max_channels_nr = 10,
-	.has_temp = true,
+	.supported_sensors = LTC2983_COMMON_SENSORS | BIT_ULL(LTC2983_SENSOR_ACTIVE_TEMP),
 	.has_eeprom = true,
 };
 
 static const struct ltc2983_chip_info ltm2985_chip_info_data = {
 	.name = "ltm2985",
 	.max_channels_nr = 10,
-	.has_temp = true,
+	.supported_sensors = LTC2983_COMMON_SENSORS | BIT_ULL(LTC2983_SENSOR_ACTIVE_TEMP),
+	.has_eeprom = true,
+};
+
+static const struct ltc2983_chip_info adt7604_chip_info_data = {
+	.name = "adt7604",
+	.max_channels_nr = 20,
+	.supported_sensors = ADT7604_SENSORS,
 	.has_eeprom = true,
 };
 
@@ -1685,6 +2054,7 @@ static const struct spi_device_id ltc2983_id_table[] = {
 	{ "ltc2984", (kernel_ulong_t)&ltc2984_chip_info_data },
 	{ "ltc2986", (kernel_ulong_t)&ltc2986_chip_info_data },
 	{ "ltm2985", (kernel_ulong_t)&ltm2985_chip_info_data },
+	{ "adt7604", (kernel_ulong_t)&adt7604_chip_info_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ltc2983_id_table);
@@ -1694,6 +2064,7 @@ static const struct of_device_id ltc2983_of_match[] = {
 	{ .compatible = "adi,ltc2984", .data = &ltc2984_chip_info_data },
 	{ .compatible = "adi,ltc2986", .data = &ltc2986_chip_info_data },
 	{ .compatible = "adi,ltm2985", .data = &ltm2985_chip_info_data },
+	{ .compatible = "adi,adt7604", .data = &adt7604_chip_info_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2983_of_match);
-- 
2.43.0

