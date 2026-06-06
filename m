Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC513033DF;
	Sat,  6 Jun 2026 05:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780723059; cv=fail; b=fOdNHJfdSIGzvupPFQvzs2V+ngErWPy7weoMAJpnn0CIbFJnicdYWVAjBQKYwqIxva2to3ZV6I9FxHmVp6DCUZ1B31b94+f+yIqZTIiViAL4T5OyxOP2twlYY9URDEMNrfE3pkqjc90I5gsB2F3ETlTjToCXzTE6WvNQk9oRmOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780723059; c=relaxed/simple;
	bh=lcYj66c62KLBwLMwmGRn5kEmEihRX6iG5OLio1ZIQX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4OoC37fSeEczdaIGOQFGtv1JOMiD5/fRijeaxb2D4DzjKodtKb5rLswa8MglBgm8KLYNf3TvHHlqA2mRjxx39DV9PNj9N8tyU65CDWQLFoN0HVxBSesXRtubMaEDlwLh2ODdXGg+PWT7rk4NgmRnWtMMlZ6sl1wnqBy9hzNDrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xr76K/h5; arc=fail smtp.client-ip=40.93.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xr76K/h5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knBhaBBT4qTeAPP0exKMPugeG+bRzMME3BS40LlKPWN3Evopya9QXid0sNrsrZDTK0/Jxtz1n1vAVmiXdGvrRN/P4G4hbyUyn5hmu62h824LRW0GM4hrDldryMRgWs4Ib6t3G5QCzo3qpY4NoBVEdtHm65K+qQO45sB1+ZQI1DdDR8ihE0ywaytzWpnBGwGdmRXfZKV3QZBGI9fbPy3d8//o5U8LaBkZDqpPnQ881L2tmbIF/mtFWS4qNbgVieAfoLDRripFkaN8O9Hxr8SSFKO4HW6+aoqGQDBy491CUKNpva5smzbO/rqqFxlp+tNc8d6Nj7buD0AVRTtGNqqjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSfymxOeN/6BivwOjisEFG3AcAY48LidUG7EPibZU8w=;
 b=m/sfWBJag8NWbNdwYwGuhQxBIOPulO3jenbXxJ695c1indrneRQOgMGOd6cZx4U92gVlmSY4/4ppuAQHE/QROKKd1I92KcFfdH01EPlp9j4FGTyjBHLXtqENYPe1Xl01saIElc+lOTTaE3WVu8XrTSZ29CdseYTC486ogsXz5wyI0DyCGllZmSq2Y+0fQZeNJA8BUm7iBMHL4k5z+HQMNu+1jKvBtxaRZFZb2CoEntQScuo4b86zDe6eeFwTNFan6HimeDBK9PntoHk7XYDI3/x+tYO833xRc00CNJjTa3adg36Qs3t7j4+Yn64q0i95xZW7U+BIpdrNigHJ5aLvKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSfymxOeN/6BivwOjisEFG3AcAY48LidUG7EPibZU8w=;
 b=Xr76K/h58kdQ0XHPDNMIv26D9OqfW8PyxdW/2dQ88sgWOEiBdM5cz67SdVkJPpUfYJq+JrMudN++An44G/gsYIzzJX+EAXR1uOIu7TJnMex4nxVSxrMRP6J1+T9B0QDfcp6N1WhR0NS3cyBK0i1bbfrN70dw8/g7AaAqIcY1uks=
Received: from SJ0PR03CA0098.namprd03.prod.outlook.com (2603:10b6:a03:333::13)
 by CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Sat, 6 Jun 2026
 05:17:31 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::2) by SJ0PR03CA0098.outlook.office365.com
 (2603:10b6:a03:333::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Sat, 6
 Jun 2026 05:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sat, 6 Jun 2026 05:17:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 00:17:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 00:17:31 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 6 Jun 2026 00:17:29 -0500
From: Salih Erim <salih.erim@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Conall O'Griofa
	<conall.ogriofa@amd.com>, Michal Simek <michal.simek@amd.com>, Guenter Roeck
	<linux@roeck-us.net>, Salih Erim <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v4 3/5] iio: adc: versal-sysmon: add I2C driver
