Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794287398;
	b=mZCvOHK7fNK7KifdNhw79VK27VKEJaLT/ryVolxlFuXJKRgjIDKcSHWQKdt476yHsMKv
	 PFJQC99NUW5HmFoVP0btYcXAsCksdiiUb4dYQntm9luSa1ahG4UunBhbGpTksc2ZNYdnC
	 GZrg3D7fGoUfKueuwPN7+WYozWjIptrQDyMlEOG91oOBOQloh/q7bww6+70sSNokBcP8G
	 +8SA/emXoZjYKGIRx1DBt/jcD7CZxPbtQVgCJY8Ci2YFRWgwwx+IQp5h0noY4RmVYnKGu
	 PiIPD3SQdeoIC6lctGS9e7/z3Bf5o6CMHWtdMJdiF7YLasLObweiyXpyrHtZE3+WmbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287398;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=+DG2o70zfrnPtJFhsx59BZwOowR4LOvyDL+pZZlOOcw=;
	b=y3Z9YKPOqlnxIeecydHr69zyFuNdvdjdEDn3RSM+6DzikPaP9R2wm8TOd4G/EnSEs1ym
	 vzKLOpjalTBt1uObmPeIe9c3bhtwWJ0H8Yi6P9giQgze++0jXHXnJS2AfAyivKzZhVLFw
	 WTSGxjIbJ9eaLIfuhRuS+lI6Mkbamwk+k68SbjuDQEWGW7WFWcrIh076cHvf1+0YKe+M1
	 DCp4o+MnZwe5NRT/qu6Fym1SXyPAzQ78r2Nl61e4gtvxpc4ls+mwWPWUkiAPnUas9Y/v3
	 zFy17ykhPHTi/VucuPkJ6eDDa7q2ZRYSG0Jz9AZK5lOdjcCw1FLGxeyCFrvx0N7gs3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t2YFDRwt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.69
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DD7606A33C;
	Tue, 10 Nov 2026 05:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76DD7606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t2YFDRwt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZRU6zioq53X1wcFOnhJWnTx+k0Onq/8gzUhj+dVtFjEB0HEN7y3knxIN1Eb2GwSO3+La+u+1Igd8PUpQ1ijEWmE5mXqigyyNE96S27T5MS271+Z7Pz29VhD2rWL565dwQ/g2CpNfMIQb+/BhlrTOwhhWAdEMLuqM8sfFZT1osF6EaFXSbsNmoqJ3bvw+1l8yHxJOjW6Z1KaoN1es52w8xn8DnO7NUBq0qI1Zv+CEIvzqR6ILQi+c798fxMyGy6STSBPeLM+PEpVhKik9e9ABKj2ic0uHWjs75petJ3HGTK/Fx00TXNYLsKTLlcdoyg9FB8oYZzZO+yXqWfWfqN8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DG2o70zfrnPtJFhsx59BZwOowR4LOvyDL+pZZlOOcw=;
 b=UDyw8DsE1AtREm/4vvGOYXZateFy/YcueqHk2SY3UYCfCNuxQSa78n2rof7kdscOLfTq4XRn7WtfC0x6GGpuW8r2/ODyatlwS9/oNfsQGMDqIq57/4Yt+kXNvT7Ld53HUvAK3QDKGGunoRG9VrKBeJhDTz95/O8o5ig3kaminhP/6+tU2eN/GHppy77qiH7EA7VxbiBVKBYg5cB2Ar3Ktb7cvSsEAJror5fPYHPlqKWEiftRzgAwSXzNh4N6sS8cqZ+kiqYsnd7dNNotuP+LREAknRD9kNtjEb/lRe+409Jy4N9OB6KG67YyMKJ4PbF+i567ZA55Ne4NwMSjxeDAhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DG2o70zfrnPtJFhsx59BZwOowR4LOvyDL+pZZlOOcw=;
 b=t2YFDRwtFB0RGDZVM5kFQVyfJenPHEmjANOMgJH/jqXMHUhCJDcNXKTYtWYZ8/L+MVT7vEQ3Kj7ijadO+PS+Lss6dRuV+31KwV2qM7nmAU+Y5KO/GoGLfXUbcgo6/WVRlqVE5F0d9CL1hnZV4k9BmyYXVpKR0DLTXxA3vtnQXkE=
