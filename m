Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88F8363C7F;
	Mon, 23 Mar 2026 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774251986; cv=fail; b=XHVSsfTRs6eBn5PdCMagxvEuq6yz1ii2HePeAq5kOFh52Lu+7cbu3WtNpkAefNsLPKpojmrvl50k8aHbr3tqxI73y5QncPjhDjqLbxVMN5I7KjRXEYtUwccNEDswSe+itVfdmjseD3AquKAFR/eZqbzlixt8z4fmzbmzRJ7f2Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774251986; c=relaxed/simple;
	bh=o15lnZlTR5B+RzPeunvYRaRk12m7lVOOTsQ58yR5uTM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdoWV1EEFtEVcwPkm2iUfuolgRdnktt5JHG/b/HAAuB2nu8kkJi8aLjjmbtB6rEASNgZyBrnlAV01iH2HEiEPTCFnb1XdpXURacbJlRR3BhSq2HWgR3BsZ2GakoutSw/zdzKgXUACg/H6CNoCT+5N55f940+gQq1GgVe/DdNF1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4X2QpGSb; arc=fail smtp.client-ip=52.101.43.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4X2QpGSb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5H7tDdZSncYbD9s92iPreQwcoKtNqbQXcg13kplDWPcuKQnG0m40TkShSOz3aS7LxVf/VGngdFeRUFhw3BsZZwIyoeQiasXeCu5E/WZZtWbdeA8VYT+3y6wZyCzdb6zYnDY5+hSET845dvU/wmhP9wu1JGFpcWYhWWnGc2C97Q/E9oyo9a2/BAxxUMcc6u460oWXyVDsm3g+SZ0qHv5N7//1N/tmgDGNfPfWjTuoYxo2mt5AIlZHAA8Nm++T18b7YpRMDC9dgWE4xuCPfKQ0bQA28DWWm5dnb5ixm4WqiZ5IL8JpnUiTCrhUMJ2rl0mCGEAdiWnr8OhTIDRJGu6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcjsSbZuqFX1KVGm1LOHervGke2vor87A3Vxf0iZhRQ=;
 b=chKVNUYirWmFM+h6eLnAZleYqypm0GrmmexXwzWuF6THuCJPkxKZDzu4rp0KFVQEawDwtkLnL7pE1T5+jJ9Jrfj7KIDPkJntkOl92JF/n9RldfAiHojCeSPihAzFXYvLOoxZVqzqdidx3wyE7C52s9RTaeVF/ekMgnuPEf/mgCpWAJ8JfXfAfWdiamW4h23DF8X+h+pdFqRdsaUV/09LiSssP/Vwtxg39IAUPda20RTSHobR/+laQl42bzclLUZU8D9DO7sXWIXodmvLsXguLnQa4b3MRyMOqQSfmx3tRmzxQj06koAswIxPM9rMl9VK2PM5W60Ph7gU8CCKcxy0/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcjsSbZuqFX1KVGm1LOHervGke2vor87A3Vxf0iZhRQ=;
 b=4X2QpGSb6R3bZAyZujDAbbXHEPjwKe20rTBZHGqgFyNr9ICO30yzuhkpD4JLCw3cyuORUtaOCqre7WoBkCkFNRdIjlMgiD/2Xu6pIx831V5hcnWSY+XIQHvb+wVUBCxEedswUj4FsAVfRkqJv8VlzAjRvDWcaaJE07XLutcGeZ0=
Received: from BL0PR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:91::13)
 by BN3PR12MB9595.namprd12.prod.outlook.com (2603:10b6:408:2cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 07:46:09 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::d9) by BL0PR05CA0003.outlook.office365.com
 (2603:10b6:208:91::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 07:46:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 07:46:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 02:46:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 02:46:06 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 02:46:03 -0500
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Michal Simek <michal.simek@amd.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<saikrishna12468@gmail.com>, <git@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v2 1/4] iio: adc: xilinx-xadc: Split driver into core and platform files
Date: Mon, 23 Mar 2026 13:15:02 +0530
Message-ID: <20260323074505.3853353-2-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260323074505.3853353-1-sai.krishna.potthuri@amd.com>
References: <20260323074505.3853353-1-sai.krishna.potthuri@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|BN3PR12MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f0c7b7e-8ae3-4c5e-43bc-08de88b03f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uk3Z7mT9taOZqcg4iOPcrddsiMh4s9I6PHawvBQAj3/u60dUc6aw+P1vbZfy6vwfnSou9tznW7PPPQ91WwgMMcXjrJ3OSR1AeVbEKLIWU6Ph3XuwnMvEHgWxuHCkHOx0zIdryKvWTTq++Y8jwZ5gOm5ZhwVSIlKxyHu53iuw9UUc120WPt2TH5O7rUtvFCc+4vnlIkVgCB8qGDaBwEiK+xzfc7KkFKc8anV/0WSoV4pdw9R/s0ieC4T16JN8w6HffuVrbb0xs2fZGPWSKO4//YA1iEGFDe99BKoKo1GQMlqX0xNMeDuf18dcvnv1MU+tIBjhzTXjb0kFAyjy87HJqTxTTCqb3S95WZX5bxQuKt3me+756ORURWjHh19MabD2MyhOdssnH9zx5aIDucD0wVAtDXBT2li0oUnjeScb5QliwYDV9fr2ZUKHHb9NJTLhyW7p331WLT8HVZkxD395SqPLV3tK4HbnX6l0SC1EROABkZRP2My76bhuedAIihCnBfdXg0SvnZ4pu20GgV96BqZdtashCwXGoS9AdkFdZb6PpgTfvWwgLtB9bwjUjPtlIpnnStVWiARg27lKtOU75//SKJ+qRe3bLqV/H8crZgjhev2vR9WMQYX4Qk1gAhuj6MkVdgOWMo1tuPWiSLoazVMAV4Y4Wzku9CH/xocy8QMpfAzaHXSTki90YO7DjXKb1TjKbI5sqgQpc4nJNZtey26CFZkQ5OPPGWhUWo5LDzNTz1VUQvAJpk6USm0X9P5MHMJ85+XuOxjT0phcBH3MQg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jk4TFitBaNtFZiSlv0FYc5EbtdBJY5f/8RKAy0AwBjRb5DVrN1kNw1zQlNZmO3fYLatmtM4Yf+IIVREmbJ6bru42oN73PeA38vU1arAw10cfRg7RYo27WB07t63XaKkos/BrgICNMKtnVsYw4YsufppJJvpjWY5vYWY+TYnY2wPjzbbm7/CxMyvvRg4gm1mqWJg05507IjWwCRCfAO5fropN6F0RpCff6AaifngS137C7yDoABT0gtaB+5wqn4UMjRssUdDgjUFuSkQR5ZAHvTtwCv/J5QcyFCffJa8qrycNk0dAAwn7kcwx4RmBCWIeAJCnW1tP3PT2S7mvOXCpOmQRju0LdIPknJpq9dRTPGW/OJoETiEp1Hx88AJp0EuIkUDrjRcdh40FtxMfEUbR3EmjwSzDTzAu9NDQEAgO8Nb76iZ1dKNmvDkRww6xgqof
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 07:46:09.1198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0c7b7e-8ae3-4c5e-43bc-08de88b03f58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9595

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

