Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65468385D75;
	Thu, 21 May 2026 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381922; cv=none; b=tVbdvnJkmGX/enuePUNiH7uMhrI/KwWZz2ICBUE1+OkTYboUV1Qu8TCVFLBh1MnRXJGDa7P9rnqCzuecbKKq3mfaw2tsxdqzh8TwcGaSzIzFd2n5beyiKM3WL3WKPHN4bOVteVxriKNTO6LlrqNZGlXWXkh7C1J0lEzT6tq2uCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381922; c=relaxed/simple;
	bh=BTCcpES96/yQE4AQwScd6z+xR77a7/D5WMmasoRVL0M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GieLHWRFR3jQEcDcCOY4kXif6Fq5dDQwhVZz5XG4EPAxxtBFrPPkJ1paQQHMYa/xuj228lBa/viwY0f40J0FGUYWWy8BSOL4CwPJbl3WJoWgypP8GnFQ0B0zAeZY2Rs5wBrlFL7DNxM10K5gePjqYEDT3PYw7I6o1NL1mEY9mJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WuLTsX/h; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WuLTsX/h"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LFM4iT263011;
	Thu, 21 May 2026 12:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MwvXY
	QtkVvGtkVVVpGe2BcBcUocfh233ADnI0Xds3JU=; b=WuLTsX/hiujoZWmYRABST
	obgb5heuwXTZ4hQgdYj5J/gNMY8jy0oN8mV7LSrJIwNWnzLTsslqS4zWOiehvGHZ
	7MPCejXoi0NYWh1ewgXq3DTUCJB2mfr+B+RjGRtlzd220Y6umvpgPkhfyTyuqneL
	uJvp981X7+oEMdLY0JDZ1xdiTmJEPEBGeXGSvFPPgwwm1aJLboc8wrNN7/vwvuka
	5bR+8nClTiGOljwdVRxd5+GarUTo0abd13pV/+ndORa3JgJ2Ys/wMZ+Xg0RIpGzL
	YihHETpHk2x8PhveutwDZ+l0GNR74REOMV+BTaq5MJDst2HMqjTMqNA/jL29W6KY
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e95e2fa86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 12:45:18 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LGjHTo000370
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 May 2026 12:45:17 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 21 May
 2026 12:45:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 12:45:17 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.208])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LGim0o024538;
	Thu, 21 May 2026 12:45:09 -0400
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
Subject: [PATCH v3 4/8] iio: temperature: ltc2983: Use fwnode_property_present() for optional properties
Date: Thu, 21 May 2026 19:42:57 +0300
Message-ID: <20260521164323.770626-5-liviu.stan@analog.com>
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
X-Proofpoint-ORIG-GUID: 0i9vSjOYDASaqpz6nMYyPFXaEsJS2b_J
X-Authority-Analysis: v=2.4 cv=Fd0HAp+6 c=1 sm=1 tr=0 ts=6a0f369e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=aunlEJVJ-oeNMYVCzPIA:9
X-Proofpoint-GUID: 0i9vSjOYDASaqpz6nMYyPFXaEsJS2b_J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE2OCBTYWx0ZWRfX7422l1Oz9zlQ
 BkCVBsxYR+hksc46rXcuzhz2Q3PbkDYjCN0V9UnXPn5Lxv1c9cxn2bcAKHNutuqISAHR8j44m3r
 3917AeA159NR3QzAkt+xrqCJXlePK6q/k/61fspUE7FsdA4TCKfc6yPQNakqGmi/4CmdOT+pd2q
 m164Pwof6daNsbSK5oNhuotdjVlTaRdzrudagbaPLuL6sOUaYIjuVnusy02WStXFRUbPWcbjGvT
 DZCVnOg3whn/bEwN7J6euxa5ZJqUFRhz5M2fp6Jl0k+u9X2GdMZ1WCWBt9pTWcA/YJUv/saxA3E
 T3sKpYxw6GHChv0tLgJqGuWeD+w+gYz17QnqJePpuKvAxiIgfFgfB36Vf5OlrilsKeMBsWycCxQ
 DoCrxXhIpbKNbsdcjlWuCi+nLvS74C/4zmaOaLlGXRhs7LTf8EsY110VluDXElMcP1bE5yv/ZQN
 nRXzEmkJ8D9/cJtPKew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210168

Checking fwnode_property_read_u32() return value with if (!ret)
silently swallows meaningful error codes when a property is present
but malformed. Use fwnode_property_present() first so that absence
uses the default while a present but unreadable property returns
a proper error.

Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v3:
- Dropped the Fixes: tag
- Fixed other occurrences brought up by sashiko

 drivers/iio/temperature/ltc2983.c | 84 +++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 0b9e5f761bd8..10f423fbe9cc 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -669,8 +669,14 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
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
@@ -760,8 +766,12 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
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
@@ -843,12 +853,13 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
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
@@ -879,9 +890,17 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
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
@@ -951,17 +970,13 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
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
@@ -1009,6 +1024,14 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
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
@@ -1047,9 +1070,13 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
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
@@ -1070,7 +1097,12 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
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

