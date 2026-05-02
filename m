Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333123385BC;
	Sat,  2 May 2026 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777720827; cv=fail; b=tUDl1zIVv/feF9B/OWnO/IiUl8AS8NzPE8xxmRIAS+PBN9toP7gfFx3T0ePfGFaaYTMJK4Oyejz6cTwDkrnaedfOQs0S4uA7CSLlJPb690E2hdS8/oEOZHnpPFeWh/rVDs/8y6sNIW5LcbLesBzYFOdZ4/eE5Y5NfE58FH0pmJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777720827; c=relaxed/simple;
	bh=QZNlhX284H5aPI1NTlCkPB6ElniJtT9GLSBtGKzIJdY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xo7fUm3Qlla38uG4rWMbiCZZqFtXQBGyHEFs0DiKT5R6UM1tEpUyU/RdEMnSZIBxJGWP31PUBa78g1WuliZs3jyXs6iCGnAYiLiMrc+yYFsOkQRBVksb/Ruo1R6IMZt6TPOXumRdnG97yMayUzkCNK5wsFXVdDKP5+eFQM9Y+lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ix/TCL4Y; arc=fail smtp.client-ip=40.107.208.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ix/TCL4Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3IIb2bQZvzYuvlZydrehF1gqLyALGQBmRslcPaH7n74UDNMUKIVJL4J1Nfg2mpQq5hsuamDvosWWesbgPod+5bus4GMF6ncNLMwHAYCQtcxFlxa5uc7IHOUgvrPpPZi72XkHzF8T1pW8KG27mj0gc+w+LlkYjzpIj5OrFz+Mt3LPJn80hPdekWc+BkI+4zg9AFbsMavoLM1OL1IsXYv+J12eR/4GCx0EOqBsiD6LLyJmzBItXjth4Zd16zk+eFltKiVVsKMf/1vn1bXATN88tgT+g3bBLLGVr9zr52IyZSrn50WlWGXIzn7+N+P52uO1clhgtUDU5DqQH44+8qrcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2mvenLE4wp2UheQrpDCptY8F0AeNDsGBYBN0YkdgPM=;
 b=A8AarqnKqtuhuqHtQ1VI1OboMzzXxk+AtQCwm3HnWW9Z/TdcxW7aUXdl2+JxfGIJ+bdxsHpO2iiaVv+CvxXYYov57y4lQsBpaSH/jbDftH7c8R23ucrlxhHg733JJDISMSw2P6CSNExDpPV3Y1odcprlUaEg5F19zUIFUcBjizfWnolI1pcL021NzFujiO7LQVRe+ZHjAGCbg/DtT3O4GWSEwIguid9MqILpwH7wc9Mns1LIcCVpnG2VMYOlt/TNsdfKdl2ZYYzXWcSqidFLhOYBABWw1zOOP/TguC+OFEtVDPf0WEqE7G4E0lcPPAg/phVgOO6ViFe4dcd/dHkIWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2mvenLE4wp2UheQrpDCptY8F0AeNDsGBYBN0YkdgPM=;
 b=Ix/TCL4YmPtyRBZEHnZgMd0IcSJJMGTabq8lZh18dXWoQWW0NQcJfcQSaVe02buw0bGQjcof0PPyhdB5lvaiKHqjv+QhH4D2y8cBLdV43vljEa1jPvq4kwuDRVIiNvJ9ZZwCeHd5yRYvLg00ww0ZL7krk33rFyUwor+mW6vM0mA=
Received: from SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::12)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sat, 2 May
 2026 11:20:17 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::6d) by SJ0P220CA0005.outlook.office365.com
 (2603:10b6:a03:41b::12) with Microsoft SMTP Server (version=TLS1_3,
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
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 2 May
 2026 06:20:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 2 May
 2026 06:20:10 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sat, 2 May 2026 06:20:08 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <git@amd.com>
CC: <nuno.sa@analog.com>, <andy@kernel.org>, <dlechner@baylibre.com>,
	<michal.simek@amd.com>, <conall.ogriofa@amd.com>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v2 2/5] iio: adc: add Versal SysMon driver
