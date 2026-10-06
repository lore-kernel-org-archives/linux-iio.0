Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0773C3F67;
	Tue,  6 Oct 2026 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273502; cv=fail; b=uhQnhA6BFKo7GsGYhxWetoKn1WGEco9MMpGcNoqDhYh9PSI4df0+uLDuHIXeSQP9cTGUer1MxsyeZqodpytRCuk5uTgMdP05zeRgHziFw9W6gpxMHGZ3JlBqO3BDCjRmWk2kM50I5hBnWJpOqGw0nBOr7KgnDEfP6ki4n+dfudE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273502; c=relaxed/simple;
	bh=9Xk7BxVwfI44HYQMU90YkaaCWn0eGKsKW9+3hyac++M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZgcVZZRgJ9bpNXrk1hIO1XDxV4gIqqSimGTcg0qVUdwuvctCCCp/f2XgsuNYKMw1hBJ+EDfoTECAsgd+u4Y2+T58KIbtzIuZ0prKQvkytPbH2kTjFUB+L9bXO9EB2b1zM8JMCKjjvBNqasEWZrz34OPx6dzej+5PLz7WLwpYuDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RIqsPhvO; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RIqsPhvO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUWtPTSJJJ6UnjfK+tegNcZfwcTiQWkLBgCaJEdcFxE3oVCBdBQA/t/fAUu9/HUVOJtUqDCbRbdWOmup5u5gziRJHSv1k+M5j4Y6wRIsPfNe24ZGEg6flV6+fwJ6hXBX4gpfsBJducDj117NvsDdCsRW1oRzQTU9hlgENVDp0WCjWfaL2qfOaat4mZ2klrS7PasuQoG0fFfR0FkmzE8qogQR3qU871Nl3cpYJ/alUDV13xJxRp0p1lr4JyDXsuNJvs0Fe/He9SnhCbfUX6IwSgz31fP9joHjI1913jODsOqz2oem5gYwB/XVwGLcpNTHXxlf+KQTCTbjOk3ozYMvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qv54N8nPqK+I/MIHI4u3zUyBb82oEGGu5yce5CFSOwA=;
 b=XTYosSQiUXe8oirxOYlua6EOwtucGeq9zj2liMLfrGRvfQjIhJiNt7twb0tE+0N1sr4KpQtIdKzAx+IlodILSN0W2ZXc9NefpnOMeENRDJsct6b/OUT3eVXDf1taj5HEVWSgY7uw3e/PfpqPdNIofwFpc5M52bJwjleaABZVdxfdc+8kn3TxOWhljrtD3r3g6hSBsrvxOj6Q7gLAQr36zmmtXPHtES+BKAmSvu8LN+NU0gdECuVEniWTgPSIXZrGf6+ka9ptWI8xKH6zgw0m+/+dcNTWUrbnQ0NBsX4Xc5wY1Uj6PrsQCMa8u80BjspzVeEzPj92x4KEZMiXHwGHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qv54N8nPqK+I/MIHI4u3zUyBb82oEGGu5yce5CFSOwA=;
 b=RIqsPhvO5LGJB+Actp5GVJYgOFwSTyPnEhH2EnAsFv8NZX/d0C5VC4W6gUEm+J7JkQNEMFK/Yw3WeRwsseGFFh1WL13e9S1S6iv4ygRcRWqlhN8fFbMBPOr+8L2Q87BW43Uis93tN53IyoCoj70bxoy4FYcjyvQhSmBSEd6Znt8ULTWFhNcwZzf800P2ViyZSTxpUDzGSUmvZVgArNqm4NmBDadSFHU91Hsiyr+ZKx0YgWQzLC98yVDDkhVhU38Z1eYeGec0lpQ4YUW3PGoB0hLvQdw99DLbv2tTa0fSUI82DXGBvTdEuoJK+Myx1t/Zh8bAvyRkKzl575IZ4GGs3Q==
Received: from AS9PR06CA0065.eurprd06.prod.outlook.com (2603:10a6:20b:464::30)
 by MA9PR10MB644838.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:250:109::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 07:58:15 +0000