Received: from SJ0PR03CA0151.namprd03.prod.outlook.com (2603:10b6:a03:338::6)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 05:09:27 +0000
Received: from BY1PEPF0002695D.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::35) by SJ0PR03CA0151.outlook.office365.com
 (2603:10b6:a03:338::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Tue,
 10 Nov 2026 05:09:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695D.mail.protection.outlook.com (10.167.244.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 05:09:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:09:20 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 23:09:17 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v5 14/16] iio: adc: xilinx-xadc: Split driver into core and platform files
Date: Tue, 10 Nov 2026 10:31:59 +0530
Message-ID: <20261110050201.1850399-15-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695D:EE_|PH7PR12MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0ed430-2729-4016-b778-08df3ee8cb67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|261028144727099003|56012099006|11063799006|261009221227099003|261021121427099003|261021123027099003|261009223327099003|261009220027099003|261022115727099003|261021135927099003|261022075727099003|261009223027099003|261009221727099003|261026140227099003|261026121527099003|261102130727099003|261022105027099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	y94YYHKQJIjERfdZVFIB/qHZ3l9XMEI9lijXM3Whdn75b1mjb6QZ3uxVPlyFsoqSY5NsUghpgxJeGSblADuTIPVsMF4AXW9uzBkdBrKi7GfNimOdh6sK4uUWireEMKCJ2gXxdBq7KtasrK2dPamgb2354qCq9EY2rG7/hcp9HO8zTZNoE9YygI1AL5bkiNTWAmMdV0RFMCj2uHS2+239CzGqubOKnXi6N1ycurrSgZwm8AKULuh/Cj6xwV70iyeuGHH69tpMsQAWDxTkXuMGDnZ913iKesdc6IYprM2LmNmnk3e3lx8ef29JjeGEHn2egeS2w8Xzed7KX3L4AwvFCB49hBbUtqd2XPVYiAM9sf/D0fe7SqZd0DmaEBCmVZ9L/cAWSyZ03ugE5hd8DlbVqBbUXFs/oMOb3KWmGA9jxIV+UUcfxAyVVjBbzZXw8e4HaM0Ip2kmHs8IIsQqrCsKoFgrKfUIPVqzRCNbmVhZSO82AxDYoSUFkt3cK0t3nzNxd9sgD+Ui13mCTn/fdHTKDlSs3HcWqCTiUZfaTL8DtJ8f1oJyh8smJ7HUBS8ZQzTNvvaX1HYbMHDQsrHr7uD8X8DQQ7wZPzl4CT0+CodxFflsc1J1z2t5vyyynCseLlFjlftMJ2pFtEIF22HUvDUQA4+TJMjdivjnFdVba+qV6t1MK8spnS+aH5R2zP1nIxLnInvnitfFeMDJj/W36KZ2Wg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(261028144727099003)(56012099006)(11063799006)(261009221227099003)(261021121427099003)(261021123027099003)(261009223327099003)(261009220027099003)(261022115727099003)(261021135927099003)(261022075727099003)(261009223027099003)(261009221727099003)(261026140227099003)(261026121527099003)(261102130727099003)(261022105027099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	A2ku2bHhEQA/o+bTP+vA2lUsMI5k+TKADa6nyd3Iu04BIBwNQvihsiy/DMDlMmyky1tg/lODl21ho0PQ8aGUoglagRqGkaYi+ktN68VSKn90JB1yU/u5QAWQ/GNyZeIk8jPgG7nTqo8nXbft521he/WQCj5xzTyV/0Spk0HBBA4xc0hdN0V1Dkp4DuYeRq0z1FdNnobXnc5yIiy65Q0cVQ0vdWK+qty1p8csA0+O+a61tiCeAXSaQrm91kCOJS0iPrvIWsUbbkmcbwEzgMzio+OO6hy8eRQBevynVFWJsH1UUn/9/4dmGjf4zT0vBWbjmnb7QUbePjrKOydboHzGx8rabzT68pIyhyJXEFP/XS+UpMpjIINmHSe8E01t5aqqAt6m1LvWEQ8AC/WnonnQ3iBXLhW5ecp39PrMA7MfzO5pID/mKvmilzYsqPDJ3okT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 05:09:27.4777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0ed430-2729-4016-b778-08df3ee8cb67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0002695D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053

Split the xilinx-xadc-core.c into separate core and platform specific
files to prepare for I2C interface support.

xilinx-xadc-core.c is reorganized as follows:
xilinx-xadc-core.c:
  - Platform-independent IIO/ADC operations
  - Channel definitions and management
  - Buffer and trigger management
  - Device tree parsing

xilinx-xadc-platform.c:
  - ZYNQ platform (FIFO-based) register access and interrupt handling
  - AXI platform (memory-mapped) register access and interrupt handling
  - Platform-specific setup and configuration
  - Platform device probe function

Update Kconfig to introduce XILINX_XADC_CORE as a helper module selected
by XILINX_XADC and update Makefile to build the split modules:
  - xilinx-xadc-common.o (core + events)
  - xilinx-xadc-platform.o (platform-specific)

Reorganize the code with no behavioral changes.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/Kconfig                       |   8 +-
 drivers/iio/adc/Makefile                      |   5 +-
 drivers/iio/adc/xilinx-xadc-core.c            | 690 +--------------
 drivers/iio/adc/xilinx-xadc-events.c          |   1 +
 ...inx-xadc-core.c => xilinx-xadc-platform.c} | 818 +-----------------
 drivers/iio/adc/xilinx-xadc.h                 |  27 +
 6 files changed, 72 insertions(+), 1477 deletions(-)
 copy drivers/iio/adc/{xilinx-xadc-core.c => xilinx-xadc-platform.c} (44%)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f8456c803988..864d3cd928c1 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -2157,11 +2157,15 @@ config VIPERBOARD_ADC
 	  To compile this driver as a module, choose M here: the module will be
 	  called viperboard_adc.
 
+config XILINX_XADC_CORE
+	tristate
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+
 config XILINX_XADC
 	tristate "Xilinx XADC driver"
 	depends on HAS_IOMEM
-	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
+	select XILINX_XADC_CORE
 	help
 	  Say yes here to have support for the Xilinx 7 Series XADC or
 	  UltraScale/UltraScale+ System Management Wizard.
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d7bb4815df61..97aed4a40135 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -183,5 +183,6 @@ obj-$(CONFIG_VERSAL_SYSMON_I2C) += versal-sysmon-i2c.o
 obj-$(CONFIG_VF610_ADC) += vf610_adc.o
 obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
 obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
-xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
-obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
+xilinx-xadc-common-y := xilinx-xadc-core.o xilinx-xadc-events.o
+obj-$(CONFIG_XILINX_XADC_CORE) += xilinx-xadc-common.o
+obj-$(CONFIG_XILINX_XADC) += xilinx-xadc-platform.o
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 9d5cc6c86c98..e92d21efe3c1 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -16,14 +16,12 @@
 #include <linux/bits.h>
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
-#include <linux/clk.h>
 #include <linux/container_of.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -37,543 +35,17 @@
 
 #include "xilinx-xadc.h"
 
-static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT_MS = 500;
-
-/* ZYNQ register definitions */
-#define XADC_ZYNQ_REG_CFG	0x00
-#define XADC_ZYNQ_REG_INTSTS	0x04
-#define XADC_ZYNQ_REG_INTMSK	0x08
-#define XADC_ZYNQ_REG_STATUS	0x0c
-#define XADC_ZYNQ_REG_CFIFO	0x10
-#define XADC_ZYNQ_REG_DFIFO	0x14
-#define XADC_ZYNQ_REG_CTL		0x18
-
-#define XADC_ZYNQ_CFG_ENABLE		BIT(31)
-#define XADC_ZYNQ_CFG_CFIFOTH_MASK	GENMASK(23, 20)
-#define XADC_ZYNQ_CFG_CFIFOTH_OFFSET	20
-#define XADC_ZYNQ_CFG_DFIFOTH_MASK	GENMASK(19, 16)
-#define XADC_ZYNQ_CFG_DFIFOTH_OFFSET	16
-#define XADC_ZYNQ_CFG_WEDGE		BIT(13)
-#define XADC_ZYNQ_CFG_REDGE		BIT(12)
-#define XADC_ZYNQ_CFG_TCKRATE_MASK	GENMASK(9, 8)
-#define XADC_ZYNQ_CFG_TCKRATE_DIV2	0
-#define XADC_ZYNQ_CFG_TCKRATE_DIV4	1
-#define XADC_ZYNQ_CFG_TCKRATE_DIV8	2
-#define XADC_ZYNQ_CFG_TCKRATE_DIV16	3
-#define XADC_ZYNQ_CFG_IGAP_MASK		GENMASK(4, 0)
-#define XADC_ZYNQ_CFG_IGAP(x)		(x)
-
-#define XADC_ZYNQ_INT_CFIFO_LTH		BIT(9)
-#define XADC_ZYNQ_INT_DFIFO_GTH		BIT(8)
-#define XADC_ZYNQ_INT_ALARM_MASK	GENMASK(7, 0)
-#define XADC_ZYNQ_INT_ALARM_OFFSET	0
-
-#define XADC_ZYNQ_STATUS_CFIFO_LVL_MASK	GENMASK(19, 16)
-#define XADC_ZYNQ_STATUS_CFIFO_LVL_OFFSET	16
-#define XADC_ZYNQ_STATUS_DFIFO_LVL_MASK	GENMASK(15, 12)
-#define XADC_ZYNQ_STATUS_DFIFO_LVL_OFFSET	12
-#define XADC_ZYNQ_STATUS_CFIFOF		BIT(11)
-#define XADC_ZYNQ_STATUS_CFIFOE		BIT(10)
-#define XADC_ZYNQ_STATUS_DFIFOF		BIT(9)
-#define XADC_ZYNQ_STATUS_DFIFOE		BIT(8)
-#define XADC_ZYNQ_STATUS_OT		BIT(7)
-#define XADC_ZYNQ_STATUS_ALM(x)		BIT(x)
-
-#define XADC_ZYNQ_CTL_RESET		BIT(4)
-
-#define XADC_ZYNQ_CMD_NOP		0x00
-#define XADC_ZYNQ_CMD_READ		0x01
-#define XADC_ZYNQ_CMD_WRITE		0x02
-
-#define XADC_ZYNQ_CMD(cmd, addr, data) (((cmd) << 26) | ((addr) << 16) | (data))
-
-/* AXI register definitions */
-#define XADC_AXI_REG_RESET		0x00
-#define XADC_AXI_REG_STATUS		0x04
-#define XADC_AXI_REG_ALARM_STATUS	0x08
-#define XADC_AXI_REG_CONVST		0x0c
-#define XADC_AXI_REG_XADC_RESET		0x10
-#define XADC_AXI_REG_GIER		0x5c
-#define XADC_AXI_REG_IPISR		0x60
-#define XADC_AXI_REG_IPIER		0x68
-
-/* 7 Series */
-#define XADC_7S_AXI_ADC_REG_OFFSET	0x200
-
-/* UltraScale */
-#define XADC_US_AXI_ADC_REG_OFFSET	0x400
-
-#define XADC_AXI_RESET_MAGIC		0xa
-#define XADC_AXI_GIER_ENABLE		BIT(31)
-
-#define XADC_AXI_INT_EOS		BIT(4)
-#define XADC_AXI_INT_ALARM_OT		BIT(0)
-#define XADC_AXI_INT_ALARM_TEMP_SUPPLY		GENMASK(3, 1)
-#define XADC_AXI_INT_ALARM_SUPPLY		GENMASK(13, 10)
-#define XADC_AXI_INT_ALARM_MASK		(XADC_AXI_INT_ALARM_SUPPLY | \
-					 XADC_AXI_INT_ALARM_TEMP_SUPPLY | \
-					 XADC_AXI_INT_ALARM_OT)
-
-#define XADC_FLAGS_BUFFERED BIT(0)
-#define XADC_FLAGS_IRQ_OPTIONAL BIT(1)
-
-/*
- * The XADC hardware supports a samplerate of up to 1MSPS. Unfortunately it does
- * not have a hardware FIFO. Which means an interrupt is generated for each
- * conversion sequence. At 1MSPS sample rate the CPU in ZYNQ7000 is completely
- * overloaded by the interrupts that it soft-lockups. For this reason the driver
- * limits the maximum samplerate 150kSPS. At this rate the CPU is fairly busy,
- * but still responsive.
- */
-#define XADC_MAX_SAMPLERATE_SPS 150000
-
-static void xadc_write_reg(struct xadc *xadc, unsigned int reg, u32 val)
+void xadc_write_reg(struct xadc *xadc, unsigned int reg, u32 val)
 {
 	writel(val, xadc->base + reg);
 }
+EXPORT_SYMBOL_NS_GPL(xadc_write_reg, "IIO_XADC");
 
-static void xadc_read_reg(struct xadc *xadc, unsigned int reg, u32 *val)
+void xadc_read_reg(struct xadc *xadc, unsigned int reg, u32 *val)
 {
 	*val = readl(xadc->base + reg);
 }
