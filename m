Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020086.outbound.protection.outlook.com [52.101.61.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9581437AA9C;
	Mon, 22 Jun 2026 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114465; cv=fail; b=V+FLEc9pRgprkxNMCFyjJ6dJcQJ6HoTdIxdAAQIM0UPaoIRSSUGeBSsgV1lN8EMdW8+WHN3ckhwvbupBkRQPUHAGuOHuXAALxkSbXF5TzMR81zjkIFzmd7joAQff5BYzhkMleyJ47r3Rwbt/UwhgWwSwowk3HenHyDu6QfmBHT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114465; c=relaxed/simple;
	bh=ob7UmcvWdjODcIVfADvv1oJTdUcpidx/+0/h3/jmwJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fp04O+tDSYM3aC30Ea0INgX4Zq5ofAHr2brlw+PI0h5HzbVSVNRfhlPRfZgfZ1+D5Tg59zzm0kH73BBVvnKTWMLKn0KYC3624ivjtfnaFNf3Dw69sd3VsVoVE1jJIsKqmYffzm+4ElJuBDmuPP3wwTTnWw0V4qszJVgNDlYmxWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=lEP8UW2q; arc=fail smtp.client-ip=52.101.61.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="lEP8UW2q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nL15VnundLpkrkjz0798blBcT/0B6/u7XnHGBbLvlA8Mj8gtj98eagGvyLdrd4sSc07ZiK1J7dYnke0l1LaywguBcH2JGYQ2Lu/uQKQt9j7EWmNjSM2fu9AkRjpGbBWfgOyljEg+eBuCz3Poi3pA4fwsgibUqMXd4SLYUuvWxeb0IIZd9yAvbox6NK2oHQBQye6Flq0+RUGY9HdDZdvB0Xhjcgjl9h543PmMPnT9Plu8MDwiDVuZIpvr3rLnNKh2ieN5x+/veSSm21fvurDWURYNv05FeMkvSY5BLUZGtMVp/Fex75Fe9g7ILrKSQDUL2aH7l+bfE1IbZjDmt4OuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRDEWcSOgK7JbfcuCAf7bIpcR9Bk9mRJ7je4veQugYs=;
 b=lq+fhYIgczqIbN6xOv0JDbu/7qs6jwpLMStTJf19QB/qX7FPJ0k+5drlY/XH46GFIKtR6EwaKo8t5lFgtSZYoALaICJb/IkG/v4wtjSLerOhTxftvIqpOgW6CjTQ0/ClaXIGuVMmxNvTdI/h6MT7S0ojqMdLr62e8tSXFOu8iuEKvFnYWiidSzNokWoMWs4sHgiAXhYehcq/dqJ4jQPfxsR1/QHyterx50ZydB/iWFdIsCldB0twa8W91xKUM/1xpO1xFcNagbREpgZppWQBkQGOB5sd0dQGhjKdCVy8UUDtMdoWIdh7Ev6+Z7txYGu/xRhcAuu8Rn+wrLV0PDGKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=analog.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRDEWcSOgK7JbfcuCAf7bIpcR9Bk9mRJ7je4veQugYs=;
 b=lEP8UW2qcy0piv+EcRNSOrRsiQd6eLsvza3GgAF19btB+UlcrGFFvv/TdyxP6uwClRFnfg7wEvs2/q4U2jgTYBVmt3NCuFO1u9tgYhnm++w61RXBDosI9rm2UBMpDDPKRy+krA6LKxduxGIgmwZHeiL4LVAp25p1DHxkhNLTRcyBtzjPzlRd+oQqVt5Sz8P/uidBYOIWoD/eT+xurj1mhKW3W5XvObEPT0oH98sJ6/rdbuYM7GFR/PnlbMK2oEyrc941Kh5Aegh22kQQoj7PLz9P0g+RCgyqD6AbjWRM4ZpSW4of2Nt7wEhp4C2JcEKytMdB1MxnXP9gSkjuqevipg==
Received: from CY8PR19CA0032.namprd19.prod.outlook.com (2603:10b6:930:6::23)
 by CO6PR18MB4451.namprd18.prod.outlook.com (2603:10b6:303:138::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 07:47:34 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:930:6:cafe::27) by CY8PR19CA0032.outlook.office365.com
 (2603:10b6:930:6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 07:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Mon, 22 Jun 2026 07:47:33 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id EBE054186B5B;
	Mon, 22 Jun 2026 00:44:48 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Mon, 22 Jun 2026 00:47:28 -0700
Subject: [PATCH v3 2/2] iio: adc: add Axiado SARADC driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-axiado-ax3000-ax3005-saradc-v3-2-e57c7c7ae675@axiado.com>
References: <20260622-axiado-ax3000-ax3005-saradc-v3-0-e57c7c7ae675@axiado.com>
In-Reply-To: <20260622-axiado-ax3000-ax3005-saradc-v3-0-e57c7c7ae675@axiado.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782114452; l=9920;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=ob7UmcvWdjODcIVfADvv1oJTdUcpidx/+0/h3/jmwJI=;
 b=Vz7EQYj6JeaB/YoTJI5dM2Xsyco/5DIH4SBsJq3YkPdnuncI1s4uzk/r7cHOgtH4lK4KxXptw
 cn0dcXQKnk9DjtBaWT+zx8QE3H2HAv6QKDvjoTddrFHoMgGfYhZSc3w
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|CO6PR18MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba9673c-6d81-4e51-f0ce-08ded032854b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|23010399003|1800799024|921020|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yCKltXDsTCIeuovyYDD9n1b6Yhx2iX94A7M5JWU3yDI751zt1yuTUaikHTagyx3wPGNFPGcdZvOrL3SLuuf3iXKRFCpiOrufxnvAIApbYY0BXFk1jKFynB89+tWYu11UD0F+heS8Jwif1XkVGKu2aASPl3SlB7qpRASxOHtU1qtxICoRNovTQ25kMSl7rTNteLB4MzsbOMOT4Xqo8COM2uhf7gSZvCmyTtYGM4c/13ZR06A0QpgnEl9XbGvCjo9CflNrd09q7ENvbDtCP6BZx+4Y7qxFvhVQ/2xj1cITt3X0TgwYyD8Denaornpictbqr1/mJtM0fzNEbtEMcgOHM1HG2R9iAXrQblCZdD/UrJA8XD5LtROHP/+JKYowIXl79OKIhQ1kx/waQHGAc4kJBJNzk2KniLAdUC0DuyGPOORLMqCztORwDlzB284YSE7ZYpFh2HsQwiCtVPwhVuAqjURNH6uktUaLHVFqn1R3TqS53BxJoNIgOAHvUiE6H8KQRq/mTWLj/lh+SAG9qCVMO8Si3wfeSz1jcAB9A2Xbhwhs22nq4TGgquMbEka6LjeLcCUHL5iKQw4ekwdK2IpWmkWqaLP682VzvbXfYlREHbdFrTCQFonlDWdWAgHI3k0ttgn7gpg73z5LD7aWSH8S+sfMS6aOMfR2dWAe646n1odO1jvKiuHWqTLF4DI2yD55+/b0G2R9OoZiA2F8uJCynGPcb3rAxECf4NH/Ku3tNR89QqabyMpr+Aw07Yw8D7S3
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(23010399003)(1800799024)(921020)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p7uiYp3S7an9rF2diMFAuPAB5so2qfM8bwZztQd/LML6rkOxGg3cZUTVAdZxgZBipk4rKkbHI6uNeLz5GSP4A3XIo08SYCKrSNW+UKMeKz48aItOjOcX1CfKTt5zk5y0uCmNGr1eCBxwovebk8St0QPhRcc7gJ7J2NJ5hSLlI2BU9jU+wliEcSsYnNrxKPsf9OFJ1vd4biCa6RgzqoQXybfxtfC955JhaPW6+hDPyh2va/FTf/CxqLZ9Rupue6fGGaAUY9cz7Gj+s9CiJCQ/qvZx/PbRnLhLIPBKC0kl+58x94868Lh/bsXNHW7gAh07zaoMuP4LqRwDwc3eZTvntuFQd6x/OnOj0GymcShFnYBvMLFUYnQ1UzOvi/70Pc6RCzETjiWNaJ3lhRScL03IUfvmI/11YbgsrlwkMkmjgF3sa5qXl1WPHj00Iq0AZ2Bq
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:47:33.3110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba9673c-6d81-4e51-f0ce-08ded032854b
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4451

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
 drivers/iio/adc/axiado_saradc.c | 245 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 257 insertions(+)

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
index 000000000000..12efe814318c
--- /dev/null
+++ b/drivers/iio/adc/axiado_saradc.c
@@ -0,0 +1,245 @@
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
+	void __iomem *regs;
+	struct clk *clk;
+	struct mutex lock; /* Serializes ADC conversions. */
+	unsigned long clk_rate;
+	int vref_uV;
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
+		     GENMASK(AX_RESOLUTION_BITS - 1, 0);
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
+	writel(AX_SARADC_GLOBAL_CTRL_PD, info->regs + AX_SARADC_GLOBAL_CTRL_REG);
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
+	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (ret < 0)
+		return dev_err_probe(dev, info->vref_uV,
+				     "failed to get vref voltage\n");
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
+	writel(AX_SARADC_GLOBAL_CTRL_PD, info->regs + AX_SARADC_GLOBAL_CTRL_REG);
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
+module_platform_driver(axiado_saradc_driver);
+
+MODULE_AUTHOR("AXIADO CORPORATION");
+MODULE_DESCRIPTION("AXIADO SARADC driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

