Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2183FBB46;
	Wed, 27 May 2026 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882155; cv=fail; b=kOw4W4N7jvuQb0Rfn/tKrhxDghgZyB0pIEQbwDfjNRmMBFaLjPOfBszvp6x4eUOQTLfjxFzNNuRVgcjbkZoGNtfSj4nn6J4Fou8sqYh/aOVZl8wt6CRappCIaO23Pzu+7gKLc9G4XilSBfA8vE/PCXh/4Guak/NtfL4Ok9badTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882155; c=relaxed/simple;
	bh=CH7WlkL8WuasQe3yImiiiRO27S38l3w3sTkkDbhO5v4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bD05eATesafGkoBu9ad0vWube1MNp3ab0SO42J5ZKfgF5yrYdAkelR2WnsP3gG1ZzQyOYjIorTiE5iM++WVCcP80VxxpLnd78RDrBrq/ZItHWWfpuRrs16oBBMQlhQyCgPealwhZpjZRr2IfdFEhFG57mww837COfkjUSl+xxpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hlMW8pQe; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hlMW8pQe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcBNLBmsM4Uf+mflqeXnW4fQJf0/gdpmU/KFctMQox6LFRKmBpov64ktSMQxRFl0UN+1LrueIGaH4sAs8SkEIcdiO/uM3S5S0vxNQRrWMrd1GV/9tKWVdBVdyAY+d17RJ6rBYH2ROQuJInxCzXp73pp3sZdey0pZCQoaNpm54fRBeaUfvEWrhNBtsc5cqpt6RKtNnLAvuu31zFhlQmj0TtA3Ux1H87QYwT+m75DrJj+A+iPS840ITMklB+plAUdJjfREpZDS71DxLwok557SWEyBl8rym6NdiQOGumKgsj2hQxm/yz0KHrfKiaal754sRX6CeRYxrYXGTP1WNX+65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iscoqSi/SYRB2sEdSMFZduzN2eVpeEHhZSIkDAZufWM=;
 b=SK/amMTVnXxwRQEkQ3HnDaSuMw5+7+sGoBBdvYfjJNXC4kQRIyXh72ZA3q0AzUx6cCP4NGsLMZ6OPprMlSvwsbN8uBg0y2yLjAAefZD8ZXUr6EbKiKhXC3eSOvQqSb4XwwiL4/1M5mxohCTu1ZhuAQXfVHO8hmgx8ofITdZ+/4R4HlMLn7Eb5A4b49aEPFEMy97rjr9r6trh4vhoRWiKs7uhnjHIkr+G87tbMXYJvFMCOU0q+QEz8LWgwrmA0yWDYka3EQC5EvL6DGXyEiD7lleKwBee1iGRbfyosixpRBj4zMaGCMN0TtcAQl0oLJrUK9b/uxFCh8cokBXzaDaQcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iscoqSi/SYRB2sEdSMFZduzN2eVpeEHhZSIkDAZufWM=;
 b=hlMW8pQe0uo3FHlCGWpERnFE+HB6mUq2sOAoN8qK7FzZQFRjuWmKQvUM1aCeARPUWXprqIQjOEf6T6gEPKwdOpphAcaGGYaXMI3ritiONmTRAQYN8enkM1wCuFfZFTCBuT4EWHNb2+lq6IPU5U6n4Fa36ORgIwX0AgfTb6VMh5Q=
Received: from BY3PR03CA0017.namprd03.prod.outlook.com (2603:10b6:a03:39a::22)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.20; Wed, 27 May 2026 11:42:26 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::69) by BY3PR03CA0017.outlook.office365.com
 (2603:10b6:a03:39a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 11:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 11:42:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 06:42:24 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 27 May 2026 06:42:22 -0500
From: Salih Erim <salih.erim@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Conall O'Griofa
	<conall.ogriofa@amd.com>, Michal Simek <michal.simek@amd.com>, Guenter Roeck
	<linux@roeck-us.net>, Salih Erim <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v3 3/5] iio: adc: versal-sysmon: add I2C driver
