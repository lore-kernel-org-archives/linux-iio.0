Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950827;
	b=eLwVlWbseoAXPNG9WbUebNzvHR+wVdYlurwxv5bKWSzLfvRhIIG1WMKvHMdVUiBSlMNJ
	 zWjxBEDkzV/HP1f3cmGTDP+alQe96XIXwGYSj8M2OtOzYEkZHUUf1DztrCQN4pNK7sw6C
	 hjukJvIrc5CZ6whiY5ajOWVBeeseSa0Izpy9XqWuxFXXsJacBu7zohq5G8JrL+l6krb7j
	 mXph1BnpW3oQMsOt9yrrGCFnIFogmB9/VqpNaRsh7yEcHwFzMgxiEonUWWSLQqujM3O3y
	 10WMQHjy1JZRRpT0VVuHHk3wl7eV8+bcuPfaVI/MwM+WJ/qujRbCUUekBSItCrld2Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950827;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=u4oCT08njFkeGXfEt/T6Wc1zTH2R7y+7VZ4fKY1vwkw=;
	b=s6bWyw8efyx873IncH/3+J2m4Syk1Q4ZlAgY+K6PVjwDAM9IfZBS3Xg9R2MG27lQxPIc
	 cjnv3K9OlUOcRuh8f4lU7dI59gubVJBejZ7xxjNlFqr//DYALm5HBZsIqeoHF1jwue8V6
	 iXq1eU6emPnvljFYkkuIN1bPnpBFgAdnuFWIt7tAHsoru+WFYxIcDpe0bzacTLI5RbQh6
	 LZl8IRqdPYFFZs6gB6/TEF2+K7Via3VPYOtTXBS3AWm3o5sts3Rm6vQmPsSZ6Jsqk8XA7
	 vW6fZ9wAE1zEPSBI1T6EaAt78nThxnuViX+K04vML37MY1KD42doPrrsLPV3scEJdbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=EgwnVfsS;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=d6LLBPMn;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03471606A32F;
	Fri,  6 Nov 2026 07:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03471606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=EgwnVfsS;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=d6LLBPMn
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A67R5dt3164176;
	Fri, 6 Nov 2026 02:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=u4oCT08njFkeGXfEt/T6Wc1zTH2R7y+7VZ4fKY1vwkw=; b=EgwnVfs
	SsVyHNwO9qv2pJMOsVlB4fI8AgAVyzevJ62zL4N7Lh6kOTG0CfSs9sMQk4YyZgMi
	gb9gIqfHfxE3lfWyhY7Tr1oNrUqRZVtkle2FoSRzAFao6NdFPiCvl0RoVGXIm+60
	plhanZJrR69LwiLFJeuaD7XWnUBKGXO3dTHRupKn7gLn1EBln/HcVif4XKOHVMqy
	rhZ4hqzQfCSEP8bXwH1RBSNjUW0A5nO+Mjk3yQk8DuL8vq/vRNtTFLqfx2VZMO2D
	+jPy0HyR2Q8IfGYPSLaFNMU0mXix7+dShKvkAPBlt5fO/rp/7RJXAPzom+Gy1+2A
	ZdcMAf4OTeJNsPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=u4oCT
	08njFkeGXfEt/T6Wc1zTH2R7y+7VZ4fKY1vwkw=; b=d6LLBPMn59Czhq1tUpAGa
	wV46caOTS5J1ypk1pk+lFG4WlHLwR/Vj07ccbe5plyfRd9khPmobYs6Z35bPcjzN
	lPdbBQQiJQ2+zxZYzakySZhPBjpsR7ZYs0AaZby7t8MTEsZ1Z4gmqW67PhZtfzZM
	WS4ImN3AXZ1wwbmFjCeBPhRk7CMOMCbuM3k5X/JSY1hJq+5vTBTUJP6dgTlNtAzZ
	m3iYZo1mJKtBvT8EyDhi6kWRalSNXr4Orpg8EWTpaKC56cKkVwq2oDy+AVik+k9r
	bOw5qT6hf2e1ICRWHGNjt+5bIY0ilG6jcFuIPa6zNLRX6bD8F/qT6yBbdKmH62Wk
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3pytftb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 02:40:23 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A67eMEK029374
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Nov 2026 02:40:22 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 6 Nov
 2026 02:40:22 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Nov 2026 02:40:22 -0500
Received: from HYB-0FPP35J6CsI ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A67eBwB028733;
	Fri, 6 Nov 2026 02:40:13 -0500
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: <jic23@kernel.org>
CC: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dragos
 Bogdan <dragos.bogdan@analog.com>,
        Ioan Daniel <pop.ioan-daniel@analog.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] iio: adc: ad7405: Add support for ADuM7801/7802/7811/7812
