Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010045.outbound.protection.outlook.com [40.93.198.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D8837F8CB;
	Mon,  5 Oct 2026 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193375; cv=fail; b=mq5dFiyNRaSnpqhImDqSXv7UydJia8If+aTYD/DrAvxbQNhIJNiUPxII3j4pQ9ZsRsDFVdv2f4t1atssiO5F2nc+DDnzoZUcmKGB9EnISEUn0ea7lCH7hUxvK+T6t6aKVmg3fV7vXUU4vxOhsfVGKziR3hcD9Zr3ApGZwLMzywE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193375; c=relaxed/simple;
	bh=JZ63G1Q4UJ1Q7BEgYPm6L0lpTzxjJEqHcojWxB5XUJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OyTRjQ6GmlxXDdkjltELDmCCE33N7HybZzdRphhd7tY07s5HHP/p0jhIO8kCvJUVLc/Sac1a290k8BoeCClhSxHMr/6lIRu6KAs5A4d+BUbYky+oxbR5VAObQGuziXxSArRXEbub23St99Q10ELcv2hfWsiHDea57knUnUw2x/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EPmR8fcu; arc=fail smtp.client-ip=40.93.198.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EPmR8fcu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iO+TVy5XU7vaoepQhG5wE698zoW1E1sig61jh149jnW5KOwXWfMb8P3/VgoFf46scI3JiQVLShFUOgg3IjzhPFQH6ajG3z+pOQkOfyYxQLcsgLaK2JNnWuNoIISths2eFWYjrWR2opMaJZm/wwdEhbTbA9Y375IEe+UyaP0HFpBI8oB+8NvQK43EH+nhG97M6UtuKfsPgH5MpAChdQYB2A2ks46lLRq9LhUSZ4+bqIXlqsOzG35dQ3/81ukI0+UkcWu450tVHeiMXgezP/2a7pybHGOMjrdlWvAAKXIkGrPibqn/h2HwIslxwAcfumjeEVkkdgqFyTxwNPi4gfeNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUTUt6lyWcSS9lD2gN/SWjIBAzuOAwO2z1OcM7EVgCQ=;
 b=eNhUw1sUymJLcswz8OlshLJnL+yaBnZ2eNAAYKNUo6ehbqcywDdogGQGG+js08UPJDTJVLcuswpLKIQJWO6Cd49oWI4QEa0EQftQ8K2zlmuwF+RkEHnyFwb2DGWfL70zsw3fd6wtxJE06TmRDccnm0YUrFO+6n0859yFsJKsd+H/aC6bkngF8Pxy6TonziQJbgUp9gvjnLQ0GBmavMnWDBTltKafQal3rUU3BfJlTrrIKCbVpj7+RvPtD9Prm5BBNbOjXVmnVTXhayM6IkxVpdPWOkQekJlAq2884Iug8of2H9yqx0nR5PGs7oQvYCfFzR6OySmGXZSeE63cw9nMpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUTUt6lyWcSS9lD2gN/SWjIBAzuOAwO2z1OcM7EVgCQ=;
 b=EPmR8fcub4Azm9g83nfrf3rNqS4gGb/RfHRoen/vW8Q37LxVvJ32fah+/70VZcjoKlGxthUdim6fjmKn9PSQADZwu25fb3bH5iXueyIG5hBOZWEvS6KnyJbyITd+JrLniBa5zE7ICWw28ubDeHzfaJDz7rfOdWTVrgKu7j1NcJU=
Received: from BN9PR03CA0081.namprd03.prod.outlook.com (2603:10b6:408:fc::26)
 by SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 09:42:39 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::17) by BN9PR03CA0081.outlook.office365.com
 (2603:10b6:408:fc::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 09:42:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 09:42:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:42:38 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:42:37 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 04:42:34 -0500
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v4 05/15] iio: adc: xilinx-xadc: Use bitfield helpers and bit macros
Date: Mon, 5 Oct 2026 15:11:55 +0530
Message-ID: <20261005094205.1045874-6-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|SN7PR12MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 68002387-73a2-4ef1-1c83-08df22c4fec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	rfnb+gjtksM44Yv5IswnkWYVQfsv29A6fFaeZxSuRKuevavD8ry67WXB0qRXIXkKB6jyBfEj/RJ1RQ717bDC2P6SrXT5mZCmsy2gtl9uuWF5gP/wt0zJpuiaLh2qsxKjLXB5FYeHXIvRoGjIeyoYCsW8BcpvAFzCJbEEDN4Xr2qTPWT9ekRAO4KOI3R+ACvtYtatQLEl0KWrAT69VqnJfJGz/G+0luEa/nqsz7EddUE4xVoKZ7UsuA9htZvrdVYqlws/cNchMJQ8MRWlWWi5XluagX8FpQfixbycP2SxnE6VUfZohUVgH0oOLfxW/sjCkzehrAgrJW//zNAWVOLM86ZjfKl5WnCgMJBvB/6FsjXhAp+1z5GF1FtCj6N1zCw039hu8wMdPCrQIf2+f133O1UD5crzxQqe/x9nnUIo+vwgiea9E7gseHP9qsvJtu0KVy95d8maEvpvs2dfxLQNNn4VcUOMaJs00PYTvWOmAFJeZ+EmPXlrGfOugCoYk4SjeCRBiE6On5lqB515FxZLIo3Dds4VLMpMrF/ZWPDPJrVD7v/tb14zwbCt/SLAAp1tBgpmEcWFg93tLv9UF5RU3aWQcamKcNWquEUIhFswFkzXqdINpoHKtRKttjb/w9UzT8qd9/+kRFBbIJfoBqOLxarD6BOEk4sKo8eG/uenIaIe1ZkIZzrCdmBmq6ZdHhwjANLSQPe0pr/JPdi4Txia5Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7v2EyKnd/jLL9f+MKFccrhRe00ESjEPunYXYQ9XDtYZRsgOWfO3BUByUHrdVdctvfYnyuRqnA3ZHOM2KMu9HFU68NrCKfehzBEYj0zWP+zlO5cst34jnLGEHdzaaPIWJ+OUp62OnLKk0xMM2orutA0DuOoB0zIAOyDG4S5NNYs472mnspTXMHumxBpfA6+NxxdcI/IhiRVq9HXiv8uND4qhRrIQOn0c0P/lZP5UHDLTxy0b2wfuJHBZu1+zXXzy3rSt8ovX9OUzB7I/pSjFzV9pioswOXvr06xFeMIIOr74gEXYoNhVsa040/O0bGIDV+w/Wz75bimtB0atBVDqj36CwXntDFyqIE0wggKCu+RKpc4YMKcu8MgIna+Ejrlv7FjgvOKTp5ePuoEJnP38bmjj87ULzJRcvav5aS9+qg8Jo9CCBoKjpqCIFtR9/bLCC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:42:39.2853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68002387-73a2-4ef1-1c83-08df22c4fec7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203

