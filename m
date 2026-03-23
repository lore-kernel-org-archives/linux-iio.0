Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA13364053;
	Mon, 23 Mar 2026 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774251987; cv=fail; b=tvEMFECRRlO6omgrhdBeTaKDe2tAoqld2aVAVDzkkrL6wkoMt7ZSGCy9nOpoFdA7YBmvIFTBjcPlCddrQP8zE2hMwjY6PXLhsfmWFMCfkS1lxPa5cH+K5Eo83fOLx5a0G1+vMczQ9cn8BZ9lbpe0YzuKtNBbgSJuhzDfCVsqM4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774251987; c=relaxed/simple;
	bh=gB8sTKP9Gd0ktIAK5pjrbgJ1eErUJvmzKJLjB6WPbrY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5gI2XrPrNPNLTrpXU56oCEgblLxIR9pHLJDSJI8k4otVeZ2UUsJYHIAvvwBXpeYfR3K0ryRNg/h07tsdmeghEx8GBY2X9IL6wJ3bLCZARve+R+DfIowxjz7lTPfVnfrxrwN/pKz3fFcvTST0tUVSQhMNSB8RBiv4nH+w/akVh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xSj21CCu; arc=fail smtp.client-ip=52.101.46.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xSj21CCu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0xs/xOhz8DuU1skVrJj09gkkqwto29WRlUNjsPy9FwY+LJ1FMKXhkiXR8xeS40Ur+w8MWVdwV59Ap3PX20nF3D82zwZZBENWJIVla/pkXRDg/4ut85Cp65To7qeiQeH287BxtPLIkGcFWLDg0bHIIfRZrNBOWBI21jnpSEfa9HZC1UW8wYEVXt+I2tKoCKg0ntav0Ia5q1FzIjurBCg9YpRhh7kN9rVk83Tdtq04tm3CKHHND+xvAvf/hc2o/6kyoVWfALlaQPhm/PET+/bcgJ5I7ejWBUjbMkMurkNpYNaa5uahgJIgylA4chvol140xmEXJV7fLq61qi65zx1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdJob3FigaIv6MGj21BovoPuxvgP9qQ0dLnWgLi4yWg=;
 b=uezhx7ln/nQ8ZVp69kyUUDRbr7MiDCrDhtaO6ubdshPuGmzmrmwv66dOkToeWJCtkuhZ/cqC8/parY4+go5VLfyxTZi4qan6Cav7zD3kvjmIOblBhQ5349G0wRKhEaUGwSc11vS5EKDVL9U+ZaS/BkFfSy8a7YA+pDCZioNam1Nsj+H3RTHeNhJtolY/7PyJH0yTAukhpP1ZXyAKsvJwg7vxutJWwhYC8jffT4mScKOY0B5MlTlqYRoChP1GyT83nPzG/fKbw1IAgUZufRQyX+/kQTC/Uo3VmLi4SwgOER70pR67zwQgakoM8RD837teJfTAGHK4TmgKlzwD4fdcUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdJob3FigaIv6MGj21BovoPuxvgP9qQ0dLnWgLi4yWg=;
 b=xSj21CCu4KBKkgG2Qg7sEogkSF58MzgdQtTJj90Muf4SmsctdvE9M4RZMRp+hHF4hD3mEXPrcnDHlHVSHKKnl5HEAsnPaaCHGd/CzyPyzQHEmFvLEB/9IWeE2eKC086lOatBG5lIkuBN+I+yw3qQxTUqNXgvi7P/4dWrISWqwQ8=