Date: Sat, 6 Jun 2026 06:17:05 +0100
Message-ID: <20260606051707.535281-4-salih.erim@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20260606051707.535281-1-salih.erim@amd.com>
References: <20260606051707.535281-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 89cd261a-e827-453a-1f46-08dec38ae913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|6133799003|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	qUF+3FlFDxkO4TbyQq+Mmsju0IR90IqDVaY589Vdf00gRPz+rDOkRXNt57ocr/ReFngaVa2sKSXtWnmvHm/LXJ7O3ZNmzoHCyk0lqnwy+veFGKfWai04q7rAzGLtZGKf0j6AoPWGPwMff/xre80cCDULHlvhV28I7JX5flFToOBPoLUDvmfd3UOvJFi7O8uH1S7Cc0wfqDO8Xy5iY982dVp0PkxhjHufiOIGVBvEEjIB8brJFeTR0AJ4erIpp8OrfeR9oQuCCgbDOnqpAR1klrRROJfcd/0YNC2QkoTBWXURQQFCOzKd14vLfcbJciRsfC8kkHu66rpmubdfEkzpSnHo1n7z8pKgfRmex2Vw4GIZh1DEV1CP/OUZPdnpfjU9j55eedaamZW0TC0Rt9/HVtJU9hfn2crHHss1GDhH5pAjcXU4XdFq3CF8VubBXcFvE4UGz0wgqC4/t0U8DDOcxfx7UkNJWWudZzCJuk9ripkSaGvVsQpLu1zEhalqTwXlJUeBPMz9iBLTkYPD5RR/8xC0uebjo9vX9mYaUwmBYkEeHd05cLM459cdMVQO7YEJERSLuvpvVKC9KL6fFQxg88AMBybApzP6rNzPjYL0Tk2bkb9hqyzTG24MpRlYsEwYM9wn1Hd1KDBMhVhg1l8DNryeqcmUPgYMikL2PIb0zbmgIVXw5cELMRK0u8pymeK9fmp3+BAzEXPXiOF/KePL3ZPS54SztnU7VjB/jG/9yyE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	61t16ZvzMbWyVWNRCKcCi2U9u46H4kF0UjAJX2miPnh9qE3ooAB5DHWmeIC2xHEetM8Q8wLKd45xWjJ/n75Pc4YC3wIspSTfbZJUUySlyfVxSvZnBXuKBUQk7uoJwuD8iXxEP7RUmv/VXVegu4uUx36yeu3oxNiMF7nMAUjn2o2xs2a5HR5XA0NPApOWiYLagyHh1MZFJEPQlXy5d6L7qAmpyKdrI4jd7CsYkL9cDUUMtUyyseqYqh5pYrnnHs/HH9itpGoh++ht++whl/P6n2R5pe5Aa7M3xB9umzVDsrCAaX6dYgBNlr+1bnJggJZGbIB3EgioDNKDLTkjmoHghSXsvw4KFlGvnU66tFcVqUbNevqAaA+ZUv5Ok5nCiJT95CCJfWzdhyI/zQZimvKhOuZlZqcQsyKMXa354kOqgtVNrmQbMcmbAMY6P0ISO7S7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2026 05:17:31.5733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cd261a-e827-453a-1f46-08dec38ae913
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

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
---
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
 drivers/iio/adc/versal-sysmon-i2c.c | 125 ++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
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
index 00000000000..27a5ff4a35f
--- /dev/null
+++ b/drivers/iio/adc/versal-sysmon-i2c.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Versal SysMon I2C driver
+ *
+ * Copyright (C) 2023 - 2026, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/bits.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
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
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init(&client->dev, NULL, client,
+				  &sysmon_i2c_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	/* I2C has no IRQ connection; events are not supported */
+	return sysmon_core_probe(&client->dev, regmap);
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
+MODULE_AUTHOR("Conall O'Griofa <conall.ogriofa@amd.com>");
+MODULE_AUTHOR("Salih Erim <salih.erim@amd.com>");
-- 
2.48.1

