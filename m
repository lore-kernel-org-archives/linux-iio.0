Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B70340DB20;
	Fri, 11 Sep 2026 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141917; cv=fail; b=uFpYs1KEHDcdqjl/am0Tx7FDy/v1eU1fFuigww0MAs6yGi6eo6Sz2Tf9UKIpx57s3kuOFk8ckbFoeoec0G3BWQe4V//cdWyTeiQXf2077CdxeyWCQdYMw6QEXDtZEHB28hlNULKLE4POzPjz61IvlzL4M67D8Qgce46Rks3504w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141917; c=relaxed/simple;
	bh=QcKc3CrsPS6HG47hux/V8+Y8KsO+SWvJdO73r2kvVGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WL1zenZtNb4vZH2H3pNVzMuyFkidKFh2bKKw2ly15KQiaA2tPsisxUdS4kV4nkqkI4N9Kv/CwuGLnAfpfsZpBqWZ9QXZkI+yoSvxsVuJhplUPlx4P7yhgiFnAs44Odnnu9sNOR4y5QKaMY6DV8lF4l5Sh++moHZ1PbQllIv32Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ABeblL7b; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ABeblL7b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9SCywelYuyU+pp6F6JNDvRdzehAMFz1wZwO7iImQTm0Lsmba3ePz6vLQAg4CN/8p3MmPfU8RSeFRKYc5fd+7qF4tlqPAVRAowyBGahyctXTi2DCqJIKyDVSXGzzYVJv7hz/MZfqqhqVbbu3kiAx6LAP+EhIFRLfuj1McFdEPLaJSP1yCfc5BCkcZruJIUsxStYdpkZR0EIgoZLbseV+94ZKnLoRiYSbvinbeuFtxO0wlFNJGvqiOWf0WbEx4x7EoNZ2rBFheZle2bc8xnh/jh8aiz6MdKn+b86TASpcth1h1nAeTF90RzAeYPFmQ/LxjNvsYF2i++vqGG8H7KPXwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lxKRl+u8WhejrPotz3Z975uspnUCwa1JPi7Rldfvp4=;
 b=S7IqPDohpgSmT9LXBOnYM9x8S0mqkiAfpGP+q3NsAyGXY9PQSBuIIJP0E2sYiMfL2fygMXjF7a7vn3tenuIMKWE+BXJLCbbWTygAuMtTz+O1ROVUFffsARfRMLCrpCoWoEXc1Juy0/nxTYcHz3ymbc9Cti1qgwM9wIgkbR0PoLDBKpz5q13wgoxbVpeYrlYeLK4Rt/ZzXBMQBxahAxYroPH2cAKVUnIU3rhU3sO4yPMtbTLPwMAleXZcDSaQu3TMYM/rEOMRlALWiqdkEuTAfUGU7zLhZTJHD3Yea/x2Slnjzu5JeecUjC/UAJoPNRpteQPNs9ku7ZLIjt8CdJ4heg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lxKRl+u8WhejrPotz3Z975uspnUCwa1JPi7Rldfvp4=;
 b=ABeblL7bQKAo4V3iXv5BeJQ+dNmUWkBvezmsfVrsH79VWQ1MExpuO62CNFBpzXeA//W+aUJ5XE06dHO5P6/gmw/WriW3M6EzTJCpW/H+ztHgM0M+hYfarPbaBYrz2mmpm7Kais5+npTXB36S79mygoAKIKeyoWVRTEVnLlGPN/QTJAPIcoT0HHXw46sXXaXk0CxiA0p8Qfho0NcdMN+HNf1t4AobgLJ9H+Na5U5GfGgUYfnNXPHI7SkJ0eA47gyHegSMZAo4MRp12E77KEsSaOZL6vG2BgMlbY6lV2YOoexSN7xGmyTiStObz9F2u+mDL5FvC94ehF5VP25Tol6V+A==
Received: from VI6PEPF0000021C.AUTP296.PROD.OUTLOOK.COM (2603:10a6:808:1::8d5)
 by DU4PR10MB175331.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:51:45 +0000
