Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0052D2B7;
	Thu,  1 Oct 2026 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866677; cv=fail; b=gCpS5GZZ+HE0KNvrq56hwcbfcJSt2WpJv18VL+yRZwwK5e2MbEDXfNTycov5Y3jF21QmbYNzQ8VPtNB0XqzAtMze+qv2Q1OujJF1C4mE/XERzlPuvygF5IM95ykF6T5KbWCZftpP0uXV5AYpCbi7+lEoc9AaftV7bTBI4zg8fSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866677; c=relaxed/simple;
	bh=Eq5DLtdN8C8rJiUzhoGFshZNukvgowkw4WT+SVsHYPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7D2ihx5cPWc3qflFqHYoiM4waRjh8w2gmpT1wRhIMTw1TNVO68R3WkoV/iH//l7GVwHBeADABgQP0WosofFPoknJTPRlpbH42GMsmluGSrT7nDnAOhnkRDvXZSf/zTg1jlF9eZZMVfL0CXGtR9L6cRa4ZxEpeNspdxXLzaaBAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ZZJAEFmL; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ZZJAEFmL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVDMlxOiELipkMtdXZyECrfeehhfPfvQesWtfre2/+ITIzBFtnV4lpOQUmfVSJLV82blfZffHgc6IrRh7CF5XSu4i80nbh+Dmdj+TIqahY8yNvTo1IhsSbqPRCFPQ7cx2j1xnseF9W39+hTVUESTi5PW9kdM7PoVAt1tHaUqjOcviYiZmYa8nj010MO7F2BYaaDFd9M4d6o1E1oH8f2+sGJvxO8ID2or1SQOuLkli9+H6vbfqlXSIneXfoUg+V5JnJdZ1oM7qWC9rt8heHgUa0Y7DT+gRIGjiYnHucneSp4WNmZ+gcfH2TnWh8j9ohEng3uejBwQuvjtdRiqAA/Ang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2M62UhGDj9w+Q1yT8H8wxc/5fUU61uMd/S5yygAiB1M=;
 b=UeWKvmyWQKkc2L4Ht1pSEbwqO1GNeywFrgyn5a45rTWzGl/0GwwtLbg1qMPdXFasbntuL1ZKIIZ5xjxcIZrr9hz62Q3rpxMtlj9AniSM3b5FW4EcgviTdp/smvtFUu+dD/9alVdnc3ri9xUD8JuftXonjy0z6GaMD+unrk6SmBQcAG7QX+z8Z2vJa9bm5H1RlU2jLw95vVam+Z4MLYj1+VfqYemNXBTa4c1Iz2U1rvK+xCW24J6cpbxtquENz3CGtQdr6xg+mKDNA4XBRps27xM047vQcW0MD93oLWCqaqAZjV4EQYLZNDG9v42OWIx05IQK0KWsVd/dNsNc4BiB2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M62UhGDj9w+Q1yT8H8wxc/5fUU61uMd/S5yygAiB1M=;
 b=ZZJAEFmLGr11qy8aNBRr1l0Uwv0fNe3RIvlnslROt0mzuYmTBI0nbaUl8YtXBpibmjMir+M+k4zallrf28OUriQJaE5a17tlWAwlYzlivLb1sFeHjRUGflv9Spn1UCzGkGn+RZrkY+ZfRSfFBuLJIyjHuUomUWpQxrbIPj3JzIode/G/t5U9zujr94/8I3M5mzc/sXWtZskM0ZY3ayXcrvw8p5mgQnjfkF+e6JmGDtmyq0QuscHs5kTBpA1UoxqqQ+OgaskicOTiASK+5IfQZPUBB5twq1oHf5BnUZ6rEmiIKZrY+pnKga8QiQkCd0gilKSNPyAs9zoAk+UUQXEUFA==
Received: from PR3PR09CA0019.eurprd09.prod.outlook.com (2603:10a6:102:b7::24)
 by AS1PR10MB5578.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:476::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 14:57:40 +0000
