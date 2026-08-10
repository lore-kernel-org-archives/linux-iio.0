Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021103.outbound.protection.outlook.com [52.101.62.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D08415F2C;
	Mon, 10 Aug 2026 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373397; cv=fail; b=eQCxEWDCJKIDMTRvKftvTB4hH/zssBHpdcxZgnBXpEldqmaETz/5YK6zFHWIB09NREvAO2bvh0oep8q5mTz6bnw1sYEo3DibGCr1xEJkzt79Ooxt+l/gFyBhnyPpeT/6SmqSuwl8ZTorvWKTv66vY9M06AvB2tm5U3WGHAxEIv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373397; c=relaxed/simple;
	bh=q10xQewckkFzhyFbWUqmuq4rjdpDRGiqM4MDJsrTNKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eSMxD6egytxZalE5LIVyxYf118CyUrF05BltYaBCE7xzGdDydWyzMQKybq95ugVTPz61CQrkzHMQh7FIzHvpO2O5yKbJSXQdxP/OKhQaZGOi+93XxBdUw527FaUolxMY7eKhIBeyfQ9IlJUIFPMUrPtUX0cyAKiBmBRoFXGUkhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=Xclivr+B; arc=fail smtp.client-ip=52.101.62.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="Xclivr+B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8wl7AxSuqjBEbMLx/ZUvJZm7srk0I5g98AXKqXbyW6ANFj1Om2n+7rtEkNOpKfRbYXuYEBteSU3pRb7u7kJdkzyJjsTFaHPqBQHJggTCb7Crb9d4THbNBNw9DlNbwgcdIJkWWvT9Z63rPe8s6Q4n7+qjVssyIvc983yA4rY1Enh3lk00dKFrm0aEo2i4/4SCvYRR7MrfOSUSGouXuMiZwmSRInrClG1a04/8W3LLpQXSejA8Y6PG/IEJvfF0TL7SOknIT0YwTXtmh3NNvS9wB0wGtwQVS/w2wHQdNHijOH+6cr+mb7NjGluQqGEbJiLYMGDOzFNDnLFLhjpAIHsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2zs7GI5jAqT+hOA5NCl01lebziYzNK03BpttKrJ2FY=;
 b=UxnRb98mUDFOwk2iEKWUa0iVrQ9SXUdbrnEpJgOuu3iUhQmTSpmjg6plbMbmud0G+Hux35ixtU5UyE7Xz/NWws74FJE8qAUWENG28pC9leo56ANRmNeylyzwQIYVn+p3LRLgkkSOmc5Qwwg/bvCmQhAMl0VHCwcEApdn5o4X7JEQsOPTbN3OUxmeOLSNKRdrf1p2LIbzpHFXAY/+ljYUsBPWg0qf7rijfnkg1j5EB1yldv1fkqq0A/rn4duvMDQqHnOfBjnH/LgPzbebRj+FMvqzZKhckpyEUjKGD8caaFblE5oYnjlbWyp2K4T/8nPcGMJDqE03+cLnKA3MG18Pog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=analog.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2zs7GI5jAqT+hOA5NCl01lebziYzNK03BpttKrJ2FY=;
 b=Xclivr+BnM/4JuKTEpEgVBjHDifVPdT9uM70c3gblVwgFLwCSxf4UyO2LiezsKqGhKGYH265vSYp1so97mpL+zZUzfmTPvAtQR7dkqRPmSpDXq8wbB1+5KKHNtyA4zQ1zaugammYqxgOY+9TQpkM6Uwsyf0bt8XsffZtdMfEO8CM5/71hjR/rLfWOKG2e5anmFhH5+KT/N9wPbO8jGgPtl1kL0+M1moOcHu61WaPl5JatJJqzjpuYByxmUT4CdrX1iFdd8sRxyRMHoqK9nqB0+g3DurjJ9Y16KmTzlfUvOphzSqoSJQtMYRS95BYPvLBk86D2YQDcnp1uhdmiT4pxA==
Received: from CH5P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::27)
 by MN2PR18MB3654.namprd18.prod.outlook.com (2603:10b6:208:26e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 14:49:45 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::8) by CH5P221CA0002.outlook.office365.com
 (2603:10b6:610:1f2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 14:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Mon, 10 Aug 2026 14:49:45 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 93FA24186B59;
	Mon, 10 Aug 2026 07:49:44 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Mon, 10 Aug 2026 07:49:36 -0700
Subject: [PATCH v5 2/2] iio: adc: add Axiado SARADC driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-axiado-ax3000-ax3005-saradc-v5-2-bb0df3ecedaa@axiado.com>
References: <20260810-axiado-ax3000-ax3005-saradc-v5-0-bb0df3ecedaa@axiado.com>
In-Reply-To: <20260810-axiado-ax3000-ax3005-saradc-v5-0-bb0df3ecedaa@axiado.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786373384; l=10399;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=q10xQewckkFzhyFbWUqmuq4rjdpDRGiqM4MDJsrTNKs=;
 b=YHj2xnpGpFdtjxPomdhCvRzlBNPfyZe+zTtJG1tZ1jpNJc81Omnc2a7ul+igN/3J+FPPTuJIZ
 7Mn6hNZcKo5DnjJPtWh4h2peODsY0ugPRMFMhrLESgxm8D+G62ybezy
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|MN2PR18MB3654:EE_
X-MS-Office365-Filtering-Correlation-Id: b5089a1f-f5fc-44a6-12ae-08def6ee9e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|7416014|56012099006|10067099003|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	jkZsKXj/6Q9now9z/WcwvUyLs6sqsJN04mDYAiGlMpyzdcBEE2cRusOFJ6APoQrnOFvie8yL8rOBo+0C5GjefWTixoRblmiOOwHMyJSxruYKluRkyaujB3qfPKi5TuSXeskv4/IvTSXPVdVvmmxRW7fnNHyzT+YhqeucSwzmc4val7+ZWj++yRtJtLCwBa9JKN6AFM3+uKR5LjXqg0Q62Ba/zY5FZVSq0/OZ2vdnjXB91m5w4UMYmSG6ireaowcsa6bcWF1hqFnnFksR6VUjUKyO7pdmhb0v338eN7411G2TcDRoGDEjARyvB2q7qkOukcH0yUGiuYTutvCCQHGGCnLEnbDKoQf+HOXROJECbgwGJckOAZGsJ5clIfuWDAku2HynUjv96soQWGpbkbzkWKCAxiTlXqC1am6CMav3uDkHNw+PXxUWadpTSNF1vc0DjKLzQplmZbggOfDohUzSX6iimxgGpdU/D4eAmgwc0dir6ZrxNLhV+FQUNqZTw+2PRRmab/RrP6TpinBKn3Qau1PvA++dc7VLd1Fs+OC8aXMbhHePmMKfOJY8oMPx8vNZmqJ4Vc+Ih2E0SJplG6VCOFhHADi/jgef2EsF1qEt8lql9LKfh2XEkYXQY/jk5wzVAaOFRvcw/PUacLIuC+FWTOFSxYzoEOmPm7J43XgLFEx/mZcH16ZlaUOsgF2/Juy699SRRAPNAtH1gPRYdJI040ayvdJLEUh/wpFYi50AgVlRu704uoDjXRMj20u4qTS9
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(7416014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Fl3+T3Y08SQmrSBgSZ9OzWjx/Jw9SvBX+oUdmqlO1s3PmdOPeml6uXjwFYKImjb0RzzIBlfnCpcE6GEfxycI0VnkGi4z0cvvPw4EZC6RRgZz3twQrq+2b+UHEqtS1SZtQ3NLp6daWPPMV1bbewpwnZu86Wc7f4DhATmBNdDIRKVpJ2dE+hpCkAf/Z6S600zI3tev11Tu7MLz6fvNXMusiNJEFJ0hXknetSbfIu97qndFyWKDlh7cCCqIKoV1eHcfsPsRzuKAhQFEJ5h9IIrMuvVcgTg02v/6CGK3gpmySAxY8eamXNf3rCobUA8nTVcWUUbtmHyquQrE7C1ph2F/n+NAXvcDXM1pMCrTLJqTitS2tQLjpn9offEfm53rAOfE+hdJQIxgIz7cYdH/e0u/ZjQMk2zXPgP3P3BadrimdOzktjBpckPN4D/8H+9tQWGP
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 14:49:45.2732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5089a1f-f5fc-44a6-12ae-08def6ee9e8c
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3654

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
 drivers/iio/adc/axiado_saradc.c | 278 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 291 insertions(+)

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
index 000000000000..daa98dd2f176
--- /dev/null
+++ b/drivers/iio/adc/axiado_saradc.c
@@ -0,0 +1,278 @@
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
+/* GLOBAL_CTRL SAMPLE_MASK field value: 0 selects 16 samples */
+#define AX_SARADC_GLOBAL_CTRL_SAMPLE_16	0
+
+/* GLOBAL_CTRL MODE_MASK field value: 1 selects manual mode */
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
+	/* Select the channel to be used and trigger conversion */
+	ret = regmap_write(info->regmap, AX_SARADC_MANUAL_CTRL_REG,
+			   AX_SARADC_MANUAL_CTRL_ENABLE |
+			   FIELD_PREP(AX_SARADC_MANUAL_CTRL_CH_SEL_MASK, chan->channel));
+	if (ret)
+		return ret;
+
+	/* Hardware requires 13 conversion cycles at clk_rate */
+	usecs = DIV_ROUND_UP(AX_SARADC_CONV_CYCLES * USEC_PER_SEC,
+			     info->clk_rate);
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
+		return dev_err_probe(dev, -EINVAL, "failed to get match data\n");
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

