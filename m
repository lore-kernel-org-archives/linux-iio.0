Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA35519BD;
	Wed, 23 Sep 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177980; cv=fail; b=JD12VyWZmjBeSXkZrnGdU4mtC+/tGcDaipIb1O+uPQrHmqn2lZJbRsxmCILRY6808U+JhkogkZKLp+G6hr5lZ3G6HBkkCSJDgiFciOy/1iZf9D6h/jCDq/GMZdnXiAbH6eVAb/Og7uauqz37EcD8Jo+slMogx9FzclQrhLaot5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177980; c=relaxed/simple;
	bh=1MB6Mofld5mUU1Ssyy0Im6BpaNXVDrdfl8A5srXb91g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RvYJEGrVMCvt2gxrHTO7JlQxcPnzcU5tD2qHLPYfFN6qltvNSrfDS+TTHV07LUv0t22n/YyrA8rGoOnQopOqEhL5XMCC90FfrRqOiBhyLhpinyDn2gQbkFY4KbszbeAYgdtmcslk66QQ2TU/7XHVYJPUBA+eD5tEAmkkJMV8WK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=DGniFHH1; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="DGniFHH1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQS/PQ15bxtu17q09nXOZVaoSURIV9Bx2PHApq9XSCZGaI9seub5AFHrm7FmO13pqU54MtKOPUElKIEXcoUl15THKbC+VaA6e5Sr0RSUBwB80u39SqklJgHgn8+hMbUHU+z7ZYCTriSn4ArOirKnqJBRI9IF5EPps859xGkhTbeicyYTNpdqCT6eiuoHJun8PeDyUnHUnmZrhgyfT7odVpdYCDrqEe18g6uniwcBpafoq3ZpZl2PILykv1FXu2P0rFBLJq/FhaAPzUvgVnzbwNKWXfIzIfazQlQg2A2A5q8Ppe2h/F6U/f4Gzvbcx4kWE3SDgzEuJ0FgXfNyIeQ8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSDQQtaGefJVnaguHiRfRQliIJ0M8A42nurTRC7g5I4=;
 b=D7lUh8Kc5VhEDmnSaYtx/4OtnQzyyuyX5C3uK+vX7oRuzNyUFqVAnQnTDSAWIdAwHtxDhsFg0zso6SFZhA2xc2j4OFvXEwyuyi513E86QcZG9y+YhDjR7vnI8ydI3aHdfo/RJ6F8Nl0NHwmWJv1USbzAvVhI2Vkm5G5x88WoeeLFB+opFou2OvPClr5WhdIenxgzr09P8YN4Dk2IK1zPECqSH6BTo59I0SEvQouQH5mUWxkT9qw2Vr7LdnyFvujlOVgVG0v9+Y8oppv4Ci313PVJgu3A7k22qaPJwdjrsnpYK5xRtV+B227Yo3bsxRvxH4rWhC+2X9jMGqxewhmpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSDQQtaGefJVnaguHiRfRQliIJ0M8A42nurTRC7g5I4=;
 b=DGniFHH1HGfw9Dh/5QWjysjbFOzPz2NKF8tEGbxwRJOcP0+qqmzteW7l47G2f+BByhX1Gep9Pq4LMv4kZjbVOiT7z/t0E/c7bJn9tO8qiB09tGs7IDxkAkl2d+gviYza5xAOS+Dqy7MY53F8sgw1ZDzProl3TZ7Z8RKPfIAYGRjMzyjKtiSDAzvGDzZFtODEK3MmNf5A613kfI3fujivKjVaDWiHBIqNH5Se1Ha3c8X2sdXLWo/jXUjPQbmhfGqohwVQ7gP/S6gIiPCtRZOVtTI2240XaK9ywatJ3/KpTwoeMwQ78snq3limAEHOHJBLEy2R7pu3OBfDOeRiNpqfug==
Received: from OL1P279CA0044.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::13)
 by DB9PR10MB6642.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 15:39:32 +0000
