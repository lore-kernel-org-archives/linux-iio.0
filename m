Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6774F2EDD40;
	Wed, 17 Jun 2026 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719338; cv=fail; b=Yu1RYjyoeR4TSuQFxsDlfBp95qpMAr/sv1iaiAITii6PFTR7gtMb/Ll9ECS/nqlN2BxpLta7YB8Edb5fmOIso5CBlYjdNMx89WiN23xupTQjwDYIfguQbQ7ayNcrVA8UokpR5ycmXo8+NEzQGF8EsOOFBzn4jQzgzNcEmHW2J4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719338; c=relaxed/simple;
	bh=RMkSqzNB+DPpqKjU3TZb2Zog9oJil9R6vJgU+X1GOcg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tj9d3PsNTgJnEJZy5vqMhJzI1gqh7gfbuHUs0GLSvljV+85UFgkR9hZtJBjt51OfWS91sgRUAgfPO0mkAM7h7adyP8vbOYuc2ya6l3R3WPQY2pCW97BuUaukVGod6XooBLc0v+YzzcjDej9UBeeTpBJibfcpWym0HIcPUgx4a5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zwosZabU; arc=fail smtp.client-ip=52.101.62.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zwosZabU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzIiLcQw9sMVrGjz4I6kI9C35eKqXXu9YDCNCTn5QzEU/Qmoigb8DgDhtlOT8cm60FAGMtHtLt4ReIxatuECRQ2aufTiEU3m6D48ATFXNoThX2Sb/fEKJoAXSTAMrAiKt+QJm/doY9udj+vfg8VARTbajRO0X1GtrgqcYKpLRyjtLrUh+tOn18MkoLBStGTC3xVfR9D7LtXtZZwVUoY5tDtPWYddSNDdKXBJBMMcqBTZhTC1CxyA0ArT14s0XvoHsfpbhPsrgdc4THPKA+cw8dqyJQ2O25ZyaoBAnCDit6Ap0B+bNc3ZL9j3+gYYayd5/NQxUp9nT7mLprUAC32S7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECzlc8slOho7VWlE8pBlIoABYiQsNDYPOTMXtfEaWgQ=;
 b=BV7zoHgv9TQqNcFQ9Am4ZM3Oj8x8Sa8PPLhBRGaY3NT+B54JKCiaRrMypio9ICxM85/08bUnOaebcSJztqy79YBhRGzpBJs+TDpkL/QYGDaOWyJB0g6S8a9e+XRkQsBhkhvHE8O7WhdRyJ2bIOdgAXn9AqH66IQLPvlNetTVNw73ZzMXNE0Iu5EFCFLra1I05+7lOsDymI48PXQ51UD9s35/oWdgI5oyFRx5GxhqHB2XIDbvoxU75Y61wwKRQYqC40vPVIsotYrq8BYmilvs1sWZsw7gTZJZBTDKdaGf/OMksVkk3o6ILDTNV+PVl7ZYUFln6dlPk5wRHrXf/RiqmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECzlc8slOho7VWlE8pBlIoABYiQsNDYPOTMXtfEaWgQ=;
 b=zwosZabU4xmqPGE/MppTpwD2QEdV+f16iK2rta13uVYte8s8eCsm3WhO4qsoacHK8WTVKKbtPzdgnqsWQFWNJCvh+pqAp+IPjiEmS4KcP+t2yK+I0HPZFCFfOpVLpAHalXOfjtBZ/3cDoAVsVjN3G5sMNiJRJfrTm12cjK7Cj70=
