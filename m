Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012041.outbound.protection.outlook.com [40.107.200.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBF53358C6;
	Sat,  2 May 2026 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777720824; cv=fail; b=US8XK/ENaSLGJfS36U6MjLlVEqMEMNKfW93DAoAEN9w3+z6JZaFXPi9eZZJn9LmNyK1LE4fX0IeoCOpJioH/yFUmyPPnNVPdcgfG1btwi5XdoU/LshJwi2cplcCur5KUCpgq6PRIu35U0S7j4LVYdCogyTngroOCsobwvCEq6Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777720824; c=relaxed/simple;
	bh=DSWWTrF5YV42He+fVAOLYwBlMyqZZxzhFkDCLLj1IQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ky7Ewmzu9iFtSPjo/HXmI+27ir5SyOSB+W8O6V5ppPnBuc3zyhO6vxVJBGNUFGX/dleQ6jLyqJER92N9I5Qdpa5c6rs41qjDA6UIZrZXZKeXx9SWYkC7zltem8dQ/B+6CJifLW5laKgckM2twVDWwCF26xt3sgP6JADFa7d5Kv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2xhM8vMu; arc=fail smtp.client-ip=40.107.200.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2xhM8vMu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVrrozKDpwL9y/6I00V9Q36XL9Fz0Ejv1wr0UaMc4NuDGPPbUHY2TxFs4uDxfVySScuMVckTTp9dOOtrbdxPO8Z0wWzAqSQR02C5vIX/WSDsWTDWs4P85KfpTyKIkfCXy+rJB2CaUrsuh4newxA1IrnN1eznxfrdRxEIKtAk62PVNAVzQcoyEfvp7cNBW+cR5VoRgEQXwTNbE7xt67Lijfll7AISqxK+HSnhA92wBlyuMqGoWpSbKYxmFccAI6luOo5xw3yB3wiQGN9QAMRH5qTpFgEwesn76v1l9lIpjcP6ywB8Gqbu7sTUjMeh0NLImwkIhut1LoN76+dBF1aEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHvVWDrio7QZjvSFLPZhr6VjXtDt5z3q5inEn+hkrqg=;
 b=m0kCD2HhW5XQEjGrYrjcDSa6+tDQdVNXGolviWszHDm5oGhFQFsKr/VjHgJMo53Sl8O/Ybrrqrz/vQpk/gULfTWf4vFQpKeHavZTvwHZ/X5t6pn0StkrGcT1b2xtPj8QNEkfzq6WW8jLD8jQJqe857lHKXQe5R0vJiD3AKz6IKp9rG9brRE3ZHDwO6tel9QD4OpKnLtA34DPEVosbnvJz7DyiHFiPCtwPK+yjOcRzQH60MZ3CyiVD7keFOvCQS/Lg+3WCGWC8dCksTMDN3z+qn5HTbOwOOr/eN8f/FS81Tjzw478lNdfq34dqvtb2zBJiODUyBOHvg/pEooAvjDo0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHvVWDrio7QZjvSFLPZhr6VjXtDt5z3q5inEn+hkrqg=;
 b=2xhM8vMuJ3JnhDtV8/seKBGOZxvcsQoeC6qHFBTjAc6ZSOkPncU1205iyNQzTM08pX1+OF3Ax62A6v8f8Gqmdq7szbrJPG+eIu8RZF2zY9ydp7vSioR91UabzKcGCGQEIVbySzcDGyAUZkbzK0IaXPywVTnj04qDZAakhp9RAG4=
Received: from SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::24)
 by SJ2PR12MB8112.namprd12.prod.outlook.com (2603:10b6:a03:4f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sat, 2 May
 2026 11:20:17 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::1f) by SJ0P220CA0012.outlook.office365.com
 (2603:10b6:a03:41b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.23 via Frontend Transport; Sat,
 2 May 2026 11:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sat, 2 May 2026 11:20:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sat, 2 May
 2026 06:20:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 2 May
 2026 06:20:12 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sat, 2 May 2026 06:20:10 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <git@amd.com>
CC: <nuno.sa@analog.com>, <andy@kernel.org>, <dlechner@baylibre.com>,
	<michal.simek@amd.com>, <conall.ogriofa@amd.com>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v2 3/5] iio: adc: versal-sysmon: add I2C driver
