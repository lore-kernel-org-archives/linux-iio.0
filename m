Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011018.outbound.protection.outlook.com [52.101.57.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C0B30216D;
	Wed, 24 Jun 2026 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311968; cv=fail; b=OzSAxE1IqeW69tjEVB6qT1X4VduMqbTpr+kp+18RHnJIzdmnwBgRX8qsswGNmK5rYFjFeQpTHqXwRhjb6UTks+pAvrzn5Yux8nmvJcJwRjRxHaaAKZOsrNbiXN2V6SFfDC1B7QMhtssV8Xzm7LV5cU9lQAopKS6YnHZRrbVo3IY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311968; c=relaxed/simple;
	bh=UKf0A3oRjC6z+K1Tdl5NpnbcHtpEP8PyLRZ/ZQINvvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkvDDKupRIXswFCtvZ5Y5GfrLCjS6JvnAsuoQrNrX99S55iSNvjYdyGmz8/PWN1ei7sRuBjOUv5ckyzxlBiT8m+7CVC52mq1snrtTIpbrxvYE86DGIbqDq6Yla5CvNuxKZ8b804Cgx6IuA0zE2YSWKZrCkRD8LjkIpizZMdIPBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UuZEAPUa; arc=fail smtp.client-ip=52.101.57.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UuZEAPUa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yd13gfipsHH5f6HEWoN0WPo2xg6c/rge04gSZuY1bf/NtYUxaw2vFpTC/JzUxgv4gC0tRIXEHmkkbE6Q6VCFvsume2gTX4rwJaILEb14fpv1+dmcc9XxGzJERUXpWyImP4lCYoq+LIuO3IBkG2Bz5gONYsIgOH+SoQpCiQILWpNaUPDuk1xIoVu00j6f9kuwf9naIUxOpNQWh2zIwLrvH/3/kGZKQNxGcb1NYP4opa8YiFrHRvjtszSw8Xdi3lN+PnezVNC+DJMX+Do/M2hSKLRG0A86gjAcx1I7OSPTld+OJ8hiNsbbXu8UxaF+Cgztg1vUnsdzkK6cat/eK3tH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUJet3m/3+4qJRbJ2sY9B5vqkyWjBXzvGlZ7UF5PU7E=;
 b=RE6eeoJA8uxaJshcrXQFftm4LsW/RtNGIo1SAsBWqAe/K1iZmoON8CRr/os7sSegITagJ2/o/suebsqLOV5acvcxFIYz0T8gz17mU7n5fJhmlKANHYgwjm1Sca8hROLLcD3GxJ4d3jaovjTXtzq93xArhonH9rwzsakhW7Uau4yedilb8q9qrtUUdPUvyHEPhPEVUXioMC7VnXnUNEh4qmpjL4QR9kiGj/KY7r8FNxyH/xswCrF6auRdI3Vtexs7rj+QisG1Uvo8FaAVpFNdKkiLpX8+vYYgbdeuCf+eSZlJ2nM5CkxpQLNyPjb1P2zQX8qJIBoJhH0AwO5JCtWzog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUJet3m/3+4qJRbJ2sY9B5vqkyWjBXzvGlZ7UF5PU7E=;
 b=UuZEAPUa6isanDJprPcvMhONAOxprPMncJx8+lo5qJ5bdMeY6CHS+Uv0f8FzAPHrtYizMNXOJIkxO5KizDg3tGIduOqBETml/9bC1v0+LepVH1y1HRPABNF5h9PoMe/PTKq7Zsffeo7F+X2xAdVoCWwMCW3HiuQwschVjgC15Qc=
Received: from DS7PR03CA0341.namprd03.prod.outlook.com (2603:10b6:8:55::23) by
 DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.13; Wed, 24 Jun 2026 14:39:20 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::1f) by DS7PR03CA0341.outlook.office365.com
 (2603:10b6:8:55::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Wed,
 24 Jun 2026 14:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 14:39:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 09:38:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 09:38:00 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 24 Jun 2026 09:37:58 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <sai.krishna.potthuri@amd.com>, <linux@roeck-us.net>,
	<erimsalih@gmail.com>, <git@amd.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Salih Erim
	<salih.erim@amd.com>, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v12 3/5] iio: adc: versal-sysmon: add I2C driver
Date: Wed, 24 Jun 2026 15:37:20 +0100
Message-ID: <20260624143722.4047649-4-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260624143722.4047649-1-salih.erim@amd.com>
References: <20260624143722.4047649-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ac0dce-5b5f-40e4-ae72-08ded1fe6094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|6133799003|18002099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	J1eN5Bs/O4mCWlV88ar63K7u0lBy1+OdDddRSvpXro3YkFBId6pXBQXb3CgTjuaXyUmPnnQc3YV9X4ygCw3bdXQVwrEECYbQOxgiG8QWuoUQXllqFzTZlXcjfbLN8/5qAimYvKJSdpdzGNDlyZvjqoh3Ys2wpJ6LbQBrcuQTidQ3CqL/M+2wwI+8PjjRealDqpU4Bf6AEFS5VyZpMV3yfRj9Fk8XpR/KizYuEgK9/qw1qJDHS5sOeRnBcY/gFrarORxIL4a9M9z4he55JMpDdS42z8IU6vWY/ugpB/4neTEavUpMGTQG5hfdC//0+fX2QU499wjxeRO+uD6/benYxQ2Imn172b2lT0wWODCfpAtAr4S/qgMx6XsqOGWnoNhKP5p9aOfNOnDoq0Q0eN68+NTHI89qMT+tG1ZtQixMfR+HwEs7eRxsIik7NFuo9MoYx6pMJ9KYT39Fr4NfUEjtOfhYDUwIShONGPhTYP2e6w+r+328vV35nzcxnHh691UNKuFgMOcihl7jUcvYu/M9/3AdMpZxnAmHNkXKXSACh63P8l364shDv0spLaPA4/EErFLSLhXR3BccrFRIyYgZ5OCMU5qijH/4hw182SIIu8tTTXH4Zt2RPmpTNIhgRm0xn1lYM6jmuXCmIFmuEUbEK4qoQBXz9E+/65vsLwayoVItitOMFKbR0wEPCSUMxd4Z2bXFJQ31IHJDdMzxNlS10Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gvpctEuEs0dVcq1dzTXJiO1l+ASTSBajEKAmxFRxvAnXlXdMHxujmp6LaN84x/VoPPoBdDopENXyU1otqInoZRQwR4T5FS/4nexu6gMdNJ29yXPv3mGs69cvj8qCJ5qZg6SKtzzAYmsCIJGxfGST7j8CNjfXlcx3Hjzx9PycVu5PPsVv24rzIOu3h7GnxdS0/gw/RJ3c/koEVZuG2+2U7Drb3dRsYDZHWcA2tu6+aDZcCTyTuQJ0S97A/o+1rpzlQTaX5bECslp42bK9JS5/2yuDGx9+bzN4eLYZMvLnDixHGTzqCg7Scd8k6Go/ugVst4k8T7D5KDOyzTQM792WKf4JPkrYvP+Uoe2PbafOGQss/g97LmVxROTTPKWtegq0XKkhFuOJp/jLXsN8kXi47IvdlEBjJq+rEn8cxS0UHIfi2OKWnc18iopAfvrt+L07
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 14:39:20.5090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ac0dce-5b5f-40e4-ae72-08ded1fe6094
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885

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
Changes in v12:
  - No code changes

Changes in v11:
  - No code changes

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

