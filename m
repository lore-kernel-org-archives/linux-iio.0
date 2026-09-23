Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5C8559C83;
	Wed, 23 Sep 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177980; cv=fail; b=fm3SMWvAga2z/ERm8qQCsFr4FtzA4WCpVG2ZVSHMcxesp3nK9zzWTFD5EWgpxdZDC8UG6OsM9X7VD2mQvtugiz+sencdaTEteVPSjBM4pY8F2KdOSooKn2ptNG9QRaOHmR4fjZHDXfcp2oUxNbPZQgGrvEkEvYku3XAQ7y6WBGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177980; c=relaxed/simple;
	bh=qCTc1sQzmcgkZSQ5v55iqaGibXjFvFDyp7Dyr+AzgJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UGKEMNZ/eI2Do9RwllWSJ1oZ7RjF0YlZDQy80UAkbJ1NUPWwrfHBFV7/a6BSrm2vuMqg4xgav7Jj7jOoMPzqcnbQIoypoNgodT0UEHmZRix75tZkOiM5bv0lARpV2VZN5IMJEQj8C3EAErtQbM6u6Qal7KfmP/4bYAaGtYA1xzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CrAvs+FL; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CrAvs+FL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mh02r9jwu3rLx6OBBkkWjVJv7w/ShZrFEe08smgBy3JDKySz1uxOI51fokWGVxNomIRz8nsJT5N0YeahtRjUZg9J6gEhWbUy0gN8Jp3PPo6zGUpYYcGyRxDEXmI1km5f69uqADNB9Vn246JiXwOeDTo1XkhMIbQ6OkU1TrhLyglDsrNtfS9huxEegXSsqzzikH3dTUcLjjWU7PECDhsG3/bM0WPPPgdfYSbaLv+TASoeGMut6IaoLfyOW2HVI/zoplS4P0BfI1rIKtoE+oXy4JoxKBeTOmPove5sMLBcKC3DDH4Gu6CJZsdmfgI4PMJ4sJ5hq+k4qRt+9zfxJyzzbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f0lJIKnJnuoBCuEnSY1AN6337cLyUeiWLbw5sVNinQ=;
 b=rHPCzYTWvmk4mF/ylHx//0anzWCF2H4FXmVXw/vko+1G+K4rpHJra1IMOhg3Y8H1lstkla24d5eOYzVGNNuahPuKfXnHcAMtQDIz+/bvwff3KePtaBx9LrnHmKeCwOnDcXjTn5lNHU7xiUy+T53yRAc3Otj1Q7oFAodwT1qFCqATGP6NB7Pnzzzo7zMbCjy9tMSeiwpikr5nTzseR2ihADxrDx25XKfmnzTtumA9kehWSU60IdvYPS0tJYHH13yNLfEnBT20ctnKxIAU6dCebqOxngQzv4URJS0B0HWC11vKgS/0+n/M8Bo1eY6mBl7ugTO9CWHsoje0zXqD32dZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7f0lJIKnJnuoBCuEnSY1AN6337cLyUeiWLbw5sVNinQ=;
 b=CrAvs+FL76xbPtt4FGIoAB/rcRFFcV5e3FPzVCohb6jWC8thIqgqY2CoPgfi7lgZcwTL+d5tvv7ZtgF1D4Ld63V7HLTWzcTVWZIysTbsnyzHOzXRtgkc/IzcN83ZCy39E3Do/xaVZGUmL/w/VRzpGj8FLpZt3GlqTzLuVQFh/7mzxDkRDNzbT5sc4IntUpDLtiXknJIP1pBKB+VdAq8A2SJ15Roo0zmqn6wc9rQQ0mZxTNQk3SbP4y/XB+d4jK7oCeh4rFxGXEY+UFBdvU35egSPAzTVNnkOoEMF5p8RebXUW3kpyeLooU5SCZjdJP+c50MLgYgTQlfAp2QHlnX9ew==
Received: from OL1P279CA0053.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::22)
 by PAVPR10MB7281.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:39:30 +0000
