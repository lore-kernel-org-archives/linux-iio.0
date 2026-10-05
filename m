Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C1744780F;
	Mon,  5 Oct 2026 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193408; cv=fail; b=dTTlY93qA17w2OR7LbVf8jilL7N5HDtEIxhgXN1WULNCCFWM3PIleNM+g5WwZW+QVqyfTSELXAtqE1tBgo5O2sT0H73ws/XkYgs+eKv1OK58R6y3lFUeMqGKHk5uWVrSaEgJVKLgiDMaqrPmCdkH4vtckAMD7FA77fuxZVLHsEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193408; c=relaxed/simple;
	bh=4Wh8MbxDpto99gL4N7G9YsXUmhQ+LC7x1MvKHyN/+0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iW+wwOQHh5suvEWJ3anttJOnH4cdzvtwclceeu8uUS2Jlgu0Q664YTrORQdDSI5l1OLQVJEiBNHgtJ14+Fv/k0lamACdg7td1sO0/GsYMEkgpEaj6wkZjC4PiOpXe0FFTOg7X0ajpTaW1QXsKwaDbL/2URcO5VcVMEeqTPs6/o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gkENLEpa; arc=fail smtp.client-ip=40.107.209.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gkENLEpa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+qxqf/2DZWIkAf8i4JtROJwI7xM5zfoog+0nZBIyhKRG6FYU1cVrGtpU9JS7U8q8FZQqb72hvt99XYarUk5cE02znN6r18dOBPdrbo2vVc4fA9px0cEszPGPvoX/Fj8CpdIITb1KIbjbAYVc5UeDkQNyhWCmesBaZ5xm88hmiPSQ5UKtdYwpKEeKCHZGTOqPJ3CG2BbLV38WjkhiCK5VxFpFvccqjmDNQQ67fS67gtga0qbrdYdDE6XXBvLAygp/6lWPkiRUBDpMUSn2fwh9acuFrLC4mGGCfz2Vtw2MRT6hiC5lru3CxN6Kk5nt+bm2ZdEeQGolFILQzNaExan9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6NkkpPQo4HgaIrylzYbwGqEXamwBxK8IIDMEAX3dmU=;
 b=JNDsncuAEotxwTrpjPDEHhCYd+yWJATkWBI9syKaDKsV1Wno+bAOwRdL1d03BVK1YxsnwHCkmqqkL+upRxEt1ZTXGk4PazFz2SB0c40+BK6ldYGOOIx7iOSbhw59BOQU7k11F0K24KDSFbzlAR/WKyorp7wksOJdoxHBns+TGq1vCGrN7ut3yVz5UDd9bnhBnID7sx24CML0Dr4R8iFDPVJcsAmjAQLCfkN7tZUao+4Br7zvSZMDeX7ocjcvxs96qBaV3fkTRHC3tz6uLM8G9488xrWgHuGq+H/fRWIQh669wYqIJshFnduAxFZ7LfBeZtCslkLlt2yNk7zTZOlPOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6NkkpPQo4HgaIrylzYbwGqEXamwBxK8IIDMEAX3dmU=;
 b=gkENLEpac+ZK4GlbFhuzLBnZgM0dCHd/YS/sSoGxvpDDb9lo/bjYw9MQHJh77wlDPS05CTpv9aHlOhxPsJSjqgAaldpSylBckeEY/fgY5vKARmrM4js12ffo2PHZjJPKqFKJeksXA/rQSsnTE1aOBQUTk1NvTdiN0xFtSLmCrcU=
