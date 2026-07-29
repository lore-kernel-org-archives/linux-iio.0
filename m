Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BF1486B9F;
	Wed, 29 Jul 2026 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329751; cv=fail; b=KylsfQ7xk1ZyELuJuvS3xJvCaGGmCgUIA6gG8SiUkjH5qKDKjIx8ssUhwkQuUcTr1IhNRgsVMYBitWjiMU2eZHIzyEUSJRuhumTEIXu0NxpegIiFsZjCQ6mHiELNUg5CodXz6KnsxRtowsg1RCjjDLvWEfOWC3Wp3oIxlc1OQnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329751; c=relaxed/simple;
	bh=N/pdrMZajL0LM7Ir6DeQGmlqvdqE69xCnNIGL2xNKr4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8JYpfnJLGSKSIvNr27Kb0wJrOS0o/rDbfe+dTEG2W3F+nscjsxklbwvdSSJcPh2Ws9Tj6p5JdcouQgQ/My2e2h5cbFrjpaWRxEdyJiHdX+AJs8+R0yhi8RZZWxTPS0XLXxeoYRqTcdGJOCcZ6qWHKCM7J3KnJhIIddYgNI4Sxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Se1BMjv6; arc=fail smtp.client-ip=52.101.52.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Se1BMjv6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcFDwDZlGp2+m09yZvishmwMZay2FPQ0lyOKDsUkQOh1W6bKoFb1/W0uWwZ7sAcfKRYReWQzKf784avoyMDS/Wtbc9C+Gxa41kqyeZV3deLtdfL5ZkxUMjLGAbhokDw1BZch30TguqT7rk8GYUjl+voPSswJr28l28YDxoCDL2Bf9abG/O9Q/GWY4Moa++HhsRHyLlcjy6NabNrJLccwrPexxYPovrIWkDy7Nmbeg7VTVAdABXBL+6eFYvXLbccXLwGRyjPqxjp1cT2sQx1KGDI2JXHBoOBTMNK85a0jpH4LpiGZ5bud0nzUqIpfF580q+gsbVAM1A98b/hrjgWBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLqXVMpifFhlF/dBpMc3aIFKn6pNF5yrtFcLC4JB6SA=;
 b=RwqcaBOjZU24U7NURlCE/YCMVSg3n4eUEJCfWdclUvgqzMp/1lTysTMqjqjkOKyp79kLAJ+W86YOzibQciSPefSyjAOR/Zz90E9u86s5CBkqGCkkQrbe1mAJgHrO7KO7g7oEjj+FOU+h0EvRpgCLgOUMsnkK9/b2mkZT2LyX9P2aOgu+7jPKNUCCc4+kDxpzhmlGdhRWGCgQaF1Y2DP4h7mHa++NEpznTizCH4oV283VP7/5+prxedRmXjQusiTaEdHWy7B+a69WglquRZlxmMeXpbBeytWrdWZLvlQ8CHJ5iGtp2lWBdeqCy32DS617A3L5lCWgm8EQii/htBW4bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLqXVMpifFhlF/dBpMc3aIFKn6pNF5yrtFcLC4JB6SA=;
 b=Se1BMjv66tlld/7stiBwi51Vtvu002RlOg+JcYGgXHD0oQQHwbUIlKd5GySnctm/E8WXeFre/9a3xKKW1lv4wKlj1FP4EJLu4TyekLcyI7TueZWP5Tw6SytZdcKy2z9vw8cdJystCwK3sd1D1W27DBWycaifHccbg+0KzVPqEBU=
