Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF032D0D3;
	Fri, 20 Feb 2026 05:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771566028; cv=fail; b=ZIy58ndB1WWyUiWTc46nBxHIrrityhCqyqD1G18MsZ5wPEcBC15Vj7OExs5IKBzTmL2H3qMkJ2Et7v3QT4RaY+V90jkkU17T1N5+8eLSD4ejzfajxmgrZAUcLa8lymM+qflJJLApb+ETRzaA4XFxP/wgJr2aBFwBpiGcwyZt7pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771566028; c=relaxed/simple;
	bh=Yu7H5uMarO24ymSrOHoP/WJmMnbCKCre8DmfnEQvnZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eorim+dMD8I7UKo2ZWiyEeUrorbPDTl8b/6rJSnUzi4LnDnHUtK9pk7v7yY1VfIXzOwk6jimWS68L7AC/xqxhxYBxCA5gFpz4Et3HMPOyDaaK9+8CQuZUYPyxYjZGbJwhGbox5/y2R1PKsRjOq43IuoVJ3HZLvDVbJvJKILmnMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1OEojAx6; arc=fail smtp.client-ip=52.101.53.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1OEojAx6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNkhCpDETzuGRdNvOHg6PbPprojbZhBSLVauSlZ7Ea/vJsuwf1n44kGn8WTQqihJrO81mnwqo8owrKx1RJ6bFhbym5+ueOrZkGDhs2y5dT2mE2qmTlxV3NiAjTKPgZgPqH7NWu61tbYZ7S2R4qe2Ajh7Na8zv6s4DBeCwCnr+LcmsrCerj6y7wH81wdXw0ZLCevgN2VeHkIXscTAIfUl3TisBBBf8yJ2Tyv+4us+a/6fqCdWEYmfLHHYI2fEE5C6UwZH91GP/AwfAHR86YG6IJsI1RFtn8L0sBxsgEDsdiwcAzTAO+UPQzIJMFUaBcFlsuZ19ILp3r4k7uY6L0mjAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16n7rLPsf5SBpnKwDfscPTMDLaU5KgwinF5/WYRRjbY=;
 b=VAQCPdWnwh/qpQuRFdKcNUhMpNmZCxYcepLmmdXF7Bt1Aleogv6iRmHmAJz00KK9pu++8ixLPuCptithfU1vXkxeJJ30ZXe7hc6Fnm4c5jF+4P7504zGlMf37ywTl2TS/63HAdymmsuT94x0yQ9NZ2boUlbZOs9T6uWl01QF5G0mq/FZouqdZqCnv4KnV5Sp3c0b6CdshW3j5qprAoEnVhVBmANIYtuWsto0dImIeIm70hTc7pZZ8N1eclu3tafXfEe639OLpWiWkSEJGxOH8fQaSgT4X8VkrHa/qK89eNNunoKUnP/JpLB/7FjaQBSEHGPp0gGPMbJCP1CM8dSQtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16n7rLPsf5SBpnKwDfscPTMDLaU5KgwinF5/WYRRjbY=;
 b=1OEojAx6ldUFStAS0MNrDoRmUMY5ij8PhC+YZD1+PvdSTG+mMwy83Sjv3EaEiLZutMi6EnlXXb08qCD9SgAM/tGb7jOaOWLAUfc+JUIig7b7hOg6RtfTvTSkS/jPmmyh+m7wD/rDg+eSfuGVrlqMYmHsQ4pm5FVzmdVGV5BFG60=
