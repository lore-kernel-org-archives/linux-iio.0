Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013024.outbound.protection.outlook.com [40.107.162.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7D04F85A9;
	Wed, 23 Sep 2026 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177975; cv=fail; b=Liojn99RjqWFg5nnahYUkn33MgETBzeRsRBRl7HgQOGx5GnSsztcE8x5mokaUFg/5AYYV1i5QPtLHdEWShuVa1EunT9IlQRKQ4av8Y36/qjiWP6OiiSNpX4EUoK1u8qwwdA1JNy2GoA3a5tuW0XW93z1ccTuZ6XwvHMDOQxXFBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177975; c=relaxed/simple;
	bh=BhYJx/9A2yNqo3/jeMOUUB55QCOnQqwyhY2wHO0abYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Xl7LJT7mJSaFAu7JnMGa/5pPSR46RfSI+MeV/eDlnZh9oRRuNO2LaVLJx1Mck8s6XPRZ43ZLRqoLjHKKXczwIkZ4hJvmxOgXdKfkQqBGfrUFxl9uTZAWF3b2dOR20ujZGHHTzLZzjtOqekdDt4kbbNt1h4cF0UPkk728ARi+OIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=LodmsKxO; arc=fail smtp.client-ip=40.107.162.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="LodmsKxO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1IcC4SROYXNClexriguMr4/FS/p6GSfS8s5vsboIDi72jFbCymOXJ5hr498YQPWuR9P5GWlsRr2MBc5ybYcCKc0sL1BlS/1yrh/SyGq8vc8bl5S/tGoiC2P4DGpfdb48dyR6ng34uI1de3o59CZtz9A1oAWwsuqa80kIvOoDOVEMYIwMWpGLF1Lr9nCau5lkh0A1zezw9JXKlxw7bV5powxkn3XGz8zJ+bYOcV8Ua3/AZD7cz/BIfNgdxjyAQBozfCEj2MJJNCsBhm/a1cwLK37ke3vh0sA55DFwjIYrVAkBR/wBoXB65cAvrX9absmBcndabhp0OCUK8qQ39gLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQRRyv3J5DLGN7L/CYs+2LWcQAdmwhlsHI04RAiZ8o0=;
 b=y8H/AqgWiytcDN42uIzSf3xhGV3rFz/vV2tvQx7nnDT+O0rK5eeIk+DC2NP+nGl4meMMJDDQ8eMSESkc0HwgPhsp8ywUlvtwzjr66t9L8gQfC3QJuuh2vyq7TpnlSEQITD6JRayOefPxzJyT3ZUVpFPPO1FlvCc8mNSn3Cb8TEPcqI3GN3/otDDVV/g8NzfQzDr8dz0W6XeNFSRIhbip1cdMh1fC5PInuHpiDBUwgceOGTuXeqr5qy52B0zNWGJcCGciEMJZNr14VK0CjJw8ndlDMhDgmk8wmBJbc+wrVgMYXXUB/p2Lboz1PeF6LWnJM0SiKbE47DhF0uB+lsefBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQRRyv3J5DLGN7L/CYs+2LWcQAdmwhlsHI04RAiZ8o0=;
 b=LodmsKxO7IHr/+vHjO/BvNQ8nQM46hxL5oaWX9WIC+cvy186SVDiTjcsEYjedQkby8PZkiLwfqE8zdu0Ytsi8nqJsJU5xF2czbfg0Nv72RdIRK2veL1GaJGCNYg6hWsgucEo0etBwIQI4G4ohXOqWt+pyuegoBzB7prqIg22W8gCWx6LEakAqt+YGh1QLQCdYxLSAmC4+iHSGM53NZOD4leM1EEbTlwPtd8jCiJCx/qSZuv3WJ5GAkDhfAd21j/UdjMFNwTkm57XHd6GPzrUC9DQUHLkDAiVLhRkxzAmBjxtxb6b86cpwNImCYSYcu3LWDgvg4qoBqpRDewH4U+qGA==
Received: from DU7P195CA0001.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::15)
 by DB5PR10MB9193.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 15:39:29 +0000
