Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45B3FB7EB;
	Thu, 11 Jun 2026 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781216874; cv=fail; b=unnWCDd4jVZEwntrvxYeN+ii72dOGo53LGv6zuRdxziEkDQunfJP/S+n0OXjr0aLDxlu9/MpMCasH34wSG7KDL2i+CnTXSPixSkYF5zES5qY/YlzFci4xc9+Vm+KAqDpsxeC1u4uVLfij9Je9Ov3ZfmKU9PgKVVPto/2qyW3Ks8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781216874; c=relaxed/simple;
	bh=7rEVOVEV3qsIXKhpF8i+e1yKdaCr2iy6IgvM6hd69ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrokTuob6oS45vqaP/QvAmIKJWhjoz9UUuJaJOsGGqJ8iTs+aRm4Ax44dUIoDjrJa+YBN2r+JMUfCj5RfBc3DLKY0+bCkY9IIP6DrFu/LYmUtd22hFXQRgtScf7V1wMyQYxftQ5Ca2+7T8Kad0qn5NW2fHYVWl/Eopp/nqRNYrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YQwvmg6G; arc=fail smtp.client-ip=52.101.52.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YQwvmg6G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7X0QRfhCGj1JXbJqEQDONKuS4ce5zzyVhTxpnmk+qicdGva14N+PIjDetb5sNFUM2QMZ29tmm46cYl36fr3cwT4UTTT5fbcTP4+E2vVR0+27OmrW8vfPTyAsqr9pd8UT461VXWSehjwYMx1sbHxbLr0ufGg6XoIihyDZ5WINQRFI8CSGUJ8OXUdwsDG3iASFSK7DHIx0Fvb4UAhHh3+N5Iszr+4IDYI5a6fQEI3OFIkjX2EtiIEClNfTko62eY+Xh17pn16lUP1mYBUoRlF5ocf0l3POfCWRmTsVE69qDEkXMX5LJiM37Z24r9vPqDj4YMRKL4QkusoJMG2WCSldQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BQv8Eyz3ZSdWLKg4AStNubqgmcp01MQZpqD1o17zoQ=;
 b=s0j5DEs/lFmkI29OFshWdWIYW1VzEvHPZHUlS+pZSxToe9Na9vH8Ety5lpzQxA5VAxlA9ZYkn1vviU1lI3mNCkYtLdRr/h6PdIvjDhJSYfg8BjOYSrI8OUFFDhIbp+K6+wfE1sekmgeFO8RH8WW97fsT/GJg7jCl1NBkyOL4SA7QZu+bzE0yhsa0jYBD9CzxBWNgQJQtNVvTuZZEQVnuEAKr8OGLwsOuhvwKEZ6deH3THB1PNNyTa0mLU4hxS69TussWKSrm3cy78TD5Qg/OF4IrUI1jl02vpowsiZDLVeQ99wZ4tIYBWqZJMgZvAdVnw7axzVAevW363pfr+EMTLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BQv8Eyz3ZSdWLKg4AStNubqgmcp01MQZpqD1o17zoQ=;
 b=YQwvmg6G4ETpWao/3sZcuL5o1QCT3WYV7ajWaD01km6qwDC3dzzrJhaXN4GpBnemTYwHKVfuRmUpXcEo5h+s3I5ewvy/8N7nZSMSMJyLICUpE5GZJLxkw901PM0ZL0yZoZB9YVqTCT77wm2tbVd2UBF9T1/DubZhO0ZqT+hguNQ=
Received: from MN0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:52f::35)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 22:27:46 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::5d) by MN0PR03CA0021.outlook.office365.com
 (2603:10b6:208:52f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 22:27:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 22:27:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 17:27:46 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 17:27:44 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v6 3/5] iio: adc: versal-sysmon: add I2C driver
Date: Thu, 11 Jun 2026 23:27:36 +0100
Message-ID: <20260611222738.2035062-4-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611222738.2035062-1-salih.erim@amd.com>
References: <20260611222738.2035062-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec8af4c-602b-4918-a976-08dec808a9b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|23010399003|6133799003|18002099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	j5UvzF7IzOBw/f3jJ3AD81dni6wn59HVY7FVMWTISPM2I+ooJpQ5HuXAKD4LBPjb1SrcynLEj1jIiJQxWWWAcYu18uuC3hn536Ckgt45b0WKIBKEMLoeIVNOXfCJUq8r3QRTCHz4e7iQOrHvvZFcaE/NyKmzRcYORxhkB+lp2cUjqFaWXWW634+iQZvXieYMQiI/f6tLRU5Q3p+wb2E7r96feVOvqBDsPpnYSq9P8XV/HDpxrGNOjmeDBhnbazHz9Es3N9oEcVOsTMQZentihukVjjpAkC5lSA/oaMvmRUCQMLbuPGx6wKWNPSpWhUNFx8yodkhrUOYkC3MXDtePNP+v/uXH4gnGBQSvK13w0GiUNGFBnm+s7GZ4t5yTZDsM6A1EGNT7T7gGvsECa+w7nMkMzKDL5H0PcQtcLyDmWolqvvinsO+Uk8YMa5ay27rJmt4zWnbaSjtiVj54VHL+OrXhfFAu3h/byoozZ7DxS+XeyW4aemCXBW/zmpI9E4jNyLDOPbijjNo6aQktzAWpYqjFGJbogZcKla8V+D3r7Ho6cqmObe3KK92yUB4JGUpa50t/nQnR0Q+gFzhOe+z4cCLxzAlja1C/JueL7+nzTcpZcJFSkSYGmwDaiYoXg6R+n2Dk9qQPQE1vmkQivhzz4+7IhCHyd9bNMv6fT5br3eZro3/mkTBao3FmsM+6h2cI2csno8g6P0xGc3IbHSR5Rh6T5fooYBhAG3eV8e9Mhlg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c7+2kqB8poj9OJ860qe83Jh3RgLqxlBEcprJFzM6pXzstc+m+3PyA1pgwiTGnwlS58BiqRAgP5kE+BCzxUJz1sXxO6Bi88a7Cvr/tnD9Yous4EhY3gHxZ2Dif14EsEvNjTPOY8D5SXWaiaAAnic+D1RYf0K+/rahr96wefxW7KqakqQqhsMBE5cbwqX+UvaJHbhs11yaAjKNG7w229tsBCEfA3cKNjd/HUlby1VS8K67MAF6MAtTnC+SBLxKXB7L0tSxOnGy43Y/bF74HVuxFSBvBnCkHesfMQOGIXnzHp5xeoz6i53K3hZaqq4kwzWwjKehkV0XKQo/hM7TN2fEGKB6WZzdjM6OlylgxGKghIY9CSU5H2Yqq5ZG/FIwloLSagpl7RSml6ifmE0pWnRwxGdUvhray2EeYUVqSoipnrA6KpqCwPX3izqzbHxsiOXu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 22:27:46.5326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec8af4c-602b-4918-a976-08dec808a9b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009

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
 drivers/iio/adc/versal-sysmon-i2c.c | 128 ++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
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
index 00000000000..1bc969597b4
--- /dev/null
+++ b/drivers/iio/adc/versal-sysmon-i2c.c
@@ -0,0 +1,128 @@
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
+	return sysmon_core_probe(dev, regmap);
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