-
-/*
- * The ZYNQ interface uses two asynchronous FIFOs for communication with the
- * XADC. Reads and writes to the XADC register are performed by submitting a
- * request to the command FIFO (CFIFO), once the request has been completed the
- * result can be read from the data FIFO (DFIFO). The method currently used in
- * this driver is to submit the request for a read/write operation, then go to
- * sleep and wait for an interrupt that signals that a response is available in
- * the data FIFO.
- */
-static void xadc_zynq_write_fifo(struct xadc *xadc, u32 *cmd, unsigned int n)
-{
-	for (unsigned int i = 0; i < n; i++)
-		xadc_write_reg(xadc, XADC_ZYNQ_REG_CFIFO, cmd[i]);
-}
-
-static void xadc_zynq_drain_fifo(struct xadc *xadc)
-{
-	u32 status, tmp;
-
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);
-
-	/*
-	 * Reading XADC_ZYNQ_REG_DFIFO pops one entry from the data FIFO.
-	 * The loop therefore removes one pending entry per iteration and
-	 * terminates once the hardware reports the FIFO empty.
-	 */
-	while (!(status & XADC_ZYNQ_STATUS_DFIFOE)) {
-		xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &tmp);
-		xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);
-	}
-}
-
-static void xadc_zynq_update_intmsk(struct xadc *xadc, unsigned int mask, unsigned int val)
-{
-	xadc->zynq_intmask = (xadc->zynq_intmask & ~mask) | (val & mask);
-
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask | xadc->zynq_masked_alarm);
-}
-
-static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
-{
-	u32 cmd[1];
-	u32 tmp;
-	int ret;
-
-	scoped_guard(spinlock_irq, &xadc->lock) {
-		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
-
-		reinit_completion(&xadc->completion);
-
-		cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_WRITE, reg, val);
-		xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
-		xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
-		tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
-		xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
-
-		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
-	}
-
-	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
-
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &tmp);
-
-	if (ret == 0)
-		return -ETIMEDOUT;
-
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
-{
-	u32 cmd[2];
-	u32 resp, tmp;
-	int ret;
-
-	cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_READ, reg, 0);
-	cmd[1] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_NOP, 0, 0);
-
-	scoped_guard(spinlock_irq, &xadc->lock) {
-		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
-		xadc_zynq_drain_fifo(xadc);
-		reinit_completion(&xadc->completion);
-
-		xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
-		xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
-		tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
-		tmp |= FIELD_PREP(XADC_ZYNQ_CFG_DFIFOTH_MASK, 1);
-		xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
-
-		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
-	}
-
-	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
-	if (ret == 0)
-		return -ETIMEDOUT;
-
-	if (ret < 0)
-		return ret;
-
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &resp);
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &resp);
-
-	*val = resp;
-
-	return 0;
-}
-
-static unsigned int xadc_zynq_transform_alarm(unsigned int alarm)
-{
-	/*
-	 * Reorder the Zynq PS-XADC alarm bits defined in UG585 to match the common
-	 * XADC driver alarm layout.
-	 */
-	return ((alarm & 0x80) >> 4) | ((alarm & 0x78) << 1) | (alarm & 0x07);
-}
-
-/*
- * The ZYNQ threshold interrupts are level sensitive. Since we can't make the
- * threshold condition go way from within the interrupt handler, this means as
- * soon as a threshold condition is present we would enter the interrupt handler
- * again and again. To work around this we mask all active thresholds interrupts
- * in the interrupt handler and start a timer. In this timer we poll the
- * interrupt status and only if the interrupt is inactive we unmask it again.
- */
-static void xadc_zynq_unmask_worker(struct work_struct *work)
-{
-	struct xadc *xadc = container_of(work, struct xadc, zynq_unmask_work.work);
-	unsigned int misc_sts, unmask;
-
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &misc_sts);
-
-	misc_sts &= XADC_ZYNQ_INT_ALARM_MASK;
-
-	scoped_guard(spinlock_irq, &xadc->lock) {
-		/* Clear those bits which are not active anymore */
-		unmask = (xadc->zynq_masked_alarm ^ misc_sts) & xadc->zynq_masked_alarm;
-		xadc->zynq_masked_alarm &= misc_sts;
-
-		/* Also clear those which are masked out anyway */
-		xadc->zynq_masked_alarm &= ~xadc->zynq_intmask;
-
-		/* Clear the interrupts before we unmask them */
-		xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, unmask);
-
-		xadc_zynq_update_intmsk(xadc, 0, 0);
-	}
-
-	/* if still pending some alarm re-trigger the timer */
-	if (xadc->zynq_masked_alarm) {
-		schedule_delayed_work(&xadc->zynq_unmask_work,
-				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT_MS));
-	}
-}
-
-static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
-{
-	struct iio_dev *indio_dev = devid;
-	struct xadc *xadc = iio_priv(indio_dev);
-	u32 status;
-
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &status);
-
-	status &= ~(xadc->zynq_intmask | xadc->zynq_masked_alarm);
-
-	if (!status)
-		return IRQ_NONE;
-
-	guard(spinlock)(&xadc->lock);
-
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status);
-
-	if (status & XADC_ZYNQ_INT_DFIFO_GTH) {
-		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
-		complete(&xadc->completion);
-	}
-
-	status &= XADC_ZYNQ_INT_ALARM_MASK;
-	if (status) {
-		xadc->zynq_masked_alarm |= status;
-		/*
-		 * mask the current event interrupt,
-		 * unmask it when the interrupt is no more active.
-		 */
-		xadc_zynq_update_intmsk(xadc, 0, 0);
-
-		xadc_handle_events(indio_dev, xadc_zynq_transform_alarm(status));
-
-		/* unmask the required interrupts in timer. */
-		schedule_delayed_work(&xadc->zynq_unmask_work,
-				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT_MS));
-	}
-
-	return IRQ_HANDLED;
-}
-
-#define XADC_ZYNQ_TCK_RATE_MAX_HZ	50000000
-#define XADC_ZYNQ_IGAP_DEFAULT_CYCLES	20
-#define XADC_ZYNQ_PCAP_RATE_MAX_HZ	200000000
-
-static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_dev, int irq)
-{
-	struct xadc *xadc = iio_priv(indio_dev);
-	unsigned long pcap_rate;
-	unsigned int tck_div;
-	unsigned int div;
-	unsigned int igap;
-	unsigned int tck_rate;
-	int ret;
-
-	/* TODO: Figure out how to make igap and tck_rate configurable */
-	igap = XADC_ZYNQ_IGAP_DEFAULT_CYCLES;
-	tck_rate = XADC_ZYNQ_TCK_RATE_MAX_HZ;
-
-	xadc->zynq_intmask = ~0;
-
-	pcap_rate = clk_get_rate(xadc->clk);
-	if (!pcap_rate)
-		return -EINVAL;
-
-	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX_HZ) {
-		ret = clk_set_rate(xadc->clk, (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX_HZ);
-		if (ret)
-			return ret;
-	}
-
-	if (tck_rate > pcap_rate / 2) {
-		div = 2;
-	} else {
-		div = pcap_rate / tck_rate;
-		if (pcap_rate / div > XADC_ZYNQ_TCK_RATE_MAX_HZ)
-			div++;
-	}
-
-	if (div <= 3)
-		tck_div = XADC_ZYNQ_CFG_TCKRATE_DIV2;
-	else if (div <= 7)
-		tck_div = XADC_ZYNQ_CFG_TCKRATE_DIV4;
-	else if (div <= 15)
-		tck_div = XADC_ZYNQ_CFG_TCKRATE_DIV8;
-	else
-		tck_div = XADC_ZYNQ_CFG_TCKRATE_DIV16;
-
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_CTL, XADC_ZYNQ_CTL_RESET);
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_CTL, 0);
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, ~0);
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask);
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, XADC_ZYNQ_CFG_ENABLE |
-		       XADC_ZYNQ_CFG_REDGE | FIELD_PREP(XADC_ZYNQ_CFG_TCKRATE_MASK, tck_div) |
-		       XADC_ZYNQ_CFG_IGAP(igap));
-
-	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX_HZ) {
-		ret = clk_set_rate(xadc->clk, pcap_rate);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static unsigned long xadc_zynq_get_dclk_rate(struct xadc *xadc)
-{
-	unsigned int div;
-	u32 val;
-
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &val);
-
-	switch (FIELD_GET(XADC_ZYNQ_CFG_TCKRATE_MASK, val)) {
-	case XADC_ZYNQ_CFG_TCKRATE_DIV4:
-		div = 4;
-		break;
-	case XADC_ZYNQ_CFG_TCKRATE_DIV8:
-		div = 8;
-		break;
-	case XADC_ZYNQ_CFG_TCKRATE_DIV16:
-		div = 16;
-		break;
-	default:
-		div = 2;
-		break;
-	}
-
-	return clk_get_rate(xadc->clk) / div;
-}
-
-static void xadc_zynq_update_alarm(struct xadc *xadc, unsigned int alarm)
-{
-	u32 status;
-
-	/* Move OT to bit 7 */
-	alarm = ((alarm & 0x08) << 4) | ((alarm & 0xf0) >> 1) | (alarm & 0x07);
-
-	guard(spinlock_irqsave)(&xadc->lock);
-
-	/* Clear previous interrupts if any. */
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &status);
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status & alarm);
-
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_ALARM_MASK, ~alarm & XADC_ZYNQ_INT_ALARM_MASK);
-}
-
-static const struct xadc_ops xadc_zynq_ops = {
-	.read = xadc_zynq_read_adc_reg,
-	.write = xadc_zynq_write_adc_reg,
-	.setup = xadc_zynq_setup,
-	.get_dclk_rate = xadc_zynq_get_dclk_rate,
-	.interrupt_handler = xadc_zynq_interrupt_handler,
-	.update_alarm = xadc_zynq_update_alarm,
-	.type = XADC_TYPE_S7,
-	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
-	.temp_scale = 503975,
-	.temp_offset = 273150,
-};
-
-static const unsigned int xadc_axi_reg_offsets[] = {
-	[XADC_TYPE_S7] = XADC_7S_AXI_ADC_REG_OFFSET,
-	[XADC_TYPE_US] = XADC_US_AXI_ADC_REG_OFFSET,
-};
-
-static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
-{
-	u32 val32;
-
-	xadc_read_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4, &val32);
-	*val = val32;
-
-	return 0;
-}
-
-static int xadc_axi_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
-{
-	xadc_write_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4, val);
-
-	return 0;
-}
-
-static int xadc_axi_setup(struct platform_device *pdev, struct iio_dev *indio_dev, int irq)
-{
-	struct xadc *xadc = iio_priv(indio_dev);
-
-	xadc_write_reg(xadc, XADC_AXI_REG_RESET, XADC_AXI_RESET_MAGIC);
-	xadc_write_reg(xadc, XADC_AXI_REG_GIER, XADC_AXI_GIER_ENABLE);
-
-	return 0;
-}
-
-static irqreturn_t xadc_axi_interrupt_handler(int irq, void *devid)
-{
-	struct iio_dev *indio_dev = devid;
-	struct xadc *xadc = iio_priv(indio_dev);
-	unsigned int events;
-	u32 status, mask;
-
-	xadc_read_reg(xadc, XADC_AXI_REG_IPISR, &status);
-	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &mask);
-	status &= mask;
-
-	if (!status)
-		return IRQ_NONE;
-
-	if ((status & XADC_AXI_INT_EOS) && xadc->trigger)
-		iio_trigger_poll(xadc->trigger);
-
-	if (status & XADC_AXI_INT_ALARM_MASK) {
-		/*
-		 * The order of the bits in the AXI-XADC status register does
-		 * not match the order of the bits in the XADC alarm enable
-		 * register. xadc_handle_events() expects the events to be in
-		 * the same order as the XADC alarm enable register.
-		 */
-		events = (status & 0x000e) >> 1;
-		events |= (status & 0x0001) << 3;
-		events |= (status & 0x3c00) >> 6;
-		xadc_handle_events(indio_dev, events);
-	}
-
-	xadc_write_reg(xadc, XADC_AXI_REG_IPISR, status);
-
-	return IRQ_HANDLED;
-}
-
-static void xadc_axi_update_alarm(struct xadc *xadc, unsigned int alarm)
-{
-	u32 val;
-
-	/*
-	 * The order of the bits in the AXI-XADC status register does not match
-	 * the order of the bits in the XADC alarm enable register. We get
-	 * passed the alarm mask in the same order as in the XADC alarm enable
-	 * register.
-	 */
-	alarm = ((alarm & 0x07) << 1) | ((alarm & 0x08) >> 3) | ((alarm & 0xf0) << 6);
-
-	guard(spinlock_irqsave)(&xadc->lock);
-	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
-	val &= ~XADC_AXI_INT_ALARM_MASK;
-	val |= alarm;
-	xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
-}
-
-static unsigned long xadc_axi_get_dclk(struct xadc *xadc)
-{
-	return clk_get_rate(xadc->clk);
-}
-
-static const struct xadc_ops xadc_7s_axi_ops = {
-	.read = xadc_axi_read_adc_reg,
-	.write = xadc_axi_write_adc_reg,
-	.setup = xadc_axi_setup,
-	.get_dclk_rate = xadc_axi_get_dclk,
-	.update_alarm = xadc_axi_update_alarm,
-	.interrupt_handler = xadc_axi_interrupt_handler,
-	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
-	.type = XADC_TYPE_S7,
-	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
-	.temp_scale = 503975,
-	.temp_offset = 273150,
-};
-
-static const struct xadc_ops xadc_us_axi_ops = {
-	.read = xadc_axi_read_adc_reg,
-	.write = xadc_axi_write_adc_reg,
-	.setup = xadc_axi_setup,
-	.get_dclk_rate = xadc_axi_get_dclk,
-	.update_alarm = xadc_axi_update_alarm,
-	.interrupt_handler = xadc_axi_interrupt_handler,
-	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
-	.type = XADC_TYPE_US,
-	/**
-	 * Values below are for UltraScale+ (SYSMONE4) using internal reference.
-	 * See https://docs.xilinx.com/v/u/en-US/ug580-ultrascale-sysmon
-	 */
-	.temp_scale = 509314,
-	.temp_offset = 280231,
-};
+EXPORT_SYMBOL_NS_GPL(xadc_read_reg, "IIO_XADC");
 
 static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, u16 mask, u16 val)
 {
@@ -785,7 +257,7 @@ static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
 	return XADC_CONF1_SEQ_SIMULTANEOUS;
 }
 
