Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2D14D17AA;
	Wed, 30 Sep 2026 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777972; cv=fail; b=Nl6sSn/+gR2OP9V5NfetbUZOdyZh9RmyMeTJokm2qSSpsIhjda2nZu3ArGOvgIyBjLL+VeNW9ePHtmmF6L61UFSXEsRvR1ByXQtzSu4Iqu8Ajull4VWqIrPJ1ni+eAZBYCqNJh8g12MIi23rcQ0VVm0NsWsyIOtzGC+hPNHD64o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777972; c=relaxed/simple;
	bh=niovY3h1hoKLtM9veTyU+YB8ASKYFfAxrmyDfkbxOxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BzrSXdYgLfuao6urbCgOlvhGfCA4Tkzm1E5vRllqvEarJ2BSv3qzW/Hj8qn5s/67yPe+rBW9apTV4X3+8tg8eEmCx1chI/ztfPeistltKyniqiYbwjUSvhFy3H5ALiiH+JIYj7tlr0GsnLOkcFaavtXfyYizDU1ZwGgUYmWzDvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=jlaIyT5G; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="jlaIyT5G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZZL6vees7Y5RXUhwsHK9/WvksP3HvRSk4BFL2z0xde5CHpM+eZVUeFhx7CLvSCmT1R+d1+7dA7UHyNxXldxqDGc12qfrRrJysp2nh3D7XGwhTrmM6jkZNS2wHnaXGou61Vw89VnDJDaOo4zFMg5qfXw/fYaOMtWnIKROf9n8m1EpuX7SmALRhBWZZobRd1Qiq/aDWxfbNJTkDWHenRXlBl7I5xCcmjitb6MHZ7O4qIhNRisYUVCECYkvwJxqxf9G9jcBcBuVC+wRZXgC7nMDCTAiL2LZ9e0BSk91CZbq+XgEaLDIlqIL95d+NSSGdeWfuzWUm8TpM2AO9h7yXVJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbhE4/4WhD0qAaXqqqxIQlcZOQ8/XdQavUnql7M1ZQ0=;
 b=hMUNS3045reQSRXwi86VhkwpFw1spb7Rstb07jOFulF7lbJFVr86ROQQ2BI/QY00mU+yDorpCh7xqkrJaOuZyXAmXGgOuy+/XT6rkY0Ca1qnI7bApWEdVktdlouEiBowdgsGqkdix0GZiv3FTiT/zOEUvWOOZLTWwDNQziDquuzcpicKOzrjhOqvif4VbEW0b1DNoLdpr5rsD4fIP1MHRMXKx5XP6sALiI7dn8Eu0wRKUIfdS2KqCCmNjmfi9YwxvRb8q67CRaV18FnHt1Wfo/Iolc2d6Z/WwwOVJZfhUqFrtUHSlSjHEoZ2SaKmidbHsMB+ZLV5WWvA8Y9tf0e0RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=baylibre.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbhE4/4WhD0qAaXqqqxIQlcZOQ8/XdQavUnql7M1ZQ0=;
 b=jlaIyT5GEPE2vkQvRX/pV6lCEfMtbVsSmTrD34+pYyuV77fROIIldAXZ0JMprAl45r5hqv4x4DKMewAqqpsWCGrYScQzpVb2nzrelSVya106BIGDONcZxZGrhK6QwQNedaZwRDKpEmLSwg+Q9LJtkq8j7Wm7cb2j5zrV0h8woM56E/scxKgk015CiwVUUnkemnXIo9QWPagWDICa9XOjw9OlPHNhSI8yt6nNHlh67XjnBRn2l3iKxgXEgFqDRirSsF49gz/KqdOxNF5hCXVxEATl+kqiXoPPg2pillyPI10KzRJd5C5+O8AssQfoavjlERhrIu/rV38RgAHxjebKpw==