Received: from PH1PEPF000132EC.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::31)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 05:40:19 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2a01:111:f403:c902::13) by PH1PEPF000132EC.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 05:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Fri, 20 Feb 2026 05:40:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 23:40:15 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 23:40:14 -0600
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Feb 2026 23:40:11 -0600
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
Subject: [PATCH 4/5] iio: adc: xilinx-xadc: Add I2C interface support
Date: Fri, 20 Feb 2026 11:09:40 +0530
Message-ID: <20260220053941.611415-5-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
References: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: f7200a68-352a-4ad3-c78c-08de70428860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OFw3xFd61XtpcF7HEdN6lGWStqVoL2AuJcMwPwzLT6IlYUmdCVI9DDHqzing?=
 =?us-ascii?Q?63NKJ/Y9Vwd7wDlsA4YRShznFxM8OiFxvQhKqMy/eNqixQfFi0wa3QOSc9YN?=
 =?us-ascii?Q?pHu67tobUXKz3Zs7S5OHw1IMzk/O8xhSmZrXC/rozvNsdpmmutNg+G7V2ftI?=
 =?us-ascii?Q?ZnG4nITl4eBYwwbn+wyxuZPuHfUTOKYbcOrSpon8KuR94RhTq35nfoO74/q3?=
 =?us-ascii?Q?Q4JUEFYJ1XjDOuxMfPcvNFoDr6BwBDeZBVc8Jqy51bRv/L1zOAoyXQm3CR/V?=
 =?us-ascii?Q?Wkxrig3VmOjFPS4MnNKErVb1VVBB1r0+g/4TBuRQNvATwEKDMqUMAgSx3ezr?=
 =?us-ascii?Q?CwcTri2EU1qL/wRZxLjnux85roqFR02RiNGxsPhuOP/Dt5IqPYBLghTnRgC6?=
 =?us-ascii?Q?QHe2VPxy7gCJakbgBDEJnsEO9iGPj8f2RmAuFu+R7QJj3dw/oDO/szNM7lSI?=
 =?us-ascii?Q?PS+rcR5wHI+jDwWK8ACB7KKdlwkGIS+Qr8h/KiAxaFx4v8K4RrfyjZxae7f6?=
 =?us-ascii?Q?SQSE8PSQ9LT3RwrLMJTfsi+WiurscGgRNWiFJH8Ytxf+ZiQlCYplGv5KkDEh?=
 =?us-ascii?Q?y1WjR2cS9Kw5DMz79h2MoG3lrod9U8MT8PTWqxX04spLPjKMeInSlfTeyA+m?=
 =?us-ascii?Q?3A+pPRAVc/Q/KLrAGogxd6KiWXYXZp2P1vJHc8+Ab7+qg3UbuJxydWY0dX0c?=
 =?us-ascii?Q?3wrWlKROSAlb36C/B//H0B44O7bCtVPMsmsNbKYZ+xrYeewMbP4ryum3S6xe?=
 =?us-ascii?Q?S3cyKzbgYjgmVJiZfDBJwkIsC+dmf8MU3UhpF5tTofCdPeXP3a/CtKRVWPpY?=
 =?us-ascii?Q?Ttpu+DXyeAYBT3vIYff8pJyKzuha+FiBc/lJn2ASb99w57B5D1hsc/Q7fonK?=
 =?us-ascii?Q?oZYSOnINUOSBJCAPgJXcvex3wy2UtzyTW9DnSHySO3d6oLjBPcf3F73OLzw8?=
 =?us-ascii?Q?S/YB2k7/SfMWLbz8r5GWBffuP2e+76SCJW/tgcMdq01Qsv6svCpMlhSVPlqJ?=
 =?us-ascii?Q?l6IVRlufOcY+mc7WI6z10Ros9H644BdLwtWd3hAuTNVU0MD0rBjg1nMPJMt6?=
 =?us-ascii?Q?Y35r+F759WZwCn+bUOBUQPlJp566iw6YoY7Q4MCTly148AR3m3U2RCJhTNqi?=
 =?us-ascii?Q?uCxUqhMknC86w2QxvxM6jeiS4D4ycRdfcbCqjX6SQO8jq/U5asqG+JvnWl1/?=
 =?us-ascii?Q?8XtniUVIpeuta4+7g1vEtPHHzPtZEEMb2FczyVoMJrVD0tl+ReqlrS5xZgxL?=
 =?us-ascii?Q?jvKG8f088PL3ZNvs5oraSnWpX5zTzH2+a85YByV/RSrVFxcd6Xg9AtrI0aNK?=
 =?us-ascii?Q?9hTxnHDWHjCJf1r/Bmz8GlvB03kl8WMKhxMLhZIczA+LiXCD/oycLa3ZtrgM?=
 =?us-ascii?Q?/gIHdZyJGN5vfg308oSxGS/DawZlZMg6r1sea1trOkcKKPtzKWJS/HRpEF6m?=
 =?us-ascii?Q?gTE/zKpdhhQkPDH53xlR53pMJo0KbbC/fubpAYEyVdU53EimpPxHMv2vc7i4?=
 =?us-ascii?Q?AuD1ux3SsvOK41IGU2BIt50Jz5CGs3Fm/wfuv0G/D8u2PuGp8gWtA8PclPsV?=
 =?us-ascii?Q?aHK1y3Tmi2TKS9B9qcmosvnjQNo5pBIMTVdxJkFMSjEP87H3AqZ5WpSgJO2p?=
 =?us-ascii?Q?0Ia/VYzjK/wM1UIACFTARxmfGvQrKS7do76TMXdt5vH1+9LQ3qIG6CLNq2eS?=
 =?us-ascii?Q?CaFMZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FE+xIpk5yk4ro6VueBssYJd/aVaPF/WtjwAS4+LFM4BNeO8wrEtorahSPUEObm9FM0XTwaR4bSzPXQ5iuKiTpUrkdg75MkI3ZzL0KVFr7jc/8rltN5hNOBEV/wpEDKSpjVwOxTGoGlNbjGxI7gRndgJz40Rb6OY2EvTquejxNwUIF04SHF4e3b997dPYTqZgat3GnI548w9bGFN2UUAlmC1DotbSGzf0jqGXxJ7eLhjfBOPsaPSpjGQBdMWv/UhjVPYUZ3dw+0lz+trzFD2kNfUDgBTWP8FcscCQJtMx5htKYTs6/srBAkZegUZQtNumvJtdz7/SSeQTTyYsG1bLHcLbK71Y7ljMiuSUKDoT+CnRwvaAz8KvFszjDitmpuiAYrAy/Nnyl50fVaDkh5k/GBVcCFNHxg8Ua4j9Wn5tPY3b6Ul6zu9hdKi5wTq5OKEI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 05:40:19.0608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7200a68-352a-4ad3-c78c-08de70428860
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718

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
- Add xadc_i2c_transaction() function to handle I2C read/write operations
- Add XADC_TYPE_US_I2C type to distinguish I2C interface from AXI.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/iio/adc/Kconfig            |  11 ++
 drivers/iio/adc/xilinx-xadc-core.c | 206 ++++++++++++++++++++++++++++-
 drivers/iio/adc/xilinx-xadc.h      |   7 +
 3 files changed, 221 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 60038ae8dfc4..0c0adac151e4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1951,6 +1951,17 @@ config XILINX_XADC
 	  The driver can also be build as a module. If so, the module will be called
 	  xilinx-xadc.
 
