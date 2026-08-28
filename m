Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020091.outbound.protection.outlook.com [52.101.193.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BBA2F1FEC;
	Fri, 28 Aug 2026 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787920147; cv=fail; b=MAY1Qs8UszvD11enSf8bkDrRaJ94+ms1LP0iRsX+eVNXreR5sTzAA4IwMMVUaUueEYUU5XtvgPTky4EidcKr12GoXH2i+B8Cr0Wv7IVfSm9+G1I2knGNVPfs1I+ws13WtuVNP8m4Nv0gJRp9CI+jdIQ4jqwQtgNr8kc5J7HFaY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787920147; c=relaxed/simple;
	bh=rNY4nLyM8wsOBfIRMDfS6xlkx0bLyP0Z196P2uJIKKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tph5lyrY4hxeEqMdajDv/xSXeIT00BpvYeTIqUQY1dbQlqW0SgURprLLvwhcyoCqRz/bVUkLlFg7FAQZks7kc/wJm+HjeFWjih/0R3LnNYjCv9zNORrZ3I6zTIXbk5yF26oFClbiR+OPGjvtcaCl3GSNYYEK2N3V+wv8zG1zNug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=ThaFb386; arc=fail smtp.client-ip=52.101.193.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="ThaFb386"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9vl7wEODg24zMQSYzXyhSaY95bI3Cg0R6EjRvFSqKXeXGusiIhfemaTyGCopmCEvnwVCLd1jACAJV5eql5fuego7kkM0BvFtKhdinh8y1fE/ssONDe01c2JzEzyB7BPMEoKxUHHZPogEC8SU6fgCbLTx3a9rDqjG8twj9uwYUgdvDfT1HpR48UfjaxPsLaj95OLKQ7qEBXqKfCxl00qs0ZfBy4kO+erJC/llEl5A29Rljy9fE3xGEjzWJAGQ8d382UVUpFCZ5Ifdot7cns2XkA2FULwCs8qBv9sX3czBKW91to3DDi3+UTAqYRjngQhF4zn0LiMWCPfB4CAbPnieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOx8DAH1AwDiA7qqemvUL4rdmlqGZWTtwuXZ7pNbXkU=;
 b=ArLQcEUVusNt8VTDQfX2u4LtmjaSFghk+pC1Ln5kI8mUfH4LDoumiqnR+K6jsqI0bad/g+lu384fA+f2ilfOY2PkOpGlNxv0jjKVE34w2yzpIWZBy5uIriA/GDVO4FMUtXEq3lYnuF1NPIttlXMee1F8N2FnfCraQaaEOAqXBSJ4WSR+zKqpcTkCYP7jbOlm3ddd0RhDxFdeBEgt613LIOrLGUQOI6eT3aoR/QN/I7Xa8CzpikPu226avOWYCse8b2z3LEz3LtSaAv5BnaPiuyXrvndtEPxsdBOl7gu4qXj/bSL6y7DLJFMYUjGd8S0EU5VCn7ZWolxBX/NTcU9U9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=analog.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOx8DAH1AwDiA7qqemvUL4rdmlqGZWTtwuXZ7pNbXkU=;
 b=ThaFb3866GOEkTy2VLzFAPjkkGsErNXBgLmgdIl+lCaWVUZFSxwVmXa1eyl3t1211PufaSvCYqMxCpYAyB74+luLaf++NjaV6lc9SXTRYHbeCiVwwa9zjNtjw6Nr26rVpHRoi9mK+vk7r+Cj3+uJcf2MUuqGdw1dCEcz+TYiBjHmzI5jMMHM0LjwEI7kcRQmYErCkj6A6ZIEtRsEDeHRab3b2ubJ9rq38CEI90v+tWnbfc2ET3D/5OIl7UyhaktDIfyzouMCqcCjRn7NKDDy0zBXhhnvUM7AWCC/YKd2l8ukuExocjWyvoOZYiGb9LOpXBBX4w/+F/fvAe499z1iGQ==
Received: from CH0PR13CA0043.namprd13.prod.outlook.com (2603:10b6:610:b2::18)
 by BY1PR18MB6043.namprd18.prod.outlook.com (2603:10b6:a03:4ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 12:28:42 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::a3) by CH0PR13CA0043.outlook.office365.com
 (2603:10b6:610:b2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.7 via Frontend Transport; Fri, 28
 Aug 2026 12:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 28 Aug 2026 12:28:41 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id C93DC40BFE04;
	Fri, 28 Aug 2026 05:28:40 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Fri, 28 Aug 2026 05:28:29 -0700
Subject: [PATCH v6 2/2] iio: adc: add Axiado SARADC driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-axiado-ax3000-ax3005-saradc-v6-2-4cea467e4167@axiado.com>
References: <20260828-axiado-ax3000-ax3005-saradc-v6-0-4cea467e4167@axiado.com>
In-Reply-To: <20260828-axiado-ax3000-ax3005-saradc-v6-0-4cea467e4167@axiado.com>
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Petar Stepanovic <pstepanovic@axiado.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787920120; l=10449;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=rNY4nLyM8wsOBfIRMDfS6xlkx0bLyP0Z196P2uJIKKE=;
 b=iNaaEwlxTtfpovetcJ8hpeWc8YO+opEjCGnumkmZJR4uHMOpk0jt/FEzrjEa5nzHcEXyBhFTr
 GNHYBdIhIuVA2uXEw/6uyqSQvm9H1g18/PXjfCwafctZR5tk9xyqyuq
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|BY1PR18MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: de3632d5-7ff4-487b-871d-08df04ffe512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|7416014|376014|10067099003|6133799003|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	jrau6OUtTkXKgzBrcFr48uMhTuY7s0BcaQ3Y5vT2ICvRodoLljH1Dn2Sd69BYP+lWQGmCyn4Mu6uW7OmqRNpymjKw75pwe+Vq3rHmNg/cMr8yIqTT1dZWxDmdxatpJVqey8/wCNHrHC2dSExUlQf8UVc773tS2Gq6Lm5UiI7kOI5vbYvGWeVID+yjLTfJCRl9AqZs/n9OYJSPInBAICEzGsAr8OtrhMThvi4sFwzfAK5vg2mSYqFr4YaEJ3Ahy7uwHmakIDluR2Xv4sU7rfnwO2jUw46e4qBqqmXvQEsIeIhUek/W0oqARym49puV95pupZBy1l2bqCGb0ubn+70D2L/grw/yKeR3zCAadWfDMhTBCQMV7sZt4bYDAnaivztaLn4Qj0uIFBzx7Gj0w4ftOimkv/DnGR31NfF/1JByvY073wGIER1sA+bmyIgtOirDpOeRYhtT99JsOdYl1FBgHRlqRZhvc/wVAR4Lo/bREGQOdOTudvqjMZZIqGaL1a4hOm1Z8URFgZPuMFWvLO8ME6rbrDvV+YmQiMUtIxGXr+cNIf0JowXjb8+HGN68+Y9jmA/WbX9gOPZYHJU7YjovhGuZIwUEVqLtn9t6a0Xb1K4oJc4lm79XcfMd/5Ny7UZX9gX1ig6nTK7Vi1BTgOKTMkP83uG/jeVbVCsCGh4BkHMImaoOFN87PSiRR9wlSb5iBQUOaoOt+BHzSXQ+gOMpcLpMGwk60NezATTnOLbHKDbTn8pMV1SM2Vv7Mn+WaXf
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(7416014)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZuvzD018v9Mi61OTsAf6ymUcV1wddUKvv/cb7GdJrCvUc8fKlYTPayLSbRBUnChTepDtTkSnZ0nhzonUTvo8n6hmtEvJMGtlvnFkgKYlFYlNvjZjaQKQHH7Bw8o8rxCKjgW6J8mXpGBRa9pJ/722nv9fda6mfVJa/ezfKmmImjqGnzYYXHS3yzVD+KG5UQELDDnGITs0d8fPRJ7ORnWLYT+Ais/4kSBKTZqrTjoguIUi5rik02uOC6bD2QN6JrFNwS8haNF4y4Nukgzt6Y3gUyhRWmVW4i4EKj3cbs1b4ZQnB8oyY/a5ojVf6soNpT8JUaVVdkoBfKu8UfFfJvKY6OnJ/KlPCaWJYg5QLNS4UM3XV5bY7AJIyoCnevYdKb/+jzMbPdx0DDpn13AdlBYMVt2UO+BzPcVlIVzOmHOZWSodM7axJRBLcEKs6+k4kPZk
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 12:28:41.3618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de3632d5-7ff4-487b-871d-08df04ffe512
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB6043

Add support for the SARADC controller found on Axiado AX3000 and
AX3005 SoCs.

The driver supports single-shot voltage reads through the IIO
subsystem. The number of available input channels is selected from
the SoC match data, allowing AX3000 and AX3005 variants to use the
same driver.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 MAINTAINERS                     |   1 +
 drivers/iio/adc/Kconfig         |  11 ++
 drivers/iio/adc/Makefile        |   1 +
 drivers/iio/adc/axiado_saradc.c | 277 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 290 insertions(+)

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
index 000000000000..699ee31616fc
--- /dev/null
+++ b/drivers/iio/adc/axiado_saradc.c
@@ -0,0 +1,277 @@
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
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+
+/* Register offsets */
+#define AX_SARADC_GLOBAL_CTRL_REG	0x0004
+#define AX_SARADC_MANUAL_CTRL_REG	0x0008
+#define AX_SARADC_DOUT_REG	0x001C
+
+/* GLOBAL_CTRL register fields */
+#define AX_SARADC_GLOBAL_CTRL_CH_EN_MASK	GENMASK(31, 16)
+#define AX_SARADC_GLOBAL_CTRL_SAMPLE_MASK	GENMASK(6, 5)
+#define AX_SARADC_GLOBAL_CTRL_MODE_MASK		GENMASK(4, 3)
+#define AX_SARADC_GLOBAL_CTRL_PD		BIT(2)
+#define AX_SARADC_GLOBAL_CTRL_ENABLE		BIT(0)
+
+/* GLOBAL_CTRL SAMPLE_MASK field value: 0 selects 16 samples. */
+#define AX_SARADC_GLOBAL_CTRL_SAMPLE_16	0
+
+/* GLOBAL_CTRL MODE_MASK field value: 1 selects manual mode. */
+#define AX_SARADC_GLOBAL_CTRL_MODE_MANUAL	1
+
+/* MANUAL_CTRL register fields */
+#define AX_SARADC_MANUAL_CTRL_ENABLE	BIT(0)
+#define AX_SARADC_MANUAL_CTRL_CH_SEL_MASK	GENMASK(4, 1)
+
+#define AX_RESOLUTION_BITS	10
+#define AX_SARADC_CONV_CYCLES	13
+#define AX_SARADC_CONV_DELAY_MARGIN_US	10
+
+struct axiado_saradc {
+	struct regmap *regmap;
+	struct mutex lock; /* Serializes ADC conversions. */
+	unsigned long clk_rate;
+	int vref_uV;
+};
+
+/*
+ * Registers contain transient control, status, and conversion data,
+ * so accesses must always go directly to hardware.
+ */
+static const struct regmap_config axiado_saradc_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = AX_SARADC_DOUT_REG,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+static int axiado_saradc_conversion(struct axiado_saradc *info,
+				    struct iio_chan_spec const *chan, int *val)
+{
+	unsigned long usecs;
+	unsigned int regval;
+	int ret;
+
+	guard(mutex)(&info->lock);
+
+	/* Select the channel to be used and trigger conversion. */
+	ret = regmap_write(info->regmap, AX_SARADC_MANUAL_CTRL_REG,
+			   AX_SARADC_MANUAL_CTRL_ENABLE |
+			   FIELD_PREP(AX_SARADC_MANUAL_CTRL_CH_SEL_MASK, chan->channel));
+	if (ret)
+		return ret;
+
+	/* Hardware requires 13 conversion cycles at clk_rate. */
+	usecs = DIV_ROUND_UP(AX_SARADC_CONV_CYCLES * USEC_PER_SEC, info->clk_rate);
+	fsleep(usecs + AX_SARADC_CONV_DELAY_MARGIN_US);
+
+	ret = regmap_read(info->regmap, AX_SARADC_DOUT_REG, &regval);
+
+	/* Best effort to stop manual conversion. */
+	regmap_write(info->regmap, AX_SARADC_MANUAL_CTRL_REG, 0);
+
+	if (ret)
+		return ret;
+
+	*val = regval & GENMASK(AX_RESOLUTION_BITS - 1, 0);
+
+	return 0;
+}
+
+static int axiado_saradc_read_raw(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  int *val, int *val2, long mask)
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
+static void axiado_saradc_disable(void *map)
+{
+	regmap_write(map, AX_SARADC_GLOBAL_CTRL_REG, AX_SARADC_GLOBAL_CTRL_PD);
+}
+
+static int axiado_saradc_probe(struct platform_device *pdev)
+{
+	const struct axiado_saradc_soc_data *soc_data;
+	struct device *dev = &pdev->dev;
+	struct axiado_saradc *info;
+	struct iio_dev *indio_dev;
+	void __iomem *regs;
+	struct regmap *map;
+	struct clk *clk;
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
+	map = devm_regmap_init_mmio(dev, regs, &axiado_saradc_regmap_config);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+	info->regmap = map;
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	info->clk_rate = clk_get_rate(clk);
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
+		return dev_err_probe(dev, -ENODATA, "failed to get match data\n");
+
+	ret = devm_mutex_init(dev, &info->lock);
+	if (ret)
+		return ret;
+
+	regval = FIELD_PREP(AX_SARADC_GLOBAL_CTRL_CH_EN_MASK,
+			    GENMASK(soc_data->num_channels - 1, 0)) |
+		 FIELD_PREP(AX_SARADC_GLOBAL_CTRL_SAMPLE_MASK,
+			    AX_SARADC_GLOBAL_CTRL_SAMPLE_16) |
+		 FIELD_PREP(AX_SARADC_GLOBAL_CTRL_MODE_MASK,
+			    AX_SARADC_GLOBAL_CTRL_MODE_MANUAL) |
+		 AX_SARADC_GLOBAL_CTRL_ENABLE;
+
+	ret = regmap_write(map, AX_SARADC_GLOBAL_CTRL_REG, regval);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, axiado_saradc_disable, map);
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
+		.name = "axiado-saradc",
+		.of_match_table = axiado_saradc_match,
+	},
+	.probe = axiado_saradc_probe,
+};
+module_platform_driver(axiado_saradc_driver);
+
+MODULE_AUTHOR("Axiado Corporation");
+MODULE_DESCRIPTION("Axiado SARADC driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