Reorganized the code and No behavioral changes.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/iio/adc/Kconfig                |   8 +-
 drivers/iio/adc/Makefile               |   5 +-
 drivers/iio/adc/xilinx-xadc-core.c     | 790 +++----------------------
 drivers/iio/adc/xilinx-xadc-platform.c | 665 +++++++++++++++++++++
 drivers/iio/adc/xilinx-xadc.h          |  30 +
 5 files changed, 779 insertions(+), 719 deletions(-)
 create mode 100644 drivers/iio/adc/xilinx-xadc-platform.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ea3ba1397392..a4a7556f4016 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1744,11 +1744,15 @@ config VIPERBOARD_ADC
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
index 09ae6edb2650..1b05176f0098 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -154,5 +154,6 @@ obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
 obj-$(CONFIG_VF610_ADC) += vf610_adc.o
 obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
 obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
-xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
-obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
+xilinx-xadc-common-y := xilinx-xadc-core.o xilinx-xadc-events.o
+obj-$(CONFIG_XILINX_XADC_CORE) += xilinx-xadc-common.o
+obj-$(CONFIG_XILINX_XADC) += xilinx-xadc-platform.o
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index e257c1b94a5f..268e46e5349c 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -11,588 +11,37 @@
  *  - AXI XADC interface: Xilinx PG019
  */
 
-#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/overflow.h>
-#include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
 #include "xilinx-xadc.h"
 
-static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
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
-#define XADC_ZYNQ_CFG_CFIFOTH_MASK	(0xf << 20)
-#define XADC_ZYNQ_CFG_CFIFOTH_OFFSET	20
-#define XADC_ZYNQ_CFG_DFIFOTH_MASK	(0xf << 16)
-#define XADC_ZYNQ_CFG_DFIFOTH_OFFSET	16
-#define XADC_ZYNQ_CFG_WEDGE		BIT(13)
-#define XADC_ZYNQ_CFG_REDGE		BIT(12)
-#define XADC_ZYNQ_CFG_TCKRATE_MASK	(0x3 << 8)
-#define XADC_ZYNQ_CFG_TCKRATE_DIV2	(0x0 << 8)
-#define XADC_ZYNQ_CFG_TCKRATE_DIV4	(0x1 << 8)
-#define XADC_ZYNQ_CFG_TCKRATE_DIV8	(0x2 << 8)
-#define XADC_ZYNQ_CFG_TCKRATE_DIV16	(0x3 << 8)
-#define XADC_ZYNQ_CFG_IGAP_MASK		0x1f
-#define XADC_ZYNQ_CFG_IGAP(x)		(x)
-
-#define XADC_ZYNQ_INT_CFIFO_LTH		BIT(9)
-#define XADC_ZYNQ_INT_DFIFO_GTH		BIT(8)
-#define XADC_ZYNQ_INT_ALARM_MASK	0xff
-#define XADC_ZYNQ_INT_ALARM_OFFSET	0
-
-#define XADC_ZYNQ_STATUS_CFIFO_LVL_MASK	(0xf << 16)
-#define XADC_ZYNQ_STATUS_CFIFO_LVL_OFFSET	16
-#define XADC_ZYNQ_STATUS_DFIFO_LVL_MASK	(0xf << 12)
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
-#define XADC_AXI_INT_ALARM_MASK		0x3c0f
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
-#define XADC_MAX_SAMPLERATE 150000
-
-static void xadc_write_reg(struct xadc *xadc, unsigned int reg,
-	uint32_t val)
+void xadc_write_reg(struct xadc *xadc, unsigned int reg, uint32_t val)
 {
 	writel(val, xadc->base + reg);
 }
+EXPORT_SYMBOL_GPL(xadc_write_reg);
 
-static void xadc_read_reg(struct xadc *xadc, unsigned int reg,
-	uint32_t *val)
+void xadc_read_reg(struct xadc *xadc, unsigned int reg, uint32_t *val)
 {
 	*val = readl(xadc->base + reg);
 }
+EXPORT_SYMBOL_GPL(xadc_read_reg);
 
