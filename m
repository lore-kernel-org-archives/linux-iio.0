Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A963C3434;
	Tue,  6 Oct 2026 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273506; cv=fail; b=UYw9XXAivR2Nc6e+dbxyhziGQl7hD7L2wO6duN4Pf8cparxu8OOnErrfBI3EGV+x/kJ4bF1bzY8ZuzKSPW3IsP5Sl3PRhbecHo0TUdfNWlZv/Ya1GP5h1zgbRWQ62pLjPgYAqnNcLX/VtCygbLZswxECspC0xAszfoluWWuVBVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273506; c=relaxed/simple;
	bh=vfmh/GVfmIT7gkjiqTxzdHGMlMEw1Q/C54K2NOFG3eI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nEHBEPxGh4jh3MeOzgKs9X6miLAK4CduiwTn2qfa4QEkcBtE3D20NwVQku77wzHjEHCrZaC9gmcYyfHfqsZKaRnMkOCCGYgz/tNy4ovwj3tY4jp46xPk++c8ca+8oYCFgeU8SwTj6+i5cAUfQnecPldukyT3P2m5st7xbuk2Ugc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=U46utTDh; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="U46utTDh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7NVN58p78TKW+MR1BZ08vjDmeN5nWGWgGvWDQrJtNdNNozb5/jJmL29n7FqJE7YO5LyWhy2lowxQpNq4q5HNSUFxDt9fw4Ru3Blg0AulEsW8XDLh0U/gB36m0026QZs9elehVQBrgrhgIqQ17qyAwqjqyzQXCIF0SnQaUffB7WkdCjg1bg8D+SCX50bIg0sxQu+TSkavYtAjSMv8HZLgsms3xcMqEkgRl6rDSxoYRzEjw2UYbJ3ZaRJG2IlVTyyVlBHD7hpVbTy7I41deEGUdWJaGZMZZGYfAfL2qWK15R5htnEgm7rnV9pclY+pn86TaoCFo8mUCfesjPZVMuDLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6X2+4Y33pwuN4eZ4JZFx1+8RX/nCccu0Y/54fGMNCw=;
 b=ansuGMZOgTvx7ivo+d25bFmcbnDC+Gr5loJTm0EnpfUYEbcBoxGq9OI7R6wWvgTSB+m9kDACtTQU8xdTRKCS1DxjcbyFwb/4ng/MyQiipMY0pszl2Y4Giwpla96wvN7Y8VLjkAcfNDg95nSV3uVEvOBN6yYQ01UaikUS0MfFhneO8/z93ru/Nb8kPeOuOpWXSuZeVBKWkE9fBcnvQTvIsLmUno9tVPjJXbwFI7qkvaBKgSpg+0o5aPsVIG8Sw655hu2vmE1kUG93irsndjHxEQUFpCaptDWwBjcgbp/H521eaOdfV49KWZjkBbiuNNQ4uwvJR10GlSPEeIoCjJ0JRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6X2+4Y33pwuN4eZ4JZFx1+8RX/nCccu0Y/54fGMNCw=;
 b=U46utTDh9ksEBfsjsDBDBK+MhB0mQ3x3KrCbEfP0TyavXVySL0rNf7+IgMttYbLfaEZmn9uPg2LyXMedOn/yD74/zko5kQcZQ52v8LFvCs813+Bdj+hIAQkBxUnegARV1YIRFuQaCVnyjWUAeDWWVTpGyhFy7Ubiacv/j2rgxbCmTemsH7c6VabhS8qhH33B8JG3mU8oJd6ViEN/7CiuVMFnyU7/j9UoaSSmdU6dDGU/ZCkucK1yFWW5Nnseh4AOHAvQK/Fx5eS4tnA285xm39yU3M6bmXCNWMjAmck7Ca+u75cYF1clfqp4yWBV+LCZQYXtn1PtPTUOq7N1LsueUg==
Received: from AS9PR06CA0069.eurprd06.prod.outlook.com (2603:10a6:20b:464::18)
 by AS2PR10MB7024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:598::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 6 Oct
 2026 07:58:10 +0000