-static int xadc_postdisable(struct iio_dev *indio_dev)
+int xadc_postdisable(struct iio_dev *indio_dev)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 	unsigned long scan_mask;
@@ -819,6 +291,7 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 
 	return xadc_power_adc_b(xadc, seq_mode);
 }
+EXPORT_SYMBOL_NS_GPL(xadc_postdisable, "IIO_XADC");
 
 static int xadc_preenable(struct iio_dev *indio_dev)
 {
@@ -872,7 +345,7 @@ static const struct iio_buffer_setup_ops xadc_buffer_ops = {
 	.postdisable = &xadc_postdisable,
 };
 
-static int xadc_read_samplerate(struct xadc *xadc)
+int xadc_read_samplerate(struct xadc *xadc)
 {
 	unsigned int div;
 	u16 val16;
@@ -888,6 +361,7 @@ static int xadc_read_samplerate(struct xadc *xadc)
 
 	return xadc_get_dclk_rate(xadc) / div / 26;
 }
+EXPORT_SYMBOL_NS_GPL(xadc_read_samplerate, "IIO_XADC");
 
 static int xadc_read_raw(struct iio_dev *indio_dev,
 			 struct iio_chan_spec const *chan, int *val, int *val2, long info)
@@ -956,7 +430,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static int xadc_setup_buffer_and_triggers(struct iio_dev *indio_dev, int irq)
+int xadc_setup_buffer_and_triggers(struct iio_dev *indio_dev, int irq)
 {
 	struct device *dev = indio_dev->dev.parent;
 	struct xadc *xadc = iio_priv(indio_dev);
@@ -983,8 +457,9 @@ static int xadc_setup_buffer_and_triggers(struct iio_dev *indio_dev, int irq)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(xadc_setup_buffer_and_triggers, "IIO_XADC");
 
-static int xadc_write_samplerate(struct xadc *xadc, int val)
+int xadc_write_samplerate(struct xadc *xadc, int val)
 {
 	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
 	unsigned int div;
@@ -1020,6 +495,7 @@ static int xadc_write_samplerate(struct xadc *xadc, int val)
 	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_DIV_MASK,
 				   FIELD_PREP(XADC_CONF2_DIV_MASK, div));
 }
+EXPORT_SYMBOL_NS_GPL(xadc_write_samplerate, "IIO_XADC");
 
 static int xadc_write_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan, int val, int val2, long info)
@@ -1180,21 +656,6 @@ static const struct iio_info xadc_info = {
 	.update_scan_mode = &xadc_update_scan_mode,
 };
 
-static const struct of_device_id xadc_of_match_table[] = {
-	{
-		.compatible = "xlnx,zynq-xadc-1.00.a",
-		.data = &xadc_zynq_ops
-	}, {
-		.compatible = "xlnx,axi-xadc-1.00.a",
-		.data = &xadc_7s_axi_ops
-	}, {
-		.compatible = "xlnx,system-management-wiz-1.3",
-		.data = &xadc_us_axi_ops
-	},
-	{ }
-};
-MODULE_DEVICE_TABLE(of, xadc_of_match_table);
-
 static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 {
 	struct device *dev = indio_dev->dev.parent;
@@ -1307,7 +768,7 @@ static const char *const xadc_type_names[] = {
 	[XADC_TYPE_US] = "xilinx-system-monitor",
 };
 
-static struct iio_dev *xadc_device_setup(struct device *dev, int size, enum xadc_type type)
+struct iio_dev *xadc_device_setup(struct device *dev, int size, enum xadc_type type)
 {
 	struct iio_dev *indio_dev;
 
@@ -1321,9 +782,10 @@ static struct iio_dev *xadc_device_setup(struct device *dev, int size, enum xadc
 
 	return indio_dev;
 }
+EXPORT_SYMBOL_NS_GPL(xadc_device_setup, "IIO_XADC");
 
-static int xadc_device_configure(struct iio_dev *indio_dev, int irq,
-				 unsigned int *conf0, unsigned int *bipolar_mask)
+int xadc_device_configure(struct iio_dev *indio_dev, int irq,
+			  unsigned int *conf0, unsigned int *bipolar_mask)
 {
 	int ret;
 
@@ -1339,124 +801,8 @@ static int xadc_device_configure(struct iio_dev *indio_dev, int irq,
 
 	return 0;
 }
-
-static void xadc_cancel_delayed_work(void *data)
-{
-	struct delayed_work *work = data;
-
-	cancel_delayed_work_sync(work);
-}
-
-static int xadc_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	const struct xadc_ops *ops;
-	struct iio_dev *indio_dev;
-	unsigned int bipolar_mask;
-	unsigned int conf0;
-	struct xadc *xadc;
-	int ret;
-	int irq;
-	int i;
-
-	ops = device_get_match_data(dev);
-	if (!ops)
-		return -ENODEV;
-
-	indio_dev = xadc_device_setup(dev, sizeof(*xadc), ops->type);
-	if (IS_ERR(indio_dev))
-		return PTR_ERR(indio_dev);
-
-	irq = platform_get_irq_optional(pdev, 0);
-	if (irq < 0 && (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))
-		return irq;
-
-	xadc = iio_priv(indio_dev);
-	xadc->ops = ops;
-	init_completion(&xadc->completion);
-	mutex_init(&xadc->mutex);
-	spin_lock_init(&xadc->lock);
-	INIT_DELAYED_WORK(&xadc->zynq_unmask_work, xadc_zynq_unmask_worker);
-
-	xadc->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(xadc->base))
-		return PTR_ERR(xadc->base);
-
-	ret = xadc_device_configure(indio_dev, irq, &conf0, &bipolar_mask);
-	if (ret)
-		return ret;
-
-	ret = xadc_setup_buffer_and_triggers(indio_dev, irq);
-	if (ret)
-		return ret;
-
-	xadc->clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(xadc->clk))
-		return PTR_ERR(xadc->clk);
-
-	/*
-	 * Make sure not to exceed the maximum samplerate since otherwise the
-	 * resulting interrupt storm will soft-lock the system.
-	 */
-	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
-		ret = xadc_read_samplerate(xadc);
-		if (ret < 0)
-			return ret;
-
-		if (ret > XADC_MAX_SAMPLERATE_SPS) {
-			ret = xadc_write_samplerate(xadc, XADC_MAX_SAMPLERATE_SPS);
-			if (ret < 0)
-				return ret;
-		}
-	}
-
-	if (irq > 0) {
-		/* Clear out any work queued by the interrupt */
-		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
-					       &xadc->zynq_unmask_work);
-		if (ret)
-			return ret;
-
-		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
-				       0, dev_name(dev), indio_dev);
-		if (ret)
-			return ret;
-	}
-
-	ret = xadc->ops->setup(pdev, indio_dev, irq);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < 16; i++)
-		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i), &xadc->threshold[i]);
-
-	ret = xadc_write_adc_reg(xadc, XADC_REG_CONF0, conf0);
-	if (ret)
-		return ret;
-
-	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(0), bipolar_mask);
-	if (ret)
-		return ret;
-
-	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(1), bipolar_mask >> 16);
-	if (ret)
-		return ret;
-
-	/* Go to non-buffered mode */
-	xadc_postdisable(indio_dev);
-
-	return devm_iio_device_register(dev, indio_dev);
-}
-
-static struct platform_driver xadc_driver = {
-	.probe = xadc_probe,
-	.driver = {
-		.name = "xadc",
-		.of_match_table = xadc_of_match_table,
-	},
-};
-module_platform_driver(xadc_driver);
+EXPORT_SYMBOL_NS_GPL(xadc_device_configure, "IIO_XADC");
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
-MODULE_DESCRIPTION("Xilinx XADC IIO driver");
+MODULE_DESCRIPTION("Xilinx XADC IIO core driver");
diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
index a63ea766b712..bb5ac1985cee 100644
--- a/drivers/iio/adc/xilinx-xadc-events.c
+++ b/drivers/iio/adc/xilinx-xadc-events.c
@@ -69,6 +69,7 @@ void xadc_handle_events(struct iio_dev *indio_dev, unsigned long events)
 	for_each_set_bit(i, &events, 8)
 		xadc_handle_event(indio_dev, i);
 }
