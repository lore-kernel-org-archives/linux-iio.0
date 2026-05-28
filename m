Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020099.outbound.protection.outlook.com [52.101.46.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3843D367B62;
	Thu, 28 May 2026 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955846; cv=fail; b=Nnrz8NchmgnfGak0StXrNF6qb5MUi33oM5lFTvgBFZAWQ2Y/srosnctjO1z3sXH24Fq0hns8WlgP9rQR2bVEgOu8ZtDJOgJHSWw6aG8Nb6V3fgVTRJeciGiBEERpGr3nLoK3VTnEk6zBf2NrFehM1ECdL6S31ImUC+dCFUiD3eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955846; c=relaxed/simple;
	bh=iPDi0+CYbyMhJQ2eE1zaFHFFViAcio930rW95DSl2ww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aCtrNg76bWOsa59qHA6zpx+s2WPIdfr+L+NaCt8KZBL/gsyPJphLaSpTtB0M0R56vY9KExxjBq0kO6XtoSVGjRa1H3MSkkV4tkRJfYAmgHmIBESLXTyZwiWFfxymgyaINyTmE499cUwcPVNNbwpZ6n/AD6yGGRuR6uduhR2T990=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=NLExQjsW; arc=fail smtp.client-ip=52.101.46.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="NLExQjsW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLg/AaMGs9Hmdjrl0PO38NJTh96Tx38xORyIC5DDSQNT5PuoGH7zXYQSk9WU/1IIO8NtBpFlZ3YvT+MRSXmhRml71lRBcsTGmUtpQj2gwFEcK+uPbkSoIQ+GJd+3W296VkS3gP1QIu71SBm3dXkVwXSvBRlS0inJdyOxPZire8l6HIBv7+ChxqrxnbDknJjnAnbYplCpMCszt0cDlvn7GweyoCzsJK2uGiAhkpirKAhE8uEkTxA2/2JZxuEi3caZIvgSIVA2G4Oxt3m3FoFi87bGJea3QFmnNwpQ6NQKyi/wgap1TuPFPGRE6NxInTvPVX96JK69CU5Ai8Aly2kwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kdgu1LLoG5+XdB4oNGRNaTWAQ1EF+6HHpbcsbLt6kL8=;
 b=qITmPxW7QTANpXHAEudkj1+uyirgQi/t7Ny35wertBCfymVoD3GzzrEhWxBgKmiKDEmS9ZD+HRngMvBxeZ8z1KoOItuGT7UFavF2ptdeqL+skzGC6S3gCxzU2oMnStubtfTx7usXgQu6vKr+1qA21obPJSvUTtMZzC/34TC9qB0v1VZpixXaBPVLpM0qOKM9tg4v9ymB/PJLg3v19GEtPzNqxk5HgvObW/oiRQRGdI8Txfaytj2YAh96N9mFNeL4Vm7Sn+LoSnUzwMVstjzlAC0v1ugm/ifeScuQgP1iSlkLY/0FFKKrBhLS85Dsp8RK8Qc2bv1zbPJ0wBf0fy6XZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=analog.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kdgu1LLoG5+XdB4oNGRNaTWAQ1EF+6HHpbcsbLt6kL8=;
 b=NLExQjsW3Ra7N487OvAYcRWTTbEIC+IxZTEj/GlswrSR39M2FI93jRySy9M78JQtlJbuAnEGeg8U6SUh54nqoWfAKGHfLQlpGGdy54/OKVtyRXoTiQrznxEyjpW/b6nguH12o0ja5RO8Go+5kcwYFlsQwNQamEsvUl19aVuXqtN1Hgih50W0J7uMJSBA3fVWx86j0BV4H45yKo6WKEdBWgXKgvCQ29LrTn67qiqa67UxvksvdkgDJevTxN+ubhRON3hFNsIz/JsY+Ff2/pTT4Rzb0omNmQd3tirf1rlKvq27sYmsSKHeAllDyYr2WeLSbVjWsH6jafy9MyPG1C7SXw==
Received: from SJ0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:33a::15)
 by IA3PR18MB6384.namprd18.prod.outlook.com (2603:10b6:208:533::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 08:10:37 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::52) by SJ0PR03CA0010.outlook.office365.com
 (2603:10b6:a03:33a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Thu, 28
 May 2026 08:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 08:10:36 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 8199C4186B5B;
	Thu, 28 May 2026 01:08:17 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Thu, 28 May 2026 01:10:24 -0700
Subject: [PATCH 2/3] iio: adc: add Axiado SARADC driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-axiado-ax3000-ax3005-saradc-v1-2-345dd5f6608a@axiado.com>
References: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
In-Reply-To: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779955836; l=8850;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=iPDi0+CYbyMhJQ2eE1zaFHFFViAcio930rW95DSl2ww=;
 b=4kqNjyU5bj99vB/dp6lmoRRwM0W9iex7P0i0PkzsTf9Wm15e7W8dxuHbQWmy6w5US5PQhRot8
 c1YoitIZZ3dAyTioqbNSJQCCDAvmD7wp4CBbHiJMX+S1j6Bcl55IT+j
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|IA3PR18MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: f26b98c8-d04f-43bd-c3ea-08debc909986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|56012099006|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	lqhYJ+kiD5bRrRORZuaHJlEn8l4VoCdlp0V3O430S8xGcE0vdlhYkXIvsGXCIizvOGTFwt1qxvhdiJZHgoV9ELm+HCdiqq0UVqz5F5tF3pcvUFkG0Nl45uecdjbITATAwt11o3v4wOHjOQgDbsIgo83w6zoZwX7EYwE+hrNTq1UAKe7F8LAxNjDndyBLQH9t6Pm+40vZqDfzPn4eVeKhzIgRbYdzPIITYOdRa/PP95Q5wlmlSVljEhHslUYtYr4pPCkjw09VQp6+k5Ef88JzaF4p9xbQjKFP1ET3SO7K5D7tg1bJnY8IIUWdBCo5sxjAu9RKTyh6YaoHNE8Wv+US/g8TyS+qNg04GcOQhbi4r0CKB4WXftwk96ph+23f1GgYxasfLuqw0uyq+S15OircIuG23GMSH42peH/a6mE2Qh2kuVLlHOkEjOw3ZqpS4e6Po+NH1/OjrvBewNWsigmN8YSL7EtY6cM3YlIw1YFRzDSictp64rQH3AZzDJ23B+y3kw18F1lIFgiqYy3Ysc3YfG9VMLyONL2O1QvU7Fr2Ss0JuCpoENu7swnDGExDRwe6HVSmXbNCMyqpy7+/lOPhd2fQH1vi5YarODdfOSoRcOsMkM2A3mscYdgfK13a8JcyIuUwCS5h2hCID5qLCEuAVLc0fNndbBQLX/Hs2fjwkRZdrlohP7wpl1/nqbz+Ua7Dg7SZdngW/Xu0n4B22db8I1yWyxaz5yohfJQazSHofmX8TkOhPsOMCl+Q1vP3d+UjhK/dWckDeXGgZ3weMZh5lg==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(56012099006)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EeG7AGReuqP9Bc2k7jsFUR2tEplaee5+zwHUNUBInWmg9J46PTw0wiye8O8I2qkH+9rv1kJf0JSp9IKrwqvMwO/DNgHWSQVYfVj/lokg4YNmXhIrsZE2aPsq2xroNgC0NikATFmQe3udHb1GPst3PMioormsqBj31l934MqAbrLfOQtSMzCQ7bko251SpGe5r562uBy3O1P6XJmTJoFEyrFX5rxtUaoSnBNWvcaWNHo/4DCDFbd+wDJ+fVXCmSlH62FszufpOV3ClTIYhyrTQOhyZaW/1aI48MUXZtJl5b5u8ej0QXBK0zz6i+Y5mXvfvqUNxfzyXqt+DUdzKVE4q2XLob0csenMi2ItvJKguNd9bA81SbjCHkxcD1KlFFfxs4a2HAzgYAMJzpBOCyEp/MBWCvzCVykMPrjIjRQ6RiHCfwXxk/uAtLGDZVJfvqjv
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:10:36.9780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f26b98c8-d04f-43bd-c3ea-08debc909986
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB6384

Add support for the SARADC controller found on Axiado AX3000 and
AX3005 SoCs.

The driver supports single-shot voltage reads through the IIO
subsystem. The number of available input channels is selected from
the SoC match data, allowing AX3000 and AX3005 variants to use the
same driver.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 drivers/iio/adc/Kconfig         |  11 ++
 drivers/iio/adc/Makefile        |   1 +
 drivers/iio/adc/axiado_saradc.c | 218 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb46..a35bba46beb0 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -631,6 +631,17 @@ config AT91_SAMA5D2_ADC
 	  To compile this driver as a module, choose M here: the module will be
 	  called at91-sama5d2_adc.
 
+config AXIADO_SARADC
+	tristate "Axiado SARADC driver"
+	depends on ARCH_AXIADO || COMPILE_TEST
+	depends on OF
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
index 000000000000..5ca711542a14
--- /dev/null
+++ b/drivers/iio/adc/axiado_saradc.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021-2026 Axiado Corporation
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+
+/* Register offsets */
+#define AX_SARADC_GLOBAL_CTRL 0x0004
+#define AX_SARADC_MANUAL_CTRL 0x0008
+#define AX_SARADC_DOUT 0x001C
+
+/* GLOBAL_CTRL fields */
+#define AX_SARADC_CH_EN_MASK GENMASK(31, 16)
+#define AX_SARADC_SAMPLE_MASK GENMASK(6, 5)
+#define AX_SARADC_MODE_MASK GENMASK(4, 3)
+#define AX_SARADC_PD BIT(2)
+#define AX_SARADC_ENABLE BIT(0)
+
+/* GLOBAL_CTRL values */
+#define AX_SARADC_SAMPLE_16 FIELD_PREP(AX_SARADC_SAMPLE_MASK, 0)
+#define AX_SARADC_MODE FIELD_PREP(AX_SARADC_MODE_MASK, 1)
+
+#define AX_SARADC_MANUAL_CTRL_EN(n) (BIT(0) | ((n) << 1))
+#define AX_RESOLUTION_BITS 10
+#define AX_SARADC_CONV_CYCLES 13
+
+struct axiado_saradc {
+	void __iomem *regs;
+	struct clk *clk;
+	unsigned long clk_rate;
+	int vref_uv;
+	struct mutex lock; /* Serializes ADC conversions. */
+};
+
+static int axiado_saradc_conversion(struct axiado_saradc *info,
+				    struct iio_chan_spec const *chan, int *val)
+{
+	unsigned long usecs;
+	/* Select the channel to be used and trigger conversion */
+	iowrite32(AX_SARADC_MANUAL_CTRL_EN(chan->channel),
+		  info->regs + AX_SARADC_MANUAL_CTRL);
+
+	/* Hardware requires 13 conversion cycles at clk_rate */
+	usecs = DIV_ROUND_UP(AX_SARADC_CONV_CYCLES * 1000000, info->clk_rate);
+	usleep_range(usecs, usecs + 10);
+
+	*val = ioread32(info->regs + AX_SARADC_DOUT) &
+	       GENMASK(AX_RESOLUTION_BITS - 1, 0);
+
+	/* Stop manual conversion */
+	iowrite32(0, info->regs + AX_SARADC_MANUAL_CTRL);
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
+		mutex_lock(&info->lock);
+		ret = axiado_saradc_conversion(info, chan, val);
+		mutex_unlock(&info->lock);
+		return ret ? ret : IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = info->vref_uv / 1000;
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
+	unsigned int num_channels;
+};
+
+static const struct axiado_saradc_soc_data ax3000_saradc_data = {
+	.num_channels = 16,
+};
+
+static const struct axiado_saradc_soc_data ax3005_saradc_data = {
+	.num_channels = 8,
+};
+
+#define AX_SARADC_CH(_index, _id)                                       \
+	{                                                               \
+		.type = IIO_VOLTAGE, .indexed = 1, .channel = (_index), \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),   \
+		.datasheet_name = (_id), .scan_index = -1,              \
+		.scan_type = {                                          \
+			.sign = 'u',                                    \
+			.realbits = AX_RESOLUTION_BITS,                 \
+			.storagebits = 16,                              \
+			.endianness = IIO_CPU,                          \
+		},                                                      \
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
+static int axiado_saradc_probe(struct platform_device *pdev)
+{
+	struct axiado_saradc *info;
+	const struct axiado_saradc_soc_data *soc_data;
+	struct iio_dev *indio_dev;
+	int ret;
+	u32 reg;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	info = iio_priv(indio_dev);
+
+	info->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(info->regs))
+		return PTR_ERR(info->regs);
+
+	info->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(info->clk))
+		return PTR_ERR(info->clk);
+
+	info->clk_rate = clk_get_rate(info->clk);
+	if (!info->clk_rate)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "invalid clock rate\n");
+
+	info->vref_uv = devm_regulator_get_enable_read_voltage(&pdev->dev,
+							       "vref");
+	if (info->vref_uv < 0)
+		return dev_err_probe(&pdev->dev, info->vref_uv,
+				     "failed to get vref voltage\n");
+
+	soc_data = device_get_match_data(&pdev->dev);
+	if (!soc_data)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "failed to get match data\n");
+
+	mutex_init(&info->lock);
+	reg = FIELD_PREP(AX_SARADC_CH_EN_MASK,
+			 GENMASK(soc_data->num_channels - 1, 0)) |
+	      AX_SARADC_SAMPLE_16 | AX_SARADC_MODE | AX_SARADC_ENABLE;
+
+	iowrite32(AX_SARADC_PD, info->regs + AX_SARADC_GLOBAL_CTRL);
+	iowrite32(reg, info->regs + AX_SARADC_GLOBAL_CTRL);
+
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &axiado_saradc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = axiado_saradc_iio_channels;
+	indio_dev->num_channels = soc_data->num_channels;
+
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register IIO device\n");
+
+	return 0;
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
+	{},
+};
+MODULE_DEVICE_TABLE(of, axiado_saradc_match);
+
+static struct platform_driver axiado_saradc_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
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

