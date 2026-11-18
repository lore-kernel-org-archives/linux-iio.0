Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795015098;
	b=figYo+7sLahcaEI4cTwWFMUesUAxJ5dd4IdeZqSOs3qznLLRXoWXHTLIRBvSy/CKjfEs
	 pBmiu2B0AHdMSP99pWGlnQRgGggnavrbuZhzor5/ln6juPg/Ywz572X6Hf8tAEwvoBlOH
	 VCThTfxUp+axep1Wntst2O861NaKoxybum9NA+jVM7DJrQO578e/gBf+pJ5GJ1mCzK7yJ
	 qxUZrjep8PvUTHMoQlyK3NBzyBSkgs2+TRFHqUhCZORodXle4TjF08ehqd2U7muzpomzn
	 y9xRB4TQ4gekJNHDDXxFzVz9GPsWShqS3rrKzuy9viusXmDB0EtwthOu99QyrnjBf1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015098;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
	 X-Mailer:X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ILpInYYNNkM15GXnyUPiLy9ZIZRAMJlyQdRTpqWthFI=;
	b=NIWjfRI4CBBiDmFbsoePjqbem2NnJ+eJJNpSOHOg4VJYQPxPDmaK8jB+pyupL6d3GVgL
	 VYCXY+VLgWboGeWhR83auToZpQqHvsLRGbA0Mz174Jl2wLIy976zsACb7WsVppVlFDfni
	 ndws7W6aewARbjIsVwaycyKagfmP6ZWG9aePIXCga9sZxM387VigpTLiLjQk1Q58kvor6
	 8nRrilNnmAVda37ooHK+sioaHOW9nC4TEmpZSe3H7pNvrT3gKItoYNoN0LZLr8qTZ2IUB
	 utBaHLxXKPAqOsFlbG1yiymU4xRunoV7CISwbr8tAysJQvSYhxJILWAsVifHSzXQjQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=HAWpnD3+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.17
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013017.outbound.protection.outlook.com [52.101.83.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239C60A2625;
	Wed, 18 Nov 2026 15:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D239C60A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=HAWpnD3+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w60XiHTsCmVhvDPEGrK29i5VtQaSiZ7pG6ja+PFtEnSbVkdayyif0TUhdhanJy4PnZlD7t82Vzai3gWy9xFpbgOzCTjDG/8h7TI+W7x/iXSaB0L/CvG6CEO1cyLj5jmLQdgHaFVYUKTrtzCdtA+BZPgWMMGOWTPT3rh4WnP/3iuZRXeleRfiqDdL7zrfkEGHo+Vd3jExzgwQvSJ09eClC7xX5ITWNkgarYMsNQPtI4h/2ymwk6A5hiq0wXoHtAWRktmxuIYa/oG64CnVAbiJz4tVpeb+oH0PYDcPt5J3NcNQBSq8SBtF7Y+QLfCsCmVu8K/fMBp9G2lUmkM5sNQCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILpInYYNNkM15GXnyUPiLy9ZIZRAMJlyQdRTpqWthFI=;
 b=xeMVjKBl5BsGLQxPH7Y9+Nioze/3Q2vQKTYjPEsccYLjYKMRDsseXpaLk7eYuf/6DIKOdxqdnB3xxZtimMO06+PARimsQIuJdPRO02KwAcTRvqisCiWP9mPJP/jDC6r1+IbXwf1ccHV92SA/ZNROf4zNhWeoL+QObZmw3qk6L4tJ0UtxTVF+ThpnZnexdrfbGBnK3+SZDQ/KqtzU8BWsDpHV6KFyOrBcYA1N66xWkAYUlCGRegFmNONIPDQ1b6kMsOhv1hMpYHUsiMqVjHBkBWhg0v2DftpIaNtj5SW2WoqVYoLJfasjEXEFz39xoYS57gs7j98zkHGUuHwzt/uScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=amd.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILpInYYNNkM15GXnyUPiLy9ZIZRAMJlyQdRTpqWthFI=;
 b=HAWpnD3++M6Y7d4/TvznzbHXiaFXDpN754KVR2NpDNnh3Jf2Hykq74xZuDMiqydAWf0THeyxiYqioRvj+QJ38i8CuvMiCeo4g6VUt+v/T+mQBMwc9sX7dIj8yBFIaCLRazicbw292Ff5aGIlX1UfgNsoxcPtLU0SPN+ZIuP9UGKdaNnfSJ38XwTKr4Cyt6dctJdwkEAg6y5vMzFvfFGGXk+PX/2e7PW9ZHXzkTFvUM2dPGmkkly8kwJtpNIg66XVaGi6qGl6KsweH6hkPkXIR74tLCyA8pWoTS5qppwmX/B6At0XwkoOw+p2vAi/hZpiX13asJjvKWI0VEbF5PgTWw==
Received: from DU6P191CA0009.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::9) by
 AM8PR10MB4098.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Wed, 18 Nov
 2026 15:18:14 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::71) by DU6P191CA0009.outlook.office365.com
 (2603:10a6:10:540::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 15:18:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:18:14 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 18 Nov
 2026 16:18:54 +0100
Received: from localhost (10.252.16.78) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 18 Nov
 2026 16:18:08 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
Date: Wed, 18 Nov 2026 16:17:56 +0100
Subject: [PATCH v2 11/11] ASoC: stm32: add mdf dai support
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261118-upstream_mdf_v2-v2-11-7939d3c3720a@foss.st.com>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
In-Reply-To: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"Sumit Semwal" <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>, Philipp Stanner <phasta@kernel.org>, "Arnaud
 Pouliquen" <arnaud.pouliquen@foss.st.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-sound@vger.kernel.org>, "Olivier
 Moysan" <olivier.moysan@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|AM8PR10MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a36ff1-6394-456f-8b40-08df45872a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|1800799024|82310400026|921020|10067099003|11063799006|56012099006|261026135527099003|261021121427099003|261021130227099003|261021135927099003|261021123027099003|261021133027099003|261022105027099003|261102123227099003|261009221227099003|261009223027099003|261022115727099003|261022075727099003|261026140227099003|261026121527099003|261026130827099003|261022113327099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	T/FsX16ZAVS0O/NbFlmd4gnTbBbpd4//+zEhmml4pmuy5yaQ7MyVFevPBGlBJz9bPSdZOPgrdPBKd+vXBOObKI08MWig3FQ1y6fJXhyJ1oALoMsE68W/QPeiQZUKFw0z/w9JvGvWl2E4PJJGKp3yQPLGP1/BZnZ8xcxsSXouQghroOCYn8bUBB9rdfTtxQSt9uxyEhBsvja/58LUFbD/rMHms7O63lmAYf9W/ep8ughFnCm3T2HpKpVhhZpOeLM9NwKC4E5FjzC8CB22+I+Y7KQO9+/Jv4q2aSEEaJXGVRK+7LiJTowy+wBAzIxqwiErOYsSoFRx8wrnYsIvoRBwABMTs/3wLsWc/dEV0jV8HKsmrLShN4AeeRquLr9ozyD8crMnxTKWKvOJfjH4RBYX/+Nd8WuYpX3zQ+6jXoOIXRk1YpwTp44FpzO+2pHYEdVfgPLOoVOR3eS/9YOE+8Q504+TnJKYQlXDbmHq7ufB7otPRO4ukmui/olEa8HBKD86hd/fCmPXELWtCfDXRYRR0rf4FxQ9b0oedpHSU/Rwsi0/K82AHhoxq1q/m7bKUoBZohZvAgqz7ocQa1RKTn1FO6kfgwYHLAqkAMDu+xuDj8wE4gG5P0hHbnbriaHctlm0hXxXfXZTAHYWBQWywbV9wVyS5/yR1ZGpLoo8a6zkQW34psrAunqfdPI6VqARQltTm7xVZOnhspsBT06HW5TK8I21Z/AC2o5vmj2oX4o/KGEXtc0glTryHVO0L3p+63lB
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(1800799024)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(261026135527099003)(261021121427099003)(261021130227099003)(261021135927099003)(261021123027099003)(261021133027099003)(261022105027099003)(261102123227099003)(261009221227099003)(261009223027099003)(261022115727099003)(261022075727099003)(261026140227099003)(261026121527099003)(261026130827099003)(261022113327099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zYmMoki7gzpXnKTjyjQR0zmb2TBHwg8FdKFUUusnEr2s8OSxfQlrgjtWxmuUmvbYnmk0lfVg9+0Azazmx/0RqVCjQDX/Dze0G8N504XiNWxc62+yGsjCJEqRD0IC27zyKiLE/6/AltYeTrdOtbZbUouJ/K5MpFKclldBAqu7f9fF8A9MdWV0fFQDyWlUEPqyd+hsoyodlU8dxQOObcKHfNO8mBeu0f7cWbhCXX+hXYlVsJAX3jzprlHmwXFVEIkoWcD/0VF/OPicyO5N7gu6WLUVoJKLmy9BYiXOTBtDw60401ZjDBlluGxgXgusrV7z/bIxunhT1TjVY947xfCHxLXByIZNoJbFLXwiE9a6OC0/DiDHjPPsKSmxskv+8sPkAUEa76e7AgWvznmtmghDw2BOirdw98K39pQA06xi95bLELzj4/1gm5hqxRJvExMV
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:18:14.5584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a36ff1-6394-456f-8b40-08df45872a8e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4098

Add driver to handle DAI interface for PDM microphones connected
to MDF STM32 IP.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 sound/soc/stm/Kconfig      |  15 ++
 sound/soc/stm/Makefile     |   3 +
 sound/soc/stm/stm32_amdf.c | 375 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 393 insertions(+)

diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
index 2753d6c2a826..6661b3a8e4f8 100644
--- a/sound/soc/stm/Kconfig
+++ b/sound/soc/stm/Kconfig
@@ -44,4 +44,19 @@ config SND_SOC_STM32_DFSDM
 	  Select this option to enable the STM32 Digital Filter
 	  for Sigma Delta Modulators (DFSDM) driver used
 	  in various STM32 series for digital microphone capture.
+
+config SND_SOC_STM32_MDF
+	tristate "SoC Audio support for STM32 MDF"
+	depends on ARCH_STM32 || COMPILE_TEST
+	depends on SND_SOC
+	depends on STM32_MDF_ADC
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+	select SND_SOC_DMIC
+	select IIO_BUFFER_CB
+	help
+	  Select this option to enable the STM32 Multi-function
+	  Digital Filter (MDF) driver used in STM32MP2 series for
+	  digital microphone capture.
+
+	  Module name is stm32_amdf when the driver is built as a module.
 endmenu
diff --git a/sound/soc/stm/Makefile b/sound/soc/stm/Makefile
index 3372432faa09..4e1b3f943a44 100644
--- a/sound/soc/stm/Makefile
+++ b/sound/soc/stm/Makefile
@@ -16,3 +16,6 @@ obj-$(CONFIG_SND_SOC_STM32_SPDIFRX) += snd-soc-stm32-spdifrx.o
 
 #DFSDM
 obj-$(CONFIG_SND_SOC_STM32_DFSDM) += stm32_adfsdm.o
+
+#MDF
+obj-$(CONFIG_SND_SOC_STM32_MDF) += stm32_amdf.o
diff --git a/sound/soc/stm/stm32_amdf.c b/sound/soc/stm/stm32_amdf.c
new file mode 100644
index 000000000000..a733a7a2997f
--- /dev/null
+++ b/sound/soc/stm/stm32_amdf.c
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * This file is part of STM32 MDF ASoC DAI driver
+ *
+ * Copyright (C) 2023, STMicroelectronics.
+ * Author: Olivier Moysan <olivier.moysan@foss.st.com>.
+ */
+
+#include <linux/clk.h>
+#include <linux/iio/adc/stm32-mdf-adc.h>
+#include <linux/iio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+#include <sound/pcm.h>
+#include <sound/soc.h>
+
+#define STM32_AMDF_DRV_NAME "stm32-amdf"
+
+#define MDF_MAX_PERIOD_SIZE	(PAGE_SIZE / 2)
+#define MDF_MAX_PERIODS	6
+
+struct stm32_amdf_priv {
+	struct snd_soc_dai_driver dai_drv;
+	struct snd_pcm_substream *substream;
+	struct device *dev;
+
+	/* IIO */
+	struct iio_channel *iio_ch;
+	struct iio_cb_buffer *iio_cb;
+	bool iio_active;
+
+	/* PCM buffer */
+	unsigned char *pcm_buff;
+	unsigned int pos;
+
+	struct mutex lock; /* protect against race condition on iio state */
+};
+
+static const struct snd_pcm_hardware stm32_amdf_pcm_hw = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_PAUSE,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
+
+	.channels_min = 1,
+	.channels_max = 1,
+
+	.periods_min = 2,
+	.periods_max = MDF_MAX_PERIODS,
+
+	.period_bytes_max = MDF_MAX_PERIOD_SIZE,
+	.buffer_bytes_max = MDF_MAX_PERIODS * MDF_MAX_PERIOD_SIZE
+};
+
+static void stm32_amdf_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct stm32_amdf_priv *priv = snd_soc_dai_get_drvdata(dai);
+
+	mutex_lock(&priv->lock);
+	if (priv->iio_active) {
+		iio_channel_stop_all_cb(priv->iio_cb);
+		priv->iio_active = false;
+	}
+	mutex_unlock(&priv->lock);
+}
+
+static int stm32_amdf_dai_prepare(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	struct stm32_amdf_priv *priv = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	mutex_lock(&priv->lock);
+	if (priv->iio_active) {
+		iio_channel_stop_all_cb(priv->iio_cb);
+		priv->iio_active = false;
+	}
+
+	ret = iio_write_channel_attribute(priv->iio_ch,
+					  substream->runtime->rate, 0,
+					  IIO_CHAN_INFO_SAMP_FREQ);
+	if (ret < 0) {
+		dev_err(dai->dev, "%s: Failed to set %d sampling rate\n",
+			__func__, substream->runtime->rate);
+		goto out;
+	}
+
+	if (!priv->iio_active) {
+		ret = iio_channel_start_all_cb(priv->iio_cb);
+		if (!ret)
+			priv->iio_active = true;
+		else
+			dev_err(dai->dev, "%s: IIO channel start failed (%d)\n",
+				__func__, ret);
+	}
+
+out:
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static const struct snd_soc_dai_ops stm32_amdf_dai_ops = {
+	.shutdown = stm32_amdf_shutdown,
+	.prepare = stm32_amdf_dai_prepare,
+};
+
+static const struct snd_soc_dai_driver stm32_amdf_dai = {
+	.capture = {
+		    .channels_min = 1,
+		    .channels_max = 1,
+		    .formats = SNDRV_PCM_FMTBIT_S16_LE |
+			       SNDRV_PCM_FMTBIT_S32_LE,
+		    .rates = SNDRV_PCM_RATE_CONTINUOUS,
+		    .rate_min = 8000,
+		    .rate_max = 48000,
+		    },
+	.ops = &stm32_amdf_dai_ops,
+};
+
+static const struct snd_soc_component_driver stm32_amdf_dai_component = {
+	.name = "stm32_mdf_audio",
+};
+
+static void stm32_memcpy_32to16(void *dest, const void *src, size_t n)
+{
+	unsigned int i = 0;
+	u16 *d = (u16 *)dest, *s = (u16 *)src;
+
+	s++;
+	for (i = n >> 1; i > 0; i--) {
+		*d++ = *s++;
+		s++;
+	}
+}
+
+static int stm32_afsdm_pcm_cb(const void *data, size_t size, void *private)
+{
+	struct stm32_amdf_priv *priv = private;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(priv->substream);
+	u8 *pcm_buff = priv->pcm_buff;
+	u8 *src_buff = (u8 *)data;
+	unsigned int old_pos = priv->pos;
+	size_t buff_size = snd_pcm_lib_buffer_bytes(priv->substream);
+	size_t period_size = snd_pcm_lib_period_bytes(priv->substream);
+	size_t cur_size, src_size = size;
+	snd_pcm_format_t format = priv->substream->runtime->format;
+
+	if (format == SNDRV_PCM_FORMAT_S16_LE)
+		src_size >>= 1;
+	cur_size = src_size;
+
+	dev_dbg(rtd->dev, "%s: buff_add :%pK, pos = %d, size = %zu\n",
+		__func__, &pcm_buff[priv->pos], priv->pos, src_size);
+
+	if ((priv->pos + src_size) > buff_size) {
+		if (format == SNDRV_PCM_FORMAT_S16_LE)
+			stm32_memcpy_32to16(&pcm_buff[priv->pos], src_buff, buff_size - priv->pos);
+		else
+			memcpy(&pcm_buff[priv->pos], src_buff, buff_size - priv->pos);
+		cur_size -= buff_size - priv->pos;
+		priv->pos = 0;
+	}
+
+	if (format == SNDRV_PCM_FORMAT_S16_LE)
+		stm32_memcpy_32to16(&pcm_buff[priv->pos], &src_buff[src_size - cur_size], cur_size);
+	else
+		memcpy(&pcm_buff[priv->pos], &src_buff[src_size - cur_size], cur_size);
+
+	priv->pos = (priv->pos + cur_size) % buff_size;
+
+	if (cur_size != src_size || (old_pos && (old_pos % period_size < size)))
+		snd_pcm_period_elapsed(priv->substream);
+
+	return 0;
+}
+
+static int stm32_amdf_trigger(struct snd_soc_component *component,
+			      struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct stm32_amdf_priv *priv =
+		snd_soc_dai_get_drvdata(snd_soc_rtd_to_cpu(rtd, 0));
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		priv->pos = 0;
+		return stm32_mdf_get_buff_cb(priv->iio_ch->indio_dev, stm32_afsdm_pcm_cb, priv);
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_STOP:
+		return stm32_mdf_release_buff_cb(priv->iio_ch->indio_dev);
+	}
+
+	return -EINVAL;
+}
+
+static int stm32_amdf_pcm_open(struct snd_soc_component *component,
+			       struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct stm32_amdf_priv *priv = snd_soc_dai_get_drvdata(snd_soc_rtd_to_cpu(rtd, 0));
+	int ret;
+
+	ret =  snd_soc_set_runtime_hwparams(substream, &stm32_amdf_pcm_hw);
+	if (!ret)
+		priv->substream = substream;
+
+	return ret;
+}
+
+static int stm32_amdf_pcm_close(struct snd_soc_component *component,
+				struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct stm32_amdf_priv *priv =
+		snd_soc_dai_get_drvdata(snd_soc_rtd_to_cpu(rtd, 0));
+
+	priv->substream = NULL;
+
+	return 0;
+}
+
+static snd_pcm_uframes_t stm32_amdf_pcm_pointer(struct snd_soc_component *component,
+						struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct stm32_amdf_priv *priv =
+		snd_soc_dai_get_drvdata(snd_soc_rtd_to_cpu(rtd, 0));
+
+	return bytes_to_frames(substream->runtime, priv->pos);
+}
+
+static int stm32_amdf_pcm_hw_params(struct snd_soc_component *component,
+				    struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct stm32_amdf_priv *priv =
+		snd_soc_dai_get_drvdata(snd_soc_rtd_to_cpu(rtd, 0));
+
+	priv->pcm_buff = substream->runtime->dma_area;
+
+	return iio_channel_cb_set_buffer_watermark(priv->iio_cb,
+						   params_period_size(params));
+}
+
+static int stm32_amdf_pcm_new(struct snd_soc_component *component,
+			      struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_pcm *pcm = rtd->pcm;
+	struct stm32_amdf_priv *priv =
+		snd_soc_dai_get_drvdata(snd_soc_rtd_to_cpu(rtd, 0));
+	unsigned int size = MDF_MAX_PERIODS * MDF_MAX_PERIOD_SIZE;
+
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV,
+				       priv->dev, size, size);
+
+	return 0;
+}
+
+static int stm32_amdf_dummy_cb(const void *data, void *private)
+{
+	/*
+	 * This dummy callback is requested by iio_channel_get_all_cb() API,
+	 * but the stm32_mdf_get_buff_cb() API is used instead, to optimize
+	 * DMA transfers.
+	 */
+	return 0;
+}
+
+static void stm32_amdf_cleanup(void *data)
+{
+	iio_channel_release_all_cb(data);
+}
+
+static const struct snd_soc_component_driver stm32_amdf_soc_platform = {
+	.open		= stm32_amdf_pcm_open,
+	.close		= stm32_amdf_pcm_close,
+	.hw_params	= stm32_amdf_pcm_hw_params,
+	.trigger	= stm32_amdf_trigger,
+	.pointer	= stm32_amdf_pcm_pointer,
+	.pcm_new	= stm32_amdf_pcm_new,
+	.debugfs_prefix	= "pcm",
+};
+
+static const struct of_device_id stm32_amdf_of_match[] = {
+	{.compatible = "st,stm32mp25-mdf-dai"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, stm32_amdf_of_match);
+
+static int stm32_amdf_probe(struct platform_device *pdev)
+{
+	struct stm32_amdf_priv *priv;
+	unsigned int channels_max;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	priv->dai_drv = stm32_amdf_dai;
+	priv->dai_drv.name = dev_name(&pdev->dev);
+	mutex_init(&priv->lock);
+
+	dev_set_drvdata(&pdev->dev, priv);
+
+	/* Associate iio channel */
+	priv->iio_ch  = devm_iio_channel_get_all(&pdev->dev);
+	if (IS_ERR(priv->iio_ch)) {
+		dev_err(&pdev->dev, "Failed to get IIO channels %ld\n", PTR_ERR(priv->iio_ch));
+		return PTR_ERR(priv->iio_ch);
+	}
+
+	priv->iio_cb = iio_channel_get_all_cb(&pdev->dev, &stm32_amdf_dummy_cb, NULL);
+	if (IS_ERR(priv->iio_cb)) {
+		dev_err(&pdev->dev, "Failed to get IIO callbacks %ld\n", PTR_ERR(priv->iio_cb));
+		return PTR_ERR(priv->iio_cb);
+	}
+
+	ret = devm_add_action_or_reset(&pdev->dev, stm32_amdf_cleanup, priv->iio_cb);
+	if (ret < 0)  {
+		dev_err(&pdev->dev, "Unable to add action\n");
+		return ret;
+	}
+
+	channels_max = stm32_mdf_get_sub_channels_nb(priv->iio_ch->indio_dev);
+	priv->dai_drv.capture.channels_max = channels_max;
+
+	ret = devm_snd_soc_register_component(&pdev->dev, &stm32_amdf_dai_component,
+					      &priv->dai_drv, 1);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register %s\n", stm32_amdf_dai_component.name);
+		return ret;
+	}
+
+	ret = devm_snd_soc_register_component(&pdev->dev, &stm32_amdf_soc_platform,
+					      NULL, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register PCM platform\n");
+		return ret;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+
+	return ret;
+}
+
+static void stm32_amdf_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+}
+
+static struct platform_driver stm32_amdf_driver = {
+	.driver = {
+		   .name = STM32_AMDF_DRV_NAME,
+		   .of_match_table = stm32_amdf_of_match,
+		   },
+	.probe = stm32_amdf_probe,
+	.remove = stm32_amdf_remove,
+};
+
+module_platform_driver(stm32_amdf_driver);
+
+MODULE_DESCRIPTION("stm32 MDF DAI driver");
+MODULE_AUTHOR("Olivier Moysan <olivier.moysan@foss.st.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");

-- 
2.43.0

