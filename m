Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013030.outbound.protection.outlook.com [52.101.83.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3283C343A;
	Tue,  6 Oct 2026 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273500; cv=fail; b=lLAxiajH+boCLT07BA+usRJkpSSY849OxorZp2uduIHAcVksw8n81Xsis6rT/Up+t68gkWbM5+agk3HrafKCVLLpzvVDp/uxRNwSka3E45WpBp4CNNHTv22/IwoWDxvpViCFDm/zKaHcxhu2fGgq6tkf0BvKYQTTEKvkCaFvWMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273500; c=relaxed/simple;
	bh=pDtjIOH+CjpxmhVBynfjRobSZKIp9bbl5FizXiywz60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tzFjn8IwIGVstNpeskDcUwU8dz1RbRdADoOhovHvaMMbhDX91voELx4U/oDTRDyy6pV6i0eWkI4VvgCyQbdd7dd0k/IxeIQVBHcHmAfBqkMQRzulgXzhhpGYgIYhZSmND5s+7M+/A6gJZvL0vGXximhuUfnyBAOpvy/Wae2plCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=fN18uTQp; arc=fail smtp.client-ip=52.101.83.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="fN18uTQp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLr6oZffvJDQpqOzYRCbQHe102GTz0pmDAvuiFWOrwa/ocT9zpTOLVOjKzYxoSdWqtZWdP6l5ZWW7Eqo9O9QPAxKQUFP3Af8eS4ed6xFEbk9BscHe2BLp0vLjNVGkqL385fS6FfaWwUnFUQgBi8lA3+3J6i/Xoxg13cxMLehTyhrXS4q+pTeO03SHzLu/MgZTlyzwxM8vnDwg42cJ6ImEteMhuam0ZSvKU2zILbt6XUL0zMHDTgbpM0LynumJURKWCUBRQHCLPy+Hq0JUi5a03HwlVz0hhvhJXTPAWMwY4ZXnE4aqU29ClbIZJBoWBnUlS+pQ6TwUNuMLglVxUKHFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+3S9qo462omFGjwY+gf1HQaUhq2Pf3TAzLgwiF7cv0=;
 b=xYr2hpH/uZOM0MpZ9yImQ4FjifLEBZ+b1gWSW7C4YQnZN1QIuduWPFckoBOwhbZlWVarRTj79ltV1vlermEJt8p+9UB1JMLvN0uRNdqgA1bk0wfAPeQm6s3fmmigXV32be1R2RcUCVaaiXEcgXrWs81M4caCAZFL2OxGYA1B9MePlGEDMxrunmbRNmMlRWKBg2fmJNKt8b3KZJaTLOYReZlG/cYrwN+ZRlRcgxNk7z9/BqJQd5GOhhPKyw+OrcRDSnUtdid377+NawlkFG4hfT4LrKaqgWb9aL0o5ww5RNcRRL8O3kyr9/pzgoshX5mv2JvxVHoQhKoRIjzCJ0xygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+3S9qo462omFGjwY+gf1HQaUhq2Pf3TAzLgwiF7cv0=;
 b=fN18uTQpx4aex3CoA7PGqJvOC12u/3qd4kqq3SqA7IwGRPUGvLvUp4O49ws2W+N1M9IXggQYWqerzRFG4HvW//S6ScqK11opxN4fKlC48oZidzEx03RBSiaHTfCRWezhbU4w90mP2OLvS1RTOCvsLUFo4RckWI8me1jBMoeGnZojVXA4o8Ruaj6qtPN4CKJmvsdN2KInztAVpPhWqdr89idcX8IJDKdALgsYLNGmBR7CPi7wMF5ypGi6/E526gCIih7eGH0ajt9WJPqSowRbE70R7sN87NTK97JM1VXhj/6e1EAX5+P9iaOYNT6fObGnvJuOF4Sv6y19FDXz8SkrHA==
Received: from BE1P281CA0462.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:7f::19)
 by DU0PR10MB9345.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:59e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 07:58:11 +0000
