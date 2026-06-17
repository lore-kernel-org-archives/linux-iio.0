Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CCF3644B3;
	Wed, 17 Jun 2026 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719327; cv=fail; b=KI+sYMHXcVhHY3Kpjivgdy9pY8HAzfQsfKUix9GIU1jZjwR9rzxQj1hnvthCmDWiiTeBEMh9wcuNkWGHCUXjXf6R7K8rAl2Ng0EOVQN3Xk/H5cEO2mhXzh4tYe5PrXa8IdlOtpBmkFEr1JS7ag0Vu98HfqndUl++NOdsVQJF9Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719327; c=relaxed/simple;
	bh=RVLG2UkiAQuv1QfH5aqVznsv3uH2ezWPGiUlRnjhu7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SVmuyV/q1iGU58VfrUsXWeQBbQpDZkhNd3s+A7MJWRvn05cmRDZ1Ud6ujTyp2viZFHGxpF0b4M7if3P79gbENrYPDQRG4CdBD3ibaiZguNWm9OtN7grW+WSl7uLcpkz8yP3Ilmya8R2ydIi0Ybal7fBa+CDqIRUGdC7OTiksDOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HOkrNFE/; arc=fail smtp.client-ip=52.101.52.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HOkrNFE/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfIGy9HoHvWOToFsWYEInEfX/J3ilpHtRD6tsuYcY4XntbMk8U4U+ZiDiXsxCIgP6Lch6JkJzqdAK1dz5fFRxh8SldgU+P2N45TFSjk43Vbsm9ZxphcxCyrIMcUWGqtnPDx69f1UPVtRx7YcnE7dxh1m7yzBuizIpUlUWCOl/Zy4dXFU762n8Dlg3O/ME7edBTcQUv7Bhbt7TdKBbSnGVfd/wtbK/wABuRRFNno487Z+KnVxVXsnchNo9ZrUVefopMNTSJ9EwNMz8aQRW+82DdrDRQoEyQgf9y0QuX9+TGJs6iLMtuZWb2rYq4YVJixKsJYs1vUjLj9QmAmt5e1k3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIFoEyCgz9gukg8kbmCkWK5KadQ7rAz8KsXYoyo7dqs=;
 b=bSQ3uDf+qu8dPdbPzGk3TMwYXmRQlAcZ+GMR+sZyqdUk54vSJs2Wmqt3fXWgoPYCAVnJqh6Q7SSNiUhHRHmKi0ux84fM/j5VX2vhZuSIQZK/uJuqY5iBrVdIwLntHlTZfDQhAUcyt+Ez3az0TAtdplLQWCA5GlATVGyosxKG5rf07B6mCLUqp2kZd6Vcljs9yEA95KrCNuPvteYIZX+hvMgSsYV52jWsXpGZWIkPl29qEmXll/FGpb9QCNPqnLeWbGcrxYJ9bIbcbu9F6gCRr8bN6iyi9hU32jKxkGNKA+QQCKIrx0NnfJRNGB5+uoC2qImyFQBsAH9e++7Z4BpBcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIFoEyCgz9gukg8kbmCkWK5KadQ7rAz8KsXYoyo7dqs=;
 b=HOkrNFE/pfSh0SnsBhuvENOvlnvJ73FOEMZP3D2MlERMy1jzvMVSyl4XO+WEChZ2AfdUcjh5SgXz6UJw5mCIxE8wUJvtigBQ0Q6XrQxBOf8195KEnhHVpAhmRksFSbol4q6/p1eC9UF5t87gQ5Mh13JSgmAZJXGupXZUY8gb0AE=