Received: from MI3PEPF00008484.eurprd02.prod.outlook.com (2603:10a6:298:1::6b)
 by VI6PEPF0000021C.outlook.office365.com (2603:10a6:808:1::8d5) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.406.10 via Frontend Transport; Fri, 11 Sep 2026 15:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF00008484.mail.protection.outlook.com (10.167.240.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:51:44 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 17:57:46 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 17:51:43 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 11 Sep 2026 17:51:25 +0200
Subject: [PATCH 3/8] iio: adc: stm32-adc: add support for stm32mp23 and
 stm32mp25
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260911-adc-stm32mp25-v1-v1-3-cef26eecdef2@foss.st.com>
References: <20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com>
In-Reply-To: <20260911-adc-stm32mp25-v1-v1-0-cef26eecdef2@foss.st.com>
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
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008484:EE_|DU4PR10MB175331:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6e2372-758f-4719-ff07-08df101c94a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|23010399003|11063799006|5023799004|56012099006|18002099003|22082099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	APsQPzDsTv5zgekYDGTOMMlTVvnD8G9+PYf5KriwD3FyF4JXhdU2t+RlDpB+/j5Yj/4tyTpA0gFvWVZ3dM6hcD8PMLnHogs6Um7Ue3DGk0eGQNYOwaWOUkklAcVzAgIFOOdsdknVDwPDQp3LXQ4MAoPVpIi02sTmCLO5iuge4Dzu5iSMU7LdFINsxkBy+2iH7BXyHb5ayzODT8cN+63m9KmO35theh7qhQENCRUfpuPGP76tduGPdkxkWjy3D38clr9aX4F4s/HHhsfWF+fL/OENCwzqzSV6pdpMbkDHqaf4gz+JWg2moVPz8jPrwa23anKcR2OdgcQCItLuiY4i15NjGvz7Vlopxj+7v9WgtS3CXBdkdNrVSeFRJ1cSF4YJrvo3q8fzYougHrm6pjv+Y9q3qrFV/eEWJDvV18x5m3qnoSOA/8RVAITMe6i2euc6iLvtEW50kyMebL3c/kXtdWh3g0bTVsAnO2zgHcskSaEjJbt8rYrIm2Bzl4EIFr3Y+DkQFSgNw1dyiv3WuF8M0qa3C3cV6l4gic7NTHATnfB5Id3zLlRQoz8lJ+VM86eETkjOzXbsD+4fHOw5qSkpbVksY9GUuRL4dJn8FAudtk1K83utDXwk380I5yFsIHwJHeecKPvO0M5O+2onwhOMGtABHQSTuonv7yYO350eDdLB6mevl65SAq2zXrUv9oRbisDD+7ioTcEsZilzkTDFcw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(23010399003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6LTGauqgkfeFCBNkJwwIsAn6AKknwQNhFI2XnFhjohwKejSrBrYm/+FMBLJV2cogKEL4/Nc8E+ifTGTz5dujbpst4xmjQCdpHXv+Q9qdhhBOLr/xVpBjoUgupSRz12Ll1ECC10AF1NDV9/faEfcIEO6XwVDIbAFBM0NdWu9Xopfrdgnyi9iiIfEvYjKDuAyPPVn50vi7rmfJksorqwXZwrPDhP1Bdq150gZQo0qQh3xPCZxBFeZZ0OO+wsGGqV2K5TTjJ7pr9gmxcxpxsOVK3GDGXXEzM35YuKqAAbQMb4M8PY1WEFnLgqMlvjuminlWHuP7TERlBUO60GTSAZXBU7j9O99pjpOMcrbYmslu6ptgCSrx9bCVpbQOfxes+WeCJNI/gi9dkkGd6A6kfvO880avW/qRCNegs13tyFUetGMiDN5j6/n+Kl95mvE1p7lT
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:51:44.8396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6e2372-758f-4719-ff07-08df101c94a8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008484.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB175331

Add support for STM32MP23 STM32MP25 SoCs. They have 3 ADCs, split into
two blocks:
- ADC12 (ADC1 & ADC2) are tightly coupled.
- ADC3 is managed independently.
Trigger list slightly changes between STM32MP23 and STM32MP25.

Each ADC is a 12-bits successive approximation analog-to-digital converter,
with up to 20 multiplexed channels that can be configured as single ended
or differential. ADC resolution ranges from 6 to 12 bits.

It introduces diversity regarding IRQs, clocks, software calibration
procedure, internal voltage channels, sampling time (prescaler) and
trigger list. Most of the architecture, and the driver engine remains
similar. So, handle the differences w.r.t. other STM32 ADCs family with
a dedicated compatible and compatible data.

Trigger list depends on ADC instance, retrieved with "st,adc-trigger-sel"
property.

Add support for vddcpu and vddgpu internal channels on stm32mp25.
These channels are enabled by using ADC option register.
Add VDDGPU to the list of supported channels in this driver and made
available on stm32mp25. So update sampling information for all variants
(with zero'ed data when it's not available).

Co-developed-by: Cheick Traore <cheick.traore-ext@st.com>
Signed-off-by: Cheick Traore <cheick.traore-ext@st.com>
Co-developed-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/iio/adc/stm32-adc-core.c |  91 ++++++--
 drivers/iio/adc/stm32-adc-core.h |  23 +++
 drivers/iio/adc/stm32-adc.c      | 435 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 521 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index a42d82d61cb8..e3c3ac7f748d 100644
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
+	int *presc;
+	int num_presc;
 	u32 max_clk_rate_hz;
 	u32 ipid;
 	unsigned int has_syscfg;
@@ -86,6 +94,7 @@ struct stm32_adc_priv_cfg {
  * struct stm32_adc_priv - stm32 ADC core private data
  * @irq:		irq(s) for ADC block
  * @nb_adc_max:		actual maximum number of instance per ADC block
+ * @nb_irqs:		number of IRQs in the ADC block
  * @domain:		irq domain reference
  * @aclk:		clock reference for the analog circuitry
  * @bclk:		bus clock common for all ADCs, depends on part used
@@ -104,6 +113,7 @@ struct stm32_adc_priv_cfg {
 struct stm32_adc_priv {
 	int				irq[STM32_ADC_MAX_ADCS];
 	unsigned int			nb_adc_max;
+	unsigned int			nb_irqs;
 	struct irq_domain		*domain;
 	struct clk			*aclk;
 	struct clk			*bclk;
@@ -128,20 +138,23 @@ static struct stm32_adc_priv *to_stm32_adc_priv(struct stm32_adc_common *com)
 /* STM32F4 ADC internal common clock prescaler division ratios */
 static int stm32f4_pclk_div[] = {2, 4, 6, 8};
 
+/* STM32MP25 ADC internal common clock prescaler division ratios */
+static int stm32mp25_presc_div[] = {1, 2, 4, 6, 8, 10, 12, 16, 32, 64, 128, 256};
+
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
+	/* stm32f4/mp25 has one clk input for analog (mandatory), enforce it here */
 	if (!priv->aclk) {
 		dev_err(&pdev->dev, "No 'adc' clock found\n");
 		return -ENOENT;
@@ -153,20 +166,20 @@ static int stm32f4_adc_clk_sel(struct platform_device *pdev,
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
@@ -314,6 +327,8 @@ static const struct stm32_adc_common_regs stm32f4_adc_common_regs = {
 	.ovr_msk = { STM32F4_OVR1, STM32F4_OVR2, STM32F4_OVR3 },
 	.ier = STM32F4_ADC_CR1,
 	.eocie_msk = STM32F4_EOCIE,
+	.presc_msk = STM32F4_ADC_ADCPRE_MASK,
+	.presc_shift = STM32F4_ADC_ADCPRE_SHIFT,
 };
 
 /* STM32H7 common registers definitions */
@@ -336,6 +351,18 @@ static const struct stm32_adc_common_regs stm32mp13_adc_common_regs = {
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
@@ -413,8 +440,10 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
 	 * Interrupt(s) must be provided, depending on the compatible:
 	 * - stm32f4/h7 shares a common interrupt line.
 	 * - stm32mp1, has one line per ADC
+	 * - stm32mp25, has a dual ADC12 and standalone ADC3. Each ADC has an IRQ
+	 *   (two for ADC12, one for ADC3)
 	 */
-	for (i = 0; i < priv->cfg->num_irqs; i++) {
+	for (i = 0; i < priv->nb_irqs; i++) {
 		priv->irq[i] = platform_get_irq(pdev, i);
 		if (priv->irq[i] < 0)
 			return priv->irq[i];
@@ -429,7 +458,7 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < priv->cfg->num_irqs; i++)
+	for (i = 0; i < priv->nb_irqs; i++)
 		irq_set_chained_handler_and_data(priv->irq[i],
 						 stm32_adc_irq_handler, priv);
 
@@ -446,7 +475,7 @@ static void stm32_adc_irq_remove(struct platform_device *pdev,
 		irq_dispose_mapping(irq_find_mapping(priv->domain, hwirq));
 	irq_domain_remove(priv->domain);
 
-	for (i = 0; i < priv->cfg->num_irqs; i++)
+	for (i = 0; i < priv->nb_irqs; i++)
 		irq_set_chained_handler(priv->irq[i], NULL);
 }
 
@@ -693,6 +722,17 @@ static int stm32_adc_probe_identification(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	if (priv->cfg->ipid == STM32MP25_IPIDR_NUMBER) {
+		/*
+		 * ADC diversity on STM32MP25 is handled here. There may be:
+		 * - 2 IRQs for ADC12 block
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
@@ -720,6 +760,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 
 	priv->cfg = device_get_match_data(dev);
 	priv->nb_adc_max = priv->cfg->num_adcs;
+	priv->nb_irqs = priv->cfg->num_irqs;
 	spin_lock_init(&priv->common.lock);
 
 	priv->common.base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
@@ -850,7 +891,9 @@ static DEFINE_RUNTIME_DEV_PM_OPS(stm32_adc_core_pm_ops,
 
 static const struct stm32_adc_priv_cfg stm32f4_adc_priv_cfg = {
 	.regs = &stm32f4_adc_common_regs,
-	.clk_sel = stm32f4_adc_clk_sel,
+	.clk_sel = stm32_adc_clk_sel,
+	.presc = stm32f4_pclk_div,
+	.num_presc = ARRAY_SIZE(stm32f4_pclk_div),
 	.max_clk_rate_hz = 36000000,
 	.num_irqs = 1,
 	.num_adcs = 3,
@@ -882,6 +925,16 @@ static const struct stm32_adc_priv_cfg stm32mp13_adc_priv_cfg = {
 	.num_irqs = 1,
 };
 
+static const struct stm32_adc_priv_cfg stm32mp25_adc_priv_cfg = {
+	.regs = &stm32mp25_adc_common_regs,
+	.clk_sel = stm32_adc_clk_sel,
+	.presc = stm32mp25_presc_div,
+	.num_presc = ARRAY_SIZE(stm32mp25_presc_div),
+	.max_clk_rate_hz = 70000000,
+	.ipid = STM32MP25_IPIDR_NUMBER,
+	.num_irqs = 2, /* 2 IRQs for ADC12, 1 irq for ADC3 */
+};
+
 static const struct of_device_id stm32_adc_of_match[] = {
 	{
 		.compatible = "st,stm32f4-adc-core",
@@ -895,6 +948,12 @@ static const struct of_device_id stm32_adc_of_match[] = {
 	}, {
 		.compatible = "st,stm32mp13-adc-core",
 		.data = (void *)&stm32mp13_adc_priv_cfg
+	}, {
+		.compatible = "st,stm32mp23-adc-core",
+		.data = (void *)&stm32mp25_adc_priv_cfg
+	}, {
+		.compatible = "st,stm32mp25-adc-core",
+		.data = (void *)&stm32mp25_adc_priv_cfg
 	}, {
 	},
 };
diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
index db50a9f3b922..0f40450844e9 100644
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
@@ -257,8 +260,28 @@ enum stm32h7_adc_dmngt {
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
+#define STM32MP25_VDDGPUEN		BIT(4)
+#define STM32MP25_VDDCPUEN		BIT(3)
+#define STM32MP25_VDDCOREEN		BIT(2)
+#define STM32MP25_SELBG			BIT(1)
+#define STM32MP25_SELREF		BIT(0)
+
 #define STM32MP15_IPIDR_NUMBER		0x00110005
 #define STM32MP13_IPIDR_NUMBER		0x00110006
+#define STM32MP25_IPIDR_NUMBER		0x00110008
 
 /**
  * struct stm32_adc_common - stm32 ADC driver common data (for all instances)
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 183b3474cad1..42827ce489dd 100644
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
+	STM32_EXT28,
 };
 
 enum stm32_adc_int_ch {
@@ -86,6 +97,7 @@ enum stm32_adc_int_ch {
 	STM32_ADC_INT_CH_VDDQ_DDR,
 	STM32_ADC_INT_CH_VREFINT,
 	STM32_ADC_INT_CH_VBAT,
+	STM32_ADC_INT_CH_VDDGPU,
 	STM32_ADC_INT_CH_NB,
 };
 
@@ -105,6 +117,7 @@ static const struct stm32_adc_ic stm32_adc_ic[STM32_ADC_INT_CH_NB] = {
 	{ "vddq_ddr", STM32_ADC_INT_CH_VDDQ_DDR },
 	{ "vrefint", STM32_ADC_INT_CH_VREFINT },
 	{ "vbat", STM32_ADC_INT_CH_VBAT },
+	{ "vddgpu", STM32_ADC_INT_CH_VDDGPU },
 };
 
 /**
@@ -165,6 +178,7 @@ struct stm32_adc_vrefint {
  * @smp_bits:		smpr1 & smpr2 index and bitfields
  * @or_vddcore:		option register & vddcore bitfield
  * @or_vddcpu:		option register & vddcpu bitfield
+ * @or_vddgpu:		option register & vddgpu bitfield
  * @or_vddq_ddr:	option register & vddq_ddr bitfield
  * @ccr_vbat:		common register & vbat bitfield
  * @ccr_vref:		common register & vrefint bitfield
@@ -184,6 +198,7 @@ struct stm32_adc_regspec {
 	const struct stm32_adc_regs *smp_bits;
 	const struct stm32_adc_regs or_vddcore;
 	const struct stm32_adc_regs or_vddcpu;
+	const struct stm32_adc_regs or_vddgpu;
 	const struct stm32_adc_regs or_vddq_ddr;
 	const struct stm32_adc_regs ccr_vbat;
 	const struct stm32_adc_regs ccr_vref;
@@ -202,6 +217,7 @@ struct stm32_adc;
  * @has_linearcal:	linear calibration support flag
  * @has_presel:		channel preselection support flag
  * @has_oversampling:	oversampling support flag
+ * @has_vregen:		voltage regulator enable/disable flag
  * @prepare:		optional prepare routine (power-up, enable)
  * @start_conv:		routine to start conversions
  * @stop_conv:		routine to stop conversions
@@ -215,13 +231,14 @@ struct stm32_adc;
 struct stm32_adc_cfg {
 	const struct stm32_adc_regspec	*regs;
 	const struct stm32_adc_info	*adc_info;
-	const struct stm32_adc_trig_info *trigs;
+	const struct stm32_adc_trig_info	*trigs[2];
 	bool clk_required;
 	bool has_vregready;
 	bool has_boostmode;
 	bool has_linearcal;
 	bool has_presel;
 	bool has_oversampling;
+	bool has_vregen;
 	int (*prepare)(struct iio_dev *);
 	void (*start_conv)(struct iio_dev *, bool dma);
 	void (*stop_conv)(struct iio_dev *);
@@ -261,6 +278,7 @@ struct stm32_adc_cfg {
  * @int_ch:		internal channel indexes array
  * @nsmps:		number of channels with optional sample time
  * @ovs_idx:		current oversampling ratio index (in oversampling array)
+ * @trigs:		trigger list in use
  */
 struct stm32_adc {
 	struct stm32_adc_common	*common;
@@ -289,6 +307,7 @@ struct stm32_adc {
 	int			int_ch[STM32_ADC_INT_CH_NB];
 	int			nsmps;
 	int			ovs_idx;
+	const struct stm32_adc_trig_info	*trigs;
 };
 
 struct stm32_adc_diff_channel {
@@ -355,6 +374,20 @@ static const struct stm32_adc_info stm32mp13_adc_info = {
 	.num_ovs = ARRAY_SIZE(stm32mp13_adc_oversampling_avail),
 };
 
+/*
+ * stm32mp25 can have up to 20 channels.
+ * Keep channel 19 (VREF+) hidden on STM32MP25: it is the ADC reference
+ * supply itself, so exposing it as a regular input is not meaningful.
+ * Reference voltage must be derived from VREFINT calibration data.
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
@@ -545,6 +578,156 @@ static const struct stm32_adc_regspec stm32h7_adc_regspec = {
 	.smp_bits = stm32h7_smp_bits,
 };
 
+/* STM32MP23 external trigger sources for ADC12 */
+static struct stm32_adc_trig_info stm32mp23_adc12_trigs[] = {
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
+	{},
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
+	{},
+};
+
+/* STM32MP25 external trigger sources for ADC12 */
+static struct stm32_adc_trig_info stm32mp25_adc12_trigs[] = {
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
+	{},
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
+	{},
+};
+
+/* STM32MP25 programmable sampling time (ADC clock cycles, rounded down) */
+static const unsigned int stm32mp25_adc_smp_cycles[STM32_ADC_MAX_SMP + 1] = {
+	2, 3, 7, 12, 24, 47, 247, 1501,
+};
+
+static const struct stm32_adc_regspec stm32mp25_adc_regspec = {
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
+	.or_vddgpu = { STM32MP25_ADC23_OR, STM32MP25_VDDGPUEN },
+	.ccr_vbat = { STM32H7_ADC_CCR, STM32H7_VBATEN },
+	.ccr_vref = { STM32H7_ADC_CCR, STM32H7_VREFEN },
+};
+
 /* STM32MP13 programmable sampling time (ADC clock cycles, rounded down) */
 static const unsigned int stm32mp13_adc_smp_cycles[STM32_ADC_MAX_SMP + 1] = {
 	2, 6, 12, 24, 47, 92, 247, 640,
@@ -769,6 +952,11 @@ static void stm32_adc_int_ch_enable(struct iio_dev *indio_dev)
 			stm32_adc_set_bits_common(adc, adc->cfg->regs->ccr_vbat.reg,
 						  adc->cfg->regs->ccr_vbat.mask);
 			break;
+		case STM32_ADC_INT_CH_VDDGPU:
+			dev_dbg(&indio_dev->dev, "Enable VDDGPU\n");
+			stm32_adc_set_bits(adc, adc->cfg->regs->or_vddgpu.reg,
+					   adc->cfg->regs->or_vddgpu.mask);
+			break;
 		}
 	}
 }
@@ -802,6 +990,10 @@ static void stm32_adc_int_ch_disable(struct stm32_adc *adc)
 			stm32_adc_clr_bits_common(adc, adc->cfg->regs->ccr_vbat.reg,
 						  adc->cfg->regs->ccr_vbat.mask);
 			break;
+		case STM32_ADC_INT_CH_VDDGPU:
+			stm32_adc_clr_bits(adc, adc->cfg->regs->or_vddgpu.reg,
+					   adc->cfg->regs->or_vddgpu.mask);
+			break;
 		}
 	}
 }
@@ -970,7 +1162,8 @@ static int stm32h7_adc_exit_pwr_down(struct iio_dev *indio_dev)
 
 	/* Exit deep power down, then enable ADC voltage regulator */
 	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_DEEPPWD);
-	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADVREGEN);
+	if (adc->cfg->has_vregen)
+		stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADVREGEN);
 
 	if (adc->cfg->has_boostmode &&
 	    adc->common->rate > STM32H7_BOOST_CLKRATE)
@@ -1310,6 +1503,163 @@ static void stm32h7_adc_unprepare(struct iio_dev *indio_dev)
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
+	int i, ret;
+
+	/* Repeat several conversions in calibration mode, average the results */
+	for (i = 0; i < STM32MP25_CALIB_LOOP; i++) {
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
+static int stm32mp25_adc_calib(struct iio_dev *indio_dev)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	u32 calfact = 0, average;
+	int ret;
+
+	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADCAL);
+	/* Clears CALADDOS (and old calibration data if any) */
+	stm32_adc_writel(adc, STM32MP25_ADC_CALFACT, 0);
+	/* Select single ended input calibration */
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADCALDIF);
+	/* Use default resolution (e.g. 12 bits) */
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR, STM32MP25_RES_MASK);
+
+retry:
+	ret = stm32mp25_adc_calib_get_average_data(indio_dev, &average);
+	if (ret)
+		goto out;
+
+	/* If the averaged data is zero, retry with additional offset (set CALADDOS) */
+	if (!average) {
+		if (!calfact) {
+			/* Averaged data is zero, retry with additional offset */
+			calfact = STM32MP25_CALFACT_CALADDOS;
+			stm32_adc_writel(adc, STM32MP25_ADC_CALFACT, calfact);
+			goto retry;
+		}
+		/* Averaged data is still zero with additional offset, just warn about it */
+		dev_warn(&indio_dev->dev, "Single-ended calibration average: 0\n");
+	}
+
+	calfact |= FIELD_PREP(STM32MP25_CALFACT_S_MASK, average);
+
+	/* Select differential input calibration (keep previous CALADDOS value) */
+	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADCALDIF);
+	ret = stm32mp25_adc_calib_get_average_data(indio_dev, &average);
+	if (ret)
+		goto out;
+
+	/*
+	 * If the averaged data is below 0x800 (half value in 12-bits mode),
+	 * retry with additional offset
+	 */
+	if (average < BIT(adc->cfg->adc_info->resolutions[0] - 1)) {
+		if (!(calfact & STM32MP25_CALFACT_CALADDOS)) {
+			/* Retry the whole calibration with additional offset */
+			stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADCALDIF);
+			calfact = STM32MP25_CALFACT_CALADDOS;
+			stm32_adc_writel(adc, STM32MP25_ADC_CALFACT, calfact);
+			goto retry;
+		}
+		/*
+		 * Averaged data is still below center value. It needs to be clamped to zero,
+		 * so don't use the result here, warn about it.
+		 */
+		dev_warn(&indio_dev->dev, "Differential calibration clamped(0): 0x%x\n", average);
+	} else {
+		calfact |= FIELD_PREP(STM32MP25_CALFACT_D_MASK, average);
+	}
+
+	stm32_adc_writel(adc, STM32MP25_ADC_CALFACT, calfact);
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
@@ -1379,15 +1729,15 @@ static int stm32_adc_get_trig_extsel(struct iio_dev *indio_dev,
 	int i;
 
 	/* lookup triggers registered by stm32 timer trigger driver */
-	for (i = 0; adc->cfg->trigs[i].name; i++) {
+	for (i = 0; adc->trigs[i].name; i++) {
 		/**
 		 * Checking both stm32 timer trigger type and trig name
 		 * should be safe against arbitrary trigger names.
 		 */
 		if ((is_stm32_timer_trigger(trig) ||
 		     is_stm32_lptim_trigger(trig)) &&
-		    !strcmp(adc->cfg->trigs[i].name, trig->name)) {
-			return adc->cfg->trigs[i].extsel;
+		    !strcmp(adc->trigs[i].name, trig->name)) {
+			return adc->trigs[i].extsel;
 		}
 	}
 
@@ -2291,6 +2641,11 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
 					dev_warn(&indio_dev->dev,
 						 "%s channel not available\n", ch_name);
 				break;
+			case STM32_ADC_INT_CH_VDDGPU:
+				if (!adc->cfg->regs->or_vddgpu.reg)
+					dev_warn(&indio_dev->dev,
+						 "%s channel not available\n", ch_name);
+				break;
 			}
 
 			if (stm32_adc_ic[i].idx != STM32_ADC_INT_CH_VREFINT) {
@@ -2506,6 +2861,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	irqreturn_t (*handler)(int irq, void *p) = NULL;
 	struct stm32_adc *adc;
 	bool timestamping = false;
+	u32 trig_id = 0;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
@@ -2558,6 +2914,18 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	if (device_property_present(&pdev->dev, "st,adc-trigger-sel")) {
+		ret = device_property_read_u32(dev, "st,adc-trigger-sel", &trig_id);
+		if (ret)
+			return ret;
+	}
+
+	adc->trigs = adc->cfg->trigs[trig_id];
+	if (!adc->trigs) {
+		dev_err(&pdev->dev, "Can't get trigger list\n");
+		return -EINVAL;
+	}
+
 	ret = stm32_adc_dma_request(dev, indio_dev);
 	if (ret < 0)
 		return ret;
@@ -2697,7 +3065,7 @@ static const struct dev_pm_ops stm32_adc_pm_ops = {
 static const struct stm32_adc_cfg stm32f4_adc_cfg = {
 	.regs = &stm32f4_adc_regspec,
 	.adc_info = &stm32f4_adc_info,
-	.trigs = stm32f4_adc_trigs,
+	.trigs = { stm32f4_adc_trigs, },
 	.clk_required = true,
 	.start_conv = stm32f4_adc_start_conv,
 	.stop_conv = stm32f4_adc_stop_conv,
@@ -2706,17 +3074,19 @@ static const struct stm32_adc_cfg stm32f4_adc_cfg = {
 	.vref_charac = 3300,
 };
 
-static const unsigned int stm32_adc_min_ts_h7[] = { 0, 0, 0, 4300, 9000 };
+/* Internal channel indexes are mapped on stm32_adc_int_ch enum */
+static const unsigned int stm32_adc_min_ts_h7[] = { 0, 0, 0, 4300, 9000, 0 };
 static_assert(ARRAY_SIZE(stm32_adc_min_ts_h7) == STM32_ADC_INT_CH_NB);
 
 static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.regs = &stm32h7_adc_regspec,
 	.adc_info = &stm32h7_adc_info,
-	.trigs = stm32h7_adc_trigs,
+	.trigs = { stm32h7_adc_trigs, },
 	.has_boostmode = true,
 	.has_linearcal = true,
 	.has_presel = true,
 	.has_oversampling = true,
+	.has_vregen = true,
 	.start_conv = stm32h7_adc_start_conv,
 	.stop_conv = stm32h7_adc_stop_conv,
 	.prepare = stm32h7_adc_prepare,
@@ -2728,18 +3098,19 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.vref_charac = 3300,
 };
 
-static const unsigned int stm32_adc_min_ts_mp1[] = { 100, 100, 100, 4300, 9800 };
+static const unsigned int stm32_adc_min_ts_mp1[] = { 100, 0, 0, 4300, 9800, 0 };
 static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp1) == STM32_ADC_INT_CH_NB);
 
 static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.regs = &stm32mp1_adc_regspec,
 	.adc_info = &stm32h7_adc_info,
-	.trigs = stm32h7_adc_trigs,
+	.trigs = { stm32h7_adc_trigs, },
 	.has_vregready = true,
 	.has_boostmode = true,
 	.has_linearcal = true,
 	.has_presel = true,
 	.has_oversampling = true,
+	.has_vregen = true,
 	.start_conv = stm32h7_adc_start_conv,
 	.stop_conv = stm32h7_adc_stop_conv,
 	.prepare = stm32h7_adc_prepare,
@@ -2751,14 +3122,15 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.vref_charac = 3300,
 };
 
-static const unsigned int stm32_adc_min_ts_mp13[] = { 100, 0, 0, 4300, 9800 };
+static const unsigned int stm32_adc_min_ts_mp13[] = { 1000, 1000, 1000, 4300, 9800, 0 };
 static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp13) == STM32_ADC_INT_CH_NB);
 
 static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
 	.regs = &stm32mp13_adc_regspec,
 	.adc_info = &stm32mp13_adc_info,
