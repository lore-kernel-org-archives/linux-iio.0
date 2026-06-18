Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16863C76A6;
	Thu, 18 Jun 2026 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777682; cv=fail; b=b7g5bYGO1ngDh7InupIPq44eKqilOYsTwVBKTfG57XnHgbG85tk/nJjN2qDFPjvPrG9AUPDGJxYm5vGQolNXQMD7Y48eqv2bsLQUGH/ifo+H37C30cntnEm/Vz1fUovwHsQcdZqHDGgH6LYafRXArzlFKGtt6GijWJBwn6wm5r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777682; c=relaxed/simple;
	bh=Bgacs8jM2PYPcwJ5qCQhp4TrTF5kcGtSFhBjDf8L54g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgTXS20Ya98o/v8wyITqAZcUvJSTZRp9HSKq5/aunpjygVowXJ4kZnjtOhDvIfK5j5cTc9H9VPYf8onSkENPeAMx9laHnNyXcXC/UcSw6gh8sTm7kBZZunufKvD+ZhG8OH43d+BNsB1cbkk3fHYDo2lAUpC+sOnrYaFuzhWzxFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QqCMuQVF; arc=fail smtp.client-ip=40.107.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QqCMuQVF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1SwHD90XsBydk8EKvfOulucI0A4tIuMOVP7UyM5fJbQUucsYhTHu1KerQTqTeho+mVlUiNWmbhWXi6H14BMunLzlZA0G8TLxjVzV8/NfkeANQfmNw+T9kJ/Ka40+yPta7wWOv+LhdYKdofdeJDyKogsiJzOzQKSm5SepxDA31Puv59u7n4D3DNQ3Ls380o0mnIqPAiZK0kiJomUpKAvazKWkMNAzI6RQQIk5x41lDBxlbuXDZFM6jFtr6MkEXYg6EqxPZjiFfvzXQb5zpZAB9IeveUO0HVzDMmHnjYSKNzM0Z7jM8v3uAcmo94JF1d5M3eW1gpvYT+2gPCpqArX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0ZYTLhjTjWCQU9/eJ0cdmNmVwzQlTD3xnsvTjL/0GI=;
 b=i7kO8P4fiV9XebZSOqaX3AatTWwn0CWexFJqe1/qSOoB+YDJLAddxsyR83YFYWGG938CASaOOOrebheT/aLuaf6sC72a2t7dqzShGzkQcyHRKjwwfweHvNKxBOdAtGKvEv/mdyHs6HnoV80H3pudF4JiQclqns4BgHvsngFI9xT9NeIbHicdy7HXguFZ/tBOdsGCfWe1OGqd2Hb3XoSt4Op+yG7tbwGQIWyFmaQHAD2odF18kGejN6tJhpTUw3r53k7w5vK509c+MC0bo429wihmIfE3Tw+JDR0CxrVGA4wUrp9VPg8Rl898kdTcmvicCgACGLdzIb/o7Qg7yhIcGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0ZYTLhjTjWCQU9/eJ0cdmNmVwzQlTD3xnsvTjL/0GI=;
 b=QqCMuQVFCjfD7yfcEgnspFubgVOUtiJAB6rF7EwC9AxHM7y26FopK76tBgMDST5Bfpv6Ok2CeSRu5Bnd7auTCYSHJx+OtyfKxR5gicmzHY87cZcsUkdgSjavcOeqzJQI7W1VDUsGxANkqSW87Bf5MmNJuxot2aF86v5fZdR7zmw=
Received: from SJ0PR03CA0228.namprd03.prod.outlook.com (2603:10b6:a03:39f::23)
 by BN5PR12MB9539.namprd12.prod.outlook.com (2603:10b6:408:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 10:14:30 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::2f) by SJ0PR03CA0228.outlook.office365.com
 (2603:10b6:a03:39f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 10:14:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 10:14:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 05:14:29 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 05:14:29 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 18 Jun 2026 05:14:27 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>, "Andy
 Shevchenko" <andriy.shevchenko@intel.com>
Subject: [PATCH v10 3/5] iio: adc: versal-sysmon: add I2C driver
Date: Thu, 18 Jun 2026 11:14:12 +0100
Message-ID: <20260618101414.3462934-4-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618101414.3462934-1-salih.erim@amd.com>
References: <20260618101414.3462934-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|BN5PR12MB9539:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb2af14-0aa4-4c58-f1a1-08decd226275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|7416014|56012099006|18002099003|11063799006|6133799003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	rel6f7fpPI7TgZPPEli+pKrbv4IyKw20NMcVMhlgOzesWAT4qrOHGxpUNsTMUn5mFDBT8OaM3rW3wWeypm/ZckgO31EToFMepcr5Y4hGl5fOwu40L5SbBey2eb2lkL5CxmZSJgqbSDZk9F2yLzu9Muupu8wV0XprX1Lb4rCsgLeXzCjzErsjmMydHz6UIBnARtsDwMdeLkp5iwn9Drve6vlql7+l0ThfEZlCZ1+ChQbdmWKn54mmheDH+0MYVPVENRbGbdRjME6o+Dm0B/rNtO32C7I1Yl6MD+V1mYNK0gJZUjqwCZ4BKMwezwDiaYVJ6ceQ+Z5H5s4TMWQNhr3+gG0C7/jDGOisyI4SE5fU2cMpb82lpIemOWzT3LrV2CVaMvCM6ZWPY57g4shnSJ1hIN41S6hfKTkxSnpIAoptuKfQ4xfjggN+LmOG3OMhprlXex+L5eBN7erF/bjzpcOoO1tsM/bf3O4KtmLyrTLhNXd1DvGKEk83SE/jCYBg1Ko0euoqCTUmsPbca3PYI0kKbbAmsN8REFmONyi/gYDeB4vfX+TCPbH3Yp+ONZ8AbSqlw7rYJjTgs8NbDDOKYZcMWbP7M9EBpU3M04yuRjaoD05hZFCTZ32tJ0hhXEtbt9cYZ1KZj+in1HW6hLRd6jgKbt/sHFZ0HOAUGQ/eE//hG5/MF9ulvnGpx9c9uxv7ye8lYWx04PccSdV67F3xTEDxsAlMigcs7NwdrttaK5lbHmo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(7416014)(56012099006)(18002099003)(11063799006)(6133799003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tvpsHaSSWtpRnKbtu0O+UIvJx+Lq8e2g2rR/B4BRU8AyJVWu7SuX9hpMgM8ZUJP4sH+3RaJdhtvabRMLrYAWhcr535sPzlm2FndWkl9HQNeF5fj1h0V7KubA/FQC3EbpGlaxajBW8KskV0LPZtOKplMPhd3omDvp8E7tUTVQrMl+wsq0NCwOsxPxcrw1mgUKHN3M2+YAvSilsxCAWVU1mpcLxA6GxFp5Wwy9LHjF2kCN0QPH//3ZmsJIERUp61eod7h6VMGhEv4tA8Ed5lvhkZyZsG2blWMQtYwVo5n3S/n5dRzwviZc4JCHwY3OetRPa5R0SuMfSmoV8kZlV40befbewR6i5LZW/p45hjzAKuuhLwlIppIO6pRhzb4EpWPc95x3G4g6kDqL1u6Ni6In+JYWC5cVW/cQs16d26tLKL+ZkcMF7icX7Me6nMB2OCM/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:14:29.6303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb2af14-0aa4-4c58-f1a1-08decd226275
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9539

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
Changes in v10:
  - No code changes

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

