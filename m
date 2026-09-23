Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFB5559C91;
	Wed, 23 Sep 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177982; cv=fail; b=WLtshapiIRs2jFRDFuV1zeXodUeXwncY+kf5BNR13CfDxm11FHXiXLMkHonjC5EGWiumeQQY0T3dNzk8gbXlI1PVgWn5+MEqoXC4iJybQ21bLsrjFjlwX3sizseQ5qHnAzs5nJ1QDKaA85iGFLa7tZSASHXnnbUSmX1odDoehwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177982; c=relaxed/simple;
	bh=1o4ZB3hyGgPd+QTA4pvRqDcR5VCYq6RppbV/pQORpxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=vFXuo0WLvANP8992rC+UzRjdMoxmShLhaISN/A9iWqALd9L2Sj5lV7aZMYxvJB8JaFASR7J4/ZLUPBFDeb3IelaFoLMopuXsM+9kd60eLz+CTYeEyDbCDqNLSXf01/wVUqUYW/PZwqv0vLj1wb/wjbT0EpA3MO8J7z5KUu8kTF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MNERRic1; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MNERRic1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPdAzWhrqxSZ34h1gWzm1ht4wVxPENyp17lTNiUoR8rHyG5R3qVk9e1O+dkO742nSCwIhtYYEB6hbz6kWWKlRGQpgSuTLA4sQ5DkDMNn7mn4ECQbQ64WwOFRQYW3fO/Na/4vA+19XiCJkqWPpIey4ZZMgSB8sFSeGXxTtXlBoPSjrKuNUgMt05J645bSeUjV0S3STHsUghywvU/jMIOJWfkRiTzHu4alDT2u+6aMRO7UHz9c2YCNlHQOpe1d6ad7ug0VLxYbZ2fy3bKQ2hILH1FigPBNfxHRLBziUhfES0Qvr4utvFKjwvA6arYYKgdmAZ9dcLt00x1uMOU3mw289Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PT1dp15KULXOZ+UCcqVd3/kazFIBGJ3dDabJ0NN+gKk=;
 b=YOveISJvFVh6kzndfjXlOQ0HSUf1T93hyVqchVYnEuAMrfatFwqJj/EjmeiNOW36p7YD9hw/4H98qs4/vhAtOA43g4wXE9KKn8ij2czbhqNgGXZHTbjXRpHSNoSxfWFw8Tlp7Rk9Dt0Oqih1ZnL9GPl8kqlXz0npDtXDLDCoCYXqIDhs1t11hFLDz6aF0VgzWipK5QBlp3m3xNyAL+P8zmsCn6fMqhcMJY7KApK7QS1oTeg2W8VxqTO3OvQDfWowQBgi269X2vn5QZKfUZZf35oy9XQVCySYaGwnd7KeAkrfjopsd1eU1T6iVcqmB9iT+CxnfWqTvzPmD8f35QsCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PT1dp15KULXOZ+UCcqVd3/kazFIBGJ3dDabJ0NN+gKk=;
 b=MNERRic1g9BXXwd9YcWy91RxifXk1R9kPi1axcoT/30bIewOS1ZQxG34I16AZIGCQkrT1BCoy8UQ2v0CBY48k83rnj4EojTr9NHfxWY77I6jtSoRWRCfUFAZJhDVizkyTU065A2H9+igYFV3sgeWT2PLI9fO/sNfPsuuoyE2FraCSZiUMOk5UMNl2HIjWNiD09aInWzWkO+68YCVy5AW3HDA2mgTgz3oCGBiyRmnvM0tGxtPcWqcRCo31pQItNMVCSfVHrec2EcOYwIG+gQz686X9TqbJ4MgT6ZloyaB/mYA+AyS+G042AXmfDqrmx5O09VWLkedWvOSd0SNoLXBtg==
Received: from OL1P279CA0049.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::18)
 by PR3PR10MB4126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 15:39:34 +0000