+config XILINX_XADC_I2C
+	bool "Xilinx System Management Wizard I2C Interface support"
+	depends on XILINX_XADC && I2C
+	help
+	  Say yes here to allow accessing the System Management
+	  Wizard on UltraScale+ devices via I2C.
+
+	  This provides voltage and temperature monitoring capabilities
+	  through the same IIO sysfs interface, but using I2C communication
+	  protocol.
+
 config XILINX_AMS
 	tristate "Xilinx AMS driver"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 4ddc962e4926..7644267092ef 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -11,9 +11,12 @@
  *  - AXI XADC interface: Xilinx PG019
  */
 
+#include <linux/bits.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -35,6 +38,22 @@
 
 #include "xilinx-xadc.h"
 
+#ifdef CONFIG_XILINX_XADC_I2C
+#define XADC_I2C_READ_DATA_SIZE		2
+#define XADC_I2C_WRITE_DATA_SIZE	4	/* 32-bit DRP packet */
+#define XADC_I2C_INSTR_READ		BIT(2)
+#define XADC_I2C_INSTR_WRITE		BIT(3)
+
+#define XADC_I2C_DRP_DATA0_MASK		GENMASK(7, 0)
+#define XADC_I2C_DRP_DATA1_MASK		GENMASK(15, 8)
+#define XADC_I2C_DRP_ADDR_MASK		GENMASK(7, 0)
+
+struct xadc_i2c {
+	struct xadc xadc;
+	struct i2c_client *client;
+};
+#endif /* CONFIG_XILINX_XADC_I2C */
+
 static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq);
 
 static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