Received: from WA1PEPF000099CF.eurprd04.prod.outlook.com
 (2603:10a6:e10:14:cafe::49) by OL1P279CA0044.outlook.office365.com
 (2603:10a6:e10:14::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 15:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 WA1PEPF000099CF.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:39:31 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:45:20 +0200
Received: from localhost (10.252.7.7) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:39:30 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 23 Sep 2026 17:39:08 +0200
Subject: [PATCH v2 05/14] iio: adc: stm32-adc: rework internal channels
 data
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260923-adc-stm32mp25-v1-v2-5-46bc019537c6@foss.st.com>
References: <20260923-adc-stm32mp25-v1-v2-0-46bc019537c6@foss.st.com>
In-Reply-To: <20260923-adc-stm32mp25-v1-v2-0-46bc019537c6@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Marek Vasut <marex@nabladev.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF000099CF:EE_|DB9PR10MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 140454d8-77a8-4662-6c81-08df1988dc6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|23010399003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	L3mt2KMwPjXX9lM7t8L+6xT5l5afeUrP/muPaUryIUPxScKQO9+85YbIQXhhZtaJMcdv5uG71FtLct740c4buTp87YzGYITF+C/0yL1/pusVpnsqNvlmhA/cv6Ki8e0L3L5pL9uDdcsxBKI1jvH89ZDmIBXY22qvmPQ8r5AmniCLxIN+QsHs1Hrw5Rpg8PVUaU0lxkiw4zos0LmopfQXCB/71FRS0MKXnzMa3YZuU0+olgSIxi335ReAOZPdmg8mdBzAQiGQqXCVpCs+m6uYMk+KoiVyIcs6RL5wdw2EePG2rQJEfqPET6RDil+IzN3Mbj4F7KK2q9I2s95Jj6Stz0Tod/cRjflRTq4qh0iN+VAzaic+Nvb4GA5U53s2LiqzFdxmVj3gNB3xFosyr1lMnpUL8nY/W/Cv1S9aDUJYmn2wU6nhCReHU4YP2UWcLrKYYQeBCLh3VeA4uVnDkZ2hwwLBsESMHezyCrKyBR6A2lASrFFcGjjSTTjEvl6TX4vYnmBXtPvrN5ODYef+hIiY1JBU+mxxXXFKckCVcwGcpnRtU6yt82ExcNwvEWUWorNlI4K862a8w8Fjn6KXogzEisYCF+7DSYc3oPSp36ZzrSibHghAWFNkQQvBia9DVEnkIxcaIzk9AALAsQkcqOTLjfl+tJStzR3OHfMNBVA1/kjvzJUmJAoJM869RcfVVrYG32BEegyaYV8ogAQdVmAYpw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(23010399003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/NW4IaVNw/gQ2J+oBOF2V2XWSyJeWM/bs5BSqM5puYAzxPstNLd0t4Y5Jvw6eBRiul7rNVxmaDEzqMVUvgGURIFRvVVu9qbjG5NrYrzLc3eh1wYmIheTbBcKgWepwygLbSDTQBhRztbccuRfuZCk+BJ8p5Ocm/Nz8UR0FExEjgwACtcohzyR5eZJLigauppQQ56xLEv5xW9YvLUa3D/4ihQxOGm656Oi1p12TGsFXodbCXcCx/xvUQqn6FNLNFEnE12L/F4cYl/t59KaJUF9jiH48POpQ3gD8cGMT6KqkiJMdjH6H4LtGfCruD+8Cx0v8fN6nHtog0Vs1L8FAS/HAmJsxsBfoXe1jhrMCt2R2y6wqDNCVa6odHVave3wOJD4Wvfahy7Oy1f5c/wjkdm5OOrbzjX1mtTFQACPn8p67a6UP82W/KM4p2wA22563nc0
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:39:31.3153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 140454d8-77a8-4662-6c81-08df1988dc6d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF000099CF.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6642

Diversity in internal channels data array lead to have zeroed data.
To facilitate addition of new internal channels, without touching
all array initializers, only focus on exiting channels on each
supported ADC variant (e.g. each SoC).

This also allows to get rid of static_assert() checks.

No functional change intended.
Cosmetic update: remove comma on STM32_ADC_INT_CH_NB as it should
always be the last element.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- new precursor patch as suggested by Jonathan
---
 drivers/iio/adc/stm32-adc.c | 51 +++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index ddf74c674da6..ac60c31de7a5 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -86,25 +86,16 @@ enum stm32_adc_int_ch {
 	STM32_ADC_INT_CH_VDDQ_DDR,
 	STM32_ADC_INT_CH_VREFINT,
 	STM32_ADC_INT_CH_VBAT,
-	STM32_ADC_INT_CH_NB,
+	STM32_ADC_INT_CH_NB
 };
 
-/**
- * struct stm32_adc_ic - ADC internal channels
- * @name:	name of the internal channel
- * @idx:	internal channel enum index
- */
-struct stm32_adc_ic {
-	const char *name;
-	u32 idx;
-};
-
-static const struct stm32_adc_ic stm32_adc_ic[STM32_ADC_INT_CH_NB] = {
-	{ "vddcore", STM32_ADC_INT_CH_VDDCORE },
-	{ "vddcpu", STM32_ADC_INT_CH_VDDCPU },
-	{ "vddq_ddr", STM32_ADC_INT_CH_VDDQ_DDR },
-	{ "vrefint", STM32_ADC_INT_CH_VREFINT },
-	{ "vbat", STM32_ADC_INT_CH_VBAT },
+/* STM32 ADC internal channel names */
+static const char stm32_adc_ic[STM32_ADC_INT_CH_NB][STM32_ADC_CH_SZ] = {
+	[STM32_ADC_INT_CH_VDDCORE] = "vddcore",
+	[STM32_ADC_INT_CH_VDDCPU] = "vddcpu",
+	[STM32_ADC_INT_CH_VDDQ_DDR] = "vddq_ddr",
+	[STM32_ADC_INT_CH_VREFINT] = "vrefint",
+	[STM32_ADC_INT_CH_VBAT] = "vbat",
 };
 
 /**
@@ -2268,7 +2259,7 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
 	int i, ret;
 
 	for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
-		if (!strncmp(stm32_adc_ic[i].name, ch_name, STM32_ADC_CH_SZ)) {
+		if (!strncmp(stm32_adc_ic[i], ch_name, STM32_ADC_CH_SZ)) {
 			bool na;
 
 			/* Check internal channel availability */
@@ -2302,7 +2293,7 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
 				return 0;
 			}
 
-			if (stm32_adc_ic[i].idx != STM32_ADC_INT_CH_VREFINT) {
+			if (i != STM32_ADC_INT_CH_VREFINT) {
 				adc->int_ch[i] = chan;
 				break;
 			}
@@ -2715,8 +2706,10 @@ static const struct stm32_adc_cfg stm32f4_adc_cfg = {
 	.vref_charac_mv = 3300,
 };
 
-static const unsigned int stm32_adc_min_ts_h7[] = { 0, 0, 0, 4300, 9000 };
-static_assert(ARRAY_SIZE(stm32_adc_min_ts_h7) == STM32_ADC_INT_CH_NB);
+static const unsigned int stm32_adc_min_ts_h7[STM32_ADC_INT_CH_NB] = {
+	[STM32_ADC_INT_CH_VREFINT] = 4300,
+	[STM32_ADC_INT_CH_VBAT] = 9000
+};
 
 static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.regs = &stm32h7_adc_regspec,
@@ -2737,8 +2730,11 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.vref_charac_mv = 3300,
 };
 
-static const unsigned int stm32_adc_min_ts_mp1[] = { 100, 100, 100, 4300, 9800 };
-static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp1) == STM32_ADC_INT_CH_NB);
+static const unsigned int stm32_adc_min_ts_mp1[STM32_ADC_INT_CH_NB] = {
+	[STM32_ADC_INT_CH_VDDCORE] = 100,
+	[STM32_ADC_INT_CH_VREFINT] = 4300,
+	[STM32_ADC_INT_CH_VBAT] = 9800
+};
 
 static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.regs = &stm32mp1_adc_regspec,
@@ -2760,8 +2756,13 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.vref_charac_mv = 3300,
 };
 
-static const unsigned int stm32_adc_min_ts_mp13[] = { 100, 0, 0, 4300, 9800 };
-static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp13) == STM32_ADC_INT_CH_NB);
+static const unsigned int stm32_adc_min_ts_mp13[STM32_ADC_INT_CH_NB] = {
+	[STM32_ADC_INT_CH_VDDCORE] = 1000,
+	[STM32_ADC_INT_CH_VDDCPU] = 1000,
+	[STM32_ADC_INT_CH_VDDQ_DDR] = 1000,
+	[STM32_ADC_INT_CH_VREFINT] = 4300,
+	[STM32_ADC_INT_CH_VBAT] = 9800
+};
 
 static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
 	.regs = &stm32mp13_adc_regspec,

-- 
2.43.0

