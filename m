Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2113.outbound.protection.partner.outlook.cn [139.219.17.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03553E2AD0;
	Mon, 18 May 2026 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092366; cv=fail; b=CZCgkqYw96po7kdqww30Z9G+3mMRM7usPdCsKTx66UmNBTvFfGDWXtnnDwdcW8QcYtW6iXpBdMdK0Dma2kwU0nd9hZkIv2Dl/OGYfVgLVzTSp0unhTnWA6sgqyKVPWYu7UZDUbkpClwgazvFUp6cBamiNnAiCFoAH/20i6YxQ9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092366; c=relaxed/simple;
	bh=KZplUTRlH8fmtVmdfNUi4Oi6vxvmMPHL3yGpkd6bJ6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CQXxQLn/LL+NQ9f5gRKB/ImllmqmSTF1cpav8XJjDxuDX+xPXQlFIqaW+Gfou49FstHtl5xuxKdtfVINnp1D5foCDKX25T886/OiucCKvd/BQZEEH/mSERL/ID0sjd8wQEXCHY9ISJ0xl55vLqX2yyYf9DN/1DhLcJXM4lCR3vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2iAjVgEiPxOOMOTQS/XLsPkf+wiNiMLL/Uw9lj/h3KAFi8qTC8x/XfTls7kIw6tHuXyvPSZ4uR/U946NrBJCTLTFzA9LsEaQHSbh2+X7rgnV5HVEzNTWETGTbKKNNGDVapxT3ZE4uQYcbUQwzsE88TH/QuF5SSGKnMiIMCI8NPLjrDzO5LDTTSXLgd+ZaXqYj7Zo4VBbiHrdfPKzSeVLirFPpIRQc3CbTfnFbvuNOaoGOgeDu8kYIZONNj5roxRkPvpFLwD3mhjM92uuQFUxCgnQeKh0ddY1MQgufp+QL5gkKum37zHpxbalEyJLvPlUdjKiM+Xtaz06F8xu7nsEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCbHYz5qkNqKJC/PpeeGXEKyTkjeKuyiqQZrAGxykyc=;
 b=Rf0W9JjT/ZvVwbjuv0nSDSjWkZYVRfwSa2ZU9JeuW8JO93qZu/YSJ+0/vdd/HhKYrm7B8Aqvyg5Lqtt1/r5cN4+HF/5OcnQcgpTAyhTwOtse1dLwXhBWGVFZPYtw7BW1hDAuYYMMe57xY4giCia7R7MDqHJO3pQO+LZIblSeYmeAXmaBY5tsa++VcSRfOXp78COV2Fj019m5PtjPmjRumKFwFjimyuj7kwXLzjK6XhkfRhBi4qDsp6c/B/aE7acSN2zQ3XykCgBR446kcVWGVKIoz+KKlffjQ/AzzEc1cDIWefZYXuDjPKLBpODNi9FkSR3Sicn6Jbw5RJNcPNxjiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.14; Mon, 18 May
 2026 08:19:02 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::d8e2:3f39:6ae7:bdf2]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::d8e2:3f39:6ae7:bdf2%6])
 with mapi id 15.20.9913.012; Mon, 18 May 2026 08:19:02 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v1 2/2] iio: adc: Add StarFive SAR-ADC driver