Received: from WA1PEPF000099CE.eurprd04.prod.outlook.com
 (2603:10a6:b10:7f:cafe::a7) by BE1P281CA0462.outlook.office365.com
 (2603:10a6:b10:7f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 6
 Oct 2026 07:58:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF000099CE.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 07:58:11 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 10:04:56 +0200
Received: from localhost (10.252.27.219) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 09:58:10 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 6 Oct 2026 09:57:36 +0200
Subject: [PATCH v4 05/15] iio: adc: stm32-adc: rework internal channels
 data
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-adc-stm32mp25-v1-v4-5-d31ec75aecf3@foss.st.com>
References: <20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com>
In-Reply-To: <20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Joshua Crofts <joshua.crofts1@gmail.com>, Marek Vasut
	<marex@nabladev.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF000099CE:EE_|DU0PR10MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0508d2-796e-4dcc-3e90-08df237f9125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|82310400026|1800799024|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	l/xMWsegN+VfHvhJGLOJwdzijaMm9lQe1S2de5g2V2q98BB1uYoXEyae5Crj9tFbx1qy4UA+vDWsWNtSIeVkWjbPVewTkp18ojCdPPKHUQkcuAnI495+WG/Ds8h1v+i2rru1x6jPJp0ihTFLGSb15Jxk3nSxFbC5H8FbHhbqK7L2nOBFvb6tsUPbdqTjQt4YbyOXqZrmgxmVw8vTyuiGY7f4IiIU7e/j/mkjTHrT+azgi+gCyOhZO3S9YcMBR1hA/sTsLIneeI8Jo4nt33FJvjYpzy3cN+Q5i9ay0kT1rKC5ogRoc0/5IT022rIA1tSzrRFiNUnNvtAJCiGgIgnloGhta4Q6Miv/VfdbKER6NcvC0QA+X7jSkXSke0OlW3AX3MkMj2EdGKYcoekdtRnG+aJgtTtJ5PkMvYMsdVzudEvwe8hEJ5VQw6oSLFfRNlJd/mK8W1Hujy30+cVYFYo8iw790ucyqmCf70jSlzGLAzRYVEnTsbQ8HcEYT5JDwxZgHzotMnCTLc6t0qzlv6QsPs84asZREYgvhFl51mA6nAc9Iw2tB3AchHRNkKku3DUOtUKuAUPNoEaBfWRzTIxoiaqIMuZ1Gqg6O/T8nw8iPyEZgXpHyOPGy21JtRDBqF7Wl+efzM9hWxGko3NsUUNci24ljJ3UnuGqXD6kRfWM/4ddGzxxoTwLbEejFYsP6KHJm/oK3L4NjT3+vWWRN2lQ0A==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Of/6pRmEV4aGqp58p72z3ax1JnPRJ/ALySPUuOcRl0IQvd3dfd5hhJTi3PDVRBeleq7uSklrZGi2HoZmdVYm+wgfwArQdtwF/eUKYtxSPvOUW24M6HMaTPJVymNR9aEmT7z6qhI6nrwP/MTmj3PcwVchXQlzXaSVuL4XnnlYGfyYnebi0xEgaL8jpaVzioazHqxOYJrUYWcwAGcHhboL6T8T7TEpfMJU1gWknwlY3J5qwzyGCvEu+8pWP914QgMCnXk9oRXGBoU5dhhasFInZ6AB5rCegM8vL0gHRAG2Bpuo9SCiTkky7Pst12cimmt/TpDWCu30QDcr1xpe2mM4WmsLL0Duq/Kvf2IRdzEcLHAJl/WzqKCd+sO7/DlIRUMDklMYuStjRBfsfslPdqfAhU1jCYCgFojQMrpNa+cTcEzB+diFUIk6w+yNyB1Cr77A
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:58:11.1749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0508d2-796e-4dcc-3e90-08df237f9125
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF000099CE.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB9345

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
Changes in v3:
- style: add commas to non-terminating entries
- Rebased on top of "iio: adc: stm32: fix minimum sampling time values",
  that has been already applied.
Changes in v2:
- new precursor patch as suggested by Jonathan
---
 drivers/iio/adc/stm32-adc.c | 51 +++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 23b51a291874..8b7eb70a882d 100644
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
@@ -2717,8 +2708,10 @@ static const struct stm32_adc_cfg stm32f4_adc_cfg = {
 	.vref_charac_mV = 3300,
 };
 
-static const unsigned int stm32_adc_min_ts_h7[] = { 0, 0, 0, 4300, 9000 };
-static_assert(ARRAY_SIZE(stm32_adc_min_ts_h7) == STM32_ADC_INT_CH_NB);
+static const unsigned int stm32_adc_min_ts_h7[STM32_ADC_INT_CH_NB] = {
+	[STM32_ADC_INT_CH_VREFINT] = 4300,
+	[STM32_ADC_INT_CH_VBAT] = 9000,
+};
 
 static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.regs = &stm32h7_adc_regspec,
@@ -2739,8 +2732,11 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.vref_charac_mV = 3300,
 };
 
-static const unsigned int stm32_adc_min_ts_mp1[] = { 100, 0, 0, 4300, 9800 };
-static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp1) == STM32_ADC_INT_CH_NB);
+static const unsigned int stm32_adc_min_ts_mp1[STM32_ADC_INT_CH_NB] = {
+	[STM32_ADC_INT_CH_VDDCORE] = 100,
+	[STM32_ADC_INT_CH_VREFINT] = 4300,
+	[STM32_ADC_INT_CH_VBAT] = 9800,
+};
 
 static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.regs = &stm32mp1_adc_regspec,
@@ -2762,8 +2758,13 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.vref_charac_mV = 3300,
 };
 
-static const unsigned int stm32_adc_min_ts_mp13[] = { 1000, 1000, 1000, 4300, 9800 };
-static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp13) == STM32_ADC_INT_CH_NB);
+static const unsigned int stm32_adc_min_ts_mp13[STM32_ADC_INT_CH_NB] = {
+	[STM32_ADC_INT_CH_VDDCORE] = 1000,
+	[STM32_ADC_INT_CH_VDDCPU] = 1000,
+	[STM32_ADC_INT_CH_VDDQ_DDR] = 1000,
+	[STM32_ADC_INT_CH_VREFINT] = 4300,
+	[STM32_ADC_INT_CH_VBAT] = 9800,
+};
 
 static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
 	.regs = &stm32mp13_adc_regspec,

-- 
2.43.0