Received: from MAD0EPF000008B2.eurprd04.prod.outlook.com
 (2603:10a6:10:54d:cafe::64) by DU7P195CA0001.outlook.office365.com
 (2603:10a6:10:54d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 15:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008B2.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:39:28 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:45:56 +0200
Received: from localhost (10.252.7.7) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:39:27 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 23 Sep 2026 17:39:05 +0200
Subject: [PATCH v2 02/14] iio: adc: stm32-adc: core: manage clock prescaler
 diversity
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260923-adc-stm32mp25-v1-v2-2-46bc019537c6@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B2:EE_|DB5PR10MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 5372faf3-bff5-49ee-cfe7-08df1988daf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|7416014|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	y8E+pPeBadHtXMrVkBOMxq7pgk538yxMWMAxl375s4SmRbph/Je3aiZo3Ea9GzQIbGiRRqHQeWE2vDpeTTKEwwKnPnY1CFvVB8rTBgCV2oI9ZjNZSeELx44NOz79r6JDcXcKTEcy4Doah+8mJPhc4jkiv1t17Sr+vnfyWHKZg9fkhSRB61ij5zHf4m+4WoGl0eVzA/fsQUTVTTOAp/HG8mCi1Of2b1JNNTpIfMOSp/0WwbKx0sty8zDMpg7it/eW5ypU+uD23kMVW1stBjLq2mZoHXeHQent5U0gHDdFf5yMwb7Oebuc73oa5Fu+xZgbjFmWgaBZlHDupMvTqJV7G4EpEuOfRj2zcJuNoY8ULjtdU5ifCWUGa1MH96QJB6qTWO9dwYcTxl+6phtgfjp/UAoO2Te/FGvO2owZsIBEuiqmU/HAYlO7FvNFDZF1hieiSZL4OGUZTEWN61zaaK+2cexUCpYQz2j5VAEMsCe8ofqTHXGO/duHka4jZd5sKaSa8oxdMMOvXp+98fUGNdepiW4dzw2AKExx4Gyp/X7108SYPILa1tMYRV8uhSO7WBNiTXZ++FEvaF5KVrIfuzsh6jS2odYzIsuuhU/6kBSv7KcWL1Yzr19olDybnBFGbnsG38moJ2jhvYfgDV3+LOKWgVHjRw6nHHcTiPCtLIEl6OY7jdVAACwwvxETV0RegVpg0fkr0zpxYf9rYjR/0kv2gg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(7416014)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5KH9uAQla+03Eu+qUiC2BL3PlAfIPYiy1kkUvr2sP6Q8m9RfhXTYi8ao5iUM2Dq+CP9vXv0fVTLo9SnjzPibELxlt22tJWtfne+BtyRXOuFdxFOclBYNskREmYxysrZr7rSZAJuCBCsRJNLmS5uPvqgy86JJuzoxsj+1Mt1j4zoOeG4+KjTC5/JoAmXS1zmjwkknTdxUZqQXolRtWVg7WlcIrWIbAR3Lrnzae5eiuj49JhQfCM84itpZ1Ur4PzrNgIoSuRnjGi9af2RPx1LLdB08JHfOUkzEuEHurjQqYaaWuDceDHbYi/v7a24JA8GUdv9GFWJU5/RCADbkl7so457ikukRomtYB0Ea1ZHoDSAc+J4hEWZUkRUdbZPI/Jr02VQ7YZ0H6D4zqF+PVgJ63z9VjhTKlTFGyl/NvdlDEvZpgAhcUqY6qYpjhyrfGKIt
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:39:28.8424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5372faf3-bff5-49ee-cfe7-08df1988daf4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008B2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB9193

Make the clock prescaler selection configurable, to prepare stm32mp2
support.
Reuse existing stm32f4_adc_clk_sel(). Rename it so it's no longer
specific to stm32f4. Add configuration data to handle upcoming
differences on:
- registers and bits
- division ratio
No functional change intended.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- new precursor patch as advised by Andy and Jonathan
- unsigned prescaler array as advised by Andy
- cosmetic: spaces before and after braces
---
 drivers/iio/adc/stm32-adc-core.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index a42d82d61cb8..14ed50bb3ab5 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -50,6 +50,8 @@
  * @ovr_msk:    array of ovr (overrun flag) masks in csr for adc1..n
  * @ier:	interrupt enable register offset for each adc
  * @eocie_msk:	end of conversion interrupt enable mask in @ier
+ * @presc_msk:	prescaler mask in ccr
+ * @presc_shift: prescaler bit shift in ccr
  */
 struct stm32_adc_common_regs {
 	u32 csr;
@@ -58,6 +60,8 @@ struct stm32_adc_common_regs {
 	u32 ovr_msk[STM32_ADC_MAX_ADCS];
 	u32 ier;
 	u32 eocie_msk;
+	u32 presc_msk;
+	u32 presc_shift;
 };
 
 struct stm32_adc_priv;
@@ -66,6 +70,8 @@ struct stm32_adc_priv;
  * struct stm32_adc_priv_cfg - stm32 core compatible configuration data
  * @regs:	common registers for all instances
  * @clk_sel:	clock selection routine
+ * @presc:	clock prescaler array
+ * @num_presc:	number of clock prescalers in presc array
  * @max_clk_rate_hz: maximum analog clock rate (Hz, from datasheet)
  * @ipid:	adc identification number
  * @has_syscfg: SYSCFG capability flags
@@ -75,6 +81,8 @@ struct stm32_adc_priv;
 struct stm32_adc_priv_cfg {
 	const struct stm32_adc_common_regs *regs;
 	int (*clk_sel)(struct platform_device *, struct stm32_adc_priv *);
+	unsigned int *presc;
+	unsigned int num_presc;
 	u32 max_clk_rate_hz;
 	u32 ipid;
 	unsigned int has_syscfg;
@@ -126,22 +134,22 @@ static struct stm32_adc_priv *to_stm32_adc_priv(struct stm32_adc_common *com)
 }
 
 /* STM32F4 ADC internal common clock prescaler division ratios */
-static int stm32f4_pclk_div[] = {2, 4, 6, 8};
+static unsigned int stm32f4_pclk_div[] = { 2, 4, 6, 8 };
 
 /**
- * stm32f4_adc_clk_sel() - Select stm32f4 ADC common clock prescaler
+ * stm32_adc_clk_sel() - Select stm32f4 ADC common clock prescaler
  * @pdev: platform device
  * @priv: stm32 ADC core private data
  * Select clock prescaler used for analog conversions, before using ADC.
  */
-static int stm32f4_adc_clk_sel(struct platform_device *pdev,
-			       struct stm32_adc_priv *priv)
+static int stm32_adc_clk_sel(struct platform_device *pdev,
+			     struct stm32_adc_priv *priv)
 {
 	unsigned long rate;
 	u32 val;
 	int i;
 
-	/* stm32f4 has one clk input for analog (mandatory), enforce it here */
+	/* This ADC has one clk input for analog (mandatory), enforce it here */
 	if (!priv->aclk) {
 		dev_err(&pdev->dev, "No 'adc' clock found\n");
 		return -ENOENT;
@@ -153,20 +161,20 @@ static int stm32f4_adc_clk_sel(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(stm32f4_pclk_div); i++) {
-		if ((rate / stm32f4_pclk_div[i]) <= priv->max_clk_rate)
+	for (i = 0; i < priv->cfg->num_presc; i++) {
+		if ((rate / priv->cfg->presc[i]) <= priv->max_clk_rate)
 			break;
 	}
-	if (i >= ARRAY_SIZE(stm32f4_pclk_div)) {
+	if (i >= priv->cfg->num_presc) {
 		dev_err(&pdev->dev, "adc clk selection failed\n");
 		return -EINVAL;
 	}
 
-	priv->common.rate = rate / stm32f4_pclk_div[i];
-	val = readl_relaxed(priv->common.base + STM32F4_ADC_CCR);
-	val &= ~STM32F4_ADC_ADCPRE_MASK;
-	val |= i << STM32F4_ADC_ADCPRE_SHIFT;
-	writel_relaxed(val, priv->common.base + STM32F4_ADC_CCR);
+	priv->common.rate = rate / priv->cfg->presc[i];
+	val = readl_relaxed(priv->common.base + priv->cfg->regs->ccr);
+	val &= ~priv->cfg->regs->presc_msk;
+	val |= i << priv->cfg->regs->presc_shift;
+	writel_relaxed(val, priv->common.base + priv->cfg->regs->ccr);
 
 	dev_dbg(&pdev->dev, "Using analog clock source at %ld kHz\n",
 		priv->common.rate / 1000);
@@ -314,6 +322,8 @@ static const struct stm32_adc_common_regs stm32f4_adc_common_regs = {
 	.ovr_msk = { STM32F4_OVR1, STM32F4_OVR2, STM32F4_OVR3 },
 	.ier = STM32F4_ADC_CR1,
 	.eocie_msk = STM32F4_EOCIE,
+	.presc_msk = STM32F4_ADC_ADCPRE_MASK,
+	.presc_shift = STM32F4_ADC_ADCPRE_SHIFT,
 };
 
 /* STM32H7 common registers definitions */
@@ -850,7 +860,9 @@ static DEFINE_RUNTIME_DEV_PM_OPS(stm32_adc_core_pm_ops,
 
 static const struct stm32_adc_priv_cfg stm32f4_adc_priv_cfg = {
 	.regs = &stm32f4_adc_common_regs,
-	.clk_sel = stm32f4_adc_clk_sel,
+	.clk_sel = stm32_adc_clk_sel,
+	.presc = stm32f4_pclk_div,
+	.num_presc = ARRAY_SIZE(stm32f4_pclk_div),
 	.max_clk_rate_hz = 36000000,
 	.num_irqs = 1,
 	.num_adcs = 3,

-- 
2.43.0