+EXPORT_SYMBOL_NS_GPL(xadc_handle_events, "IIO_XADC");
 
 static unsigned int xadc_get_threshold_offset(const struct iio_chan_spec *chan,
 					      enum iio_event_direction dir)
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-platform.c
similarity index 44%
copy from drivers/iio/adc/xilinx-xadc-core.c
copy to drivers/iio/adc/xilinx-xadc-platform.c
index 9d5cc6c86c98..68610c0ffa43 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-platform.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Xilinx XADC driver
+ * Xilinx XADC platform driver
  *
  * Copyright 2013-2014 Analog Devices Inc.
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
@@ -11,13 +11,10 @@
  *  - AXI XADC interface: Xilinx PG019
  */
 
-#include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
-#include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
-#include <linux/container_of.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -25,15 +22,10 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
-#include <linux/slab.h>
-#include <linux/types.h>
 
-#include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
-#include <linux/iio/trigger_consumer.h>
-#include <linux/iio/triggered_buffer.h>
 
 #include "xilinx-xadc.h"
 
@@ -94,8 +86,6 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT_MS = 500;
 #define XADC_AXI_REG_CONVST		0x0c
 #define XADC_AXI_REG_XADC_RESET		0x10
 #define XADC_AXI_REG_GIER		0x5c
-#define XADC_AXI_REG_IPISR		0x60
-#define XADC_AXI_REG_IPIER		0x68
 
 /* 7 Series */
 #define XADC_7S_AXI_ADC_REG_OFFSET	0x200
@@ -106,36 +96,12 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT_MS = 500;
 #define XADC_AXI_RESET_MAGIC		0xa
 #define XADC_AXI_GIER_ENABLE		BIT(31)
 