Received: from BL1PR13CA0314.namprd13.prod.outlook.com (2603:10b6:208:2c1::19)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 07:46:17 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::f0) by BL1PR13CA0314.outlook.office365.com
 (2603:10b6:208:2c1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 07:46:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 07:46:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 23 Mar
 2026 02:46:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Mar
 2026 02:46:14 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 02:46:11 -0500
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Michal Simek <michal.simek@amd.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<saikrishna12468@gmail.com>, <git@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v2 3/4] iio: adc: xilinx-xadc: Add I2C interface support
Date: Mon, 23 Mar 2026 13:15:04 +0530
Message-ID: <20260323074505.3853353-4-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260323074505.3853353-1-sai.krishna.potthuri@amd.com>
References: <20260323074505.3853353-1-sai.krishna.potthuri@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sai.krishna.potthuri@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 7039d6e7-c9c6-4343-8300-08de88b04400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zzY3Xl+ymfcgHWkyxoFcV+seqImnxIu8lvzu1vGnFIVCwVQ5steefcJRbfo8MC/6Y8j1L9kednTYLGtIh5Q/XpHTJBWWGTa5ffKbfoDrCbkNxaNyS9G22LdKRPZ7MpfhJLbdQE1VH+hnUNlfJRLrV58V8MCu3cVwNwz9MinsBZem7XGm9EAsRGM+7An31YsqyQu8Fz003H2r3Dyi0IV5dY361OgTVzaVxvYeYOolVMpBFo0yYHfp92h5ZNBk6GR0zkLmxCBKxEDGoKl/xTLUBCzE7wBRfhpyE4XEdwI60AldBXkKXXCbNyNxUYEMapGOw/f53XijILHLlMZTbAhZCvoJm8lfNEgm37e4oh1cbUEgjm8TyirsFamkimL1jhAKTUDeNRsjDu6/N28iN/HycIJH2hyVcB5o/5ckU0bYz2Ey63b82VbC1VStJkozd0sZQgm+QPdgBo5ZhGdt1ijQPhMS8vqAzNNuQFEZC7QoaAUu0PIcKmwlJcEG638iKYiQ59MP0RSt3xv60RNWMxSzWvVu8pbG7zoQFYVyfN+7axM2nc9/6wHo1i98dhtOLiLpiVuP8HBQAQ0evPZfCRYU4wctRtz2FY32xy85vah7Yv6rftYMby9ahjLXeDi1NVfCXIZBIUD/OGbH8zOm2qogam5gIk9JSZ8Ye9IzjzhVf40XSDml71ce3ImBSI+Wmcd6cmaDMWHlXHZflgEidtyIsZpvMUM0GVLiipekkYF2e86ap7l42wsLgpQAcewUMtHz2Z5FHR6jG3jXEj/s74a3wg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N/0nLKGL2feHyJjj5h7zTtPtTVWY3DNct+hxsQOZhQHXkMDiyMkxOqMJf0rU/jTwmv6uAmOn8o76PMXQjHo70HqePvfpW5gX+lliY5waM+XD4YVJ6EEVo762BmXE7zsQ4Q9tAphucgtqSkiEkzDraii2McfhBmepPU6c9s8C0PX0qoNlmOG/bejLRlgpT6ApRKgzb4QK94hnHjQJLJS0F7JmHqynXSarqy4qAY6vxrJMpVBtzP4vzK/n+bDOZiTHWoRaDG6H+By3oUtKPdCOoscWTyg2UH5omR5nHd1D1sdGDtioGSKHzKTH16x9VR+jQzW6VFJop5w3JaU42Y/9Tx4rXqRrDiljBJAtMrUYXltcZogS0dI/zYFH25ETh54k216IWlPta8j8jnNbWxswDU9wuI/es6AnJlyuck+rzTHbHe/BfpFPVFxhqYMqJyRe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 07:46:16.9256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7039d6e7-c9c6-4343-8300-08de88b04400
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039

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

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/iio/adc/Kconfig            |  15 ++
 drivers/iio/adc/Makefile           |   1 +
 drivers/iio/adc/xilinx-xadc-core.c |  28 +++-
 drivers/iio/adc/xilinx-xadc-i2c.c  | 215 +++++++++++++++++++++++++++++
 drivers/iio/adc/xilinx-xadc.h      |   1 +
 5 files changed, 256 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iio/adc/xilinx-xadc-i2c.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a4a7556f4016..5a3956a5c086 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1767,6 +1767,21 @@ config XILINX_XADC
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
+	  The driver can also be build as a module. If so, the module will be called
+	  xilinx-xadc-i2c.
+
 config XILINX_AMS
 	tristate "Xilinx AMS driver"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 1b05176f0098..2dc08c9d82cc 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -157,3 +157,4 @@ obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
 xilinx-xadc-common-y := xilinx-xadc-core.o xilinx-xadc-events.o
 obj-$(CONFIG_XILINX_XADC_CORE) += xilinx-xadc-common.o
 obj-$(CONFIG_XILINX_XADC) += xilinx-xadc-platform.o
