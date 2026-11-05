Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871395;
	b=e4QNZlL5+tR+QngrW3YtkJaM5cPZM24ca/2zZrBMVYhhtxOVIQnyd/Mw30wHA7GbHVEh
	 4JQBM80sEkqKWiz/aQowXfGa62spQGE4SVLNhpx82+6gpTOqBME6X+iX7jxQvuNUQjYyg
	 m5mBJn6huEbImVRi1JD1vTB5QWmFmHoxrzyKerguju+MfHR69b0fA9EdyMzuvLhibgCrE
	 ehKsAu8NWaQHfVwgqCWwSgPWZxmiH/LCkkkY1LoWBwe2/Q8FJcqHR5NqJrpcAFIw7ErST
	 cHiMKUlJDRWl9wRRfsV2Qfvu2XhktSKrKeTCXus0O6njnTIeqUnSEDTQ9ygeBf4Zr0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871395;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qzal4fAhEMaqUY7JVYGl3jG8NExy2Nx98oV60M21/Ws=;
	b=JdoY2LrQDcyVec0fLtROTw70/8ws6tzeMhoVCf/nZ2pl1RgbRpnMaPR/qMlEfnB5tlRI
	 Caz87wBktZ1O+pL58QF3+HCAJWvVjdbOyXpY+paK6nbCFXUFTpcKHQvX+QycmTjEnFjMj
	 jMW6FAPCKepw2GKgVTAizQhRKNL09W0CLY2uV5i33zbH9uarAQo0JkX6GMoYgLozlxtr4
	 gpcRcQTq+Sx3cUuLHuzghfuFHmCUSanTJ0DFSTJdUEtbKAQnb38TrwgYLHtFfJ5L3XlPK
	 mQ33sdpih48ZE3s4lNY7dcyGlxcndNByu4KHKSt5upwDOOb9Hue5OuCqYwU1qzxAXcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=bOuIopCa;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=N4Fq4gsT;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A54606A338;
	Thu,  5 Nov 2026 09:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50A54606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=bOuIopCa;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=N4Fq4gsT
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56WrWo096544;
	Thu, 5 Nov 2026 04:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=qzal4fAhEMaqUY7JVYGl3jG8NExy2Nx98oV60M21/Ws=; b=bOuIopC
	aCD/OovQcH+H1pNwBW0HvAbKX2pAVXJbJO46Dg56br6XPiEN3wd2CZ0QRr0CfWBH
	v0qAkss8uzLDT08MtRjQ5dnTiNTxdgzHTYqIi1kYy4ags9pRyFVzq+1PdIdchpqF
	N0RvgTFyFD/Gn/LQ8o3ExHg2nAyPU8PpPg/WdE28qOn42/SBU1dVwC5JQJ+yKw0Q
	EMmZXh+GO/4HbX5VXTwwEWCSLOdc5j7+1DYeHMPXAXnbqT8DS7oklXjjNUFOlJBR
	2a8PGHB4fwRoxzrp9nJS70FF27GZzK6JF+/au1k5BQauMgjqyVXFxbh4i135EmKW
	iEtD6TIm82Kgc2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qzal4
	fAhEMaqUY7JVYGl3jG8NExy2Nx98oV60M21/Ws=; b=N4Fq4gsT9W4ToD4ANe0O1
	nGWUx1m6G3vwdqSSVcMzMZaJZIWrlqNB6w37ZlFxjuxQvl1NRWLlCD40q2zugWxB
	YDT4CbVMQNVxjPmbSf4+XNaz/Rn0mAxwgtMO7MQTQy3kAYJAexozfFZxJv53gw6A
	hj0Ldu0iG/H3CXHeANF8RE7dw8l7vJS1A0msHPsby9aPREzGn7JRd1lvn6pbdiRo
	vVDLEArLqHLN5LIMuk8BYBGLUAgFkXwmy93Idtq+YC+L1ot3XjoAKXXGwb0C2wLv
	M9qgvCJtmUh6UDos2Y5MZmQpCJk32t96GxtnGBy/qCDLzfmRseWSqp6o134KLQi0
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hr9xd4f4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 04:36:32 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A59aVl8010859
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Nov 2026 04:36:31 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Nov 2026 04:36:31 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 5 Nov 2026 04:36:30 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Nov 2026 04:36:30 -0500
Received: from HYB-0FPP35J6CsI ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A59aJYM024438;
	Thu, 5 Nov 2026 04:36:21 -0500
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: <jic23@kernel.org>
CC: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Dragos
 Bogdan" <dragos.bogdan@analog.com>,
        Ioan Daniel <pop.ioan-daniel@analog.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] iio: adc: ad7405: Add support for ADuM7801/7802/7811/7812
Date: Thu, 5 Nov 2026 11:35:31 +0200
Message-ID: <20261105093531.7562-3-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105093531.7562-1-pop.ioan-daniel@analog.com>
References: <20261105093531.7562-1-pop.ioan-daniel@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzOCBTYWx0ZWRfX4+Ls+/G3mxE6
 nJO6/ayTliglRaAyi2lTM3OFtQO8Juw1ikHKJ6qm/hQ7ZoQzZtgn2hdqwoF4xfBHVhhncPyczHK
 IKxF89/liWkZ7RJDfIwF4hPdb9A67DFuyLKazL1LSid5Z0t+wUUP
X-Proofpoint-GUID: sXD15OMTLMpRl9oQDR6VjXhOHPV6bB0V
X-Proofpoint-ORIG-GUID: sXD15OMTLMpRl9oQDR6VjXhOHPV6bB0V
X-Authority-Analysis: v=2.4 cv=JrVkP84C c=1 sm=1 tr=0 ts=6aec4e20 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=13Dk0xqSWolDs0EYx5YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzOCBTYWx0ZWRfX/eXck259yuKA
 QemhsBkuU2tDr0JUCNdVDaK5ACNsozTpw2m1yxzokrKCdNy9uvkhMP9EsgC7T+tMFbBxnaMw2s0
 P9rNHgwi3g0CD0Twbx/gOBaDtXiMIzzeAVAXgFJEW7z+YzQ10VM8Ce7UFg8gY3eHuVUu2kUgw52
 U5TmISsXZ6SKz1uVTpgPJx5pr+EorktipkMzpMmVSbUN0aKeJTubkrB2S09VXp1W2l+nEoKBF3U
 HzHm2A7Odh0sz9x8YJKR/m8P94wBBXaUoI/55Xj27zikMl3n/cxgB6x2RGn3StGsdHz40eor3qn
 OXYkjI2KxSMSlOhrCCs27uWdhywnxCnEUtW3nKAtGDRZoOTwYsHBYmk5yiyZb57BaS+iWqhaLh+
 MBtqRr46O2wYLB/LSDj8I+w6Zv9GTYzJ9Eng+gRmbKRJtwKKHUeDpvvGTp7NWVXWez4iGEJMxU+
 RHfzfYcpxAh9KuBjZSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050038

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
changes in v2:
 - keep dedicated match entries so the IIO device reports the real
   part name (the binding now has fallback compatibles)
 - list one supported part per line in the Kconfig help text
 - make the Kconfig prompt generic instead of naming only the AD7405
 
 drivers/iio/adc/Kconfig  | 14 +++++++++++---
 drivers/iio/adc/ad7405.c | 24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 3 deletions(-)

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
index 0996f48d76f1e..ee9873b47a84f 100644
--- a/drivers/iio/adc/ad7405.c
+++ b/drivers/iio/adc/ad7405.c
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
-- 
2.34.1