Received: from CH0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:610:b0::24)
 by SA3PR12MB9198.namprd12.prod.outlook.com (2603:10b6:806:39f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 12:55:27 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::7e) by CH0PR03CA0019.outlook.office365.com
 (2603:10b6:610:b0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 12:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 12:55:26 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 07:55:25 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 07:55:22 -0500
From: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<DileepKumar.Nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v3 5/6] iio: adc: xilinx-xadc: Add I2C interface support
Date: Wed, 29 Jul 2026 18:24:54 +0530
Message-ID: <20260729125455.95893-6-DileepKumar.Nagavarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729125455.95893-1-DileepKumar.Nagavarapu@amd.com>
References: <20260729125455.95893-1-DileepKumar.Nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|SA3PR12MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb2e18b-e3b0-48b1-1b66-08deed70a95a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|22082099003|56012099006|11063799006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	VD8eoolRl1HpGxTFS/O1TSCF7UjWZKBpDvT9jIKuYhvYQTHtZtTEH09Dra7hjekL8do7PNG/aN1g70+BBz3rhDi8wRwOBZSyIcUd0mpOINeVkIClwNWE7EfX753Jkz+uNrDnXULqHT3lTpGrwSw4AB0NPYdRuR3lL9aybcQc7+kF5sjyPwedGymzIGlgCfstn8xX9rv8ObfAVoSroFe0FtRYOQ8CFXNGN8XtWmRF8De5zVWZBRb62Lvrw2CA5eIay07A5O5FUplDYb+QDtCqdwFDea9bso6+eXoWWUA4jT4265l7/861qc2VFvFUtI7lex2HGxqf9720ycpMPiZ2qkbhpifqkmZbHyHV2xLmOLMwkFCo6ZEoBPrNRSK+DtT9mzovdKBmUsudw3qNbWa6S1w/nHtYrDJo8+gObXn6hbX/RxDlJpEtynENTe+DIQRa0+m6TaHbX4A8qm703SO1L2PtX6Z3j3TggvTedFDE8UG+kY+LFe24Eb6FJcV4BeILbvApxrsxoJ8NwpHZMlLtfBp/38IeQGwV5W/ufn6Cg1F6sMUzs1hOuTcG3/MT6in0IkrKXbNILx+HXGwuUSDYFhgkRTHMJ5Fs4SegGsTpOxgHglW5+uvksU3K+pzafx2529UrtwSDdZtFhOu7ZDrh8zNGeSEmd2JvNM2tY9k6732RqGH3Snaq2VsAriVWODz+fMrhLC1TvUY3UT1ct1QiMg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cxcLb6XAaVSdAkhu2AUSndBw85QE6ElnwnAF9TLC9xhelIuiUS7Gzb1vP0gtTx4bp0jvZhNlhd3Bbfi9yj26YEGvQi2jIdKzJ/OlOq9c2R9skGbqKeHZkxj5A+HHZFd1z/WzrQxzY/nUn2O4zVz0s9upDbM62YpVBwgk8yY5ZOdk65G1YnYiBdr5gE1KAtdiMP6xiUaDz9d91gYe9cfoNCUMmcuSeslTAD/WNcxwtKEgrWG0z8GGV9DZX1s9HJ1ylenbvthSo5Kj8U7WxmKhgtkGWqLAIgOYbZzB2g8Dw4swn3/ARI2ZBExYBBH7bD58EGU0+RkICfNUPGhrbP/R7osGQbO5HTzz3xa0rJhJyz3TWdz/8kBUm+MwgKAOrfy/TW3lD3R/Nj+Os0zbl5JhFusftLj0+RNMFi28v0XriGhb6z/bq0PiTcQdOecCiS1u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:55:26.6031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb2e18b-e3b0-48b1-1b66-08deed70a95a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9198

Add I2C interface support for Xilinx System Management Wizard IP along
with the existing AXI memory-mapped interface. This support enables
monitoring the voltage and temperature on UltraScale+ devices where the
System Management Wizard is connected via I2C.

Key changes:
- Implement 32-bit DRP(Dynamic Reconfiguration Port) packet format as per
  Xilinx PG185 specification.
- Add separate I2C probe with xadc_i2c_of_match_table to handle same
  compatible string("xlnx,system-management-wiz-1.3") on I2C bus.
- Implement delayed version of hardware initialization for I2C interface
  to handle the case where System Management Wizard IP is not ready during
  the I2C probe.
- Add NULL checks for get_dclk_rate callback function in sampling rate
  functions to support interfaces without clock control
- Create separate iio_info structure(xadc_i2c_info) without event
  callbacks for I2C devices
- Add xadc_i2c_transaction() function to handle I2C read/write operations
- Add XADC_TYPE_US_I2C type to distinguish I2C interface from AXI
- Defer XADC hardware initialization until first device access.
- The I2C path reaches the PL SysMon indirectly through a platform
  controller DRP bridge, which may not be operational when the driver
  probes.
- Initialize hardware on first read/write instead of probe() to avoid
  failures caused by temporary unavailability of the downstream path.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>
---
 drivers/iio/adc/Kconfig            |  15 ++
 drivers/iio/adc/Makefile           |   1 +
 drivers/iio/adc/xilinx-xadc-core.c |  25 +++-
 drivers/iio/adc/xilinx-xadc-i2c.c  | 228 +++++++++++++++++++++++++++++
 drivers/iio/adc/xilinx-xadc.h      |   1 +
 5 files changed, 266 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iio/adc/xilinx-xadc-i2c.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 15ecf001b3ce..9f7f0abdb29e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -2051,6 +2051,21 @@ config XILINX_XADC
 	  The driver can also be build as a module. If so, the module will be called
 	  xilinx-xadc.
 