@@ -596,6 +615,108 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.temp_offset = 280231,
 };
 
+#ifdef CONFIG_XILINX_XADC_I2C
+static int xadc_i2c_transaction(struct xadc *xadc, unsigned int reg, uint16_t write_data,
+				bool is_write, uint16_t *read_data)
+{
+	struct xadc_i2c *xadc_i2c = container_of(xadc, struct xadc_i2c, xadc);
+	struct i2c_client *client = xadc_i2c->client;
+	char read_buffer[XADC_I2C_READ_DATA_SIZE];
+	char write_buffer[XADC_I2C_WRITE_DATA_SIZE] = { 0 };
+	int ret;
+
+	if (is_write) {
+		write_buffer[0] = FIELD_GET(XADC_I2C_DRP_DATA0_MASK, write_data);
+		write_buffer[1] = FIELD_GET(XADC_I2C_DRP_DATA1_MASK, write_data);
+		write_buffer[2] = FIELD_GET(XADC_I2C_DRP_ADDR_MASK, reg);
+		write_buffer[3] = XADC_I2C_INSTR_WRITE;
+	} else {
+		write_buffer[2] = FIELD_GET(XADC_I2C_DRP_ADDR_MASK, reg);
+		write_buffer[3] = XADC_I2C_INSTR_READ;
+	}
+
+	ret = i2c_master_send(client, write_buffer, XADC_I2C_WRITE_DATA_SIZE);
+	if (ret < 0)
+		return ret;
+
+	/* Read response for read operations */
+	if (!is_write) {
+		ret = i2c_master_recv(client, read_buffer, XADC_I2C_READ_DATA_SIZE);
+		if (ret < 0)
+			return ret;
+
+		*read_data = FIELD_PREP(XADC_I2C_DRP_DATA0_MASK, read_buffer[0]) |
+				FIELD_PREP(XADC_I2C_DRP_DATA1_MASK, read_buffer[1]);
+	}
+
+	return 0;
+}
+
+static int xadc_hardware_init(struct xadc *xadc)
+{
+	int ret, i;
+
+	for (i = 0; i < 16; i++) {
+		ret = xadc_i2c_transaction(xadc, XADC_REG_THRESHOLD(i), 0, false,
+					   &xadc->threshold[i]);
+		if (ret)
+			return ret;
+	}
+
+	ret = xadc_i2c_transaction(xadc, XADC_REG_CONF0, xadc->conf0, true, NULL);
+	if (ret)
+		return ret;
+
+	ret = xadc_i2c_transaction(xadc, XADC_REG_INPUT_MODE(0), xadc->bipolar_mask, true, NULL);
+	if (ret)
+		return ret;
+
+	ret = xadc_i2c_transaction(xadc, XADC_REG_INPUT_MODE(1), xadc->bipolar_mask >> 16, true,
+				   NULL);
+	if (ret)
+		return ret;
+
+	xadc->hw_initialized = true;
+
+	return 0;
+}
+
+static int xadc_i2c_read_reg(struct xadc *xadc, unsigned int reg, uint16_t *val)
+{
+	if (!xadc->hw_initialized) {
+		int ret;
+
+		ret = xadc_hardware_init(xadc);
+		if (ret)
+			return ret;
+	}
+
+	return xadc_i2c_transaction(xadc, reg, 0, false, val);
+}
+
+static int xadc_i2c_write_reg(struct xadc *xadc, unsigned int reg, uint16_t val)
+{
+	if (!xadc->hw_initialized) {
+		int ret;
+
+		ret = xadc_hardware_init(xadc);
+		if (ret)
+			return ret;
+	}
+
+	return xadc_i2c_transaction(xadc, reg, val, true, NULL);
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
+#endif /* CONFIG_XILINX_XADC_I2C */
+
 static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
 	uint16_t mask, uint16_t val)
 {
@@ -782,7 +903,8 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
 	 * non-existing ADC-B powers down the main ADC, so just return and don't
 	 * do anything.
 	 */
-	if (xadc->ops->type == XADC_TYPE_US)
+	if (xadc->ops->type == XADC_TYPE_US ||
+	    xadc->ops->type == XADC_TYPE_US_I2C)
 		return 0;
 
 	/* Powerdown the ADC-B when it is not needed. */
@@ -805,7 +927,8 @@ static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
 	unsigned int aux_scan_mode = scan_mode >> 16;
 
 	/* UltraScale has only one ADC and supports only continuous mode */
-	if (xadc->ops->type == XADC_TYPE_US)
+	if (xadc->ops->type == XADC_TYPE_US ||
+	    xadc->ops->type == XADC_TYPE_US_I2C)
 		return XADC_CONF1_SEQ_CONTINUOUS;
 
 	if (xadc->external_mux_mode == XADC_EXTERNAL_MUX_DUAL)
@@ -1306,6 +1429,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 static const char * const xadc_type_names[] = {
 	[XADC_TYPE_S7] = "xadc",
 	[XADC_TYPE_US] = "xilinx-system-monitor",
+	[XADC_TYPE_US_I2C] = "xilinx-system-monitor",
 };
 
 static void xadc_cancel_delayed_work(void *data)
@@ -1469,6 +1593,65 @@ static int xadc_probe(struct platform_device *pdev)
 	return devm_iio_device_register(dev, indio_dev);
 }
 
