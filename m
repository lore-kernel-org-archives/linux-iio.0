Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621685;
	b=yK0o4INaXXbwygnSkP6Mtj02vlkmcwoTnLDdTptXEmSp4Po4w3PExg1nRAOH3FAOr243
	 LHiwEh7pQChJq0Holxum1e5gXPYdYWaoFoHllWIOhQzT7KEGw6271DcrlqF7RlE72gIna
	 C1BC0Ad1NXgATWH4pXPYnabAMhyLYexRK8lStcXgg7pkkw5k27qxjlMcsDIxXaYXtPMjp
	 8sugS9xAp8WvDGYOjGalRG9Vq68ORlhUbz2z+legAFP2U9L3u44c78CShnTHio2RYqrDq
	 5LCehpJEzCchIj+ieZSC0UIQLcNQF1Rnn7NKbRwZ6R2SMpNGwc4N5oGsHPIPsc7gYnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621685;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4pYys262BoSP9st1EWB0AAZfQAXhEMARnoA66AWBafE=;
	b=SPIWFtEKR73aAbpbp5U6lqRcb5ZEKI7yVfBy7an+KiPLFnxZ477FuaeACEYkvYg6pCtX
	 B9ELrruRh958cn5SsL3Z0cMkyTUyOQ5h+lyG9Ob+SlgCWfmQSElMO7FhNYqjULJ3KOf+N
	 a7s4xhExQ3mKeT/vo9rRpTrQw87pHorsEO9biqbOnJIiirAFdO2n/dDiu9znBIqMpQPDM
	 t2QBY7Yso569vUBSZtHFJnvUqkfAB7Aa/sQnfDvtxMZzkxmlH+UviY+TzvEqCqNIewFjT
	 6a4tqckHM0dn0WUKQ61AiqxkUREk+saDiHYK0yAO7WIeAP0DCm6zUzLFrxh2htKVx/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=O5Qo49TV;
	dkim=temperror header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=YhbFCFgs;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9570C60A2611;
	Mon,  2 Nov 2026 12:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9570C60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=O5Qo49TV;
	dkim=temperror header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=YhbFCFgs
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29BVu51304387;
	Mon, 2 Nov 2026 07:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=4pYys262BoSP9st1EWB0AAZfQAXhEMARnoA66AWBafE=; b=O5Qo49T
	VDoOkzDGhP3gTSZg9CQsRcoDCZiNN70BGc4KmuPJvbLfEfYvzCs1bEOp9QJVGQTa
	8TkEtHsXP4cEsNl+/iOlyzkrEvKTV6zrkJrdw0EG+AenpoNkeJSRhMSA1lkx1j6g
	QMN4VDZj4MOKrFhrUJMgPhdJvwyZ5qlzNlj3KF0Qgdo8ED1/mPEgSmthYsoqBKGv
	oixH9syL3rskUDlLOSfvmWRbWtUnOKJZLIVuT5NE3MNj4rJpp34mnh5PWK99uEZL
	ADskQANbwsK1d/Zxx2L6qbnTsmV98mTt3RxC0CtaC5EzdlK08ez9do6xuQiR2qKC
	rS9IQgNENqJBwYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4pYys
	262BoSP9st1EWB0AAZfQAXhEMARnoA66AWBafE=; b=YhbFCFgs6cjRj79cY64Jl
	Z9ldx9YN6PV2IRxuLt7AtviBzkE57SOr+XUJXJ0Y+FTYKxIe0capQMrP03vnwcJv
	Od49Y/R1MOaYhgUYquAkiwAmQQQAwUEasf4ck5Q7HmDO3KEfSXBM4GHbn7Pc9v6l
	0eRII3GlmC05JIjRtdtxWTQ8SYut3Zyfd5izfz1iSEBqpawWocFNZXtINq1rmvwG
	jgyIsGmQIRF6EqwJxv+nTt6+CQv82ang6sPDLujmeljfGlL64NkV/TLD+UkhlQnN
	3r3XHe+oiiH2muX1xbA2D+1+wyvxj8DDER2I72Y8dppR9lmaAAuLOtRaMXKD9NoV
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hpad3bvjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 07:14:31 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A2CEUTa042531
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Nov 2026 07:14:30 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Nov 2026 07:14:30 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Nov 2026 07:14:30 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Nov 2026 07:14:30 -0500
Received: from HYB-0FPP35J6CsI.ad.analog.com ([10.135.2.44])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A2CEE0F021851;
	Mon, 2 Nov 2026 07:14:23 -0500
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
 Bogdan" <dragos.bogdan@analog.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Subject: [PATCH 2/2] iio: adc: ad7405: Add support for ADuM7801/7802/7811/7812