Received: from AMS1EPF00000094.eurprd05.prod.outlook.com
 (2603:10a6:20b:464:cafe::2c) by AS9PR06CA0065.outlook.office365.com
 (2603:10a6:20b:464::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 07:58:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000094.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 07:58:14 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 10:04:17 +0200
Received: from localhost (10.252.27.219) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 09:58:12 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 6 Oct 2026 09:57:39 +0200
Subject: [PATCH v4 08/15] iio: adc: stm32-adc: add support for stm32mp25
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-adc-stm32mp25-v1-v4-8-d31ec75aecf3@foss.st.com>
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
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Cheick Traore
	<cheick.traore-ext@st.com>, Olivier Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000094:EE_|MA9PR10MB644838:EE_
X-MS-Office365-Filtering-Correlation-Id: 1598fa0b-241a-4f55-b8f1-08df237f935c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|7416014|6133799003|18002099003|22082099003|10067099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	e2UnTJvr0gJ3+FLiJOfgKWYARicM/mqp+hYUysHTxjm6mRgALZDEsw9to5kFSj9yzZHaNFAtCW37S8jnRWUhBzoUNvHJYVpATl3557SWgW5qHPatOB53UyIGpzH4tBld5ifYBB854Es3DhxXAkxPga/1AycAT3/C7xjahJl2cO/u1nSvykIaCEIuLnUF9uTqUiCwmYMlLPeYIJGGv1f7NrJFi4/y7BVjFriCnRLDK2l/7CLMqTsqEbQWIqdOu5dBY1FCULe+HYMUEoJwxKIDFDW3NMm5Io6QjW49OEnKAFNZA5bmCeMsUERAIKjeXWSbLqZpHpNHoMi+yweYdgM5INrlcUoQ7ddUheQCXNPxYRxrfjwxnk6oWPnkq/RdIv4QavnARk/GKuvfb7iQG51eO2O7s2KQYKLpFVHWjkOKtt+nmqMHqrV6AdmY5o8kTroxVcjHRRQoA0jureHVoW6ETJbQdMoaw+23faabIs1DWIqZxiPGG0CUqr6e1zcl3GhuexpN6Q6pCBAmcNUIC2zgPAZhXvSHKJx8yqntzw0qjRW7CQigz9SdOHfR3uu8Ej0kstrF8Wj6VFwLHlvjQUNgAcifMbYh7AndGOnkHqWjIm/wd47nxZCGaqg4n62thjkbR2bC3dXddIFC+Mmc+9vXq9L9TNkJ9Pi3ZsQJf2uG5YWjtg8A0AVK66XQj+lzpE3Evw1ly38JJ3DE+9MW5m9TqA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(7416014)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nKHeUes+VTE26vR5WAcCJaR8nXlwDG/fFpken1g1Bkp6a/UGtyZQV7q+6gkJrjWIMO7lEX9S0P3BkuB/w41X/fIMd1sFVb1QajLXnTh/xgua/+yC8M1QX0k7fLhLVXfLNROO1bqCrChg2sB8rwQ6TSym6lQSheT5cETggK5krWWRwagTO2aX3Fw4NeUraw+zY1n848gWYFGX6PwzAN6Jh+wnIdKUvtt3f5ZPNXppUFUBG5lE9GEwukNAk9PSqN7Nsyaj5qWm7/WROwTrt5i7Bee/4xv/21YJ0IzMfkI6GYdZBuIwnVf2MYvB0wZZmVERE5Pk4RsB37p+WF+EII+CsULAh60tRlOr8q8CI+LDTxXICkhM5k3u6+zpgCluqe4qZYTf5BVYcQ7bJui2jhWSMnQGVtqkQDFlulkWPGNKXhgkl0ktzXeinV84KZiq6nl4
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:58:14.9233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1598fa0b-241a-4f55-b8f1-08df237f935c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000094.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR10MB644838

Add support for ADC on STM32MP25 SoC. It has 3 ADCs, split into two blocks:
- ADC1 & ADC2 are tightly coupled.
- ADC3 is managed independently.

Trigger list slightly changes between these blocks (ADC1 & ADC2). Other
differences are found on channels interconnects (similar between ADC2
and ADC3):
- ADC1 is connected to 18 external channels + 2 internal channels
- ADC2 is connected to 14 external channels + 6 internal channels
- ADC3 is connected to 14 external channels + 6 internal channels

Each ADC is a 12-bits successive approximation analog-to-digital converter,
with up to 20 multiplexed channels that can be configured as single ended
or differential. ADC resolution ranges from 6 to 12 bits.

It introduces diversity regarding IRQs, clocks, software calibration
procedure, internal voltage channels, sampling time (prescaler) and
trigger list. Most of the architecture, and the driver engine remains
similar. So, handle the differences w.r.t. other STM32 ADCs family with
a dedicated compatible and compatible data.

Co-developed-by: Cheick Traore <cheick.traore-ext@st.com>
Signed-off-by: Cheick Traore <cheick.traore-ext@st.com>
Co-developed-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- Add an ADSTP command in case calibration times-out, suggested by Sashiko
- Rework differential calibration factor computation: don't rely on
  FIELD_PREP mask to truncate calfact_d as raised by Sashiko. Rather
  subtract 0x7ff to the result, as per the STM32MP25 reference manual
- Use const for stm32_adc_trig_info as raised by Joshua and Sashiko
- Notes for Sashiko: STM32MP25 datasheet (Rev 5 at the time of writing)
  specifies 34 ns minimum sampling time for internal channels.
- Add a comment to clarify DIFSEL write constraint: it can be written as
  long as there's no conversion on-going (same for PCSEL).

Changes in v3:
- Andy review comments: Refactor the calibration routine, to get rid of
  retry labels. So add a dedicated differential calibration routine. Each
  routine becomes more linear. Adopt positive conditional checks.
- Fix style (trailing commas).

Changes in v2:
- Split as advised by Jonathan and Andy. Added precursor patches to
  prepare all the infrastructure. Keep only the new hardware support.
- Adopt separate compatible for ADC1, ADC2 and ADC3 to better describe
  internal channels (split regs descriptions) and trigger list. Drop
  "st,adc-trigger-sel".
- Cosmetic updates whilst at it: remove trailing comma
- Refactor calibration routine, to avoid twisted goto chain, as advised
  by Andy
- One patch per new SoC
---
 drivers/iio/adc/stm32-adc-core.c |  38 ++++
 drivers/iio/adc/stm32-adc-core.h |  20 ++
 drivers/iio/adc/stm32-adc.c      | 402 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 460 insertions(+)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 745063b37b52..aff369299255 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -136,6 +136,9 @@ static struct stm32_adc_priv *to_stm32_adc_priv(struct stm32_adc_common *com)
 /* STM32F4 ADC internal common clock prescaler division ratios */
 static const unsigned int stm32f4_pclk_div[] = { 2, 4, 6, 8 };
 
+/* STM32MP25 ADC internal common clock prescaler division ratios */
+static const unsigned int stm32mp25_presc_div[] = { 1, 2, 4, 6, 8, 10, 12, 16, 32, 64, 128, 256 };
+
 /**
  * stm32_adc_clk_sel() - Select stm32f4 ADC common clock prescaler
  * @pdev: platform device
@@ -345,6 +348,17 @@ static const struct stm32_adc_common_regs stm32mp13_adc_common_regs = {
 	.eocie_msk = STM32H7_EOCIE,
 };
 
+/* STM32MP25 common registers definitions */
+static const struct stm32_adc_common_regs stm32mp25_adc_common_regs = {
+	.csr = STM32H7_ADC_CSR,
+	.ccr = STM32H7_ADC_CCR,
+	.eoc_msk = { STM32H7_EOC_MST, STM32H7_EOC_SLV},
+	.ovr_msk = { STM32H7_OVR_MST, STM32H7_OVR_SLV},
+	.ier = STM32H7_ADC_IER,
+	.eocie_msk = STM32H7_EOCIE,
+	.presc_msk = STM32H7_PRESC_MASK,
+};
+
 static const unsigned int stm32_adc_offset[STM32_ADC_MAX_ADCS] = {
 	0, STM32_ADC_OFFSET, STM32_ADC_OFFSET * 2,
 };
@@ -422,6 +436,8 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
 	 * Interrupt(s) must be provided, depending on the compatible:
 	 * - stm32f4/h7 shares a common interrupt line.
 	 * - stm32mp1, has one line per ADC
+	 * - stm32mp25, has a dual ADC1/ADC2 and standalone ADC3. Each ADC has an IRQ
+	 *   (two for ADC1/ADC2, one for ADC3)
 	 */
 	for (i = 0; i < priv->nb_irqs; i++) {
 		priv->irq[i] = platform_get_irq(pdev, i);
@@ -702,6 +718,17 @@ static int stm32_adc_probe_identification(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	if (priv->cfg->ipid == STM32MP25_IPIDR_NUMBER) {
+		/*
+		 * ADC diversity on STM32MP25 is handled here. There may be:
+		 * - 2 IRQs for ADC1/ADC2 block
+		 * - 1 IRQ for ADC3 block.
+		 * There cannot be more IRQs than the actual number of ADCs.
+		 */
+		if (priv->nb_irqs > priv->nb_adc_max)
+			priv->nb_irqs = priv->nb_adc_max;
+	}
+
 	val = readl_relaxed(priv->common.base + STM32MP1_ADC_VERR);
 	dev_dbg(&pdev->dev, "ADC version: %lu.%lu\n",
 		FIELD_GET(STM32MP1_MAJREV_MASK, val),
@@ -894,11 +921,22 @@ static const struct stm32_adc_priv_cfg stm32mp13_adc_priv_cfg = {
 	.num_irqs = 1,
 };
 
+static const struct stm32_adc_priv_cfg stm32mp25_adc_priv_cfg = {
+	.regs = &stm32mp25_adc_common_regs,
+	.clk_sel = stm32_adc_clk_sel,
+	.presc = stm32mp25_presc_div,
+	.num_presc = ARRAY_SIZE(stm32mp25_presc_div),
+	.max_clk_rate_hz = 70000000,
+	.ipid = STM32MP25_IPIDR_NUMBER,
+	.num_irqs = 2, /* 2 IRQs for ADC1/ADC2, 1 irq for ADC3 */
+};
+
 static const struct of_device_id stm32_adc_of_match[] = {
 	{ .compatible = "st,stm32f4-adc-core", .data = (void *)&stm32f4_adc_priv_cfg },
 	{ .compatible = "st,stm32h7-adc-core", .data = (void *)&stm32h7_adc_priv_cfg },
 	{ .compatible = "st,stm32mp1-adc-core",	.data = (void *)&stm32mp1_adc_priv_cfg },
 	{ .compatible = "st,stm32mp13-adc-core", .data = (void *)&stm32mp13_adc_priv_cfg },
+	{ .compatible = "st,stm32mp25-adc-core", .data = (void *)&stm32mp25_adc_priv_cfg },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, stm32_adc_of_match);
diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
index db50a9f3b922..68b937e3819f 100644
--- a/drivers/iio/adc/stm32-adc-core.h
+++ b/drivers/iio/adc/stm32-adc-core.h
@@ -121,6 +121,9 @@
 #define STM32MP13_ADC_CALFACT		0xB4
 #define STM32MP13_ADC2_OR		0xC8
 
+/* STM32MP25 - ADC2 and ADC3 option register */
+#define STM32MP25_ADC23_OR		0xD0
+
 /* STM32H7 - common registers for all ADC instances */
 #define STM32H7_ADC_CSR			(STM32_ADCX_COMN_OFFSET + 0x00)
 #define STM32H7_ADC_CCR			(STM32_ADCX_COMN_OFFSET + 0x08)
@@ -257,8 +260,25 @@ enum stm32h7_adc_dmngt {
 #define STM32MP13_OP1			BIT(1)
 #define STM32MP13_OP0			BIT(0)
 
+/* STM32MP25 - Registers for each ADC instance */
+#define STM32MP25_ADC_CALFACT		0xC4
+
+/* STM32MP25_ADC_CALFACT - bit fields */
+#define STM32MP25_CALFACT_CALADDOS	BIT(31)
+#define STM32MP25_CALFACT_D_MASK	GENMASK(24, 16)
+#define STM32MP25_CALFACT_S_MASK	GENMASK(8, 0)
+
+/* STM32MP25_ADC_CFGR specific bit fields */
+#define STM32MP25_RES_SHIFT		2
+#define STM32MP25_RES_MASK		GENMASK(3, 2)
+
+/* STM32MP25_ADC23_OR - specific bit fields */
+#define STM32MP25_VDDCPUEN		BIT(3)
+#define STM32MP25_VDDCOREEN		BIT(2)
+
 #define STM32MP15_IPIDR_NUMBER		0x00110005
 #define STM32MP13_IPIDR_NUMBER		0x00110006
+#define STM32MP25_IPIDR_NUMBER		0x00110008
 
 /**
  * struct stm32_adc_common - stm32 ADC driver common data (for all instances)
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index e3719b29dcb1..e7c927d1a73b 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -36,6 +36,12 @@
 /* BOOST bit must be set on STM32H7 when ADC clock is above 20MHz */
 #define STM32H7_BOOST_CLKRATE		20000000UL
 
+/* Number of loops in the calibration procedure to average data on STM32MP25 */
+#define STM32MP25_CALIB_LOOP		8
+
+/* Value to subtract from averaged calibration data in differential mode on STM32MP25 */
+#define STM32MP25_CALFACT_D_SUBSTRACT	0x7ffU
+
 #define STM32_ADC_CH_MAX		20	/* max number of channels */
 #define STM32_ADC_CH_SZ			16	/* max channel name size */
 #define STM32_ADC_MAX_SQ		16	/* SQ1..SQ16 */
@@ -77,6 +83,14 @@ enum stm32_adc_extsel {
 	STM32_EXT18,
 	STM32_EXT19,
 	STM32_EXT20,
+	STM32_EXT21,
+	STM32_EXT22,
+	STM32_EXT23,
+	STM32_EXT24,
+	STM32_EXT25,
+	STM32_EXT26,
+	STM32_EXT27,
+	STM32_EXT28,
 };
 
 enum stm32_adc_int_ch {
@@ -348,6 +362,20 @@ static const struct stm32_adc_info stm32mp13_adc_info = {
 	.num_ovs = ARRAY_SIZE(stm32mp13_adc_oversampling_avail),
 };
 
+/*
+ * stm32mp25 can have up to 20 channels.
+ * Keep channel 19 (VREF+) hidden on STM32MP25: it is the ADC reference
+ * supply itself, so exposing it as a regular input is meaningless.
+ * Reference voltage must be derived from VREFINT with calibration data.
+ */
+static const struct stm32_adc_info stm32mp25_adc_info = {
+	.max_channels = STM32_ADC_CH_MAX - 1,
+	.resolutions = stm32f4_adc_resolutions,
+	.oversampling = stm32h7_adc_oversampling_avail,
+	.num_res = ARRAY_SIZE(stm32f4_adc_resolutions),
+	.num_ovs = ARRAY_SIZE(stm32h7_adc_oversampling_avail),
+};
+
 /*
  * stm32f4_sq - describe regular sequence registers
  * - L: sequence len (register & bit field)
@@ -538,6 +566,114 @@ static const struct stm32_adc_regspec stm32h7_adc_regspec = {
 	.smp_bits = stm32h7_smp_bits,
 };
 
+/* STM32MP25 external trigger sources for ADC1 and ADC2 */
+static const struct stm32_adc_trig_info stm32mp25_adc1_adc2_trigs[] = {
+	{ TIM1_TRGO, STM32_EXT0 },
+	{ TIM1_TRGO2, STM32_EXT1 },
+	{ TIM8_TRGO, STM32_EXT2 },
+	{ TIM8_TRGO2, STM32_EXT3 },
+	{ TIM20_TRGO, STM32_EXT4 },
+	{ TIM20_TRGO2, STM32_EXT5 },
+	{ TIM2_TRGO, STM32_EXT6 },
+	{ TIM3_TRGO, STM32_EXT7 },
+	{ TIM4_TRGO, STM32_EXT8 },
+	{ TIM5_TRGO, STM32_EXT9 },
+	{ TIM6_TRGO, STM32_EXT10 },
+	{ TIM15_TRGO, STM32_EXT11 },
+	{ TIM1_CH1, STM32_EXT12 },
+	{ TIM1_CH2, STM32_EXT13 },
+	{ TIM1_CH3, STM32_EXT14 },
+	{ TIM20_OC1, STM32_EXT15 },
+	{ TIM20_OC2, STM32_EXT16 },
+	{ TIM20_OC3, STM32_EXT17 },
+	{ TIM2_CH2, STM32_EXT18 },
+	{ TIM3_CH4, STM32_EXT19 },
+	{ TIM4_CH4, STM32_EXT20 },
+	{ TIM5_CH1, STM32_EXT21 },
+	{ TIM12_CH1, STM32_EXT22 },
+	{ LPTIM1_CH1, STM32_EXT24 },
+	{ LPTIM2_CH1, STM32_EXT25 },
+	{ LPTIM3_CH1, STM32_EXT26 },
+	{ LPTIM4_CH1, STM32_EXT27 },
+	{ LPTIM5_OUT, STM32_EXT28 },
+	{ }
+};
+
+/* STM32MP25 external trigger sources for ADC3 */
+static const struct stm32_adc_trig_info stm32mp25_adc3_trigs[] = {
+	{ TIM1_TRGO, STM32_EXT0 },
+	{ TIM1_TRGO2, STM32_EXT1 },
+	{ TIM8_TRGO, STM32_EXT2 },
+	{ TIM8_TRGO2, STM32_EXT3 },
+	{ TIM20_TRGO, STM32_EXT4 },
+	{ TIM20_TRGO2, STM32_EXT5 },
+	{ TIM2_TRGO, STM32_EXT6 },
+	{ TIM3_TRGO, STM32_EXT7 },
+	{ TIM4_TRGO, STM32_EXT8 },
+	{ TIM5_TRGO, STM32_EXT9 },
+	{ TIM6_TRGO, STM32_EXT10 },
+	{ TIM7_TRGO, STM32_EXT11 },
+	{ TIM15_TRGO, STM32_EXT12 },
+	{ TIM17_OC1, STM32_EXT13 },
+	{ TIM1_CH3, STM32_EXT14 },
+	{ TIM8_CH1, STM32_EXT15 },
+	{ TIM20_OC1, STM32_EXT16 },
+	{ TIM2_CH1, STM32_EXT17 },
+	{ TIM2_CH3, STM32_EXT18 },
+	{ TIM3_CH1, STM32_EXT19 },
+	{ TIM4_CH1, STM32_EXT20 },
+	{ TIM5_CH3, STM32_EXT21 },
+	{ TIM12_CH1, STM32_EXT22 },
+	{ LPTIM1_CH1, STM32_EXT24 },
+	{ LPTIM2_CH1, STM32_EXT25 },
+	{ LPTIM3_CH1, STM32_EXT26 },
+	{ LPTIM4_CH1, STM32_EXT27 },
+	{ LPTIM5_OUT, STM32_EXT28 },
+	{ }
+};
+
+/* STM32MP25 programmable sampling time (ADC clock cycles, rounded down) */
+static const unsigned int stm32mp25_adc_smp_cycles[STM32_ADC_MAX_SMP + 1] = {
+	2, 3, 7, 12, 24, 47, 247, 1501,
+};
+
+static const struct stm32_adc_regspec stm32mp25_adc1_regspec = {
+	.dr = STM32H7_ADC_DR,
+	.ier_eoc = { STM32H7_ADC_IER, STM32H7_EOCIE },
+	.ier_ovr = { STM32H7_ADC_IER, STM32H7_OVRIE },
+	.isr_eoc = { STM32H7_ADC_ISR, STM32H7_EOC },
+	.isr_ovr = { STM32H7_ADC_ISR, STM32H7_OVR },
+	.sqr = stm32h7_sq,
+	.exten = { STM32H7_ADC_CFGR, STM32H7_EXTEN_MASK, STM32H7_EXTEN_SHIFT },
+	.extsel = { STM32H7_ADC_CFGR, STM32H7_EXTSEL_MASK,
+		    STM32H7_EXTSEL_SHIFT },
+	.res = { STM32H7_ADC_CFGR, STM32MP25_RES_MASK, STM32MP25_RES_SHIFT },
+	.difsel = { STM32H7_ADC_DIFSEL, STM32H7_DIFSEL_MASK},
+	.smpr = { STM32H7_ADC_SMPR1, STM32H7_ADC_SMPR2 },
+	.smp_bits = stm32h7_smp_bits,
+	.ccr_vref = { STM32H7_ADC_CCR, STM32H7_VREFEN },
+};
+
+static const struct stm32_adc_regspec stm32mp25_adc2_adc3_regspec = {
+	.dr = STM32H7_ADC_DR,
+	.ier_eoc = { STM32H7_ADC_IER, STM32H7_EOCIE },
+	.ier_ovr = { STM32H7_ADC_IER, STM32H7_OVRIE },
+	.isr_eoc = { STM32H7_ADC_ISR, STM32H7_EOC },
+	.isr_ovr = { STM32H7_ADC_ISR, STM32H7_OVR },
+	.sqr = stm32h7_sq,
+	.exten = { STM32H7_ADC_CFGR, STM32H7_EXTEN_MASK, STM32H7_EXTEN_SHIFT },
+	.extsel = { STM32H7_ADC_CFGR, STM32H7_EXTSEL_MASK,
+		    STM32H7_EXTSEL_SHIFT },
+	.res = { STM32H7_ADC_CFGR, STM32MP25_RES_MASK, STM32MP25_RES_SHIFT },
+	.difsel = { STM32H7_ADC_DIFSEL, STM32H7_DIFSEL_MASK},
+	.smpr = { STM32H7_ADC_SMPR1, STM32H7_ADC_SMPR2 },
+	.smp_bits = stm32h7_smp_bits,
+	.or_vddcore = { STM32MP25_ADC23_OR, STM32MP25_VDDCOREEN },
+	.or_vddcpu = { STM32MP25_ADC23_OR, STM32MP25_VDDCPUEN },
+	.ccr_vbat = { STM32H7_ADC_CCR, STM32H7_VBATEN },
+	.ccr_vref = { STM32H7_ADC_CCR, STM32H7_VREFEN },
+};
+
 /* STM32MP13 programmable sampling time (ADC clock cycles, rounded down) */
 static const unsigned int stm32mp13_adc_smp_cycles[STM32_ADC_MAX_SMP + 1] = {
 	2, 6, 12, 24, 47, 92, 247, 640,
@@ -1304,6 +1440,211 @@ static void stm32h7_adc_unprepare(struct iio_dev *indio_dev)
 	stm32h7_adc_enter_pwr_down(adc);
 }
 
+/*
+ * STM32MP25 offset calibration software procedure. Basically the calibration routine is
+ * expected to average (for example) 8 samples in calibration mode, for single-ended  and
+ * differential channels, to calibrate the zero offset. In case offset is "negative", an
+ * additional offset can be added, to determine calibration factor. It must be kept later
+ * for all conversions.
+ */
+static int stm32mp25_adc_calib_get_average_data(struct iio_dev *indio_dev, u32 *average)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	u32 avg = 0;
+
+	/* Repeat several conversions in calibration mode, average the results */
+	for (unsigned int i = 0; i < STM32MP25_CALIB_LOOP; i++) {
+		int ret;
+		u32 val;
+
+		stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADSTART);
+		ret = stm32_adc_readl_poll_timeout(STM32H7_ADC_CR, val,
+						   !(val & (STM32H7_ADSTART)),
+						   100, STM32_ADC_TIMEOUT_US);
+		if (ret) {
+			stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADSTP);
+			dev_err(&indio_dev->dev, "calibration average error %d\n", ret);
+			return ret;
+		}
+
+		val = stm32_adc_readl(adc, adc->cfg->regs->dr);
+		dev_vdbg(&indio_dev->dev, "dr[%d]=0x%08x\n", i, val);
+		avg += val;
+	}
+
+	*average = DIV_ROUND_CLOSEST(avg, STM32MP25_CALIB_LOOP);
+	dev_vdbg(&indio_dev->dev, "average=0x%08x\n", *average);
+
+	return 0;
+}
+
+static int stm32mp25_adc_calib_single_ended(struct iio_dev *indio_dev, u32 *calfact)
+{
+	bool additional_offset = FIELD_GET(STM32MP25_CALFACT_CALADDOS, *calfact);
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	u32 average;
+	int ret;
+
+	/* Select single ended input calibration */
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADCALDIF);
+	ret = stm32mp25_adc_calib_get_average_data(indio_dev, &average);
+	if (ret)
+		return ret;
+
+	/* Add offset and re-run single-ended calibration if the averaged data is zero */
+	if (!average && !additional_offset) {
+		additional_offset = true;
+		*calfact = STM32MP25_CALFACT_CALADDOS;
+		stm32_adc_writel(adc, STM32MP25_ADC_CALFACT, *calfact);
+
+		ret = stm32mp25_adc_calib_get_average_data(indio_dev, &average);
+		if (ret)
+			return ret;
+	}
+
+	if (average) {
+		*calfact |= FIELD_PREP(STM32MP25_CALFACT_S_MASK, average);
+		stm32_adc_writel(adc, STM32MP25_ADC_CALFACT, *calfact);
+	} else if (additional_offset) {
+		/* If average data is still zero with additional offset, just warn about it */
+		dev_warn(&indio_dev->dev, "Single-ended calibration average: 0\n");
+	}
+
+	return 0;
+}
+
+static int stm32mp25_adc_calib_differential(struct iio_dev *indio_dev, u32 *calfact)
+{
+	bool additional_offset = FIELD_GET(STM32MP25_CALFACT_CALADDOS, *calfact);
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	int calfact_d;
+	u32 average;
+	int ret;
+
+	/* Select differential input calibration (keep previous CALADDOS value) */
+	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADCALDIF);
+	ret = stm32mp25_adc_calib_get_average_data(indio_dev, &average);
+	if (ret)
+		return ret;
+
+	/*
+	 * Subtract 0x7ff from the averaged data. If the result is positive, store it in CALFACT_D.
+	 * If averaged differential data is negative and an offset can be added, re-run
+	 * single-ended and differential calibration with an additional offset.
+	 */
+	calfact_d = average - STM32MP25_CALFACT_D_SUBSTRACT;
+	if (calfact_d < 0 && !additional_offset) {
+		/* Clear previous calibration result and add an offset */
+		*calfact = STM32MP25_CALFACT_CALADDOS;
+		stm32_adc_writel(adc, STM32MP25_ADC_CALFACT, *calfact);
+
+		ret = stm32mp25_adc_calib_single_ended(indio_dev, calfact);
+		if (ret)
+			return ret;
+
+		stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADCALDIF);
+		ret = stm32mp25_adc_calib_get_average_data(indio_dev, &average);
+		if (ret)
+			return ret;
+
+		calfact_d = average - STM32MP25_CALFACT_D_SUBSTRACT;
+	}
+
+	if (calfact_d > 0) {
+		*calfact |= FIELD_PREP(STM32MP25_CALFACT_D_MASK, calfact_d);
+		stm32_adc_writel(adc, STM32MP25_ADC_CALFACT, *calfact);
+	} else if (calfact_d < 0) {
+		/* Clamp differential data to zero (don't use the result), warn about it. */
+		dev_warn(&indio_dev->dev, "Differential calibration clamped(0): 0x%x\n", average);
+	}
+
+	return 0;
+}
+
+static int stm32mp25_adc_calib(struct iio_dev *indio_dev)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	u32 calfact = 0;
+	int ret;
+
+	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADCAL);
+	/* Use default resolution (e.g. 12 bits) */
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR, STM32MP25_RES_MASK);
+	/* Clear calfact (additional offset and old calibration data if any) */
+	stm32_adc_writel(adc, STM32MP25_ADC_CALFACT, calfact);
+
+	ret = stm32mp25_adc_calib_single_ended(indio_dev, &calfact);
+	if (ret) {
+		stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADCAL);
+		return ret;
+	}
+
+	ret = stm32mp25_adc_calib_differential(indio_dev, &calfact);
+	if (ret) {
+		stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADCAL);
+		return ret;
+	}
+
+	dev_dbg(&indio_dev->dev, "set calfact_s=0x%03lx, calfact_d=0x%03lx, caladdos=%ld\n",
+		FIELD_GET(STM32MP25_CALFACT_S_MASK, calfact),
+		FIELD_GET(STM32MP25_CALFACT_D_MASK, calfact),
+		FIELD_GET(STM32MP25_CALFACT_CALADDOS, calfact));
+
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADCAL);
+	stm32_adc_set_res(adc);
+
+	return 0;
+}
+
+static int stm32mp25_adc_prepare(struct iio_dev *indio_dev)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	ret = stm32h7_adc_exit_pwr_down(indio_dev);
+	if (ret)
+		return ret;
+
+	/* Must enable the ADC before running software-assisted calibration */
+	ret = stm32h7_adc_enable(indio_dev);
+	if (ret)
+		goto pwr_dwn;
+
+	/* Always run offset calibration */
+	ret = stm32mp25_adc_calib(indio_dev);
+	if (ret)
+		goto adc_dis;
+
+	stm32_adc_int_ch_enable(indio_dev);
+
+	/* DIFSEL and PCSEL can be written when there's no on-going conversions (ADSTART = 0) */
+	stm32_adc_writel(adc, adc->cfg->regs->difsel.reg, adc->difsel);
+
+	if (adc->cfg->has_presel)
+		stm32_adc_writel(adc, STM32H7_ADC_PCSEL, adc->pcsel);
+
+	return 0;
+
+adc_dis:
+	stm32h7_adc_disable(indio_dev);
+pwr_dwn:
+	stm32h7_adc_enter_pwr_down(adc);
+
+	return ret;
+}
+
+static void stm32mp25_adc_unprepare(struct iio_dev *indio_dev)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+
+	/* Undo things in the reverse order */
+	if (adc->cfg->has_presel)
+		stm32_adc_writel(adc, STM32H7_ADC_PCSEL, 0);
+	stm32_adc_int_ch_disable(adc);
+	stm32h7_adc_disable(indio_dev);
+	stm32h7_adc_enter_pwr_down(adc);
+}
+
 /**
  * stm32_adc_conf_scan_seq() - Build regular channels scan sequence
  * @indio_dev: IIO device
@@ -2788,11 +3129,72 @@ static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
 	.vref_charac_mV = 3300,
 };
 
+static const unsigned int stm32_adc_min_ts_mp25[STM32_ADC_INT_CH_NB] = {
+	[STM32_ADC_INT_CH_VDDCORE] = 34,
+	[STM32_ADC_INT_CH_VDDCPU] = 34,
+	[STM32_ADC_INT_CH_VREFINT] = 34,
+	[STM32_ADC_INT_CH_VBAT] = 34,
+};
+
+static const struct stm32_adc_cfg stm32mp25_adc1_cfg = {
+	.regs = &stm32mp25_adc1_regspec,
+	.adc_info = &stm32mp25_adc_info,
+	.trigs = stm32mp25_adc1_adc2_trigs,
+	.has_oversampling = true,
+	.has_presel = true,
+	.start_conv = stm32h7_adc_start_conv,
+	.stop_conv = stm32h7_adc_stop_conv,
+	.prepare = stm32mp25_adc_prepare,
+	.unprepare = stm32mp25_adc_unprepare,
+	.smp_cycles = stm32mp25_adc_smp_cycles,
+	.irq_clear = stm32h7_adc_irq_clear,
+	.set_ovs = stm32h7_adc_set_ovs,
+	.ts_int_ch = stm32_adc_min_ts_mp25,
+	.vref_charac_mV = 1800,
+};
+
+static const struct stm32_adc_cfg stm32mp25_adc2_cfg = {
+	.regs = &stm32mp25_adc2_adc3_regspec,
+	.adc_info = &stm32mp25_adc_info,
+	.trigs = stm32mp25_adc1_adc2_trigs,
+	.has_oversampling = true,
+	.has_presel = true,
+	.start_conv = stm32h7_adc_start_conv,
+	.stop_conv = stm32h7_adc_stop_conv,
+	.prepare = stm32mp25_adc_prepare,
+	.unprepare = stm32mp25_adc_unprepare,
+	.smp_cycles = stm32mp25_adc_smp_cycles,
+	.irq_clear = stm32h7_adc_irq_clear,
+	.set_ovs = stm32h7_adc_set_ovs,
+	.ts_int_ch = stm32_adc_min_ts_mp25,
+	.vref_charac_mV = 1800,
+};
+
+static const struct stm32_adc_cfg stm32mp25_adc3_cfg = {
+	.regs = &stm32mp25_adc2_adc3_regspec,
+	.adc_info = &stm32mp25_adc_info,
+	.trigs = stm32mp25_adc3_trigs,
+	.has_oversampling = true,
+	.has_presel = true,
+	.start_conv = stm32h7_adc_start_conv,
+	.stop_conv = stm32h7_adc_stop_conv,
+	.prepare = stm32mp25_adc_prepare,
+	.unprepare = stm32mp25_adc_unprepare,
+	.smp_cycles = stm32mp25_adc_smp_cycles,
+	.irq_clear = stm32h7_adc_irq_clear,
+	.set_ovs = stm32h7_adc_set_ovs,
+	.ts_int_ch = stm32_adc_min_ts_mp25,
+	.vref_charac_mV = 1800,
+};
+
 static const struct of_device_id stm32_adc_of_match[] = {
 	{ .compatible = "st,stm32f4-adc", .data = (void *)&stm32f4_adc_cfg },
 	{ .compatible = "st,stm32h7-adc", .data = (void *)&stm32h7_adc_cfg },
 	{ .compatible = "st,stm32mp1-adc", .data = (void *)&stm32mp1_adc_cfg },
 	{ .compatible = "st,stm32mp13-adc", .data = (void *)&stm32mp13_adc_cfg },
+	{ .compatible = "st,stm32mp25-adc1", .data = (void *)&stm32mp25_adc1_cfg },
+	{ .compatible = "st,stm32mp25-adc2", .data = (void *)&stm32mp25_adc2_cfg },
+	{ .compatible = "st,stm32mp25-adc3", .data = (void *)&stm32mp25_adc3_cfg },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, stm32_adc_of_match);

-- 
2.43.0