Received: from PH8PR20CA0016.namprd20.prod.outlook.com (2603:10b6:510:23c::20)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 18:01:59 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::58) by PH8PR20CA0016.outlook.office365.com
 (2603:10b6:510:23c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 18:01:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 18:01:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 13:01:57 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 13:01:56 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>, "Andy
 Shevchenko" <andriy.shevchenko@intel.com>
Subject: [PATCH v9 2/5] iio: adc: add Versal SysMon driver
Date: Wed, 17 Jun 2026 19:01:44 +0100
Message-ID: <20260617180147.3370346-3-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: 85cae5b9-4e73-4335-dc55-08decc9a8660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|82310400026|1800799024|11063799006|56012099006|5023799004|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	BAmgFHvPfhHabfJL0CY5HNV08uKmEs51naR+pE2/fhAdS4F0CSioRT/LwvwED+w0fJ54CwTyovih2GVKCF8y/Pvg2PYV0/9gq+IrPlTQyQYseKyFV+YzHZWozMLkVslrIpj+YEG8wnpuK8F0U60PI8fGCE7AEajp8pPf1nAucYYwidOihSU8CrQAjF40g13im/wVhWc98MqG9wcx/gcRf7/wPJwxYZjAeWm7UoWYNV1MdMVaasAj1c1WSdSM5972v32MYBnMesuyBgsGnTDJqCbi6FBZ1GrQzlqMsPrRnbF6hTSxYO/CKerxhuCHxqBBnJUmWwE3wUcH3Z8awWyGWYZP3xyM9mOia0W4r6VyfLKzMi90FepV0LIem7ldafJ+tew+AD6+nnXy0xsd6izwIzUC0YMDm819ESgjg8D8Nc/e2ah+i3j4Y4XGEMPKDc+jf6bvV5g9bvEhQBkkMeI1rByAR5EvEGGodoDrO5aiXacSoXgikDQoMnUHPIxshU2BoIvrzheziA0yhgWvhNajT2TwvknMl0SmI5YtfMR8vdFgOrZfHNn+91GL5f6Ouaez604Ht2f+/7a6uX5VNssI+3SBtoaSSYMmHur3KG0rP1Fuj/O7YLYnrncbgDn7YJVaxaeyQWZZuG0OofBMDTtEtp1qakhwOixqEmAsxBTLgxzxb0MLqjSNLz/xB6yz6Uu8pyswghzk6E3ux8lY/wfcrIzSveWbKcDjZoX4sEPUob8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(5023799004)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UWJrhoWn5X/wIJwzmBo57fjiiT9JwLQnMIdbb2LFRBlKztdDIMXKu3Mu39o7X5/0udC3kNY2DL6CjgzJkFVST5IWTfqAFwiQMn8dUlXha9T11bqoSr42u6zurs5v/Zgq5Hs4ctctnb8FI20EHlo3hRB/RIoI+S92obeScWHa/RJiUVxUPfu09O+QAsvWFPWSaKYFEuFoE1YHLNBIpKMNXrZTfJkiTH7AepQD5StUiALEwiCd/w/afHJm1fnholacTSXOQ88UvSu1Ugq32Ve8k5qyIBQGyG8aPksRVEmTWFWv0tkJFdej5TjxxS7B9j4fkeDm51n11l5F3cdMKat5eUTfqskzXdwsIG496g9LJ4G6Mf1KlMn7jBopGtxcjGp6IMAXPJuAEpYpteYS8s5rJi6/Ixf4njEfkcjWJxgkfF18KFgEC2VwTyustwu5HTQl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 18:01:58.3823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cae5b9-4e73-4335-dc55-08decc9a8660
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399

Add the core driver and MMIO platform driver for the AMD/Xilinx Versal
System Monitor (SysMon) block.

The SysMon block resides in the platform management controller (PMC) and
provides on-chip voltage and temperature monitoring through a 10-bit,
200 kSPS ADC. It can monitor up to 160 voltage channels and 64
temperature satellites distributed across the SoC, with a consistent
sample rate of 8 kSPS per channel regardless of how many channels are
enabled.

The hardware also provides four aggregate temperature registers that
are always present regardless of the device tree configuration: the
current max and min across all active satellites, and the peak and
trough values recorded since the last hardware reset.

The driver is split into two compilation units:
  - versal-sysmon-core: Channel parsing, IIO registration, read_raw
  - versal-sysmon: MMIO platform driver with custom regmap accessors

Voltage results are stored in a 19-bit modified floating-point format
and converted to millivolts. Temperature results are stored in Q8.7
signed fixed-point Celsius format and converted to millicelsius.

The MMIO regmap backend uses a custom reg_write accessor that
automatically unlocks the NPI (NoC programming interface) lock
register before each write, as required by the hardware. The regmap
is configured with fast_io since the underlying MMIO accessors are
safe to call from atomic context.

Co-developed-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Salih Erim <salih.erim@amd.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
Changes in v9:
  - Add Reviewed-by tag from Andy Shevchenko
  - Use EXPORT_SYMBOL_NS_GPL with "VERSAL_SYSMON" namespace,
    add MODULE_IMPORT_NS to MMIO driver (Andy)
  - Join sysmon_mmio_reg_read and sysmon_mmio_reg_write
    signatures to single lines (Andy)
  - Introduce num_static variable in sysmon_parse_fw to reduce
    churn in P4 (Andy)

Changes in v8:
  - Use MILLIDEGREE_PER_DEGREE instead of MILLI for temperature
    scale (Andy)
  - Add overflow.h include for size_add() (Andy)
  - Rename sysmon_core_probe to devm_versal_sysmon_core_probe (Andy)

Changes in v7:
  - Add documentation comment explaining the four static aggregate
    temperature registers (Jonathan)

Changes in v6:
  - Macro brace on separate line for SYSMON_CHAN_TEMP (Andy)
  - Remove unneeded = 0 init on num_supply, num_temp (Andy)
  - Use temporary variable for channel count allocation (Andy)
  - Initialize idx directly after memcpy (Andy)
  - Join info_mask_separate on one line (Andy)
  - Join info_mask_shared_by_type on one line (Andy)
  - Join devm_kcalloc on one line (Andy)
  - Reversed xmas tree ordering in sysmon_parse_fw

Changes in v5:
  - Add err.h include to core (IWYU) (Andy)
  - Drop (int) cast on MILLI in scale assignment (Andy)
  - sign_extend32() instead of (s16) cast for temperature raw (Andy)
  - Remove unneeded parentheses in voltage address calculation (Andy)
  - Drop NULL checks before fwnode_get_child_node_count (Andy)
  - Nested size_add() for overflow-safe allocation (Andy)
  - if (ret) instead of if (ret < 0) for fwnode property reads (Andy)
  - Remove outer parentheses in satellite address calculation (Andy)
  - Loop index declared in for() scope (Andy)
  - MMIO: add err.h, types.h includes (IWYU) (Andy)
  - Header: remove unused types.h include and struct iio_dev
    forward declaration (Andy)

Changes in v4:
  - Temperature: RAW + SCALE (IIO_VAL_FRACTIONAL, 1000/128) instead
    of PROCESSED (Jonathan)
  - Voltage: PROCESSED only, drop RAW (Jonathan)
  - Drop scan_type from all channel macros (Jonathan)
  - Move __free(fwnode_handle) declarations down to just above use
    (Jonathan)
  - devm_regmap_init() on one line (Jonathan)
  - Lock comment: describe RMW sequences and cached state (Jonathan)
  - Remove sysmon_q8p7_to_millicelsius() from this patch; the function
    is now introduced in P4 where it is first used

Changes in v3:
  - IWYU: add array_size.h, string.h, types.h to core; audit and
    fix header and MMIO driver includes (Andy)
  - Rename _ext to _name in SYSMON_CHAN_TEMP macro parameter (Andy,
    Jonathan)
  - Use .info_mask_separate = BIT() style in SYSMON_CHAN_TEMP (Andy)
  - Use s16 parameter in sysmon_q8p7_to_millicelsius (Andy)
  - Use sign_extend32() in sysmon_supply_rawtoprocessed (Andy)
  - Split sysmon_read_raw parameters logically across lines (Andy)
  - Remove redundant (int) casts on regval (Andy)
  - Split num_supply/num_temp initialization (Andy)
  - Use __free(fwnode_handle) cleanup, remove goto err_put (Andy)
  - Use size_add() for overflow-safe allocation (Andy)
  - Use dev_err_probe() in sysmon_parse_fw error paths (Jonathan)
  - Move fwnode_irq_get() to core_probe, remove irq parameter
    from bus driver interfaces (Jonathan)
  - Use (int)MILLI at call sites, drop SYSMON_MILLI define (Andy,
    Jonathan)
  - Remove sysmon->dev, sysmon->indio_dev, sysmon->irq from struct;
    pass as local variables or use regmap_get_device() (Jonathan)
  - Use struct device *dev local in sysmon_platform_probe (Andy)
  - Describe protected data in lock comment (Jonathan)
  - Add comment explaining RAW+PROCESSED co-exposure (Jonathan)

Changes in v2:
  - Split into core (versal-sysmon-core.c) + MMIO platform driver
    (versal-sysmon.c) + shared header (versal-sysmon.h)
  - Uses regmap API instead of direct readl/writel
  - MMIO regmap uses custom callbacks with NPI unlock in write path
  - Reverse Christmas Tree variable ordering throughout
  - Header include order fixed
  - MAINTAINERS entry folded in with wildcard F: pattern
  - Kconfig: hidden VERSAL_SYSMON_CORE + VERSAL_SYSMON selects it
  - Kconfig/Makefile: alphabetical ordering (VERSAL before VF610)
  - Bounds validation on DT reg values
  - Named constants replace magic numbers (SYSMON_REG_STRIDE,
    SYSMON_SUPPLY_MANTISSA_BITS, SYSMON_MILLI)
  - kernel-doc for exported sysmon_core_probe() and sysmon_parse_fw()
  - Supply voltage conversion uses proper two's complement sign
    extension (s16 cast) matching the hardware specification
  - Register offsets sorted by address in header
  - Each patch introduces only the defines, fields, and includes
    it uses (no dead code in any commit)
  - Removed unused linux/limits.h and linux/units.h includes
  - Renamed iio_dev_info to sysmon_iio_info
  - regmap_write return values checked in probe init path
 MAINTAINERS                          |   7 +
 drivers/iio/adc/Kconfig              |  20 ++
 drivers/iio/adc/Makefile             |   2 +
 drivers/iio/adc/versal-sysmon-core.c | 292 +++++++++++++++++++++++++++
 drivers/iio/adc/versal-sysmon.c      |  92 +++++++++
 drivers/iio/adc/versal-sysmon.h      |  67 ++++++
 6 files changed, 480 insertions(+)
 create mode 100644 drivers/iio/adc/versal-sysmon-core.c
 create mode 100644 drivers/iio/adc/versal-sysmon.c
 create mode 100644 drivers/iio/adc/versal-sysmon.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd1..46762c8496d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29216,6 +29216,13 @@ F:	Documentation/devicetree/bindings/memory-controllers/xlnx,versal-net-ddrmc5.y
 F:	drivers/edac/versalnet_edac.c
 F:	include/linux/cdx/edac_cdx_pcol.h
 
+XILINX VERSAL SYSMON DRIVER
+M:	Salih Erim <salih.erim@amd.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
+F:	drivers/iio/adc/versal-sysmon*
+
 XILINX WATCHDOG DRIVER
 M:	Srinivas Neeli <srinivas.neeli@amd.com>
 R:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb4..c7f19057484 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1943,6 +1943,26 @@ config TWL6030_GPADC
 	  This driver can also be built as a module. If so, the module will be
 	  called twl6030-gpadc.
 
+config VERSAL_SYSMON_CORE
+	tristate
+	select REGMAP
+
+config VERSAL_SYSMON
+	tristate "AMD Versal SysMon driver"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	depends on HAS_IOMEM
+	select VERSAL_SYSMON_CORE
+	help
+	  Say yes here to have support for the AMD/Xilinx Versal System
+	  Monitor (SysMon). This driver provides voltage and temperature
+	  monitoring through the IIO subsystem.
+
+	  The SysMon measures up to 160 supply voltages and reads up to
+	  64 temperature satellites distributed across the SoC.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called versal-sysmon.
+
 config VF610_ADC
 	tristate "Freescale vf610 ADC driver"
 	depends on HAS_IOMEM
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 097357d146b..d7696b1b157 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -167,6 +167,8 @@ obj-$(CONFIG_TI_TLC4541) += ti-tlc4541.o
 obj-$(CONFIG_TI_TSC2046) += ti-tsc2046.o
 obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
 obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
+obj-$(CONFIG_VERSAL_SYSMON_CORE) += versal-sysmon-core.o
+obj-$(CONFIG_VERSAL_SYSMON) += versal-sysmon.o
 obj-$(CONFIG_VF610_ADC) += vf610_adc.o
 obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
 obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
new file mode 100644
index 00000000000..e0b9b3d2b6d
--- /dev/null
+++ b/drivers/iio/adc/versal-sysmon-core.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Versal SysMon core driver
+ *
+ * Copyright (C) 2019 - 2022, Xilinx, Inc.
+ * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+
+#include "versal-sysmon.h"
+
+#define SYSMON_CHAN_TEMP(_chan, _address, _name)		\
+{								\
+	.type = IIO_TEMP,					\
+	.indexed = 1,						\
+	.address = _address,					\
+	.channel = _chan,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.datasheet_name = _name,				\
+}
+
+/*
+ * Static temperature channels (always present).
+ *
+ * These are hardware-computed aggregate registers across all active
+ * temperature satellites:
+ *   temp:     current max temperature across all active satellites
+ *   min:      current min temperature across all active satellites
+ *   max_max:  highest peak recorded since last hardware reset
+ *   min_min:  lowest trough recorded since last hardware reset
+ */
+static const struct iio_chan_spec temp_channels[] = {
+	SYSMON_CHAN_TEMP(0, SYSMON_TEMP_MAX, "temp"),
+	SYSMON_CHAN_TEMP(1, SYSMON_TEMP_MIN, "min"),
+	SYSMON_CHAN_TEMP(2, SYSMON_TEMP_MAX_MAX, "max_max"),
+	SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
+};
+
+static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
+{
+	int mantissa, format, exponent;
+
+	mantissa = FIELD_GET(SYSMON_MANTISSA_MASK, raw_data);
+	exponent = SYSMON_SUPPLY_MANTISSA_BITS - FIELD_GET(SYSMON_MODE_MASK, raw_data);
+	format = FIELD_GET(SYSMON_FMT_MASK, raw_data);
+	/*
+	 * When format bit is set the mantissa is two's complement
+	 * (per hardware spec); sign-extend to int for correct arithmetic.
+	 */
+	if (format)
+		mantissa = sign_extend32(mantissa, 15);
+
+	*val = (mantissa * (int)MILLI) >> exponent;
+}
+
+static int sysmon_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	unsigned int regval;
+	int ret;
+
+	guard(mutex)(&sysmon->lock);
+
+	switch (chan->type) {
+	case IIO_TEMP:
+		if (mask == IIO_CHAN_INFO_SCALE) {
+			/* Q8.7 to millicelsius: raw * 1000 / 128 */
+			*val = MILLIDEGREE_PER_DEGREE;
+			*val2 = BIT(SYSMON_FRACTIONAL_SHIFT);
+			return IIO_VAL_FRACTIONAL;
+		}
+		if (mask != IIO_CHAN_INFO_RAW)
+			return -EINVAL;
+
+		ret = regmap_read(sysmon->regmap, chan->address, &regval);
+		if (ret)
+			return ret;
+
+		*val = sign_extend32(regval, 15);
+		return IIO_VAL_INT;
+
+	case IIO_VOLTAGE:
+		if (mask != IIO_CHAN_INFO_PROCESSED)
+			return -EINVAL;
+
+		ret = regmap_read(sysmon->regmap,
+				  chan->address * SYSMON_REG_STRIDE +
+				  SYSMON_SUPPLY_BASE, &regval);
+		if (ret)
+			return ret;
+
+		sysmon_supply_rawtoprocessed(regval, val);
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sysmon_read_label(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     char *label)
+{
+	if (chan->datasheet_name)
+		return sysfs_emit(label, "%s\n", chan->datasheet_name);
+
+	return -EINVAL;
+}
+
+static const struct iio_info sysmon_iio_info = {
+	.read_raw = sysmon_read_raw,
+	.read_label = sysmon_read_label,
+};
+
+/**
+ * sysmon_parse_fw() - Parse firmware nodes and configure IIO channels.
+ * @indio_dev: IIO device instance
+ * @dev: Parent device
+ *
+ * Reads voltage-channels and temperature-channels container nodes from
+ * firmware and builds the IIO channel array. Static temperature channels
+ * are prepended, followed by supply and satellite channels from DT.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
+{
+	unsigned int num_chan, num_static, idx, temp_chan_idx, volt_chan_idx;
+	unsigned int num_supply, num_temp;
+	struct iio_chan_spec *sysmon_channels;
+	const char *label;
+	u32 reg;
+	int ret;
+
+	struct fwnode_handle *supply_node __free(fwnode_handle) =
+		device_get_named_child_node(dev, "voltage-channels");
+	num_supply = fwnode_get_child_node_count(supply_node);
+
+	struct fwnode_handle *temp_node __free(fwnode_handle) =
+		device_get_named_child_node(dev, "temperature-channels");
+	num_temp = fwnode_get_child_node_count(temp_node);
+
+	num_static = ARRAY_SIZE(temp_channels);
+	num_chan = size_add(num_temp, size_add(num_static, num_supply));
+	sysmon_channels = devm_kcalloc(dev, num_chan, sizeof(*sysmon_channels), GFP_KERNEL);
+	if (!sysmon_channels)
+		return -ENOMEM;
+
+	/* Static temperature channels first */
+	memcpy(sysmon_channels, temp_channels, sizeof(temp_channels));
+	idx = num_static;
+
+	/* Supply channels from DT */
+	fwnode_for_each_child_node_scoped(supply_node, child) {
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "missing reg for supply channel\n");
+
+		if (reg > SYSMON_SUPPLY_IDX_MAX)
+			return dev_err_probe(dev, -EINVAL,
+					     "supply reg %u exceeds max %u\n",
+					     reg, SYSMON_SUPPLY_IDX_MAX);
+
+		ret = fwnode_property_read_string(child, "label", &label);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "missing label for supply channel\n");
+
+		sysmon_channels[idx++] = (struct iio_chan_spec) {
+			.type = IIO_VOLTAGE,
+			.indexed = 1,
+			.address = reg,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+			.datasheet_name = label,
+		};
+	}
+
+	/* Temperature satellite channels from DT */
+	fwnode_for_each_child_node_scoped(temp_node, child) {
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "missing reg for temp channel\n");
+
+		if (reg < 1 || reg > SYSMON_TEMP_SAT_MAX)
+			return dev_err_probe(dev, -EINVAL,
+					     "temp reg %u out of range [1..%u]\n",
+					     reg, SYSMON_TEMP_SAT_MAX);
+
+		ret = fwnode_property_read_string(child, "label", &label);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "missing label for temp channel\n");
+
+		sysmon_channels[idx++] = (struct iio_chan_spec) {
+			.type = IIO_TEMP,
+			.indexed = 1,
+			.address = SYSMON_TEMP_SAT_BASE +
+				   (reg - 1) * SYSMON_REG_STRIDE,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+			.datasheet_name = label,
+		};
+	}
+
+	indio_dev->num_channels = idx;
+	indio_dev->info = &sysmon_iio_info;
+
+	/*
+	 * Assign per-type sequential channel numbers.
+	 * IIO sysfs uses type prefix (in_tempN, in_voltageN)
+	 * so numbers only need to be unique within each type.
+	 */
+	temp_chan_idx = 0;
+	volt_chan_idx = 0;
+	for (unsigned int idx = 0; idx < indio_dev->num_channels; idx++) {
+		if (sysmon_channels[idx].type == IIO_TEMP)
+			sysmon_channels[idx].channel = temp_chan_idx++;
+		else
+			sysmon_channels[idx].channel = volt_chan_idx++;
+	}
+
+	indio_dev->channels = sysmon_channels;
+
+	return 0;
+}
+
+/**
+ * devm_versal_sysmon_core_probe() - Initialize Versal SysMon core
+ * @dev: Parent device
+ * @regmap: Register map for hardware access
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
+{
+	struct iio_dev *indio_dev;
+	struct sysmon *sysmon;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*sysmon));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	sysmon = iio_priv(indio_dev);
+	sysmon->regmap = regmap;
+
+	ret = devm_mutex_init(dev, &sysmon->lock);
+	if (ret)
+		return ret;
+
+	/* Disable all interrupts and clear pending status */
+	ret = regmap_write(sysmon->regmap, SYSMON_IDR, SYSMON_INTR_ALL_MASK);
+	if (ret)
+		return ret;
+	ret = regmap_write(sysmon->regmap, SYSMON_ISR, SYSMON_INTR_ALL_MASK);
+	if (ret)
+		return ret;
+
+	indio_dev->name = "versal-sysmon";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = sysmon_parse_fw(indio_dev, dev);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+EXPORT_SYMBOL_NS_GPL(devm_versal_sysmon_core_probe, "VERSAL_SYSMON");
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("AMD Versal SysMon Core Driver");
+MODULE_AUTHOR("Salih Erim <salih.erim@amd.com>");
diff --git a/drivers/iio/adc/versal-sysmon.c b/drivers/iio/adc/versal-sysmon.c
new file mode 100644
index 00000000000..529d0486c9f
--- /dev/null
+++ b/drivers/iio/adc/versal-sysmon.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Versal SysMon MMIO platform driver
+ *
+ * Copyright (C) 2019 - 2022, Xilinx, Inc.
+ * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include "versal-sysmon.h"
+
+struct sysmon_mmio {
+	void __iomem *base;
+};
+
+static int sysmon_mmio_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct sysmon_mmio *mmio = context;
+
+	*val = readl(mmio->base + reg);
+	return 0;
+}
+
+static int sysmon_mmio_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct sysmon_mmio *mmio = context;
+
+	/* NPI must be unlocked before any register write except to NPI_LOCK */
+	if (reg != SYSMON_NPI_LOCK)
+		writel(SYSMON_NPI_UNLOCK_CODE, mmio->base + SYSMON_NPI_LOCK);
+	writel(val, mmio->base + reg);
+
+	return 0;
+}
+
+static const struct regmap_config sysmon_mmio_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = SYSMON_REG_STRIDE,
+	.max_register = SYSMON_MAX_REG,
+	.reg_read = sysmon_mmio_reg_read,
+	.reg_write = sysmon_mmio_reg_write,
+	.fast_io = true,
+};
+
+static int sysmon_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sysmon_mmio *mmio;
+	struct regmap *regmap;
+
+	mmio = devm_kzalloc(dev, sizeof(*mmio), GFP_KERNEL);
+	if (!mmio)
+		return -ENOMEM;
+
+	mmio->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mmio->base))
+		return PTR_ERR(mmio->base);
+
+	regmap = devm_regmap_init(dev, NULL, mmio, &sysmon_mmio_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return devm_versal_sysmon_core_probe(dev, regmap);
+}
+
+static const struct of_device_id sysmon_of_match_table[] = {
+	{ .compatible = "xlnx,versal-sysmon" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sysmon_of_match_table);
+
+static struct platform_driver sysmon_platform_driver = {
+	.probe = sysmon_platform_probe,
+	.driver = {
+		.name = "versal-sysmon",
+		.of_match_table = sysmon_of_match_table,
+	},
+};
+module_platform_driver(sysmon_platform_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("AMD Versal SysMon Platform Driver");
+MODULE_IMPORT_NS("VERSAL_SYSMON");
+MODULE_AUTHOR("Salih Erim <salih.erim@amd.com>");
diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
new file mode 100644
index 00000000000..e27a5357575
--- /dev/null
+++ b/drivers/iio/adc/versal-sysmon.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD Versal SysMon driver
+ *
+ * Copyright (C) 2019 - 2022, Xilinx, Inc.
+ * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
+ */
+
+#ifndef _VERSAL_SYSMON_H_
+#define _VERSAL_SYSMON_H_
+
+#include <linux/bits.h>
+#include <linux/mutex.h>
+
+struct device;
+struct regmap;
+
+/* Register offsets (sorted by address) */
+#define SYSMON_NPI_LOCK			0x000C
+#define SYSMON_ISR			0x0044
+#define SYSMON_IDR			0x0050
+#define SYSMON_TEMP_MAX			0x1030
+#define SYSMON_TEMP_MIN			0x1034
+#define SYSMON_SUPPLY_BASE		0x1040
+#define SYSMON_TEMP_MIN_MIN		0x1F8C
+#define SYSMON_TEMP_MAX_MAX		0x1F90
+#define SYSMON_TEMP_SAT_BASE		0x1FAC
+#define SYSMON_MAX_REG			0x24C0
+
+/* NPI unlock value written to SYSMON_NPI_LOCK */
+#define SYSMON_NPI_UNLOCK_CODE		0xF9E8D7C6
+
+/* Register stride: 4 bytes per 32-bit register */
+#define SYSMON_REG_STRIDE		4
+
+#define SYSMON_SUPPLY_IDX_MAX		159
+#define SYSMON_TEMP_SAT_MAX		64
+#define SYSMON_INTR_ALL_MASK		GENMASK(31, 0)
+
+/* Supply voltage conversion register fields */
+#define SYSMON_MANTISSA_MASK		GENMASK(15, 0)
+#define SYSMON_FMT_MASK			BIT(16)
+#define SYSMON_MODE_MASK		GENMASK(18, 17)
+
+/* Q8.7 fractional shift */
+#define SYSMON_FRACTIONAL_SHIFT		7U
+#define SYSMON_SUPPLY_MANTISSA_BITS	16
+
+/**
+ * struct sysmon - Driver data for Versal SysMon
+ * @regmap: register map for hardware access
+ * @lock: protects read-modify-write sequences on threshold registers
+ *        and cached state that spans multiple regmap calls
+ */
+struct sysmon {
+	struct regmap *regmap;
+	/*
+	 * Protects read-modify-write sequences on threshold registers
+	 * and cached state (oversampling ratios, hysteresis values)
+	 * that spans multiple regmap calls.
+	 */
+	struct mutex lock;
+};
+
+int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap);
+
+#endif /* _VERSAL_SYSMON_H_ */
-- 
2.48.1