Date: Mon, 2 Nov 2026 14:13:52 +0200
Message-ID: <20261102121352.23741-3-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102121352.23741-1-pop.ioan-daniel@analog.com>
References: <20261102121352.23741-1-pop.ioan-daniel@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0OCBTYWx0ZWRfX9F4vsRtpf9qV
 sCEug5QOiHS1bPLZwykJv5BlTKsf2NwcDIQAxsF8NhGgP9oXz9SXRc+VfyvBw4+t4s0OJnaYsO4
 z1YY1N4TKflr6WCt4FcQWiwDqW8DlcFBjtL+wkN4WYcT+0/bCHGaMLiAk8dkY75socApiWD5DP/
 bjtEqeIth3fWdC0075RJ1x2aB7JhGhPuu3FBOG0ynLE17SWk+9tJC29HuyMZEi/nqCIuCg+dog8
 QtwEipFbPpSWByiscZ4llMzmW1ZokQFMoMxNlmmVs3y7xzBFUmMdiB74HdNEiPnGm4o7WNZrZjA
 NjtB1z6OmRG1yHG67QpLXo0oVfHfgHZBSAB0ZwX/SFa/DrKRr7iXrqU2fR35o5cFe8u+zqSvhlB
 BSGFnzGNq5qgbozuLq2xdcGY6nsmnKue4FqjpHkflHdtk0MTF7XMVjxYHcziew1i+Vzq+5qnl8y
 bnlDZYRe5W5l5Bkvq1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0OCBTYWx0ZWRfXxpZPn7CQ1Dhv
 EKzCb957+BBewkbZ4/4eUu/9vUsEI8WN8xgHGnotZtb5mPKac/Y8NeggWPHG6WSu0ad0ctCKq3M
 VW4tERLrCmHRRzeyTI/mJGwBbIPHvm26+arShA4+DZHV0UdUtNOm
X-Authority-Analysis: v=2.4 cv=YL0KWhGx c=1 sm=1 tr=0 ts=6ae87ea7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=YT1L1IOf0YprgsJQ2eIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GebDVp99DRRY2NWCPxh3LgTjHfR-aIQ5
X-Proofpoint-GUID: GebDVp99DRRY2NWCPxh3LgTjHfR-aIQ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 phishscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020048

Add a chip information structure and a device tree match table entry
for each of the ADuM7801, ADuM7802, ADuM7811 and ADuM7812. These parts
are handled the same way as the existing ADuM770x devices and differ
only in their full-scale input range: ±320 mV for the ADuM7801 and
ADuM7811, and ±64 mV for the ADuM7802 and ADuM7812.

Also list the new parts in the Kconfig help text.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
 drivers/iio/adc/Kconfig  |  3 ++-
 drivers/iio/adc/ad7405.c | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f8456c8039883..0458b326e153b 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -359,7 +359,8 @@ config AD7405
 	depends on IIO_BACKEND
 	help
 	  Say yes here to build support for Analog Devices AD7405, ADUM7701,
-	  ADUM7702, ADUM7703 analog to digital converters (ADC).
+	  ADUM7702, ADUM7703, ADUM7801, ADUM7802, ADUM7811, ADUM7812 analog
+	  to digital converters (ADC).
 
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