+obj-$(CONFIG_XILINX_XADC_I2C) += xilinx-xadc-i2c.o
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 7fbf55f8e0bb..383bd93676ec 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -222,7 +222,8 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
 	 * non-existing ADC-B powers down the main ADC, so just return and don't
 	 * do anything.
 	 */
-	if (xadc->ops->type == XADC_TYPE_US)
+	if (xadc->ops->type == XADC_TYPE_US ||
+	    xadc->ops->type == XADC_TYPE_US_I2C)
 		return 0;
 
 	/* Powerdown the ADC-B when it is not needed. */
@@ -245,7 +246,8 @@ static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
 	unsigned int aux_scan_mode = scan_mode >> 16;
 
 	/* UltraScale has only one ADC and supports only continuous mode */
-	if (xadc->ops->type == XADC_TYPE_US)
+	if (xadc->ops->type == XADC_TYPE_US ||
+	    xadc->ops->type == XADC_TYPE_US_I2C)
 		return XADC_CONF1_SEQ_CONTINUOUS;
 
 	if (xadc->external_mux_mode == XADC_EXTERNAL_MUX_DUAL)
@@ -346,6 +348,9 @@ int xadc_read_samplerate(struct xadc *xadc)
 	uint16_t val16;
 	int ret;
 
+	if (!xadc->ops->get_dclk_rate)
+		return -EOPNOTSUPP;
+
 	ret = xadc_read_adc_reg(xadc, XADC_REG_CONF2, &val16);
 	if (ret)
 		return ret;
@@ -457,9 +462,14 @@ EXPORT_SYMBOL_GPL(xadc_setup_buffer_and_triggers);
 
 int xadc_write_samplerate(struct xadc *xadc, int val)
 {
-	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
+	unsigned long clk_rate;
 	unsigned int div;
 
+	if (!xadc->ops->get_dclk_rate)
+		return -EOPNOTSUPP;
+
+	clk_rate = xadc_get_dclk_rate(xadc);
+
 	if (!clk_rate)
 		return -EINVAL;
 
@@ -653,6 +663,11 @@ static const struct iio_info xadc_info = {
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
@@ -765,6 +780,7 @@ EXPORT_SYMBOL_GPL(xadc_parse_dt);
 const char * const xadc_type_names[] = {
 	[XADC_TYPE_S7] = "xadc",
 	[XADC_TYPE_US] = "xilinx-system-monitor",
+	[XADC_TYPE_US_I2C] = "xilinx-system-monitor",
 };
 
 struct iio_dev *xadc_device_setup(struct device *dev, int size,
@@ -781,7 +797,11 @@ struct iio_dev *xadc_device_setup(struct device *dev, int size,
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
index 000000000000..3d802b907260
--- /dev/null
+++ b/drivers/iio/adc/xilinx-xadc-i2c.c
@@ -0,0 +1,215 @@
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
+#include <linux/kernel.h>
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
+	write_buffer[0] = FIELD_GET(XADC_I2C_DRP_DATA0_MASK, val);
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
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(xadc->threshold); i++) {
+		ret = xadc_i2c_read_transaction(xadc, XADC_REG_THRESHOLD(i),
+						&xadc->threshold[i]);
+		if (ret)
+			return ret;
+	}
+
+	ret = xadc_i2c_write_transaction(xadc, XADC_REG_CONF0, xadc_i2c->conf0);
+	if (ret)
+		return ret;
+
+	ret = xadc_i2c_write_transaction(xadc, XADC_REG_INPUT_MODE(0),
+					 xadc_i2c->bipolar_mask);
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
+	mutex_init(&xadc->mutex);
+	spin_lock_init(&xadc->lock);
+
+	ret = xadc_device_configure(dev, indio_dev, 0, &conf0, &bipolar_mask);
+	if (ret) {
+		dev_err(dev, "Failed to setup the device: %d\n", ret);
+		return ret;
+	}
+
+	i2c_set_clientdata(client, indio_dev);
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
+	{ }
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
index feec8ef76e4f..d0c64b5f55f1 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -72,6 +72,7 @@ struct xadc {
 enum xadc_type {
 	XADC_TYPE_S7, /* Series 7 */
 	XADC_TYPE_US, /* UltraScale and UltraScale+ */
+	XADC_TYPE_US_I2C, /* UltraScale+ I2C interface */
 };
 
 struct xadc_ops {
-- 
2.25.1