Received: from WA1PEPF000099CF.eurprd04.prod.outlook.com
 (2603:10a6:e10:14:cafe::63) by OL1P279CA0053.outlook.office365.com
 (2603:10a6:e10:14::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 15:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 WA1PEPF000099CF.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:39:30 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:45:18 +0200
Received: from localhost (10.252.7.7) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 23 Sep
 2026 17:39:28 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 23 Sep 2026 17:39:06 +0200
Subject: [PATCH v2 03/14] iio: adc: stm32-adc: core: configurable number of
 interrupts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260923-adc-stm32mp25-v1-v2-3-46bc019537c6@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: WA1PEPF000099CF:EE_|PAVPR10MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: b0cfdeda-8125-487c-b017-08df1988dbf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|23010399003|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Uzv82G2JPB6RGcotzkRUTP3378hj4CWyIGukXhN62nZlB7jvLrkStyxrBitJlNrb7smKzt82K+QdGjuoqr+AX+HfsZuubWCUSJ/VG3xPWC9jeOxAP8jwbUDhKtjLd+PiBo1PTVRJIOkZ9POmcxGSCXFf+wI+rrIBHjenzBGyEGcUhglaMVAnQNsFezXbehXCG23aSdaTJATDmPOiCEUlGv5hrQyXdB8OIq8QzmAOMxwtsjyE6CTadIJnQ1ccHRINTG0687PBItE+KfoG0QMWGl4ndHUkHE/fjPAy/WyxCUirgOFbqepTHUYxQlYEmw2GmjG0zvuQ1deMkqfdp4RUh8VIrk+JxJadOHqYhqzZi0B++5goTM0363Rt+JqaBblMCMYjwuLngTBeCZ5ie6Dos2wEqVfHnZ0eCf/XWgU4vZuy3qKJPdVOavQsop9qg5GGlQCTW8m8jBNbtJ4bepurBp0mD9iIXPoNsQHYJ/VbJhi/4JjOs+Hu8vQUOe0si+yVMnzp2DfeI4m783z8ZUNn0PjkTQehpkjzyVF2tCGqkDAXkYv1lrncvl9yaBocQbY9RW5SVOU18hklxzP5hIcORAE4Y8gdxhb2ihpgRU9a9kFPSyLqkGsdfaYmpXs3M1tM9iRwJMWj+QBD7rnzge3P1MKLuMYe6EKy4/DCCrE3oizFlea/uk+2XJkE+eQGrFr2WfbwJF+Ugozu+TBkUECZIw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oX8Aqe0TpUsKh0igPGONrBPo+oI91ZBMaxavzadERNceI+9/pJDEJBlbkw615f77GCepBDpBxv2VYx2wLAhqnG189ExFWlhSTQLSVDBcQ5kCsdERDIXUeOGtlqGvHQePpVvfxfEU61lKdz6d8gUMxmZlQGuomzL08mpKoxuDbPtw6BaOSLXRwr350DkDa7NOYav+VdvrYNgejHY+XwAFKe1TaERlAdohQCEuRp+xPwVZ9bK5QrTBjLtERWIlPuRo7eBjdBYcZyN7bgFIXI2GsxHFcAV+skVq1qjw/C19aP+gmwUi0G6GdpbH1N4ZYmatIKlwnfAugNiNHL5iFIsIjonALfWP4JDLfy3Qg8S9JyZCF30HRG32oQo+JEjiobwPogf+YyAtD6CcOmUQWqdT/AK3sgjR9ISbyzq6P4MyhfG6LPH1SjC2PCvVmHANIPlg
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:39:30.5577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cfdeda-8125-487c-b017-08df1988dbf8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF000099CF.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7281

Make the number of interrupts configurable to prepare stm32mp2
support. Read from the SoC compatible data, and add it to
private data struct.
No functional change intended.

Co-developed-by: Cheick Traore <cheick.traore-ext@st.com>
Signed-off-by: Cheick Traore <cheick.traore-ext@st.com>
Co-developed-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- new precursor patch as advised by Andy and Jonathan to render
  num_irqs configurable
---
 drivers/iio/adc/stm32-adc-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 14ed50bb3ab5..5845173e288c 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -94,6 +94,7 @@ struct stm32_adc_priv_cfg {
  * struct stm32_adc_priv - stm32 ADC core private data
  * @irq:		irq(s) for ADC block
  * @nb_adc_max:		actual maximum number of instance per ADC block
+ * @nb_irqs:		number of IRQs in the ADC block
  * @domain:		irq domain reference
  * @aclk:		clock reference for the analog circuitry
  * @bclk:		bus clock common for all ADCs, depends on part used
@@ -112,6 +113,7 @@ struct stm32_adc_priv_cfg {
 struct stm32_adc_priv {
 	int				irq[STM32_ADC_MAX_ADCS];
 	unsigned int			nb_adc_max;
+	unsigned int			nb_irqs;
 	struct irq_domain		*domain;
 	struct clk			*aclk;
 	struct clk			*bclk;
@@ -424,7 +426,7 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
 	 * - stm32f4/h7 shares a common interrupt line.
 	 * - stm32mp1, has one line per ADC
 	 */
-	for (i = 0; i < priv->cfg->num_irqs; i++) {
+	for (i = 0; i < priv->nb_irqs; i++) {
 		priv->irq[i] = platform_get_irq(pdev, i);
 		if (priv->irq[i] < 0)
 			return priv->irq[i];
@@ -439,7 +441,7 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < priv->cfg->num_irqs; i++)
+	for (i = 0; i < priv->nb_irqs; i++)
 		irq_set_chained_handler_and_data(priv->irq[i],
 						 stm32_adc_irq_handler, priv);
 
@@ -456,7 +458,7 @@ static void stm32_adc_irq_remove(struct platform_device *pdev,
 		irq_dispose_mapping(irq_find_mapping(priv->domain, hwirq));
 	irq_domain_remove(priv->domain);
 
-	for (i = 0; i < priv->cfg->num_irqs; i++)
+	for (i = 0; i < priv->nb_irqs; i++)
 		irq_set_chained_handler(priv->irq[i], NULL);
 }
 
@@ -730,6 +732,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 
 	priv->cfg = device_get_match_data(dev);
 	priv->nb_adc_max = priv->cfg->num_adcs;
+	priv->nb_irqs = priv->cfg->num_irqs;
 	spin_lock_init(&priv->common.lock);
 
 	priv->common.base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);

-- 
2.43.0