Replace open-coded bit manipulation with FIELD_GET(),
FIELD_PREP(), BIT(), and GENMASK() helpers.

Using the kernel bitfield helpers improves readability and
makes bit operations less error-prone.

No functional changes intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 25 +++++++++++++------------
 drivers/iio/adc/xilinx-xadc.h      | 24 ++++++++++++------------
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index b4a3e6f967c4..9e4955016bbc 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -11,6 +11,8 @@
  *  - AXI XADC interface: Xilinx PG019
  */
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -47,18 +49,17 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
 #define XADC_ZYNQ_REG_CTL		0x18
 
 #define XADC_ZYNQ_CFG_ENABLE		BIT(31)
-#define XADC_ZYNQ_CFG_DFIFOTH_MASK	(0xf << 16)
-#define XADC_ZYNQ_CFG_DFIFOTH_OFFSET	16
 #define XADC_ZYNQ_CFG_REDGE		BIT(12)
-#define XADC_ZYNQ_CFG_TCKRATE_MASK	(0x3 << 8)
-#define XADC_ZYNQ_CFG_TCKRATE_DIV2	(0x0 << 8)
-#define XADC_ZYNQ_CFG_TCKRATE_DIV4	(0x1 << 8)
-#define XADC_ZYNQ_CFG_TCKRATE_DIV8	(0x2 << 8)
-#define XADC_ZYNQ_CFG_TCKRATE_DIV16	(0x3 << 8)
+#define XADC_ZYNQ_CFG_DFIFOTH_MASK	GENMASK(19, 16)
+#define XADC_ZYNQ_CFG_TCKRATE_MASK	GENMASK(9, 8)
+#define XADC_ZYNQ_CFG_TCKRATE_DIV2	0
+#define XADC_ZYNQ_CFG_TCKRATE_DIV4	BIT(8)
+#define XADC_ZYNQ_CFG_TCKRATE_DIV8	BIT(9)
+#define XADC_ZYNQ_CFG_TCKRATE_DIV16	GENMASK(9, 8)
 #define XADC_ZYNQ_CFG_IGAP(x)		(x)
 
 #define XADC_ZYNQ_INT_DFIFO_GTH		BIT(8)