Date: Sat, 2 May 2026 12:19:49 +0100
Message-ID: <20260502111951.538488-4-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260502111951.538488-1-salih.erim@amd.com>
References: <20260502111951.538488-1-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: salih.erim@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SJ2PR12MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b434d7d-c5e2-42bf-4fd0-08dea83cca46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fGvQ0EAxst5uA/EzkwoIrLbxKeuOC/VLcUwTtLBM2FyU0yDRhobuwC9+YWP90TQ5vQfmejZCvnl3tOFFhsRKQt+/KAhYmR789aRur1W3VmDsV+JnFFTK5ATdqwd0TG7EMgiYqnRC8yCqVN5Oinm+hzo8v2Y2m7fwZq8QXPS0VZwRHrjTOu4eEnR+IDey0l2CCTDcO+VqbUIyg/2mkCwTHV8EVxR6on5d2WazugNUPPMio8JDxO2vG8EzFTq3opf/+yU3XzqRl2RKsDMuYm8EsIoA4C/pe5sqZAAEv5fHuZAwdhN+7xp+QV/LS3odW52BTAWH/VOdsaCeZYfBGjdpHxzAn4BYfd5GjvXES21ytQ916IyLtYtPpEB7jQADDV5LuqJAmKc/xsosPjPw1Yk8Om38AUyPlZMmqTDY5t5SeqjuOYDg0bEstVQwOkTh/H/z7xKxpgo9284785GhaQQBlPHJeXMFUNQBkNYS/ocVtwG5pEAVs4XRNq3SmxRlVcMOrfK2kwp2/gDKWLFnupLC15ufpSoM5OcxhJd8IJ8VWYyjBueLl4i6mE4WgOXpIH1f0pihn4hoPbcalv5tHE+5sVFKX5nGPNgrVPwYtg3m5bCm4XtWak5j8OJg4HkWGeZvId6FdgbnVzAZ52raE3O7kJy/Rtt6JZT7/pJspCYsz7k7Kk9v5bgVGPVVK+vwNXgjyvvGhbtY4B/QiqJYIIiD+CGlZAyNUD5/XzZdgy3JaD8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zBg4ID/avY25NeAJi4Oq/vzDtnHN0wZh/QS2ey+ToPbjhwebc/5TSHqTimXLERozC2QQSgzzSbQ3riio3eAJDmrNQj4YxV5As4SPsqYfXA+uk0s+u3AnbFgIdDESuYE+gAkMSXy3mlyGXya3EFVPmqfjH4CSO8xju8i4QQU1ODCNVhz4eYQKeufSjpOPabJmkwcsiaQ+wyZrvFNoYdGk+Gq/Lyn6wg5X2Cn19DnZFTdm+Rm3WcRgGhHMLjJldQWB4iGP8BymGyy1wSmG9YzdefdgnJufyAnsALRrHLoSU1WOXPip51rnYzt+IBbONH/TW6e0Ti+hNcXDkPFa5wklgNYOtZfDt5JK1qRXY5dtGUTLzYv+iDlcz7jP4tyxXH3byFtWQQNDIuBQs1eiRXFV3wWQYMY5Jfd0OZr6yNOmJOQND43PpY/d6tq1Dn8ceOqN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 11:20:17.6950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b434d7d-c5e2-42bf-4fd0-08dea83cca46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8112

Add I2C bus driver for Versal SysMon to enable voltage and temperature
monitoring when the Versal chip has SysMon configured with an I2C
interface.

The I2C protocol uses a custom 8-byte write format:
  - Bytes 0-3: Data (little-endian, 32-bit)
  - Bytes 4-5: Register offset (split into low/high parts)
  - Byte 6: Instruction (read=0x4, write=0x8)
  - Byte 7: Reserved

For reads, the driver sends the 8-byte command then receives 4 bytes
of data. For writes, it sends the 8-byte command with embedded data.

