Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010048.outbound.protection.outlook.com [52.101.84.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91895519AE;
	Wed, 23 Sep 2026 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177981; cv=fail; b=fsMaJv3DaBLOPxXzm3RMjIyNpel0CeATraVJQDwO+obsn/QA47yRYQMeZDrVX69x51xxdTX5uZiQHkYjQTXJpsuXz+3tuK2qQsh69toQhEh50Mkz55APxLa9vUUOa6rfJ+hMT/rscmyoWTFDGWlm2O+uXiMJT70nLBdl53Ax+yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177981; c=relaxed/simple;
	bh=SSWyZoYW3WUTUkAy1NMu/N0dS3nvuM8JX5c7SfWvgW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=in6rDx4Whx44yPIJsPzLp6WbDvG3gdqJbDxGZCSCpstiWt/3OZWPWL1/EcRT9ktnx13MXy9YT2JsHISeuzG/EBnGqHYmCCrBm3/5XDUYxTFlKJ8XxZT39/Z+xwzqkegat+Ly/pdLHchLa7ypNu1aQNGE3pBkEnYAAT2ltYoLSMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=U/q7D8dT; arc=fail smtp.client-ip=52.101.84.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="U/q7D8dT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlQr0JjltPxi9aHJNTRkOQJ65zQNngZgi152HMTlYroPU5Rhhmz38ZOYSQc2GQ04/4C2kc9kTVwS9PKeoHn5RQp2ioMn3y2/Y6RXLDXE4RtKPXU77MV0dEPU21mkar4YQCFg+j9TRO5wNnwQyJy8OldsS0YMcUIzYXcBnW1zFlbevXXW9Kl14tLQNGV8fOHkc0HCvk4GokYyqPNnZ2Y5dgsImtnMBbQUCb9wpK61GDBznyEZlMJFjL6fC/0mNOljJZK9uipHT4IGLBtbQzs1eCIm+4cLL+9VzHPc18W+FvvzffL1heQlc92yXo6/QGxTXz40MCfVdX4b2L1+p4fPdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XMS/HuWqP1qL0RxWqfs3JhXTuXgp0rrs6F3LModr1w=;
 b=AoDo5ZI8xGOJQmKYFE/zXfhQeImuo7F69SQKavAQ8uvL47HnUIa2D9iVr0p8Ru8TSlXP5c+LMfdeloHpfEW6xUrngfoHj8ghJy2AmO5XjcMofXa+giuVgpJwxBKvKdVfx0Nux0w0geWXJp2PB6adlTE/V4s8nJH5R3K35fXbwZoARUjntIP1sDLIuDtWKfHBB21VcYSdMbtO1EOYB5ruPF3fKxoQhCI0xYvb65lTrvFGraTYukcroTufc4feuyopEhcTYoLDKL5OUozHtQAeFTHHGGYGNnfH/IF+BWR0eYt5i0EGrkTDLLfxJs3vWqxzXvZDXo7/rSMKZynu2Dh+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XMS/HuWqP1qL0RxWqfs3JhXTuXgp0rrs6F3LModr1w=;
 b=U/q7D8dT2w4V6OAaT5e+sDCl65BgWVUYMkAKZ20RIDe5Y+Wo9aA0ok3Ru4sZDMWYUNxGIQRq4MpND3RXsY8kkH/95d0lUZQhA48k3ZFNeBxkvz6hq3mIySaiLKzSn1wa2OZFNcGwGTytbm6sL0ri37jtsHfaH6JWAnWsHrHB5fD9TQMTx3phb4EZUtx9hA0lwYd9X9D7PSLC/2fLCmoBRnsxwA1pgz0CeZfsmscdIIhazaJ9xZgwozyXb/cX9grgYdisf7w9opgj7VvWaFX5eUFyARW1ojBDsIJaSABVuoBwb/pFpPATfKuJnHAku1yHuHVOt/FV+QOyxuBow81mzA==
Received: from PA7P264CA0196.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36d::9)
 by DB9PR10MB8144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 15:39:33 +0000