Date: Sat, 2 May 2026 12:19:48 +0100
Message-ID: <20260502111951.538488-3-salih.erim@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 785fc5af-f232-4dde-497b-08dea83cc9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Hk5xAOIFMBJ5ru1ZXXkBaOh9vSb/PoT5pASJfnPGSZITxUaTKLfsFZv7oNpCTA7GOobCU3i1hdAC40GMaISV8Rw56in6QERasFBtJZs14hmeHhX+jNKl37mO+VDUXuEAwCv8NY3+xfrAHM5JgOycd/b/Tm+sW1BPiSCF+pPvQZXI4kvIbF1j6HHHhZA63okPsRrDTMbBsxfxex4iOzzm918Xgemn4pHRTB4anLfA/3C9AfzuaXwwbevFuOFTTgH7D2aBWJx1JmSNrUnGLfAXKKWs4RiU7C1UrZYUkPD3XdbLtqimW91TiaahufzdEAd8iGMgsjLbhWyX0s4bdmaiCEOCFAMlQTLzBoFJ2wY8CJfJcMwgpTYebcv7tiMqqQ/jfNZoGSWPB9wvN9oETZ51Vj0TvLMt/ONh8NMvYBUc0Sobgp4mu5tRLghZFGB4JWcKTxVN44Sm/Vk7/6bFxU04pU+tMnM7VAkm4l37V7zL2+Gvs1glDwcKMxC/dEuwJdtnBflL7gimutiAMzboE0Ys9YsX67hdrUfjlbAv6Q9vLhfdChyKeVyW9N9IHWZvvMcWt4iqJOo12HM5v3UyZXgStTwFTm3lwMCpfdJmgJwaQMYlU7/6bsqAqLKJea4K7OjcQTQmbgx1wF+miyDH5b+RN+YLkyeQHAgY66Oi+5RqX4uOc43mWPZ+KotdB4kTJzjYepXOO6zIboRypKaMBBsJcyK/u+cT5GyZcQ6r8OihBRE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fSqTxCHA7bTMIJR2yxnUweo0PKJjoyFNsuzS3CUkHYycqNTgqSRFLBSlDcCKL/5riJpeEpnq4WruEhhI5NDUm3Q/oF93oGnrY45tfJkfsI3txCfeRIP7eXzD+cBG2E3m4Ngba7pqrBQBqfSm5+L/2NGY+08wIZ3NtC2JfRx9bkKBeKmobaEJE4jOeDT5HGYsl0X2rQKgYnDZF13xTgNqF4l3THVNhQzPVPueMS1JJii7/BIIkdIMH/qDeeaJBnhK2rAZU00mmEeKfGzARuXejfi01on/aXbJJ9XLOwXoTz+YyAuv90nj0cceSy7s7wfdECzctllXfnMw6XFKqN36MkV5MQdO7f54ZNGBBkszBzEo9keZRzoDy7sPbbZuosx/Jw5/LF7t2bkUl+oFZ9AO2oI5/bTfNFxMI2VSy149j+l1upRBoQhjIpkV/kMFsPEx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 11:20:17.1522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 785fc5af-f232-4dde-497b-08dea83cc9f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241

Add the AMD/Xilinx Versal System Monitor (SysMon) IIO driver.

The driver is split into a bus-agnostic core module
(versal-sysmon-core) and a memory-mapped I/O platform driver
(versal-sysmon). The core uses the regmap API so that different
bus implementations can share the same IIO logic.

The core provides:
  - Static temperature channels (current max/min, peak max/min)
  - Supply voltage channels parsed from DT container nodes
  - Temperature satellite channels parsed from DT container nodes
  - read_raw for IIO_CHAN_INFO_RAW and IIO_CHAN_INFO_PROCESSED
  - read_label using the DT label property

The MMIO platform driver provides:
  - Memory-mapped register access via custom regmap callbacks
  - NPI unlock before every register write (platform management
    controller may re-lock NPI unpredictably on Versal devices)

Threshold events, oversampling, and I2C bus support are added in
subsequent patches.