Date: Mon, 18 May 2026 16:18:52 +0800
Message-Id: <20260518081852.116909-3-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::31) To NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0956:EE_|NTZPR01MB1035:EE_
X-MS-Office365-Filtering-Correlation-Id: d3fac1b5-3456-403a-7cb3-08deb4b61e83
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	5XvCGWsbS9cZtfP961wcmqyO1Mc7jLm6BEIjalEfYNvdVC6ym+aNNwIDPT4z8pfTfSIMuOVw49t1uElAhuqExxv8KM5KISQSZ1wd56aLYiNigGoTRd/UWlyhNWePe/aIxPS/VAcoQua+BCfm8tcjGMhDuFHhoXJ61w8AQg6SGWVGcKzXvdS/fd3sOUEKwdIuzkqXvri4VjsBGxyKjauQHpQq9LBt2pS99oNSVlxndmmrCWtus/kxlvrI1H85h+IYItoicKjctsFFfFIlsZCqOpGyBQLmHYG6a7Ziab7AdB6TJFOscTfL8seTBefHR1I9JZjwLthmch4gC5UnqvaRCnFE3qYCnka3PcjZa2hAGjY4aXaoAtovMUms+ntE58EMA43WHMC9IAhk6PoCxxObZWU58dr2BtT7rnyD6xEmfiM/ClVcpWD/2J1ysaf4BEsjj63o5me5zDAFLrwbyhZuekUrrP3qTf5V+YQw+oRVZjcUHb++4rAA7/MerNqrXGh0E/vxICdWGEKg078EvzMzlwfx7U3mFL1uchdGvos4cm+ksEI0F4RMoey9xEMbD1yL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MMGj+Ipt2N6f421P0ss7gavOaMNsmBvEQJahiEyj8NIrJu55Ufus2enKrQi7?=
 =?us-ascii?Q?osj4vjHZKpdfMii/iJP/dXA+fxlIU5Xci2FwTCLT27G+YqpRUEtgBTX6fH00?=
 =?us-ascii?Q?Xbrd8sdlbpY2/U2znl7G90FQJ6W1BlTX/8oCT/hiCYC22EmBglhUh8xrNS10?=
 =?us-ascii?Q?IhRe6QIBUP0tzue36kFxZ7e6iM7y/4oG5myLE31dErhdJn29AdgJEP/oixSa?=
 =?us-ascii?Q?zMbSsDA77yhgjlKVWoSHWUxY3eDWlXqaEyDIAb5l+vwmvvGqIyyFCUN4r8Ag?=
 =?us-ascii?Q?Mq6rs2V8ZUfs4J8Ni0Q3KjBDkFXoxIvKkGGY9ARESR9Ffs7/blJf0aeRaacc?=
 =?us-ascii?Q?TOTgFjAiqXWJNWZPJi5HyNomYLDI+2mxjIe99R6X3/N/H/Q4OAsrA3cRhj6N?=
 =?us-ascii?Q?2F6ENQi1f0dBN6HpUyg9CAZD97I5oIBz29Aa+7CtV+9zf85LhgDQGya2R5Vb?=
 =?us-ascii?Q?tqCKsapLN5cvy2eL+WTuCGO6UbPLQEOusDEMUyDYLOh5IHe27FaqDEHG5OOK?=
 =?us-ascii?Q?/tNOVsWLx0tPctbSVqDOCCb/HTz5jbwqN02lpxc/3GM5wLhfqF+jsctdKAja?=
 =?us-ascii?Q?LCEc0RxRo4VbKBo9EXE+vaaeJH0IX7v/1Q2SycEFLIREvrpKb39ANqpBnLUO?=
 =?us-ascii?Q?vZ1BTxqYau/BWuhomcmkZUhqVonpp65X1v8b1Y4XYTOmtmoiXmqyNWCM2x6V?=
 =?us-ascii?Q?F1cHNY3wixdsk/rZ45MkjrtKKx6gy099+EUrvIqxLmci5pDLQx623Zacx2Sz?=
 =?us-ascii?Q?s+4FpdjJxeg1VdXxDztDMh/fgpYqdTXKA1/7gqJ+Z0A71iWvOgP1DGV9f0gR?=
 =?us-ascii?Q?uOqCpUiprMEfwQ1ukMm1DdYjGv++TbJxTuR+9gWrDW0fn3mSgnUmyZ7V7AiL?=
 =?us-ascii?Q?Dz0OV+I/E99/IJLbduXCx7cqL3wBEnXUDGoRoS/xzWCozPCZy8FzCoCRpua4?=
 =?us-ascii?Q?HlSUDS2R0nL4SyZ1+YNc7lJjLtpN7oEi4fFx0ZYBR4axqdBJeAHxS7z78wsc?=
 =?us-ascii?Q?SKJSVhr3cTU9iFsOTGTl3OcJTfiMaO1lGlZfj8G3FilLJlCq7ddWSxkrUa7f?=
 =?us-ascii?Q?kqYFnx+tXg7qNSSw9V+vG/wkznYz/OiL4hmgOAEmeH/68rVN8jXDOD9wblDD?=
 =?us-ascii?Q?UIcZK4rTUlXqRL3TL2pqEjyN9ZUqeD0xRwgGGS7beTbsu/laUOIl7qOOb5bT?=
 =?us-ascii?Q?lu9WuVCf3zpXxTO7OGTLkMXUHtC0Eq2apG7lFYoyHkXaQ1RxIQMXioZdGD7m?=
 =?us-ascii?Q?vvt9MlNC7rA2Y3lkTlt/Z9k417Hi2wEH0of9EF+ZeuzY6UXV90fUxXGczBmE?=
 =?us-ascii?Q?xbyjQ6JMYY9g8jSjxvhtPWDxe1FBlGm3Wv/QoHwW8R5CHZBc4WbIO/zQRFxz?=
 =?us-ascii?Q?jUbg4+dbCuuiJn/T814PqsfWuFHk06vjK6wbWsU//tzjVLYA8KKS1vBfNg9N?=
 =?us-ascii?Q?+x1ZpHa7Ry7/sPU4IQi9UltUK7UFtmdMxmnLLzP9AVxmioV9odnibALG/ZGd?=
 =?us-ascii?Q?Mriv/GmNBDwKdeZfvp4HMOQh15A4i/9GIusiRklH9HnI1uS/9PQfGe0+Hmnj?=
 =?us-ascii?Q?qqsTMwkVqxyDo0LtAtkmlEyIgPNPzTmFQzNJ9Ur4GLEfRK0evtnXvBE2qgqZ?=
 =?us-ascii?Q?cRCI3bNR3cCBtzXXcgnyOIhc4LOM25tDCp5TRIePcyyJpkmgENVNweBpJ7Qv?=
 =?us-ascii?Q?hWo7mQzgwXABRH5aLwvZQGA/8hnO1QVEJENEJ7axDFqLyFlSJ8bnSwslf5G9?=
 =?us-ascii?Q?RphMOpr6FHyUWKXfRkBwoLhIvlKGp+M=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fac1b5-3456-403a-7cb3-08deb4b61e83
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:19:02.3812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oB2WnMnZLX4WRFTRpTe1+Ux7LNFTh3+eVnJvDvGb1MQVHX3dP0iaLGwc1OQCCLNYfM3R+Dv5mK/G2x/f+lssIl6OOFtnGzTmefdL393T010=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1035

Add a new IIO ADC driver for the StarFive JHB100 SAR ADC controller.

The hardware provides 12-bit conversion precision and up to 8 input
channels. This driver supports single-shot channel reads and exposes
standard IIO interfaces for raw ADC values, processed voltages, and
scale reporting. The driver also supports channel monitor mode with
out-of-bound detection and scan frequency configuration.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 MAINTAINERS                       |   6 +
 drivers/iio/adc/Kconfig           |  11 +
 drivers/iio/adc/Makefile          |   1 +
 drivers/iio/adc/starfive-saradc.c | 978 ++++++++++++++++++++++++++++++
 4 files changed, 996 insertions(+)
 create mode 100644 drivers/iio/adc/starfive-saradc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c3fe46d7c4bc..497b3ae64cb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25275,6 +25275,12 @@ F:	Documentation/devicetree/bindings/power/starfive*
 F:	drivers/pmdomain/starfive/
 F:	include/dt-bindings/power/starfive,jh7110-pmu.h
 