Received: from BN0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:408:e6::34)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Mon, 5 Oct
 2026 09:43:15 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::2b) by BN0PR03CA0029.outlook.office365.com
 (2603:10b6:408:e6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 09:43:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 09:43:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:43:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:43:13 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 04:43:10 -0500
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v4 15/15] iio: adc: xilinx-xadc: Add I2C interface support
Date: Mon, 5 Oct 2026 15:12:05 +0530
Message-ID: <20261005094205.1045874-16-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
References: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b434b19-82f2-45c4-70e1-08df22c51411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|6133799003|18002099003|22082099003|3023799007|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	I6Y3Ulh2bqeP6SsQaSeaXnRQuHelhLRhGvriRLAQn880EI69HW5ah5DFDvxejaP+/ARxE6xR7fm452I0rjZ0z/jlQ55jSnXiOs9jXGBbRZUasq83DSFiw8gLEeDLagTcW1m5Ow85i6HVvZuJs24UOQlBpBDsxL9qvlMlL96STOK/h0VUpLvyP9J6mbKQ1hbfTfDL8PNh+rIko55UnjzK+bhDTvzew4TWzdxmTDXOZo2wQdygJWWSoRBk6V0QP487bTAIVDRKKJTO5FwGgkXvr1ML3O7QvGs3DfnP5xT1xBezbxlKnCVEzlsD3kgBeH9bN9IIiGsaQeyhxDKgwNtgObfjTzoNUA9/1qNsnoQCcRvvzGpfpkcG1/elnfanC+CPgg2IIP0XIZ6GZMZDbimvWleaZDq3xyOuclHtZqWHY4mDIBhAA2CRzw2MKRP6+DZ0H3WHr/hONDFp7F5srRaVoP/62wurEcgqmrAfSumvryea87xqK/2JHr+HwIBOJ1xDwzOYv9muPmO/87ilbRoReO0fsEQNXgvll569LNQo4Fx1MxUMcHHiReJf/127nWexczzxXZ+nSkJoATJ6/+2BmRQyB9ODWyFpI+cNJM0V199ZLtNxz0JFieyoBu5ZWM8yJPUHAB5w+wQR8k2dmhf8bb0DLhPcNlfP3caOXlis9THhbtvgaclSV3+q7Dk195FoW902zCyMIG46f7Zk2rt+Xg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0TnxMNz9GeOUsVmy9TbCmLw+jBNynKG24comSu/JVOalCU+K4XKtdYUy3tYHVh6gH/QXpMVOpyyV8AxDNaomBhq3MTQLNbE/l3FTbIttJwCoX0lGh+fAyCDjiOu7gX6YC0ylrMsYxDFAzKrS/jwDVpcdAdXsQvQ4hajOpHKIRW3X2YwEYrkmPAy35jZgWUCDIQjNcsEn8cshaKj6BHfGBGsHqJ9xZtEFNrME38fLzQbApiNcwMbamJhoCfjuwNbQRZapTfz0fCa8JMAKUWaRx2KpqbfGNoOppVOq7SwkNSZx6Wl5jN5QE0J4Hx8dHdOgNAnHMhet51dq2hJwkZFTX8E9GUaTaIJDaics5adlq28OCIW1bo6zHTFEwjR+g/zrV/ew26t7EtHVyG2bYVUj8byJdFY/TWTVECNfdYrTanHSfytzvjTXSXxBgMNdlhwY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:43:15.0128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b434b19-82f2-45c4-70e1-08df22c51411
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768

Add I2C interface support for Xilinx System Management Wizard IP along
with the existing AXI memory-mapped interface. This support enables
monitoring the voltage and temperature on UltraScale+ devices where the
System Management Wizard is connected via I2C.

Key changes:
- Implement 32-bit DRP (Dynamic Reconfiguration Port) packet format
  as per Xilinx PG185 specification.
- Add separate I2C probe with xadc_i2c_of_match_table to handle same
  compatible string ("xlnx,system-management-wiz-1.3") on I2C bus.
- Add NULL checks for get_dclk_rate callback function in sampling rate
  functions to support interfaces without clock control
- Create separate iio_info structure(xadc_i2c_info) without event
  callbacks for I2C devices
- Add xadc_i2c_transaction() function to handle I2C read/write operations
- Add XADC_TYPE_US_I2C type to distinguish I2C interface from AXI
- Defer XADC hardware initialization until first device access, since the
  I2C path reaches the PL SysMon indirectly through a platform controller
  DRP bridge that may not yet be operational at probe() time. Initializing
  on first read/write instead avoids probe failures caused by transient
  unavailability of that downstream path.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/Kconfig            |  15 ++
 drivers/iio/adc/Makefile           |   1 +
 drivers/iio/adc/xilinx-xadc-core.c |  25 ++-
 drivers/iio/adc/xilinx-xadc-i2c.c  | 236 +++++++++++++++++++++++++++++
 drivers/iio/adc/xilinx-xadc.h      |   1 +
 5 files changed, 274 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iio/adc/xilinx-xadc-i2c.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 15ecf001b3ce..dd0ff0982d51 100644
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
+	  The driver can also be built as a module. If so, the module
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
index 2addb61cf5b1..80199c4ddf69 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -227,7 +227,7 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
 	 * non-existing ADC-B powers down the main ADC, so just return and don't
 	 * do anything.
 	 */
-	if (xadc->ops->type == XADC_TYPE_US)
+	if (xadc->ops->type == XADC_TYPE_US || xadc->ops->type == XADC_TYPE_US_I2C)
 		return 0;
 
 	/* Powerdown the ADC-B when it is not needed. */
@@ -249,7 +249,7 @@ static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
 	unsigned int aux_scan_mode = scan_mode >> 16;
 
 	/* UltraScale has only one ADC and supports only continuous mode */
-	if (xadc->ops->type == XADC_TYPE_US)
+	if (xadc->ops->type == XADC_TYPE_US || xadc->ops->type == XADC_TYPE_US_I2C)
 		return XADC_CONF1_SEQ_CONTINUOUS;
 
 	if (xadc->external_mux_mode == XADC_EXTERNAL_MUX_DUAL)
