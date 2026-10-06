Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460253C8724;
	Tue,  6 Oct 2026 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273517; cv=fail; b=ofqRCmZRAfflMvVTe5B+C+hof7JDH8CAi/MbNinvQXLIzbLcPWRaYKniL9UeXaqO3Y4qAWanB12oWixjvGDbFRhrV412j5uX9ZfHr/AwsXLGpyqd6hvrud2v3f3+FFIJYrFzxCVjus0R+gF2Fj3kbYF87V8o4qZkQ9iGGqZQSVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273517; c=relaxed/simple;
	bh=QK5M/Cq/kJn9FSiAHivPbKKTtVy2Hb0PBJN8THLgk/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=r5ZXNxIQ2SArVcIMIfhHZ4bQbBBGluNw/wt++Xc8G9DYzgaW7wQNhVU0Zu3gvoX89wS+GYWn9PqiN6RQSb050dpL7oCnqL7qUxF/S9YakiSfqDWaNi9XamZHLSikWz2ys85jGPrYornD3l13vMYJaY7VjEWhaH0/wh0HR/OHr7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=JxOAL7Eq; arc=fail smtp.client-ip=52.101.83.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="JxOAL7Eq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ki8fyfvsTzuPBVp4J5a4fqr9Htn9pqDCb/miRYJpKdPUXwOn43D4Nw1GaFun7DoZnJSJDPiPzRg7zw1uc+3/7zWLkNXSdExe2WowQsqk/BQWIGgCaxY3KxFli6XT/NkR6PL22gXiaGNrCeVGdzMDVMWlWy2Q3gy9RvYCqORii4nmJlCoLkfzm7yKfXOtUl25T22MgC1dMhHi31pnNVuF39O/IJJMDDX3NB6s5X+WXJWxXojs1dNBkXo5NAeIfu1Kfb1PztRiOWLs73fRbx6ukw1UKBNDYuHdRbk8jwTyU+ZMisdVZKyIA1EoEtdWRyqKdapdZcacYgXAjFP1L7zUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDr+BjhC74a9RlxfLN1LLRrh4hmywh9coivHmGRvIew=;
 b=JVzt1QsXfMPjQrZ0n+KBXxE/LYjExQxCKL7xiy7Wqu1u/Grp5spOqgw6/EV2mlpx4eifBdswMguMkvm4MTdMesLBkySM+70gOTvPjGS7+rmHByeo02Ui3515P2tzm6WOBeNfzZ276mJH5KyLnm/TBbizFSEuIU9MGjXJTsYQKly81f3lcCzkpvq953tlxDodrWRGIUAc2EbpRF8XFBLftzWerG4dWk8M57G4axCqLNYzr1qyLBRbhq7G5/Wimi9pZCFW5cvABMIIuX2VquQuOb5Q4SyXN8CxRmpsvc82SJyCRT8oSsY1PwsfyLS3B6dzBn1QUIvzbxT+2veQfR5q/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDr+BjhC74a9RlxfLN1LLRrh4hmywh9coivHmGRvIew=;
 b=JxOAL7Eqm1LxhKOHPx2xzYeWmvym/zdl/evMAGn1BX2q9ZJpZXCDZybKPTump6wMai8WQaFqv+/72CN/WVSXqQUrIa0lU1TX2H/2rlfhS6coIcLRrHO0zEseb/gmwU7fUkE6dlP7Ir9BEZC0ntMKXGjJOsxcKOv/5j8Uc8Fubn3L3W2rAHuT5AELdVdRgFNJNawU4Lb+W7gvAjFMle1V980R4skVHQtC8AvB9rpzWxyjypNwgI1iyxQz3fuD9lnrMSRiLVW/hn+oSEvtJGk+RdnXKvkc+D/RyWZrJ1881kO8YhmRappoiZU2qKLquTyRzRpj257MZ2klXmnpuPeweQ==
Received: from BE1P281CA0472.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:7f::25)
 by GV1PR10MB8754.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 07:58:18 +0000