Date: Fri, 6 Nov 2026 09:39:37 +0200
Message-ID: <20261106073937.13927-3-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106073937.13927-1-pop.ioan-daniel@analog.com>
References: <20261106073937.13927-1-pop.ioan-daniel@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzMCBTYWx0ZWRfXzPSfodF6K+vX
 6FOnqKkFjacuDOO/jCAq1jzX7WlxV4lQVwBcLXNf54ctNftoPNUXkgpUpXJHqYa+GrqY7wX+QkA
 H0BX1LEF/7w9u/nKVdCx+SAnNNl4/TST+9TKgQLmbIihmQ9e0DqU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzMCBTYWx0ZWRfX9oB4Hz2d2QZw
 Y4A542BAeidcWQQXMLEd2lj29JbYP3Jvw4brauJ+pCMop6GSlT4k8CB8I4gifIMTUSSugCiI0f3
 Zt14iUD0Hf964SkH8PHXi5BX18py6pkCylvc2kZPI1TBJIAqtXit4Y15Bkb32ttqy6X84lmU/hM
 +iB2WDYnMLU0t8upOsJsRQxWWyApm+NX0Ikwcp+FtWHbL6d4P5ppDGV7UoDeLeVkudToFb/40//
 wjmSc18Bzqhwru/VlXaIBy0fSoXTbizSZOeQrSdCyjEn+CTfN1twbo2IYz8o+8sPEwkok6UxyXI
 /P5EGlg++ZtvTocqoUVKP/DhuyqpQ+IYsV9RMdvxm3vejw1M31LGbXJCc1FHpBvB3uEjO/+VE9n
 GtkJkCNOh2deFk4W3HGFCWUmXkJYkfinvh6S9GgUAzKxqn3x+K3UdMkYqRo7f7lSKbGJw4xJXht
 eZcTKH/tI2Q5lEgqGcQ==
X-Proofpoint-ORIG-GUID: nFC14UrCnqcCzmzJ0jzGfTtdPer0ZB_S
X-Authority-Analysis: v=2.4 cv=TYcDJhQh c=1 sm=1 tr=0 ts=6aed8467 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=x9WmffaYgfafupnZSc8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nFC14UrCnqcCzmzJ0jzGfTtdPer0ZB_S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060030

Add a chip information structure and a device tree match table entry
for each of the ADuM7801, ADuM7802, ADuM7811 and ADuM7812. These parts
are handled the same way as the existing ADuM770x devices and differ
only in their full-scale input range: ±320 mV for the ADuM7801 and
ADuM7811, and ±64 mV for the ADuM7802 and ADuM7812.

The device tree binding lists the ADuM7701 and ADuM7702 as fallback
compatibles, so the driver can handle these parts through the fallback
alone. The dedicated entries are added so that the IIO device reports
the real part name instead of the name of the fallback part.

Rework the Kconfig help text to list one supported part per line, so
that new parts can be added without rewrapping the text, and make the
prompt generic instead of naming only the AD7405.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
changes in v3:
 - use the same description in the Kconfig prompt, the top comment
   and MODULE_DESCRIPTION()

 drivers/iio/adc/Kconfig  | 14 +++++++++++---
 drivers/iio/adc/ad7405.c | 28 ++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f8456c8039883..bdcb1f5c9a218 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -355,11 +355,19 @@ config AD7380
 	  called ad7380.
 
 config AD7405
-	tristate "Analog Devices AD7405 ADC Driver"
+	tristate "Analog Devices AD7405 and similar isolated sigma-delta modulators driver"
 	depends on IIO_BACKEND
 	help
-	  Say yes here to build support for Analog Devices AD7405, ADUM7701,
-	  ADUM7702, ADUM7703 analog to digital converters (ADC).
+	  Say yes here to build support for Analog Devices isolated
+	  sigma-delta modulators:
+	  - AD7405
+	  - ADuM7701
+	  - ADuM7702
+	  - ADuM7703
+	  - ADuM7801
+	  - ADuM7802
+	  - ADuM7811
+	  - ADuM7812
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad7405.
diff --git a/drivers/iio/adc/ad7405.c b/drivers/iio/adc/ad7405.c
index 0996f48d76f1e..4eaa272a48ae4 100644
--- a/drivers/iio/adc/ad7405.c
+++ b/drivers/iio/adc/ad7405.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Analog Devices AD7405 driver
+ * Analog Devices AD7405 and similar isolated sigma-delta modulators driver
  *
  * Copyright 2025 Analog Devices Inc.
  */
@@ -158,6 +158,26 @@ static const struct ad7405_chip_info adum7703_chip_info = {
 	.full_scale_mv = 320,
 };
 
+static const struct ad7405_chip_info adum7801_chip_info = {
+	.name = "adum7801",
+	.full_scale_mv = 320,
+};
+
+static const struct ad7405_chip_info adum7802_chip_info = {
+	.name = "adum7802",
+	.full_scale_mv = 64,
+};
+
+static const struct ad7405_chip_info adum7811_chip_info = {
+	.name = "adum7811",
+	.full_scale_mv = 320,
+};
+
+static const struct ad7405_chip_info adum7812_chip_info = {
+	.name = "adum7812",
+	.full_scale_mv = 64,
+};
+
 static const char * const ad7405_power_supplies[] = {
 	"vdd1",	"vdd2",
 };
@@ -232,6 +252,10 @@ static const struct of_device_id ad7405_of_match[] = {
 	{ .compatible = "adi,adum7701", .data = &adum7701_chip_info, },
 	{ .compatible = "adi,adum7702", .data = &adum7702_chip_info, },
 	{ .compatible = "adi,adum7703", .data = &adum7703_chip_info, },
+	{ .compatible = "adi,adum7801", .data = &adum7801_chip_info, },
+	{ .compatible = "adi,adum7802", .data = &adum7802_chip_info, },
+	{ .compatible = "adi,adum7811", .data = &adum7811_chip_info, },
+	{ .compatible = "adi,adum7812", .data = &adum7812_chip_info, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7405_of_match);
@@ -247,6 +271,6 @@ module_platform_driver(ad7405_driver);
 
 MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");
 MODULE_AUTHOR("Pop Ioan Daniel <pop.ioan-daniel@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7405 driver");
+MODULE_DESCRIPTION("Analog Devices AD7405 and similar isolated sigma-delta modulators driver");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("IIO_BACKEND");
-- 
2.34.1