@@ -354,6 +354,9 @@ int xadc_read_samplerate(struct xadc *xadc)
 	u16 val16;
 	int ret;
 
+	if (!xadc->ops->get_dclk_rate)
+		return -EOPNOTSUPP;
+
 	ret = xadc_read_adc_reg(xadc, XADC_REG_CONF2, &val16);
 	if (ret)
 		return ret;
@@ -463,9 +466,13 @@ EXPORT_SYMBOL_NS_GPL(xadc_setup_buffer_and_triggers, "IIO_XADC");
 
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
 
@@ -658,6 +665,11 @@ static const struct iio_info xadc_info = {
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
@@ -769,6 +781,7 @@ EXPORT_SYMBOL_NS_GPL(xadc_parse_dt, "IIO_XADC");
 static const char *const xadc_type_names[] = {
 	[XADC_TYPE_S7] = "xadc",
 	[XADC_TYPE_US] = "xilinx-system-monitor",
+	[XADC_TYPE_US_I2C] = "xilinx-system-monitor",
 };
 
 struct iio_dev *xadc_device_setup(struct device *dev, int size, const struct xadc_ops **ops)
@@ -784,7 +797,11 @@ struct iio_dev *xadc_device_setup(struct device *dev, int size, const struct xad
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
index 000000000000..cee2f7b3f9bd
--- /dev/null
+++ b/drivers/iio/adc/xilinx-xadc-i2c.c
@@ -0,0 +1,236 @@
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
+/* Byte offsets within the 32-bit DRP packet, per Xilinx PG185 */
+#define XADC_I2C_DRP_DATA_LOW		0
+#define XADC_I2C_DRP_DATA_HIGH		1
+#define XADC_I2C_DRP_ADDR		2
+#define XADC_I2C_DRP_INSTR		3
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
+	u8 write_buffer[XADC_I2C_WRITE_DATA_SIZE] = { 0 };
+	struct i2c_client *client = xadc_i2c->client;
+	u8 read_buffer[XADC_I2C_READ_DATA_SIZE];
+	int ret;
+
+	write_buffer[XADC_I2C_DRP_ADDR] = FIELD_GET(XADC_I2C_DRP_ADDR_MASK, reg);
+	write_buffer[XADC_I2C_DRP_INSTR] = XADC_I2C_INSTR_READ;
+
+	ret = i2c_master_send(client, write_buffer, XADC_I2C_WRITE_DATA_SIZE);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_master_recv(client, read_buffer, XADC_I2C_READ_DATA_SIZE);
+	if (ret < 0)
+		return ret;
+
+	*val = FIELD_PREP(XADC_I2C_DRP_DATA0_MASK, read_buffer[XADC_I2C_DRP_DATA_LOW]) |
+	       FIELD_PREP(XADC_I2C_DRP_DATA1_MASK, read_buffer[XADC_I2C_DRP_DATA_HIGH]);
+
+	return 0;
+}
+
+static int xadc_i2c_write_transaction(struct xadc *xadc, unsigned int reg, u16 val)
+{
+	struct xadc_i2c *xadc_i2c = container_of(xadc, struct xadc_i2c, xadc);
+	struct i2c_client *client = xadc_i2c->client;
+	u8 write_buffer[XADC_I2C_WRITE_DATA_SIZE];
+	int ret;
+
+	/* low byte of the 16-bit DRP data value */
+	write_buffer[XADC_I2C_DRP_DATA_LOW] = FIELD_GET(XADC_I2C_DRP_DATA0_MASK, val);
+	/* high byte of the 16-bit DRP data value */
+	write_buffer[XADC_I2C_DRP_DATA_HIGH] = FIELD_GET(XADC_I2C_DRP_DATA1_MASK, val);
+	write_buffer[XADC_I2C_DRP_ADDR] = FIELD_GET(XADC_I2C_DRP_ADDR_MASK, reg);
+	write_buffer[XADC_I2C_DRP_INSTR] = XADC_I2C_INSTR_WRITE;
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
+	xadc->ops = ops;
+
+	ret = devm_mutex_init(dev, &xadc->mutex);
+	if (ret)
+		return ret;
+
+	spin_lock_init(&xadc->lock);
+
+	ret = xadc_device_configure(indio_dev, 0, &conf0, &bipolar_mask);
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
+MODULE_IMPORT_NS("IIO_XADC");
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>");
+MODULE_AUTHOR("Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>");
+MODULE_DESCRIPTION("Xilinx XADC I2C Interface Driver");
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 66d333ad91ec..c43001ec738c 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -71,6 +71,7 @@ struct xadc {
 enum xadc_type {
 	XADC_TYPE_S7, /* Series 7 */
 	XADC_TYPE_US, /* UltraScale and UltraScale+ */
+	XADC_TYPE_US_I2C, /* UltraScale+ I2C interface */
 };
 
 struct xadc_ops {
-- 
2.34.1