+#ifdef CONFIG_XILINX_XADC_I2C
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
+	indio_dev->name = xadc_type_names[xadc->ops->type];
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &xadc_info;
+
+	ret = xadc_device_configure(dev, indio_dev, 0, &conf0, &bipolar_mask);
+	if (ret) {
+		dev_err(dev, "Failed to setup the device: %d\n", ret);
+		return ret;
+	}
+
+	i2c_set_clientdata(client, indio_dev);
+	xadc->conf0 = conf0;
+	xadc->bipolar_mask = bipolar_mask;
+	xadc->hw_initialized = false;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id xadc_i2c_of_match_table[] = {
+	{
+		.compatible = "xlnx,system-management-wiz-1.3",
+		.data = &xadc_system_mgmt_wiz_i2c_ops
+	},
+	{ },
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
+#endif /* CONFIG_XILINX_XADC_I2C */
+
 static struct platform_driver xadc_driver = {
 	.probe = xadc_probe,
 	.driver = {
@@ -1479,12 +1662,29 @@ static struct platform_driver xadc_driver = {
 
 static int __init xadc_init(void)
 {
-	return platform_driver_register(&xadc_driver);
+	int ret;
+
+	ret = platform_driver_register(&xadc_driver);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_XILINX_XADC_I2C
+	ret = i2c_add_driver(&xadc_i2c_driver);
+	if (ret) {
+		platform_driver_unregister(&xadc_driver);
+		return ret;
+	}
+#endif
+
+	return 0;
 }
 module_init(xadc_init);
 
 static void __exit xadc_exit(void)
 {
+#ifdef CONFIG_XILINX_XADC_I2C
+	i2c_del_driver(&xadc_i2c_driver);
+#endif
 	platform_driver_unregister(&xadc_driver);
 }
 module_exit(xadc_exit);
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 26cd65153176..4bcafd419df2 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -63,6 +63,12 @@ struct xadc {
 	unsigned int zynq_intmask;
 	struct delayed_work zynq_unmask_work;
 
+#ifdef CONFIG_XILINX_XADC_I2C
+	bool hw_initialized;
+	unsigned int conf0;
+	unsigned int bipolar_mask;
+#endif
+
 	struct mutex mutex;
 	spinlock_t lock;
 
@@ -72,6 +78,7 @@ struct xadc {
 enum xadc_type {
 	XADC_TYPE_S7, /* Series 7 */
 	XADC_TYPE_US, /* UltraScale and UltraScale+ */
+	XADC_TYPE_US_I2C, /* UltraScale+ I2C interface */
 };
 
 struct xadc_ops {
-- 
2.25.1