Date: Wed, 27 May 2026 12:42:09 +0100
Message-ID: <20260527114211.174288-4-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527114211.174288-1-salih.erim@amd.com>
References: <20260527114211.174288-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: 875331aa-488b-4c2e-86f3-08debbe50673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|1800799024|376014|82310400026|22082099003|18002099003|56012099006|3023799007|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Xd1y7WywrvjjNONjfEz7FIgc/WMtYd+1hoDIT/wzxxoQOrKsJFF2LIKLo6E9LL4j04LPyfI8CaWyQIXQ6P10dqXv7MmtZ+fVPjXVxSlBQXEuOTWQ85oBw0b8IUkDd/Kiu6dpULZqcGWGN6VxCIqZPq2Kb7JC/DwDpkLmwkIXaSK6y5z0oTDoI9fmB6yWLvk3aWKF4ElTOyt8KsoAJ/EaDeIdlssAaVBwIfWCDI4Kc4LNg6UdEMfNwdxSUs/RBXnICStEfwWTa6eo5aHz0GSMGJ/9lOwvlF4RvgfPq7hcemaoP8FnR4IpsoYxrsgDr/YC4s2FGFeCP8pAuSNnNIWOPmuCxmfb1y5dzxsXv/UJJ4PJGwerdZG5poSPSh1PM9aEeeFP8KIjRGiwg2VWzRagdNcFfVqfCID5+p/3ao54erRdlFDrp9poZw1m64FRD9bTUiqbyHu0Ee4+OeiKk0+EP5IL3FYI4/oCH+MGe7v56bC1PSVLbltSuvHtBotVMP+GgF5dGsiyBjpOYXY4+/uj8gxPI1oSWV6vjskfvI7LMHjVwWkBoxWjvotOLzvmv7jbkHFKPRe52hIoGbk4H5JlvaQ0zy0WAei0J5jafqc14LJSnO1WdC2BJE7r8DelbWaLphzqxlaLJJ1UNSAXZHnYhYkV7qWPinC/+odkLjPPzvzlTazdXwHdg5ZYZUuAJ7Oxjdfao8c0nUwqrn9854mildfKPiKSmyXzUhH+qDnm9GE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(56012099006)(3023799007)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	stbCrE8Viu0Z9MnUtqDdvP8qOcqYq/sY/RNGIQxlT7wp9Ky1WdT5A12AcOqc2Jst/afZq1JirKM+BZnyLOIhyhoUEw8n9xeFVoZmwSEhubWzyJ1VuYZ+SSDQxzXdvry6GC+ZESLE1XRJp9tTvHOqxrApUTAYB0r4iFyMtmsA8dRnfUMXwTqJiwRU56hezaT5ppOcgfoBHpOw1z82Xnv2BUSfF9MaqSJqLu+m4XRgfS5IaWcXGsC+zQYsDaK4cvyTwswAhvUQ6eRJTfR0fKKOUhBULmJHR8q7dbtillAS1boBLaqjPHcrj5hiIvuAUKkllcNq+M3ULTXH6mIbKp5KL/QDaTC46cnZgOGm0JN6XH0Jits1Lfh80NBFqeBzx8mOviNTv1P0R9M4d60iqdNiljCKzbCJ/cFungQ2mCVfSOgfoARgdZm4GO2ylDr8C/fb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 11:42:26.2688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 875331aa-488b-4c2e-86f3-08debbe50673
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745

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
 drivers/iio/adc/versal-sysmon-i2c.c | 153 ++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)
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
index 00000000000..92d149f517e
--- /dev/null
+++ b/drivers/iio/adc/versal-sysmon-i2c.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Versal SysMon I2C driver
+ *
+ * Copyright (C) 2023 - 2026, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "versal-sysmon.h"
+
+#define SYSMON_I2C_INSTR_READ	BIT(2)
+#define SYSMON_I2C_INSTR_WRITE	BIT(3)
+
+#define SYSMON_I2C_DATA0_MASK	GENMASK(7, 0)
+#define SYSMON_I2C_DATA1_MASK	GENMASK(15, 8)
+#define SYSMON_I2C_DATA2_MASK	GENMASK(23, 16)
+#define SYSMON_I2C_DATA3_MASK	GENMASK(31, 24)
+
+#define SYSMON_I2C_OFS_LOW_MASK		GENMASK(9, 2)
+#define SYSMON_I2C_OFS_HIGH_MASK	GENMASK(15, 10)
+
+/* Byte positions within the 8-byte I2C command frame (HW-defined) */
+enum sysmon_i2c_payload_idx {
+	SYSMON_I2C_DATA0_IDX = 0,
+	SYSMON_I2C_DATA1_IDX = 1,
+	SYSMON_I2C_DATA2_IDX = 2,
+	SYSMON_I2C_DATA3_IDX = 3,
+	SYSMON_I2C_OFS_LOW_IDX = 4,
+	SYSMON_I2C_OFS_HIGH_IDX = 5,
+	SYSMON_I2C_INSTR_IDX = 6,
+};
+
+static int sysmon_i2c_reg_read(void *context, unsigned int reg,
+			       unsigned int *val)
+{
+	struct i2c_client *client = context;
+	u8 write_buf[8] = { };
+	u8 read_buf[4];
+	int ret;
+
+	write_buf[SYSMON_I2C_OFS_LOW_IDX] =
+		FIELD_GET(SYSMON_I2C_OFS_LOW_MASK, reg);
+	write_buf[SYSMON_I2C_OFS_HIGH_IDX] =
+		FIELD_GET(SYSMON_I2C_OFS_HIGH_MASK, reg);
+	write_buf[SYSMON_I2C_INSTR_IDX] = SYSMON_I2C_INSTR_READ;
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
+	*val = FIELD_PREP(SYSMON_I2C_DATA0_MASK,
+			  read_buf[SYSMON_I2C_DATA0_IDX]) |
+	       FIELD_PREP(SYSMON_I2C_DATA1_MASK,
+			  read_buf[SYSMON_I2C_DATA1_IDX]) |
+	       FIELD_PREP(SYSMON_I2C_DATA2_MASK,
+			  read_buf[SYSMON_I2C_DATA2_IDX]) |
+	       FIELD_PREP(SYSMON_I2C_DATA3_MASK,
+			  read_buf[SYSMON_I2C_DATA3_IDX]);
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
+	write_buf[SYSMON_I2C_DATA0_IDX] =
+		FIELD_GET(SYSMON_I2C_DATA0_MASK, val);
+	write_buf[SYSMON_I2C_DATA1_IDX] =
+		FIELD_GET(SYSMON_I2C_DATA1_MASK, val);
+	write_buf[SYSMON_I2C_DATA2_IDX] =
+		FIELD_GET(SYSMON_I2C_DATA2_MASK, val);
+	write_buf[SYSMON_I2C_DATA3_IDX] =
+		FIELD_GET(SYSMON_I2C_DATA3_MASK, val);
+	write_buf[SYSMON_I2C_OFS_LOW_IDX] =
+		FIELD_GET(SYSMON_I2C_OFS_LOW_MASK, reg);
+	write_buf[SYSMON_I2C_OFS_HIGH_IDX] =
+		FIELD_GET(SYSMON_I2C_OFS_HIGH_MASK, reg);
+	write_buf[SYSMON_I2C_INSTR_IDX] = SYSMON_I2C_INSTR_WRITE;
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
+	{ "versal-sysmon" },
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