Received: from ZR1PEPF0000E463.eurprd04.prod.outlook.com
 (2603:10a6:102:b7:cafe::35) by PR3PR09CA0019.outlook.office365.com
 (2603:10a6:102:b7::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 14:57:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 ZR1PEPF0000E463.mail.protection.outlook.com (10.167.241.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 14:57:40 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 1 Oct
 2026 17:03:34 +0200
Received: from localhost (10.48.87.64) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 1 Oct
 2026 16:57:39 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Sumit Semwal
	<sumit.semwal@linaro.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: Olivier Moysan <olivier.moysan@foss.st.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-media@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>
Subject: [PATCH 2/3] iio: adc: add stm32 mdf support
Date: Thu, 1 Oct 2026 16:56:46 +0200
Message-ID: <20261001145702.2628429-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E463:EE_|AS1PR10MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c470cfd-7c1b-4d95-2f14-08df1fcc56e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|7416014|1800799024|36860700016|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003|18092099006;
X-Microsoft-Antispam-Message-Info:
	b8lRAc+22SlXe+QVNjt4Mw/jdXD2WWchcHu12iJlfWqar+YCkFmW5/X0Hj9DdLUgMU/N5aL/uxmaVCRTaFfgQw0KWydddG/3JzrEOhWBGNvc1NkItSw+iNMpll45IY4LYwsS2Z7JFOzWovQwujv7JfU0WIRXv1uqj0NYmKdBVzhTfvyMxTWHfg73L67sZvFzKdjVMbA/0wP/xUSbAMXKb9q+9TZ0fMvyOy/Ja9Bqhrx4TghMjH92/HBYMt5PkpebQf5Jy2RgxN519rnhs4pbOnxkiLQhWBhcYuErOpsrdD6Heey8vaTlYzLVeSgDBFl9UcpVUAJachlxR3Z89B5E325BH+BuJ0O45gZkL4N4H7ZX7Pplwf1o3H1KLZgk2vkFMwgAJ2kkI7N44C5mcYo7pz15qKpzP4g8c684pTBGdPoA9/dQ/Fm71lm04KK59v3VJTIUQbUkeCbSZNDEwM9+Z7Uo0vXTOn0K8+SaiZl0Dt6Y3Lo5GL47xR6kEtGJn3tXAolATBSf1BU+m8n2oSxQUCbrMrP48/1iJvFJ39uzsFwpsNfzBt7op4Ald7LltNOct524u1kWjTnQmnFqZ+qwqs+83i5jnZASLuVP5wnzpWaMkOHncP5VPftSyHxWmqw0/++jEiyIKZNxIZtSA9hJs4vKMqbR10nAKGol71vo94SrgZILR4yzJHV0VPcf8hTZF2khEgLXS6HJ4rYc/NJhCA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(7416014)(1800799024)(36860700016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(18092099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jKJibp+y5lZvx49+TPyjVTOk47HPd310ognegBOSETuwVls7DFohg23GlTC/lSBicf6hapr1z//lTmS/cd5FhNVdBHSPojo4NeTZZS8lzpvQarNa2YQ4aLNSyyUI72xJZdzNv4eD5k5slX8l3dgF8w9mpA72PrvZbW/8+T6vLGYx6t6Mb98bT9bQpVdMfoYVtmsF5cQFoXqngzO/2hklNiWAidmpJ486QwhG03V6QnS6nH4ozW8inpmEqZ7UadEE5GuKCmahrffnNOaui9IWXieGtOdy70Vo2dTElfUwbjvxxsCUqI24EQ+5JjEUcAh/EOyxugMRMxU8UkQDFhrk03HZotzXQJVm/HIVUzB3PAgICEfDuU+vcVQISZ1n4YrbNnm/s8t13mepo9EJStBlz5uB7ey65fzhsry11EFB5abnIGjp0OU+MzcAsYGg4YIX
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:57:40.0802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c470cfd-7c1b-4d95-2f14-08df1fcc56e4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E463.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5578

Add the STM32 Multi-function Digital Filter (MDF) core, serial interface
and digital filter drivers. The MDF converts bitstreams from sigma-delta
modulators or digital microphones into samples exposed through IIO.

Audio: capture PDM microphones via cyclic DMA for an ASoC consumer.
Support CIC scaling and filtering, synchronized and interleaving modes.
Audio use case requires a DMIC filter, and a separate ASoC DAI.

Analog: expose sigma-delta modulators as IIO voltage channels with
direct reads or DMA buffering mode. STM32 timer triggers can be used as
clock source.
Analog use case requires an IIO backend for the SD modulator.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/Kconfig               |   27 +
 drivers/iio/adc/Makefile              |    3 +
 drivers/iio/adc/stm32-mdf-adc.c       | 2078 +++++++++++++++++++++++++
 drivers/iio/adc/stm32-mdf-core.c      |  857 ++++++++++
 drivers/iio/adc/stm32-mdf-serial.c    |  309 ++++
 drivers/iio/adc/stm32-mdf.h           |  312 ++++
 include/linux/iio/adc/stm32-mdf-adc.h |   19 +
 7 files changed, 3605 insertions(+)
 create mode 100644 drivers/iio/adc/stm32-mdf-adc.c
 create mode 100644 drivers/iio/adc/stm32-mdf-core.c
 create mode 100644 drivers/iio/adc/stm32-mdf-serial.c
 create mode 100644 drivers/iio/adc/stm32-mdf.h
 create mode 100644 include/linux/iio/adc/stm32-mdf-adc.h

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 415e519ad4eb..917fd995711a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1656,6 +1656,33 @@ config STM32_DFSDM_ADC
 	  This driver can also be built as a module.  If so, the module
 	  will be called stm32-dfsdm-adc.
 
+config STM32_MDF_CORE
+	tristate "STMicroelectronics STM32 MDF core"
+	depends on (ARCH_STM32 && OF) || COMPILE_TEST
+	select REGMAP
+	select REGMAP_MMIO
+	help
+	  Select this option to enable the driver for STMicroelectronics
+	  STM32 Multi-function Digital Filter for sigma delta converter.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called stm32-mdf-core.
+
+config STM32_MDF_ADC
+	tristate "STMicroelectronics STM32 MDF adc"
+	depends on (ARCH_STM32 && OF) || COMPILE_TEST
+	select STM32_MDF_CORE
+	select COMMON_CLK_REGMAP
+	select IIO_BUFFER
+	select IIO_BUFFER_HW_CONSUMER
+	select IIO_BACKEND
+	help
+	  Select this option to support ADCSigma delta modulator for
+	  STMicroelectronics STM32 Multi-function digital filter.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called stm32-mdf-adc.
+
 config STMPE_ADC
 	tristate "STMicroelectronics STMPE ADC driver"
 	depends on OF && MFD_STMPE
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index dcec0abb03b7..ce36846156ab 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -141,6 +141,9 @@ obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
 obj-$(CONFIG_STM32_ADC) += stm32-adc.o
 obj-$(CONFIG_STM32_DFSDM_ADC) += stm32-dfsdm-adc.o
 obj-$(CONFIG_STM32_DFSDM_CORE) += stm32-dfsdm-core.o
+obj-$(CONFIG_STM32_MDF_ADC) += stm32-mdf-adc.o
+obj-$(CONFIG_STM32_MDF_CORE) += stm32-mdf-core.o
+obj-$(CONFIG_STM32_MDF_CORE) += stm32-mdf-serial.o
 obj-$(CONFIG_STMPE_ADC) += stmpe-adc.o
 obj-$(CONFIG_SUN20I_GPADC) += sun20i-gpadc-iio.o
 obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
diff --git a/drivers/iio/adc/stm32-mdf-adc.c b/drivers/iio/adc/stm32-mdf-adc.c
new file mode 100644
index 000000000000..74ac9b8c382d
--- /dev/null
+++ b/drivers/iio/adc/stm32-mdf-adc.c
@@ -0,0 +1,2078 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * This file is part of STM32 MDF driver
+ *
+ * Copyright (C) 2023, STMicroelectronics - All Rights Reserved
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/iio/adc/stm32-mdf-adc.h>
+#include <linux/iio/backend.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/hw-consumer.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/timer/stm32-lptim-trigger.h>
+#include <linux/iio/timer/stm32-timer-trigger.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "stm32-mdf.h"
+
+#define MDF_DMA_BUFFER_SIZE (4 * PAGE_SIZE)
+#define STM32_MDF_ITF_MAX 8
+#define STM32_MDF_DATA_RES 24
+#define STM32_MDF_HPF_BYPASS -1
+#define STM32_MDF_TIMEOUT_MS msecs_to_jiffies(100)
+/*
+ * Choose a default sampling ratio supported for all filter orders with RSFLT active.
+ * 32 is the maximum decimation ratio for filter order 5, with RSFLT active.
+ */
+#define MDF_DEFAULT_DECIM_RATIO 32
+
+#define MDF_IS_FILTER0(adc)			(!((adc)->fl_id))
+#define MDF_IS_INTERLEAVED_FILT(adc)		((adc)->interleaved)
+#define MDF_IS_INTERLEAVED_FILT_NOT_0(adc)	({ typeof(adc) x = (adc);\
+						MDF_IS_INTERLEAVED_FILT(x) && !MDF_IS_FILTER0(x); })
+
+#define STM32_MDF_ERR_SCK_FREQ BIT(1)
+#define STM32_MDF_ERR_MODE_RATIO BIT(2)
+#define STM32_MDF_ERR_DECIM_RATIO BIT(3)
+
+struct stm32_mdf_dev_data {
+	int type;
+	int (*init)(struct device *dev, struct iio_dev *indio_dev);
+};
+
+struct stm32_mdf_adc_chan {
+	const char *channel_name;
+	struct iio_backend *backend;
+};
+
+/*
+ * struct stm32_mdf_adc - STM32 MDF ADC private data
+ * @entry: pointer to serial interfaces list
+ * @dev: pointer to filter device
+ * @mdf: pointer to mdf common data
+ * @regmap: regmap pointer for register read/write
+ * @node: pointer to filter node
+ * @dma_chan: filter dma channel pointer
+ * @channels: pointer to channel descriptors array
+ * @dev_data: mdf device data pointer
+ * @sitf: pointer to serial interface feeding the filter
+ * @completion: completion for conversion
+ * @dma_buf: physical dma address
+ * @phys_addr: mdf physical address
+ * @cb: iio consumer callback function pointer
+ * @cb_priv: pointer to consumer private structure
+ * @sck_freq: serial interface frequency
+ * @requested_sample_freq: requested sample frequency from IIO sysfs or from audio stream
+ * @sample_freq: actual sampling frequency
+ * @fl_id: filter index
+ * @decim_ratio: total decimation ratio
+ * @decim_cic: CIC filter decimation ratio
+ * @stu: settling time in micro seconds
+ * @nbdis: number of samples to discard
+ * @bufi: dma buffer current position
+ * @buf_sz: dma buffer size
+ * @buffer: buffer pointer for raw conversion
+ * @dflt_max: dflt maximum output
+ * @cicmode: cic filter order
+ * @hpf_cutoff: high pass filter cut-off frequency
+ * @delay: microphone delay
+ * @datsrc: data source path
+ * @rx_buf: dma buffer pointer
+ * @rsflt_bypass: reshape filter bypass flag
+ * @synced: synchronous flag
+ * @trgo: TRGO trigger flag
+ * @interleaved: interleave flag
+ */
+struct stm32_mdf_adc {
+	struct list_head entry;
+	struct device *dev;
+	struct stm32_mdf *mdf;
+	struct regmap *regmap;
+	struct fwnode_handle *node;
+	struct dma_chan *dma_chan;
+	struct stm32_mdf_adc_chan *channels;
+	const struct stm32_mdf_dev_data *dev_data;
+	struct stm32_mdf_sitf *sitf;
+	struct completion completion;
+	dma_addr_t dma_buf;
+	phys_addr_t phys_addr;
+	int (*cb)(const void *data, size_t size, void *cb_priv);
+	void *cb_priv;
+	unsigned long sck_freq;
+	unsigned long requested_sample_freq;
+	unsigned long sample_freq;
+	unsigned int fl_id;
+	unsigned int decim_ratio;
+	unsigned int decim_cic;
+	unsigned int stu;
+	unsigned int nbdis;
+	unsigned int bufi;
+	unsigned int buf_sz;
+	unsigned int dflt_max;
+	u32 *buffer;
+	u32 cicmode;
+	u32 hpf_cutoff;
+	u32 delay;
+	u32 datsrc;
+	u8 *rx_buf;
+	bool rsflt_bypass;
+	bool synced;
+	bool trgo;
+	bool interleaved;
+};
+
+struct stm32_mdf_scales {
+	unsigned int scale;
+	int gain_db;
+	int gain_lin;
+};
+
+struct stm32_mdf_log10 {
+	unsigned int raw;
+	unsigned int log;
+};
+
+enum stm32_mdf_converter_type {
+	STM32_MDF_AUDIO,
+	STM32_MDF_IIO,
+};
+
+enum stm32_mdf_data_src_type {
+	STM32_MDF_DATSRC_BSMX,
+	STM32_MDF_DATSRC_UNSUPPORTED,
+	STM32_MDF_DATSRC_ADCITF1,
+	STM32_MDF_DATSRC_ADCITF2,
+	STM32_MDF_DATSRC_NB,
+};
+
+enum stm32_mdf_acq_mode {
+	STM32_MDF_ACQ_MODE_ASYNC_CONT,
+	STM32_MDF_ACQ_MODE_ASYNC_SINGLE_SHOT,
+	STM32_MDF_ACQ_MODE_SYNC_CONT,
+	STM32_MDF_ACQ_MODE_SYNC_SINGLE_SHOT,
+	STM32_MDF_ACQ_MODE_WINDOW_CONT,
+	STM32_MDF_ACQ_MODE_SYNC_SNAPSHOT,
+	STM32_MDF_ACQ_MODE_NB,
+};
+
+enum stm32_trig_type {
+	STM32_MDF_TRGSRC_TRGO,
+	STM32_MDF_TRGSRC_OLD,
+	STM32_MDF_TRGSRC_EXT,
+	STM32_MDF_TRGSRC_NB,
+};
+
+enum stm32_trig_sens {
+	STM32_MDF_TRGSENS_RISING_EDGE,
+	STM32_MDF_TRGSENS_FALLING_EDGE,
+};
+
+enum stm32_trig_src {
+	STM32_MDF_TRGSRC_TIM1_TRGO2 = 0x2,
+	STM32_MDF_TRGSRC_TIM8_TRGO2,
+	STM32_MDF_TRGSRC_TIM20_TRGO2,
+	STM32_MDF_TRGSRC_TIM16_OC1,
+	STM32_MDF_TRGSRC_TIM6_TRGO,
+	STM32_MDF_TRGSRC_TIM7_TRGO,
+	STM32_MDF_TRGSRC_EXTI11,
+	STM32_MDF_TRGSRC_EXTI15,
+	STM32_MDF_TRGSRC_LPTIM1_CH1,
+	STM32_MDF_TRGSRC_LPTIM2_CH1,
+	STM32_MDF_TRGSRC_LPTIM3_CH1,
+};
+
+struct stm32_mdf_ext_trig_src {
+	const char *name;
+	unsigned int trgsrc;
+};
+
+static const struct stm32_mdf_ext_trig_src stm32_mdf_trigs[] = {
+	{ TIM1_TRGO2, STM32_MDF_TRGSRC_TIM1_TRGO2 },
+	{ TIM8_TRGO2, STM32_MDF_TRGSRC_TIM8_TRGO2 },
+	{ TIM20_TRGO2, STM32_MDF_TRGSRC_TIM20_TRGO2 },
+	{ TIM16_OC1, STM32_MDF_TRGSRC_TIM16_OC1 },
+	{ TIM6_TRGO, STM32_MDF_TRGSRC_TIM6_TRGO },
+	{ TIM7_TRGO, STM32_MDF_TRGSRC_TIM7_TRGO },
+	{ LPTIM1_CH1, STM32_MDF_TRGSRC_LPTIM1_CH1 },
+	{ LPTIM2_CH1, STM32_MDF_TRGSRC_LPTIM2_CH1 },
+	{ LPTIM3_CH1, STM32_MDF_TRGSRC_LPTIM3_CH1 },
+	{},
+};
+
+static const unsigned int stm32_mdf_hpf_cutoff_ratio[] = {
+	625, 1250, 2500, 9500
+};
+
+/*
+ * The CIC output data resolution cannot exceed 26 bits.
+ * Output data resolution: D = N * ln(D) / ln(2) + 1 (for serial interface data),
+ * where N is filter order and D the CIC decimation factor.
+ * Following table gives the maximum decimation ratio for filter order [0..5].
+ */
+static const unsigned int stm32_mdf_cic_max_decim_sitf[] = {
+512, 512, 512, 322, 76, 32
+};
+
+/* Gain (dB) x 10 according to scale value in hex */
+static const struct stm32_mdf_scales stm32_mdf_scale_table[] = {
+	{0x20, -482, -2558},
+	{0x21, -446, -1706},
+	{0x22, -421, -1280},
+	{0x23, -386, -853},
+	{0x24, -361, -640},
+	{0x25, -326, -427},
+	{0x26, -301, -320},
+	{0x27, -266, -213},
+	{0x28, -241, -160},
+	{0x29, -206, -107},
+	{0x2A, -181, -80},
+	{0x2B, -145, -53},
+	{0x2C, -120, -40},
+	{0x2D, -85,  -27},
+	{0x2E, -60,  -20},
+	{0x2F, -25,  -13},
+	{0x00, 0,    10},
+	{0x01, 35,   15},
+	{0x02, 60,   20},
+	{0x03, 95,   30},
+	{0x04, 120,  40},
+	{0x05, 156,  60},
+	{0x06, 181,  80},
+	{0x07, 216,  120},
+	{0x08, 241,  160},
+	{0x09, 276,  240},
+	{0x0A, 301,  320},
+	{0x0B, 336,  480},
+	{0x0C, 361,  640},
+	{0x0D, 396,  960},
+	{0x0E, 421,  1280},
+	{0x0F, 457,  1920},
+	{0x10, 482,  2560},
+	{0x11, 517,  3840},
+	{0x12, 542,  5120},
+	{0x13, 577,  7680},
+	{0x14, 602,  10240},
+	{0x15, 637,  15360},
+	{0x16, 662,  20480},
+	{0x17, 697,  30720},
+	{0x18, 722,  40960},
+};
+
+/* Prime number 1000 x log10 table */
+static const struct stm32_mdf_log10 stm32_mdf_log_table[] = {
+	{2, 301}, {3, 477}, {5, 699}, {7, 845}, {11, 1041}, {13, 1114}, {17, 1230}, {19, 1279},
+	{23, 1362}, {29, 1462}, {31, 1491}, {37, 1568}, {41, 1613}, {43, 1633}, {47, 1672},
+	{53, 1724}, {59, 1771}, {61, 1785}, {67, 1826}, {71, 1851}, {73, 1863}, {79, 1898},
+	{83, 1919}, {89, 1949}, {97, 1987}, {101, 2004}, {103, 2013}, {107, 2029}, {109, 2037},
+	{113, 2053}, {127, 2104}
+};
+
+static bool stm32_mdf_adc_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MDF_BSMXCR_REG:
+	case MDF_DFLTCR_REG:
+	case MDF_DFLTCICR_REG:
+	case MDF_DFLTRSFR_REG:
+	case MDF_DFLTINTR_REG:
+	case MDF_OLDCR_REG:
+	case MDF_OLDTHLR_REG:
+	case MDF_OLDTHHR_REG:
+	case MDF_DLYCR_REG:
+	case MDF_SCDCR_REG:
+	case MDF_DFLTIER_REG:
+	case MDF_DFLTISR_REG:
+	case MDF_OECCR_REG:
+	case MDF_SNPSDR:
+	case MDF_DFLTDR_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool stm32_mdf_adc_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/*
+	 * In MDF_DFLTCR_REG register only DFLTACTIVE & DFLTRUN bits are volatile.
+	 * MDF_DFLTCR_REG is not marked as volatible to ease the suspend/resume case, and benefit
+	 * from the regcache API. Access to volatile bits is managed specifically instead.
+	 */
+	switch (reg) {
+	case MDF_DFLTISR_REG:
+	case MDF_SNPSDR:
+	case MDF_DFLTDR_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool stm32_mdf_adc_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MDF_BSMXCR_REG:
+	case MDF_DFLTCR_REG:
+	case MDF_DFLTCICR_REG:
+	case MDF_DFLTRSFR_REG:
+	case MDF_DFLTINTR_REG:
+	case MDF_OLDCR_REG:
+	case MDF_OLDTHLR_REG:
+	case MDF_OLDTHHR_REG:
+	case MDF_DLYCR_REG:
+	case MDF_SCDCR_REG:
+	case MDF_DFLTIER_REG:
+	case MDF_DFLTISR_REG:
+	case MDF_OECCR_REG:
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
+	.max_register = MDF_DFLTDR_REG,
+	.readable_reg = stm32_mdf_adc_readable_reg,
+	.volatile_reg = stm32_mdf_adc_volatile_reg,
+	.writeable_reg = stm32_mdf_adc_writeable_reg,
+	.num_reg_defaults_raw = MDF_DFLTDR_REG / sizeof(u32) + 1,
+	.cache_type = REGCACHE_FLAT,
+	.fast_io = true,
+};
+
+static struct stm32_mdf_adc *stm32_mdf_get_filter_by_handle(struct stm32_mdf *mdf,
+							    struct fwnode_handle *node)
+{
+	struct stm32_mdf_adc *adc;
+
+	/* Look for filter data from filter node handle */
+	list_for_each_entry(adc, &mdf->filter_list, entry) {
+		if (adc->node == node)
+			return adc;
+	}
+	return NULL;
+}
+
+static int stm32_mdf_adc_start_filter(struct stm32_mdf_adc *adc)
+{
+	struct stm32_mdf_adc *adc_inter;
+	struct stm32_mdf *mdf = adc->mdf;
+	u32 val;
+
+	if (MDF_IS_FILTER0(adc))
+		list_for_each_entry(adc_inter, &mdf->filter_list, entry)
+			if (MDF_IS_INTERLEAVED_FILT_NOT_0(adc_inter))
+				stm32_mdf_adc_start_filter(adc_inter);
+
+	/* Check filter status. Bypass cache to access volatile MDF_DFLTCR_ACTIVE bit */
+	regcache_cache_bypass(adc->regmap, true);
+	regmap_read(adc->regmap, MDF_DFLTCR_REG, &val);
+	regcache_cache_bypass(adc->regmap, false);
+	if (val & MDF_DFLTCR_ACTIVE) {
+		dev_err(adc->dev, "Filter [%d] is already running\n", adc->fl_id);
+		return -EBUSY;
+	}
+
+	return regmap_set_bits(adc->regmap, MDF_DFLTCR_REG, MDF_DFLTCR_DFLTEN);
+}
+
+static void stm32_mdf_adc_stop_filter(struct stm32_mdf_adc *adc)
+{
+	struct stm32_mdf_adc *adc_inter;
+	struct stm32_mdf *mdf = adc->mdf;
+
+	regmap_clear_bits(adc->regmap, MDF_DFLTCR_REG, MDF_DFLTCR_DFLTEN);
+
+	if (MDF_IS_FILTER0(adc))
+		list_for_each_entry(adc_inter, &mdf->filter_list, entry)
+			if (MDF_IS_INTERLEAVED_FILT_NOT_0(adc_inter))
+				stm32_mdf_adc_stop_filter(adc_inter);
+}
+
+static int stm32_mdf_adc_get_trig(struct iio_dev *indio_dev, struct iio_trigger *trig)
+{
+	int i;
+
+	/* lookup triggers registered by stm32 timer trigger driver */
+	for (i = 0; stm32_mdf_trigs[i].name; i++) {
+		/**
+		 * Checking both stm32 timer trigger type and trig name
+		 * should be safe against arbitrary trigger names.
+		 */
+		if ((is_stm32_timer_trigger(trig) ||
+		     is_stm32_lptim_trigger(trig)) &&
+		     !strcmp(stm32_mdf_trigs[i].name, trig->name)) {
+			dev_dbg(&indio_dev->dev, "Trigger [%d] found\n", i);
+			return stm32_mdf_trigs[i].trgsrc;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int stm32_mdf_adc_filter_set_trig(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	struct iio_trigger *trig = indio_dev->trig;
+	u32 trgsrc = 0;
+	/* set trigger polarity to rising edge by default */
+	u32 trgsens = STM32_MDF_TRGSENS_RISING_EDGE;
+	int ret;
+
+	if (trig) {
+		ret = stm32_mdf_adc_get_trig(indio_dev, trig);
+		if (ret < 0)
+			return ret;
+	}
+
+	dev_dbg(adc->dev, "Set trigger source [%d] on filter [%d]\n", trgsrc, adc->fl_id);
+
+	return regmap_update_bits(adc->regmap, MDF_DFLTCR_REG,
+				  MDF_DFLTCR_TRGSRC_MASK | MDF_DFLTCR_TRGSENS,
+				  MDF_DFLTCR_TRGSRC(trgsrc) | MDF_DFLTCR_TRGSENS_SET(trgsens));
+}
+
+static void stm32_mdf_adc_filter_clear_trig(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+
+	regmap_update_bits(adc->regmap, MDF_DFLTCR_REG,
+			   MDF_DFLTCR_TRGSRC_MASK | MDF_DFLTCR_TRGSENS, 0);
+}
+
+static int stm32_mdf_adc_filter_set_mode(struct stm32_mdf_adc *adc, bool cont)
+{
+	struct stm32_mdf_adc *adc_inter;
+	struct iio_dev *indio_dev = dev_get_drvdata(adc->dev);
+	struct iio_trigger *trig = indio_dev->trig;
+	u32 mode;
+
+	if (MDF_IS_FILTER0(adc)) {
+		list_for_each_entry(adc_inter, &adc->mdf->filter_list, entry) {
+			if (MDF_IS_INTERLEAVED_FILT_NOT_0(adc_inter))
+				stm32_mdf_adc_filter_set_mode(adc_inter, cont);
+		}
+	}
+
+	if (adc->synced || MDF_IS_INTERLEAVED_FILT(adc) || trig) {
+		if (cont)
+			mode = STM32_MDF_ACQ_MODE_SYNC_CONT;
+		else
+			mode = STM32_MDF_ACQ_MODE_SYNC_SINGLE_SHOT;
+	} else {
+		if (cont)
+			mode = STM32_MDF_ACQ_MODE_ASYNC_CONT;
+		else
+			/*
+			 * The expected mode would be STM32_MDF_ACQ_MODE_ASYNC_SINGLE_SHOT here.
+			 * However, there is an instability depending on "bus/kernel clock ratio"
+			 * in this mode.
+			 * Use STM32_MDF_ACQ_MODE_SYNC_SINGLE_SHOT mode along with TRGO trigger,
+			 * as a workaround.
+			 */
+			mode = STM32_MDF_ACQ_MODE_SYNC_SINGLE_SHOT;
+	}
+
+	dev_dbg(adc->dev, "Set mode [0x%x] on filter [%d]\n", mode, adc->fl_id);
+
+	return regmap_update_bits(adc->regmap, MDF_DFLTCR_REG,
+				  MDF_DFLTCR_ACQMOD_MASK, MDF_DFLTCR_ACQMOD(mode));
+}
+
+static int stm32_mdf_adc_compute_scale(struct device *dev, unsigned int decim,
+				       unsigned int order, unsigned int data_size)
+{
+	unsigned long max = ARRAY_SIZE(stm32_mdf_log_table);
+	unsigned int prime_factors[16];
+	unsigned int num, div, logd = 0;
+	int i, j, scale;
+
+	/* Decompose decimation ratio D, as prime number factors, to compute log10(D) */
+	j = 0;
+	num = decim;
+	while (num > 1) {
+		i = 0;
+		while (i < max) {
+			div = stm32_mdf_log_table[i].raw;
+			if (!(num % div)) {
+				prime_factors[j] = stm32_mdf_log_table[i].log;
+				num = num / div;
+				j++;
+				break;
+			}
+			i++;
+		}
+		if (i == max) {
+			dev_warn(dev, "Failed to set scale. Output signal may saturate.\n");
+			return 0;
+		}
+	}
+
+	for (i = 0; i < j; i++)
+		logd += prime_factors[i];
+
+	/* scale = 20 * ((DS - 1) * log10(2) - NF * log10(D)) */
+	scale = 20 * ((data_size - 1) * stm32_mdf_log_table[0].log - order * logd);
+
+	return scale;
+}
+
+static int stm32_mdf_adc_apply_filters_config(struct stm32_mdf_adc *adc, unsigned int scale)
+{
+	struct stm32_mdf_adc *adc_inter;
+	u32 msk, val;
+	int ret, cnt = 0;
+
+	/* Apply conf from filter0 to interleaved filters if any */
+	if (MDF_IS_FILTER0(adc) && adc->mdf->nb_interleave) {
+		list_for_each_entry(adc_inter, &adc->mdf->filter_list, entry) {
+			if (MDF_IS_INTERLEAVED_FILT_NOT_0(adc_inter)) {
+				adc_inter->datsrc = adc->datsrc;
+				adc_inter->cicmode = adc->cicmode;
+				adc_inter->decim_cic = adc->decim_cic;
+				adc_inter->nbdis = adc->nbdis;
+				adc_inter->hpf_cutoff = adc->hpf_cutoff;
+
+				stm32_mdf_adc_apply_filters_config(adc_inter, scale);
+				cnt++;
+			}
+		}
+		if (cnt != adc->mdf->nb_interleave - 1) {
+			dev_err(adc->dev, "Interleaved filter number [%d] / expected [%d]\n",
+				cnt, adc->mdf->nb_interleave - 1);
+			return -EINVAL;
+		}
+	}
+
+	/* Configure delay */
+	ret = regmap_update_bits(adc->regmap, MDF_DLYCR_REG, MDF_DLYCR_SKPDLY_MASK, adc->delay);
+	if (ret)
+		return ret;
+
+	/* Configure NBDIS */
+	if (adc->nbdis) {
+		ret = regmap_update_bits(adc->regmap, MDF_DFLTCR_REG, MDF_DFLTCR_NBDIS_MASK,
+					 MDF_DFLTCR_NBDIS(adc->nbdis));
+		if (ret)
+			return ret;
+	}
+
+	/* Configure CICR */
+	msk = MDF_SITFCR_SCKSRC_MASK | MDF_DFLTCICR_CICMOD_MASK |
+	      MDF_DFLTCICR_MCICD_MASK | MDF_DFLTCICR_SCALE_MASK;
+	val = MDF_SITFCR_SCKSRC(adc->datsrc) | MDF_DFLTCICR_CICMOD(adc->cicmode) |
+	      MDF_DFLTCICR_MCICD(adc->decim_cic - 1) | MDF_DFLTCICR_SCALE(scale);
+
+	ret = regmap_update_bits(adc->regmap, MDF_DFLTCICR_REG, msk, val);
+	if (ret)
+		return ret;
+
+	/* Configure RSFR & HPF */
+	if (adc->hpf_cutoff == STM32_MDF_HPF_BYPASS)
+		val = MDF_DFLTRSFR_HPFBYP;
+	else
+		val = MDF_DFLTRSFR_HPFC(adc->hpf_cutoff);
+	val |= adc->rsflt_bypass ? MDF_DFLTRSFR_RSFLTBYP : 0;
+	msk = MDF_DFLTRSFR_RSFLTBYP | MDF_DFLTRSFR_HPFBYP | MDF_DFLTRSFR_HPFC_MASK;
+
+	return regmap_update_bits(adc->regmap, MDF_DFLTRSFR_REG, msk, val);
+}
+
+static int stm32_mdf_adc_set_filters_config(struct iio_dev *indio_dev, unsigned int decim)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	struct device *dev = &indio_dev->dev;
+	unsigned int decim_cic, decim_rsflt = 1;
+	unsigned int data_size = STM32_MDF_DATA_RES, order = adc->cicmode;
+	u64 max;
+	int i, d, log, scale, max_scale, gain_lin;
+
+	if (!adc->rsflt_bypass) {
+		decim_rsflt = 4;
+		data_size -= 2;
+
+		/* Check if total decimation factor is a multiple of reshape filter decimation */
+		if (decim % decim_rsflt) {
+			dev_err(dev, "Total decimation factor [%d] not multiple of [%d]\n",
+				decim, decim_rsflt);
+			return -EINVAL;
+		}
+	}
+
+	decim_cic = DIV_ROUND_CLOSEST(decim, decim_rsflt);
+	if (decim_cic < MDF_DFLTCICR_MCICD_MIN ||
+	    decim_cic > stm32_mdf_cic_max_decim_sitf[order]) {
+		dev_err(dev, "Decimation factor [%d] out of range for CIC filter order [%d]\n",
+			decim_cic, adc->cicmode);
+		return -EINVAL;
+	}
+
+	/*
+	 * Compute scaling:
+	 * max scale = 20 * log10( 2 exp DS / D exp NF )
+	 * - DS = max data size at scale output (RSFLT on: DS = 22 / RSFLT off: DS = 24)
+	 * - NF = Main CIC filter order
+	 */
+	if (is_power_of_2(decim_cic)) {
+		/*
+		 * Decimation ratio is a power of 2: D = 2 exp n
+		 * max scale = 20 * (DS - n * NF) * log10(2)
+		 */
+		log = stm32_mdf_log_table[0].log;
+
+		/* Compute max scale (dB) * 1000 */
+		max_scale = (20 * (data_size - 1 - (order * (fls(decim_cic) - 1))) * log);
+	} else {
+		/*
+		 * Decimation ratio is not a power of 2
+		 * max scale = 20 * ((DS - 1) * log10(2) - NF * log10(D))
+		 */
+		max_scale = stm32_mdf_adc_compute_scale(dev, decim_cic, order, data_size);
+	}
+
+	dev_dbg(dev, "Filter order [%d], decimation [%d], data size [%d], max scale [%d]\n",
+		order, decim_cic, data_size, max_scale / 1000);
+
+	/*
+	 * Find scale register setting.
+	 * Limit max_scale accuracy to first decimal for comparison with scale table values.
+	 */
+	max_scale = DIV_ROUND_CLOSEST(max_scale, 100);
+	i = ARRAY_SIZE(stm32_mdf_scale_table) - 1;
+	while (i > 0) {
+		if (stm32_mdf_scale_table[i].gain_db < max_scale)
+			break;
+		i--;
+	};
+	scale = stm32_mdf_scale_table[i].scale;
+	gain_lin = stm32_mdf_scale_table[i].gain_lin;
+
+	dev_dbg(dev, "Set scale to [%d]dB: [0x%x]\n", stm32_mdf_scale_table[i].gain_db / 10, scale);
+
+	adc->decim_cic = decim_cic;
+
+	/*
+	 * Calculate maximum DFLT output filter
+	 * max = K * G
+	 * - Fastsinc (order 0):	G = 2 * d^2 * gain_lin
+	 * - Sinc order 1 to 5:		G = d^N * gain_lin
+	 * - RSFLT off:			K = 1, d = decim
+	 * - RSFLT on:			K = 2.98, d = decim_cic
+	 * N = CIC filter order, decim = total decimation ratio, decim_cic = CIC decimation ratio
+	 * gain_lin is multiplied by a 10 factor in stm32_mdf_scale_table, and K with a 100 factor.
+	 */
+	if (adc->rsflt_bypass) {
+		d = decim;
+		max = 100;
+	} else {
+		d = decim_cic;
+		max = 298;
+	}
+
+	if (order) {
+		i = 0;
+		while (i < order) {
+			max *= d;
+			i++;
+		}
+	} else {
+		max *= 2 * d * d;
+	}
+
+	if (gain_lin > 0) {
+		max *= gain_lin;
+		max = DIV_ROUND_CLOSEST_ULL(max, 1000);
+	}
+	if (gain_lin < 0) {
+		max = DIV_ROUND_CLOSEST_ULL(max, -gain_lin);
+		max = DIV_ROUND_CLOSEST_ULL(max,  10);
+	}
+
+	adc->dflt_max = max;
+
+	dev_dbg(dev, "DFLT maximum output [%d]\n", adc->dflt_max);
+
+	return stm32_mdf_adc_apply_filters_config(adc, scale);
+}
+
+static int stm32_mdf_adc_check_clock_config(struct stm32_mdf_adc *adc, unsigned long *sck_freq)
+{
+	unsigned long cck_expected_freq;
+	unsigned int ratio, cic_ratio;
+	int ret, error = 0;
+
+	/*
+	 * The cck expected rate is set at probe from "clock-frequency" device tree property.
+	 * The serial interface clock sck (aka cck) is derived from MDF kernel clock frequency.
+	 * The kernel clock rate may have been changed by another consumer, or MDF dividers
+	 * may have been updated through clk_get_rate() call.
+	 * Ensure that kernel clock rate and MDF dividers, still provide the right sck/cck rate
+	 */
+	cck_expected_freq = stm32_mdf_core_get_cck(adc->mdf);
+	if (*sck_freq != cck_expected_freq) {
+		dev_dbg(adc->dev, "Wrong sck_freq [%lu]Hz. Expected [%lu]Hz.\n",
+			*sck_freq, cck_expected_freq);
+		error |= STM32_MDF_ERR_SCK_FREQ;
+	}
+
+	/*
+	 * Mode SPI:    check Fproc >= 4 * Fsck
+	 * Mode LF SPI: check Fproc >= 2 * Fsck
+	 */
+	ratio = DIV_ROUND_CLOSEST(adc->mdf->fproc, *sck_freq);
+	if ((adc->sitf->mode == STM32_MDF_MODE_SPI && ratio <= 4) ||
+	    (adc->sitf->mode == STM32_MDF_MODE_LF_SPI && ratio <= 2)) {
+		dev_dbg(adc->dev, "Wrong Fproc/Fsck ratio [%d]. sitf mode [%d], RSFLT [%s]\n",
+			ratio, adc->sitf->mode, adc->rsflt_bypass ? "off" : "on");
+		error |= STM32_MDF_ERR_MODE_RATIO;
+	}
+
+	/* RSFLT enabled: check Fproc > 24 * Fsck / (MCICD+1) */
+	cic_ratio = DIV_ROUND_CLOSEST(24, adc->decim_cic);
+	if (!adc->rsflt_bypass && ratio <= cic_ratio)
+		error |= STM32_MDF_ERR_DECIM_RATIO;
+
+	/* If we found an error, try to restore clocks initial settings */
+	if (error) {
+		ret = stm32_mdf_core_restore_cck(adc->mdf);
+		if (ret < 0)
+			goto err;
+
+		*sck_freq = clk_get_rate(adc->sitf->sck);
+		if (!*sck_freq) {
+			ret = -EINVAL;
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	dev_err(adc->dev, "Wrong clock configuration [0x%x]. Clock recovering returned [%d]\n",
+		error, ret);
+
+	return ret;
+}
+
+static int mdf_adc_set_samp_freq(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	struct device *dev = &indio_dev->dev;
+	unsigned int decim_ratio;
+	unsigned long delta, delta_ppm, sck_freq, sample_freq = adc->requested_sample_freq;
+	int ret;
+
+	sck_freq = clk_get_rate(adc->sitf->sck);
+	if (!sck_freq) {
+		dev_err(dev, "Unexpected serial clock frequency: 0Hz\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/*
+	 * In analog use cases, the sampling frequency may not be already set in IIO sysfs.
+	 * (In audio use cases, the sampling frequency is always provided on stream startup)
+	 * If requested sampling frequency is 0, set a default frequency.
+	 * The default frequency is computed from the default decimation ratio.
+	 * This ensures that a filter configuration can be found whatever the selected filter
+	 * order. (Most constrained case is order 5)
+	 */
+	if (!sample_freq)
+		sample_freq = sck_freq / MDF_DEFAULT_DECIM_RATIO;
+
+	ret = stm32_mdf_adc_check_clock_config(adc, &sck_freq);
+	if (ret)
+		goto err;
+
+	decim_ratio = DIV_ROUND_CLOSEST(sck_freq, sample_freq);
+
+	delta = abs(sck_freq - (decim_ratio * sample_freq));
+	delta_ppm = (1000000 * delta) / sck_freq;
+	if (delta_ppm > 1000)
+		dev_warn(dev, "Sample rate deviation [%lu] ppm: [%lu] vs [%lu] Hz\n",
+			 delta_ppm, sck_freq / decim_ratio, sample_freq);
+	else if (delta)
+		dev_dbg(dev, "Sample rate deviation [%lu] ppm: [%lu] vs [%lu] Hz\n",
+			delta_ppm, sck_freq / decim_ratio, sample_freq);
+
+	/*
+	 * Convert settling time into a minimum number of output sample to discard before releasing
+	 * the data. This allows to drop the samples affected by the impulse response of the
+	 * filter and wait for stable data.
+	 */
+	adc->nbdis = DIV_ROUND_UP(adc->stu * sample_freq, 1000000);
+	if (adc->nbdis > MDF_DFLTCR_NBDIS_MAX) {
+		dev_warn(dev, "NBDIS [%u] too large. Force to [%lu]\n",
+			 adc->nbdis, MDF_DFLTCR_NBDIS_MAX);
+		adc->nbdis = MDF_DFLTCR_NBDIS_MAX;
+	} else {
+		dev_dbg(dev, "Settling time [%u] us. NBDIS set to [%u] samples\n",
+			adc->stu, adc->nbdis);
+	}
+
+	ret = stm32_mdf_adc_set_filters_config(indio_dev, decim_ratio);
+	if (ret < 0)
+		goto err;
+
+	adc->sample_freq = DIV_ROUND_CLOSEST(sck_freq, decim_ratio);
+	adc->decim_ratio = decim_ratio;
+
+err:
+	return ret;
+}
+
+static int stm32_mdf_adc_start_mdf(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	ret = clk_prepare_enable(adc->sitf->sck);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "Failed to enable clock %s\n",
+			__clk_get_name(adc->sitf->sck));
+		return ret;
+	}
+
+	ret = mdf_adc_set_samp_freq(indio_dev);
+	if (ret < 0)
+		goto err;
+
+	ret = stm32_mdf_core_start_mdf(adc->mdf);
+	if (ret < 0)
+		goto err;
+
+	return 0;
+
+err:
+	clk_disable_unprepare(adc->sitf->sck);
+
+	return ret;
+}
+
+static void stm32_mdf_adc_stop_mdf(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+
+	stm32_mdf_core_stop_mdf(adc->mdf);
+
+	clk_disable_unprepare(adc->sitf->sck);
+}
+
+static int stm32_mdf_adc_start_conv(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	ret = stm32_mdf_sitf_start(adc->sitf);
+	if (ret < 0)
+		return ret;
+
+	ret = stm32_mdf_adc_start_filter(adc);
+	if (ret < 0)
+		goto stop_sitf;
+
+	if (adc->trgo) {
+		ret = stm32_mdf_core_trigger(adc->mdf);
+		if (ret < 0)
+			goto stop_filter;
+	}
+
+	return 0;
+
+stop_filter:
+	stm32_mdf_adc_stop_filter(adc);
+stop_sitf:
+	stm32_mdf_sitf_stop(adc->sitf);
+
+	return ret;
+}
+
+static void stm32_mdf_adc_stop_conv(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+
+	stm32_mdf_adc_stop_filter(adc);
+
+	stm32_mdf_sitf_stop(adc->sitf);
+}
+
+static unsigned int stm32_mdf_adc_dma_residue(struct stm32_mdf_adc *adc)
+{
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(adc->dma_chan, adc->dma_chan->cookie, &state);
+	if (status == DMA_IN_PROGRESS) {
+		/* Residue is size in bytes from end of buffer */
+		unsigned int i = adc->buf_sz - state.residue;
+		unsigned int size;
+
+		/* Return available bytes */
+		if (i >= adc->bufi)
+			size = i - adc->bufi;
+		else
+			size = adc->buf_sz + i - adc->bufi;
+
+		return size;
+	}
+
+	return 0;
+}
+
+static void stm32_mdf_adc_dma_buffer_done(void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int available = stm32_mdf_adc_dma_residue(adc);
+	size_t old_pos;
+
+	dev_dbg(&indio_dev->dev, "pos = %d, available = %d\n", adc->bufi, available);
+	old_pos = adc->bufi;
+
+	while (available >= indio_dev->scan_bytes) {
+		s32 *buffer = (s32 *)&adc->rx_buf[adc->bufi];
+
+		adc->bufi += indio_dev->scan_bytes;
+		if (adc->bufi >= adc->buf_sz) {
+			if (adc->cb)
+				adc->cb(&adc->rx_buf[old_pos], adc->buf_sz - old_pos, adc->cb_priv);
+			adc->bufi = 0;
+			old_pos = 0;
+		}
+		if (adc->dev_data->type == STM32_MDF_IIO)
+			iio_push_to_buffers(indio_dev, buffer);
+		available -= indio_dev->scan_bytes;
+	}
+	if (adc->cb)
+		adc->cb(&adc->rx_buf[old_pos], adc->bufi - old_pos, adc->cb_priv);
+}
+
+static int stm32_mdf_adc_dma_start(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	struct dma_slave_config config = {
+		.src_addr = (dma_addr_t)adc->phys_addr + MDF_DFLTDR_REG,
+		.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+	};
+	struct dma_async_tx_descriptor *desc;
+	int ret;
+
+	if (!adc->dma_chan)
+		return -EINVAL;
+
+	dev_dbg(&indio_dev->dev, "size=%d watermark=%d\n", adc->buf_sz, adc->buf_sz / 2);
+
+	ret = dmaengine_slave_config(adc->dma_chan, &config);
+	if (ret)
+		return ret;
+
+	/* Prepare a DMA cyclic transaction */
+	desc = dmaengine_prep_dma_cyclic(adc->dma_chan, adc->dma_buf,
+					 adc->buf_sz, adc->buf_sz / 2,
+					 DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+	if (!desc)
+		return -EBUSY;
+
+	desc->callback = stm32_mdf_adc_dma_buffer_done;
+	desc->callback_param = indio_dev;
+
+	ret = dma_submit_error(dmaengine_submit(desc));
+	if (ret)
+		goto err_stop_dma;
+
+	/* Issue pending DMA requests */
+	dma_async_issue_pending(adc->dma_chan);
+
+	/* Enable regular DMA transfer*/
+	ret = regmap_set_bits(adc->regmap, MDF_DFLTCR_REG, MDF_DFLTCR_DMAEN);
+	if (ret < 0)
+		goto err_stop_dma;
+
+	return 0;
+
+err_stop_dma:
+	dmaengine_terminate_sync(adc->dma_chan);
+
+	return ret;
+}
+
+static void stm32_mdf_adc_dma_stop(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+
+	if (!adc->dma_chan)
+		return;
+
+	regmap_clear_bits(adc->regmap, MDF_DFLTCR_REG, MDF_DFLTCR_DMAEN);
+
+	dmaengine_terminate_sync(adc->dma_chan);
+}
+
+static int stm32_mdf_adc_postenable(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int i = 0;
+	int ret;
+
+	/* Reset adc buffer index */
+	adc->bufi = 0;
+
+	while (adc->channels[i].backend && i < indio_dev->num_channels) {
+		ret = iio_backend_enable(adc->channels[i].backend);
+		if (ret < 0) {
+			while (--i > 0)
+				iio_backend_disable(adc->channels[i].backend);
+
+			return ret;
+		}
+		i++;
+	}
+
+	ret = stm32_mdf_adc_start_mdf(indio_dev);
+	if (ret < 0)
+		goto err_start;
+
+	stm32_mdf_adc_filter_set_mode(adc, true);
+
+	regmap_clear_bits(adc->regmap, MDF_DFLTISR_REG,
+			  MDF_DFLTISR_DOVRF_MASK | MDF_DFLTISR_SATF_MASK);
+
+	regmap_set_bits(adc->regmap, MDF_DFLTIER_REG,
+			MDF_DFLTIER_DOVRIE_MASK | MDF_DFLTIER_SATIE_MASK);
+
+	ret = stm32_mdf_adc_dma_start(indio_dev);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Can't start DMA\n");
+		goto err_dma;
+	}
+
+	ret = stm32_mdf_adc_filter_set_trig(indio_dev);
+	if (ret < 0)
+		goto err_trig;
+
+	ret = stm32_mdf_adc_start_conv(indio_dev);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Can't start conversion\n");
+		goto err_conv;
+	}
+
+	return 0;
+
+err_conv:
+	stm32_mdf_adc_filter_clear_trig(indio_dev);
+err_trig:
+	stm32_mdf_adc_dma_stop(indio_dev);
+err_dma:
+	stm32_mdf_adc_stop_mdf(indio_dev);
+err_start:
+	i = 0;
+	while (adc->channels[i].backend && i < indio_dev->num_channels) {
+		iio_backend_disable(adc->channels[i].backend);
+		i++;
+	}
+
+	return ret;
+}
+
+static int stm32_mdf_adc_predisable(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int i = 0;
+
+	stm32_mdf_adc_stop_conv(indio_dev);
+
+	stm32_mdf_adc_filter_clear_trig(indio_dev);
+
+	stm32_mdf_adc_dma_stop(indio_dev);
+
+	regmap_clear_bits(adc->regmap, MDF_DFLTIER_REG,
+			  MDF_DFLTIER_DOVRIE_MASK | MDF_DFLTIER_SATIE_MASK);
+
+	stm32_mdf_adc_stop_mdf(indio_dev);
+
+	while (adc->channels[i].backend && i < indio_dev->num_channels) {
+		iio_backend_disable(adc->channels[i].backend);
+		i++;
+	}
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops stm32_mdf_buffer_setup_ops = {
+	.postenable = &stm32_mdf_adc_postenable,
+	.predisable = &stm32_mdf_adc_predisable,
+};
+
+unsigned int stm32_mdf_get_sub_channels_nb(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+
+	if (MDF_IS_FILTER0(adc) && adc->mdf->nb_interleave)
+		return adc->mdf->nb_interleave;
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_get_sub_channels_nb);
+
+static ssize_t stm32_mdf_adc_audio_get_channels(struct iio_dev *indio_dev, uintptr_t priv,
+						const struct iio_chan_spec *chan, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", stm32_mdf_get_sub_channels_nb(indio_dev));
+}
+
+/*
+ * IIO channel extended info used by the audio device IIO channel consumer.
+ * sub_channels_nb: provides the number of audio channels associated to the IIO channel.
+ */
+static const struct iio_chan_spec_ext_info stm32_mdf_adc_audio_ext_info[] = {
+	{
+		.name = "sub_channels_nb",
+		.shared = IIO_SHARED_BY_TYPE,
+		.read = stm32_mdf_adc_audio_get_channels,
+	},
+	{},
+};
+
+static void stm32_mdf_dma_release(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+
+	if (adc && adc->dma_chan) {
+		dma_free_coherent(adc->dma_chan->device->dev,
+				  MDF_DMA_BUFFER_SIZE, adc->rx_buf, adc->dma_buf);
+		dma_release_channel(adc->dma_chan);
+	}
+}
+
+static int stm32_mdf_dma_request(struct device *dev, struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	struct dma_chan *dma_chan;
+
+	dma_chan = dma_request_chan(dev, "rx");
+	if (IS_ERR(dma_chan))
+		return PTR_ERR(dma_chan) ? PTR_ERR(dma_chan) : -ENODEV;
+	adc->dma_chan = dma_chan;
+
+	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
+					 MDF_DMA_BUFFER_SIZE, &adc->dma_buf, GFP_KERNEL);
+	if (!adc->rx_buf) {
+		dma_release_channel(adc->dma_chan);
+		return -ENOMEM;
+	}
+
+	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
+	indio_dev->setup_ops = &stm32_mdf_buffer_setup_ops;
+
+	return 0;
+}
+
+static int stm32_mdf_channel_parse_of(struct iio_dev *indio_dev, struct fwnode_handle *node,
+				      struct iio_chan_spec *ch)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	struct iio_backend *backend;
+	const char *label = fwnode_get_name(node);
+	int ret;
+	u32 stu = 0;
+
+	ret = fwnode_property_read_u32(node, "reg", &ch->channel);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "Failed to read channel index: [%d]\n", ret);
+		return ret;
+	}
+
+	if (fwnode_property_present(node, "label")) {
+		/* label is optional */
+		ret = fwnode_property_read_string(node, "label", &label);
+		if (ret < 0) {
+			dev_err(&indio_dev->dev,
+				" Error parsing 'label' for idx %d\n", ch->channel);
+			return ret;
+		}
+	}
+	adc->channels[ch->scan_index].channel_name = label;
+
+	/* settling-time-us is optional */
+	if (fwnode_property_present(node, "settling-time-us")) {
+		/*
+		 * The settling time is relevant only for the first channel. In case of interleaved
+		 * channels, the settling time of the first configured channel, is applied to other
+		 * channels.
+		 */
+		if (!ch->scan_index) {
+			ret = fwnode_property_read_u32(node, "settling-time-us", &stu);
+			if (ret < 0) {
+				dev_err(&indio_dev->dev, "Failed to read settling time: [%d]\n",
+					ret);
+				return ret;
+			}
+
+			adc->stu = stu;
+		}
+	}
+
+	if (adc->dev_data->type == STM32_MDF_IIO) {
+		backend = devm_iio_backend_fwnode_get(&indio_dev->dev, NULL, node);
+		if (IS_ERR(backend))
+			return dev_err_probe(&indio_dev->dev, PTR_ERR(backend),
+					     "Failed to get backend\n");
+		adc->channels[ch->scan_index].backend = backend;
+	}
+
+	return ret;
+}
+
+static int stm32_mdf_adc_chan_init_one(struct iio_dev *indio_dev, struct fwnode_handle *node,
+				       struct iio_chan_spec *ch, int idx)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	ch->type = IIO_VOLTAGE;
+	ch->indexed = 1;
+	ch->scan_index = idx;
+
+	ret = stm32_mdf_channel_parse_of(indio_dev, node, ch);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "Failed to parse channel [%d]\n", idx);
+		return ret;
+	}
+
+	if (adc->dev_data->type == STM32_MDF_IIO) {
+		ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE) |
+					 BIT(IIO_CHAN_INFO_OFFSET);
+		ch->scan_type.shift = 8;
+	}
+
+	if (adc->dev_data->type == STM32_MDF_AUDIO)
+		ch->ext_info = stm32_mdf_adc_audio_ext_info;
+
+	ch->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ);
+	ch->scan_type.sign = 's';
+	ch->scan_type.realbits = STM32_MDF_DATA_RES;
+	ch->scan_type.storagebits = 32;
+
+	return 0;
+}
+
+static int stm32_mdf_adc_chan_init(struct iio_dev *indio_dev, struct iio_chan_spec *channels)
+{
+	struct fwnode_handle *child;
+	int chan_idx = 0, ret;
+
+	device_for_each_child_node(indio_dev->dev.parent, child) {
+		/* Skip the child nodes with a compatible. (e.g. DAI node for audio) */
+		if (fwnode_property_present(child, "compatible"))
+			continue;
+
+		ret = stm32_mdf_adc_chan_init_one(indio_dev, child, &channels[chan_idx], chan_idx);
+		if (ret < 0) {
+			fwnode_handle_put(child);
+			return dev_err_probe(&indio_dev->dev, ret, "Channels [%d] init failed\n",
+					     chan_idx);
+		}
+
+		chan_idx++;
+	}
+
+	return chan_idx;
+}
+
+static int stm32_mdf_set_watermark(struct iio_dev *indio_dev, unsigned int val)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	unsigned int watermark = MDF_DMA_BUFFER_SIZE / 2;
+	unsigned int rx_buf_sz = MDF_DMA_BUFFER_SIZE;
+
+	/*
+	 * DMA cyclic transfers are used, buffer is split into two periods.
+	 * There should be :
+	 * - always one buffer (period) DMA is working on
+	 * - one buffer (period) driver pushed to ASoC side.
+	 */
+	watermark = min(watermark, val * (unsigned int)(sizeof(u32)));
+	adc->buf_sz = min(rx_buf_sz, watermark * 2);
+
+	return 0;
+}
+
+static int stm32_mdf_adc_single_conv(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan, int *res)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	long timeout;
+	bool save_trgo = adc->trgo;
+	int ret;
+
+	reinit_completion(&adc->completion);
+
+	ret = stm32_mdf_adc_start_mdf(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_set_bits(adc->regmap, MDF_DFLTIER_REG, MDF_DFLTIER_FTHIE_MASK);
+	if (ret < 0)
+		goto err_conv;
+
+	stm32_mdf_adc_filter_set_mode(adc, false);
+
+	/* Force trgo as a workaround for STM32_MDF_ACQ_MODE_ASYNC_SINGLE_SHOT mode */
+	adc->trgo = true;
+
+	ret = stm32_mdf_adc_start_conv(indio_dev);
+	if (ret < 0) {
+		regmap_update_bits(adc->regmap, MDF_DFLTIER_REG, MDF_DFLTIER_FTHIE_MASK, 0);
+		goto err_conv;
+	}
+
+	timeout = wait_for_completion_interruptible_timeout(&adc->completion, STM32_MDF_TIMEOUT_MS);
+
+	regmap_clear_bits(adc->regmap, MDF_DFLTIER_REG, MDF_DFLTIER_FTHIE_MASK);
+
+	if (timeout == 0) {
+		dev_err(&indio_dev->dev, "Timeout reached on channel [%d]", chan->channel);
+		ret = -ETIMEDOUT;
+		goto stop_conv;
+	} else if (timeout < 0) {
+		ret = timeout;
+		goto stop_conv;
+	} else {
+		ret = IIO_VAL_INT;
+	}
+
+	if (MDF_IS_INTERLEAVED_FILT(adc))
+		*res = adc->buffer[chan->channel];
+	else
+		*res = adc->buffer[0];
+
+stop_conv:
+	stm32_mdf_adc_stop_conv(indio_dev);
+
+err_conv:
+	adc->trgo = save_trgo;
+
+	stm32_mdf_adc_stop_mdf(indio_dev);
+
+	return ret;
+}
+
+static int stm32_mdf_adc_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+				   int val, int val2, long mask)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int ret = 0;
+
+	if (mask != IIO_CHAN_INFO_SAMP_FREQ || !val)
+		return -EINVAL;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	/* Set requested_sample_freq right now, as used by mdf_adc_set_samp_freq() */
+	adc->requested_sample_freq = val;
+
+	if (adc->dev_data->type == STM32_MDF_IIO) {
+		ret = stm32_mdf_core_lock_kclk_rate(adc->mdf);
+		if (ret)
+			goto release_direct_mode;
+
+		ret = mdf_adc_set_samp_freq(indio_dev);
+
+		stm32_mdf_core_unlock_kclk_rate(adc->mdf);
+	}
+
+release_direct_mode:
+	iio_device_release_direct(indio_dev);
+
+	if (ret)
+		adc->requested_sample_freq = 0;
+
+	return ret;
+}
+
+static int stm32_mdf_adc_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+				  int *val, int *val2, long mask)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int idx = chan->scan_index;
+	int max = BIT(STM32_MDF_DATA_RES - 1) - 1;
+	int scale, offset;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		if (adc->channels[idx].backend) {
+			ret = iio_backend_enable(adc->channels[idx].backend);
+			if (ret)
+				goto err_release_direct_mode;
+		}
+
+		ret = stm32_mdf_adc_single_conv(indio_dev, chan, val);
+		if (ret)
+			goto err_backend_disable;
+
+		if (adc->channels[idx].backend)
+			iio_backend_disable(adc->channels[idx].backend);
+
+		iio_device_release_direct(indio_dev);
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = adc->sample_freq;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * Vconv = (raw>>shift + offset) * scale.
+		 * scale = Vref * k / 2^res (denominator is managed through FRACTIONAL_LOG2 type)
+		 * k correspond to the ratio between max resolution and actual filter maximum
+		 * k = max / dflt_max
+		 * max = 2^(res - 1) - 1
+		 * max_dflt = D^N * gain_lin * gain_rsflt
+		 * scale = Vref * max / dflt_max
+		 */
+		if (adc->channels[idx].backend) {
+			ret = iio_backend_read_scale(adc->channels[idx].backend, chan,
+						     &scale, NULL);
+			if (ret < 0)
+				return ret;
+
+			*val = div_u64((u64)scale * max, adc->dflt_max);
+
+			*val2 = chan->scan_type.realbits;
+			if (chan->differential)
+				*val *= 2;
+		} else {
+			return -EPERM;
+		}
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	case IIO_CHAN_INFO_OFFSET:
+		if (adc->channels[idx].backend) {
+			ret = iio_backend_read_offset(adc->channels[idx].backend, chan,
+						      &offset, NULL);
+			if (ret < 0)
+				return ret;
+
+			*val = offset;
+			if (!chan->differential)
+				*val += adc->dflt_max;
+		} else {
+			return -EPERM;
+		}
+
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+
+err_backend_disable:
+	if (adc->channels[idx].backend)
+		iio_backend_disable(adc->channels[idx].backend);
+err_release_direct_mode:
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
+
+static int stm32_mdf_adc_read_label(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+				    char *label)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	const char *name = adc->channels[chan->scan_index].channel_name;
+
+	return sysfs_emit(label, "%s\n", name);
+}
+
+static const struct iio_info stm32_mdf_info_audio = {
+	.hwfifo_set_watermark = stm32_mdf_set_watermark,
+	.write_raw = stm32_mdf_adc_write_raw,
+	.read_raw = stm32_mdf_adc_read_raw,
+	.read_label = stm32_mdf_adc_read_label,
+};
+
+static const struct iio_info stm32_mdf_info_adc = {
+	.hwfifo_set_watermark = stm32_mdf_set_watermark,
+	.write_raw = stm32_mdf_adc_write_raw,
+	.read_raw = stm32_mdf_adc_read_raw,
+	.read_label = stm32_mdf_adc_read_label,
+	.validate_trigger = stm32_mdf_adc_get_trig,
+};
+
+static irqreturn_t stm32_mdf_irq(int irq, void *arg)
+{
+	struct iio_dev *indio_dev = arg;
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev), *adc_inter;
+	struct regmap *regmap = adc->regmap;
+	u32 *ptr = adc->buffer;
+	u32 isr, ier, flags;
+
+	regmap_read(regmap, MDF_DFLTISR_REG, &isr);
+	regmap_read(regmap, MDF_DFLTIER_REG, &ier);
+
+	flags = isr & ier;
+	if (!flags)
+		return IRQ_NONE;
+
+	if (flags & MDF_DFLTISR_FTHF_MASK) {
+		/* Reading the data register clear the IRQ status */
+		regmap_read(regmap, MDF_DFLTDR_REG, ptr++);
+
+		if (MDF_IS_FILTER0(adc))
+			list_for_each_entry(adc_inter, &adc->mdf->filter_list, entry)
+				if (MDF_IS_INTERLEAVED_FILT_NOT_0(adc_inter))
+					regmap_read(regmap, MDF_DFLTDR_REG, ptr++);
+
+		complete(&adc->completion);
+	}
+
+	if (flags & MDF_DFLTISR_DOVRF_MASK) {
+		dev_warn(&indio_dev->dev, "Data overflow detected\n");
+		regmap_set_bits(regmap, MDF_DFLTISR_REG, MDF_DFLTISR_DOVRF_MASK);
+	}
+
+	if (flags & MDF_DFLTISR_RFOVRF_MASK) {
+		dev_warn(&indio_dev->dev, "Reshape filter overrun detected\n");
+		regmap_set_bits(regmap, MDF_DFLTISR_REG, MDF_DFLTISR_RFOVRF_MASK);
+	}
+
+	if (flags & MDF_DFLTISR_SATF_MASK) {
+		dev_warn(&indio_dev->dev, "Saturation detected\n");
+		regmap_set_bits(regmap, MDF_DFLTISR_REG, MDF_DFLTISR_SATF_MASK);
+
+		/* Notify only once */
+		regmap_clear_bits(adc->regmap, MDF_DFLTIER_REG, MDF_DFLTIER_SATIE_MASK);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int stm32_mdf_audio_init(struct device *dev, struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	struct iio_chan_spec *ch;
+	int ret;
+
+	ch = devm_kzalloc(&indio_dev->dev, sizeof(*ch), GFP_KERNEL);
+	if (!ch)
+		return -ENOMEM;
+
+	adc->channels = devm_kzalloc(&indio_dev->dev, sizeof(*adc->channels), GFP_KERNEL);
+	if (!adc->channels)
+		return -ENOMEM;
+
+	ret = stm32_mdf_adc_chan_init(indio_dev, ch);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Channels init failed\n");
+
+	indio_dev->num_channels = 1;
+	indio_dev->channels = ch;
+
+	ret = stm32_mdf_dma_request(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get DMA\n");
+
+	ret =  stm32_mdf_adc_filter_set_mode(adc, true);
+	if (ret)
+		stm32_mdf_dma_release(indio_dev);
+
+	return ret;
+}
+
+static int stm32_mdf_adc_init(struct device *dev, struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	struct iio_chan_spec *ch = NULL;
+	unsigned int num_ch;
+	int ret;
+
+	num_ch = device_get_child_node_count(indio_dev->dev.parent);
+	if (num_ch) {
+		/* Filter0 may have several channels in interleaved mode */
+		if (num_ch > 1) {
+			if (!MDF_IS_FILTER0(adc)) {
+				dev_err(dev, "Too many channels for filter [%d]\n", adc->fl_id);
+				return -EINVAL;
+			} else if (num_ch != adc->mdf->nb_interleave) {
+				dev_err(dev, "Unexpected channels number for filter0: [%d]\n",
+					num_ch);
+				return -EINVAL;
+			}
+		}
+
+		ch = devm_kcalloc(&indio_dev->dev, num_ch, sizeof(*ch), GFP_KERNEL);
+		if (!ch)
+			return -ENOMEM;
+
+		adc->channels = devm_kcalloc(&indio_dev->dev, num_ch, sizeof(*adc->channels),
+					     GFP_KERNEL);
+		if (!adc->channels)
+			return -ENOMEM;
+
+		ret = stm32_mdf_adc_chan_init(indio_dev, ch);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "Channels init failed\n");
+	}
+
+	indio_dev->num_channels = num_ch;
+	indio_dev->channels = ch;
+
+	init_completion(&adc->completion);
+
+	/* Optionally request DMA */
+	ret = stm32_mdf_dma_request(dev, indio_dev);
+	if (ret) {
+		if (ret != -ENODEV)
+			return dev_err_probe(dev, ret, "DMA channel request failed with\n");
+
+		dev_dbg(dev, "No DMA support\n");
+		return 0;
+	}
+
+	ret = iio_triggered_buffer_setup(indio_dev,
+					 &iio_pollfunc_store_time, NULL,
+					 &stm32_mdf_buffer_setup_ops);
+	if (ret) {
+		stm32_mdf_dma_release(indio_dev);
+		dev_err(&indio_dev->dev, "buffer setup failed\n");
+		return ret;
+	}
+
+	/* lptimer/timer hardware triggers */
+	indio_dev->modes |= INDIO_HARDWARE_TRIGGERED;
+
+	return 0;
+}
+
+static const struct stm32_mdf_dev_data stm32h7_mdf_adc_data = {
+	.type = STM32_MDF_IIO,
+	.init = stm32_mdf_adc_init,
+};
+
+static const struct stm32_mdf_dev_data stm32_mdf_audio_data = {
+	.type = STM32_MDF_AUDIO,
+	.init = stm32_mdf_audio_init,
+};
+
+/**
+ * stm32_mdf_get_buff_cb() - register a callback that will be called when
+ *                           DMA transfer period is achieved.
+ *
+ * @iio_dev: Handle to IIO device.
+ * @cb: Pointer to callback function:
+ *      - data: pointer to data buffer
+ *      - size: size in byte of the data buffer
+ *      - private: pointer to consumer private structure.
+ * @private: Pointer to consumer private structure.
+ */
+int stm32_mdf_get_buff_cb(struct iio_dev *iio_dev,
+			  int (*cb)(const void *data, size_t size, void *private), void *private)
+{
+	struct stm32_mdf_adc *adc;
+
+	if (!iio_dev)
+		return -EINVAL;
+	adc = iio_priv(iio_dev);
+
+	if (!adc)
+		return -EINVAL;
+
+	adc->cb = cb;
+	adc->cb_priv = private;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_get_buff_cb);
+
+/**
+ * stm32_mdf_release_buff_cb - unregister buffer callback
+ *
+ * @iio_dev: Handle to IIO device.
+ */
+int stm32_mdf_release_buff_cb(struct iio_dev *iio_dev)
+{
+	struct stm32_mdf_adc *adc;
+
+	if (!iio_dev)
+		return -EINVAL;
+	adc = iio_priv(iio_dev);
+
+	if (!adc)
+		return -EINVAL;
+
+	adc->cb = NULL;
+	adc->cb_priv = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_release_buff_cb);
+
+static const struct of_device_id stm32_mdf_adc_match[] = {
+	{
+		.compatible = "st,stm32mp25-mdf-adc",
+		.data = &stm32h7_mdf_adc_data,
+	},
+	{
+		.compatible = "st,stm32mp25-mdf-dmic",
+		.data = &stm32_mdf_audio_data,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, stm32_mdf_adc_match);
+
+static int stm32_mdf_get_sitf(struct device *dev, struct stm32_mdf_adc *adc,
+			      struct fwnode_handle *sitf_node)
+{
+	struct stm32_mdf_sitf *sitf;
+
+	/* Look for sitf interface from node handle */
+	list_for_each_entry(sitf, &adc->mdf->sitf_list, entry) {
+		if (sitf->node == sitf_node) {
+			adc->sitf = sitf;
+			break;
+		}
+	}
+
+	if (!adc->sitf) {
+		dev_dbg(dev, "Serial interface not registered\n");
+		return -EPROBE_DEFER;
+	}
+
+	return 0;
+}
+
+static int stm32_mdf_get_filters_config(struct device *dev, struct stm32_mdf_adc *adc)
+{
+	int i, ret;
+	u32 val;
+
+	ret = device_property_read_u32(dev, "st,cic-mode", &val);
+	if (ret) {
+		dev_err(dev, "Could not get cic filter mode: %d\n", ret);
+		return ret;
+	}
+	adc->cicmode = val;
+
+	adc->rsflt_bypass = device_property_present(dev, "st,rs-filter-bypass");
+
+	adc->hpf_cutoff = STM32_MDF_HPF_BYPASS;
+	if (device_property_present(dev, "st,hpf-filter-cutoff-bp")) {
+		ret = device_property_read_u32(dev, "st,hpf-filter-cutoff-bp", &val);
+		if (ret) {
+			dev_err(dev, "Could not read HPF cut-off frequency: %d\n", ret);
+			return ret;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(stm32_mdf_hpf_cutoff_ratio); i++) {
+			if (stm32_mdf_hpf_cutoff_ratio[i] == val) {
+				adc->hpf_cutoff = i;
+				break;
+			}
+		}
+
+		if (adc->hpf_cutoff == STM32_MDF_HPF_BYPASS) {
+			dev_err(dev, "Unknown HPF cut-off frequency ratio: %d\n", val);
+			return -EINVAL;
+		}
+	}
+
+	dev_dbg(dev, "Filter [%d] config: cic mode [%d], rsflt [%s], hpf [%s]\n", adc->fl_id,
+		adc->cicmode, adc->rsflt_bypass ? "off" : "on",
+		adc->hpf_cutoff == STM32_MDF_HPF_BYPASS ? "off" : "on");
+
+	return 0;
+}
+
+static int stm32_mdf_adc_parse_of(struct platform_device *pdev, struct stm32_mdf_adc *adc)
+{
+	struct device *dev = &pdev->dev;
+	struct stm32_mdf_adc *adcm;
+	struct fwnode_handle *sitf_node;
+	struct fwnode_handle *filt_node;
+	struct fwnode_reference_args args;
+	int i, ret, stream, buf_size = 1;
+	u32 idx, bsmx, val;
+
+	ret = device_property_read_u32(dev, "reg", &idx);
+	if (ret) {
+		dev_err(dev, "Could not get filter index: %d\n", ret);
+		return ret;
+	}
+
+	if ((idx - 4) % 0x80) {
+		dev_err(dev, "Unexpected reg property value [%x]\n", idx);
+		return -EINVAL;
+	}
+
+	adc->fl_id = (idx >> 7) - 1;
+	if (adc->fl_id >= adc->mdf->nbf) {
+		dev_err(dev, "Wrong filter index [%d]\n", adc->fl_id);
+		return -EINVAL;
+	}
+	adc->node = dev_fwnode(dev);
+
+	if (device_property_present(&pdev->dev, "st,sync")) {
+		filt_node = fwnode_find_reference(dev_fwnode(dev), "st,sync", 0);
+		if (IS_ERR(filt_node)) {
+			dev_err(dev, "Failed to get filter sync handle %ld\n", PTR_ERR(filt_node));
+			return PTR_ERR(filt_node);
+		}
+		adc->synced = true;
+
+		adcm = stm32_mdf_get_filter_by_handle(adc->mdf, filt_node);
+		if (!adcm)
+			return dev_err_probe(dev, -EPROBE_DEFER, "Failed to get filter synchro\n");
+
+		/* The Synchronized master filter is the TRGO trigger source */
+		adcm->trgo = true;
+	}
+
+	if (device_property_present(&pdev->dev, "st,delay")) {
+		ret = device_property_read_u32(dev, "st,delay", &val);
+		if (ret) {
+			dev_err(dev, "Could not get filter delay: %d\n", ret);
+			return ret;
+		}
+		adc->delay = val;
+	}
+
+	/*
+	 * In interleave mode the filters in range [1..n] share their configuration with filter 0.
+	 * In this case, use config from filter 0, instead of parsing DT.
+	 */
+	if (!MDF_IS_FILTER0(adc) && adc->fl_id < adc->mdf->nb_interleave) {
+		/* Check if filter is in interleave filter list */
+		for (i = 0; i < adc->mdf->nb_interleave; i++) {
+			if (adc->mdf->fh_interleave[i] == adc->node) {
+				adc->interleaved = true;
+				break;
+			}
+		}
+
+		if (!adc->interleaved) {
+			dev_err(dev, "Filter [%d] not in interleave property\n", adc->fl_id);
+			return -EINVAL;
+		}
+	} else {
+		ret = stm32_mdf_get_filters_config(dev, adc);
+		if (ret)
+			return ret;
+
+		if (MDF_IS_FILTER0(adc) && adc->mdf->nb_interleave) {
+			/* Filter 0 is the TRGO trigger source in interleave mode */
+			adc->trgo = true;
+			adc->interleaved = true;
+			buf_size = adc->mdf->nb_interleave;
+		}
+	}
+
+	adc->buffer = kcalloc(buf_size, sizeof(u32), GFP_KERNEL);
+	if (!adc->buffer)
+		return -ENOMEM;
+
+	/* Retrieve serial interface */
+	ret = fwnode_property_get_reference_args(dev_fwnode(dev), "st,sitf", NULL, 1, 0, &args);
+	if (ret) {
+		dev_err(dev, "Serial interface node not found: %d\n", ret);
+		return ret;
+	}
+	sitf_node = args.fwnode;
+
+	/* Get stream index */
+	if (args.nargs != 1) {
+		dev_err(dev, "Failed to get stream index in st,sitf property\n");
+		return -EINVAL;
+	}
+	stream = args.args[0];
+
+	/* Retrieve sitf data from sitf node phanle */
+	ret = stm32_mdf_get_sitf(dev, adc, sitf_node);
+	if (ret)
+		return ret;
+
+	bsmx = adc->sitf->id * 2 + stream;
+
+	dev_dbg(dev, "Digital filter [%d] linked to sitf [%d]\n", adc->fl_id, adc->sitf->id);
+
+	/* Only support BSMX filter source right now */
+	adc->datsrc = STM32_MDF_DATSRC_BSMX;
+
+	list_add(&adc->entry, &adc->mdf->filter_list);
+
+	/* Configure BSMXCR */
+	regmap_update_bits(adc->regmap, MDF_BSMXCR_REG,
+			   MDF_BSMXCR_BSSEL_MASK, MDF_BSMXCR_BSSEL(bsmx));
+
+	return 0;
+}
+
+static int stm32_mdf_adc_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct stm32_mdf_adc *adc;
+	const struct stm32_mdf_dev_data *dev_data;
+	struct iio_dev *iio;
+	struct resource *res;
+	void __iomem *base;
+	int ret, irq;
+
+	dev_data = of_device_get_match_data(dev);
+	iio = devm_iio_device_alloc(dev, sizeof(*adc));
+	if (!iio) {
+		dev_err(dev, "Failed to allocate IIO device\n");
+		return -ENOMEM;
+	}
+	iio->modes = INDIO_DIRECT_MODE;
+
+	adc = iio_priv(iio);
+	adc->mdf = dev_get_drvdata(dev->parent);
+
+	platform_set_drvdata(pdev, iio);
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base), "Failed to get resource\n");
+	adc->phys_addr = res->start;
+
+	adc->regmap = devm_regmap_init_mmio_clk(dev, "ker_ck", base, &stm32_mdf_regmap_cfg);
+	if (IS_ERR(adc->regmap))
+		return dev_err_probe(dev, PTR_ERR(adc->regmap), "Failed to get kernel clock\n");
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get IRQ\n");
+
+	ret = devm_request_irq(dev, irq, stm32_mdf_irq, 0, pdev->name, iio);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
+
+	ret = stm32_mdf_adc_parse_of(pdev, adc);
+	if (ret < 0)
+		return ret;
+
+	if (dev_data->type == STM32_MDF_AUDIO)
+		iio->info = &stm32_mdf_info_audio;
+	else
+		iio->info = &stm32_mdf_info_adc;
+	iio->name = dev_name(&pdev->dev);
+
+	adc->dev = dev;
+	adc->dev_data = dev_data;
+	ret = dev_data->init(dev, iio);
+	if (ret < 0)
+		goto err_clean_list;
+
+	if (!MDF_IS_INTERLEAVED_FILT_NOT_0(adc)) {
+		ret = iio_device_register(iio);
+		if (ret < 0) {
+			dev_err_probe(dev, ret, "Failed to register IIO device: %d\n", ret);
+			goto err_cleanup;
+		}
+	}
+
+	if (dev_data->type == STM32_MDF_AUDIO) {
+		ret = of_platform_populate(node, NULL, NULL, dev);
+		if (ret < 0) {
+			dev_err_probe(dev, ret, "Failed to find an audio DAI\n");
+			goto err_unregister;
+		}
+	}
+
+	return 0;
+
+err_unregister:
+	iio_device_unregister(iio);
+err_cleanup:
+	stm32_mdf_dma_release(iio);
+err_clean_list:
+	list_del(&adc->entry);
+
+	return ret;
+}
+
+static void stm32_mdf_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+
+	if (adc->dev_data->type == STM32_MDF_AUDIO)
+		of_platform_depopulate(&pdev->dev);
+	if (!MDF_IS_INTERLEAVED_FILT_NOT_0(adc))
+		iio_device_unregister(indio_dev);
+	stm32_mdf_dma_release(indio_dev);
+
+	list_del(&adc->entry);
+}
+
+static int stm32_mdf_adc_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int ret = 0;
+
+	if (iio_buffer_enabled(indio_dev))
+		ret = stm32_mdf_adc_predisable(indio_dev);
+
+	regcache_cache_only(adc->regmap, true);
+	regcache_mark_dirty(adc->regmap);
+
+	return ret;
+}
+
+static int stm32_mdf_adc_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	regcache_cache_only(adc->regmap, false);
+	ret = regcache_sync(adc->regmap);
+
+	if (!ret && iio_buffer_enabled(indio_dev))
+		ret = stm32_mdf_adc_postenable(indio_dev);
+
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(stm32_mdf_adc_pm_ops, stm32_mdf_adc_suspend, stm32_mdf_adc_resume);
+
+static struct platform_driver stm32_mdf_adc_driver = {
+	.driver = {
+		.name = "stm32-mdf-adc",
+		.of_match_table = stm32_mdf_adc_match,
+		.pm = &stm32_mdf_adc_pm_ops,
+	},
+	.probe = stm32_mdf_adc_probe,
+	.remove = stm32_mdf_adc_remove,
+};
+module_platform_driver(stm32_mdf_adc_driver);
+
+MODULE_DESCRIPTION("STM32 MDF sigma delta ADC");
+MODULE_AUTHOR("Olivier Moysan <olivier.moysan@foss.st.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_BACKEND");
diff --git a/drivers/iio/adc/stm32-mdf-core.c b/drivers/iio/adc/stm32-mdf-core.c
new file mode 100644
index 000000000000..cb46980af525
--- /dev/null
+++ b/drivers/iio/adc/stm32-mdf-core.c
@@ -0,0 +1,857 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * This file is part of STM32 MDF driver
+ *
+ * Copyright (C) 2023, STMicroelectronics - All Rights Reserved
+ * Author: Olivier Moysan <olivier.moysan@foss.st.com>.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/gcd.h>
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
+ * @cck_freq: output cck clocks frequency requested in DT
+ * @cck_freq_actual: actual output cck clocks frequency
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
+	unsigned long cck_freq;
+	unsigned long cck_freq_actual;
+	bool exclusive_flg;
+};
+
+#define STM32_MDF_MAX_CCK 2
+#define STM32_MDF_MP23_FILTER_NB 4
+
+struct clk_mdf_cck {
+	struct clk_hw	hw;
+	struct stm32_mdf_priv *priv;
+};
+
+#define to_clk_mdf_cck(_hw) container_of(_hw, struct clk_mdf_cck, hw)
+
+static inline struct stm32_mdf_priv *to_stm32_mdf_priv(struct stm32_mdf *mdf)
+{
+	return container_of(mdf, struct stm32_mdf_priv, mdf);
+}
+
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
+int stm32_mdf_core_trigger(struct stm32_mdf *mdf)
+{
+	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
+	int ret;
+	u32 val;
+
+	spin_lock(&priv->lock);
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
+	spin_unlock(&priv->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_core_trigger);
+
+unsigned long stm32_mdf_core_get_cck(struct stm32_mdf *mdf)
+{
+	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
+
+	return priv->cck_freq_actual;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_core_get_cck);
+
+int stm32_mdf_core_lock_kclk_rate(struct stm32_mdf *mdf)
+{
+	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
+	struct device *dev = &priv->pdev->dev;
+	int ret;
+
+	if (!atomic_read(&priv->n_active_ch)) {
+		/* Request rate exclusivity on kernel clock right now */
+		ret = clk_rate_exclusive_get(priv->kclk);
+		if (ret < 0) {
+			dev_err(dev, "Failed to get exclusive rate on kernel clock: [%d]\n", ret);
+			return ret;
+		}
+
+		priv->exclusive_flg = true;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_core_lock_kclk_rate);
+
+void stm32_mdf_core_unlock_kclk_rate(struct stm32_mdf *mdf)
+{
+	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
+
+	if (!atomic_read(&priv->n_active_ch)) {
+		clk_rate_exclusive_put(priv->kclk);
+		priv->exclusive_flg = false;
+	}
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_core_unlock_kclk_rate);
+
+int stm32_mdf_core_restore_cck(struct stm32_mdf *mdf)
+{
+	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
+	struct device *dev = &priv->pdev->dev;
+	int ret;
+
+	ret = clk_set_rate(priv->kclk, priv->kclk_rate);
+	if (ret) {
+		dev_err(dev, "Failed to change kernel clock rate from [%lu]Hz to [%lu]Hz: [%d]\n",
+			clk_get_rate(priv->kclk), priv->kclk_rate, ret);
+		return ret;
+	}
+
+	dev_dbg(dev, "MDF kernel clock rate changed to [%lu]Hz.\n", priv->kclk_rate);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_core_restore_cck);
+
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
+static int stm32_mdf_core_cck_divider_set_rate(struct platform_device *pdev,
+					       struct stm32_mdf_priv *priv,
+					       unsigned long parent_rate)
+{
+	struct device *dev = &pdev->dev;
+	unsigned long rate = priv->cck_freq;
+	unsigned long ratio, delta, delta_ppm;
+	unsigned int cckdiv, procdiv;
+
+	ratio = DIV_ROUND_CLOSEST(parent_rate, rate);
+	if (!ratio) {
+		dev_err(dev, "CCK frequency above kernel frequency\n");
+		return -EINVAL;
+	}
+
+	delta = abs(parent_rate - (ratio * rate));
+
+	delta_ppm = (1000000 * delta) / parent_rate;
+	priv->cck_freq_actual = DIV_ROUND_CLOSEST(parent_rate, ratio);
+
+	if (delta_ppm > 1000) {
+		/* If frequency deviation is higher than 1000 ppm return error */
+		dev_dbg(dev, "CCK clock deviation [%lu] ppm too large: [%lu] vs [%lu] Hz\n",
+			delta_ppm, priv->cck_freq_actual, rate);
+		return -EINVAL;
+	} else if (delta_ppm) {
+		dev_dbg(dev, "CCK clock frequency not accurate: [%lu] ppm deviation\n", delta_ppm);
+	}
+
+	/*
+	 * The total divider ratio must be split between proc divider and
+	 * cck divider. Try to maximize cck divider first, to help fulfilling
+	 * frequency ratio requirements between fproc and fcck.
+	 */
+	cckdiv = gcd(ratio, MDF_CKG_CCKDIV_MAX);
+	procdiv = ratio / cckdiv;
+
+	if (procdiv > MDF_PROCDIV_MAX) {
+		dev_err(dev, "Proc divider out of range: %u > %lu\n", procdiv, MDF_PROCDIV_MAX);
+		return -EINVAL;
+	}
+
+	priv->mdf.fproc = DIV_ROUND_CLOSEST(parent_rate, procdiv);
+
+	/* Configure CKGCR register */
+	dev_dbg(dev, "Set MDF dividers: CCKDIV [%d], PROCDIV [%d]\n", cckdiv, procdiv);
+	return regmap_update_bits(priv->regmap, MDF_CKGCR_REG,
+				  MDF_CKG_CCKDIV_MASK | MDF_CKG_PROCDIV_MASK,
+				  MDF_CKG_CCKDIV(cckdiv - 1) |
+				  MDF_CKG_PROCDIV(procdiv - 1));
+}
+
+static int stm32_mdf_core_cck_set_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long parent_rate)
+{
+	struct clk_mdf_cck *clk = to_clk_mdf_cck(hw);
+	struct stm32_mdf_priv *priv = clk->priv;
+
+	return stm32_mdf_core_cck_divider_set_rate(priv->pdev, priv, parent_rate);
+}
+
+static int stm32_mdf_core_cck_determine_rate(struct clk_hw *hw,
+					     struct clk_rate_request *req)
+{
+	struct clk_mdf_cck *clk = to_clk_mdf_cck(hw);
+	struct stm32_mdf_priv *priv = clk->priv;
+	struct platform_device *pdev = priv->pdev;
+	unsigned long ratio;
+
+	ratio = DIV_ROUND_CLOSEST(req->best_parent_rate, req->rate);
+	if (!ratio) {
+		dev_err(&pdev->dev, "CCK frequency above kernel frequency\n");
+		return -EINVAL;
+	}
+
+	req->rate = DIV_ROUND_CLOSEST(req->best_parent_rate, ratio);
+
+	return 0;
+}
+
+static unsigned long stm32_mdf_core_cck_divider_recalc_rate(struct clk_hw *hw,
+							    unsigned long parent_rate)
+{
+	struct clk_mdf_cck *clk = to_clk_mdf_cck(hw);
+	struct stm32_mdf_priv *priv = clk->priv;
+	unsigned int val;
+	unsigned int ratio;
+	int ret;
+
+	ret = regmap_read(priv->regmap, MDF_CKGCR_REG, &val);
+	if (ret)
+		/* Gives a hint that something is wrong */
+		return 0;
+
+	ratio = (FIELD_GET(MDF_CKG_PROCDIV_MASK, val) + 1) *
+		(FIELD_GET(MDF_CKG_CCKDIV_MASK, val) + 1);
+
+	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate, ratio);
+};
+
+static const struct clk_ops clk_cck_ops = {
+	.recalc_rate = stm32_mdf_core_cck_divider_recalc_rate,
+	.set_rate = stm32_mdf_core_cck_set_rate,
+	.determine_rate = stm32_mdf_core_cck_determine_rate,
+};
+
+static struct clk_mdf_cck clk_cck;
+
+struct clk_cckx_gate {
+	struct clk_hw hw;
+	struct regmap	*map;
+	u32		map_offset;
+	u8		bit_idx;
+	u8		flags;
+	spinlock_t	*lock; /* Protect cckx gating */
+};
+
+#define to_clk_cckx_gate(_hw) container_of(_hw, struct clk_cckx_gate, hw)
+
+static inline u32 clk_cckx_gate_readl(struct clk_cckx_gate *gate)
+{
+	u32 val;
+
+	regmap_read(gate->map, gate->map_offset, &val);
+
+	return val;
+}
+
+static inline void clk_cckx_gate_writel(struct clk_cckx_gate *gate, u32 val)
+{
+	regmap_write(gate->map, gate->map_offset, val);
+}
+
+static void clk_cckx_gate_endisable(struct clk_hw *hw, int enable)
+{
+	struct clk_cckx_gate *gate = to_clk_cckx_gate(hw);
+	unsigned long flags = 0;
+	u32 reg;
+
+	if (gate->lock)
+		spin_lock_irqsave(gate->lock, flags);
+	else
+		__acquire(gate->lock);
+
+	reg = clk_cckx_gate_readl(gate);
+
+	if (enable)
+		reg |= BIT(gate->bit_idx);
+	else
+		reg &= ~BIT(gate->bit_idx);
+
+	clk_cckx_gate_writel(gate, reg);
+
+	if (gate->lock)
+		spin_unlock_irqrestore(gate->lock, flags);
+	else
+		__release(gate->lock);
+}
+
+static int clk_cckx_gate_enable(struct clk_hw *hw)
+{
+	clk_cckx_gate_endisable(hw, 1);
+
+	return 0;
+}
+
+static void clk_cckx_gate_disable(struct clk_hw *hw)
+{
+	clk_cckx_gate_endisable(hw, 0);
+}
+
+static int clk_cckx_gate_is_enabled(struct clk_hw *hw)
+{
+	struct clk_cckx_gate *gate = to_clk_cckx_gate(hw);
+	u32 reg;
+
+	reg = clk_cckx_gate_readl(gate);
+
+	reg &= BIT(gate->bit_idx);
+
+	return reg ? 1 : 0;
+}
+
+static const struct clk_ops clk_cckx_gate_ops = {
+	.enable = clk_cckx_gate_enable,
+	.disable = clk_cckx_gate_disable,
+	.is_enabled = clk_cckx_gate_is_enabled,
+};
+
+static struct clk_cckx_gate clk_cck0 = {
+	.map_offset = MDF_CKGCR_REG,
+	.bit_idx = 1,
+};
+
+static struct clk_cckx_gate clk_cck1 = {
+	.map_offset = MDF_CKGCR_REG,
+	.bit_idx = 2,
+};
+
+static int stm32_mdf_core_register_clock_provider(struct platform_device *pdev,
+						  struct stm32_mdf_priv *priv)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct clk_hw_onecell_data *clk_data;
+	struct property *prop;
+	const char *clk_name;
+	u32 ckgcr = 0;
+	int index = 0, ret, clk_id;
+	struct clk_hw *mdf_hw[] = { &clk_cck0.hw, &clk_cck1.hw };
+	struct clk_cckx_gate *gate;
+
+	clk_cck.hw.init = CLK_HW_INIT_FW_NAME("clk_cck", "ker_ck", &clk_cck_ops, 0);
+	clk_cck0.hw.init = CLK_HW_INIT_HW(STM32_MDF_CCK0, &clk_cck.hw, &clk_cckx_gate_ops,
+					  CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED);
+	clk_cck1.hw.init = CLK_HW_INIT_HW(STM32_MDF_CCK1, &clk_cck.hw, &clk_cckx_gate_ops,
+					  CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED);
+
+	clk_cck.priv = priv;
+
+	ret = devm_clk_hw_register(dev, &clk_cck.hw);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register clk_cck");
+
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, STM32_MDF_MAX_CCK), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	of_property_for_each_string(node, "clock-output-names", prop, clk_name) {
+		if (index >= STM32_MDF_MAX_CCK) {
+			dev_err(dev, "Too many cck providers defined\n");
+			return -EINVAL;
+		}
+
+		if (!strncmp(clk_name, "cck0", 4)) {
+			clk_id = 0;
+		} else if (!strncmp(clk_name, "cck1", 4)) {
+			clk_id = 1;
+		} else {
+			dev_err(dev, "Unexpected cck clock provider name [%s]\n", clk_name);
+			return -EINVAL;
+		}
+
+		gate = to_clk_cckx_gate(mdf_hw[clk_id]);
+		gate->map = priv->regmap;
+
+		ret = devm_clk_hw_register(dev, mdf_hw[clk_id]);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to register %s clock provider",
+					     clk_name);
+
+		clk_data->hws[index] = mdf_hw[clk_id];
+
+		/* Configure the CCKx clock as output */
+		ckgcr |= clk_id ? MDF_CKG_CCK1DIR : MDF_CKG_CCK0DIR;
+
+		index++;
+	}
+
+	/*
+	 * Set num to max number of clock. This allows any clocks indice below maximum
+	 * in of_clk_hw_onecell_get, whatever the actual number of providers.
+	 */
+	clk_data->num = STM32_MDF_MAX_CCK;
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
+	if (ret) {
+		dev_err(dev, "Failed to add %s clock provider: %d\n",
+			clk_name ? clk_name : "", ret);
+		return ret;
+	}
+
+	/* Configure CKGCR register */
+	return regmap_update_bits(priv->regmap, MDF_CKGCR_REG,
+				  MDF_CKG_CCK1DIR | MDF_CKG_CCK0DIR, ckgcr);
+}
+
+static int stm32_mdf_core_of_cck_get(struct platform_device *pdev, struct stm32_mdf_priv *priv)
+{
+	struct device *dev = &pdev->dev;
+	u32 freq;
+	int ret;
+
+	ret = device_property_read_u32(dev, "clock-frequency", &freq);
+	if (ret < 0) {
+		/* If property does not exist return immediately */
+		if (ret == -EINVAL)
+			return 0;
+
+		dev_err(dev, "Failed to read clock-frequency property: %d\n", ret);
+		return ret;
+	}
+
+	if (!freq) {
+		dev_err(dev, "Null frequency not allowed for cck output frequency\n");
+		return -EINVAL;
+	}
+	priv->cck_freq = freq;
+
+	return 0;
+}
+
+static int stm32_mdf_core_parse_clocks(struct platform_device *pdev, struct stm32_mdf_priv *priv)
+{
+	struct device *dev = &pdev->dev;
+	struct clk *kclk;
+	int ret;
+
+	kclk = devm_clk_get(dev, "ker_ck");
+	if (IS_ERR(kclk))
+		return dev_err_probe(dev, PTR_ERR(kclk), "Failed to get kernel clock\n");
+
+	priv->kclk = kclk;
+	priv->kclk_rate = clk_get_rate(kclk);
+
+	/* CCK0 and CCK1 clocks are optional. Used only in SPI master modes. */
+	ret = stm32_mdf_core_of_cck_get(pdev, priv);
+	if (ret)
+		return ret;
+
+	if (priv->cck_freq) {
+		ret = stm32_mdf_core_cck_divider_set_rate(pdev, priv, priv->kclk_rate);
+		if (ret) {
+			dev_err(dev, "Failed to set cck rate: %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = stm32_mdf_core_register_clock_provider(pdev, priv);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int stm32_mdf_core_parse_of(struct platform_device *pdev, struct stm32_mdf_priv *priv)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct reset_control *rst;
+	struct device *dev = &pdev->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	struct fwnode_handle *handle;
+	struct fwnode_handle **fh;
+	int count, ret, i;
+
+	if (!node)
+		return -EINVAL;
+
+	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, "mdf");
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset controller\n");
+
+	ret = reset_control_reset(rst);
+	if (ret) {
+		dev_err(&pdev->dev, "reset_control_reset failed %d\n", ret);
+		return ret;
+	}
+
+	ret = stm32_mdf_core_parse_clocks(pdev, priv);
+	if (ret < 0)
+		return ret;
+
+	if (device_property_present(&pdev->dev, "st,interleave")) {
+		count = fwnode_property_count_u32(fwnode, "st,interleave");
+		if (count < 2 || count > priv->mdf.nbf) {
+			dev_err(dev, "Wrong interleave filters number [%d]\n", count);
+			return -EINVAL;
+		}
+
+		fh = devm_kzalloc(dev, count * sizeof(*fh), GFP_KERNEL);
+		if (!fh)
+			return -ENOMEM;
+		priv->mdf.fh_interleave = fh;
+
+		for (i = 0; i < count; i++) {
+			handle = fwnode_find_reference(fwnode, "st,interleave", i);
+			if (IS_ERR(handle)) {
+				dev_err(dev, "Failed to read filter handle: %ld\n",
+					PTR_ERR(handle));
+				return PTR_ERR(handle);
+			}
+			priv->mdf.fh_interleave[i] = handle;
+		}
+
+		priv->mdf.nb_interleave = count;
+
+		/* Configure GCR */
+		ret = regmap_update_bits(priv->regmap, MDF_GCR_REG,
+					 MDF_GCR_ILVNB_MASK, MDF_GCR_ILVNB(count - 1));
+	}
+
+	return ret;
+}
+
+static const struct of_device_id stm32_mdf_of_match[] = {
+	{ .compatible = "st,stm32mp25-mdf" },
+	{ .compatible = "st,stm32mp23-mdf", .data = (void *)STM32_MDF_MP23_FILTER_NB },
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
+	mdf->nbf = (uintptr_t)device_get_match_data(&pdev->dev);
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
+	priv->regmap =
+		devm_regmap_init_mmio_clk(&pdev->dev, "ker_ck", priv->base, &stm32_mdf_regmap_cfg);
+	if (IS_ERR(priv->regmap)) {
+		ret = PTR_ERR(priv->regmap);
+		dev_err(&pdev->dev, "Failed to allocate regmap: %d\n", ret);
+		return ret;
+	}
+
+	ret = stm32_mdf_core_identification(pdev, priv);
+	if (ret < 0)
+		return ret;
+
+	ret = stm32_mdf_core_parse_of(pdev, priv);
+	if (ret < 0)
+		return ret;
+
+	INIT_LIST_HEAD(&priv->mdf.sitf_list);
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
+	/* Balance devm_regmap_init_mmio_clk() clk_prepare() */
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
diff --git a/drivers/iio/adc/stm32-mdf-serial.c b/drivers/iio/adc/stm32-mdf-serial.c
new file mode 100644
index 000000000000..15a58cf833be
--- /dev/null
+++ b/drivers/iio/adc/stm32-mdf-serial.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * This file is part of STM32 MDF driver
+ *
+ * Copyright (C) 2023, STMicroelectronics - All Rights Reserved
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "stm32-mdf.h"
+
+#define STM32_MDF_MODE_SZ 12
+
+enum {
+	STM32_MDF_SCKSRC_CCK0,
+	STM32_MDF_SCKSRC_CCK1,
+	STM32_MDF_SCKSRC_CLK,
+	STM32_MDF_SCKSRC_NONE,
+};
+
+struct stm32_mdf_sf_mode {
+	const char *name;
+	u32 mode;
+};
+
+static const struct stm32_mdf_sf_mode stm32_mdf_mode[STM32_MDF_MODE_NB] = {
+	{ "spi", STM32_MDF_MODE_SPI },
+	{ "lf_spi", STM32_MDF_MODE_LF_SPI },
+	{ "manchester_r", STM32_MDF_MODE_MANCHESTER_R },
+	{ "manchester_f", STM32_MDF_MODE_MANCHESTER_F },
+};
+
+static bool stm32_mdf_sitf_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MDF_SITFCR_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool stm32_mdf_sitf_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MDF_SITFCR_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config stm32_sitf_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = sizeof(u32),
+	.max_register = MDF_SITFCR_REG,
+	.readable_reg = stm32_mdf_sitf_readable_reg,
+	.writeable_reg = stm32_mdf_sitf_writeable_reg,
+	.fast_io = true,
+	/* Do not use regcache as it does not support single register map */
+};
+
+int stm32_mdf_sitf_start(struct stm32_mdf_sitf *sitf)
+{
+	int ret;
+
+	spin_lock(&sitf->lock);
+
+	ret = regmap_set_bits(sitf->regmap, MDF_SITFCR_REG, MDF_SITFCR_SITFEN);
+	if (!ret)
+		sitf->refcnt++;
+
+	spin_unlock(&sitf->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_sitf_start);
+
+int stm32_mdf_sitf_stop(struct stm32_mdf_sitf *sitf)
+{
+	int ret = 0;
+
+	spin_lock(&sitf->lock);
+
+	if (!sitf->refcnt) {
+		dev_err(sitf->dev, "Unbalanced serial interface stop ?\n");
+		ret = -EPERM;
+		goto out;
+	} else {
+		sitf->refcnt--;
+	}
+
+	if (!sitf->refcnt)
+		ret = regmap_clear_bits(sitf->regmap, MDF_SITFCR_REG, MDF_SITFCR_SITFEN);
+
+out:
+	spin_unlock(&sitf->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_sitf_stop);
+
+static int stm32_mdf_sitf_get_clk(struct device *dev, struct stm32_mdf_sitf *sitf)
+{
+	struct clk *sck;
+
+	/* Optional clock. Clock not needed in Manchester mode */
+	sck = clk_get_optional(sitf->dev, 0);
+	if (IS_ERR(sck))
+		return dev_err_probe(sitf->dev, PTR_ERR(sck), "Can't get serial clock\n");
+
+	sitf->sck = sck;
+
+	if (sitf->sck) {
+		if (!strncmp(__clk_get_name(sck), STM32_MDF_CCK0, sizeof(STM32_MDF_CCK0)))
+			sitf->scksrc = STM32_MDF_SCKSRC_CCK0;
+		else if (!strncmp(__clk_get_name(sck), STM32_MDF_CCK1, sizeof(STM32_MDF_CCK1)))
+			sitf->scksrc = STM32_MDF_SCKSRC_CCK1;
+		else
+			sitf->scksrc = STM32_MDF_SCKSRC_CLK;
+	}
+
+	return 0;
+};
+
+static int stm32_mdf_sitf_parse(struct platform_device *pdev, struct stm32_mdf_sitf *sitf)
+{
+	struct device *dev = &pdev->dev;
+	const char *str;
+	int ret, i = 0;
+	u32 idx, mode, sitfcr;
+
+	ret = device_property_read_u32(dev, "reg", &idx);
+	if (ret) {
+		dev_err(dev, "Could not get interface index: %d\n", ret);
+		return ret;
+	}
+
+	if (idx % 0x80) {
+		dev_err(dev, "Unexpected reg property value [%x]\n", idx);
+		return -EINVAL;
+	}
+
+	idx = (idx >> 7) - 1;
+	if (idx > sitf->mdf->nbf) {
+		dev_err(dev, "Interface index [%d] exceeds maximum [%d]\n", idx, sitf->mdf->nbf);
+		return -EINVAL;
+	}
+
+	/* Get SITF mode */
+	ret = device_property_read_string(dev, "st,sitf-mode", &str);
+	if (ret) {
+		dev_err(dev, "Could not get interface mode: %d\n", ret);
+		return ret;
+	}
+
+	while (i < STM32_MDF_MODE_NB) {
+		if (!strncmp(stm32_mdf_mode[i].name, str, STM32_MDF_MODE_SZ)) {
+			mode = stm32_mdf_mode[i].mode;
+			break;
+		}
+		i++;
+	}
+
+	if (i >= STM32_MDF_MODE_NB) {
+		dev_err(dev, "Unknown serial interface mode [%s]\n", str);
+		return -EINVAL;
+	}
+
+	sitf->mode = mode;
+	sitfcr = MDF_SITFCR_SITFMOD(mode);
+
+	ret = stm32_mdf_sitf_get_clk(dev, sitf);
+	if (ret)
+		return ret;
+
+	if (mode == STM32_MDF_MODE_SPI && sitf->scksrc == STM32_MDF_SCKSRC_NONE) {
+		dev_err(dev, "Missing clock for serial interface [%d] in SPI mode\n", idx);
+		return -EINVAL;
+	}
+
+	if (mode == STM32_MDF_MODE_LF_SPI && (sitf->scksrc != STM32_MDF_SCKSRC_CCK0 &&
+					      sitf->scksrc != STM32_MDF_SCKSRC_CCK1)) {
+		dev_err(dev, "Missing CCKx clock for serial interface [%d] in LF_SPI mode\n", idx);
+		return -EINVAL;
+	}
+
+	sitf->id = idx;
+	sitf->node = dev_fwnode(dev);
+	spin_lock_init(&sitf->lock);
+
+	sitfcr |= MDF_SITFCR_SCKSRC(sitf->scksrc);
+
+	/* Configure SITF register */
+	regmap_set_bits(sitf->regmap, MDF_SITFCR_REG, sitfcr);
+
+	dev_dbg(dev, "Serial interface [%d] registered\n", idx);
+
+	return 0;
+}
+
+static int stm32_mdf_sitf_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct stm32_mdf_sitf *sitf;
+	struct regmap *regmap;
+	struct resource *res;
+	void __iomem *base;
+	int ret;
+
+	sitf = devm_kzalloc(&pdev->dev, sizeof(*sitf), GFP_KERNEL);
+	if (!sitf)
+		return -ENOMEM;
+	sitf->dev = dev;
+	sitf->mdf = dev_get_drvdata(dev->parent);
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = devm_regmap_init_mmio_clk(dev, "ker_ck", base, &stm32_sitf_regmap_cfg);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to init regmap\n");
+	sitf->regmap = regmap;
+
+	ret = stm32_mdf_sitf_parse(pdev, sitf);
+	if (ret < 0)
+		return ret;
+
+	list_add(&sitf->entry, &sitf->mdf->sitf_list);
+
+	platform_set_drvdata(pdev, sitf);
+
+	return 0;
+}
+
+static void stm32_mdf_sitf_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct stm32_mdf_sitf *sitf = dev_get_drvdata(dev);
+
+	list_del(&sitf->entry);
+}
+
+static int stm32_mdf_sitf_suspend(struct device *dev)
+{
+	struct stm32_mdf_sitf *sitf = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pinctrl_pm_select_sleep_state(dev);
+
+	regmap_read(sitf->regmap, MDF_SITFCR_REG, &sitf->sitfcr);
+
+	return ret;
+}
+
+static int stm32_mdf_sitf_resume(struct device *dev)
+{
+	struct stm32_mdf_sitf *sitf = dev_get_drvdata(dev);
+
+	regmap_write(sitf->regmap, MDF_SITFCR_REG, sitf->sitfcr);
+
+	return pinctrl_pm_select_default_state(dev);
+}
+
+static int stm32_mdf_sitf_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int stm32_mdf_sitf_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+
+static const struct dev_pm_ops stm32_mdf_sitf_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_mdf_sitf_suspend, stm32_mdf_sitf_resume)
+	SET_RUNTIME_PM_OPS(stm32_mdf_sitf_runtime_suspend, stm32_mdf_sitf_runtime_resume, NULL)
+};
+
+static const struct of_device_id stm32_mdf_sitf_of_match[] = {
+	{ .compatible = "st,stm32mp25-sitf-mdf" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, stm32_mdf_sitf_of_match);
+
+static struct platform_driver stm32_mdf_sitf_driver = {
+	.probe = stm32_mdf_sitf_probe,
+	.remove = stm32_mdf_sitf_remove,
+	.driver = {
+		.name = "stm32-mdf-sitf",
+		.of_match_table = stm32_mdf_sitf_of_match,
+		.pm = &stm32_mdf_sitf_pm_ops,
+	},
+};
+
+module_platform_driver(stm32_mdf_sitf_driver);
+
+MODULE_AUTHOR("Olivier Moysan <olivier.moysan@foss.st.com>");
+MODULE_DESCRIPTION("STMicroelectronics STM32 MDF serial driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/adc/stm32-mdf.h b/drivers/iio/adc/stm32-mdf.h
new file mode 100644
index 000000000000..7e403c26d4dc
--- /dev/null
+++ b/drivers/iio/adc/stm32-mdf.h
@@ -0,0 +1,312 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * This file is part of STM32 MDF driver
+ *
+ * Copyright (C) 2023, STMicroelectronics - All Rights Reserved
+ * Author: Olivier Moysan <olivier.moysan@foss.st.com>.
+ */
+
+#include <linux/bitfield.h>
+
+/* Register definitions */
+#define MDF_GCR_REG 0x00
+#define MDF_CKGCR_REG 0x04
+#define MDF_HWCFGR_REG 0xff0
+#define MDF_VERR_REG 0xff4
+#define MDF_IPIDR_REG 0xff8
+#define MDF_SIDR_REG 0xffc
+
+/* Registers offsets relative to sitf base address */
+#define MDF_SITFCR_REG 0x00 /* 0x80 * x + offset */
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
+#define MDF_GCR_ILVNB(v) FIELD_PREP(MDF_GCR_ILVNB_MASK, v)
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
+#define MDF_CKG_TRGSRC(v) FIELD_PREP(MDF_CKG_TRGSRC_MASK, v)
+#define MDF_CKG_CCKDIV_MASK GENMASK(19, 16)
+#define MDF_CKG_CCKDIV(v) FIELD_PREP(MDF_CKG_CCKDIV_MASK, v)
+#define MDF_CKG_CCKDIV_MAX (FIELD_MAX(MDF_CKG_CCKDIV_MASK) + 1)
+#define MDF_CKG_PROCDIV_MASK GENMASK(30, 24)
+#define MDF_CKG_PROCDIV(v) FIELD_PREP(MDF_CKG_PROCDIV_MASK, v)
+#define MDF_PROCDIV_MAX (FIELD_MAX(MDF_CKG_PROCDIV_MASK) + 1)
+#define MDF_CKG_ACTIVE BIT(31)
+
+/* MDF_OR: Option Register */
+#define MDF_OR_OPTION_MASK OPTION(31, 0)
+#define MDF_OR_OPTION(v) FIELD_PREP(MDF_OR_OPTION_MASK, v)
+
+/* MDF_SITFCR: Serial Interface Control Register */
+#define MDF_SITFCR_SITFEN BIT(0)
+#define MDF_SITFCR_SCKSRC_MASK GENMASK(2, 1)
+#define MDF_SITFCR_SCKSRC(v) FIELD_PREP(MDF_SITFCR_SCKSRC_MASK, v)
+#define MDF_SITFCR_SITFMOD_MASK GENMASK(5, 4)
+#define MDF_SITFCR_SITFMOD(v) FIELD_PREP(MDF_SITFCR_SITFMOD_MASK, v)
+#define MDF_SITFCR_STH_MASK GENMASK(12, 8)
+#define MDF_SITFCR_STH(v) FIELD_PREP(MDF_SITFCR_STH_MASK, v)
+#define MDF_SITFCR_ACTIVE BIT(31)
+
+/* MDF_BSMXCR: Bitstream Matrix Control Register */
+#define MDF_BSMXCR_BSSEL_MASK GENMASK(4, 0)
+#define MDF_BSMXCR_BSSEL(v) FIELD_PREP(MDF_BSMXCR_BSSEL_MASK, v)
+#define MDF_BSMXCR_ACTIVE BIT(31)
+
+/* MDF_DFLTCR: Digital Filter Control Register */
+#define MDF_DFLTCR_DFLTEN BIT(0)
+#define MDF_DFLTCR_DMAEN BIT(1)
+#define MDF_DFLTCR_FTH BIT(2)
+#define MDF_DFLTCR_ACQMOD_MASK GENMASK(6, 4)
+#define MDF_DFLTCR_ACQMOD(v) FIELD_PREP(MDF_DFLTCR_ACQMOD_MASK, v)
+#define MDF_DFLTCR_TRGSENS BIT(8)
+#define MDF_DFLTCR_TRGSENS_SET(v) FIELD_PREP(MDF_DFLTCR_TRGSENS, v)
+#define MDF_DFLTCR_TRGSRC_MASK GENMASK(15, 12)
+#define MDF_DFLTCR_TRGSRC(v) FIELD_PREP(MDF_DFLTCR_TRGSRC_MASK, v)
+#define MDF_DFLTCR_SNPSFMT BIT(16)
+#define MDF_DFLTCR_NBDIS_MASK GENMASK(27, 20)
+#define MDF_DFLTCR_NBDIS(v) FIELD_PREP(MDF_DFLTCR_NBDIS_MASK, v)
+#define MDF_DFLTCR_NBDIS_MAX FIELD_MAX(MDF_DFLTCR_NBDIS_MASK)
+#define MDF_DFLTCR_DFLTRUN BIT(30)
+#define MDF_DFLTCR_ACTIVE BIT(31)
+
+/* MDF_DFLTCICR: Digital Filter Configuration Register */
+#define MDF_DFLTCICR_DATSRC_MASK GENMASK(1, 0)
+#define MDF_DFLTCICR_DATSRC(v) FIELD_PREP(MDF_DFLTCICR_DATSRC_MASK, v)
+#define MDF_DFLTCICR_CICMOD_MASK GENMASK(6, 4)
+#define MDF_DFLTCICR_CICMOD(v) FIELD_PREP(MDF_DFLTCICR_CICMOD_MASK, v)
+#define MDF_DFLTCICR_MCICD_MASK GENMASK(16, 8)
+#define MDF_DFLTCICR_MCICD(v) FIELD_PREP(MDF_DFLTCICR_MCICD_MASK, v)
+#define MDF_DFLTCICR_MCICD_MIN 2
+#define MDF_DFLTCICR_SCALE_MASK GENMASK(25, 20)
+#define MDF_DFLTCICR_SCALE(v) FIELD_PREP(MDF_DFLTCICR_SCALE_MASK, v)
+
+/* MDF_DFLTRSFR: Reshape Filter Configuration Register */
+#define MDF_DFLTRSFR_RSFLTBYP BIT(0)
+#define MDF_DFLTRSFR_RSFLTD BIT(4)
+#define MDF_DFLTRSFR_HPFBYP BIT(7)
+#define MDF_DFLTRSFR_HPFC_MASK GENMASK(9, 8)
+#define MDF_DFLTRSFR_HPFC(v) FIELD_PREP(MDF_DFLTRSFR_HPFC_MASK, v)
+
+/* MDF_DFLTINTR: Integrator Configuration Register */
+#define MDF_DFLTINTR_INTDIV_MASK GENMASK(1, 0)
+#define MDF_DFLTINTR_INTDIV(v) FIELD_PREP(MDF_DFLTINTR_INTDIV_MASK, v)
+#define MDF_DFLTINTR_INTVAL_MASK GENMASK(10, 4)
+#define MDF_DFLTINTR_INTVAL(v) FIELD_PREP(MDF_DFLTINTR_INTVAL_MASK, v)
+
+/* MDF_OLDCR: Out-Of Limit Detector Control Register */
+#define MDF_OLDCR_OLDEN_MASK BIT(0)
+#define MDF_OLDCR_OLDEN(v) FIELD_PREP(MDF_OLDCR_OLDEN_MASK, v)
+#define MDF_OLDCR_THINB_MASK BIT(1)
+#define MDF_OLDCR_THINB(v) FIELD_PREP(MDF_OLDCR_THINB_MASK, v)
+#define MDF_OLDCR_BKOLD_MASK GENMASK(7, 4)
+#define MDF_OLDCR_BKOLD(v) FIELD_PREP(MDF_OLDCR_BKOLD_MASK, v)
+#define MDF_OLDCR_ACICN_MASK GENMASK(13, 12)
+#define MDF_OLDCR_ACICN(v) FIELD_PREP(MDF_OLDCR_ACICN_MASK, v)
+#define MDF_OLDCR_ACICD_MASK GENMASK(21, 17)
+#define MDF_OLDCR_ACICD(v) FIELD_PREP(MDF_OLDCR_ACICD_MASK, v)
+#define MDF_OLDCR_ACTIVE_MASK BIT(31)
+#define MDF_OLDCR_ACTIVE(v) FIELD_PREP(MDF_OLDCR_ACTIVE_MASK, v)
+
+/* MDF_OLDxTHLR: OLD Threshold Low Register */
+#define MDF_OLDTHLR_OLDTHL_MASK GENMASK(25, 0)
+#define MDF_OLDTHLR_OLDTHL(v) FIELD_PREP(MDF_OLDTHLR_OLDTHL_MASK, v)
+
+/* MDF_OLDxTHHR: OLD Threshold High Register */
+#define MDF_OLDTHHR_OLDTHH_MASK GENMASK(25, 0)
+#define MDF_OLDTHHR_OLDTHH(v) FIELD_PREP(MDF_OLDTHHR_OLDTHH_MASK, v)
+
+/* MDF_DLYCR: Delay control Register */
+#define MDF_DLYCR_SKPDLY_MASK GENMASK(6, 0)
+#define MDF_DLYCR_SKPDLY(v) FIELD_PREP(MDF_DLYCR_SKPDLY_MASK, v)
+
+/* MDF_SCDCR: Short circuit detector control Register */
+#define MDF_SCDCR_CDEN_MASK BIT(0)
+#define MDF_SCDCR_CDEN(v) FIELD_PREP(MDF_SCDCR_CDEN_MASK, v)
+#define MDF_SCDCR_BKSCD_MASK GENMASK(7, 4)
+#define MDF_SCDCR_BKSCD(v) FIELD_PREP(MDF_SCDCR_BKSCD_MASK, v)
+#define MDF_SCDCR_SCDT_MASK GENMASK(19, 12)
+#define MDF_SCDCR_SCDT(v) FIELD_PREP(MDF_SCDCR_SCDT_MASK, v)
+#define MDF_SCDCR_ACTIVE_MASK BIT(31)
+#define MDF_SCDCR_ACTIVE(v) FIELD_PREP(MDF_SCDCR_ACTIVE_MASK, v)
+
+/* MDF_DFLTIER: DFLT Interrupt enable Register */
+#define MDF_DFLTIER_FTHIE_MASK BIT(0)
+#define MDF_DFLTIER_FTHIE(v) FIELD_PREP(MDF_DFLTIER_FTHIE_MASK, v)
+#define MDF_DFLTIER_DOVRIE_MASK BIT(1)
+#define MDF_DFLTIER_DOVRIE(v) FIELD_PREP(MDF_DFLTIER_DOVRIE_MASK, v)
+#define MDF_DFLTIER_SSDRIE_MASK BIT(2)
+#define MDF_DFLTIER_SSDRIE(v) FIELD_PREP(MDF_DFLTIER_SSDRIE_MASK, v)
+#define MDF_DFLTIER_OLDIE_MASK BIT(4)
+#define MDF_DFLTIER_OLDIE(v) FIELD_PREP(MDF_DFLTIER_OLDIE_MASK, v)
+#define MDF_DFLTIER_SSOVRIE_MASK BIT(7)
+#define MDF_DFLTIER_SSOVRIE(v) FIELD_PREP(MDF_DFLTIER_SSOVRIE_MASK, v)
+#define MDF_DFLTIER_SCDIE_MASK BIT(8)
+#define MDF_DFLTIER_SCDIE(v) FIELD_PREP(MDF_DFLTIER_SCDIE_MASK, v)
+#define MDF_DFLTIER_SATIE_MASK BIT(9)
+#define MDF_DFLTIER_SATIE(v) FIELD_PREP(MDF_DFLTIER_SATIE_MASK, v)
+#define MDF_DFLTIER_CKABIE_MASK BIT(10)
+#define MDF_DFLTIER_CKABIE(v) FIELD_PREP(MDF_DFLTIER_CKABIE_MASK, v)
+#define MDF_DFLTIER_RFOVRIE_MASK BIT(11)
+#define MDF_DFLTIER_RFOVRIE(v) FIELD_PREP(MDF_DFLTIER_RFOVRIE_MASK, v)
+
+/* MDF_DFLTISR: DFLT Interrupt status Register */
+#define MDF_DFLTISR_FTHF_MASK BIT(0)
+#define MDF_DFLTISR_FTHF(v) FIELD_PREP(MDF_DFLTISR_FTHF_MASK, v)
+#define MDF_DFLTISR_DOVRF_MASK BIT(1)
+#define MDF_DFLTISR_DOVRF(v) FIELD_PREP(MDF_DFLTISR_DOVRF_MASK, v)
+#define MDF_DFLTISR_SSDRF_MASK BIT(2)
+#define MDF_DFLTISR_SSDRF(v) FIELD_PREP(MDF_DFLTISR_SSDRF_MASK, v)
+#define MDF_DFLTISR_OLDF_MASK BIT(4)
+#define MDF_DFLTISR_OLDF(v) FIELD_PREP(MDF_DFLTISR_OLDF_MASK, v)
+#define MDF_DFLTISR_SSOVRF_MASK BIT(7)
+#define MDF_DFLTISR_SSOVRF(v) FIELD_PREP(MDF_DFLTISR_SSOVRF_MASK, v)
+#define MDF_DFLTISR_SCDF_MASK BIT(8)
+#define MDF_DFLTISR_SCDF(v) FIELD_PREP(MDF_DFLTISR_SCDF_MASK, v)
+#define MDF_DFLTISR_SATF_MASK BIT(9)
+#define MDF_DFLTISR_SATF(v) FIELD_PREP(MDF_DFLTISR_SATF_MASK, v)
+#define MDF_DFLTISR_CKABF_MASK BIT(10)
+#define MDF_DFLTISR_CKABF(v) FIELD_PREP(MDF_DFLTISR_CKABF_MASK, v)
+#define MDF_DFLTISR_RFOVRF_MASK BIT(11)
+#define MDF_DFLTISR_RFOVRF(v) FIELD_PREP(MDF_DFLTISR_RFOVRF_MASK, v)
+
+/* MDF_OECCR: Offset Error Compensation Control Register */
+#define MDF_OECCR_OFFSET_MASK GENMASK(25, 0)
+#define MDF_OECCR_OFFSET(v) FIELD_PREP(MDF_OECCR_OFFSET_MASK, v)
+
+/* MDF_SNPSDR:  Snapshot Data Register */
+#define MDF_SNPSDR_MCICDC_MASK GENMASK(8, 0)
+#define MDF_SNPSDR_MCICDC(v) FIELD_PREP(MDF_SNPSDR_MCICDC_MASK, v)
+#define MDF_SNPSDR_EXTSDR_MASK GENMASK(15, 9)
+#define MDF_SNPSDR_EXTSDR(v) FIELD_PREP(MDF_SNPSDR_EXTSDR_MASK, v)
+#define MDF_SNPSDR_SDR_MASK GENMASK(31, 16)
+#define MDF_SNPSDR_SDR(v) FIELD_PREP(MDF_SNPSDR_SDR_MASK, v)
+
+/* MDF_DFLTDR: Digital Filter Data Register */
+#define MDF_DFLTDR_DR_MASK GENMASK(31, 8)
+#define MDF_DFLTDR_DR(v) FIELD_PREP(MDF_DFLTDR_DR_MASK, v)
+
+/* MDF_HWCFGR: Hardware configuration register */
+#define MDF_HWCFGR_FIFO_SIZE_MASK GENMASK(7, 0)
+#define MDF_HWCFGR_FIFO_SIZE(v) FIELD_PREP(MDF_HWCFGR_FIFO_SIZE_MASK, v)
+#define MDF_HWCFGR_NBF_MASK GENMASK(15, 8)
+#define MDF_HWCFGR_NBF(v) FIELD_PREP(MDF_HWCFGR_NBF_MASK, v)
+#define MDF_HWCFGR_FLT_CFG_MASK GENMASK(19, 16)
+#define MDF_HWCFGR_FLT_CFG(v) FIELD_PREP(MDF_HWCFGR_FLT_CFG_MASK, v)
+#define MDF_HWCFGR_SAD_MASK GENMASK(23, 20)
+#define MDF_HWCFGR_SAD(v) FIELD_PREP(MDF_HWCFGR_SAD_MASK, v)
+#define MDF_HWCFGR_OPTION_MASK GENMASK(31, 24)
+#define MDF_HWCFGR_OPTION(v) FIELD_PREP(MDF_HWCFGR_OPTION_MASK, v)
+
+/* MDF_VERR: Version Register */
+#define MDF_VERR_MINREV_MASK GENMASK(3, 0)
+#define MDF_VERR_MINREV(v) FIELD_PREP(MDF_VERR_MINREV_MASK, v)
+#define MDF_VERR_MAJREV_MASK GENMASK(7, 4)
+#define MDF_VERR_MAJREV(v) FIELD_PREP(MDF_VERR_MAJREV_MASK, v)
+
+/* MDF_IPIDR: Identification Register */
+#define MDF_IPIDR_ID_MASK GENMASK(31, 0)
+#define MDF_IPIDR_ID_MINREV(v) FIELD_PREP(MDF_IPIDR_ID_MASK, v)
+
+/* MDF_SIDR: Size Identification Register */
+#define MDF_SIDR_SID_MASK GENMASK(31, 0)
+#define MDF_SIDR_SID(v) FIELD_PREP(MDF_SIDR_SID_MASK, v)
+
+#define STM32MP25_MDF_IPIDR_NUMBER 0x00110032
+
+#define STM32_MDF_CCK0 "clk_cck0"
+#define STM32_MDF_CCK1 "clk_cck1"
+
+enum stm32_sitf_mode {
+	STM32_MDF_MODE_LF_SPI,
+	STM32_MDF_MODE_SPI,
+	STM32_MDF_MODE_MANCHESTER_R,
+	STM32_MDF_MODE_MANCHESTER_F,
+	STM32_MDF_MODE_NB,
+};
+
+/*
+ * struct stm32_mdf_sitf - STM32 MDF serial interface data
+ * @entry: serial interface list head
+ * @dev: pointer to parent device
+ * @regmap: regmap for register read/write
+ * @mdf: mdf common data pointer
+ * @node: serial interface node handle
+ * @sck: sitf clock handle
+ * @base: sitf registers base cpu addr
+ * @lock: sitf state manegement lock
+ * @refcnt: sitf usage reference counter
+ * @scksrc: sitf clock source
+ * @id: serial interface index
+ * @mode: sitf mode
+ * @sitfcr: sitf configuration register backup
+ */
+struct stm32_mdf_sitf {
+	struct list_head entry;
+	struct device *dev;
+	struct regmap *regmap;
+	struct stm32_mdf *mdf;
+	struct fwnode_handle *node;
+	struct clk *sck;
+	void __iomem *base;
+	spinlock_t lock; /* Manage race conditions on sitf state */
+	unsigned int refcnt;
+	unsigned int scksrc;
+	u32 id;
+	u32 mode;
+	u32 sitfcr;
+};
+
+/*
+ * struct stm32_mdf - STM32 MDF driver common data (for all instances)
+ * @sitf_list: pointer to serial interfaces list
+ * @filter_list: pointer to filter interfaces list
+ * @fh_interleave: interleaved filter handle list pointer
+ * @fproc: processing clock frequency
+ * @nbf: total number of digital filters
+ * @nb_interleave: number of interleaved filters
+ */
+struct stm32_mdf {
+	struct list_head sitf_list;
+	struct list_head filter_list;
+	struct fwnode_handle **fh_interleave;
+	unsigned long fproc;
+	unsigned int nbf;
+	unsigned int nb_interleave;
+};
+
+int stm32_mdf_core_start_mdf(struct stm32_mdf *mdf);
+int stm32_mdf_core_stop_mdf(struct stm32_mdf *mdf);
+int stm32_mdf_core_trigger(struct stm32_mdf *mdf);
+int stm32_mdf_core_restore_cck(struct stm32_mdf *mdf);
+int stm32_mdf_core_lock_kclk_rate(struct stm32_mdf *mdf);
+void stm32_mdf_core_unlock_kclk_rate(struct stm32_mdf *mdf);
+unsigned long stm32_mdf_core_get_cck(struct stm32_mdf *mdf);
+
+int stm32_mdf_sitf_start(struct stm32_mdf_sitf *sitf);
+int stm32_mdf_sitf_stop(struct stm32_mdf_sitf *sitf);
diff --git a/include/linux/iio/adc/stm32-mdf-adc.h b/include/linux/iio/adc/stm32-mdf-adc.h
new file mode 100644
index 000000000000..95e3f4afdb78
--- /dev/null
+++ b/include/linux/iio/adc/stm32-mdf-adc.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * This file describe the STM32 MDF IIO driver API for audio part
+ *
+ * Copyright (C) 2023, STMicroelectronics.
+ * Author(s): Olivier Moysan <olivier.moysan@foss.st.com>.
+ */
+
+#ifndef STM32_MDF_ADC_H
+#define STM32_MDF_ADC_H
+
+#include <linux/iio/iio.h>
+
+int stm32_mdf_get_buff_cb(struct iio_dev *iio_dev,
+			  int (*cb)(const void *data, size_t size, void *private), void *private);
+int stm32_mdf_release_buff_cb(struct iio_dev *iio_dev);
+unsigned int stm32_mdf_get_sub_channels_nb(struct iio_dev *iio_dev);
+
+#endif
-- 
2.43.0