Received: from SJ0PR13CA0037.namprd13.prod.outlook.com (2603:10b6:a03:2c2::12)
 by MN6PR12MB8489.namprd12.prod.outlook.com (2603:10b6:208:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 18:02:11 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::6e) by SJ0PR13CA0037.outlook.office365.com
 (2603:10b6:a03:2c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 18:02:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 18:02:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 13:01:59 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 13:01:58 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>, "Andy
 Shevchenko" <andriy.shevchenko@intel.com>
Subject: [PATCH v9 3/5] iio: adc: versal-sysmon: add I2C driver
Date: Wed, 17 Jun 2026 19:01:45 +0100
Message-ID: <20260617180147.3370346-4-salih.erim@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260617180147.3370346-1-salih.erim@amd.com>
References: <20260617180147.3370346-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|MN6PR12MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a418b45-5459-4f20-ac7b-08decc9a8d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|7416014|36860700016|56012099006|11063799006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qZBvL99Ci/pWzK8PP8K2nqBT9EpxHuyOMmVg65SwtWtfYyjVPRCe9pKCCIOrbBG1DRCRTdrbR21RtaigmFyDJJ5s+X13JSoILDiwuJZH98NWyP5R7js9wZh38M/A93+K9yCcIiKowSTxP4zSIS2uWWaqgWwqbBjvur1spfKY7DD1Iqn2/L3Ca7VqxeSL4f3fKoId8lQUWd9kiLZkA+JBUGvvbHpu3SuqHaeGhzBLo89LFIXjEet8xvp2l5eIlWpXh1/Psfz5FY1JvFwb7HerM1v9DlCAskPgkxaAZJOiwlInDgslHneH+Ztt7fVRR56VkAgOX3G2sTFMwDwG5fuop+DbJnq6UsVGb9QTqipEdbipEZI/nJK8XIzj4N4kBk085mE1cRDbdFRYvM1PxJ3fvfxmrnBzHo0+EWu3SP4aEbAwG32ACJyWev8SiL5aoSdc1RDtxWaRUSu+jA59OzLm+3zz1oz4dH0BsOup8zSj2LqXwRvoPUZ13LIo1BfJ4uW2W+laKwS5mbDQZJB/SaoKo88/L9TAZe8eZ4BR5tovvopVPbGyDFJB+Jv15pXECnAik2J0bGMoh9CGKuNQCkQNDYnNNjWu4cR9h+jcwnBOrRGO1ew5CbyCAxnLKdTwTn6ErpmCTmW+Kugu3CwjvTZdDRzxiyKu036NsnXdxHZqZoL/wK9t6INYzUTdrYt2FnNm2W5YinOxNoozz3mcfHmboxXyIE1iu2xQ6ieiMSVPFIY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(7416014)(36860700016)(56012099006)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3cbIvK+hEwcp1VOK2qyV7HqRq1Hchw9Iwdb3ebVO1h9GcocVosr8Por2XqZ4A0TMqz4fG+3QaiR3jxEHfMdDchcezoNXqbq52z21ZSC86jJ4iWW6AnnWsKRE18avzSaVQ14Xv8bLNDysAYJcKVma6xUL655UjWTZKa79KnJA1wATmG6KjyEJ8wn4zevS8QUxI8x/6ZLaFisVMUetUANrMCD/ohWBXcZD+v9OcSi/BGEc3MhGW/55X0oMxawPyRMzxwiZje+9T7oGr5wW2QzpYteOF861acVfsd5qMO0XYOZazWoY+p+6oZF94PmSGc85kAPzoB17gqboiBcVdX1GHko8wgeBuJPRnWTZfQNCb7hTMGXuEUrp1L5NTkaM9JNAXtdfxnBhucDoxFaZLp3zZQtYO4/aowsNUePkyxV7ExEIytTUAf6LCYy+iffL+uxi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 18:02:09.6123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a418b45-5459-4f20-ac7b-08decc9a8d15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489

Add an I2C transport driver for the Versal SysMon block. The SysMon
provides an I2C slave interface that allows an external master to
read voltage and temperature measurements through the same register
map used by the MMIO path.

The I2C command frame is an 8-byte structure containing a 4-byte data
payload, a 2-byte register offset, and a 1-byte instruction field.
Read operations send the frame with a read instruction, then receive
a 4-byte response containing the register value.

Events are not supported on the I2C path because there is no
interrupt line and the I2C regmap backend cannot be called from
atomic context.

Co-developed-by: Conall O'Griofa <conall.ogriofa@amd.com>
Signed-off-by: Conall O'Griofa <conall.ogriofa@amd.com>
Signed-off-by: Salih Erim <salih.erim@amd.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
Changes in v9:
  - Add Reviewed-by tag from Andy Shevchenko
  - Add MODULE_IMPORT_NS("VERSAL_SYSMON") (Andy, from P2 namespace)

Changes in v8:
  - Add volatile register comment for regmap cache (Andy)
  - Update devm_versal_sysmon_core_probe call site (Andy, from P2 rename)

Changes in v7:
  - No code changes

Changes in v6:
  - Add types.h include (IWYU) (Andy)
  - Add local struct device *dev, join devm_regmap_init on
    one line (Andy)

Changes in v5:
  - Add err.h, mod_devicetable.h includes (IWYU) (Andy)

Changes in v4:
  - Replace enum with defines for I2C frame offsets (Jonathan)
  - Use get_unaligned_le32() for read data reassembly (Jonathan)
  - Use put_unaligned_le32/le16() for write data and register offset
    packing (Jonathan)
  - Named initializer in i2c_device_id (Jonathan)
  - Drop bitfield.h, add unaligned.h (FIELD_GET/FIELD_PREP replaced
    by unaligned accessors)

Changes in v3:
  - IWYU: fix includes (Andy)
  - Enum: assign all values explicitly for HW-mapped fields (Andy)
  - Remove sysmon_i2c wrapper struct, pass i2c_client directly
    (Andy)
  - Use sizeof() for I2C buffer lengths instead of defines (Andy)
  - Use = { } instead of = { 0 } for initializers (Andy)
  - Use single compatible xlnx,versal-sysmon (Krzysztof)
  - Adapt to core_probe interface change: irq moved to core,
    remove irq parameter from bus driver (Jonathan)

Changes in v2:
  - New patch (I2C was deferred to Series B in v1)
  - Uses regmap API with custom I2C read/write callbacks
  - Shares core module with MMIO driver via sysmon_core_probe()
  - No event support (I2C has no interrupt line)
  - Separate VERSAL_SYSMON_I2C Kconfig symbol
  - Reverse Christmas Tree variable ordering in read/write functions
 drivers/iio/adc/Kconfig             |  13 +++
 drivers/iio/adc/Makefile            |   1 +
 drivers/iio/adc/versal-sysmon-i2c.c | 134 ++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 drivers/iio/adc/versal-sysmon-i2c.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index c7f19057484..8f9fc9de74a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1963,6 +1963,19 @@ config VERSAL_SYSMON
 	  To compile this driver as a module, choose M here: the module
 	  will be called versal-sysmon.
 
+config VERSAL_SYSMON_I2C
+	tristate "AMD Versal SysMon I2C driver"
+	depends on I2C
+	select VERSAL_SYSMON_CORE
+	help
+	  Say yes here to have support for the AMD/Xilinx Versal System
+	  Monitor (SysMon) via I2C interface. This driver enables voltage
+	  and temperature monitoring when the Versal chip has SysMon
+	  configured with I2C access.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called versal-sysmon-i2c.
+
 config VF610_ADC
 	tristate "Freescale vf610 ADC driver"
 	depends on HAS_IOMEM
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d7696b1b157..5abb611fe46 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -169,6 +169,7 @@ obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
 obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
 obj-$(CONFIG_VERSAL_SYSMON_CORE) += versal-sysmon-core.o
 obj-$(CONFIG_VERSAL_SYSMON) += versal-sysmon.o
+obj-$(CONFIG_VERSAL_SYSMON_I2C) += versal-sysmon-i2c.o
 obj-$(CONFIG_VF610_ADC) += vf610_adc.o
 obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
 obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
diff --git a/drivers/iio/adc/versal-sysmon-i2c.c b/drivers/iio/adc/versal-sysmon-i2c.c
new file mode 100644
index 00000000000..e9a7629159a
--- /dev/null
+++ b/drivers/iio/adc/versal-sysmon-i2c.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Versal SysMon I2C driver
+ *
+ * Copyright (C) 2023 - 2026, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#include "versal-sysmon.h"
+
+#define SYSMON_I2C_INSTR_READ	BIT(2)
+#define SYSMON_I2C_INSTR_WRITE	BIT(3)
+
+/*
+ * I2C command frame layout (8 bytes):
+ *   [0..3] data payload (little-endian u32)
+ *   [4..5] register offset >> 2 (little-endian u16)
+ *   [6]    instruction (read/write)
+ *   [7]    reserved
+ */
+#define SYSMON_I2C_DATA_OFS	0
+#define SYSMON_I2C_REG_OFS	4
+#define SYSMON_I2C_INSTR_OFS	6
+
+static int sysmon_i2c_reg_read(void *context, unsigned int reg,
+			       unsigned int *val)
+{
+	struct i2c_client *client = context;
+	u8 write_buf[8] = { };
+	u8 read_buf[4];
+	int ret;
+
+	put_unaligned_le16(reg >> 2, &write_buf[SYSMON_I2C_REG_OFS]);
+	write_buf[SYSMON_I2C_INSTR_OFS] = SYSMON_I2C_INSTR_READ;
+
+	ret = i2c_master_send(client, write_buf, sizeof(write_buf));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(write_buf))
+		return -EIO;
+
+	ret = i2c_master_recv(client, read_buf, sizeof(read_buf));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(read_buf))
+		return -EIO;
+
+	*val = get_unaligned_le32(read_buf);
+
+	return 0;
+}
+
+static int sysmon_i2c_reg_write(void *context, unsigned int reg,
+				unsigned int val)
+{
+	struct i2c_client *client = context;
+	u8 write_buf[8] = { };
+	int ret;
+
+	put_unaligned_le32(val, &write_buf[SYSMON_I2C_DATA_OFS]);
+	put_unaligned_le16(reg >> 2, &write_buf[SYSMON_I2C_REG_OFS]);
+	write_buf[SYSMON_I2C_INSTR_OFS] = SYSMON_I2C_INSTR_WRITE;
+
+	ret = i2c_master_send(client, write_buf, sizeof(write_buf));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(write_buf))
+		return -EIO;
+
+	return 0;
+}
+
+/*
+ * Almost all registers are volatile (live ADC readings, interrupt
+ * status). The rest are not accessed often enough to benefit from
+ * caching.
+ */
+static const struct regmap_config sysmon_i2c_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = SYSMON_REG_STRIDE,
+	.max_register = SYSMON_MAX_REG,
+	.reg_read = sysmon_i2c_reg_read,
+	.reg_write = sysmon_i2c_reg_write,
+};
+
+static int sysmon_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init(dev, NULL, client, &sysmon_i2c_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	/* I2C has no IRQ connection; events are not supported */
+	return devm_versal_sysmon_core_probe(dev, regmap);
+}
+
+static const struct of_device_id sysmon_i2c_of_match_table[] = {
+	{ .compatible = "xlnx,versal-sysmon" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sysmon_i2c_of_match_table);
+
+static const struct i2c_device_id sysmon_i2c_id_table[] = {
+	{ .name = "versal-sysmon" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sysmon_i2c_id_table);
+
+static struct i2c_driver sysmon_i2c_driver = {
+	.probe = sysmon_i2c_probe,
+	.driver = {
+		.name = "versal-sysmon-i2c",
+		.of_match_table = sysmon_i2c_of_match_table,
+	},
+	.id_table = sysmon_i2c_id_table,
+};
+module_i2c_driver(sysmon_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("AMD Versal SysMon I2C Driver");
+MODULE_IMPORT_NS("VERSAL_SYSMON");
+MODULE_AUTHOR("Conall O'Griofa <conall.ogriofa@amd.com>");
+MODULE_AUTHOR("Salih Erim <salih.erim@amd.com>");
-- 
2.48.1