-/*
- * The ZYNQ interface uses two asynchronous FIFOs for communication with the
- * XADC. Reads and writes to the XADC register are performed by submitting a
- * request to the command FIFO (CFIFO), once the request has been completed the
- * result can be read from the data FIFO (DFIFO). The method currently used in
- * this driver is to submit the request for a read/write operation, then go to
- * sleep and wait for an interrupt that signals that a response is available in
- * the data FIFO.
- */
-
-static void xadc_zynq_write_fifo(struct xadc *xadc, uint32_t *cmd,
-	unsigned int n)
-{
-	unsigned int i;
-
-	for (i = 0; i < n; i++)
-		xadc_write_reg(xadc, XADC_ZYNQ_REG_CFIFO, cmd[i]);
-}
-
-static void xadc_zynq_drain_fifo(struct xadc *xadc)
-{
-	uint32_t status, tmp;
-
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);
-
-	while (!(status & XADC_ZYNQ_STATUS_DFIFOE)) {
-		xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &tmp);
-		xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);
-	}
-}
-
-static void xadc_zynq_update_intmsk(struct xadc *xadc, unsigned int mask,
-	unsigned int val)
-{
-	xadc->zynq_intmask &= ~mask;
-	xadc->zynq_intmask |= val;
-
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK,
-		xadc->zynq_intmask | xadc->zynq_masked_alarm);
-}
-
-static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t val)
-{
-	uint32_t cmd[1];
-	uint32_t tmp;
-	int ret;
-
-	spin_lock_irq(&xadc->lock);
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
-			XADC_ZYNQ_INT_DFIFO_GTH);
-
-	reinit_completion(&xadc->completion);
-
-	cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_WRITE, reg, val);
-	xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
-	tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
-	tmp |= 0 << XADC_ZYNQ_CFG_DFIFOTH_OFFSET;
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
-
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
-	spin_unlock_irq(&xadc->lock);
-
-	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
-	if (ret == 0)
-		ret = -EIO;
-	else
-		ret = 0;
-
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &tmp);
-
-	return ret;
-}
-
-static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t *val)
-{
-	uint32_t cmd[2];
-	uint32_t resp, tmp;
-	int ret;
-
-	cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_READ, reg, 0);
-	cmd[1] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_NOP, 0, 0);
-
-	spin_lock_irq(&xadc->lock);
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
-			XADC_ZYNQ_INT_DFIFO_GTH);
-	xadc_zynq_drain_fifo(xadc);
-	reinit_completion(&xadc->completion);
-
-	xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
-	tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
-	tmp |= 1 << XADC_ZYNQ_CFG_DFIFOTH_OFFSET;
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
-
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
-	spin_unlock_irq(&xadc->lock);
-	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
-	if (ret == 0)
-		ret = -EIO;
-	if (ret < 0)
-		return ret;
-
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &resp);
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &resp);
-
-	*val = resp & 0xffff;
-
-	return 0;
-}
-
-static unsigned int xadc_zynq_transform_alarm(unsigned int alarm)
-{
-	return ((alarm & 0x80) >> 4) |
-		((alarm & 0x78) << 1) |
-		(alarm & 0x07);
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
-	spin_lock_irq(&xadc->lock);
-
-	/* Clear those bits which are not active anymore */
-	unmask = (xadc->zynq_masked_alarm ^ misc_sts) & xadc->zynq_masked_alarm;
-	xadc->zynq_masked_alarm &= misc_sts;
-
-	/* Also clear those which are masked out anyway */
-	xadc->zynq_masked_alarm &= ~xadc->zynq_intmask;
-
-	/* Clear the interrupts before we unmask them */
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, unmask);
-
-	xadc_zynq_update_intmsk(xadc, 0, 0);
-
-	spin_unlock_irq(&xadc->lock);
-
-	/* if still pending some alarm re-trigger the timer */
-	if (xadc->zynq_masked_alarm) {
-		schedule_delayed_work(&xadc->zynq_unmask_work,
-				msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
-	}
-
-}
-
-static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
-{
-	struct iio_dev *indio_dev = devid;
-	struct xadc *xadc = iio_priv(indio_dev);
-	uint32_t status;
-
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &status);
-
-	status &= ~(xadc->zynq_intmask | xadc->zynq_masked_alarm);
-
-	if (!status)
-		return IRQ_NONE;
-
-	spin_lock(&xadc->lock);
-
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status);
-
-	if (status & XADC_ZYNQ_INT_DFIFO_GTH) {
-		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
-			XADC_ZYNQ_INT_DFIFO_GTH);
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
-		xadc_handle_events(indio_dev,
-				xadc_zynq_transform_alarm(status));
-
-		/* unmask the required interrupts in timer. */
-		schedule_delayed_work(&xadc->zynq_unmask_work,
-				msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
-	}
-	spin_unlock(&xadc->lock);
-
-	return IRQ_HANDLED;
-}
-
-#define XADC_ZYNQ_TCK_RATE_MAX 50000000
-#define XADC_ZYNQ_IGAP_DEFAULT 20
-#define XADC_ZYNQ_PCAP_RATE_MAX 200000000
-
-static int xadc_zynq_setup(struct platform_device *pdev,
-	struct iio_dev *indio_dev, int irq)
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
-	igap = XADC_ZYNQ_IGAP_DEFAULT;
-	tck_rate = XADC_ZYNQ_TCK_RATE_MAX;
-
-	xadc->zynq_intmask = ~0;
-
-	pcap_rate = clk_get_rate(xadc->clk);
-	if (!pcap_rate)
-		return -EINVAL;
-
-	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
-		ret = clk_set_rate(xadc->clk,
-				   (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX);
-		if (ret)
-			return ret;
-	}
-
-	if (tck_rate > pcap_rate / 2) {
-		div = 2;
-	} else {
-		div = pcap_rate / tck_rate;
-		if (pcap_rate / div > XADC_ZYNQ_TCK_RATE_MAX)
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
-			XADC_ZYNQ_CFG_REDGE | XADC_ZYNQ_CFG_WEDGE |
-			tck_div | XADC_ZYNQ_CFG_IGAP(igap));
-
-	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
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
-	uint32_t val;
-
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &val);
-
-	switch (val & XADC_ZYNQ_CFG_TCKRATE_MASK) {
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
-	unsigned long flags;
-	uint32_t status;
-
-	/* Move OT to bit 7 */
-	alarm = ((alarm & 0x08) << 4) | ((alarm & 0xf0) >> 1) | (alarm & 0x07);
-
-	spin_lock_irqsave(&xadc->lock, flags);
-
-	/* Clear previous interrupts if any. */
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &status);
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status & alarm);
-
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_ALARM_MASK,
-		~alarm & XADC_ZYNQ_INT_ALARM_MASK);
-
-	spin_unlock_irqrestore(&xadc->lock, flags);
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
-static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t *val)
-{
-	uint32_t val32;
-
-	xadc_read_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4,
-		&val32);
-	*val = val32 & 0xffff;
-
-	return 0;
-}
-
-static int xadc_axi_write_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t val)
-{
-	xadc_write_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4,
-		val);
-
-	return 0;
-}
-
-static int xadc_axi_setup(struct platform_device *pdev,
-	struct iio_dev *indio_dev, int irq)
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
-	uint32_t status, mask;
-	unsigned int events;
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
-	uint32_t val;
-	unsigned long flags;
-
-	/*
-	 * The order of the bits in the AXI-XADC status register does not match
-	 * the order of the bits in the XADC alarm enable register. We get
-	 * passed the alarm mask in the same order as in the XADC alarm enable
-	 * register.
-	 */
-	alarm = ((alarm & 0x07) << 1) | ((alarm & 0x08) >> 3) |
-			((alarm & 0xf0) << 6);
-
-	spin_lock_irqsave(&xadc->lock, flags);
-	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
-	val &= ~XADC_AXI_INT_ALARM_MASK;
-	val |= alarm;
-	xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
-	spin_unlock_irqrestore(&xadc->lock, flags);
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
-
-static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t mask, uint16_t val)
+static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, u16 mask, u16 val)
 {
 	uint16_t tmp;
 	int ret;
@@ -604,8 +53,7 @@ static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
 	return _xadc_write_adc_reg(xadc, reg, (tmp & ~mask) | val);
 }
 
-static int xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t mask, uint16_t val)
+static int xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, u16 mask, u16 val)
 {
 	int ret;
 
@@ -621,12 +69,11 @@ static unsigned long xadc_get_dclk_rate(struct xadc *xadc)
 	return xadc->ops->get_dclk_rate(xadc);
 }
 