+STARFIVE JHB100 SARADC DRIVER
+M:	Xingyu Wu <xingyu.wu@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc.yaml
+F:	drivers/iio/adc/starfive-saradc.c
+
 STARFIVE SOC DRIVERS
 M:	Conor Dooley <conor@kernel.org>
 S:	Maintained
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 60038ae8dfc4..5f85d521f659 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1514,6 +1514,17 @@ config SD_ADC_MODULATOR
 	  This driver can also be built as a module.  If so, the module
 	  will be called sd_adc_modulator.
 
+config STARFIVE_SARADC
+	tristate "StarFive SARADC driver"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	depends on COMMON_CLK && RESET_CONTROLLER
+	help
+	  Say yes here to build support for the SARADC found in SoCs from
+	  StarFive.
+
+          To compile this driver as a module, choose M here: the
+          module will be called starfive_saradc.
+
 config STM32_ADC_CORE
 	tristate "STMicroelectronics STM32 adc core"
 	depends on ARCH_STM32 || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index c76550415ff1..d4a3a4af16c6 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -133,6 +133,7 @@ obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
 obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
 obj-$(CONFIG_SOPHGO_CV1800B_ADC) += sophgo-cv1800b-adc.o
 obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
+obj-$(CONFIG_STARFIVE_SARADC) += starfive-saradc.o
 obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
 obj-$(CONFIG_STM32_ADC) += stm32-adc.o
 obj-$(CONFIG_STM32_DFSDM_ADC) += stm32-dfsdm-adc.o