+config XILINX_XADC_I2C
+	tristate "Xilinx System Management Wizard I2C Interface support"
+	depends on I2C
+	select XILINX_XADC_CORE
+	help
+	  Say yes here to allow accessing the System Management
+	  Wizard on UltraScale+ devices via I2C.
+
+	  This provides voltage and temperature monitoring capabilities
+	  through the same IIO sysfs interface, but using I2C communication
+	  protocol.
+
+	  The driver can also be build as a module. If so, the module
+	  will be called xilinx-xadc-i2c.
+
 config XILINX_AMS
 	tristate "Xilinx AMS driver"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 4cb06243966c..1f22f8a4b439 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -178,3 +178,4 @@ obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
 xilinx-xadc-common-y := xilinx-xadc-core.o xilinx-xadc-events.o
 obj-$(CONFIG_XILINX_XADC_CORE) += xilinx-xadc-common.o
 obj-$(CONFIG_XILINX_XADC) += xilinx-xadc-platform.o
+obj-$(CONFIG_XILINX_XADC_I2C) += xilinx-xadc-i2c.o
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index d39ff54439ba..1f1a1d5d23d3 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -224,7 +224,7 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
 	 * non-existing ADC-B powers down the main ADC, so just return and don't
 	 * do anything.
 	 */
-	if (xadc->ops->type == XADC_TYPE_US)
+	if (xadc->ops->type == XADC_TYPE_US || xadc->ops->type == XADC_TYPE_US_I2C)
 		return 0;
 
 	/* Powerdown the ADC-B when it is not needed. */
@@ -246,7 +246,7 @@ static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
 	unsigned int aux_scan_mode = scan_mode >> 16;
 
 	/* UltraScale has only one ADC and supports only continuous mode */
-	if (xadc->ops->type == XADC_TYPE_US)
+	if (xadc->ops->type == XADC_TYPE_US || xadc->ops->type == XADC_TYPE_US_I2C)
 		return XADC_CONF1_SEQ_CONTINUOUS;
 
 	if (xadc->external_mux_mode == XADC_EXTERNAL_MUX_DUAL)
@@ -351,6 +351,9 @@ int xadc_read_samplerate(struct xadc *xadc)
 	u16 val16;
 	int ret;
 
+	if (!xadc->ops->get_dclk_rate)
+		return -EOPNOTSUPP;
+
 	ret = xadc_read_adc_reg(xadc, XADC_REG_CONF2, &val16);
 	if (ret)
 		return ret;