-static int xadc_update_scan_mode(struct iio_dev *indio_dev,
-	const unsigned long *mask)
+static int xadc_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *mask)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
-	size_t n;
 	void *data;
+	size_t n;
 
 	n = bitmap_weight(mask, iio_get_masklength(indio_dev));
 
@@ -698,9 +145,8 @@ static irqreturn_t xadc_trigger_handler(int irq, void *p)
 static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 {
 	struct xadc *xadc = iio_trigger_get_drvdata(trigger);
+	unsigned int convst, val;
 	unsigned long flags;
-	unsigned int convst;
-	unsigned int val;
 	int ret = 0;
 
 	mutex_lock(&xadc->mutex);
@@ -718,7 +164,7 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 				convst = 0;
 		}
 		ret = _xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF0_EC,
-					convst);
+					   convst);
 		if (ret)
 			goto err_out;
 	} else {
@@ -745,8 +191,7 @@ static const struct iio_trigger_ops xadc_trigger_ops = {
 	.set_trigger_state = &xadc_trigger_set_state,
 };
 
-static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev,
-	const char *name)
+static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev, const char *name)
 {
 	struct device *dev = indio_dev->dev.parent;
 	struct iio_trigger *trig;
@@ -813,12 +258,12 @@ static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
 	return XADC_CONF1_SEQ_SIMULTANEOUS;
 }
 
-static int xadc_postdisable(struct iio_dev *indio_dev)
+int xadc_postdisable(struct iio_dev *indio_dev)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 	unsigned long scan_mask;
 	int ret;
-	int i;
+	u32 i;
 
 	scan_mask = 1; /* Run calibration as part of the sequence */
 	for (i = 0; i < indio_dev->num_channels; i++)
@@ -840,6 +285,7 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 
 	return xadc_power_adc_b(xadc, XADC_CONF1_SEQ_CONTINUOUS);
 }
+EXPORT_SYMBOL_GPL(xadc_postdisable);
 
 static int xadc_preenable(struct iio_dev *indio_dev)
 {
@@ -894,7 +340,7 @@ static const struct iio_buffer_setup_ops xadc_buffer_ops = {
 	.postdisable = &xadc_postdisable,
 };
 
-static int xadc_read_samplerate(struct xadc *xadc)
+int xadc_read_samplerate(struct xadc *xadc)
 {
 	unsigned int div;
 	uint16_t val16;
@@ -910,9 +356,10 @@ static int xadc_read_samplerate(struct xadc *xadc)
 
 	return xadc_get_dclk_rate(xadc) / div / 26;
 }
+EXPORT_SYMBOL_GPL(xadc_read_samplerate);
 
-static int xadc_read_raw(struct iio_dev *indio_dev,
-	struct iio_chan_spec const *chan, int *val, int *val2, long info)
+static int xadc_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			 int *val, int *val2, long info)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 	unsigned int bits = chan->scan_type.realbits;
@@ -978,7 +425,37 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static int xadc_write_samplerate(struct xadc *xadc, int val)
+int xadc_setup_buffer_and_triggers(struct device *dev, struct iio_dev *indio_dev,
+				   struct xadc *xadc, int irq)
+{
+	int ret;
+
+	if (!(xadc->ops->flags & XADC_FLAGS_BUFFERED))
+		return 0;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &xadc_trigger_handler,
+					      &xadc_buffer_ops);
+	if (ret)
+		return ret;
+
+	if (irq > 0) {
+		xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
+		if (IS_ERR(xadc->convst_trigger))
+			return PTR_ERR(xadc->convst_trigger);
+
+		xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev,
+							      "samplerate");
+		if (IS_ERR(xadc->samplerate_trigger))
+			return PTR_ERR(xadc->samplerate_trigger);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xadc_setup_buffer_and_triggers);
+
+int xadc_write_samplerate(struct xadc *xadc, int val)
 {
 	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
 	unsigned int div;
@@ -1014,6 +491,7 @@ static int xadc_write_samplerate(struct xadc *xadc, int val)
 	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_DIV_MASK,
 		div << XADC_CONF2_DIV_OFFSET);
 }
+EXPORT_SYMBOL_GPL(xadc_write_samplerate);
 
 static int xadc_write_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int val, int val2, long info)
@@ -1175,21 +653,6 @@ static const struct iio_info xadc_info = {
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
@@ -1298,156 +761,53 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 	return 0;
 }
 
-static const char * const xadc_type_names[] = {
+const char * const xadc_type_names[] = {
 	[XADC_TYPE_S7] = "xadc",
 	[XADC_TYPE_US] = "xilinx-system-monitor",
 };
 
-static void xadc_cancel_delayed_work(void *data)
+struct iio_dev *xadc_device_setup(struct device *dev, int size,
+				  const struct xadc_ops **ops)
 {
-	struct delayed_work *work = data;
-
-	cancel_delayed_work_sync(work);
-}
-
-static int xadc_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	const struct xadc_ops *ops;
 	struct iio_dev *indio_dev;
-	unsigned int bipolar_mask;
-	unsigned int conf0;
-	struct xadc *xadc;
-	int ret;
-	int irq;
-	int i;
-
-	ops = device_get_match_data(dev);
-	if (!ops)
-		return -EINVAL;
 
-	irq = platform_get_irq_optional(pdev, 0);
-	if (irq < 0 &&
-	    (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))
-		return irq;
+	*ops = device_get_match_data(dev);
+	if (!*ops)
+		return ERR_PTR(-ENODEV);
 
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*xadc));
+	indio_dev = devm_iio_device_alloc(dev, size);
 	if (!indio_dev)
-		return -ENOMEM;
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
+		return ERR_PTR(-ENOMEM);
 
-	indio_dev->name = xadc_type_names[xadc->ops->type];
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = xadc_type_names[(*ops)->type];
 	indio_dev->info = &xadc_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = xadc_parse_dt(indio_dev, &conf0, irq);
-	if (ret)
-		return ret;
-
-	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
-		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-						      &iio_pollfunc_store_time,
-						      &xadc_trigger_handler,
-						      &xadc_buffer_ops);
-		if (ret)
-			return ret;
-
-		if (irq > 0) {
-			xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
-			if (IS_ERR(xadc->convst_trigger))
-				return PTR_ERR(xadc->convst_trigger);
-
-			xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev,
-				"samplerate");
-			if (IS_ERR(xadc->samplerate_trigger))
-				return PTR_ERR(xadc->samplerate_trigger);
-		}
-	}
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
-		if (ret > XADC_MAX_SAMPLERATE) {
-			ret = xadc_write_samplerate(xadc, XADC_MAX_SAMPLERATE);
-			if (ret < 0)
-				return ret;
-		}
-	}
-
-	if (irq > 0) {
-		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
-				       0, dev_name(dev), indio_dev);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
-					       &xadc->zynq_unmask_work);
-		if (ret)
-			return ret;
-	}
-
-	ret = xadc->ops->setup(pdev, indio_dev, irq);
-	if (ret)
-		return ret;
+	return indio_dev;
+}
+EXPORT_SYMBOL_GPL(xadc_device_setup);
 