The driver uses the regmap API with custom read/write callbacks to
share the bus-agnostic core driver (versal-sysmon-core).

Event support is not available on I2C since the SysMon interrupt
lines are not routed over the I2C bus.

Co-developed-by: Conall O'Griofa <conall.ogriofa@amd.com>
Signed-off-by: Conall O'Griofa <conall.ogriofa@amd.com>
Signed-off-by: Salih Erim <salih.erim@amd.com>
---
Changes in v2:
  - New patch (I2C was deferred to Series B in v1)
  - Uses regmap API with custom I2C read/write callbacks
  - Shares core module with MMIO driver via sysmon_core_probe()
  - No event support (I2C has no interrupt line)
  - Separate VERSAL_SYSMON_I2C Kconfig symbol
  - Reverse Christmas Tree variable ordering in read/write functions
 drivers/iio/adc/Kconfig             |  13 +++
 drivers/iio/adc/Makefile            |   1 +
 drivers/iio/adc/versal-sysmon-i2c.c | 166 ++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+)
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
index 00000000000..0464b356bbf
--- /dev/null
+++ b/drivers/iio/adc/versal-sysmon-i2c.c
@@ -0,0 +1,166 @@
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
+#define SYSMON_I2C_READ_SIZE	4
+#define SYSMON_I2C_WRITE_SIZE	8
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
+enum sysmon_i2c_payload_idx {
+	SYSMON_I2C_DATA0_IDX = 0,
+	SYSMON_I2C_DATA1_IDX,
+	SYSMON_I2C_DATA2_IDX,
+	SYSMON_I2C_DATA3_IDX,
+	SYSMON_I2C_OFS_LOW_IDX,
+	SYSMON_I2C_OFS_HIGH_IDX,
+	SYSMON_I2C_INSTR_IDX,
+};
+
+struct sysmon_i2c {
+	struct i2c_client *client;
+};
+
+static int sysmon_i2c_reg_read(void *context, unsigned int reg,
+			       unsigned int *val)
+{
+	u8 write_buf[SYSMON_I2C_WRITE_SIZE] = { 0 };
+	u8 read_buf[SYSMON_I2C_READ_SIZE];
+	struct sysmon_i2c *priv = context;
+	int ret;
+
+	write_buf[SYSMON_I2C_OFS_LOW_IDX] =
+		FIELD_GET(SYSMON_I2C_OFS_LOW_MASK, reg);
+	write_buf[SYSMON_I2C_OFS_HIGH_IDX] =
+		FIELD_GET(SYSMON_I2C_OFS_HIGH_MASK, reg);
+	write_buf[SYSMON_I2C_INSTR_IDX] = SYSMON_I2C_INSTR_READ;
+
+	ret = i2c_master_send(priv->client, write_buf, SYSMON_I2C_WRITE_SIZE);
+	if (ret < 0)
+		return ret;
+	if (ret != SYSMON_I2C_WRITE_SIZE)
+		return -EIO;
+
+	ret = i2c_master_recv(priv->client, read_buf, SYSMON_I2C_READ_SIZE);
+	if (ret < 0)
+		return ret;
+	if (ret != SYSMON_I2C_READ_SIZE)
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
+	u8 write_buf[SYSMON_I2C_WRITE_SIZE] = { 0 };
+	struct sysmon_i2c *priv = context;
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
+	ret = i2c_master_send(priv->client, write_buf, SYSMON_I2C_WRITE_SIZE);
+	if (ret < 0)
+		return ret;
+	if (ret != SYSMON_I2C_WRITE_SIZE)
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
+	struct sysmon_i2c *priv;
+	struct regmap *regmap;
+
+	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->client = client;
+
+	regmap = devm_regmap_init(&client->dev, NULL, priv,
+				  &sysmon_i2c_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	/* I2C has no IRQ connection; events are not supported */
+	return sysmon_core_probe(&client->dev, regmap, 0);
+}
+
+static const struct of_device_id sysmon_i2c_of_match_table[] = {
+	{ .compatible = "xlnx,versal-sysmon-i2c" },
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