@@ -460,9 +463,13 @@ EXPORT_SYMBOL_NS_GPL(xadc_setup_buffer_and_triggers, "IIO_XADC");
 
 int xadc_write_samplerate(struct xadc *xadc, int val)
 {
-	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
+	unsigned long clk_rate;
 	unsigned int div;
 
+	if (!xadc->ops->get_dclk_rate)
+		return -EOPNOTSUPP;
+
+	clk_rate = xadc->ops->get_dclk_rate(xadc);
 	if (!clk_rate)
 		return -EINVAL;
 
@@ -656,6 +663,11 @@ static const struct iio_info xadc_info = {
 	.update_scan_mode = &xadc_update_scan_mode,
 };
 
+static const struct iio_info xadc_i2c_info = {
+	.read_raw = &xadc_read_raw,
+	.write_raw = &xadc_write_raw,
+};
+
 int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 {
 	struct device *dev = indio_dev->dev.parent;
@@ -767,6 +779,7 @@ EXPORT_SYMBOL_NS_GPL(xadc_parse_dt, "IIO_XADC");
 static const char *const xadc_type_names[] = {
 	[XADC_TYPE_S7] = "xadc",
 	[XADC_TYPE_US] = "xilinx-system-monitor",
+	[XADC_TYPE_US_I2C] = "xilinx-system-monitor",
 };
 
 struct iio_dev *xadc_device_setup(struct device *dev, int size, const struct xadc_ops **ops)
@@ -780,7 +793,11 @@ struct iio_dev *xadc_device_setup(struct device *dev, int size, const struct xad
 		return ERR_PTR(-ENOMEM);
 
 	indio_dev->name = xadc_type_names[(*ops)->type];
-	indio_dev->info = &xadc_info;
+	if ((*ops)->type == XADC_TYPE_US_I2C)
+		indio_dev->info = &xadc_i2c_info;
+	else
+		indio_dev->info = &xadc_info;
+
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	return indio_dev;
diff --git a/drivers/iio/adc/xilinx-xadc-i2c.c b/drivers/iio/adc/xilinx-xadc-i2c.c
new file mode 100644
index 000000000000..5628340d7ed5
--- /dev/null
+++ b/drivers/iio/adc/xilinx-xadc-i2c.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx XADC I2C Interface Driver
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ *
+ * This driver implements I2C interface support for Xilinx System Management
+ * Wizard IP on UltraScale+ devices. It uses the 32-bit DRP (Dynamic
+ * Reconfiguration Port) packet format as per Xilinx PG185 specification.
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+
+#include <linux/iio/iio.h>
+
+#include "xilinx-xadc.h"
+
+#define XADC_I2C_READ_DATA_SIZE		2
+#define XADC_I2C_WRITE_DATA_SIZE	4	/* 32-bit DRP packet */
+#define XADC_I2C_INSTR_READ		BIT(2)
+#define XADC_I2C_INSTR_WRITE		BIT(3)
+
+#define XADC_I2C_DRP_DATA0_MASK		GENMASK(7, 0)
+#define XADC_I2C_DRP_DATA1_MASK		GENMASK(15, 8)
+#define XADC_I2C_DRP_ADDR_MASK		GENMASK(7, 0)
+
+#define XADC_INPUT_MODE_BITS		16
+
+struct xadc_i2c {
+	struct xadc xadc;
+	struct i2c_client *client;
+	bool hw_initialized;
+	unsigned int conf0;
+	unsigned int bipolar_mask;
+};
+
+static int xadc_i2c_read_transaction(struct xadc *xadc, unsigned int reg, u16 *val)
+{
+	struct xadc_i2c *xadc_i2c = container_of(xadc, struct xadc_i2c, xadc);
+	char write_buffer[XADC_I2C_WRITE_DATA_SIZE] = { 0 };
+	struct i2c_client *client = xadc_i2c->client;
+	char read_buffer[XADC_I2C_READ_DATA_SIZE];
+	int ret;
+
+	write_buffer[2] = FIELD_GET(XADC_I2C_DRP_ADDR_MASK, reg);
+	write_buffer[3] = XADC_I2C_INSTR_READ;
+
+	ret = i2c_master_send(client, write_buffer, XADC_I2C_WRITE_DATA_SIZE);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_master_recv(client, read_buffer, XADC_I2C_READ_DATA_SIZE);
+	if (ret < 0)
+		return ret;
+
+	*val = FIELD_PREP(XADC_I2C_DRP_DATA0_MASK, read_buffer[0]) |
+	       FIELD_PREP(XADC_I2C_DRP_DATA1_MASK, read_buffer[1]);
+
+	return 0;
+}
+
+static int xadc_i2c_write_transaction(struct xadc *xadc, unsigned int reg, u16 val)
+{
+	struct xadc_i2c *xadc_i2c = container_of(xadc, struct xadc_i2c, xadc);
+	struct i2c_client *client = xadc_i2c->client;
+	char write_buffer[XADC_I2C_WRITE_DATA_SIZE];
+	int ret;
+
+	/* low byte of the 16-bit DRP data value */
+	write_buffer[0] = FIELD_GET(XADC_I2C_DRP_DATA0_MASK, val);
+	/* high byte of the 16-bit DRP data value */
+	write_buffer[1] = FIELD_GET(XADC_I2C_DRP_DATA1_MASK, val);
+	write_buffer[2] = FIELD_GET(XADC_I2C_DRP_ADDR_MASK, reg);
+	write_buffer[3] = XADC_I2C_INSTR_WRITE;
+
+	ret = i2c_master_send(client, write_buffer, XADC_I2C_WRITE_DATA_SIZE);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int xadc_hardware_init(struct xadc *xadc)
+{
+	struct xadc_i2c *xadc_i2c = container_of(xadc, struct xadc_i2c, xadc);
+	int ret;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(xadc->threshold); i++) {
+		ret = xadc_i2c_read_transaction(xadc, XADC_REG_THRESHOLD(i), &xadc->threshold[i]);
+		if (ret)
+			return ret;
+	}
+
+	ret = xadc_i2c_write_transaction(xadc, XADC_REG_CONF0, xadc_i2c->conf0);
+	if (ret)
+		return ret;
+
+	ret = xadc_i2c_write_transaction(xadc, XADC_REG_INPUT_MODE(0), xadc_i2c->bipolar_mask);
+	if (ret)
+		return ret;
+
+	ret = xadc_i2c_write_transaction(xadc, XADC_REG_INPUT_MODE(1),
+					 xadc_i2c->bipolar_mask >> XADC_INPUT_MODE_BITS);
+	if (ret)
+		return ret;
+
+	xadc_i2c->hw_initialized = true;
+
+	return 0;
+}
+
+static int xadc_i2c_read_reg(struct xadc *xadc, unsigned int reg, u16 *val)
+{
+	struct xadc_i2c *xadc_i2c = container_of(xadc, struct xadc_i2c, xadc);
+
+	/*
+	 * Deferring initialization to the first real read/write means it
+	 * only runs once the device is actually being used, at which point
+	 * the full path down to the PL SysMon is expected to be up. This
+	 * avoids spurious probe failures caused by transient unavailability
+	 * of hardware outside this driver's control.
+	 */
+	if (!xadc_i2c->hw_initialized) {
+		int ret;
+
+		ret = xadc_hardware_init(xadc);
+		if (ret)
+			return ret;
+	}
+
+	return xadc_i2c_read_transaction(xadc, reg, val);
+}
+
+static int xadc_i2c_write_reg(struct xadc *xadc, unsigned int reg, u16 val)
+{
+	struct xadc_i2c *xadc_i2c = container_of(xadc, struct xadc_i2c, xadc);
+
+	/*
+	 * Deferring initialization to the first real read/write means it
+	 * only runs once the device is actually being used, at which point
+	 * the full path down to the PL SysMon is expected to be up. This
+	 * avoids spurious probe failures caused by transient unavailability
+	 * of hardware outside this driver's control.
+	 */
+	if (!xadc_i2c->hw_initialized) {
+		int ret;
+
+		ret = xadc_hardware_init(xadc);
+		if (ret)
+			return ret;
+	}
+
+	return xadc_i2c_write_transaction(xadc, reg, val);
+}
+
+static const struct xadc_ops xadc_system_mgmt_wiz_i2c_ops = {
+	.read = xadc_i2c_read_reg,
+	.write = xadc_i2c_write_reg,
+	.setup_channels = xadc_parse_dt,
+	.type = XADC_TYPE_US_I2C,
+	.temp_scale = 509314,
+	.temp_offset = 280231,
+};
+
+static int xadc_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	unsigned int conf0, bipolar_mask;
+	const struct xadc_ops *ops;
+	struct iio_dev *indio_dev;
+	struct xadc_i2c *xadc_i2c;
+	struct xadc *xadc;
+	int ret;
+
+	indio_dev = xadc_device_setup(dev, sizeof(*xadc_i2c), &ops);
+	if (IS_ERR(indio_dev))
+		return PTR_ERR(indio_dev);
+
+	xadc_i2c = iio_priv(indio_dev);
+	xadc_i2c->client = client;
+	xadc = &xadc_i2c->xadc;
+	xadc->clk = NULL;
+	xadc->ops = ops;
+
+	ret = devm_mutex_init(xadc->mutex);
+	if (ret)
+		return ret;
+
+	spin_lock_init(&xadc->lock);
+
+	ret = xadc_device_configure(dev, indio_dev, 0, &conf0, &bipolar_mask);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup the device\n");
+
+	xadc_i2c->conf0 = conf0;
+	xadc_i2c->bipolar_mask = bipolar_mask;
+	xadc_i2c->hw_initialized = false;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id xadc_i2c_of_match_table[] = {
+	{
+		.compatible = "xlnx,system-management-wiz-1.3",
+		.data = &xadc_system_mgmt_wiz_i2c_ops,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, xadc_i2c_of_match_table);
+
+static struct i2c_driver xadc_i2c_driver = {
+	.probe = xadc_i2c_probe,
+	.driver = {
+		.name = "xadc-i2c",
+		.of_match_table = xadc_i2c_of_match_table,
+	},
+};
+module_i2c_driver(xadc_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>");
+MODULE_DESCRIPTION("Xilinx XADC I2C Interface Driver");
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 67efa093157e..178d4fa0b249 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -69,6 +69,7 @@ struct xadc {
 enum xadc_type {
 	XADC_TYPE_S7, /* Series 7 */
 	XADC_TYPE_US, /* UltraScale and UltraScale+ */
+	XADC_TYPE_US_I2C, /* UltraScale+ I2C interface */
 };
 
 struct xadc_ops {
-- 
2.34.1