-	for (i = 0; i < 16; i++)
-		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i),
-			&xadc->threshold[i]);
+int xadc_device_configure(struct device *dev, struct iio_dev *indio_dev,
+			  int irq, unsigned int *conf0,
+			  unsigned int *bipolar_mask)
+{
+	int ret;
+	u32 i;
 
-	ret = xadc_write_adc_reg(xadc, XADC_REG_CONF0, conf0);
+	ret = xadc_parse_dt(indio_dev, conf0, irq);
 	if (ret)
 		return ret;
 
-	bipolar_mask = 0;
+	*bipolar_mask = 0;
 	for (i = 0; i < indio_dev->num_channels; i++) {
 		if (indio_dev->channels[i].scan_type.sign == 's')
-			bipolar_mask |= BIT(indio_dev->channels[i].scan_index);
+			*bipolar_mask |= BIT(indio_dev->channels[i].scan_index);
 	}
 
-	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(0), bipolar_mask);
-	if (ret)
-		return ret;
-
-	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(1),
-		bipolar_mask >> 16);
-	if (ret)
-		return ret;
-
-	/* Go to non-buffered mode */
-	xadc_postdisable(indio_dev);
-
-	return devm_iio_device_register(dev, indio_dev);
+	return 0;
 }
-
-static struct platform_driver xadc_driver = {
-	.probe = xadc_probe,
-	.driver = {
-		.name = "xadc",
-		.of_match_table = xadc_of_match_table,
-	},
-};
-module_platform_driver(xadc_driver);
+EXPORT_SYMBOL_GPL(xadc_device_configure);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
-MODULE_DESCRIPTION("Xilinx XADC IIO driver");
+MODULE_DESCRIPTION("Xilinx XADC IIO core driver");
diff --git a/drivers/iio/adc/xilinx-xadc-platform.c b/drivers/iio/adc/xilinx-xadc-platform.c
new file mode 100644
index 000000000000..f1ffbf5cff42
--- /dev/null
+++ b/drivers/iio/adc/xilinx-xadc-platform.c
@@ -0,0 +1,665 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx XADC platform driver
+ *
+ * Copyright 2013-2014 Analog Devices Inc.
+ *  Author: Lars-Peter Clausen <lars@metafoo.de>
+ *
+ * Documentation for the parts can be found at:
+ *  - XADC hardmacro: Xilinx UG480
+ *  - ZYNQ XADC interface: Xilinx UG585
+ *  - AXI XADC interface: Xilinx PG019
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
+#include "xilinx-xadc.h"
+
+static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
+
+/* ZYNQ register definitions */
+#define XADC_ZYNQ_REG_CFG	0x00
+#define XADC_ZYNQ_REG_INTSTS	0x04
+#define XADC_ZYNQ_REG_INTMSK	0x08
+#define XADC_ZYNQ_REG_STATUS	0x0c
+#define XADC_ZYNQ_REG_CFIFO	0x10
+#define XADC_ZYNQ_REG_DFIFO	0x14
+#define XADC_ZYNQ_REG_CTL		0x18
+
+#define XADC_ZYNQ_CFG_ENABLE		BIT(31)
+#define XADC_ZYNQ_CFG_CFIFOTH_MASK	(0xf << 20)
+#define XADC_ZYNQ_CFG_CFIFOTH_OFFSET	20
+#define XADC_ZYNQ_CFG_DFIFOTH_MASK	(0xf << 16)
+#define XADC_ZYNQ_CFG_DFIFOTH_OFFSET	16
+#define XADC_ZYNQ_CFG_WEDGE		BIT(13)
+#define XADC_ZYNQ_CFG_REDGE		BIT(12)
+#define XADC_ZYNQ_CFG_TCKRATE_MASK	(0x3 << 8)
+#define XADC_ZYNQ_CFG_TCKRATE_DIV2	(0x0 << 8)
+#define XADC_ZYNQ_CFG_TCKRATE_DIV4	(0x1 << 8)
+#define XADC_ZYNQ_CFG_TCKRATE_DIV8	(0x2 << 8)
+#define XADC_ZYNQ_CFG_TCKRATE_DIV16	(0x3 << 8)
+#define XADC_ZYNQ_CFG_IGAP_MASK		0x1f
+#define XADC_ZYNQ_CFG_IGAP(x)		(x)
+
+#define XADC_ZYNQ_INT_CFIFO_LTH		BIT(9)
+#define XADC_ZYNQ_INT_DFIFO_GTH		BIT(8)
+#define XADC_ZYNQ_INT_ALARM_MASK	0xff
+#define XADC_ZYNQ_INT_ALARM_OFFSET	0
+
+#define XADC_ZYNQ_STATUS_CFIFO_LVL_MASK	(0xf << 16)
+#define XADC_ZYNQ_STATUS_CFIFO_LVL_OFFSET	16
+#define XADC_ZYNQ_STATUS_DFIFO_LVL_MASK	(0xf << 12)
+#define XADC_ZYNQ_STATUS_DFIFO_LVL_OFFSET	12
+#define XADC_ZYNQ_STATUS_CFIFOF		BIT(11)
+#define XADC_ZYNQ_STATUS_CFIFOE		BIT(10)
+#define XADC_ZYNQ_STATUS_DFIFOF		BIT(9)
+#define XADC_ZYNQ_STATUS_DFIFOE		BIT(8)
+#define XADC_ZYNQ_STATUS_OT		BIT(7)
+#define XADC_ZYNQ_STATUS_ALM(x)		BIT(x)
+
+#define XADC_ZYNQ_CTL_RESET		BIT(4)
+
+#define XADC_ZYNQ_CMD_NOP		0x00
+#define XADC_ZYNQ_CMD_READ		0x01
+#define XADC_ZYNQ_CMD_WRITE		0x02
+
+#define XADC_ZYNQ_CMD(cmd, addr, data) (((cmd) << 26) | ((addr) << 16) | (data))
+
+/* AXI register definitions */
+#define XADC_AXI_REG_RESET		0x00
+#define XADC_AXI_REG_STATUS		0x04
+#define XADC_AXI_REG_ALARM_STATUS	0x08
+#define XADC_AXI_REG_CONVST		0x0c
+#define XADC_AXI_REG_XADC_RESET		0x10
+#define XADC_AXI_REG_GIER		0x5c
+#define XADC_AXI_REG_IPISR		0x60
+#define XADC_AXI_REG_IPIER		0x68
+
+/* 7 Series */
+#define XADC_7S_AXI_ADC_REG_OFFSET	0x200
+/* UltraScale */
+#define XADC_US_AXI_ADC_REG_OFFSET	0x400
+#define XADC_AXI_RESET_MAGIC		0xa
+#define XADC_AXI_GIER_ENABLE		BIT(31)
+#define XADC_AXI_INT_EOS		BIT(4)
+#define XADC_AXI_INT_ALARM_MASK		0x3c0f
+
+/*
+ * The ZYNQ interface uses two asynchronous FIFOs for communication with the
+ * XADC. Reads and writes to the XADC register are performed by submitting a
+ * request to the command FIFO (CFIFO), once the request has been completed the
+ * result can be read from the data FIFO (DFIFO). The method currently used in
+ * this driver is to submit the request for a read/write operation, then go to
+ * sleep and wait for an interrupt that signals that a response is available in
+ * the data FIFO.
+ */
+static void xadc_zynq_write_fifo(struct xadc *xadc, uint32_t *cmd, unsigned int n)
+{
+	unsigned int i;
+
+	for (i = 0; i < n; i++)
+		xadc_write_reg(xadc, XADC_ZYNQ_REG_CFIFO, cmd[i]);
+}
+
+static void xadc_zynq_drain_fifo(struct xadc *xadc)
+{
+	u32 status, tmp;
+
+	xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);
+
+	while (!(status & XADC_ZYNQ_STATUS_DFIFOE)) {
+		xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &tmp);
+		xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);
+	}
+}
+
+static void xadc_zynq_update_intmsk(struct xadc *xadc, unsigned int mask, unsigned int val)
+{
+	xadc->zynq_intmask &= ~mask;
+	xadc->zynq_intmask |= val;
+
+	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask | xadc->zynq_masked_alarm);
+}
+
+static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t val)
+{
+	u32 cmd[1], tmp;
+	int ret;
+
+	spin_lock_irq(&xadc->lock);
+	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
+
+	reinit_completion(&xadc->completion);
+
+	cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_WRITE, reg, val);
+	xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
+	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
+	tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
+	tmp |= 0 << XADC_ZYNQ_CFG_DFIFOTH_OFFSET;
+	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
+
+	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
+	spin_unlock_irq(&xadc->lock);
+
+	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
+	if (ret == 0)
+		ret = -EIO;
+	else
+		ret = 0;
+
+	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &tmp);
+
+	return ret;
+}
+
+static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *val)
+{
+	u32 cmd[2], resp, tmp;
+	int ret;
+
+	cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_READ, reg, 0);
+	cmd[1] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_NOP, 0, 0);
+
+	spin_lock_irq(&xadc->lock);
+	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
+	xadc_zynq_drain_fifo(xadc);
+	reinit_completion(&xadc->completion);
+
+	xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
+	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
+	tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
+	tmp |= 1 << XADC_ZYNQ_CFG_DFIFOTH_OFFSET;
+	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
+
+	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
+	spin_unlock_irq(&xadc->lock);
+	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
+	if (ret == 0)
+		ret = -EIO;
+	if (ret < 0)
+		return ret;
+
+	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &resp);
+	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &resp);
+
+	*val = resp & 0xffff;
+
+	return 0;
+}
+
+static unsigned int xadc_zynq_transform_alarm(unsigned int alarm)
+{
+	return ((alarm & 0x80) >> 4) |
+		((alarm & 0x78) << 1) |
+		(alarm & 0x07);
+}
+
+/*
+ * The ZYNQ threshold interrupts are level sensitive. Since we can't make the
+ * threshold condition go way from within the interrupt handler, this means as
+ * soon as a threshold condition is present we would enter the interrupt handler
+ * again and again. To work around this we mask all active thresholds interrupts
+ * in the interrupt handler and start a timer. In this timer we poll the
+ * interrupt status and only if the interrupt is inactive we unmask it again.
+ */
+static void xadc_zynq_unmask_worker(struct work_struct *work)
+{
+	struct xadc *xadc = container_of(work, struct xadc, zynq_unmask_work.work);
+	unsigned int misc_sts, unmask;
+
+	xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &misc_sts);
+
+	misc_sts &= XADC_ZYNQ_INT_ALARM_MASK;
+
+	spin_lock_irq(&xadc->lock);
+
+	/* Clear those bits which are not active anymore */
+	unmask = (xadc->zynq_masked_alarm ^ misc_sts) & xadc->zynq_masked_alarm;
+	xadc->zynq_masked_alarm &= misc_sts;
+
+	/* Also clear those which are masked out anyway */
+	xadc->zynq_masked_alarm &= ~xadc->zynq_intmask;
+
+	/* Clear the interrupts before we unmask them */
+	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, unmask);
+
+	xadc_zynq_update_intmsk(xadc, 0, 0);
+
+	spin_unlock_irq(&xadc->lock);
+
+	/* if still pending some alarm re-trigger the timer */
+	if (xadc->zynq_masked_alarm)
+		schedule_delayed_work(&xadc->zynq_unmask_work,
+				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
+}
+
+static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
+{
+	struct iio_dev *indio_dev = devid;
+	struct xadc *xadc = iio_priv(indio_dev);
+	u32 status;
+
+	xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &status);
+
+	status &= ~(xadc->zynq_intmask | xadc->zynq_masked_alarm);
+
+	if (!status)
+		return IRQ_NONE;
+
+	spin_lock(&xadc->lock);
+
+	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status);
+
+	if (status & XADC_ZYNQ_INT_DFIFO_GTH) {
+		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
+					XADC_ZYNQ_INT_DFIFO_GTH);
+		complete(&xadc->completion);
+	}
+
+	status &= XADC_ZYNQ_INT_ALARM_MASK;
+	if (status) {
+		xadc->zynq_masked_alarm |= status;
+		/*
+		 * mask the current event interrupt,
+		 * unmask it when the interrupt is no more active.
+		 */
+		xadc_zynq_update_intmsk(xadc, 0, 0);
+
+		xadc_handle_events(indio_dev, xadc_zynq_transform_alarm(status));
+
+		/* unmask the required interrupts in timer. */
+		schedule_delayed_work(&xadc->zynq_unmask_work,
+				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
+	}
+	spin_unlock(&xadc->lock);
+
+	return IRQ_HANDLED;
+}
+
+#define XADC_ZYNQ_TCK_RATE_MAX 50000000
+#define XADC_ZYNQ_IGAP_DEFAULT 20
+#define XADC_ZYNQ_PCAP_RATE_MAX 200000000
+
+static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_dev, int irq)
+{
+	unsigned int tck_div, div, igap, tck_rate;
+	struct xadc *xadc = iio_priv(indio_dev);
+	unsigned long pcap_rate;
+	int ret;
+
+	/* TODO: Figure out how to make igap and tck_rate configurable */
+	igap = XADC_ZYNQ_IGAP_DEFAULT;
+	tck_rate = XADC_ZYNQ_TCK_RATE_MAX;
+
+	xadc->zynq_intmask = ~0;
+
+	pcap_rate = clk_get_rate(xadc->clk);
+	if (!pcap_rate)
+		return -EINVAL;
+
+	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
+		ret = clk_set_rate(xadc->clk, (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX);
+		if (ret)
+			return ret;
+	}
+
+	if (tck_rate > pcap_rate / 2) {
+		div = 2;
+	} else {
+		div = pcap_rate / tck_rate;
+		if (pcap_rate / div > XADC_ZYNQ_TCK_RATE_MAX)
+			div++;
+	}
+
+	if (div <= 3)
+		tck_div = XADC_ZYNQ_CFG_TCKRATE_DIV2;
+	else if (div <= 7)
+		tck_div = XADC_ZYNQ_CFG_TCKRATE_DIV4;
+	else if (div <= 15)
+		tck_div = XADC_ZYNQ_CFG_TCKRATE_DIV8;
+	else
+		tck_div = XADC_ZYNQ_CFG_TCKRATE_DIV16;
+
+	xadc_write_reg(xadc, XADC_ZYNQ_REG_CTL, XADC_ZYNQ_CTL_RESET);
+	xadc_write_reg(xadc, XADC_ZYNQ_REG_CTL, 0);
+	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, ~0);
+	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask);
+	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, XADC_ZYNQ_CFG_ENABLE |
+		       XADC_ZYNQ_CFG_REDGE | XADC_ZYNQ_CFG_WEDGE |
+		       tck_div | XADC_ZYNQ_CFG_IGAP(igap));
+
+	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
+		ret = clk_set_rate(xadc->clk, pcap_rate);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static unsigned long xadc_zynq_get_dclk_rate(struct xadc *xadc)
+{
+	unsigned int div;
+	u32 val;
+
+	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &val);
+
+	switch (val & XADC_ZYNQ_CFG_TCKRATE_MASK) {
+	case XADC_ZYNQ_CFG_TCKRATE_DIV4:
+		div = 4;
+		break;
+	case XADC_ZYNQ_CFG_TCKRATE_DIV8:
+		div = 8;
+		break;
+	case XADC_ZYNQ_CFG_TCKRATE_DIV16:
+		div = 16;
+		break;
+	default:
+		div = 2;
+		break;
+	}
+
+	return clk_get_rate(xadc->clk) / div;
+}
+
+static void xadc_zynq_update_alarm(struct xadc *xadc, unsigned int alarm)
+{
+	unsigned long flags;
+	u32 status;
+
+	/* Move OT to bit 7 */
+	alarm = ((alarm & 0x08) << 4) | ((alarm & 0xf0) >> 1) | (alarm & 0x07);
+
+	spin_lock_irqsave(&xadc->lock, flags);
+
+	/* Clear previous interrupts if any. */
+	xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &status);
+	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status & alarm);
+
+	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_ALARM_MASK,
+				~alarm & XADC_ZYNQ_INT_ALARM_MASK);
+
+	spin_unlock_irqrestore(&xadc->lock, flags);
+}
+
+static const struct xadc_ops xadc_zynq_ops = {
+	.read = xadc_zynq_read_adc_reg,
+	.write = xadc_zynq_write_adc_reg,
+	.setup = xadc_zynq_setup,
+	.get_dclk_rate = xadc_zynq_get_dclk_rate,
+	.interrupt_handler = xadc_zynq_interrupt_handler,
+	.update_alarm = xadc_zynq_update_alarm,
+	.type = XADC_TYPE_S7,
+	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
+	.temp_scale = 503975,
+	.temp_offset = 273150,
+};
+
+static const unsigned int xadc_axi_reg_offsets[] = {
+	[XADC_TYPE_S7] = XADC_7S_AXI_ADC_REG_OFFSET,
+	[XADC_TYPE_US] = XADC_US_AXI_ADC_REG_OFFSET,
+};
+
+static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *val)
+{
+	u32 val32;
+
+	xadc_read_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4, &val32);
+	*val = val32 & 0xffff;
+
+	return 0;
+}
+
+static int xadc_axi_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
+{
+	xadc_write_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4, val);
+
+	return 0;
+}
+
+static int xadc_axi_setup(struct platform_device *pdev, struct iio_dev *indio_dev, int irq)
+{
+	struct xadc *xadc = iio_priv(indio_dev);
+
+	xadc_write_reg(xadc, XADC_AXI_REG_RESET, XADC_AXI_RESET_MAGIC);
+	xadc_write_reg(xadc, XADC_AXI_REG_GIER, XADC_AXI_GIER_ENABLE);
+
+	return 0;
+}
+
+static irqreturn_t xadc_axi_interrupt_handler(int irq, void *devid)
+{
+	struct iio_dev *indio_dev = devid;
+	struct xadc *xadc = iio_priv(indio_dev);
+	u32 status, mask;
+	unsigned int events;
+
+	xadc_read_reg(xadc, XADC_AXI_REG_IPISR, &status);
+	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &mask);
+	status &= mask;
+
+	if (!status)
+		return IRQ_NONE;
+
+	if ((status & XADC_AXI_INT_EOS) && xadc->trigger)
+		iio_trigger_poll(xadc->trigger);
+
+	if (status & XADC_AXI_INT_ALARM_MASK) {
+		/*
+		 * The order of the bits in the AXI-XADC status register does
+		 * not match the order of the bits in the XADC alarm enable
+		 * register. xadc_handle_events() expects the events to be in
+		 * the same order as the XADC alarm enable register.
+		 */
+		events = (status & 0x000e) >> 1;
+		events |= (status & 0x0001) << 3;
+		events |= (status & 0x3c00) >> 6;
+		xadc_handle_events(indio_dev, events);
+	}
+
+	xadc_write_reg(xadc, XADC_AXI_REG_IPISR, status);
+
+	return IRQ_HANDLED;
+}
+
+static void xadc_axi_update_alarm(struct xadc *xadc, unsigned int alarm)
+{
+	u32 val;
+	unsigned long flags;
+
+	/*
+	 * The order of the bits in the AXI-XADC status register does not match
+	 * the order of the bits in the XADC alarm enable register. We get
+	 * passed the alarm mask in the same order as in the XADC alarm enable
+	 * register.
+	 */
+	alarm = ((alarm & 0x07) << 1) | ((alarm & 0x08) >> 3) |
+			((alarm & 0xf0) << 6);
+
+	spin_lock_irqsave(&xadc->lock, flags);
+	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
+	val &= ~XADC_AXI_INT_ALARM_MASK;
+	val |= alarm;
+	xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
+	spin_unlock_irqrestore(&xadc->lock, flags);
+}
+
+static unsigned long xadc_axi_get_dclk(struct xadc *xadc)
+{
+	return clk_get_rate(xadc->clk);
+}
+
+static const struct xadc_ops xadc_7s_axi_ops = {
+	.read = xadc_axi_read_adc_reg,
+	.write = xadc_axi_write_adc_reg,
+	.setup = xadc_axi_setup,
+	.get_dclk_rate = xadc_axi_get_dclk,
+	.update_alarm = xadc_axi_update_alarm,
+	.interrupt_handler = xadc_axi_interrupt_handler,
+	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
+	.type = XADC_TYPE_S7,
+	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
+	.temp_scale = 503975,
+	.temp_offset = 273150,
+};
+
+static const struct xadc_ops xadc_us_axi_ops = {
+	.read = xadc_axi_read_adc_reg,
+	.write = xadc_axi_write_adc_reg,
+	.setup = xadc_axi_setup,
+	.get_dclk_rate = xadc_axi_get_dclk,
+	.update_alarm = xadc_axi_update_alarm,
+	.interrupt_handler = xadc_axi_interrupt_handler,
+	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
+	.type = XADC_TYPE_US,
+	/**
+	 * Values below are for UltraScale+ (SYSMONE4) using internal reference.
+	 * See https://docs.xilinx.com/v/u/en-US/ug580-ultrascale-sysmon
+	 */
+	.temp_scale = 509314,
+	.temp_offset = 280231,
+};
+
+static const struct of_device_id xadc_of_match_table[] = {
+	{
+		.compatible = "xlnx,zynq-xadc-1.00.a",
+		.data = &xadc_zynq_ops
+	}, {
+		.compatible = "xlnx,axi-xadc-1.00.a",
+		.data = &xadc_7s_axi_ops
+	}, {
+		.compatible = "xlnx,system-management-wiz-1.3",
+		.data = &xadc_us_axi_ops
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, xadc_of_match_table);
+
+static void xadc_cancel_delayed_work(void *data)
+{
+	struct delayed_work *work = data;
+
+	cancel_delayed_work_sync(work);
+}
+
+static int xadc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct xadc_ops *ops;
+	struct iio_dev *indio_dev;
+	unsigned int bipolar_mask;
+	unsigned int conf0;
+	struct xadc *xadc;
+	int ret;
+	int irq;
+	u32 i;
+
+	indio_dev = xadc_device_setup(dev, sizeof(*xadc), &ops);
+	if (IS_ERR(indio_dev))
+		return PTR_ERR(indio_dev);
+
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq < 0 &&
+	    (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))
+		return irq;
+
+	xadc = iio_priv(indio_dev);
+	xadc->ops = ops;
+	init_completion(&xadc->completion);
+	mutex_init(&xadc->mutex);
+	spin_lock_init(&xadc->lock);
+	INIT_DELAYED_WORK(&xadc->zynq_unmask_work, xadc_zynq_unmask_worker);
+
+	xadc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(xadc->base))
+		return PTR_ERR(xadc->base);
+
+	ret = xadc_device_configure(dev, indio_dev, irq, &conf0, &bipolar_mask);
+	if (ret)
+		return ret;
+
+	ret = xadc_setup_buffer_and_triggers(dev, indio_dev, xadc, irq);
+	if (ret)
+		return ret;
+
+	xadc->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(xadc->clk))
+		return PTR_ERR(xadc->clk);
+
+	/*
+	 * Make sure not to exceed the maximum samplerate since otherwise the
+	 * resulting interrupt storm will soft-lock the system.
+	 */
+	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
+		ret = xadc_read_samplerate(xadc);
+		if (ret < 0)
+			return ret;
+
+		if (ret > XADC_MAX_SAMPLERATE) {
+			ret = xadc_write_samplerate(xadc, XADC_MAX_SAMPLERATE);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	if (irq > 0) {
+		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
+				       0, dev_name(dev), indio_dev);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
+					       &xadc->zynq_unmask_work);
+		if (ret)
+			return ret;
+	}
+
+	ret = xadc->ops->setup(pdev, indio_dev, irq);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < 16; i++)
+		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i), &xadc->threshold[i]);
+
+	ret = xadc_write_adc_reg(xadc, XADC_REG_CONF0, conf0);
+	if (ret)
+		return ret;
+
+	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(0), bipolar_mask);
+	if (ret)
+		return ret;
+
+	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(1), bipolar_mask >> 16);
+	if (ret)
+		return ret;
+
+	/* Go to non-buffered mode */
+	xadc_postdisable(indio_dev);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static struct platform_driver xadc_driver = {
+	.probe = xadc_probe,
+	.driver = {
+		.name = "xadc",
+		.of_match_table = xadc_of_match_table,
+	},
+};
+module_platform_driver(xadc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_DESCRIPTION("Xilinx XADC platform driver");
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index b4d9d4683117..a2d208fbd13b 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -211,4 +211,34 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg,
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
+#define XADC_MAX_SAMPLERATE 150000
+
+#define XADC_FLAGS_BUFFERED BIT(0)
+#define XADC_FLAGS_IRQ_OPTIONAL BIT(1)
+
+/* AXI register definitions needed by core */
+#define XADC_AXI_REG_IPISR		0x60
+#define XADC_AXI_REG_IPIER		0x68
+#define XADC_AXI_INT_EOS		BIT(4)
+
+void xadc_write_reg(struct xadc *xadc, unsigned int reg, uint32_t val);
+void xadc_read_reg(struct xadc *xadc, unsigned int reg, uint32_t *val);
+struct iio_dev *xadc_device_setup(struct device *dev, int size,
+				  const struct xadc_ops **ops);
+int xadc_device_configure(struct device *dev, struct iio_dev *indio_dev,
+			  int irq, unsigned int *conf0, unsigned int *bipolar_mask);
+int xadc_read_samplerate(struct xadc *xadc);
+int xadc_write_samplerate(struct xadc *xadc, int val);
+int xadc_setup_buffer_and_triggers(struct device *dev, struct iio_dev *indio_dev,
+				   struct xadc *xadc, int irq);
+int xadc_postdisable(struct iio_dev *indio_dev);
+
 #endif
-- 
2.25.1