-	.trigs = stm32h7_adc_trigs,
+	.trigs = { stm32h7_adc_trigs, },
 	.has_oversampling = true,
+	.has_vregen = true,
 	.start_conv = stm32mp13_adc_start_conv,
 	.stop_conv = stm32h7_adc_stop_conv,
 	.prepare = stm32h7_adc_prepare,
@@ -2770,11 +3142,50 @@ static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
 	.vref_charac = 3300,
 };
 
+static const unsigned int stm32_adc_min_ts_mp25[] = { 34, 34, 0, 34, 34, 34 };
+static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp25) == STM32_ADC_INT_CH_NB);
+
+static const struct stm32_adc_cfg stm32mp23_adc_cfg = {
+	.regs = &stm32mp25_adc_regspec,
+	.adc_info = &stm32mp25_adc_info,
+	.trigs = { stm32mp23_adc12_trigs, stm32mp23_adc3_trigs },
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
+	.vref_charac = 1800,
+};
+
+static const struct stm32_adc_cfg stm32mp25_adc_cfg = {
+	.regs = &stm32mp25_adc_regspec,
+	.adc_info = &stm32mp25_adc_info,
+	.trigs = { stm32mp25_adc12_trigs, stm32mp25_adc3_trigs },
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
+	.vref_charac = 1800,
+};
+
 static const struct of_device_id stm32_adc_of_match[] = {
 	{ .compatible = "st,stm32f4-adc", .data = (void *)&stm32f4_adc_cfg },
 	{ .compatible = "st,stm32h7-adc", .data = (void *)&stm32h7_adc_cfg },
 	{ .compatible = "st,stm32mp1-adc", .data = (void *)&stm32mp1_adc_cfg },
 	{ .compatible = "st,stm32mp13-adc", .data = (void *)&stm32mp13_adc_cfg },
+	{ .compatible = "st,stm32mp23-adc", .data = (void *)&stm32mp23_adc_cfg },
+	{ .compatible = "st,stm32mp25-adc", .data = (void *)&stm32mp25_adc_cfg },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, stm32_adc_of_match);

-- 
2.43.0