Received: from AMS1EPF00000094.eurprd05.prod.outlook.com
 (2603:10a6:20b:464:cafe::75) by AS9PR06CA0069.outlook.office365.com
 (2603:10a6:20b:464::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 07:58:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000094.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 07:58:10 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 10:04:12 +0200
Received: from localhost (10.252.27.219) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 6 Oct
 2026 09:58:07 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 6 Oct 2026 09:57:33 +0200
Subject: [PATCH v4 02/15] iio: adc: stm32-adc: core: manage clock prescaler
 diversity
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-adc-stm32mp25-v1-v4-2-d31ec75aecf3@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000094:EE_|AS2PR10MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f3f32a-3aff-4a82-766c-08df237f908a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|23010399003|376014|36860700016|11063799006|6133799003|22082099003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	dMOC7/nX65iCjlMu8xjKvp0oOZRjxFkFSEwBKIbt7a0k4ln8jskkcj7tv4BR9W05ZdmGra93zG8FC9TAGvrl7W9OsjpzMqyu4K+HVikQ3K1WVOJzhU3GPpxpcdcuQn0omU+3SFkqPW1GWp4yGReolSyBhhttKP/C1kwYHqwvvrre0P/B9FJ/YRdY7wtt5allLIymZoYllnphWSMFcfWGDb8u6ScCLcp0SK0T3/CIdrJ2Y8okVLNip1lCvao/YNpr9sJJHP23B2xAAD8120W+fM+gJ1cAV8Hb8RkmihqKX9suobNsNtfaQjjxC5jzebdOkuaisgkx6Ehugj0IIAuAi02K7zNs8RY3FsdB0OvN57Y0MocjmOFB4sqEbMLRMFLW1QcBvFtIDMDzQGSUoUiyUkCmci7n3eYMUR1YFQyde5nLMlcGukvgOS7HwDolCQ+juNUKjRD3+xFBL0zflLT5aJlceTRPcZPl6/hjS7gj8TVp9/54AF+Cx1i915r24xk/3dfEUg2TzJJ9z9Q7NyM3qMOpQUA9q0AIdzC4sWWgrhUwFdyQWUy20etYkXAOB0hszHre5NMojQmm/OzsYaSPDjS4HUR0w9HvzeXWYKCEZKqfPNRoMZjW6m6Ldm+eGJUK9VnAlzHKaHD7vgWWupA6i5NuQnKGJB7uPhlccmMp83cy2h3bTS3hF/rXiRgxE+xDN5Zf68m4z0cGLVe9NjA+pQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(23010399003)(376014)(36860700016)(11063799006)(6133799003)(22082099003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9pC7RbEzXJybGzv6pbTSAakZemPXmRwOKU4w8KNSfA67vRn0GQdNpI6eCHIyJRoFbdLJ4suTPr6kbDg36v7BWkRj0cljGYsjKw6rjsZ0Q4NR8abO0SA8nQgXqBVYsrgiWDpW5rGLPRPyCW4lOPT1QjXMpuGSMru7iXX5y4nvoZqgU1sAmnmcAT7rhovbRHl4BSlA91qjRqOJTazKHJdbzpqb7soq8OV87Rp9lABUwPnXz7HmxUMTnMBBzNAO4DnqI8evRcUsHJ95GifCXEBns4Ta+2HyC/5L+sOlXmbhLUqM5cgwQP6kaRMXofE+GJePO3JmNQlipxGIO0g3QXQ9wj8DrGRqzU/5AgpsmfBYz/pYqf1DE/J2JGFnFG09CufXAGsGBTJyXmo3jXQmcfLHnQb3Yw9hnluEm3c2zVmnB1DbWybqDkj6Z6DPDo984Eu4
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:58:10.1909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f3f32a-3aff-4a82-766c-08df237f908a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000094.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7024

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
Changes in v4:
- Use const for presc array

Changes in v3:
- Adopt field_prep as advised by Jonathan, no need to store shift and mask.

Changes in v2:
- new precursor patch as advised by Andy and Jonathan
- unsigned prescaler array as advised by Andy
- cosmetic: spaces before and after braces
---
 drivers/iio/adc/stm32-adc-core.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index a42d82d61cb8..4b3c00392a73 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -50,6 +50,7 @@
  * @ovr_msk:    array of ovr (overrun flag) masks in csr for adc1..n
  * @ier:	interrupt enable register offset for each adc
  * @eocie_msk:	end of conversion interrupt enable mask in @ier
+ * @presc_msk:	prescaler mask in ccr
  */
 struct stm32_adc_common_regs {
 	u32 csr;
@@ -58,6 +59,7 @@ struct stm32_adc_common_regs {
 	u32 ovr_msk[STM32_ADC_MAX_ADCS];
 	u32 ier;
 	u32 eocie_msk;
+	u32 presc_msk;
 };
 
 struct stm32_adc_priv;
@@ -66,6 +68,8 @@ struct stm32_adc_priv;
  * struct stm32_adc_priv_cfg - stm32 core compatible configuration data
  * @regs:	common registers for all instances
  * @clk_sel:	clock selection routine
+ * @presc:	clock prescaler array
+ * @num_presc:	number of clock prescalers in presc array
  * @max_clk_rate_hz: maximum analog clock rate (Hz, from datasheet)
  * @ipid:	adc identification number
  * @has_syscfg: SYSCFG capability flags
@@ -75,6 +79,8 @@ struct stm32_adc_priv;
 struct stm32_adc_priv_cfg {
 	const struct stm32_adc_common_regs *regs;
 	int (*clk_sel)(struct platform_device *, struct stm32_adc_priv *);
+	const unsigned int *presc;
+	unsigned int num_presc;
 	u32 max_clk_rate_hz;
 	u32 ipid;
 	unsigned int has_syscfg;
@@ -126,22 +132,22 @@ static struct stm32_adc_priv *to_stm32_adc_priv(struct stm32_adc_common *com)
 }
 
 /* STM32F4 ADC internal common clock prescaler division ratios */
-static int stm32f4_pclk_div[] = {2, 4, 6, 8};
+static const unsigned int stm32f4_pclk_div[] = { 2, 4, 6, 8 };
 
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
@@ -153,20 +159,20 @@ static int stm32f4_adc_clk_sel(struct platform_device *pdev,
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
+	val |= field_prep(priv->cfg->regs->presc_msk, i);
+	writel_relaxed(val, priv->common.base + priv->cfg->regs->ccr);
 
 	dev_dbg(&pdev->dev, "Using analog clock source at %ld kHz\n",
 		priv->common.rate / 1000);
@@ -314,6 +320,7 @@ static const struct stm32_adc_common_regs stm32f4_adc_common_regs = {
 	.ovr_msk = { STM32F4_OVR1, STM32F4_OVR2, STM32F4_OVR3 },
 	.ier = STM32F4_ADC_CR1,
 	.eocie_msk = STM32F4_EOCIE,
+	.presc_msk = STM32F4_ADC_ADCPRE_MASK,
 };
 
 /* STM32H7 common registers definitions */
@@ -850,7 +857,9 @@ static DEFINE_RUNTIME_DEV_PM_OPS(stm32_adc_core_pm_ops,
 
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

