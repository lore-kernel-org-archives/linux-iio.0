Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C093F5BC5;
	Mon, 25 May 2026 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727307; cv=none; b=fIFnvF1Us6cL+VhJ+XsbiN1AmZwNOJLXEFG3szx8iYNIIwmhkDAGGSdQ7Q6QLI0C8hvbcEV3L4v//vbrgearO7JUFE4VsmOAcbkMm6dWlkc/evcnv6lZHizgWXDQevs/u6hO+nOiYRg3+Bhl85JpiQx0nH9tR/gCBLkHggF7R+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727307; c=relaxed/simple;
	bh=JIst4o0j7wuo6h/TJXHXlAPZjkaV78ADFvWAcjzE230=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tcxl+K+r9ZrIavVSBmMfD17o//FJN2tcIGWxzfmL9kne816ykK9He7fVjg72iEmmMxqBAqTZfzMxBeeK1QjVNDav6Utxsx/fc18P33L3d05SKJ14UxDm6pDQE+RN9ehtt+3/aMR0ycFmRx6FI8jI1aEOunG8ybeI56Lq0FPFczg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=E1UCox9o; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="E1UCox9o"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PC2MBc753613;
	Mon, 25 May 2026 12:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qJcYK
	cgNTZxUFnt3e2bi2jnmaNa99UL+Xti+u6X9DZA=; b=E1UCox9og0K7iFBjHlX2V
	fT1W8d/kX1nMQsZiQkSUMpV4VkqclE2iSYh+enjmIli50ulTQRd9RYMJr0fdKmm3
	qgC1bgTpzBKqA48UdsbDYMDq/7Mn33F6pi1HikzxeAsUekTwCxVIlcpl2lY9U5AB
	q/1xxmC35+IVSRT/wX9dsPwx0/8hyvlXuQ4n0m0aIQEnZOk8CtADPRV5g8TAxSkh
	MyW8tBo6mtKetSXekIRpOWglyF1ukgK/6UXrCyhBKqVEYMquqctjTq9A9WTDGa7C
	zpmyoZGIObuKn9jmutIyIQJeBir8Iv5uJHLF85OrNq2yxe0TTwwSdQ3unhg33+AR
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ecbgtavb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 12:41:43 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64PGfgBh022304
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 May 2026 12:41:42 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 25 May
 2026 12:41:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 25 May 2026 12:41:42 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com ([10.32.226.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64PGevH5028845;
	Mon, 25 May 2026 12:41:36 -0400
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
Subject: [PATCH v4 6/9] iio: temperature: ltc2983: Use fwnode_property_present() for optional properties
Date: Mon, 25 May 2026 19:39:33 +0300
Message-ID: <20260525164013.118614-7-liviu.stan@analog.com>
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
X-Proofpoint-GUID: xuHN--WU8TcNTFglrYGpqIXrqNaaKb5a
X-Proofpoint-ORIG-GUID: xuHN--WU8TcNTFglrYGpqIXrqNaaKb5a
X-Authority-Analysis: v=2.4 cv=L5EtheT8 c=1 sm=1 tr=0 ts=6a147bc7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=jYDum2LILOQkPmL8thgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE2OCBTYWx0ZWRfX0d97XjI8RbFG
 J35YbyP2Vd0Nf397XRl6F2dbGlCdPDAiH6ZDjwVuytCn7Dnzn8vGqnA3BCfFKdBQajX5L+h3Bkp
 Qx6hUtqJZ2XJwg+n3+PfQOfpe8kT9UOixKSIfMcoJGaFUkTVL5RWqPYpkRIOCEroFQ1R4aZW3MB
 6Lt2kvXhRhXl2bKg64s7+hZFEqUVedkeFl34hnhZr+UGR88RG8ZxcycmO2a4AH4Aivd8JOJzLh3
 umD8/+WozrmDKIpbzuUHhACdvJa1vSL6BXxK2ra33hVIUGpH+lb5rzCOsrQdB37Ng0YZ4GjRncq
 MyY8EsEPyZ5rVAmyeWP98KnUdu5idV0cfvVdUeKtMSLNVHJXMn5/XIJmG0WphJ7oCG9at5/B9R4
 4987IMe5hdH5IL88Ob5jyybwhqk9mfx+IToTRL/E1tc+6JtBffE3xIncAgPwsYyXCLZ6P+NBAJy
 v5o1eSLuTVLtVTY32Bg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250168

Checking fwnode_property_read_u32() return value with if (!ret)
silently swallows meaningful error codes when a property is present
but malformed. Use fwnode_property_present() first so that absence
uses the default while a present but unreadable property returns
a proper error.

Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v4:
- No changes

 drivers/iio/temperature/ltc2983.c | 84 +++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index fc904c0a42b4..130ab7fddc2f 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -668,8 +668,14 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 	if (fwnode_property_read_bool(child, "adi,single-ended"))
 		thermo->sensor_config = LTC2983_THERMOCOUPLE_SGL(1);
 
-	ret = fwnode_property_read_u32(child, "adi,sensor-oc-current-microamp", &oc_current);
-	if (!ret) {
+	if (fwnode_property_present(child, "adi,sensor-oc-current-microamp")) {
+		ret = fwnode_property_read_u32(child,
+					       "adi,sensor-oc-current-microamp",
+					       &oc_current);
+		if (ret)
+			return dev_err_ptr_probe(dev, ret,
+						 "Failed to read adi,sensor-oc-current-microamp\n");
+
 		switch (oc_current) {
 		case 10:
 			thermo->sensor_config |=
@@ -759,8 +765,12 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 		return dev_err_ptr_probe(dev, ret,
 					 "Property reg must be given\n");
 
-	ret = fwnode_property_read_u32(child, "adi,number-of-wires", &n_wires);
-	if (!ret) {
+	if (fwnode_property_present(child, "adi,number-of-wires")) {
+		ret = fwnode_property_read_u32(child, "adi,number-of-wires", &n_wires);
+		if (ret)
+			return dev_err_ptr_probe(dev, ret,
+						 "Failed to read adi,number-of-wires\n");
+
 		switch (n_wires) {
 		case 2:
 			rtd->sensor_config = LTC2983_RTD_N_WIRES(0);
@@ -842,12 +852,13 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 	rtd->sensor.fault_handler = ltc2983_common_fault_handler;
 	rtd->sensor.assign_chan = ltc2983_rtd_assign_chan;
 
-	ret = fwnode_property_read_u32(child, "adi,excitation-current-microamp",
-				       &excitation_current);
-	if (ret) {
-		/* default to 5uA */
-		rtd->excitation_current = 1;
-	} else {
+	if (fwnode_property_present(child, "adi,excitation-current-microamp")) {
+		ret = fwnode_property_read_u32(child, "adi,excitation-current-microamp",
+					       &excitation_current);
+		if (ret)
+			return dev_err_ptr_probe(dev, ret,
+						 "Failed to read adi,excitation-current-microamp\n");
+
 		switch (excitation_current) {
 		case 5:
 			rtd->excitation_current = 0x01;
@@ -878,9 +889,17 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 						 "Invalid value for excitation current(%u)\n",
 						 excitation_current);
 		}
+	} else {
+		/* default to 5uA */
+		rtd->excitation_current = 1;
 	}
 
-	fwnode_property_read_u32(child, "adi,rtd-curve", &rtd->rtd_curve);
+	if (fwnode_property_present(child, "adi,rtd-curve")) {
+		ret = fwnode_property_read_u32(child, "adi,rtd-curve", &rtd->rtd_curve);
+		if (ret)
+			return dev_err_ptr_probe(dev, ret,
+						 "Failed to read adi,rtd-curve\n");
+	}
 
 	return &rtd->sensor;
 }
@@ -950,17 +969,13 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 	thermistor->sensor.fault_handler = ltc2983_common_fault_handler;
 	thermistor->sensor.assign_chan = ltc2983_thermistor_assign_chan;
 
-	ret = fwnode_property_read_u32(child, "adi,excitation-current-nanoamp",
-				       &excitation_current);
-	if (ret) {
-		/* Auto range is not allowed for custom sensors */
-		if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART)
-			/* default to 1uA */
-			thermistor->excitation_current = 0x03;
-		else
-			/* default to auto-range */
-			thermistor->excitation_current = 0x0c;
-	} else {
+	if (fwnode_property_present(child, "adi,excitation-current-nanoamp")) {
+		ret = fwnode_property_read_u32(child, "adi,excitation-current-nanoamp",
+					       &excitation_current);
+		if (ret)
+			return dev_err_ptr_probe(dev, ret,
+						 "Failed to read adi,excitation-current-nanoamp\n");
+
 		switch (excitation_current) {
 		case 0:
 			/* auto range */
@@ -1008,6 +1023,14 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 						 "Invalid value for excitation current(%u)\n",
 						 excitation_current);
 		}
+	} else {
+		/* Auto range is not allowed for custom sensors */
+		if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART)
+			/* default to 1uA */
+			thermistor->excitation_current = 0x03;
+		else
+			/* default to auto-range */
+			thermistor->excitation_current = 0x0c;
 	}
 
 	return &thermistor->sensor;
@@ -1046,9 +1069,13 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
 	diode->sensor.fault_handler = ltc2983_common_fault_handler;
 	diode->sensor.assign_chan = ltc2983_diode_assign_chan;
 
-	ret = fwnode_property_read_u32(child, "adi,excitation-current-microamp",
-				       &excitation_current);
-	if (!ret) {
+	if (fwnode_property_present(child, "adi,excitation-current-microamp")) {
+		ret = fwnode_property_read_u32(child, "adi,excitation-current-microamp",
+					       &excitation_current);
+		if (ret)
+			return dev_err_ptr_probe(dev, ret,
+						 "Failed to read adi,excitation-current-microamp\n");
+
 		switch (excitation_current) {
 		case 10:
 			diode->excitation_current = 0x00;
@@ -1069,7 +1096,12 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
 		}
 	}
 
-	fwnode_property_read_u32(child, "adi,ideal-factor-value", &temp);
+	if (fwnode_property_present(child, "adi,ideal-factor-value")) {
+		ret = fwnode_property_read_u32(child, "adi,ideal-factor-value", &temp);
+		if (ret)
+			return dev_err_ptr_probe(dev, ret,
+						 "Failed to read adi,ideal-factor-value\n");
+	}
 
 	/* 2^20 resolution */
 	diode->ideal_factor_value = __convert_to_raw(temp, 1048576);
-- 
2.43.0

