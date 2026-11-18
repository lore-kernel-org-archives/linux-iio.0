Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795015094;
	b=1pLHuynBPweujj9PpmwFsovxap1WssM8mT/IOH59ItKK6b2I6+SHfPL0kGJdIK1/tqxe
	 73YulGWls8pGBjzLpUaXZjRkMT+AfwdW0LsS+VbQF9KXad1EwiXJZYPU68GJeeOybT1wA
	 bbmIWgpjkGW+5WMLyq/XXJMLKWcG6CHRUPezfaC8lpKKbz5VrTlr/6aS7jDdlXQikwkSu
	 dRUaO18LzSREz7xkISZ8dFTO1YZXSOog1uhhDB+4O/T7QtdOdqFFCaZyd4xbpV4cWogtJ
	 5zupJn7DAaVBkhY6QCb+3sO5qS7FfLWeqCBjnVk3aUGRjwUtjMXGO8E2y/QGZ+t8G+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015094;
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
	bh=CONcmZGf2zXM0ho/JUCxUJn3l6uAbeJCqgfAdtQqKW4=;
	b=EOUd99OPQc5IVnhvclTF36A2XJ5kHD4W61UVaha5pgjAFh418eFf3NDrjtEjgJEVj2ys
	 THnbmf5yex2uCuEpsv0Erg40jImQN1yUE6t7wPUV/ROXwObFNSRVTKMPNwtBVS3z1fDbl
	 YkhH7iaM1d4t2+GFaIEzaR2XcFe+a/JXv4wdrxAIj12rZ+DOtkeD1vF7icfm/tG5z83ZM
	 wyjSHeSnfRuqJL+dYFoScXr2w+XkzlHsf7azRKhCkp0L1E8HnzI/8vuk3Ehaq1UpsGltE
	 fSWd2qmNa60nzmVvcGgFdhpwYVGieOf9zsnxxmasJH2on1QTIDmzPC7BC/NOvEI9B/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=fxlSOIrK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.45
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013045.outbound.protection.outlook.com [52.101.83.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC01960A263D;
	Wed, 18 Nov 2026 15:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC01960A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=fxlSOIrK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTySDuzahRArVL2kr/EFSKU95+NDzcIHZ/mmhtFKkyHr/5inDcP1QIZ4AQZLGHUqsK6ZvF5LYY/SQj8wu5yiL4LOuedQRzgaRpLx5l4OtLS19zLRJSvlwLhv+JfaGgF3LPcW+tyB+L9fSizI5rtf7QlBuRfPjRRRM07gUvKtXLRlWSGkXnLOMMWbWi3/wMrROoOFYAYKwog/NhDCaN51Jb9LBSqb2EpFLXl1I/KgnnWzCLh0hCRtkAHVCk+vqeHPUxzLr1Z6B/lemoaoJle6CZY7MmR5to367OasgE6IXYegQ3QIKv0vf4rxa5ZtpzfA6+tMn1doZxs1tDCZ90Pjpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CONcmZGf2zXM0ho/JUCxUJn3l6uAbeJCqgfAdtQqKW4=;
 b=skX9L5rAdRnlV6L4Rst4Fq4lUN6PZBFoWfcQ/sFKKs5tmCJjkn8ZWQ6lOb3nsuyQKzPu8WELZq08IxSb9/OjdKdH2Fmanj7EVxxZP6pfXwSOShkZHN/JsZSdH4jXA12E0DuClTLqJ1fhC2Eoh6Cm+h+eaiMxwzc/JM6hGcet5Bhc77+GGorPSG/TFh6PANoDT5eNZCmdxdpopUJrPi9x2F3J0N7fHG0PzF7Is/KSqSHg9uIE/1OVPIu01vHg0enpqcKUnRQEsDtNFC8kzPpChexjEOe9O/ce2L7spDFurG8fL21/BKlaGqDAa+zA7prMjqxgRSmQFedzba/DfzgGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=amd.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CONcmZGf2zXM0ho/JUCxUJn3l6uAbeJCqgfAdtQqKW4=;
 b=fxlSOIrKe7bwkjhZTYd1KpVFhjM1t4A2JwtMZNXEciB4URQ/ojgvIQSUP5CMhbMxmQwTebVgOufKaW2NIzTTBnZTymv1wWYpvq3uy4tDscj9vE1BnSXoOG/tk5DI+I5f3PmkOsuiYLGkfM24+MUuGEklf+sDjOX5j977X6FEUhsvXcmYjX8zwHfU25p5MO07dYCmfTiQE7yKRvSIEjazWBXg6X1c/Qz4OQtJ7aJ3YcPvHfAJWvq3anU9srM4ubAnzj6HRWhy4rrwblnWlcAYCREEmlCWbfoE/yL6DlZlhS0gBU+AscDyydWS9SQxPULrPWhb0uqWtcWfYWHX4j2/bA==
Received: from DU6P191CA0005.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::18)
 by VI0PR10MB8763.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:239::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.6; Wed, 18 Nov
 2026 15:18:04 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::61) by DU6P191CA0005.outlook.office365.com
 (2603:10a6:10:540::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 15:18:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:18:01 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 18 Nov
 2026 16:18:46 +0100
Received: from localhost (10.252.16.78) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 18 Nov
 2026 16:18:00 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
Date: Wed, 18 Nov 2026 16:17:47 +0100
Subject: [PATCH v2 02/11] iio: adc: stm32-mdf: add core registration
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
Message-ID: <20261118-upstream_mdf_v2-v2-2-7939d3c3720a@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|VI0PR10MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: ef238bec-854c-46dd-face-08df458722c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|23010399003|376014|1800799024|22082099003|18002099003|6133799003|261009220027099003|261009221727099003|261009223327099003|261009223027099003|261009221227099003|921020|11063799006|261022115727099003|261028144727099003|261022075727099003|56012099006|261102130727099003|261026140227099003|261021121427099003|261022105027099003|261021135927099003|261021123027099003|261026121527099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	GX5Htj7aJ8HuMNZ//Hun3wDNSgjDLnwXDW0vUEXjxRNBCgEZky8MALU5ibcEEqvltQQPRJo4IAIh/wC2CXTjkB3ATwiYgsZZq1Pew8+ac063VUUoS4btgIgOzDnDUke0KWm8heufTsQItsngmceeCsB09jaYy0fWoEH+2Hc+sfzebEDvqxb8YAYi1BAF0wOEZDLobwja96z09WhOzq5M2IYbhRnvmC9NPendCkhRMbbT37MHJBPGqCzF+Kf0y/SmEoH1GbCtK4kIqzltpFzCDXbC4sFfTTlGu7mTW6d+Tz7BeFFjBIRsIN7eshybL3PmzgrWzvyOHX4E48/m6I0PVmzcsuJMgkw2eyzIsrFTL+DNdYtpAhv4kfs1nXV6367JTrWY3zB22G6nadKtJ2CyrhXKJufZQm+dPjI5xbYa2YUlhvttFp2xQI5JQf+g4lwGUcn0m3QwT8f0Zo0fv6f+2P7SJ1MW5ND3JrfMLP9chZlVYYZJvF7YjqUN0fUjfYrU7VbmLUOA8+r0V6jhe+NIa8JQuYZ0mNcATs4rJUtcrAToA84eotUzIcVqJ7GnOBacSYFY9wCFoeurWZr4xlBwNnouSIk3wFoIq3UQBBZDRoOmai1/7H3HDT2NLKoxJxTQRroj6qJ8xa33V+8zfSjpGNrR06lOUNYdptw2TzGqo/P/7aJAtMmjqo7x1v8yI5v6VTKoPgavPfn3CzkbAvG3vfHlspX/Zkjq905Qsnnf2vnQ3MTPDxGsqtwe9mVefcpr
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(261009220027099003)(261009221727099003)(261009223327099003)(261009223027099003)(261009221227099003)(921020)(11063799006)(261022115727099003)(261028144727099003)(261022075727099003)(56012099006)(261102130727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021135927099003)(261021123027099003)(261026121527099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jEAaxXAjn52cDz7+tTVTsig/Jo8jzoBFNcX9e7p9BDAse8Ds3jEr0e3stbR8AhIQ9irNRhLesPgIpVRHAWitTFy5rVz4Ng2hAn3RZ2A94xcSZm0lODiQMRA9RLLfCcencrPp87t2wp84vLZxg920TfMdy0Gbzby8tJ19hYn0+hu2D7MooOzmF1+wci+pGHUqzf5FUvED8Vjx/38ItwhU0CttEek65bqwS6xG/GfK+DZo/d6WMQeyhecFMR+skKyfxQBiKqKru60b97isztpAcTdVhP/H7mk6/vdsFHw5f89v9aVKGi2UFwZbJqJUTKKQXJE8OMqGq2bDn/1eMdJvIFJURNTe2+0/780Cpo3HXn6TzxGxqy+6uX6gDDYv/5yfFFP+Gfehvlp/LlYQtJG9WdgVb8Hn66UcWNMpMjZvFaw7g+Kkpkm0B9MaISGCsArk
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:18:01.4803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef238bec-854c-46dd-face-08df458722c2
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8763

The STM32 multifunction digital filter (MDF) shares its register bank,
kernel clock and power resources between serial interfaces and digital
filters. Add a core driver to manage these common resources on STM32MP2.

Check the number of filter actually supported from identification
registers.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/Kconfig          |  13 ++
 drivers/iio/adc/Makefile         |   2 +
 drivers/iio/adc/stm32-mdf-core.c | 471 +++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/stm32-mdf.h      | 221 ++++++++++++++++++
 4 files changed, 707 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1d6ed49041ab..6bd46c79d6d6 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1740,6 +1740,19 @@ config STM32_DFSDM_ADC
 	  This driver can also be built as a module.  If so, the module
 	  will be called stm32-dfsdm-adc.
 
+config STM32_MDF_CORE
+	tristate "STMicroelectronics STM32 MDF core"
+	depends on (ARCH_STM32 && OF) || COMPILE_TEST
+	depends on COMMON_CLK
+	select REGMAP
+	select REGMAP_MMIO
+	help
+	  Select this option to enable the driver for STMicroelectronics
+	  STM32 Multi-function Digital Filter for sigma delta converter.
+
+	  This driver can also be built as a module. If so, the module
+		  will be called stm32-mdf.
+
 config STMPE_ADC
 	tristate "STMicroelectronics STMPE ADC driver"
 	depends on OF && MFD_STMPE
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 769965295dcc..d5fc809c33ca 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -146,6 +146,8 @@ obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
 obj-$(CONFIG_STM32_ADC) += stm32-adc.o
 obj-$(CONFIG_STM32_DFSDM_ADC) += stm32-dfsdm-adc.o
 obj-$(CONFIG_STM32_DFSDM_CORE) += stm32-dfsdm-core.o
+obj-$(CONFIG_STM32_MDF_CORE) += stm32-mdf.o
+stm32-mdf-y := stm32-mdf-core.o
 obj-$(CONFIG_STMPE_ADC) += stmpe-adc.o
 obj-$(CONFIG_SUN20I_GPADC) += sun20i-gpadc-iio.o
 obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
diff --git a/drivers/iio/adc/stm32-mdf-core.c b/drivers/iio/adc/stm32-mdf-core.c
new file mode 100644
index 000000000000..ca50ce566a43
--- /dev/null
+++ b/drivers/iio/adc/stm32-mdf-core.c
@@ -0,0 +1,471 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * This file is part of STM32 MDF driver
+ *
+ * Copyright (C) 2023-2026, STMicroelectronics - All Rights Reserved
+ * Author: Olivier Moysan <olivier.moysan@foss.st.com>.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#include "stm32-mdf.h"
+
+static bool stm32_mdf_core_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MDF_GCR_REG:
+	case MDF_CKGCR_REG:
+	case MDF_HWCFGR_REG:
+	case MDF_VERR_REG:
+	case MDF_IPIDR_REG:
+	case MDF_SIDR_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool stm32_mdf_core_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/*
+	 * In MDF_CKGCR_REG register only CKGACTIVE bit is volatile. MDF_CKGCR_REG is not marked
+	 * as volatible to ease the suspend/resume case, and benefit from the regcache API.
+	 * Access to CKGACTIVE bit is managed specifically instead.
+	 */
+	return false;
+}
+
+static bool stm32_mdf_core_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MDF_GCR_REG:
+	case MDF_CKGCR_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config stm32_mdf_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = sizeof(u32),
+	.max_register = MDF_SIDR_REG,
+	.readable_reg = stm32_mdf_core_readable_reg,
+	.volatile_reg = stm32_mdf_core_volatile_reg,
+	.writeable_reg = stm32_mdf_core_writeable_reg,
+	.num_reg_defaults_raw = MDF_SIDR_REG / sizeof(u32) + 1,
+	.fast_io = true,
+	.cache_type = REGCACHE_FLAT,
+};
+
+/*
+ * struct stm32_mdf_priv - STM32 MDF private data
+ * @mdf: mdf common data
+ * @pdev: platform device pointer
+ * @regmap: regmap for register read/write
+ * @kclk: mdf kernel clock handle
+ * @base: mdf registers base cpu address
+ * @phys_base: mdf registers base physical address
+ * @n_active_ch: number of active channels
+ * @lock: lock to manage common resources
+ * @kclk_rate: save kclk rate at probe
+ * @exclusive_flg: exclusive rate request flag
+ */
+struct stm32_mdf_priv {
+	struct stm32_mdf mdf;
+	struct platform_device *pdev;
+	struct regmap *regmap;
+	struct clk *kclk;
+	void __iomem *base;
+	phys_addr_t phys_base;
+	atomic_t n_active_ch;
+	spinlock_t lock; /* Manage common resources race conditions */
+	unsigned long kclk_rate;
+	bool exclusive_flg;
+};
+
+#define STM32_MDF_MP23_FILTER_NB 4
+
+static inline struct stm32_mdf_priv *to_stm32_mdf_priv(struct stm32_mdf *mdf)
+{
+	return container_of(mdf, struct stm32_mdf_priv, mdf);
+}
+
+/**
+ * stm32_mdf_core_start_mdf() - Start the MDF clock generator
+ * @mdf: MDF instance
+ *
+ * Enable the MDF clocks on first active channel. The kernel clock
+ * rate is made exclusive while channels are active.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int stm32_mdf_core_start_mdf(struct stm32_mdf *mdf)
+{
+	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
+	struct device *dev = &priv->pdev->dev;
+	int ret;
+	u32 val;
+
+	if (atomic_inc_return(&priv->n_active_ch) == 1) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0)
+			goto err;
+
+		/* Enable PROCDIV and CCKDIV clock dividers */
+		ret = regmap_set_bits(priv->regmap, MDF_CKGCR_REG, MDF_CKG_CKGDEN);
+		if (ret < 0)
+			goto pm_put;
+
+		/* Check clock status. Bypass cache to access volatile CKGACTIVE active bit */
+		regcache_cache_bypass(priv->regmap, true);
+		regmap_read(priv->regmap, MDF_CKGCR_REG, &val);
+		regcache_cache_bypass(priv->regmap, false);
+		if (!(val & MDF_CKG_ACTIVE)) {
+			ret = -EINVAL;
+			dev_err(dev, "MDF clock not active\n");
+			goto pm_put;
+		}
+
+		if (!priv->exclusive_flg) {
+			clk_rate_exclusive_get(priv->kclk);
+			priv->exclusive_flg = true;
+		}
+	}
+
+	return 0;
+
+pm_put:
+	pm_runtime_put_sync(dev);
+err:
+	atomic_dec(&priv->n_active_ch);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_core_start_mdf);
+
+/**
+ * stm32_mdf_core_trigger() - Trigger MDF filters
+ * @mdf: MDF instance
+ *
+ * Trigger MDF filters via TRGO trigger.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int stm32_mdf_core_trigger(struct stm32_mdf *mdf)
+{
+	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
+	int ret;
+	u32 val;
+
+	guard(spinlock)(&priv->lock);
+
+	/* Bypass cache to access TRGO volatile bit */
+	regcache_cache_bypass(priv->regmap, true);
+
+	ret = regmap_read(priv->regmap, MDF_GCR_REG, &val);
+	if (ret < 0)
+		goto err;
+
+	if (val & MDF_GCR_TRGO) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	ret = regmap_set_bits(priv->regmap, MDF_GCR_REG, MDF_GCR_TRGO);
+
+err:
+	regcache_cache_bypass(priv->regmap, false);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_core_trigger);
+
+/**
+ * stm32_mdf_core_stop_mdf() - Stop an MDF channel
+ * @mdf: MDF instance
+ *
+ * Drop one active-channel reference. When the last channel stops, release the
+ * exclusive kernel clock rate and disable the MDF clock.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int stm32_mdf_core_stop_mdf(struct stm32_mdf *mdf)
+{
+	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
+	int ret = 0;
+
+	if (atomic_dec_and_test(&priv->n_active_ch)) {
+		if (priv->exclusive_flg) {
+			clk_rate_exclusive_put(priv->kclk);
+			priv->exclusive_flg = false;
+		}
+
+		ret = regmap_clear_bits(priv->regmap, MDF_CKGCR_REG, MDF_CKG_CKGDEN);
+
+		pm_runtime_put_sync(&priv->pdev->dev);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_core_stop_mdf);
+
+static int stm32_mdf_core_parse_clocks(struct platform_device *pdev, struct stm32_mdf_priv *priv)
+{
+	priv->kclk_rate = clk_get_rate(priv->kclk);
+
+	return 0;
+}
+
+static int stm32_mdf_core_parse_of(struct platform_device *pdev, struct stm32_mdf_priv *priv)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct reset_control *rst;
+	struct device *dev = &pdev->dev;
+	u32 count;
+	int ret;
+
+	if (!node)
+		return -EINVAL;
+
+	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset controller\n");
+
+	ret = reset_control_reset(rst);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to reset MDF\n");
+
+	ret = stm32_mdf_core_parse_clocks(pdev, priv);
+	if (ret < 0)
+		return ret;
+
+	if (device_property_present(&pdev->dev, "st,interleave")) {
+		ret = device_property_read_u32(dev, "st,interleave", &count);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to read interleaved filter count\n");
+
+		if (count < 2 || count > 8 || count > priv->mdf.nbf)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid interleaved filter count [%u]\n", count);
+
+		priv->mdf.nb_interleave = count;
+
+		/* Configure GCR */
+		ret = regmap_update_bits(priv->regmap, MDF_GCR_REG,
+					 MDF_GCR_ILVNB_MASK,
+					 FIELD_PREP(MDF_GCR_ILVNB_MASK, count - 1));
+	}
+
+	return ret;
+}
+
+static const struct of_device_id stm32_mdf_of_match[] = {
+	{ .compatible = "st,stm32mp23-mdf", .data = (void *)STM32_MDF_MP23_FILTER_NB },
+	{ .compatible = "st,stm32mp25-mdf" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, stm32_mdf_of_match);
+
+static int stm32_mdf_core_identification(struct platform_device *pdev, struct stm32_mdf_priv *priv)
+{
+	struct stm32_mdf *mdf = &priv->mdf;
+	u32 val;
+	int ret;
+
+	/* If filter number is explicitly defined, don't check identification registers */
+	mdf->nbf = ((unsigned long)device_get_match_data(&pdev->dev));
+	if (mdf->nbf)
+		return 0;
+
+	ret = regmap_read(priv->regmap, MDF_IPIDR_REG, &val);
+	if (ret)
+		return ret;
+
+	if (val == STM32MP25_MDF_IPIDR_NUMBER) {
+		ret = regmap_read(priv->regmap, MDF_HWCFGR_REG, &val);
+		if (ret)
+			return ret;
+
+		mdf->nbf = FIELD_GET(MDF_HWCFGR_NBF_MASK, val);
+
+		ret = regmap_read(priv->regmap, MDF_VERR_REG, &val);
+
+		dev_dbg(&pdev->dev, "MDF version: %lu.%lu\n", FIELD_GET(MDF_VERR_MAJREV_MASK, val),
+			FIELD_GET(MDF_VERR_MINREV_MASK, val));
+	} else {
+		dev_err(&pdev->dev, "Unexpected ID number: 0x%x\n", val);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int stm32_mdf_core_probe(struct platform_device *pdev)
+{
+	struct stm32_mdf_priv *priv;
+	struct resource *res;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->pdev = pdev;
+	spin_lock_init(&priv->lock);
+
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+	priv->phys_base = res->start;
+
+	priv->kclk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->kclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->kclk),
+				     "Failed to get kernel clock\n");
+	priv->mdf.kclk = priv->kclk;
+
+	priv->regmap = stm32_mdf_regmap_init(&pdev->dev, priv->kclk, priv->base,
+					     &stm32_mdf_regmap_cfg);
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->regmap),
+				     "Regmap init error\n");
+
+	ret = stm32_mdf_core_identification(pdev, priv);
+	if (ret < 0)
+		return ret;
+
+	ret = stm32_mdf_core_parse_of(pdev, priv);
+	if (ret < 0)
+		return ret;
+
+	INIT_LIST_HEAD(&priv->mdf.filter_list);
+
+	platform_set_drvdata(pdev, priv);
+
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+	if (ret)
+		goto pm_put;
+
+	pm_runtime_put(&pdev->dev);
+
+	return 0;
+
+pm_put:
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
+	return ret;
+}
+
+static void stm32_mdf_core_remove(struct platform_device *pdev)
+{
+	pm_runtime_get_sync(&pdev->dev);
+	of_platform_depopulate(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+}
+
+static int stm32_mdf_core_suspend(struct device *dev)
+{
+	struct stm32_mdf *mdf = dev_get_drvdata(dev);
+	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
+	int ret;
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
+
+	regcache_cache_only(priv->regmap, true);
+	regcache_mark_dirty(priv->regmap);
+
+	/* Balance regmap_mmio_attach_clk() clk_prepare() */
+	clk_unprepare(priv->kclk);
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int stm32_mdf_core_resume(struct device *dev)
+{
+	struct stm32_mdf *mdf = dev_get_drvdata(dev);
+	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
+	int ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret) {
+		dev_err(dev, "Failed to set pins default state: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare(priv->kclk);
+	if (ret) {
+		dev_err(dev, "Failed to prepare kernel clock: %d\n", ret);
+		goto err_clk;
+	}
+
+	regcache_cache_only(priv->regmap, false);
+	ret = regcache_sync(priv->regmap);
+	if (ret) {
+		dev_err(dev, "Failed to sync cache: %d\n", ret);
+		goto err_cache;
+	}
+
+	return pm_runtime_force_resume(dev);
+
+err_cache:
+	clk_unprepare(priv->kclk);
+err_clk:
+	pinctrl_pm_select_sleep_state(dev);
+
+	return ret;
+}
+
+static int stm32_mdf_core_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int stm32_mdf_core_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+
+static const struct dev_pm_ops stm32_mdf_core_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_mdf_core_suspend, stm32_mdf_core_resume)
+	SET_RUNTIME_PM_OPS(stm32_mdf_core_runtime_suspend, stm32_mdf_core_runtime_resume, NULL)
+};
+
+static struct platform_driver stm32_mdf_driver = {
+	.probe = stm32_mdf_core_probe,
+	.remove = stm32_mdf_core_remove,
+	.driver = {
+		.name = "stm32-mdf",
+		.of_match_table = stm32_mdf_of_match,
+		.pm = &stm32_mdf_core_pm_ops,
+	},
+};
+
+module_platform_driver(stm32_mdf_driver);
+
+MODULE_AUTHOR("Olivier Moysan <olivier.moysan@foss.st.com>");
+MODULE_DESCRIPTION("STMicroelectronics STM32 MDF driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/adc/stm32-mdf.h b/drivers/iio/adc/stm32-mdf.h
new file mode 100644
index 000000000000..b334769f8b17
--- /dev/null
+++ b/drivers/iio/adc/stm32-mdf.h
@@ -0,0 +1,221 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * This file is part of STM32 MDF driver
+ *
+ * Copyright (C) 2023, STMicroelectronics - All Rights Reserved
+ * Author: Olivier Moysan <olivier.moysan@foss.st.com>.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/regmap.h>
+
+/* Register definitions */
+#define MDF_GCR_REG 0x00
+#define MDF_CKGCR_REG 0x04
+#define MDF_HWCFGR_REG 0xff0
+#define MDF_VERR_REG 0xff4
+#define MDF_IPIDR_REG 0xff8
+#define MDF_SIDR_REG 0xffc
+
+/* Registers offsets relative to filter base address */
+#define MDF_BSMXCR_REG 0x00 /* 0x84 * x + offset */
+#define MDF_DFLTCR_REG 0x04
+#define MDF_DFLTCICR_REG 0x08
+#define MDF_DFLTRSFR_REG 0x0c
+#define MDF_DFLTINTR_REG 0x10
+#define MDF_OLDCR_REG 0x14
+#define MDF_OLDTHLR_REG 0x18
+#define MDF_OLDTHHR_REG 0x1c
+#define MDF_DLYCR_REG 0x20
+#define MDF_SCDCR_REG 0x24
+#define MDF_DFLTIER_REG 0x28
+#define MDF_DFLTISR_REG 0x2C
+#define MDF_OECCR_REG 0x30
+#define MDF_SNPSDR 0x64
+#define MDF_DFLTDR_REG 0x6c
+
+/* MDF_GCR: Global Control Register */
+#define MDF_GCR_TRGO BIT(0)
+#define MDF_GCR_ILVNB_MASK GENMASK(7, 4)
+
+/* MDF_CKGCR: Clock Generator Control Register */
+#define MDF_CKG_CKGDEN BIT(0)
+#define MDF_CKG_CCK0EN BIT(1)
+#define MDF_CKG_CCK1EN BIT(2)
+#define MDF_CKG_CKGMOD BIT(4)
+#define MDF_CKG_CCK0DIR BIT(5)
+#define MDF_CKG_CCK1DIR BIT(6)
+#define MDF_CKG_TRGSENS BIT(8)
+#define MDF_CKG_TRGSRC_MASK GENMASK(15, 12)
+#define MDF_CKG_CCKDIV_MASK GENMASK(19, 16)
+#define MDF_CKG_CCKDIV_MAX (FIELD_MAX(MDF_CKG_CCKDIV_MASK) + 1)
+#define MDF_CKG_PROCDIV_MASK GENMASK(30, 24)
+#define MDF_PROCDIV_MAX (FIELD_MAX(MDF_CKG_PROCDIV_MASK) + 1)
+#define MDF_CKG_ACTIVE BIT(31)
+
+/* MDF_OR: Option Register */
+#define MDF_OR_OPTION_MASK OPTION(31, 0)
+
+/* MDF_SITFCR: Serial Interface Control Register */
+#define MDF_SITFCR_SITFEN BIT(0)
+#define MDF_SITFCR_SCKSRC_MASK GENMASK(2, 1)
+#define MDF_SITFCR_SITFMOD_MASK GENMASK(5, 4)
+#define MDF_SITFCR_STH_MASK GENMASK(12, 8)
+#define MDF_SITFCR_ACTIVE BIT(31)
+
+/* MDF_BSMXCR: Bitstream Matrix Control Register */
+#define MDF_BSMXCR_BSSEL_MASK GENMASK(4, 0)
+#define MDF_BSMXCR_ACTIVE BIT(31)
+
+/* MDF_DFLTCR: Digital Filter Control Register */
+#define MDF_DFLTCR_DFLTEN BIT(0)
+#define MDF_DFLTCR_DMAEN BIT(1)
+#define MDF_DFLTCR_FTH BIT(2)
+#define MDF_DFLTCR_ACQMOD_MASK GENMASK(6, 4)
+#define MDF_DFLTCR_TRGSENS BIT(8)
+#define MDF_DFLTCR_TRGSRC_MASK GENMASK(15, 12)
+#define MDF_DFLTCR_SNPSFMT BIT(16)
+#define MDF_DFLTCR_NBDIS_MASK GENMASK(27, 20)
+#define MDF_DFLTCR_NBDIS_MAX FIELD_MAX(MDF_DFLTCR_NBDIS_MASK)
+#define MDF_DFLTCR_DFLTRUN BIT(30)
+#define MDF_DFLTCR_ACTIVE BIT(31)
+
+/* MDF_DFLTCICR: Digital Filter Configuration Register */
+#define MDF_DFLTCICR_DATSRC_MASK GENMASK(1, 0)
+#define MDF_DFLTCICR_CICMOD_MASK GENMASK(6, 4)
+#define MDF_DFLTCICR_MCICD_MASK GENMASK(16, 8)
+#define MDF_DFLTCICR_MCICD_MIN 2
+#define MDF_DFLTCICR_SCALE_MASK GENMASK(25, 20)
+
+/* MDF_DFLTRSFR: Reshape Filter Configuration Register */
+#define MDF_DFLTRSFR_RSFLTBYP BIT(0)
+#define MDF_DFLTRSFR_RSFLTD BIT(4)
+#define MDF_DFLTRSFR_HPFBYP BIT(7)
+#define MDF_DFLTRSFR_HPFC_MASK GENMASK(9, 8)
+
+/* MDF_DFLTINTR: Integrator Configuration Register */
+#define MDF_DFLTINTR_INTDIV_MASK GENMASK(1, 0)
+#define MDF_DFLTINTR_INTVAL_MASK GENMASK(10, 4)
+
+/* MDF_OLDCR: Out-Of Limit Detector Control Register */
+#define MDF_OLDCR_OLDEN_MASK BIT(0)
+#define MDF_OLDCR_THINB_MASK BIT(1)
+#define MDF_OLDCR_BKOLD_MASK GENMASK(7, 4)
+#define MDF_OLDCR_ACICN_MASK GENMASK(13, 12)
+#define MDF_OLDCR_ACICD_MASK GENMASK(21, 17)
+#define MDF_OLDCR_ACTIVE_MASK BIT(31)
+
+/* MDF_OLDxTHLR: OLD Threshold Low Register */
+#define MDF_OLDTHLR_OLDTHL_MASK GENMASK(25, 0)
+
+/* MDF_OLDxTHHR: OLD Threshold High Register */
+#define MDF_OLDTHHR_OLDTHH_MASK GENMASK(25, 0)
+
+/* MDF_DLYCR: Delay control Register */
+#define MDF_DLYCR_SKPDLY_MASK GENMASK(6, 0)
+
+/* MDF_SCDCR: Short circuit detector control Register */
+#define MDF_SCDCR_CDEN_MASK BIT(0)
+#define MDF_SCDCR_BKSCD_MASK GENMASK(7, 4)
+#define MDF_SCDCR_SCDT_MASK GENMASK(19, 12)
+#define MDF_SCDCR_ACTIVE_MASK BIT(31)
+
+/* MDF_DFLTIER: DFLT Interrupt enable Register */
+#define MDF_DFLTIER_FTHIE_MASK BIT(0)
+#define MDF_DFLTIER_DOVRIE_MASK BIT(1)
+#define MDF_DFLTIER_SSDRIE_MASK BIT(2)
+#define MDF_DFLTIER_OLDIE_MASK BIT(4)
+#define MDF_DFLTIER_SSOVRIE_MASK BIT(7)
+#define MDF_DFLTIER_SCDIE_MASK BIT(8)
+#define MDF_DFLTIER_SATIE_MASK BIT(9)
+#define MDF_DFLTIER_CKABIE_MASK BIT(10)
+#define MDF_DFLTIER_RFOVRIE_MASK BIT(11)
+
+/* MDF_DFLTISR: DFLT Interrupt status Register */
+#define MDF_DFLTISR_FTHF_MASK BIT(0)
+#define MDF_DFLTISR_DOVRF_MASK BIT(1)
+#define MDF_DFLTISR_SSDRF_MASK BIT(2)
+#define MDF_DFLTISR_OLDF_MASK BIT(4)
+#define MDF_DFLTISR_SSOVRF_MASK BIT(7)
+#define MDF_DFLTISR_SCDF_MASK BIT(8)
+#define MDF_DFLTISR_SATF_MASK BIT(9)
+#define MDF_DFLTISR_CKABF_MASK BIT(10)
+#define MDF_DFLTISR_RFOVRF_MASK BIT(11)
+
+/* MDF_OECCR: Offset Error Compensation Control Register */
+#define MDF_OECCR_OFFSET_MASK GENMASK(25, 0)
+
+/* MDF_SNPSDR:  Snapshot Data Register */
+#define MDF_SNPSDR_MCICDC_MASK GENMASK(8, 0)
+#define MDF_SNPSDR_EXTSDR_MASK GENMASK(15, 9)
+#define MDF_SNPSDR_SDR_MASK GENMASK(31, 16)
+
+/* MDF_DFLTDR: Digital Filter Data Register */
+#define MDF_DFLTDR_DR_MASK GENMASK(31, 8)
+
+/* MDF_HWCFGR: Hardware configuration register */
+#define MDF_HWCFGR_FIFO_SIZE_MASK GENMASK(7, 0)
+#define MDF_HWCFGR_NBF_MASK GENMASK(15, 8)
+#define MDF_HWCFGR_FLT_CFG_MASK GENMASK(19, 16)
+#define MDF_HWCFGR_SAD_MASK GENMASK(23, 20)
+#define MDF_HWCFGR_OPTION_MASK GENMASK(31, 24)
+
+/* MDF_VERR: Version Register */
+#define MDF_VERR_MINREV_MASK GENMASK(3, 0)
+#define MDF_VERR_MAJREV_MASK GENMASK(7, 4)
+
+/* MDF_IPIDR: Identification Register */
+#define MDF_IPIDR_ID_MASK GENMASK(31, 0)
+
+/* MDF_SIDR: Size Identification Register */
+#define MDF_SIDR_SID_MASK GENMASK(31, 0)
+
+#define STM32MP25_MDF_IPIDR_NUMBER 0x00110032
+
+/*
+ * struct stm32_mdf - STM32 MDF driver common data (for all instances)
+ * @filter_list: pointer to filter interfaces list
+ * @kclk: kernel clock shared by the core and its children
+ * @fproc: processing clock frequency
+ * @nbf: total number of digital filters
+ * @nb_interleave: number of interleaved filters
+ */
+struct stm32_mdf {
+	struct list_head filter_list;
+	struct clk *kclk;
+	unsigned long fproc;
+	unsigned int nbf;
+	unsigned int nb_interleave;
+};
+
+static inline struct regmap *stm32_mdf_regmap_init(struct device *dev, struct clk *kclk,
+						   void __iomem *base,
+						   const struct regmap_config *config)
+{
+	struct regmap *map;
+	int ret;
+
+	/* Regcache initialization may read registers before the clock is attached. */
+	ret = clk_prepare_enable(kclk);
+	if (ret)
+		return ERR_PTR(ret);
+
+	map = devm_regmap_init_mmio(dev, base, config);
+	if (!IS_ERR(map)) {
+		ret = regmap_mmio_attach_clk(map, kclk);
+		if (ret)
+			map = ERR_PTR(ret);
+	}
+	clk_disable_unprepare(kclk);
+
+	return map;
+}
+
+int stm32_mdf_core_start_mdf(struct stm32_mdf *mdf);
+int stm32_mdf_core_stop_mdf(struct stm32_mdf *mdf);
+int stm32_mdf_core_trigger(struct stm32_mdf *mdf);
+int stm32_mdf_core_lock_kclk_rate(struct stm32_mdf *mdf);
+void stm32_mdf_core_unlock_kclk_rate(struct stm32_mdf *mdf);
+

-- 
2.43.0

