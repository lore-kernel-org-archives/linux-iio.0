Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020120.outbound.protection.outlook.com [52.101.61.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9358C3A963C;
	Fri, 17 Jul 2026 05:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784267595; cv=fail; b=qDtv0TJBAOWF/aC/Y/OtGjT+3KIyeQofT0+KCyxFqgvTPHLHnEbceOdkvGNdE1AIy6bs6GZ+p2G/Alg8+S+haXmdGuT3+8gXY40PQO017UzEic9uT0ZcT9ldlg+4Ue0Tt7e/vRm+tbpMUJWC65Dc44WEMgQM+pl8QUDo/yTRrJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784267595; c=relaxed/simple;
	bh=sDVGUuopZ0UEhenFKaQy+812elTN7A35vCPUy3Omd3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YNJZsZV1j0rAW6tu3yqAcvzuk52IHGe3PBs9FApARgIOC7FCiaEZzp8ILeiTYMVqKY1Hb0ISPtdKl7MxrQc538NgixS5Cu8JuaoHTA6soHAKoIVDvsnM36LkqCTSoIXck6AMBWEn8wyRR5Ur2LIISEfumUGCZIjKk5NlfLRLWAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=q9jYOpFU; arc=fail smtp.client-ip=52.101.61.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="q9jYOpFU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwYc8PR5p1D8LJ62FwOBlUpjshyk0BJvNasDexiKzaR4yBXLvXKmg9y9VSxkGMTKQB8KDuFgDvJuVTMkxcDFNueL117d+Z94waQ4OnZuKLwQYL4hsAyYTqS9cNd/Nm2P5/npnGdWZi2rR5aItbOnh+jrMK/FwXvgyYEU2vzZFba0AkRUuRHtBYFFYApTbmYoYFgMgo/Iv2dh8R7TKHWxkPDUqkRDFbpH3BM7Nj9NB+lEJMm79PNQjynpqdnrYLHxvapod0CEfxTiokO6mbU9Gv9u4HzfPQ2Wy890/CLvjF4A2eGpqTD7veLUOgLtrWjVrh0gpjcNGirYlD9e9tHPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBBn2asUQ4lRiydokB0bjzwjs9Ss2z2SXkK0P6NKPZE=;
 b=LxcUE/7wdhXreCOSOaVWoPepEOVs8+WYo529ZXlvaXdUSS6JNk8g4obAIyobyiAsjS99XNgaqxUJzttqJtl1FDYhWpuzSovhhv6dbS06G9M4WpA/4OC5S9+Xt8z535giwJLi/EZBx23gQAyc+NMsyt69PlGBVTogv/7lTy5NOGlM/VhkhCPRyB7+dHvVVq9dLU0Q5Tfy0qqSKGTDij6cA0Eb3PnlO6C+xPeaSg46IUVovsu7QZ4ZxZEV25IRuCOc68Ydyn5XtKgaxQiDenmcA1SeVV09ebAbi8ImrzthLEA28CEhNMxPLN5Z+nJ+MOhna2YOIgp1ueuku8FUSd5sDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=analog.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBBn2asUQ4lRiydokB0bjzwjs9Ss2z2SXkK0P6NKPZE=;
 b=q9jYOpFUEZ4TvlXsdBQdzzVvAXKgpk72DJ/QZQyfB21fZKn6NwSKDF+zrLNuHOk8M2gCkhj2VqzjwIsVkCVKA2u7SQvcIuk6auw7bnoZ1qp4lCOR4BXxiMyxgPo4ov4t3aMlffLDAHQlYCQ/B0kjvjsiOZxQZlwPgD31MN6Mb1j+MHbSmiFsLCEJCTm4RJM5hfKoe5xhkPClw8SRZYR7KmhaT9bE9+oSIuM4ILnfPjpwDbBk/3xtkSOhwzIL1e77OyDTD/IHY551oR5uU7Ydpt1cIlMk9tGa9X5MMIf1A0ju7HJBvvF+Glsr6SAICcpQp1P9AsB6HA3z8xIK1PND9g==
Received: from BLAPR03CA0131.namprd03.prod.outlook.com (2603:10b6:208:32e::16)
 by MW5PR18MB5065.namprd18.prod.outlook.com (2603:10b6:303:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Fri, 17 Jul
 2026 05:53:05 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::97) by BLAPR03CA0131.outlook.office365.com
 (2603:10b6:208:32e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Fri,
 17 Jul 2026 05:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Fri, 17 Jul 2026 05:53:05 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 668F44186B59;
	Thu, 16 Jul 2026 22:53:04 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Thu, 16 Jul 2026 22:53:02 -0700
Subject: [PATCH v4 2/2] iio: adc: add Axiado SARADC driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-axiado-ax3000-ax3005-saradc-v4-2-810527a9d27f@axiado.com>
References: <20260716-axiado-ax3000-ax3005-saradc-v4-0-810527a9d27f@axiado.com>
In-Reply-To: <20260716-axiado-ax3000-ax3005-saradc-v4-0-810527a9d27f@axiado.com>
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Petar Stepanovic <pstepanovic@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784267584; l=10486;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=sDVGUuopZ0UEhenFKaQy+812elTN7A35vCPUy3Omd3U=;
 b=pLY2UAF94mNOOxBJmWWo4rnp529OaLCVxI18I+HzysvqrhnUz6FqB+Myfi9o0AETUjSw+4Dkq
 DKiHL/FkaRbAFQOCWsTEvvEDTeUBJzv1bqTe6EkxSD2I+eEZalu05JM
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|MW5PR18MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: d12a15c9-c0a3-40db-5003-08dee3c7abce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|82310400026|1800799024|6133799003|56012099006|921020|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HM82mAiJMWujoisK9Fhsuj6YxUgqavFz34Yxpi+yEe5JPOuFxsBygkE2QmRsjOXltKFyuI/L++aGNsfozdb++qIZ+khZfhcsejQrTp0yjr+7wHDHWXvMvl+M1iYsewqPD3k4h+6cQfJ0EJHef/0bB3+kN+gL55lFdeYWVLAnzbzjXc3qvp14wHnl26MIMXKrk9YSBeJN9ussBhK9ao10HcdNHg/rnLRKomoXaLDt6xtaiz73ukK5NFCVYrP/ygb6f5wtQN2TvuP1CD4vapiJwjCvGa8DSxbvOoLpUlcoBCxX7FvI/D9EnCJDEBUXrZRQuOesxjTdUCv7ReInAk8gwNv59hYgbJYWjRuVf/001vlpS7J/ctf+ymAxg8pI3TCYAPFspkQDz8MBk6GwpScFD+RSXMbBy8ZKKV27BvRGEmpvAocqc4hoAgZLT4GiwPZ53OAmhiESzGSCDiq/q3bpgIvMgMnlW97U5i5uKttwt/dxdwnnfPKtFs7YcVs2e1M/5aK6ffStIGrRC4RpIfBva+FrK3FmYgMa0eaO91hrRGnkyus11iPSJ0ImE+5qqarzfE54ClmOQ+rV71pdAbMGQn9/JBCPTkoNdvmp8ogkwhCx8/1Th8/s/DBmLohlY4FR4C8Qz2rnPAMzjH1hG7XUPO5tx6YeEX3s4wxWG4tL4jSW4YT7pn9FeS2P5kPUNd18s11VGwHBVrWdVypO9Ii3JrtV8N+wD34/WUy9jr0PV0uRuG0QZ1hZvbTMKYWPTVcj
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(82310400026)(1800799024)(6133799003)(56012099006)(921020)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S5wdChXwjiaor2E80QQWxCJfOGN6J6jDcZon5fFF7taKrVFzaxcoLB6eaA7GIWyo8nUbuv9BH7Dnq5Ncs3owcRsKziCpZ4jsnVE7HedIjkV/NMkRwk5G+Oqu3A/yHRYNnLCNZ1yqojJmGfp0k7+CS4W4GmmzjBKqOVUIfMrRNyVqAnjWcqTgy2c9xEj33hguVyP0Rmo/yL0vWpSRq7Sylev+ivy1uZehaNTqUNI2cXHYugsXj6N3XYC/u4/fwaoJjRPI4xvfVsPcy6Hlu9J/WcXKezzxy9TvHGyYxtbME7VwEKlZHgFeEpgKEJYebu0iyQJjZ6gQ0O8a2cZYYGhSU01KKLGQg2JkLa/8c2mkvZmZxt8t0bc+wWy1/DI1Pa0/uDkEDD6xyLacnpxaCnyjKN3+1n5LOj5aj7/s18w5bsDiKgM0RnzrJ4mf+HMONz1U
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 05:53:05.1881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d12a15c9-c0a3-40db-5003-08dee3c7abce
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR18MB5065

Add support for the SARADC controller found on Axiado AX3000 and
AX3005 SoCs.

The driver supports single-shot voltage reads through the IIO
subsystem. The number of available input channels is selected from
the SoC match data, allowing AX3000 and AX3005 variants to use the
same driver.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 MAINTAINERS                     |   1 +
 drivers/iio/adc/Kconfig         |  11 ++
 drivers/iio/adc/Makefile        |   1 +
 drivers/iio/adc/axiado_saradc.c | 286 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 299 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6f4febfe4fd..d2e99c2260fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4319,6 +4319,7 @@ M:	Prasad Bolisetty <pbolisetty@axiado.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/axiado,ax3000-saradc.yaml
+F:	drivers/iio/adc/axiado_saradc.c
 
 AXIS ARTPEC ARM64 SoC SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb46..c6fe026dc70e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -631,6 +631,17 @@ config AT91_SAMA5D2_ADC
 	  To compile this driver as a module, choose M here: the module will be
 	  called at91-sama5d2_adc.
 
+config AXIADO_SARADC
+	tristate "Axiado SARADC driver"
+	depends on ARCH_AXIADO || COMPILE_TEST
+	select REGMAP_MMIO
+	help
+	  Say yes here to build support for the SARADC found in Axiado
+	  SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called axiado_saradc.
+
 config AXP20X_ADC
 	tristate "X-Powers AXP20X and AXP22X ADC driver"
 	depends on MFD_AXP20X
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 097357d146ba..96de0ce1d90a 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_ADI_AXI_ADC) += adi-axi-adc.o
 obj-$(CONFIG_ASPEED_ADC) += aspeed_adc.o
 obj-$(CONFIG_AT91_ADC) += at91_adc.o
 obj-$(CONFIG_AT91_SAMA5D2_ADC) += at91-sama5d2_adc.o
+obj-$(CONFIG_AXIADO_SARADC) += axiado_saradc.o
 obj-$(CONFIG_AXP20X_ADC) += axp20x_adc.o
 obj-$(CONFIG_AXP288_ADC) += axp288_adc.o
 obj-$(CONFIG_BCM_IPROC_ADC) += bcm_iproc_adc.o
diff --git a/drivers/iio/adc/axiado_saradc.c b/drivers/iio/adc/axiado_saradc.c
new file mode 100644
index 000000000000..b802fceb9c7b
--- /dev/null
+++ b/drivers/iio/adc/axiado_saradc.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021-2026 Axiado Corporation
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+
+/* Register offsets */
+#define AX_SARADC_GLOBAL_CTRL_REG 0x0004
+#define AX_SARADC_MANUAL_CTRL_REG 0x0008
+#define AX_SARADC_DOUT_REG 0x001C
+
+/* GLOBAL_CTRL register fields */
+#define AX_SARADC_GLOBAL_CTRL_CH_EN_MASK	GENMASK(31, 16)
+#define AX_SARADC_GLOBAL_CTRL_SAMPLE_MASK	GENMASK(6, 5)
+#define AX_SARADC_GLOBAL_CTRL_MODE_MASK		GENMASK(4, 3)
+#define AX_SARADC_GLOBAL_CTRL_PD		BIT(2)
+#define AX_SARADC_GLOBAL_CTRL_ENABLE		BIT(0)
+
+/* GLOBAL_CTRL register values */
+#define AX_SARADC_GLOBAL_CTRL_SAMPLE_16	\
+	FIELD_PREP(AX_SARADC_GLOBAL_CTRL_SAMPLE_MASK, 0)
+
+#define AX_SARADC_GLOBAL_CTRL_MODE_MANUAL	\
+	FIELD_PREP(AX_SARADC_GLOBAL_CTRL_MODE_MASK, 1)
+
+/* MANUAL_CTRL register fields */
+#define AX_SARADC_MANUAL_CTRL_ENABLE           BIT(0)
+#define AX_SARADC_MANUAL_CTRL_CH_SEL_MASK      GENMASK(4, 1)
+
+#define AX_SARADC_MANUAL_CTRL_EN(ch)	\
+	(AX_SARADC_MANUAL_CTRL_ENABLE |	\
+	FIELD_PREP(AX_SARADC_MANUAL_CTRL_CH_SEL_MASK, ch))
+
+#define AX_RESOLUTION_BITS 10
+#define AX_SARADC_CONV_CYCLES 13
+#define AX_SARADC_CONV_DELAY_MARGIN_US 10
+
+struct axiado_saradc {
+	struct regmap *regmap;
+	struct clk *clk;
+	struct mutex lock; /* Serializes ADC conversions. */
+	unsigned long clk_rate;
+	int vref_uV;
+};
+
+static const struct regmap_config axiado_saradc_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = AX_SARADC_DOUT_REG,
+};
+
+
+static int axiado_saradc_conversion(struct axiado_saradc *info,
+				    struct iio_chan_spec const *chan, int *val)
+{
+	unsigned long usecs;
+	unsigned int regval;
+	int stop_ret;
+	int ret;
+
+	guard(mutex)(&info->lock);
+
+	/* Select the channel to be used and trigger conversion */
+	ret = regmap_write(info->regmap, AX_SARADC_MANUAL_CTRL_REG,
+			   AX_SARADC_MANUAL_CTRL_EN(chan->channel));
+	if (ret)
+		return ret;
+
+
+	/* Hardware requires 13 conversion cycles at clk_rate */
+	usecs = DIV_ROUND_UP(AX_SARADC_CONV_CYCLES * USEC_PER_SEC,
+			     info->clk_rate);
+	fsleep(usecs + AX_SARADC_CONV_DELAY_MARGIN_US);
+
+	ret = regmap_read(info->regmap, AX_SARADC_DOUT_REG, &regval);
+
+	/* Stop manual conversion */
+	stop_ret = regmap_write(info->regmap, AX_SARADC_MANUAL_CTRL_REG, 0);
+
+	if (ret)
+		return ret;
+	if (stop_ret)
+		return stop_ret;
+
+	*val = regval & GENMASK(AX_RESOLUTION_BITS - 1, 0);
+	return 0;
+}
+
+static int axiado_saradc_read_raw(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan, int *val,
+				  int *val2, long mask)
+{
+	struct axiado_saradc *info = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = axiado_saradc_conversion(info, chan, val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = info->vref_uV / (MICRO / MILLI);
+		*val2 = AX_RESOLUTION_BITS;
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info axiado_saradc_iio_info = {
+	.read_raw = axiado_saradc_read_raw,
+};
+
+struct axiado_saradc_soc_data {
+	const char *name;
+	unsigned int num_channels;
+};
+
+static const struct axiado_saradc_soc_data ax3000_saradc_data = {
+	.name = "ax3000_saradc",
+	.num_channels = 16,
+};
+
+static const struct axiado_saradc_soc_data ax3005_saradc_data = {
+	.name = "ax3005_saradc",
+	.num_channels = 8,
+};
+
+#define AX_SARADC_CH(_index)                                            \
+	{                                                               \
+		.type = IIO_VOLTAGE,                                    \
+		.indexed = 1,                                           \
+		.channel = (_index),                                    \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),   \
+		.datasheet_name = "adc" #_index,                        \
+	}
+
+static const struct iio_chan_spec axiado_saradc_iio_channels[] = {
+	AX_SARADC_CH(0),
+	AX_SARADC_CH(1),
+	AX_SARADC_CH(2),
+	AX_SARADC_CH(3),
+	AX_SARADC_CH(4),
+	AX_SARADC_CH(5),
+	AX_SARADC_CH(6),
+	AX_SARADC_CH(7),
+	AX_SARADC_CH(8),
+	AX_SARADC_CH(9),
+	AX_SARADC_CH(10),
+	AX_SARADC_CH(11),
+	AX_SARADC_CH(12),
+	AX_SARADC_CH(13),
+	AX_SARADC_CH(14),
+	AX_SARADC_CH(15),
+};
+
+static void axiado_saradc_disable(void *data)
+{
+	struct axiado_saradc *info = data;
+
+	regmap_write(info->regmap, AX_SARADC_GLOBAL_CTRL_REG,
+		     AX_SARADC_GLOBAL_CTRL_PD);
+}
+
+static int axiado_saradc_probe(struct platform_device *pdev)
+{
+	const struct axiado_saradc_soc_data *soc_data;
+	struct device *dev = &pdev->dev;
+	struct axiado_saradc *info;
+	struct iio_dev *indio_dev;
+	void __iomem *regs;
+	u32 regval;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	info = iio_priv(indio_dev);
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	info->regmap = devm_regmap_init_mmio(dev, regs,
+					     &axiado_saradc_regmap_config);
+	if (IS_ERR(info->regmap))
+		return PTR_ERR(info->regmap);
+
+	info->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(info->clk))
+		return PTR_ERR(info->clk);
+
+	info->clk_rate = clk_get_rate(info->clk);
+	if (!info->clk_rate)
+		return dev_err_probe(dev, -EINVAL, "invalid clock rate\n");
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get vref voltage\n");
+
+	info->vref_uV = ret;
+
+	soc_data = device_get_match_data(dev);
+	if (!soc_data)
+		return dev_err_probe(dev, -EINVAL, "failed to get match data\n");
+
+	ret = devm_mutex_init(dev, &info->lock);
+	if (ret)
+		return ret;
+
+	regval = FIELD_PREP(AX_SARADC_GLOBAL_CTRL_CH_EN_MASK,
+			    GENMASK(soc_data->num_channels - 1, 0)) |
+		 AX_SARADC_GLOBAL_CTRL_SAMPLE_16 |
+		 AX_SARADC_GLOBAL_CTRL_MODE_MANUAL |
+		 AX_SARADC_GLOBAL_CTRL_ENABLE;
+
+	ret = regmap_write(info->regmap, AX_SARADC_GLOBAL_CTRL_REG,
+			   AX_SARADC_GLOBAL_CTRL_PD);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(info->regmap, AX_SARADC_GLOBAL_CTRL_REG, regval);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, axiado_saradc_disable, info);
+	if (ret)
+		return ret;
+
+	indio_dev->name = soc_data->name;
+	indio_dev->info = &axiado_saradc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = axiado_saradc_iio_channels;
+	indio_dev->num_channels = soc_data->num_channels;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id axiado_saradc_match[] = {
+	{
+		.compatible = "axiado,ax3000-saradc",
+		.data = &ax3000_saradc_data,
+	},
+	{
+		.compatible = "axiado,ax3005-saradc",
+		.data = &ax3005_saradc_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, axiado_saradc_match);
+
+static struct platform_driver axiado_saradc_driver = {
+	.driver = {
+		.name =  "axiado-saradc",
+		.of_match_table = axiado_saradc_match,
+	},
+	.probe = axiado_saradc_probe,
+};
+module_platform_driver(axiado_saradc_driver);
+
+MODULE_AUTHOR("AXIADO CORPORATION");
+MODULE_DESCRIPTION("AXIADO SARADC driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