-#define XADC_AXI_INT_EOS		BIT(4)
-#define XADC_AXI_INT_ALARM_OT		BIT(0)
-#define XADC_AXI_INT_ALARM_TEMP_SUPPLY		GENMASK(3, 1)
-#define XADC_AXI_INT_ALARM_SUPPLY		GENMASK(13, 10)
-#define XADC_AXI_INT_ALARM_MASK		(XADC_AXI_INT_ALARM_SUPPLY | \
-					 XADC_AXI_INT_ALARM_TEMP_SUPPLY | \
-					 XADC_AXI_INT_ALARM_OT)
-
-#define XADC_FLAGS_BUFFERED BIT(0)
-#define XADC_FLAGS_IRQ_OPTIONAL BIT(1)
-
-/*
- * The XADC hardware supports a samplerate of up to 1MSPS. Unfortunately it does
- * not have a hardware FIFO. Which means an interrupt is generated for each
- * conversion sequence. At 1MSPS sample rate the CPU in ZYNQ7000 is completely
- * overloaded by the interrupts that it soft-lockups. For this reason the driver
- * limits the maximum samplerate 150kSPS. At this rate the CPU is fairly busy,
- * but still responsive.
- */
-#define XADC_MAX_SAMPLERATE_SPS 150000
-
-static void xadc_write_reg(struct xadc *xadc, unsigned int reg, u32 val)
-{
-	writel(val, xadc->base + reg);
-}
-
-static void xadc_read_reg(struct xadc *xadc, unsigned int reg, u32 *val)
-{
-	*val = readl(xadc->base + reg);
-}
+#define XADC_AXI_INT_ALARM_OT      BIT(0)
+#define XADC_AXI_INT_ALARM_TEMP_SUPPLY     GENMASK(3, 1)
+#define XADC_AXI_INT_ALARM_SUPPLY      GENMASK(13, 10)
+#define XADC_AXI_INT_ALARM_MASK        (XADC_AXI_INT_ALARM_SUPPLY | \
+					XADC_AXI_INT_ALARM_TEMP_SUPPLY | \
+					XADC_AXI_INT_ALARM_OT)
 
 /*
  * The ZYNQ interface uses two asynchronous FIFOs for communication with the
@@ -387,8 +353,7 @@ static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_d
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, ~0);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, XADC_ZYNQ_CFG_ENABLE |
-		       XADC_ZYNQ_CFG_REDGE | FIELD_PREP(XADC_ZYNQ_CFG_TCKRATE_MASK, tck_div) |
-		       XADC_ZYNQ_CFG_IGAP(igap));
+		       XADC_ZYNQ_CFG_REDGE | tck_div | XADC_ZYNQ_CFG_IGAP(igap));
 
 	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX_HZ) {
 		ret = clk_set_rate(xadc->clk, pcap_rate);
@@ -406,7 +371,7 @@ static unsigned long xadc_zynq_get_dclk_rate(struct xadc *xadc)
 
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &val);
 
-	switch (FIELD_GET(XADC_ZYNQ_CFG_TCKRATE_MASK, val)) {
+	switch (val & XADC_ZYNQ_CFG_TCKRATE_MASK) {
 	case XADC_ZYNQ_CFG_TCKRATE_DIV4:
 		div = 4;
 		break;
@@ -575,611 +540,6 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.temp_offset = 280231,
 };
 
-static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, u16 mask, u16 val)
-{
-	u16 tmp;
-	int ret;
-
-	ret = _xadc_read_adc_reg(xadc, reg, &tmp);
-	if (ret)
-		return ret;
-
-	return _xadc_write_adc_reg(xadc, reg, (tmp & ~mask) | val);
-}
-
-static int xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, u16 mask, u16 val)
-{
-	int ret;
-
-	guard(mutex)(&xadc->mutex);
-	ret = _xadc_update_adc_reg(xadc, reg, mask, val);
-
-	return ret;
-}
-
-static unsigned long xadc_get_dclk_rate(struct xadc *xadc)
-{
-	return xadc->ops->get_dclk_rate(xadc);
-}
-
-static int xadc_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *mask)
-{
-	struct xadc *xadc = iio_priv(indio_dev);
-	void *data;
-	size_t n;
-
-	n = bitmap_weight(mask, iio_get_masklength(indio_dev));
-
-	data = devm_krealloc_array(indio_dev->dev.parent, xadc->data, n,
-				   sizeof(*xadc->data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	memset(data, 0, n * sizeof(*xadc->data));
-	xadc->data = data;
-
-	return 0;
-}
-
-static unsigned int xadc_scan_index_to_channel(unsigned int scan_index)
-{
-	switch (scan_index) {
-	case 5:
-		return XADC_REG_VCCPINT;
-	case 6:
-		return XADC_REG_VCCPAUX;
-	case 7:
-		return XADC_REG_VCCO_DDR;
-	case 8:
-		return XADC_REG_TEMP;
-	case 9:
-		return XADC_REG_VCCINT;
-	case 10:
-		return XADC_REG_VCCAUX;
-	case 11:
-		return XADC_REG_VPVN;
-	case 12:
-		return XADC_REG_VREFP;
-	case 13:
-		return XADC_REG_VREFN;
-	case 14:
-		return XADC_REG_VCCBRAM;
-	default:
-		return XADC_REG_VAUX(scan_index - 16);
-	}
-}
-
-static irqreturn_t xadc_trigger_handler(int irq, void *p)
-{
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
-	struct xadc *xadc = iio_priv(indio_dev);
-	unsigned int chan;
-	int i, j;
-
-	if (!xadc->data)
-		goto out;
-
-	j = 0;
-	iio_for_each_active_channel(indio_dev, i) {
-		chan = xadc_scan_index_to_channel(i);
-		xadc_read_adc_reg(xadc, chan, &xadc->data[j]);
-		j++;
-	}
-
-	iio_push_to_buffers(indio_dev, xadc->data);
-
-out:
-	iio_trigger_notify_done(indio_dev->trig);
-
-	return IRQ_HANDLED;
-}
-
-static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
-{
-	struct xadc *xadc = iio_trigger_get_drvdata(trigger);
-	unsigned int convst;
-	unsigned int val;
-	int ret = 0;
-
-	guard(mutex)(&xadc->mutex);
-
-	if (state) {
-		/* Only one of the two triggers can be active at a time. */
-		if (xadc->trigger) {
-			return -EBUSY;
-		} else {
-			xadc->trigger = trigger;
-			if (trigger == xadc->convst_trigger)
-				convst = XADC_CONF0_EC;
-			else
-				convst = 0;
-		}
-		ret = _xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF0_EC, convst);
-		if (ret)
-			return ret;
-	} else {
-		xadc->trigger = NULL;
-	}
-
-	scoped_guard(spinlock_irqsave, &xadc->lock) {
-		xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
-		xadc_write_reg(xadc, XADC_AXI_REG_IPISR, XADC_AXI_INT_EOS);
-		if (state)
-			val |= XADC_AXI_INT_EOS;
-		else
-			val &= ~XADC_AXI_INT_EOS;
-		xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
-	}
-
-	return 0;
-}
-
-static const struct iio_trigger_ops xadc_trigger_ops = {
-	.set_trigger_state = &xadc_trigger_set_state,
-};
-
-static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev, const char *name)
-{
-	struct device *dev = indio_dev->dev.parent;
-	struct iio_trigger *trig;
-	int ret;
-
-	trig = devm_iio_trigger_alloc(dev, "%s%d-%s", indio_dev->name,
-				      iio_device_id(indio_dev), name);
-	if (!trig)
-		return ERR_PTR(-ENOMEM);
-
-	trig->ops = &xadc_trigger_ops;
-	iio_trigger_set_drvdata(trig, iio_priv(indio_dev));
-
-	ret = devm_iio_trigger_register(dev, trig);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return trig;
-}
-
-static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
-{
-	u16 val;
-
-	/*
-	 * As per datasheet the power-down bits are don't care in the
-	 * UltraScale, but as per reality setting the power-down bit for the
-	 * non-existing ADC-B powers down the main ADC, so just return and don't
-	 * do anything.
-	 */
-	if (xadc->ops->type == XADC_TYPE_US)
-		return 0;
-
-	/* Powerdown the ADC-B when it is not needed. */
-	switch (seq_mode) {
-	case XADC_CONF1_SEQ_SIMULTANEOUS:
-	case XADC_CONF1_SEQ_INDEPENDENT:
-		val = 0;
-		break;
-	default:
-		val = XADC_CONF2_PD_ADC_B;
-		break;
-	}
-
-	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_PD_MASK,
-				   FIELD_PREP(XADC_CONF2_PD_MASK, val));
-}
-
-static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
-{
-	unsigned int aux_scan_mode = scan_mode >> 16;
-
-	/* UltraScale has only one ADC and supports only continuous mode */
-	if (xadc->ops->type == XADC_TYPE_US)
-		return XADC_CONF1_SEQ_CONTINUOUS;
-
-	if (xadc->external_mux_mode == XADC_EXTERNAL_MUX_DUAL)
-		return XADC_CONF1_SEQ_SIMULTANEOUS;
-
-	if ((aux_scan_mode & 0xff00) == 0 || (aux_scan_mode & 0x00ff) == 0)
-		return XADC_CONF1_SEQ_CONTINUOUS;
-
-	return XADC_CONF1_SEQ_SIMULTANEOUS;
-}
-
-static int xadc_postdisable(struct iio_dev *indio_dev)
-{
-	struct xadc *xadc = iio_priv(indio_dev);
-	unsigned long scan_mask;
-	int seq_mode;
-	int ret;
-	int i;
-
-	scan_mask = 1; /* Run calibration as part of the sequence */
-	for (i = 0; i < indio_dev->num_channels; i++)
-		scan_mask |= BIT(indio_dev->channels[i].scan_index);
-
-	/*
-	 * Use the correct sequencer mode for the idle state: simultaneous
-	 * mode for dual external mux configurations, continuous otherwise.
-	 */
-	seq_mode = xadc_get_seq_mode(xadc, scan_mask);
-
-	/* Enable all channels and calibration */
-	ret = xadc_write_adc_reg(xadc, XADC_REG_SEQ(0), scan_mask & 0xffff);
-	if (ret)
-		return ret;
-
-	ret = xadc_write_adc_reg(xadc, XADC_REG_SEQ(1), scan_mask >> 16);
-	if (ret)
-		return ret;
-
-	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
-				  FIELD_PREP(XADC_CONF1_SEQ_MASK, seq_mode));
-	if (ret)
-		return ret;
-
-	return xadc_power_adc_b(xadc, seq_mode);
-}
-
-static int xadc_preenable(struct iio_dev *indio_dev)
-{
-	struct xadc *xadc = iio_priv(indio_dev);
-	unsigned long scan_mask;
-	int seq_mode;
-	int ret;
-
-	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
-				  FIELD_PREP(XADC_CONF1_SEQ_MASK, XADC_CONF1_SEQ_DEFAULT));
-	if (ret)
-		goto err;
-
-	scan_mask = *indio_dev->active_scan_mask;
-	seq_mode = xadc_get_seq_mode(xadc, scan_mask);
-
-	ret = xadc_write_adc_reg(xadc, XADC_REG_SEQ(0), scan_mask & 0xffff);
-	if (ret)
-		goto err;
-
-	/*
-	 * In simultaneous mode the upper and lower aux channels are samples at
-	 * the same time. In this mode the upper 8 bits in the sequencer
-	 * register are don't care and the lower 8 bits control two channels
-	 * each. As such we must set the bit if either the channel in the lower
-	 * group or the upper group is enabled.
-	 */
-	if (seq_mode == XADC_CONF1_SEQ_SIMULTANEOUS)
-		scan_mask = ((scan_mask >> 8) | scan_mask) & 0xff0000;
-
-	ret = xadc_write_adc_reg(xadc, XADC_REG_SEQ(1), scan_mask >> 16);
-	if (ret)
-		goto err;
-
-	ret = xadc_power_adc_b(xadc, seq_mode);
-	if (ret)
-		goto err;
-
-	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK, seq_mode);
-	if (ret)
-		goto err;
-
-	return 0;
-err:
-	xadc_postdisable(indio_dev);
-	return ret;
-}
-
-static const struct iio_buffer_setup_ops xadc_buffer_ops = {
-	.preenable = &xadc_preenable,
-	.postdisable = &xadc_postdisable,
-};
-
-static int xadc_read_samplerate(struct xadc *xadc)
-{
-	unsigned int div;
-	u16 val16;
-	int ret;
-
-	ret = xadc_read_adc_reg(xadc, XADC_REG_CONF2, &val16);
-	if (ret)
-		return ret;
-
-	div = FIELD_GET(XADC_CONF2_DIV_MASK, val16);
-	if (div < 2)
-		div = 2;
-
-	return xadc_get_dclk_rate(xadc) / div / 26;
-}
-
-static int xadc_read_raw(struct iio_dev *indio_dev,
-			 struct iio_chan_spec const *chan, int *val, int *val2, long info)
-{
-	struct xadc *xadc = iio_priv(indio_dev);
-	unsigned int bits = chan->scan_type.realbits;
-	u16 val16;
-	int ret;
-
-	switch (info) {
-	case IIO_CHAN_INFO_RAW:
-		if (iio_buffer_enabled(indio_dev))
-			return -EBUSY;
-		ret = xadc_read_adc_reg(xadc, chan->address, &val16);
-		if (ret < 0)
-			return ret;
-
-		val16 >>= chan->scan_type.shift;
-		if (chan->scan_type.sign == 'u')
-			*val = val16;
-		else
-			*val = sign_extend32(val16, bits - 1);
-
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE:
-		switch (chan->type) {
-		case IIO_VOLTAGE:
-			/* V = (val * 3.0) / 2**bits */
-			switch (chan->address) {
-			case XADC_REG_VCCINT:
-			case XADC_REG_VCCAUX:
-			case XADC_REG_VREFP:
-			case XADC_REG_VREFN:
-			case XADC_REG_VCCBRAM:
-			case XADC_REG_VCCPINT:
-			case XADC_REG_VCCPAUX:
-			case XADC_REG_VCCO_DDR:
-				*val = 3000;
-				break;
-			default:
-				*val = 1000;
-				break;
-			}
-			*val2 = bits;
-			return IIO_VAL_FRACTIONAL_LOG2;
-		case IIO_TEMP:
-			*val = xadc->ops->temp_scale;
-			*val2 = bits;
-			return IIO_VAL_FRACTIONAL_LOG2;
-		default:
-			return -EINVAL;
-		}
-	case IIO_CHAN_INFO_OFFSET:
-		/* Only the temperature channel has an offset */
-		*val = -((xadc->ops->temp_offset << bits) / xadc->ops->temp_scale);
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = xadc_read_samplerate(xadc);
-		if (ret < 0)
-			return ret;
-
-		*val = ret;
-		return IIO_VAL_INT;
-	default:
-		return -EINVAL;
-	}
-}
-
-static int xadc_setup_buffer_and_triggers(struct iio_dev *indio_dev, int irq)
-{
-	struct device *dev = indio_dev->dev.parent;
-	struct xadc *xadc = iio_priv(indio_dev);
-	int ret;
-
-	if (!(xadc->ops->flags & XADC_FLAGS_BUFFERED))
-		return 0;
-
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, &iio_pollfunc_store_time,
-					      &xadc_trigger_handler, &xadc_buffer_ops);
-	if (ret)
-		return ret;
-
-	if (irq <= 0)
-		return 0;
-
-	xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
-	if (IS_ERR(xadc->convst_trigger))
-		return PTR_ERR(xadc->convst_trigger);
-
-	xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev, "samplerate");
-	if (IS_ERR(xadc->samplerate_trigger))
-		return PTR_ERR(xadc->samplerate_trigger);
-
-	return 0;
-}
-
-static int xadc_write_samplerate(struct xadc *xadc, int val)
-{
-	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
-	unsigned int div;
-
-	if (!clk_rate)
-		return -EINVAL;
-
-	if (val <= 0)
-		return -EINVAL;
-
-	/* Max. 150 kSPS */
-	if (val > XADC_MAX_SAMPLERATE_SPS)
-		val = XADC_MAX_SAMPLERATE_SPS;
-
-	val *= 26;
-
-	/* Min 1MHz */
-	if (val < 1000000)
-		val = 1000000;
-
-	/*
-	 * We want to round down, but only if we do not exceed the 150 kSPS
-	 * limit.
-	 */
-	div = clk_rate / val;
-	if (clk_rate / div / 26 > XADC_MAX_SAMPLERATE_SPS)
-		div++;
-	if (div < 2)
-		div = 2;
-	else if (div > 0xff)
-		div = 0xff;
-
-	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_DIV_MASK,
-				   FIELD_PREP(XADC_CONF2_DIV_MASK, div));
-}
-
-static int xadc_write_raw(struct iio_dev *indio_dev,
-			  struct iio_chan_spec const *chan, int val, int val2, long info)
-{
-	struct xadc *xadc = iio_priv(indio_dev);
-
-	if (info != IIO_CHAN_INFO_SAMP_FREQ)
-		return -EINVAL;
-
-	return xadc_write_samplerate(xadc, val);
-}
-
-static const struct iio_event_spec xadc_temp_events[] = {
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_RISING,
-		.mask_separate = BIT(IIO_EV_INFO_ENABLE) | BIT(IIO_EV_INFO_VALUE) |
-				 BIT(IIO_EV_INFO_HYSTERESIS),
-	},
-};
-
-/* Separate values for upper and lower thresholds, but only a shared enabled */
-static const struct iio_event_spec xadc_voltage_events[] = {
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_RISING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE),
-	}, {
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_FALLING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE),
-	}, {
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
-	},
-};
-
-#define XADC_CHAN_TEMP(_chan, _scan_index, _addr, _bits) { \
-	.type = IIO_TEMP, \
-	.indexed = 1, \
-	.channel = (_chan), \
-	.address = (_addr), \
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
-		BIT(IIO_CHAN_INFO_SCALE) | \
-		BIT(IIO_CHAN_INFO_OFFSET), \
-	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
-	.event_spec = xadc_temp_events, \
-	.num_event_specs = ARRAY_SIZE(xadc_temp_events), \
-	.scan_index = (_scan_index), \
-	.scan_type = { \
-		.sign = 'u', \
-		.realbits = (_bits), \
-		.storagebits = 16, \
-		.shift = 16 - (_bits), \
-		.endianness = IIO_CPU, \
-	}, \
-}
-
-#define XADC_CHAN_VOLTAGE(_chan, _scan_index, _addr, _bits, _ext, _alarm) { \
-	.type = IIO_VOLTAGE, \
-	.indexed = 1, \
-	.channel = (_chan), \
-	.address = (_addr), \
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
-		BIT(IIO_CHAN_INFO_SCALE), \
-	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
-	.event_spec = (_alarm) ? xadc_voltage_events : NULL, \
-	.num_event_specs = (_alarm) ? ARRAY_SIZE(xadc_voltage_events) : 0, \
-	.scan_index = (_scan_index), \
-	.scan_type = { \
-		.sign = ((_addr) == XADC_REG_VREFN) ? 's' : 'u', \
-		.realbits = (_bits), \
-		.storagebits = 16, \
-		.shift = 16 - (_bits), \
-		.endianness = IIO_CPU, \
-	}, \
-	.extend_name = _ext, \
-}
-
-/* 7 Series */
-#define XADC_7S_CHAN_TEMP(_chan, _scan_index, _addr) \
-	XADC_CHAN_TEMP(_chan, _scan_index, _addr, 12)
-#define XADC_7S_CHAN_VOLTAGE(_chan, _scan_index, _addr, _ext, _alarm) \
-	XADC_CHAN_VOLTAGE(_chan, _scan_index, _addr, 12, _ext, _alarm)
-
-static const struct iio_chan_spec xadc_7s_channels[] = {
-	XADC_7S_CHAN_TEMP(0, 8, XADC_REG_TEMP),
-	XADC_7S_CHAN_VOLTAGE(0, 9, XADC_REG_VCCINT, "vccint", true),
-	XADC_7S_CHAN_VOLTAGE(1, 10, XADC_REG_VCCAUX, "vccaux", true),
-	XADC_7S_CHAN_VOLTAGE(2, 14, XADC_REG_VCCBRAM, "vccbram", true),
-	XADC_7S_CHAN_VOLTAGE(3, 5, XADC_REG_VCCPINT, "vccpint", true),
-	XADC_7S_CHAN_VOLTAGE(4, 6, XADC_REG_VCCPAUX, "vccpaux", true),
-	XADC_7S_CHAN_VOLTAGE(5, 7, XADC_REG_VCCO_DDR, "vccoddr", true),
-	XADC_7S_CHAN_VOLTAGE(6, 12, XADC_REG_VREFP, "vrefp", false),
-	XADC_7S_CHAN_VOLTAGE(7, 13, XADC_REG_VREFN, "vrefn", false),
-	XADC_7S_CHAN_VOLTAGE(8, 11, XADC_REG_VPVN, NULL, false),
-	XADC_7S_CHAN_VOLTAGE(9, 16, XADC_REG_VAUX(0), NULL, false),
-	XADC_7S_CHAN_VOLTAGE(10, 17, XADC_REG_VAUX(1), NULL, false),
-	XADC_7S_CHAN_VOLTAGE(11, 18, XADC_REG_VAUX(2), NULL, false),
-	XADC_7S_CHAN_VOLTAGE(12, 19, XADC_REG_VAUX(3), NULL, false),
-	XADC_7S_CHAN_VOLTAGE(13, 20, XADC_REG_VAUX(4), NULL, false),
-	XADC_7S_CHAN_VOLTAGE(14, 21, XADC_REG_VAUX(5), NULL, false),
-	XADC_7S_CHAN_VOLTAGE(15, 22, XADC_REG_VAUX(6), NULL, false),
-	XADC_7S_CHAN_VOLTAGE(16, 23, XADC_REG_VAUX(7), NULL, false),
-	XADC_7S_CHAN_VOLTAGE(17, 24, XADC_REG_VAUX(8), NULL, false),
-	XADC_7S_CHAN_VOLTAGE(18, 25, XADC_REG_VAUX(9), NULL, false),
-	XADC_7S_CHAN_VOLTAGE(19, 26, XADC_REG_VAUX(10), NULL, false),
-	XADC_7S_CHAN_VOLTAGE(20, 27, XADC_REG_VAUX(11), NULL, false),
-	XADC_7S_CHAN_VOLTAGE(21, 28, XADC_REG_VAUX(12), NULL, false),
-	XADC_7S_CHAN_VOLTAGE(22, 29, XADC_REG_VAUX(13), NULL, false),
-	XADC_7S_CHAN_VOLTAGE(23, 30, XADC_REG_VAUX(14), NULL, false),
-	XADC_7S_CHAN_VOLTAGE(24, 31, XADC_REG_VAUX(15), NULL, false),
-};
-
-/* UltraScale */
-#define XADC_US_CHAN_TEMP(_chan, _scan_index, _addr) \
-	XADC_CHAN_TEMP(_chan, _scan_index, _addr, 10)
-#define XADC_US_CHAN_VOLTAGE(_chan, _scan_index, _addr, _ext, _alarm) \
-	XADC_CHAN_VOLTAGE(_chan, _scan_index, _addr, 10, _ext, _alarm)
-
-static const struct iio_chan_spec xadc_us_channels[] = {
-	XADC_US_CHAN_TEMP(0, 8, XADC_REG_TEMP),
-	XADC_US_CHAN_VOLTAGE(0, 9, XADC_REG_VCCINT, "vccint", true),
-	XADC_US_CHAN_VOLTAGE(1, 10, XADC_REG_VCCAUX, "vccaux", true),
-	XADC_US_CHAN_VOLTAGE(2, 14, XADC_REG_VCCBRAM, "vccbram", true),
-	XADC_US_CHAN_VOLTAGE(3, 5, XADC_REG_VCCPINT, "vccpsintlp", true),
-	XADC_US_CHAN_VOLTAGE(4, 6, XADC_REG_VCCPAUX, "vccpsintfp", true),
-	XADC_US_CHAN_VOLTAGE(5, 7, XADC_REG_VCCO_DDR, "vccpsaux", true),
-	XADC_US_CHAN_VOLTAGE(6, 12, XADC_REG_VREFP, "vrefp", false),
-	XADC_US_CHAN_VOLTAGE(7, 13, XADC_REG_VREFN, "vrefn", false),
-	XADC_US_CHAN_VOLTAGE(8, 11, XADC_REG_VPVN, NULL, false),
-	XADC_US_CHAN_VOLTAGE(9, 16, XADC_REG_VAUX(0), NULL, false),
-	XADC_US_CHAN_VOLTAGE(10, 17, XADC_REG_VAUX(1), NULL, false),
-	XADC_US_CHAN_VOLTAGE(11, 18, XADC_REG_VAUX(2), NULL, false),
-	XADC_US_CHAN_VOLTAGE(12, 19, XADC_REG_VAUX(3), NULL, false),
-	XADC_US_CHAN_VOLTAGE(13, 20, XADC_REG_VAUX(4), NULL, false),
-	XADC_US_CHAN_VOLTAGE(14, 21, XADC_REG_VAUX(5), NULL, false),
-	XADC_US_CHAN_VOLTAGE(15, 22, XADC_REG_VAUX(6), NULL, false),
-	XADC_US_CHAN_VOLTAGE(16, 23, XADC_REG_VAUX(7), NULL, false),
-	XADC_US_CHAN_VOLTAGE(17, 24, XADC_REG_VAUX(8), NULL, false),
-	XADC_US_CHAN_VOLTAGE(18, 25, XADC_REG_VAUX(9), NULL, false),
-	XADC_US_CHAN_VOLTAGE(19, 26, XADC_REG_VAUX(10), NULL, false),
-	XADC_US_CHAN_VOLTAGE(20, 27, XADC_REG_VAUX(11), NULL, false),
-	XADC_US_CHAN_VOLTAGE(21, 28, XADC_REG_VAUX(12), NULL, false),
-	XADC_US_CHAN_VOLTAGE(22, 29, XADC_REG_VAUX(13), NULL, false),
-	XADC_US_CHAN_VOLTAGE(23, 30, XADC_REG_VAUX(14), NULL, false),
-	XADC_US_CHAN_VOLTAGE(24, 31, XADC_REG_VAUX(15), NULL, false),
-};
-
-static const struct iio_info xadc_info = {
-	.read_raw = &xadc_read_raw,
-	.write_raw = &xadc_write_raw,
-	.read_event_config = &xadc_read_event_config,
-	.write_event_config = &xadc_write_event_config,
-	.read_event_value = &xadc_read_event_value,
-	.write_event_value = &xadc_write_event_value,
-	.update_scan_mode = &xadc_update_scan_mode,
-};
-
 static const struct of_device_id xadc_of_match_table[] = {
 	{
 		.compatible = "xlnx,zynq-xadc-1.00.a",
@@ -1195,151 +555,6 @@ static const struct of_device_id xadc_of_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, xadc_of_match_table);
 
-static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
-{
-	struct device *dev = indio_dev->dev.parent;
-	struct xadc *xadc = iio_priv(indio_dev);
-	const struct iio_chan_spec *channel_templates;
-	struct iio_chan_spec *channels, *chan;
-	struct fwnode_handle *chan_node, *child;
-	unsigned int max_channels;
-	unsigned int num_channels;
-	const char *external_mux;
-	u32 ext_mux_chan;
-	u32 reg;
-	int ret;
-	int i;
-
-	*conf = 0;
-
-	ret = device_property_read_string(dev, "xlnx,external-mux", &external_mux);
-	if (ret < 0 || strcasecmp(external_mux, "none") == 0)
-		xadc->external_mux_mode = XADC_EXTERNAL_MUX_NONE;
-	else if (strcasecmp(external_mux, "single") == 0)
-		xadc->external_mux_mode = XADC_EXTERNAL_MUX_SINGLE;
-	else if (strcasecmp(external_mux, "dual") == 0)
-		xadc->external_mux_mode = XADC_EXTERNAL_MUX_DUAL;
-	else
-		return -EINVAL;
-
-	if (xadc->external_mux_mode != XADC_EXTERNAL_MUX_NONE) {
-		ret = device_property_read_u32(dev, "xlnx,external-mux-channel", &ext_mux_chan);
-		if (ret < 0)
-			return ret;
-
-		if (xadc->external_mux_mode == XADC_EXTERNAL_MUX_SINGLE) {
-			if (ext_mux_chan == 0)
-				ext_mux_chan = XADC_REG_VPVN;
-			else if (ext_mux_chan <= 16)
-				ext_mux_chan = XADC_REG_VAUX(ext_mux_chan - 1);
-			else
-				return -EINVAL;
-		} else {
-			if (ext_mux_chan > 0 && ext_mux_chan <= 8)
-				ext_mux_chan = XADC_REG_VAUX(ext_mux_chan - 1);
-			else
-				return -EINVAL;
-		}
-
-		*conf |= XADC_CONF0_MUX | XADC_CONF0_CHAN(ext_mux_chan);
-	}
-	if (xadc->ops->type == XADC_TYPE_S7) {
-		channel_templates = xadc_7s_channels;
-		max_channels = ARRAY_SIZE(xadc_7s_channels);
-	} else {
-		channel_templates = xadc_us_channels;
-		max_channels = ARRAY_SIZE(xadc_us_channels);
-	}
-	channels = devm_kmemdup_array(dev, channel_templates, max_channels,
-				      sizeof(*channel_templates), GFP_KERNEL);
-	if (!channels)
-		return -ENOMEM;
-
-	num_channels = 9;
-	chan = &channels[9];
-
-	chan_node = device_get_named_child_node(dev, "xlnx,channels");
-	fwnode_for_each_child_node(chan_node, child) {
-		if (num_channels >= max_channels) {
-			fwnode_handle_put(child);
-			break;
-		}
-
-		ret = fwnode_property_read_u32(child, "reg", &reg);
-		if (ret || reg > 16)
-			continue;
-
-		if (fwnode_property_read_bool(child, "xlnx,bipolar"))
-			chan->scan_type.sign = 's';
-
-		if (reg == 0) {
-			chan->scan_index = 11;
-			chan->address = XADC_REG_VPVN;
-		} else {
-			chan->scan_index = 15 + reg;
-			chan->address = XADC_REG_VAUX(reg - 1);
-		}
-		num_channels++;
-		chan++;
-	}
-	fwnode_handle_put(chan_node);
-
-	/* No IRQ => no events */
-	if (irq <= 0) {
-		for (i = 0; i < num_channels; i++) {
-			channels[i].event_spec = NULL;
-			channels[i].num_event_specs = 0;
-		}
-	}
-
-	indio_dev->num_channels = num_channels;
-	indio_dev->channels = devm_krealloc_array(dev, channels, num_channels,
-						  sizeof(*channels), GFP_KERNEL);
-	/* If we can't resize the channels array, just use the original */
-	if (!indio_dev->channels)
-		indio_dev->channels = channels;
-
-	return 0;
-}
-
-static const char *const xadc_type_names[] = {
-	[XADC_TYPE_S7] = "xadc",
-	[XADC_TYPE_US] = "xilinx-system-monitor",
-};
-
-static struct iio_dev *xadc_device_setup(struct device *dev, int size, enum xadc_type type)
-{
-	struct iio_dev *indio_dev;
-
-	indio_dev = devm_iio_device_alloc(dev, size);
-	if (!indio_dev)
-		return ERR_PTR(-ENOMEM);
-
-	indio_dev->name = xadc_type_names[type];
-	indio_dev->info = &xadc_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
-	return indio_dev;
-}
-
-static int xadc_device_configure(struct iio_dev *indio_dev, int irq,
-				 unsigned int *conf0, unsigned int *bipolar_mask)
-{
-	int ret;
-
-	ret = xadc_parse_dt(indio_dev, conf0, irq);
-	if (ret)
-		return ret;
-
-	*bipolar_mask = 0;
-	for (unsigned int i = 0; i < indio_dev->num_channels; i++) {
-		if (indio_dev->channels[i].scan_type.sign == 's')
-			*bipolar_mask |= BIT(indio_dev->channels[i].scan_index);
-	}
-
-	return 0;
-}
-
 static void xadc_cancel_delayed_work(void *data)
 {
 	struct delayed_work *work = data;
@@ -1411,14 +626,13 @@ static int xadc_probe(struct platform_device *pdev)
 	}
 
 	if (irq > 0) {
-		/* Clear out any work queued by the interrupt */
-		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
-					       &xadc->zynq_unmask_work);
+		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
+				       0, dev_name(dev), indio_dev);
 		if (ret)
 			return ret;
 