Received: from DU6P191CA0044.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::24)
 by PA2PR10MB9068.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 14:19:18 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::d) by DU6P191CA0044.outlook.office365.com
 (2603:10a6:10:53f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 14:19:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 14:19:18 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 16:25:50 +0200
Received: from localhost (10.252.17.140) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 30 Sep
 2026 16:19:17 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 30 Sep 2026 16:18:30 +0200
Subject: [PATCH v3 09/15] iio: adc: stm32-adc: add support for stm32mp23
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260930-adc-stm32mp25-v1-v3-9-406834430d72@foss.st.com>
References: <20260930-adc-stm32mp25-v1-v3-0-406834430d72@foss.st.com>
In-Reply-To: <20260930-adc-stm32mp25-v1-v3-0-406834430d72@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DF:EE_|PA2PR10MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: d3809dee-a66c-4576-740e-08df1efdd07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|36860700016|82310400026|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cCznogn2NzAEAral4Xo1OIvCy8LcsP54pbqCkliqx47dljEl8VbFByB90lAYDBqKqb50wr3lQyisBOlHQtAUlwt3hFeKdCkdp6MQhidP3A8oMqi+52rVc+h1pGKyEHJPhrBEjA8VjRLh5bYdFKPmcl3aF/M1bdpSc3BMjvl8/NwxPP6Q6U3bLAjIyVrzIdB6mqhm+ro+MWJR+2rpyKGoHaQsZwP7hF5VzoqcaLl8NBw5jp4uI+7N90wTsIqovNXLFemyuU4VVw9vnhAzo/8rUiKI9FRKr529MhUui0waOZRQYKIKpcRYL8ppAgC1wFqJY7gWPQs2aw6MHQfkzyGI+foAa9Wn0YIcpWC7Opb2qUY6ET2Gn50rSWUwrIRQPPBYupQvPzQfevsEyNNaDSCOdbJJ3iievJBfo4+BhQLEgPzGKgKEMmWq718SWu9WB8lnh/ISARmIEo4D3uop4R3r5IukSvie2LcUl1F7lL64sn/G/qIraoGHyaoyHUMkVzQYVLiIwi3jOM95Bo12euSSoB8qM1N/vsKa6FvqwmWIJfvKjebeYjzxHlBVbUv/tponx8jIGcEEXMr4wv67fpiRlNjFF8ItZcM21yDiEnEBLWDTACGaJFQ65XCPq4WBQb2Nc0JTjFJOeQN5kXpyc70LUKqOtZ4z+27U+47LFYqgDe7GIaFi04MD3S0+ctQJeIm6p5lFTtMunjDKTz7bAp20VQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(36860700016)(82310400026)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MtML2EzZ5G2O7A3I9Sq9Ko4UGHiXThDKW+xRQbu3XxL4PnADmbLx/cztldeOzGh3bSv18aXAPtTgU3h7an+ouuS2c854Rgvy9OfHU/+ZfQe6s/9iml3GAJ2VvYHQ1qagubtz/hLbliPNB6bApo29040F9fSbpf1/DtSw3XO/i2886CFp/YPWjNyBtxTZ2nfnV5QvIWPW1uNFcKa9+pd4/SIDinBxbrjBW0I97EMpb71fjgmM/FA7PXiyqvziH6+jYzDDhOJA4myIJWSErmE9duF4+9Us2P4kykzhJBX+BpYRr47ALyiZd88bY2GDwdDdxSvtevg8CTcKo2WVxFdNutk92bvFJ671ix8bLIjv8e43Xg9Rl7aJ6Mwu7fLkc7BopYmX2OdoKPz0CnHIeFO5Gm6CPKoyaCUcyuKaiwVYoLZFjNC2ZtkRYnWFM4l8ZfIE
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:19:18.2089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3809dee-a66c-4576-740e-08df1efdd07b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9068

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
Changes in v3:
- Style: Wrap core ID table to 100 chars.

Changes in v2:
- New patch, split as advised by Andy: one patch for this new SoC
---
 drivers/iio/adc/stm32-adc-core.c |   1 +
 drivers/iio/adc/stm32-adc.c      | 112 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index bb8b53f52914..f94cc6fe4c02 100644
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
index 33e41505b2e9..210b76b21d13 100644
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
@@ -3131,6 +3189,57 @@ static const unsigned int stm32_adc_min_ts_mp25[STM32_ADC_INT_CH_NB] = {
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
@@ -3187,6 +3296,9 @@ static const struct of_device_id stm32_adc_of_match[] = {
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