Received: from WA1PEPF000099CF.eurprd04.prod.outlook.com
 (2603:10a6:e10:14:cafe::6a) by OL1P279CA0049.outlook.office365.com
 (2603:10a6:e10:14::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 15:39:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 WA1PEPF000099CF.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:39:33 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:45:22 +0200
Received: from localhost (10.252.7.7) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:39:31 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 23 Sep 2026 17:39:10 +0200
Subject: [PATCH v2 07/14] iio: adc: stm32-adc: add support for stm32mp25
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260923-adc-stm32mp25-v1-v2-7-46bc019537c6@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: WA1PEPF000099CF:EE_|PR3PR10MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb5fe04-9ae9-4be1-b116-08df1988ddd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700016|82310400026|23010399003|6133799003|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2w1wWuU3kwrch644ZNgXgbH8OO7JJEPri3DTSYbS0DRjVjrWLdAvXhUGP+dmk9Q1eU28a2iRQlE/Uc1TtlG/dmVX3M3lIOPiEogC7+xW0B7SxUUrGIFSv6Fhjv8eufJIfpYM0Ig9plxabC0r1tX7yunlB5jh4jND+3GKH+DtJG6vyaEHVR6gkZ7ZHqQbvXRlNQ6aoz228YIOYQSNT1kJ6XdolASVZFJFiPTWFTlWTgz++ViH8kgkNqyvshWtgJ9qWWwgZnT7BDgu4uSf0AZWQDhG+/sHXmSxyzZC+LwgTrfIyXsPEG1okojBvNsDwjCBJRfK2tZyFDOT0/9fWW9U/uHsqiETelyHnfLDroJ2EQroAzyDb8Ic+uMYtXsOQXeCXDQB5zDVZMZKLEyRmWbyM0Hhp1bSuGf5UsZ8XFqWMMl4fo9EYClMybKMgKDoRkFcZc/TkIDjHce1S/uJRE0NLLHpFp4BpFbEZEAJIe2xk33npyOoAu0mkwCdXA/kPqXvwmFtwIiPzimPy129kT63GWx5zAMkjq5KszmgRcnY/JGCwAFiz6jCA+hmwBz8Cmq0lOl58xS5k3lz1mlrnVYlD+djuXMRplNuyWpCiBsVuiFo+R1xwvrQFFDQF7HRAsMe1KkQsL9kzTI3DXHv/n/BUhKlsUC9JhsTWW6uWax0zvQ4bdXSEVLBjs+6T3QhFfcWJILgn4IAXsPl1cu6TdUA8A==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700016)(82310400026)(23010399003)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u9Av4s2WXel++J+Rnct/+v4O8JRU/cvXULwGH03ziRFJz05e0ZklZaCvy6mwwXdDJ9C0WK8b2yBTrvxMMvthqvK5DpUUxAYyn+4yLS/SG2xRFOmdiNgRLRba0sEw5pX+2zWmaei6UilMJrzOhm4Nv2p93vAnTDhyIo+mWFLH+hqgYHNV2MVb5vvT0EVzRPjUDcNqWYOEVXIGwqQRZD8jvBvS1bBcL67l/llS1U2y7wkyLZ/k3AFInGOnPeqJ4OlJhhB1hxvejr7APjTlfAcEc2tlBZRIShmA4KnQseKEND47sFpZtlferBHJ6UHYQ0rX3rW0Zf3OzpPkuraSs9fdO9gBP1JncTpjk+hb/YCF7MPNr+gKsuz7cWFQ3bXaYGtZXhILEWZgPn6N50/PlOgFfUySznzCXgzT3n/mUiIcsPDJp+qbUtaS4jRJqbqeonko
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:39:33.6481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb5fe04-9ae9-4be1-b116-08df1988ddd0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF000099CF.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4126

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
 drivers/iio/adc/stm32-adc-core.c |  43 ++++-
 drivers/iio/adc/stm32-adc-core.h |  20 +++
 drivers/iio/adc/stm32-adc.c      | 372 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 434 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 5845173e288c..7027d86f7457 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -138,6 +138,9 @@ static struct stm32_adc_priv *to_stm32_adc_priv(struct stm32_adc_common *com)
 /* STM32F4 ADC internal common clock prescaler division ratios */
 static unsigned int stm32f4_pclk_div[] = { 2, 4, 6, 8 };
 