-		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
-				       0, dev_name(dev), indio_dev);
+		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
+					       &xadc->zynq_unmask_work);
 		if (ret)
 			return ret;
 	}
@@ -1457,6 +671,8 @@ static struct platform_driver xadc_driver = {
 };
 module_platform_driver(xadc_driver);
 
-MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_XADC");
+
+MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
-MODULE_DESCRIPTION("Xilinx XADC IIO driver");
+MODULE_DESCRIPTION("Xilinx XADC platform driver");
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 1bbc19ac6333..c70cb6a77d2e 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -205,4 +205,31 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 va
 #define XADC_THRESHOLD_VCCPAUX_MIN	0xe
 #define XADC_THRESHOLD_VCCODDR_MIN	0xf
 
+/*
+ * The XADC hardware supports a samplerate of up to 1MSPS. Unfortunately it does
+ * not have a hardware FIFO. Which means an interrupt is generated for each
+ * conversion sequence. At 1MSPS sample rate the CPU in ZYNQ7000 is completely
+ * overloaded by the interrupts that it soft-lockups. For this reason the driver
+ * limits the maximum samplerate 150kSPS. At this rate the CPU is fairly busy,
+ * but still responsive.
+ */
+#define XADC_MAX_SAMPLERATE_SPS		150000
+
+#define XADC_FLAGS_BUFFERED		BIT(0)
+#define XADC_FLAGS_IRQ_OPTIONAL		BIT(1)
+
+#define XADC_AXI_REG_IPISR		0x60
+#define XADC_AXI_REG_IPIER		0x68
+#define XADC_AXI_INT_EOS		BIT(4)
+
+void xadc_write_reg(struct xadc *xadc, unsigned int reg, u32 val);
+void xadc_read_reg(struct xadc *xadc, unsigned int reg, u32 *val);
+struct iio_dev *xadc_device_setup(struct device *dev, int size, enum xadc_type type);
+int xadc_device_configure(struct iio_dev *indio_dev,
+			  int irq, unsigned int *conf0, unsigned int *bipolar_mask);
+int xadc_read_samplerate(struct xadc *xadc);
+int xadc_write_samplerate(struct xadc *xadc, int val);
+int xadc_setup_buffer_and_triggers(struct iio_dev *indio_dev, int irq);
+int xadc_postdisable(struct iio_dev *indio_dev);
+
 #endif
-- 
2.34.1