Received: from WA1PEPF000099CE.eurprd04.prod.outlook.com
 (2603:10a6:b10:7f:cafe::8e) by BE1P281CA0472.outlook.office365.com
 (2603:10a6:b10:7f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 6
 Oct 2026 07:58:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF000099CE.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 07:58:17 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 10:04:59 +0200
Received: from localhost (10.252.27.219) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 09:58:13 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 6 Oct 2026 09:57:40 +0200
Subject: [PATCH v4 09/15] iio: adc: stm32-adc: add support for stm32mp23
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-adc-stm32mp25-v1-v4-9-d31ec75aecf3@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: WA1PEPF000099CE:EE_|GV1PR10MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5f5b5e-33c9-4220-a392-08df237f9534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|82310400026|376014|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Fuf8FpENb1Z6EAXX98OWnl7MVB8u2GTq5vbQO424KTKcJqm+JQDKY/P2e0kjrqM/jfg8L/73g1QhPidXfgGdpkbnk/PGXO1tDzEbD12+/YvqC0VN5Iud2IztnyneCiPzQ+CY5MH1WHPsQLtxbwy8S9ca6X8NXbzShPUjGpn0boWwXpVIgE8tiBpUDFVP9pLj3EhVfzb2mmMj9J5yu/oXkAMYtyXPuerf16lxiFcR+6RjvY1NnTUKAy0emUiDMwUgv4X6PjdcBDvr2nuuN9NZlLjFWz9bTxAmqoE/AK1HPSXsqqzncZjrT51Ja9Keua19Hlv7VFhcqyISoS45iknh6B47XhIUWpff2VWXuFRE/JmA1kPlWwMPrv38J1JSxFQ7lG92LhtMF9C+Ht9qpaJmn7d0LzWIug29fw+RReGP5Ympiv8Lz7XlHqeU5Jn2ESlhMj5quFtfd9TZ967LOy5nmbvwHWs+2GtApQRrRpwFfVgg3sHLF9ZFrnXv2TVUCxukuVuw6I9uFwhDv9z+lHwO55hTf5wZVlTN7gVVFM8J4lB/l4hMrcLbIGNgBTjv+qLFT+BAFR5/etUJb3hbwNNMogtqbIBvDtiKByQMqu01c7P1MZKUlatYjVvOVqKFWnNMlyOHRgro/yeXGMEBqp6ZwkmMJBXETAhP90t0OPci98gHd6ry91G2pFixdt+cz/azZyHk5PTje6oW9EG2DF9g8g==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(82310400026)(376014)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Cr/7Zw4S+AETclO1gQUB/kJQEepMXl3wPJHnSsDTp6DwQbTOnkxZsnKn4SkzlgA/ByEs5YhXRAN73dgXO+Mg2sgktwxQh9A/F9BDLDvoLSF+4P3/d6DRjIKDee79APa2bKgK7hIvVvoDvhM8OwNRg1D5+vuNy74xh0b3zZUEQlbB5Zw4Df1uWWDJ9fuT4EQIWxl6qmL77zMIpE+nGxFUDo/Ty0ein3cGpOOj78LFrmV1/vgk2hLLwZzsvfz6DZr/CaiZl/KZmRMS6MyjDyhzfgHl+q/oOMT8BQkJR9hhxh9b1C8PwdzmBIRmYvtk3JrbrL+fCmX1GWELvZbC+mUA41n2gpdNGH6A1G8sQd4ixxFw9Uk13nCv4ui0JpnaSOxhHp6FKT2plEq7zvcdQq276nPuAb+gVVz6f2yU4iv7MYmiRGjTd2gS7gXigPNYfKtr
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:58:17.9839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5f5b5e-33c9-4220-a392-08df237f9534
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF000099CE.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8754

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
Changes in v4:
- Use const for stm32_adc_trig_info as raised by Joshua and Sashiko

Changes in v3:
- Style: Wrap core ID table to 100 chars.

Changes in v2:
- New patch, split as advised by Andy: one patch for this new SoC
---
 drivers/iio/adc/stm32-adc-core.c |   1 +
 drivers/iio/adc/stm32-adc.c      | 112 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index aff369299255..c409edd3a827 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -936,6 +936,7 @@ static const struct of_device_id stm32_adc_of_match[] = {
 	{ .compatible = "st,stm32h7-adc-core", .data = (void *)&stm32h7_adc_priv_cfg },
 	{ .compatible = "st,stm32mp1-adc-core",	.data = (void *)&stm32mp1_adc_priv_cfg },
 	{ .compatible = "st,stm32mp13-adc-core", .data = (void *)&stm32mp13_adc_priv_cfg },
+	{ .compatible = "st,stm32mp23-adc-core", .data = (void *)&stm32mp25_adc_priv_cfg },
 	{ .compatible = "st,stm32mp25-adc-core", .data = (void *)&stm32mp25_adc_priv_cfg },
 	{ }
 };
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index e7c927d1a73b..e744e1d48823 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -566,6 +566,64 @@ static const struct stm32_adc_regspec stm32h7_adc_regspec = {
 	.smp_bits = stm32h7_smp_bits,
 };
 
+/* STM32MP23 external trigger sources for ADC1 and ADC2 */
+static const struct stm32_adc_trig_info stm32mp23_adc1_adc2_trigs[] = {
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
+static const struct stm32_adc_trig_info stm32mp23_adc3_trigs[] = {
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
 static const struct stm32_adc_trig_info stm32mp25_adc1_adc2_trigs[] = {
 	{ TIM1_TRGO, STM32_EXT0 },
@@ -3136,6 +3194,57 @@ static const unsigned int stm32_adc_min_ts_mp25[STM32_ADC_INT_CH_NB] = {
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
+	.vref_charac_mV = 1800,
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
+	.vref_charac_mV = 1800,
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
+	.vref_charac_mV = 1800,
+};
+
 static const struct stm32_adc_cfg stm32mp25_adc1_cfg = {
 	.regs = &stm32mp25_adc1_regspec,
 	.adc_info = &stm32mp25_adc_info,
@@ -3192,6 +3301,9 @@ static const struct of_device_id stm32_adc_of_match[] = {
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