Received: from MAD0EPF000008B1.eurprd04.prod.outlook.com
 (2603:10a6:102:36d:cafe::a1) by PA7P264CA0196.outlook.office365.com
 (2603:10a6:102:36d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 15:39:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008B1.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:39:33 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:46:01 +0200
Received: from localhost (10.252.7.7) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:39:32 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 23 Sep 2026 17:39:11 +0200
Subject: [PATCH v2 08/14] iio: adc: stm32-adc: add support for stm32mp23
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260923-adc-stm32mp25-v1-v2-8-46bc019537c6@foss.st.com>
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
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Cheick Traore
	<cheick.traore-ext@st.com>, Olivier Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B1:EE_|DB9PR10MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 490894be-48d1-47e8-0443-08df1988ddad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|7416014|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5hPE5V+71wDbfTm8yHJSKlgdGW5ZuNMwNT6TvHcAwli71kaloq5P/M9cSAfXpMNYqBweo1ZhN0S+M1jtgT8q3Ch2VgVCdWb0G1ZHp4bBZTKpp06sCLE24GFrRH3Wur+SKvaQZIEWVd8cmSYZ/JL9rAIz7ybAaQQK3WA2ksNlr3CUH0DevCnbXRq41BEqEb5Sg7P4ONABzRpDegEnXOGzAQy3WB7IOGN5uKAA5Z1C2S9IVWfXZf8uyylPJeh44NGrbExVjRNz0/qzSphuDiN2BNiL4nU50SEInVIy3rZRRihHJa1DH/yjxRYzmxgr+Pm+sWhmQRYMjpcX6n9EbiT6Gf5q397clQRQnOqgqDGw/iuaU+DwRJ0E5Nj/H4BWT5Epiv3EdDI24W9ThWQj3QmtB30veHYa9Snnw7kmBg5ItNW0UHmHEITj135uxDaLMAupgffZ/NWvhaq8kvdxtLZttNN5CJbzV5qm7cd9ySnpd4S+IXlVEqc9CnLwBNgaDz0+x2o5DisE/r6a2G+YX6Xo7PA5cq/G0GQgAX5b9wdCgBfNSOXhoVxocCAlTjayq3ouh7zasPHHN0mMvw1VL6nQKzMF1JtnNZw7aNsUibW37+D0NsBf2CohQ4edIB+WZD+rTZO+a4cEYb79nOFc+5Fb7fUdPWLH5lDoDRUvXsIEPfRL5DU907NkgOtEgrHsSW6U8ubiD+9KOhSO6JBxA1dPTg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(7416014)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Fkny5WJbAz0UV0baqjAuUlWrqpd3oNrNuq9y2FP786Wy47nuY3PiyL+4GDx4juIgNHKI87+O2j/G5npAPleR62eIGFqT72QJpYdUejSHQJ3n/IcHaNbzKHgPw2UzWHsPHqTYuy6vLohJm/uPXPs0Kiqf6E8CDr4qJV2PrKV8n9WD5cAd9wUpOZqoC3EZxQaQEeSkoQaau9MYbneeW34tGXc/bTFx8R+W4oIZOc5Vpq2G/+DL28tfecED1OC4uQ2INfYpzfD3kLDqixUIdgoqDgU3qfil9I2Gv2igDcrwj/kwZ4JgrBmdxlbpt0MuwGVXDITItbs1BjNaO102QZVsUMorL8s31DC0FjpwVF3RlK3aKC8VRun4srCQxrOstmvxGXM1DX+U2WZu+nxrFep1TJy70NHNLWMib7+AQuJwA1f8XJJtaDoz8NL0gRMAMv6p
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:39:33.4043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 490894be-48d1-47e8-0443-08df1988ddad
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008B1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8144

Add support for ADC on STM32MP23 SoC. It has 3 ADCs, split into two blocks:
- ADC1 & ADC2 are tightly coupled.
- ADC3 is managed independently.

It is quite similar to STM32MP25 ADC, except for the trigger list. TIM20
triggers have been removed. So, handle the differences with a dedicated
compatible and compatible data.

Co-developed-by: Cheick Traore <cheick.traore-ext@st.com>
Signed-off-by: Cheick Traore <cheick.traore-ext@st.com>
Co-developed-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- New patch, split as advised by Andy: one patch for this new SoC
---
 drivers/iio/adc/stm32-adc-core.c |   3 ++
 drivers/iio/adc/stm32-adc.c      | 112 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 7027d86f7457..418846f736ba 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -948,6 +948,9 @@ static const struct of_device_id stm32_adc_of_match[] = {
 	}, {
 		.compatible = "st,stm32mp13-adc-core",
 		.data = (void *)&stm32mp13_adc_priv_cfg
+	}, {
+		.compatible = "st,stm32mp23-adc-core",
+		.data = (void *)&stm32mp25_adc_priv_cfg
 	}, {
 		.compatible = "st,stm32mp25-adc-core",
 		.data = (void *)&stm32mp25_adc_priv_cfg
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index a5bffc09898b..a14f858299ae 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -563,6 +563,64 @@ static const struct stm32_adc_regspec stm32h7_adc_regspec = {
 	.smp_bits = stm32h7_smp_bits,
 };
 
+/* STM32MP23 external trigger sources for ADC1 and ADC2 */
+static struct stm32_adc_trig_info stm32mp23_adc1_adc2_trigs[] = {
+	{ TIM1_TRGO, STM32_EXT0 },
+	{ TIM1_TRGO2, STM32_EXT1 },
+	{ TIM8_TRGO, STM32_EXT2 },
+	{ TIM8_TRGO2, STM32_EXT3 },
+	{ TIM2_TRGO, STM32_EXT6 },
+	{ TIM3_TRGO, STM32_EXT7 },
+	{ TIM4_TRGO, STM32_EXT8 },
+	{ TIM5_TRGO, STM32_EXT9 },
+	{ TIM6_TRGO, STM32_EXT10 },
+	{ TIM15_TRGO, STM32_EXT11 },
+	{ TIM1_CH1, STM32_EXT12 },
+	{ TIM1_CH2, STM32_EXT13 },
+	{ TIM1_CH3, STM32_EXT14 },
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
+/* STM32MP23 external trigger sources for ADC3 */
+static struct stm32_adc_trig_info stm32mp23_adc3_trigs[] = {
+	{ TIM1_TRGO, STM32_EXT0 },
+	{ TIM1_TRGO2, STM32_EXT1 },
+	{ TIM8_TRGO, STM32_EXT2 },
+	{ TIM8_TRGO2, STM32_EXT3 },
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
 /* STM32MP25 external trigger sources for ADC1 and ADC2 */
 static struct stm32_adc_trig_info stm32mp25_adc1_adc2_trigs[] = {
 	{ TIM1_TRGO, STM32_EXT0 },
@@ -3104,6 +3162,57 @@ static const unsigned int stm32_adc_min_ts_mp25[STM32_ADC_INT_CH_NB] = {
 	[STM32_ADC_INT_CH_VBAT] = 34,
 };
 
+static const struct stm32_adc_cfg stm32mp23_adc1_cfg = {
+	.regs = &stm32mp25_adc1_regspec,
+	.adc_info = &stm32mp25_adc_info,
+	.trigs = stm32mp23_adc1_adc2_trigs,
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
+	.vref_charac_mv = 1800,
+};
+
+static const struct stm32_adc_cfg stm32mp23_adc2_cfg = {
+	.regs = &stm32mp25_adc2_adc3_regspec,
+	.adc_info = &stm32mp25_adc_info,
+	.trigs = stm32mp23_adc1_adc2_trigs,
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
+	.vref_charac_mv = 1800,
+};
+
+static const struct stm32_adc_cfg stm32mp23_adc3_cfg = {
+	.regs = &stm32mp25_adc2_adc3_regspec,
+	.adc_info = &stm32mp25_adc_info,
+	.trigs = stm32mp23_adc3_trigs,
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
+	.vref_charac_mv = 1800,
+};
+
 static const struct stm32_adc_cfg stm32mp25_adc1_cfg = {
 	.regs = &stm32mp25_adc1_regspec,
 	.adc_info = &stm32mp25_adc_info,
@@ -3160,6 +3269,9 @@ static const struct of_device_id stm32_adc_of_match[] = {
 	{ .compatible = "st,stm32h7-adc", .data = (void *)&stm32h7_adc_cfg },
 	{ .compatible = "st,stm32mp1-adc", .data = (void *)&stm32mp1_adc_cfg },
 	{ .compatible = "st,stm32mp13-adc", .data = (void *)&stm32mp13_adc_cfg },
+	{ .compatible = "st,stm32mp23-adc1", .data = (void *)&stm32mp23_adc1_cfg },
+	{ .compatible = "st,stm32mp23-adc2", .data = (void *)&stm32mp23_adc2_cfg },
+	{ .compatible = "st,stm32mp23-adc3", .data = (void *)&stm32mp23_adc3_cfg },
 	{ .compatible = "st,stm32mp25-adc1", .data = (void *)&stm32mp25_adc1_cfg },
 	{ .compatible = "st,stm32mp25-adc2", .data = (void *)&stm32mp25_adc2_cfg },
 	{ .compatible = "st,stm32mp25-adc3", .data = (void *)&stm32mp25_adc3_cfg },

-- 
2.43.0