-#define XADC_ZYNQ_INT_ALARM_MASK	0xff
+#define XADC_ZYNQ_INT_ALARM_MASK	GENMASK(7, 0)
 
 #define XADC_ZYNQ_STATUS_DFIFOE		BIT(8)
 
@@ -86,7 +87,7 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
 #define XADC_AXI_GIER_ENABLE		BIT(31)
 
 #define XADC_AXI_INT_EOS		BIT(4)
-#define XADC_AXI_INT_ALARM_MASK		0x3c0f
+#define XADC_AXI_INT_ALARM_MASK		(GENMASK(13, 10) | GENMASK(3, 0))
 
 #define XADC_FLAGS_BUFFERED BIT(0)
 #define XADC_FLAGS_IRQ_OPTIONAL BIT(1)
@@ -196,7 +197,7 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 	xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
 	tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
-	tmp |= 1 << XADC_ZYNQ_CFG_DFIFOTH_OFFSET;
+	tmp |= FIELD_PREP(XADC_ZYNQ_CFG_DFIFOTH_MASK, 1);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
 
 	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
@@ -857,7 +858,7 @@ static int xadc_read_samplerate(struct xadc *xadc)
 	if (ret)
 		return ret;
 
-	div = (val16 & XADC_CONF2_DIV_MASK) >> XADC_CONF2_DIV_OFFSET;
+	div = FIELD_GET(XADC_CONF2_DIV_MASK, val16);
 	if (div < 2)
 		div = 2;
 
@@ -965,7 +966,7 @@ static int xadc_write_samplerate(struct xadc *xadc, int val)
 		div = 0xff;
 
 	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_DIV_MASK,
-				   div << XADC_CONF2_DIV_OFFSET);
+				   FIELD_PREP(XADC_CONF2_DIV_MASK, div));
 }
 
 static int xadc_write_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 8449fb741370..a659b7981b2f 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -9,6 +9,7 @@
 #ifndef __IIO_XILINX_XADC__
 #define __IIO_XILINX_XADC__
 
+#include <linux/bits.h>
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
@@ -141,20 +142,19 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 va
 #define XADC_CONF0_MUX			BIT(11)
 #define XADC_CONF0_CHAN(x)		(x)
 
-#define XADC_CONF1_SEQ_MASK		(0xf << 12)
-#define XADC_CONF1_SEQ_DEFAULT		(0 << 12)
-#define XADC_CONF1_SEQ_CONTINUOUS	(2 << 12)
-#define XADC_CONF1_SEQ_SIMULTANEOUS	(4 << 12)
-#define XADC_CONF1_SEQ_INDEPENDENT	(8 << 12)
-#define XADC_CONF1_ALARM_MASK		0x0f0f
+#define XADC_CONF1_SEQ_MASK		GENMASK(15, 12)
+#define XADC_CONF1_SEQ_DEFAULT		0
+#define XADC_CONF1_SEQ_CONTINUOUS	BIT(13)
+#define XADC_CONF1_SEQ_SIMULTANEOUS	BIT(14)
+#define XADC_CONF1_SEQ_INDEPENDENT	BIT(15)
+#define XADC_CONF1_ALARM_MASK		(GENMASK(11, 8) | GENMASK(3, 0))
 
-#define XADC_CONF2_DIV_MASK	0xff00
-#define XADC_CONF2_DIV_OFFSET	8
+#define XADC_CONF2_DIV_MASK	GENMASK(15, 8)
 
-#define XADC_CONF2_PD_MASK	(0x3 << 4)
-#define XADC_CONF2_PD_NONE	(0x0 << 4)
-#define XADC_CONF2_PD_ADC_B	(0x2 << 4)
-#define XADC_CONF2_PD_BOTH	(0x3 << 4)
+#define XADC_CONF2_PD_MASK	GENMASK(5, 4)
+#define XADC_CONF2_PD_NONE	0
+#define XADC_CONF2_PD_ADC_B	BIT(5)
+#define XADC_CONF2_PD_BOTH	GENMASK(5, 4)
 
 #define XADC_ALARM_VCCINT_MASK		BIT(1)
 #define XADC_ALARM_VCCAUX_MASK		BIT(2)
-- 
2.34.1

