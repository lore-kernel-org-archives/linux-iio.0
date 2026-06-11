Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020107.outbound.protection.outlook.com [52.101.46.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EE6293C4E;
	Thu, 11 Jun 2026 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170704; cv=fail; b=KpQi6+qcrH7UjKTS5T2CqUR5D0zIpZJVefZkOrV6OkmX1TNEDoKETileCdW6zGE364d4w7GQl7F8FivxvdKaSJohIrJrtU4+pp+ecXPmZ0OET2W82j5ks5DHBTbkT6TMZf31IVKzt4Ok3IpHgsvX4/AVfb/slECmpJQDtq32GYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170704; c=relaxed/simple;
	bh=NF72uE+7ZGh3ABz5dozlMLicl+m0ViqKxaWUHa/Lp48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KDNh8V4rtUjj/JqabehQnMAbMcaLdJ9YnJ/d96e66uvYBrF2sI9yiYpVUN/G2SJm/gXGImOkjXHmHZk8KcG7RTABk0l8/LLY8jTviSjayQK+KASth3i02zaYDuZkfqHuL0kWBPbEtSRlyrcDwy470tPLuHGkcIly1GJIYKZl4jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=gsML4gqD; arc=fail smtp.client-ip=52.101.46.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="gsML4gqD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuTWgpQ42GDG0IK2GivWGkE/JMQHStf0HFEEfUsXfI88RZ+g59V7E7AcxuAV1cdYHGcQeUVeXP5lwA/wIVfoS24ovyPgYyh4OKjDgVPtxO+JcAt0lmbH/MHiz3/6ZZZPVJ0r/ExpUHwpjV0KTEu7naVbMKJmIOmayl2zuNL9FnXzMocE0BFxmOXdlJaj6eHx6aW9LXI2/RebVTakNkF06Z7KNPtUGNqfzguG/hxlDHX9lm3g30a+3ELm6x254AEL1D1x1i0Co4L6wcyIEBxKAInGft8Q/iTC/lSTY4TLNJXwUcXfGtvpp18B2OzU6gGGiKDtdhGQW3/K1xx2/BFlnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fo+1stqKmr9xqHmh3WNVKMGft6gsHFjd6QG/HOazkjw=;
 b=jA6sjY+oMDQ7u1hBS+Yl1wFbpKioHTOSBRWrFGjlza7NiFmY+E1IWZXq0qzANR5FaN02gH0PRKmcXYaT5/X/0h7iqigSOuRm4Y3LwTCNlrKzaAGDndqsIpD1ibjP8YQUcBcJkJyO+jANlXDGC2Jv+QhD6WTGayia8rR2oj+4+BojU2+oHlo+iriNP/wPTN7YUxPyHfue6e62JgIEWHGo3usFF+kNow+YqecgXB6Rp+US65vPVlVXLXDnpThw2XDDMUxzuedpNBacSW5Vikap/ZB+bi7gKrZx2w1pEoD04NyTNPhWXV5SMZmcNue1mCzCsZlD1ITrpsJd2xT3s+4sIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=analog.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo+1stqKmr9xqHmh3WNVKMGft6gsHFjd6QG/HOazkjw=;
 b=gsML4gqDMZq8v3h6tPgPEWCd1VIEXoSdnyP2ObJXOnKBHe0QrKkaNw5vREf4KGc0DoPW7GTgK/c2A/3XfafZRW+xbQmBC9WHv3TWppy7fhw4iBa0SjwCGrunJOTbIvz4F72nTmT+SURIVeq84rtWwKjsw5wJArE5NjJjJEYj7MR/CJndMmzGM030MM6pHfpcVIbBLGo6nESsFCG4VgeGrOc4dv5ZdASAfPtDFrf16YRhyzpLr7YgGCTWWPNfR7SBKiLenP3vDJvgmSSz3vjDCBBP6JX1en09PEo+zhJ7vYiueAXJ+xikIiNgm8X8eeCpzF0VV9QYlbuoHo4d+UwMVQ==
Received: from BLAPR03CA0039.namprd03.prod.outlook.com (2603:10b6:208:32d::14)
 by SJ2PR18MB5660.namprd18.prod.outlook.com (2603:10b6:a03:563::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 09:38:17 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::3c) by BLAPR03CA0039.outlook.office365.com
 (2603:10b6:208:32d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Thu,
 11 Jun 2026 09:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Thu, 11 Jun 2026 09:38:16 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 2DBF14186B5B;
	Thu, 11 Jun 2026 02:35:43 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Thu, 11 Jun 2026 02:37:44 -0700
Subject: [PATCH v2 2/2] iio: adc: add Axiado SARADC driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-axiado-ax3000-ax3005-saradc-v2-2-913c9de7c64c@axiado.com>
References: <20260611-axiado-ax3000-ax3005-saradc-v2-0-913c9de7c64c@axiado.com>
In-Reply-To: <20260611-axiado-ax3000-ax3005-saradc-v2-0-913c9de7c64c@axiado.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781170695; l=9910;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=NF72uE+7ZGh3ABz5dozlMLicl+m0ViqKxaWUHa/Lp48=;
 b=MlityGgvsGJeo3ff+jJVN2beiZ77IWl70i27dtaA/Hqjd66eS/3bs8ldkmdyGOrKBdqE52CmF
 qv5XuzpzECzBUvMa45DMMcZnn2Qakvvi71C7IZ/dPAqXhv3HfRaAefI
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SJ2PR18MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 305a7c65-c8ae-4dcf-2236-08dec79d2a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|82310400026|36860700016|376014|1800799024|6133799003|18002099003|22082099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	GLL15KZyuKi6Zsld3aP6vaU/TY9J0wB4UWk3WSjHKCkaAptpcUucYC3rdavQKdySk0KcLEu9ohFDtI4xi0HUAWms/ABBqYD2lWdlSj6hXjdqUzqcz67g9fK+XvrPARxEoaZwzgTeNxc40oxFvxxxBVMaR8EBFnZsAOL8XRBJ0olWS+gNsbg+0IM83732l+7c5wGEZJZovRO8HHMceojjw/g1p6dcKwEcz12ZxrjqfHhudDj8ZNRdLsp62/Q7MBjSvZmZGmXYAJe7EVgQ7+2sSKJipY2n4y6zromjs9wID/uYxi2P29cXgJuF/RHIduU2F69GTpvjYoBESHhi2R7zKSgN+t1ckK9SY4/xUfxvEBHVoo6OHvg6QyR5RnzToqgLfKV+Huz17wXyR1YvvjqHxi/s96CS07AL9pNh6vPiQK1aX4pcy6NwQMNJHFJa7b8PhgFXlnwTknEZb30SX9kRJLRGZG+UosOHw+MZFvgXoDH+k42wwHaw+cOycYhp6snt5EQxRbsnnCHMf0wCCSLfWq49t0oqCK/VYVP59m+04VybFg+A64zpi+/lDDuk30csZ1N+spgAMvknw7gNwJ/9EyfFXHZyb/fbdpey7yd2HzjMsYOhOAz6blSCrW5T/xJFjTtMOY8MMUqMmfcc7TpBP0U4aLoJPaNqYCF9Mwr8TwREOw8B2WBB5PjhuM8hvuHmNb48nestMAx+1Ngf4Gpky83WwajbmOryAngyDMWSrQqqJXqOQLun2/+awomimZveT9HgX1TpJ/Z+VAuMy55JiQ==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(82310400026)(36860700016)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i0CHiLCCUWZLNlFT5kYMdfzuq95Gz80dC7MnV2+0PpGQD2QrKDD0SWvAsRRmi3er+k+LFHAyGz+ghR3/BVDb9oiOFIkLSQTnTlHmboMWCfzzRq4W6ldIGDXCLwXeb4Xqqw85DjO3xHu8LUCHt4ALKpUCUQzCfEVSmSzFPd3QfQklqdDu92ifMqno3cpJ2eQYzS7bBRPFYN6ekAvWOl2daTW6S7fcyqzecY8GY4COsfoFegf5gGqZE0ZjuLkTKA3XNMroBJ6CFTv0JBjEEedvU7bH2T0BCdeMLAKU85AOnZ4sesccbKlAmYbmf6HRkYiX4eLlhym6GDlXLftwgC9AT2LbFVfzSVF5Ycodnjq0V3RgmJSWw2SWD2iCdb1t6jO0N6tC0qj5iaiHzJFzE6LQ8zjgtKkVtaoZsmUGetg2l0zTPoz2cDCGF9hH3gqLCm5H
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:38:16.9574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 305a7c65-c8ae-4dcf-2236-08dec79d2a94
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR18MB5660

Add support for the SARADC controller found on Axiado AX3000 and
AX3005 SoCs.

The driver supports single-shot voltage reads through the IIO
subsystem. The number of available input channels is selected from
the SoC match data, allowing AX3000 and AX3005 variants to use the
same driver.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 MAINTAINERS                     |   1 +
 drivers/iio/adc/Kconfig         |  10 ++
 drivers/iio/adc/Makefile        |   1 +
 drivers/iio/adc/axiado_saradc.c | 244 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 256 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 932bba890780..e6dadfa65ee0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4318,6 +4318,7 @@ M:	Akhila Kavi <akavi@axiado.com>
 M:	Prasad Bolisetty <pbolisetty@axiado.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/axiado,ax3000-saradc.yaml
+F:	drivers/iio/adc/axiado_saradc.c
 
 AXIS ARTPEC ARM64 SoC SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb46..a9ba600a5f64 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -631,6 +631,16 @@ config AT91_SAMA5D2_ADC
 	  To compile this driver as a module, choose M here: the module will be
 	  called at91-sama5d2_adc.
 
+config AXIADO_SARADC
+	tristate "Axiado SARADC driver"
+	depends on ARCH_AXIADO || COMPILE_TEST
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
index 000000000000..d2f4071c932c
--- /dev/null
+++ b/drivers/iio/adc/axiado_saradc.c
@@ -0,0 +1,244 @@
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
+#include <linux/regulator/consumer.h>
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
+#define AX_SARADC_GLOBAL_CTRL_SAMPLE_16		\
+	FIELD_PREP(AX_SARADC_GLOBAL_CTRL_SAMPLE_MASK, 0)
+
+#define AX_SARADC_GLOBAL_CTRL_MODE_MANUAL	\
+	FIELD_PREP(AX_SARADC_GLOBAL_CTRL_MODE_MASK, 1)
+
+/* MANUAL_CTRL register fields */
+#define AX_SARADC_MANUAL_CTRL_ENABLE           BIT(0)
+#define AX_SARADC_MANUAL_CTRL_CH_SEL_MASK      GENMASK(4, 1)
+
+#define AX_SARADC_MANUAL_CTRL_EN(ch)           \
+	(AX_SARADC_MANUAL_CTRL_ENABLE |          \
+	 FIELD_PREP(AX_SARADC_MANUAL_CTRL_CH_SEL_MASK, ch))
+
+#define AX_RESOLUTION_BITS 10
+#define AX_SARADC_CONV_CYCLES 13
+#define AX_SARADC_CONV_DELAY_MARGIN_US 10
+
+struct axiado_saradc {
+	void __iomem *regs;
+	struct clk *clk;
+	unsigned long clk_rate;
+	int vref_uV;
+	struct mutex lock; /* Serializes ADC conversions. */
+};
+
+static int axiado_saradc_conversion(struct axiado_saradc *info,
+				    struct iio_chan_spec const *chan, int *val)
+{
+	unsigned long usecs;
+
+	guard(mutex)(&info->lock);
+
+	/* Select the channel to be used and trigger conversion */
+	writel(AX_SARADC_MANUAL_CTRL_EN(chan->channel),
+	       info->regs + AX_SARADC_MANUAL_CTRL_REG);
+
+	/* Hardware requires 13 conversion cycles at clk_rate */
+	usecs = DIV_ROUND_UP(AX_SARADC_CONV_CYCLES * USEC_PER_SEC,
+			     info->clk_rate);
+	fsleep(usecs + AX_SARADC_CONV_DELAY_MARGIN_US);
+
+	*val = readl(info->regs + AX_SARADC_DOUT_REG) &
+	       GENMASK(AX_RESOLUTION_BITS - 1, 0);
+
+	/* Stop manual conversion */
+	writel(0, info->regs + AX_SARADC_MANUAL_CTRL_REG);
+
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
+		return ret ? ret : IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = info->vref_uV / 1000;
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
+#define AX_SARADC_CH(_index, _id)                                       \
+	{                                                               \
+		.type = IIO_VOLTAGE,                                    \
+		.indexed = 1,                                           \
+		.channel = (_index),                                    \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),   \
+		.datasheet_name = (_id),                                \
+	}
+
+static const struct iio_chan_spec axiado_saradc_iio_channels[] = {
+	AX_SARADC_CH(0, "adc0"),   AX_SARADC_CH(1, "adc1"),
+	AX_SARADC_CH(2, "adc2"),   AX_SARADC_CH(3, "adc3"),
+	AX_SARADC_CH(4, "adc4"),   AX_SARADC_CH(5, "adc5"),
+	AX_SARADC_CH(6, "adc6"),   AX_SARADC_CH(7, "adc7"),
+	AX_SARADC_CH(8, "adc8"),   AX_SARADC_CH(9, "adc9"),
+	AX_SARADC_CH(10, "adc10"), AX_SARADC_CH(11, "adc11"),
+	AX_SARADC_CH(12, "adc12"), AX_SARADC_CH(13, "adc13"),
+	AX_SARADC_CH(14, "adc14"), AX_SARADC_CH(15, "adc15"),
+};
+
+static void axiado_saradc_disable(void *data)
+{
+	struct axiado_saradc *info = data;
+
+	writel(AX_SARADC_GLOBAL_CTRL_PD,
+	       info->regs + AX_SARADC_GLOBAL_CTRL_REG);
+}
+
+static int axiado_saradc_probe(struct platform_device *pdev)
+{
+	const struct axiado_saradc_soc_data *soc_data;
+	struct device *dev = &pdev->dev;
+	struct axiado_saradc *info;
+	struct iio_dev *indio_dev;
+	u32 regval;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	info = iio_priv(indio_dev);
+
+	info->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(info->regs))
+		return PTR_ERR(info->regs);
+
+	info->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(info->clk))
+		return PTR_ERR(info->clk);
+
+	info->clk_rate = clk_get_rate(info->clk);
+	if (!info->clk_rate)
+		return dev_err_probe(dev, -EINVAL, "invalid clock rate\n");
+
+	info->vref_uV = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (info->vref_uV < 0)
+		return dev_err_probe(dev, info->vref_uV,
+				     "failed to get vref voltage\n");
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
+			 GENMASK(soc_data->num_channels - 1, 0)) |
+	      AX_SARADC_GLOBAL_CTRL_SAMPLE_16 |
+	      AX_SARADC_GLOBAL_CTRL_MODE_MANUAL |
+	      AX_SARADC_GLOBAL_CTRL_ENABLE;
+
+	writel(AX_SARADC_GLOBAL_CTRL_PD,
+		  info->regs + AX_SARADC_GLOBAL_CTRL_REG);
+	writel(regval, info->regs + AX_SARADC_GLOBAL_CTRL_REG);
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
+
+module_platform_driver(axiado_saradc_driver);
+
+MODULE_AUTHOR("AXIADO CORPORATION");
+MODULE_DESCRIPTION("AXIADO SARADC driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