+/* STM32MP25 ADC internal common clock prescaler division ratios */
+static unsigned int stm32mp25_presc_div[] = { 1, 2, 4, 6, 8, 10, 12, 16, 32, 64, 128, 256 };
+
 /**
  * stm32_adc_clk_sel() - Select stm32f4 ADC common clock prescaler
  * @pdev: platform device
@@ -348,6 +351,18 @@ static const struct stm32_adc_common_regs stm32mp13_adc_common_regs = {
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
+	.presc_shift = STM32H7_PRESC_SHIFT,
+};
+
 static const unsigned int stm32_adc_offset[STM32_ADC_MAX_ADCS] = {
 	0, STM32_ADC_OFFSET, STM32_ADC_OFFSET * 2,
 };
@@ -425,6 +440,8 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
 	 * Interrupt(s) must be provided, depending on the compatible:
 	 * - stm32f4/h7 shares a common interrupt line.
 	 * - stm32mp1, has one line per ADC
+	 * - stm32mp25, has a dual ADC1/ADC2 and standalone ADC3. Each ADC has an IRQ
+	 *   (two for ADC1/ADC2, one for ADC3)
 	 */
 	for (i = 0; i < priv->nb_irqs; i++) {
 		priv->irq[i] = platform_get_irq(pdev, i);
@@ -705,6 +722,17 @@ static int stm32_adc_probe_identification(struct platform_device *pdev,
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
@@ -897,6 +925,16 @@ static const struct stm32_adc_priv_cfg stm32mp13_adc_priv_cfg = {
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
 	{
 		.compatible = "st,stm32f4-adc-core",
@@ -911,7 +949,10 @@ static const struct of_device_id stm32_adc_of_match[] = {
 		.compatible = "st,stm32mp13-adc-core",
 		.data = (void *)&stm32mp13_adc_priv_cfg
 	}, {
-	},
+		.compatible = "st,stm32mp25-adc-core",
+		.data = (void *)&stm32mp25_adc_priv_cfg
+	}, {
+	}
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
index eecdc4cce1b4..a5bffc09898b 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -33,6 +33,9 @@
 /* Number of linear calibration shadow registers / LINCALRDYW control bits */
 #define STM32H7_LINCALFACT_NUM		6
 
+/* Number of loops in the calibration procedure to average data on STM32MP25 */
+#define STM32MP25_CALIB_LOOP		8
+
 /* BOOST bit must be set on STM32H7 when ADC clock is above 20MHz */
 #define STM32H7_BOOST_CLKRATE		20000000UL
 
@@ -77,6 +80,14 @@ enum stm32_adc_extsel {
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
+	STM32_EXT28
 };
 
 enum stm32_adc_int_ch {
@@ -348,6 +359,20 @@ static const struct stm32_adc_info stm32mp13_adc_info = {
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
@@ -538,6 +563,114 @@ static const struct stm32_adc_regspec stm32h7_adc_regspec = {
 	.smp_bits = stm32h7_smp_bits,
 };
 
+/* STM32MP25 external trigger sources for ADC1 and ADC2 */
+static struct stm32_adc_trig_info stm32mp25_adc1_adc2_trigs[] = {
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
+static struct stm32_adc_trig_info stm32mp25_adc3_trigs[] = {
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
@@ -1304,6 +1437,184 @@ static void stm32h7_adc_unprepare(struct iio_dev *indio_dev)
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
+	const struct stm32_adc_regspec *regs = adc->cfg->regs;
+	u32 val, avg = 0;
+	int ret;
+
+	/* Repeat several conversions in calibration mode, average the results */
+	for (unsigned int i = 0; i < STM32MP25_CALIB_LOOP; i++) {
+		stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADSTART);
+		ret = stm32_adc_readl_poll_timeout(STM32H7_ADC_CR, val,
+						   !(val & (STM32H7_ADSTART)),
+						   100, STM32_ADC_TIMEOUT_US);
+		if (ret) {
+			dev_err(&indio_dev->dev, "calibration average error %d\n", ret);
+			return ret;
+		}
+
+		val = stm32_adc_readl(adc, regs->dr);
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
+static int stm32mp25_adc_calib_single_ended_offset(struct iio_dev *indio_dev, bool *add_offset)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	u32 average;
+	int ret;
+
+	/* Select single ended input calibration */
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADCALDIF);
+
+retry:
+	/* Clears or set CALADDOS (also clear old calibration data if any) */
+	stm32_adc_writel(adc, STM32MP25_ADC_CALFACT,
+			 FIELD_PREP(STM32MP25_CALFACT_CALADDOS, *add_offset));
+
+	ret = stm32mp25_adc_calib_get_average_data(indio_dev, &average);
+	if (ret)
+		return ret;
+
+	/* Add offset and retry single-ended calibration if the averaged data is zero */
+	if (!average && !*add_offset) {
+		*add_offset = true;
+		goto retry;
+	}
+
+	if (!average) {
+		/* If average data is still zero with additional offset, just warn about it */
+		dev_warn(&indio_dev->dev, "Single-ended calibration average: 0\n");
+	} else {
+		u32 calfact = stm32_adc_readl(adc, STM32MP25_ADC_CALFACT);
+
+		calfact |= FIELD_PREP(STM32MP25_CALFACT_S_MASK, average);
+		stm32_adc_writel(adc, STM32MP25_ADC_CALFACT, calfact);
+	}
+
+	return 0;
+}
+
+static int stm32mp25_adc_calib(struct iio_dev *indio_dev)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	bool add_offset = false;
+	bool diff_below_zero;
+	u32 average, calfact;
+	int ret;
+
+	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADCAL);
+	/* Use default resolution (e.g. 12 bits) */
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR, STM32MP25_RES_MASK);
+
+retry:
+	/* Single ended input calibration */
+	ret = stm32mp25_adc_calib_single_ended_offset(indio_dev, &add_offset);
+	if (ret)
+		goto out;
+
+	/* Differential input calibration (keep previous CALADDOS value) */
+	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADCALDIF);
+	ret = stm32mp25_adc_calib_get_average_data(indio_dev, &average);
+	if (ret)
+		goto out;
+
+	/* Averaged diff data is below 0x800 (half value in 12-bits mode) */
+	diff_below_zero = average < BIT(adc->cfg->adc_info->resolutions[0] - 1);
+
+	if (diff_below_zero && !add_offset) {
+		/* Retry the whole calibration with additional offset */
+		add_offset = true;
+		goto retry;
+	}
+
+	calfact = stm32_adc_readl(adc, STM32MP25_ADC_CALFACT);
+
+	if (diff_below_zero) {
+		/*
+		 * Averaged data is still below center value. It needs to be clamped to zero,
+		 * so don't use the result here, warn about it.
+		 */
+		dev_warn(&indio_dev->dev, "Differential calibration clamped(0): 0x%x\n", average);
+	} else {
+		calfact |= FIELD_PREP(STM32MP25_CALFACT_D_MASK, average);
+		stm32_adc_writel(adc, STM32MP25_ADC_CALFACT, calfact);
+	}
+
+	dev_dbg(&indio_dev->dev, "set calfact_s=0x%03lx, calfact_d=0x%03lx, calados=%ld\n",
+		FIELD_GET(STM32MP25_CALFACT_S_MASK, calfact),
+		FIELD_GET(STM32MP25_CALFACT_D_MASK, calfact),
+		FIELD_GET(STM32MP25_CALFACT_CALADDOS, calfact));
+out:
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADCAL);
+	stm32_adc_set_res(adc);
+
+	return ret;
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
@@ -2786,11 +3097,72 @@ static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
 	.vref_charac_mv = 3300,
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
+	.vref_charac_mv = 1800,
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
+	.vref_charac_mv = 1800,
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
+	.vref_charac_mv = 1800,
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