diff --git a/drivers/iio/adc/starfive-saradc.c b/drivers/iio/adc/starfive-saradc.c
new file mode 100644
index 000000000000..78409cb1bcb2
--- /dev/null
+++ b/drivers/iio/adc/starfive-saradc.c
@@ -0,0 +1,978 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * StarFive Successive Approximation Register (SAR) A/D Converter
+ *
+ * Copyright (C) 2026 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+#define SARADC_CTRL				0x00
+#define SARADC_IRQ_EN_ST			0x04
+#define SARADC_SAMPLE_DAT0			0x10
+#define SARADC_ULB_CH0				0x40
+#define SARADC_SCAN_FREQ			0x70
+
+/* macro SARADC_CTRL reg*/
+#define ADC_EN_MSK				BIT(0)
+#define ADC_PWRDOWN_MSK				BIT(1)
+#define ADC_IDLE_MSK				BIT(8)
+#define ADC_CHAN_EN_MSK				GENMASK(23, 16)
+#define ADC_CHAN_EN_SFT				16
+#define SARADC_CHAN_EN(x)			(BIT(x) << ADC_CHAN_EN_SFT)
+
+/* macro SARADC_IRQ_EN_ST reg */
+#define ADC_IRQ_ST_MSK				GENMASK(7, 0)
+#define ADC_IRQ_EN_MSK				GENMASK(23, 16)
+#define ADC_IRQ_EN_SFT				16
+#define SARADC_IRQ_CH_EN(x)			(BIT(x) << ADC_IRQ_EN_SFT)
+
+/* macro SARADC_SAMPLE_DATx reg */
+#define ADC_DAT_MSK				GENMASK(11, 0)
+#define ADC_DAT_RDY_MSK				BIT(31)
+
+/* macro SARADC_ULB_CHX reg */
+#define ADC_LOWER_BOUND_MSK			GENMASK(11, 0)
+#define ADC_LOWER_BOUND_SFT			0
+#define ADC_UPPER_BOUND_MSK			GENMASK(31, 20)
+#define ADC_UPPER_BOUND_SFT			20
+#define ADC_LOWER_BOUND_DEF			0x0
+#define ADC_UPPER_BOUND_DEF			0xFFF
+
+/* macro SARADC_SCAN_FREQ reg */
+#define ADC_SCAN_FREQ_MSK			GENMASK(19, 0)
+#define ADC_SCAN_FREQ_SFT			0
+#define ADC_SCAN_FREQ_DEF			20
+#define ADC_SCAN_FREQ_MIN			15
+
+#define SARADC_TIMEOUT				(100 * USEC_PER_MSEC)
+#define SARADC_MAX_CHANNELS			8
+#define SARADC_REALBITS				12
+#define SARADC_DATAX_REG_GET(x)			((x) * sizeof(u32) + SARADC_SAMPLE_DAT0)
+#define SARADC_ULB_CHX_REG_GET(x)		((x) * sizeof(u32) + SARADC_ULB_CH0)
+/* AVDD = 1.8v = 1.8 * 1000000 uv */
+#define SARADC_AVDD_VOL				(18 * 100000)
+/* same with: (x * 1800000) >> 12 */
+#define SARADC_VDD_XFER(x)			(((x) * 28125) >> 6)
+
+#define SARADC_ADJUST_B				65217 /* 0.065217 * 1000000 */
+#define SARADC_ADJUST_K				1078 /* 1.078 * 1000 */
+/* For VDD adjustment: ((x - b) * k) v*/
+#define SARADC_VDD_ADJUST(x)			(((x) - SARADC_ADJUST_B) * \
+						 SARADC_ADJUST_K / 1000)
+#define SARADC_RAW_TO_VDD_ADJ(x)	({ \
+						u32 _x = (x); \
+						(_x < 149) ? 0U : ({ \
+							u64 _v = (uint64_t)_x * \
+							28125 - 4173888; \
+							(u32)((_v * 1078 + 32000) / 64000); \
+						}); \
+					})
+
+#define SARADC_VDD_MV_TO_RAW(x)		({ \
+						((x) == 0) ? 0U : ({ \
+							u32 _raw = \
+							(u32)(((u64)(x) * 64000000ULL + \
+							4514610639ULL) / 30318750ULL); \
+							_raw > 4095 ? 4095 : _raw; \
+						}); \
+					})
+
+#define SARADC_CHAN(_index) {					\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = _index,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			BIT(IIO_CHAN_INFO_PROCESSED),		\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
+	.datasheet_name = "SARADC_"#_index,			\
+	.scan_index = _index,					\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = SARADC_REALBITS,			\
+		.endianness = IIO_CPU,				\
+	},							\
+}
+
+struct starfive_saradc {
+	void __iomem		*base;
+	struct device		*dev;
+	struct clk		*clk;
+	struct reset_control	*rst;
+	/* lock to protect against multiple access to the device */
+	struct mutex		lock;
+	int			using_ch;
+	/* flag of interrupts by error or data done */
+	bool			err;
+	bool			mon_working;
+	u8			mon_ch;
+	bool			mon_en;
+	u32			up_bounds[SARADC_MAX_CHANNELS];
+	u32			low_bounds[SARADC_MAX_CHANNELS];
+};
+
+static const struct iio_chan_spec starfive_saradc_iio_channels[] = {
+	SARADC_CHAN(0),
+	SARADC_CHAN(1),
+	SARADC_CHAN(2),
+	SARADC_CHAN(3),
+	SARADC_CHAN(4),
+	SARADC_CHAN(5),
+	SARADC_CHAN(6),
+	SARADC_CHAN(7),
+};
+
+/* Power on or down */
+static void starfive_saradc_pwr_on(struct starfive_saradc *priv, bool on)
+{
+	unsigned int val = readl(priv->base + SARADC_CTRL);
+
+	if (on)
+		writel(val & ~ADC_PWRDOWN_MSK, priv->base + SARADC_CTRL);
+	else
+		writel(val | ADC_PWRDOWN_MSK, priv->base + SARADC_CTRL);
+}
+
+static inline bool starfive_saradc_is_ready(struct starfive_saradc *priv)
+{
+	return !!(readl(priv->base + SARADC_CTRL) & ADC_IDLE_MSK);
+}
+
+static inline unsigned int starfive_saradc_data_get(struct starfive_saradc *priv)
+{
+	return readl(priv->base + SARADC_DATAX_REG_GET(priv->using_ch));
+}
+
+static inline void starfive_saradc_irq_clr(struct starfive_saradc *priv, u32 reg)
+{
+	writel(reg | ADC_IRQ_ST_MSK, priv->base + SARADC_IRQ_EN_ST);
+}
+
+static inline void starfive_saradc_data_clr_ch(struct starfive_saradc *priv, int ch)
+{
+	writel(ADC_DAT_RDY_MSK, priv->base + SARADC_DATAX_REG_GET(ch));
+}
+
+static inline void starfive_saradc_irq_clr_all(struct starfive_saradc *priv)
+{
+	unsigned int reg = readl(priv->base + SARADC_IRQ_EN_ST);
+	int i;
+
+	starfive_saradc_irq_clr(priv, reg);
+	for (i = 0; i < SARADC_MAX_CHANNELS; i++)
+		starfive_saradc_data_clr_ch(priv, i);
+}
+
+static void starfive_saradc_ch_dis_save(struct starfive_saradc *priv)
+{
+	unsigned int reg;
+
+	if (priv->mon_en) {
+		writel(ADC_IRQ_ST_MSK, priv->base + SARADC_IRQ_EN_ST);
+
+		reg = readl(priv->base + SARADC_CTRL) & ~ADC_CHAN_EN_MSK;
+		writel(reg, priv->base + SARADC_CTRL);
+		priv->mon_working = false;
+	}
+
+	starfive_saradc_irq_clr_all(priv);
+	msleep(20);
+}
+
+static void starfive_saradc_ch_start(struct starfive_saradc *priv)
+{
+	int ch = priv->using_ch;
+	unsigned int reg = readl(priv->base + SARADC_CTRL);
+
+	/* Enable channel */
+	reg = (reg & ~ADC_CHAN_EN_MSK) | SARADC_CHAN_EN(ch);
+	writel(reg, priv->base + SARADC_CTRL);
+
+	msleep(20);
+
+	/* Enable conversion */
+	writel(reg | ADC_EN_MSK, priv->base + SARADC_CTRL);
+}
+
+static void starfive_saradc_ch_stop(struct starfive_saradc *priv)
+{
+	unsigned int reg = readl(priv->base + SARADC_CTRL);
+
+	/* Disable channel */
+	reg &= ~ADC_CHAN_EN_MSK;
+	writel(reg, priv->base + SARADC_CTRL);
+
+	if (priv->mon_en) {
+		/* Restore IRQ and re-enable channel */
+		reg = readl(priv->base + SARADC_CTRL) | SARADC_CHAN_EN(priv->mon_ch);
+		writel(reg, priv->base + SARADC_CTRL);
+		starfive_saradc_irq_clr_all(priv);
+
+		writel(SARADC_IRQ_CH_EN(priv->mon_ch), priv->base + SARADC_IRQ_EN_ST);
+		priv->mon_working = true;
+	}
+}
+
+static u32 starfive_saradc_scan_freq_get(struct starfive_saradc *priv)
+{
+	return readl(priv->base + SARADC_SCAN_FREQ) & ADC_SCAN_FREQ_MSK;
+}
+
+static void starfive_saradc_scan_freq_set(struct starfive_saradc *priv, u32 data)
+{
+	writel(data & ADC_SCAN_FREQ_MSK, priv->base + SARADC_SCAN_FREQ);
+}
+
+static u32 starfive_saradc_ch_upper_bound_get(struct starfive_saradc *priv, int ch)
+{
+	return FIELD_GET(ADC_UPPER_BOUND_MSK,
+			 readl(priv->base + SARADC_ULB_CHX_REG_GET(ch)));
+}
+
+static void starfive_saradc_ch_upper_bound_set(struct starfive_saradc *priv,
+					       int ch, u32 data)
+{
+	void __iomem *base = priv->base + SARADC_ULB_CHX_REG_GET(ch);
+	u32 reg = readl(base) & ~ADC_UPPER_BOUND_MSK;
+
+	writel(FIELD_PREP(ADC_UPPER_BOUND_MSK, data) | reg, base);
+}
+
+static u32 starfive_saradc_ch_lower_bound_get(struct starfive_saradc *priv, int ch)
+{
+	return FIELD_GET(ADC_LOWER_BOUND_MSK,
+			 readl(priv->base + SARADC_ULB_CHX_REG_GET(ch)));
+}
+
+static void starfive_saradc_ch_lower_bound_set(struct starfive_saradc *priv,
+					       int ch, u32 data)
+{
+	void __iomem *base = priv->base + SARADC_ULB_CHX_REG_GET(ch);
+	u32 reg = readl(base) & ~ADC_LOWER_BOUND_MSK;
+
+	writel(FIELD_PREP(ADC_LOWER_BOUND_MSK, data) | reg, base);
+}
+
+static ssize_t starfive_saradc_scan_freq_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct starfive_saradc *priv = iio_priv(indio_dev);
+	int ret = pm_runtime_get_sync(priv->dev);
+	ssize_t len;
+
+	if (ret < 0) {
+		pm_runtime_put_noidle(priv->dev);
+		return ret;
+	}
+
+	len = sprintf(buf, "%d\n", starfive_saradc_scan_freq_get(priv));
+	pm_runtime_put(priv->dev);
+
+	return len;
+}
+
+static ssize_t starfive_saradc_scan_freq_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct starfive_saradc *priv = iio_priv(indio_dev);
+	u32 freq;
+	int ret;
+
+	if (kstrtou32(buf, 10, &freq))
+		return -EINVAL;
+
+	ret = pm_runtime_get_sync(priv->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(priv->dev);
+		return ret;
+	}
+
+	if (freq < ADC_SCAN_FREQ_MIN || freq > ADC_SCAN_FREQ_MSK) {
+		dev_err(dev, "The data %d is out of range (%d - %ld).\n",
+			freq, ADC_SCAN_FREQ_MIN, ADC_SCAN_FREQ_MSK);
+		pm_runtime_put(priv->dev);
+		return -EINVAL;
+	}
+
+	starfive_saradc_scan_freq_set(priv, freq);
+	pm_runtime_put(priv->dev);
+
+	return len;
+}
+
+static ssize_t starfive_saradc_upper_bound_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_attr *iio_attr = to_iio_dev_attr(attr);
+	int ch = iio_attr->address;
+	struct starfive_saradc *priv = iio_priv(indio_dev);
+	int ret = pm_runtime_get_sync(priv->dev);
+	ssize_t len;
+
+	if (ret < 0) {
+		pm_runtime_put_noidle(priv->dev);
+		return ret;
+	}
+
+	len = sprintf(buf, "%d\n", priv->up_bounds[ch]);
+	pm_runtime_put(priv->dev);
+
+	return len;
+}
+
+static ssize_t starfive_saradc_upper_bound_store(struct device *dev,
+						 struct device_attribute *attr,
+						 const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_attr *iio_attr = to_iio_dev_attr(attr);
+	int ch = iio_attr->address;
+	struct starfive_saradc *priv = iio_priv(indio_dev);
+	u32 upper;
+	int ret;
+
+	if (kstrtou32(buf, 10, &upper))
+		return -EINVAL;
+
+	ret = pm_runtime_get_sync(priv->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(priv->dev);
+		return ret;
+	}
+
+	starfive_saradc_ch_upper_bound_set(priv, ch, SARADC_VDD_MV_TO_RAW(upper));
+	priv->up_bounds[ch] = upper;
+	pm_runtime_put(priv->dev);
+
+	return len;
+}
+
+static ssize_t starfive_saradc_lower_bound_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_attr *iio_attr = to_iio_dev_attr(attr);
+	int ch = iio_attr->address;
+	struct starfive_saradc *priv = iio_priv(indio_dev);
+	int ret = pm_runtime_get_sync(priv->dev);
+	ssize_t len;
+
+	if (ret < 0) {
+		pm_runtime_put_noidle(priv->dev);
+		return ret;
+	}
+
+	len = sprintf(buf, "%d\n", priv->low_bounds[ch]);
+	pm_runtime_put(priv->dev);
+
+	return len;
+}
+
+static ssize_t starfive_saradc_lower_bound_store(struct device *dev,
+						 struct device_attribute *attr,
+						 const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_attr *iio_attr = to_iio_dev_attr(attr);
+	int ch = iio_attr->address;
+	struct starfive_saradc *priv = iio_priv(indio_dev);
+	u32 lower;
+	int ret;
+
+	if (kstrtou32(buf, 10, &lower))
+		return -EINVAL;
+
+	ret = pm_runtime_get_sync(priv->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(priv->dev);
+		return ret;
+	}
+
+	starfive_saradc_ch_lower_bound_set(priv, ch, SARADC_VDD_MV_TO_RAW(lower));
+	priv->low_bounds[ch] = lower;
+	pm_runtime_put(priv->dev);
+
+	return len;
+}
+
+static ssize_t starfive_saradc_monitor_channel_show(struct device *dev,
+						    struct device_attribute *attr,
+						    char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct starfive_saradc *priv = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", priv->mon_ch);
+}
+
+static ssize_t starfive_saradc_monitor_channel_select(struct device *dev,
+						      struct device_attribute *attr,
+						      const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct starfive_saradc *priv = iio_priv(indio_dev);
+	u32 ch;
+
+	if (kstrtou32(buf, 10, &ch))
+		return -EINVAL;
+
+	if (ch >= SARADC_MAX_CHANNELS || ch < 0)
+		return -EINVAL;
+
+	priv->mon_ch = ch;
+
+	return len;
+}
+
+static ssize_t starfive_saradc_monitor_status(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct starfive_saradc *priv = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", priv->mon_en);
+}
+
+static void starfive_saradc_ch_monitor_start(struct starfive_saradc *priv, u8 ch)
+{
+	u32 reg = readl(priv->base + SARADC_CTRL);
+
+	starfive_saradc_irq_clr(priv, BIT(ch));
+	starfive_saradc_data_clr_ch(priv, ch);
+
+	/* Enable channel */
+	reg |= SARADC_CHAN_EN(ch);
+	writel(reg, priv->base + SARADC_CTRL);
+
+	msleep(20);
+
+	/* Enable conversion */
+	writel(reg | ADC_EN_MSK, priv->base + SARADC_CTRL);
+
+	/* Enable IRQ */
+	reg = readl(priv->base + SARADC_IRQ_EN_ST);
+	writel(reg | SARADC_IRQ_CH_EN(ch), priv->base + SARADC_IRQ_EN_ST);
+
+	priv->mon_en = true;
+	priv->mon_working = true;
+}
+
+static void starfive_saradc_ch_monitor_stop(struct starfive_saradc *priv, u8 ch)
+{
+	unsigned int reg = readl(priv->base + SARADC_IRQ_EN_ST);
+
+	/* Disable IRQ */
+	writel(reg & ~SARADC_IRQ_CH_EN(ch), priv->base + SARADC_IRQ_EN_ST);
+	starfive_saradc_irq_clr(priv, BIT(ch));
+	starfive_saradc_data_clr_ch(priv, ch);
+
+	/* Disable channel */
+	reg = readl(priv->base + SARADC_CTRL) & ~SARADC_CHAN_EN(ch);
+	writel(reg, priv->base + SARADC_CTRL);
+
+	priv->mon_en = false;
+	priv->mon_working = false;
+}
+
+static ssize_t starfive_saradc_monitor_enable(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct starfive_saradc *priv = iio_priv(indio_dev);
+	u8 ch = priv->mon_ch;
+	u32 enable;
+	int ret;
+
+	if (kstrtou32(buf, 10, &enable))
+		return -EINVAL;
+
+	if (ch >= SARADC_MAX_CHANNELS || ch < 0)
+		return -EINVAL;
+
+	mutex_lock(&priv->lock);
+	if (enable && !priv->mon_en) {
+		ret = pm_runtime_get_sync(priv->dev);
+		if (ret < 0) {
+			pm_runtime_put_noidle(priv->dev);
+			goto out;
+		}
+
+		if (!starfive_saradc_is_ready(priv)) {
+			dev_err(priv->dev, "ADC do not ready, please try again later!\n");
+			pm_runtime_put(priv->dev);
+			goto out;
+		}
+
+		starfive_saradc_ch_monitor_start(priv, ch);
+	} else if (!enable && priv->mon_en) {
+		starfive_saradc_ch_monitor_stop(priv, ch);
+		pm_runtime_put(priv->dev);
+	}
+
+out:
+	mutex_unlock(&priv->lock);
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(scan_frequency, 0644,
+		       starfive_saradc_scan_freq_show,
+		       starfive_saradc_scan_freq_store, 0);
+static IIO_DEVICE_ATTR(in_voltage0_upper, 0644,
+		       starfive_saradc_upper_bound_show,
+		       starfive_saradc_upper_bound_store, 0);
+static IIO_DEVICE_ATTR(in_voltage1_upper, 0644,
+		       starfive_saradc_upper_bound_show,
+		       starfive_saradc_upper_bound_store, 1);
+static IIO_DEVICE_ATTR(in_voltage2_upper, 0644,
+		       starfive_saradc_upper_bound_show,
+		       starfive_saradc_upper_bound_store, 2);
+static IIO_DEVICE_ATTR(in_voltage3_upper, 0644,
+		       starfive_saradc_upper_bound_show,
+		       starfive_saradc_upper_bound_store, 3);
+static IIO_DEVICE_ATTR(in_voltage4_upper, 0644,
+		       starfive_saradc_upper_bound_show,
+		       starfive_saradc_upper_bound_store, 4);
+static IIO_DEVICE_ATTR(in_voltage5_upper, 0644,
+		       starfive_saradc_upper_bound_show,
+		       starfive_saradc_upper_bound_store, 5);
+static IIO_DEVICE_ATTR(in_voltage6_upper, 0644,
+		       starfive_saradc_upper_bound_show,
+		       starfive_saradc_upper_bound_store, 6);
+static IIO_DEVICE_ATTR(in_voltage7_upper, 0644,
+		       starfive_saradc_upper_bound_show,
+		       starfive_saradc_upper_bound_store, 7);
+static IIO_DEVICE_ATTR(in_voltage0_lower, 0644,
+		       starfive_saradc_lower_bound_show,
+		       starfive_saradc_lower_bound_store, 0);
+static IIO_DEVICE_ATTR(in_voltage1_lower, 0644,
+		       starfive_saradc_lower_bound_show,
+		       starfive_saradc_lower_bound_store, 1);
+static IIO_DEVICE_ATTR(in_voltage2_lower, 0644,
+		       starfive_saradc_lower_bound_show,
+		       starfive_saradc_lower_bound_store, 2);
+static IIO_DEVICE_ATTR(in_voltage3_lower, 0644,
+		       starfive_saradc_lower_bound_show,
+		       starfive_saradc_lower_bound_store, 3);
+static IIO_DEVICE_ATTR(in_voltage4_lower, 0644,
+		       starfive_saradc_lower_bound_show,
+		       starfive_saradc_lower_bound_store, 4);
+static IIO_DEVICE_ATTR(in_voltage5_lower, 0644,
+		       starfive_saradc_lower_bound_show,
+		       starfive_saradc_lower_bound_store, 5);
+static IIO_DEVICE_ATTR(in_voltage6_lower, 0644,
+		       starfive_saradc_lower_bound_show,
+		       starfive_saradc_lower_bound_store, 6);
+static IIO_DEVICE_ATTR(in_voltage7_lower, 0644,
+		       starfive_saradc_lower_bound_show,
+		       starfive_saradc_lower_bound_store, 7);
+static IIO_DEVICE_ATTR(voltage_monitor_channel, 0644,
+		       starfive_saradc_monitor_channel_show,
+		       starfive_saradc_monitor_channel_select, 2);
+static IIO_DEVICE_ATTR(voltage_monitor_en, 0644,
+		       starfive_saradc_monitor_status,
+		       starfive_saradc_monitor_enable, 0);
+
+static struct attribute *starfive_saradc_attributes[] = {
+	&iio_dev_attr_scan_frequency.dev_attr.attr,
+	&iio_dev_attr_in_voltage0_upper.dev_attr.attr,
+	&iio_dev_attr_in_voltage1_upper.dev_attr.attr,
+	&iio_dev_attr_in_voltage2_upper.dev_attr.attr,
+	&iio_dev_attr_in_voltage3_upper.dev_attr.attr,
+	&iio_dev_attr_in_voltage4_upper.dev_attr.attr,
+	&iio_dev_attr_in_voltage5_upper.dev_attr.attr,
+	&iio_dev_attr_in_voltage6_upper.dev_attr.attr,
+	&iio_dev_attr_in_voltage7_upper.dev_attr.attr,
+	&iio_dev_attr_in_voltage0_lower.dev_attr.attr,
+	&iio_dev_attr_in_voltage1_lower.dev_attr.attr,
+	&iio_dev_attr_in_voltage2_lower.dev_attr.attr,
+	&iio_dev_attr_in_voltage3_lower.dev_attr.attr,
+	&iio_dev_attr_in_voltage4_lower.dev_attr.attr,
+	&iio_dev_attr_in_voltage5_lower.dev_attr.attr,
+	&iio_dev_attr_in_voltage6_lower.dev_attr.attr,
+	&iio_dev_attr_in_voltage7_lower.dev_attr.attr,
+	&iio_dev_attr_voltage_monitor_channel.dev_attr.attr,
+	&iio_dev_attr_voltage_monitor_en.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group starfive_saradc_attr_group = {
+	.attrs = starfive_saradc_attributes,
+};
+
+static int starfive_saradc_read(struct starfive_saradc *priv)
+{
+	unsigned int tmp;
+	int ret;
+
+	starfive_saradc_ch_dis_save(priv);
+	if (!starfive_saradc_is_ready(priv)) {
+		dev_err(priv->dev, "ADC do not ready, please try again later!\n");
+		starfive_saradc_ch_stop(priv);
+		return -EBUSY;
+	}
+
+	priv->err = false;
+	starfive_saradc_ch_start(priv);
+
+	tmp = starfive_saradc_data_get(priv);
+	/* Check that the data is ready to be read. */
+	if (!(tmp & ADC_DAT_RDY_MSK)) {
+		ret = readl_poll_timeout(priv->base + SARADC_DATAX_REG_GET(priv->using_ch), tmp,
+					 (tmp & ADC_DAT_RDY_MSK), 10, SARADC_TIMEOUT);
+		if (ret) {
+			priv->err = true;
+			dev_err(priv->dev, "channel%d is still not ready to be read! Timeout!\n",
+				priv->using_ch);
+		}
+	}
+
+	if (priv->err)
+		tmp = 0;
+
+	starfive_saradc_ch_stop(priv);
+
+	return (int)(tmp & ADC_DAT_MSK);
+}
+
+static int starfive_saradc_read_raw(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    int *val, int *val2, long mask)
+{
+	struct starfive_saradc *priv = iio_priv(indio_dev);
+	int ret;
+	u64 tmp;
+
+	mutex_lock(&priv->lock);
+	priv->using_ch = chan->channel;
+	ret = pm_runtime_get_sync(priv->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(priv->dev);
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = starfive_saradc_read(priv);
+		if (ret < 0)
+			break;
+
+		*val = ret;
+		ret = IIO_VAL_INT;
+		break;
+
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = starfive_saradc_read(priv);
+		if (ret < 0)
+			break;
+
+		/* VIN = AVDD * data[11:0] / 4096. (AVDD = 1.8v) */
+		tmp = SARADC_RAW_TO_VDD_ADJ(ret);
+		*val = (int)(tmp / 1000000);
+		*val2 = (int)(tmp % 1000000);
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * AVDD is fixed at 1.8v.
+		 * 1.8 / (1 << 12) * 1000000
+		 */
+		*val = 0;
+		*val2 = SARADC_AVDD_VOL / (1 << SARADC_REALBITS);
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+	pm_runtime_put_autosuspend(priv->dev);
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static irqreturn_t starfive_saradc_mon_stop_threadfn(int irq, void *data)
+{
+	struct starfive_saradc *priv = data;
+	u8 ch = priv->mon_ch;
+	u32 up, low, raw;
+
+	mutex_lock(&priv->lock);
+	if (!priv->mon_en) {
+		mutex_unlock(&priv->lock);
+		return IRQ_HANDLED;
+	}
+
+	raw = readl(priv->base + SARADC_DATAX_REG_GET(ch)) & ADC_DAT_MSK;
+	up = starfive_saradc_ch_upper_bound_get(priv, ch);
+	low = starfive_saradc_ch_lower_bound_get(priv, ch);
+	dev_err(priv->dev,
+		"channel %d is out of bounds. sample data: %dmv (range: %dmv ~ %dmv)\n",
+		ch, (SARADC_RAW_TO_VDD_ADJ(raw) / 1000),
+		priv->low_bounds[ch], priv->up_bounds[ch]);
+
+	starfive_saradc_ch_monitor_stop(priv, ch);
+	pm_runtime_put_autosuspend(priv->dev);
+	mutex_unlock(&priv->lock);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t starfive_saradc_irq_handler(int irq, void *data)
+{
+	struct starfive_saradc *priv = data;
+	u32 irq_err = readl(priv->base + SARADC_IRQ_EN_ST);
+
+	if (!priv->mon_working)
+		return IRQ_HANDLED;
+
+	/* Error of out of bounds */
+	if (irq_err & BIT(priv->mon_ch)) {
+		/* Clear the interrupt */
+		writel(irq_err, priv->base + SARADC_IRQ_EN_ST);
+		priv->err = true;
+		return IRQ_WAKE_THREAD;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void starfive_saradc_init(struct starfive_saradc *priv)
+{
+	bool use_def = false;
+	u16 up, low, scan, tmp;
+	u32 upmv, lowmv;
+	int i;
+
+	if (of_property_read_u16(priv->dev->of_node, "upper-bound-mv", &tmp)) {
+		use_def = true;
+	} else {
+		up = SARADC_VDD_MV_TO_RAW(tmp);
+		if (up > ADC_UPPER_BOUND_DEF)
+			use_def = true;
+		else
+			upmv = tmp;
+	}
+
+	if (use_def) {
+		up = ADC_UPPER_BOUND_DEF;
+		upmv = SARADC_RAW_TO_VDD_ADJ(up);
+		use_def = false;
+	}
+
+	if (of_property_read_u16(priv->dev->of_node, "lower-bound-mv", &tmp)) {
+		use_def = true;
+	} else {
+		low = SARADC_VDD_MV_TO_RAW(tmp);
+		if (low > ADC_UPPER_BOUND_DEF)
+			use_def = true;
+		else
+			lowmv = tmp;
+	}
+
+	if (use_def) {
+		low = ADC_LOWER_BOUND_DEF;
+		lowmv = SARADC_RAW_TO_VDD_ADJ(low);
+	}
+
+	if (of_property_read_u16(priv->dev->of_node, "scan-freq", &scan))
+		scan = ADC_SCAN_FREQ_DEF;
+
+	if ((scan & ADC_SCAN_FREQ_MSK) < ADC_SCAN_FREQ_MIN) {
+		dev_warn(priv->dev, "The scan_freq is out of range and use the default value!\n");
+		scan = ADC_SCAN_FREQ_DEF;
+	}
+
+	starfive_saradc_scan_freq_set(priv, scan);
+
+	for (i = 0; i < SARADC_MAX_CHANNELS; i++) {
+		starfive_saradc_ch_upper_bound_set(priv, i, up);
+		starfive_saradc_ch_lower_bound_set(priv, i, low);
+		priv->up_bounds[i] = upmv;
+		priv->low_bounds[i] = lowmv;
+	}
+}
+
+static int starfive_saradc_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+				      unsigned int writeval, unsigned int *readval)
+{
+	struct starfive_saradc *priv = iio_priv(indio_dev);
+	int ret = 0;
+
+	if (reg % 4 || reg > SARADC_SCAN_FREQ)
+		return -EINVAL;
+
+	ret = pm_runtime_get_sync(priv->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(priv->dev);
+		return ret;
+	}
+
+	mutex_lock(&priv->lock);
+
+	if (readval)
+		*readval = readl(priv->base + reg);
+	else if (reg < SARADC_ULB_CH0)
+		/* Allowed to write from SARADC_ULB_CH0 to SARADC_SCAN_FREQ */
+		ret = -EINVAL;
+	else
+		writel(writeval, priv->base + reg);
+
+	mutex_unlock(&priv->lock);
+	pm_runtime_put_sync_autosuspend(priv->dev);
+
+	return ret;
+}
+
+static const struct iio_info starfive_saradc_iio_info = {
+	.read_raw = starfive_saradc_read_raw,
+	.debugfs_reg_access = starfive_saradc_reg_access,
+	.attrs = &starfive_saradc_attr_group,
+};
+
+static int starfive_saradc_probe(struct platform_device *pdev)
+{
+	struct starfive_saradc *priv;
+	struct iio_dev *indio_dev;
+	int irq, ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
+	if (!indio_dev)
+		return dev_err_probe(&pdev->dev, -ENOMEM, "failed allocating iio device\n");
+
+	priv = iio_priv(indio_dev);
+	platform_set_drvdata(pdev, indio_dev);
+	priv->dev = &pdev->dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(&pdev->dev, irq,
+				     "failed to get irq\n");
+
+	ret = devm_request_threaded_irq(&pdev->dev, irq,
+					starfive_saradc_irq_handler,
+					starfive_saradc_mon_stop_threadfn,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					dev_name(&pdev->dev), priv);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to request irq handler\n");
+
+	priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk),
+				     "failed to get clock\n");
+
+	priv->rst = devm_reset_control_array_get_shared(&pdev->dev);
+	if (IS_ERR(priv->rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->rst),
+				     "failed to get resets\n");
+
+	ret = reset_control_deassert(priv->rst);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to deassert reset\n");
+
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &starfive_saradc_iio_info;
+	indio_dev->channels = starfive_saradc_iio_channels;
+	indio_dev->num_channels = ARRAY_SIZE(starfive_saradc_iio_channels);
+
+	starfive_saradc_init(priv);
+	mutex_init(&priv->lock);
+
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static void starfive_saradc_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+}
+
+static int starfive_saradc_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct starfive_saradc *priv = iio_priv(indio_dev);
+
+	starfive_saradc_pwr_on(priv, false);
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int starfive_saradc_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct starfive_saradc *priv = iio_priv(indio_dev);
+	int ret = clk_prepare_enable(priv->clk);
+
+	if (ret)
+		return ret;
+
+	starfive_saradc_pwr_on(priv, true);
+	/* Need time to completely power on. */
+	msleep(20);
+
+	return 0;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(starfive_saradc_pm_ops,
+				 starfive_saradc_runtime_suspend,
+				 starfive_saradc_runtime_resume, NULL);
+
+static const struct of_device_id starfive_saradc_of_match[] = {
+	{ .compatible = "starfive,jhb100-saradc", },
+	{ }
+};
+
+static struct platform_driver starfive_saradc_driver = {
+	.probe	= starfive_saradc_probe,
+	.remove	= starfive_saradc_remove,
+	.driver	= {
+		.name = "starfive_saradc",
+		.of_match_table = starfive_saradc_of_match,
+		.pm = pm_ptr(&starfive_saradc_pm_ops)
+	},
+};
+
+module_platform_driver(starfive_saradc_driver);
+
+MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive Successive Approximation Register ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