Co-developed-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Salih Erim <salih.erim@amd.com>
---
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
 drivers/iio/adc/versal-sysmon-core.c | 320 +++++++++++++++++++++++++++
 drivers/iio/adc/versal-sysmon.c      |  94 ++++++++
 drivers/iio/adc/versal-sysmon.h      |  69 ++++++
 6 files changed, 512 insertions(+)
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
index 00000000000..37736c2900b
--- /dev/null
+++ b/drivers/iio/adc/versal-sysmon-core.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Versal SysMon core driver
+ *
+ * Copyright (C) 2019 - 2022, Xilinx, Inc.
+ * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+#include "versal-sysmon.h"
+
+#define SYSMON_CHAN_TEMP(_chan, _address, _ext) {		\
+	.type = IIO_TEMP,					\
+	.indexed = 1,						\
+	.address = _address,					\
+	.channel = _chan,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+		BIT(IIO_CHAN_INFO_PROCESSED),			\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = 15,					\
+		.storagebits = 16,				\
+		.endianness = IIO_CPU,				\
+	},							\
+	.datasheet_name = _ext,					\
+}
+
+/* Static temperature channels (always present) */
+static const struct iio_chan_spec temp_channels[] = {
+	SYSMON_CHAN_TEMP(0, SYSMON_TEMP_MAX, "temp"),
+	SYSMON_CHAN_TEMP(1, SYSMON_TEMP_MIN, "min"),
+	SYSMON_CHAN_TEMP(2, SYSMON_TEMP_MAX_MAX, "max_max"),
+	SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
+};
+
+static void sysmon_q8p7_to_millicelsius(int raw_data, int *val)
+{
+	*val = ((s16)raw_data * SYSMON_MILLI) >> SYSMON_FRACTIONAL_SHIFT;
+}
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
+		mantissa = (int)(s16)mantissa;
+
+	*val = (mantissa * SYSMON_MILLI) >> exponent;
+}
+
+static int sysmon_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	struct sysmon *sysmon = iio_priv(indio_dev);
+	unsigned int regval;
+	int ret;
+
+	if (mask != IIO_CHAN_INFO_RAW && mask != IIO_CHAN_INFO_PROCESSED)
+		return -EINVAL;
+
+	guard(mutex)(&sysmon->lock);
+
+	switch (chan->type) {
+	case IIO_TEMP:
+		ret = regmap_read(sysmon->regmap, chan->address, &regval);
+		if (ret)
+			return ret;
+		if (mask == IIO_CHAN_INFO_PROCESSED)
+			sysmon_q8p7_to_millicelsius(regval, val);
+		else
+			*val = (int)regval;
+		return IIO_VAL_INT;
+
+	case IIO_VOLTAGE:
+		ret = regmap_read(sysmon->regmap,
+				  (chan->address * SYSMON_REG_STRIDE) + SYSMON_SUPPLY_BASE,
+				  &regval);
+		if (ret)
+			return ret;
+		if (mask == IIO_CHAN_INFO_PROCESSED)
+			sysmon_supply_rawtoprocessed(regval, val);
+		else
+			*val = (int)regval;
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
+ * Reads supply-channels and temperature-channels container nodes from
+ * firmware and builds the IIO channel array. Static temperature channels
+ * are prepended, followed by supply and satellite channels from DT.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
+{
+	unsigned int idx, temp_chan_idx, volt_chan_idx;
+	struct fwnode_handle *supply_node, *temp_node;
+	unsigned int num_supply = 0, num_temp = 0;
+	struct iio_chan_spec *sysmon_channels;
+	const char *label;
+	u32 reg;
+	int ret;
+
+	supply_node = device_get_named_child_node(dev, "supply-channels");
+	if (supply_node)
+		num_supply = fwnode_get_child_node_count(supply_node);
+
+	temp_node = device_get_named_child_node(dev, "temperature-channels");
+	if (temp_node)
+		num_temp = fwnode_get_child_node_count(temp_node);
+
+	sysmon_channels = devm_kcalloc(dev,
+				       ARRAY_SIZE(temp_channels) +
+				       num_supply + num_temp,
+				       sizeof(*sysmon_channels), GFP_KERNEL);
+	if (!sysmon_channels) {
+		ret = -ENOMEM;
+		goto err_put;
+	}
+
+	/* Static temperature channels first (fixed indices) */
+	idx = 0;
+	memcpy(sysmon_channels, temp_channels, sizeof(temp_channels));
+	idx += ARRAY_SIZE(temp_channels);
+
+	/* Supply channels from DT */
+	if (supply_node) {
+		fwnode_for_each_child_node_scoped(supply_node, child) {
+			ret = fwnode_property_read_u32(child, "reg", &reg);
+			if (ret < 0)
+				goto err_put;
+
+			if (reg > SYSMON_SUPPLY_IDX_MAX) {
+				ret = -EINVAL;
+				dev_err(dev, "supply reg %u exceeds max %u\n",
+					reg, SYSMON_SUPPLY_IDX_MAX);
+				goto err_put;
+			}
+
+			ret = fwnode_property_read_string(child, "label",
+							  &label);
+			if (ret < 0)
+				goto err_put;
+
+			sysmon_channels[idx++] = (struct iio_chan_spec) {
+				.type = IIO_VOLTAGE,
+				.indexed = 1,
+				.address = reg,
+				.info_mask_separate =
+					BIT(IIO_CHAN_INFO_RAW) |
+					BIT(IIO_CHAN_INFO_PROCESSED),
+				.scan_type = {
+					.realbits = 19,
+					.storagebits = 32,
+					.endianness = IIO_CPU,
+					.sign = fwnode_property_read_bool(child,
+						"bipolar") ? 's' : 'u',
+				},
+				.datasheet_name = label,
+			};
+		}
+		fwnode_handle_put(supply_node);
+		supply_node = NULL;
+	}
+
+	/* Temperature satellite channels from DT */
+	if (temp_node) {
+		fwnode_for_each_child_node_scoped(temp_node, child) {
+			ret = fwnode_property_read_u32(child, "reg", &reg);
+			if (ret < 0)
+				goto err_put;
+
+			if (reg < 1 || reg > SYSMON_TEMP_SAT_MAX) {
+				ret = -EINVAL;
+				dev_err(dev, "temp reg %u out of range [1..%u]\n",
+					reg, SYSMON_TEMP_SAT_MAX);
+				goto err_put;
+			}
+
+			ret = fwnode_property_read_string(child, "label",
+							  &label);
+			if (ret < 0)
+				goto err_put;
+
+			sysmon_channels[idx++] = (struct iio_chan_spec) {
+				.type = IIO_TEMP,
+				.indexed = 1,
+				.address = SYSMON_TEMP_SAT_BASE +
+					   ((reg - 1) * SYSMON_REG_STRIDE),
+				.info_mask_separate =
+					BIT(IIO_CHAN_INFO_RAW) |
+					BIT(IIO_CHAN_INFO_PROCESSED),
+				.scan_type = {
+					.sign = 's',
+					.realbits = 15,
+					.storagebits = 16,
+					.endianness = IIO_CPU,
+				},
+				.datasheet_name = label,
+			};
+		}
+		fwnode_handle_put(temp_node);
+		temp_node = NULL;
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
+	for (idx = 0; idx < indio_dev->num_channels; idx++) {
+		if (sysmon_channels[idx].type == IIO_TEMP)
+			sysmon_channels[idx].channel = temp_chan_idx++;
+		else
+			sysmon_channels[idx].channel = volt_chan_idx++;
+	}
+
+	indio_dev->channels = sysmon_channels;
+
+	return 0;
+
+err_put:
+	fwnode_handle_put(supply_node);
+	fwnode_handle_put(temp_node);
+	return ret;
+}
+
+/**
+ * sysmon_core_probe() - Initialize Versal SysMon core
+ * @dev: Parent device
+ * @regmap: Register map for hardware access
+ * @irq: Interrupt number (negative if not available)
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int sysmon_core_probe(struct device *dev, struct regmap *regmap, int irq)
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
+	sysmon->dev = dev;
+	sysmon->indio_dev = indio_dev;
+	sysmon->regmap = regmap;
+	sysmon->irq = irq;
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
+EXPORT_SYMBOL_GPL(sysmon_core_probe);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("AMD Versal SysMon Core Driver");
+MODULE_AUTHOR("Salih Erim <salih.erim@amd.com>");
diff --git a/drivers/iio/adc/versal-sysmon.c b/drivers/iio/adc/versal-sysmon.c
new file mode 100644
index 00000000000..c597934e869
--- /dev/null
+++ b/drivers/iio/adc/versal-sysmon.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Versal SysMon MMIO platform driver
+ *
+ * Copyright (C) 2019 - 2022, Xilinx, Inc.
+ * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "versal-sysmon.h"
+
+struct sysmon_mmio {
+	void __iomem *base;
+};
+
+static int sysmon_mmio_reg_read(void *context, unsigned int reg,
+				unsigned int *val)
+{
+	struct sysmon_mmio *mmio = context;
+
+	*val = readl(mmio->base + reg);
+	return 0;
+}
+
+static int sysmon_mmio_reg_write(void *context, unsigned int reg,
+				 unsigned int val)
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
+	struct sysmon_mmio *mmio;
+	struct regmap *regmap;
+	int irq;
+
+	mmio = devm_kzalloc(&pdev->dev, sizeof(*mmio), GFP_KERNEL);
+	if (!mmio)
+		return -ENOMEM;
+
+	mmio->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mmio->base))
+		return PTR_ERR(mmio->base);
+
+	regmap = devm_regmap_init(&pdev->dev, NULL, mmio,
+				  &sysmon_mmio_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	irq = platform_get_irq_optional(pdev, 0);
+
+	return sysmon_core_probe(&pdev->dev, regmap, irq);
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
+MODULE_AUTHOR("Salih Erim <salih.erim@amd.com>");
diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
new file mode 100644
index 00000000000..fc4d2338328
--- /dev/null
+++ b/drivers/iio/adc/versal-sysmon.h
@@ -0,0 +1,69 @@
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
+#include <linux/iio/iio.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
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
+/* Signed milli scale (MILLI from linux/units.h is unsigned long) */
+#define SYSMON_MILLI			1000
+
+/**
+ * struct sysmon - Driver data for Versal SysMon
+ * @dev: pointer to device struct
+ * @indio_dev: pointer to the iio device (needed for work callbacks)
+ * @regmap: register map for hardware access
+ * @lock: mutex for serializing user-space access
+ * @irq: interrupt number
+ */
+struct sysmon {
+	struct device *dev;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	/* Serializes access to device registers and state */
+	struct mutex lock;
+	int irq;
+};
+
+int sysmon_core_probe(struct device *dev, struct regmap *regmap, int irq);
+
+#endif /* _VERSAL_SYSMON_H_ */
-- 
2.48.1

