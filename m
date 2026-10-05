Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E698544780F;
	Mon,  5 Oct 2026 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193372; cv=fail; b=RL1IirxECQWrJNs9gghWdNI+QTbe9oMjz4cFQijT39u0W1jWkIzOA7+V/3pPU54FXswPrUF+KeXyAPQEGlh/JXMi8X9v6pKmQUjUL2sF/jDDhC8Paelz9fkwSDXtwyaaEEqGfxLgQ2wbk+QIC+2q63d95yBZtzGQPxLnuHNGRQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193372; c=relaxed/simple;
	bh=kHk9f8OCYsFvXcYfHP1EUAlU6QjtlOLrAPspqN2wRZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCLH/iwaRexrl889Me2rlh0WsIljNSkYj042yCImMv0nQH/8t8M3QBhym6X1w3EMrvr7RPC/CPKF0dDXOKMcfsqmeRo2w0aJhmDIaXeLzhqFKdxw+lHtKWqf6sM181hipFMYSGqWmhrvJDwzs34XUR7W5/xrkolEyHPGfu+ZmKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gX0lY88X; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gX0lY88X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEPCyHhQRxalaWMIxNFTiak+67DmXL6+alUNAKOM3QIhSwx4Gby05u1TWIK7TTG7Sqo5Rby0X6FZ8NsNvE75WbnYMhOHn/FcidJmfXmmqCp8qd8Mhb1KjMf5PVzC6ySPzoRHBzHInyPzpHpaeZfj/bk9w24zCi7KCDuwQL+tx0Edm5blmyDjKpyqdH6bPRUsiFIbxhzh3PpnqSr93N07NmGHVR+rwiWfKkz+7vMsxvV13TvWtKNr9897+eo4VVB2mAPa+TFV3vBURWVixFy8DkqqoUUMTSeP4G9c2xfmNXz0R/JjLWcjvZqNEyCweisMUctHb3Q6HL8DtEfUYqvxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hhQiCWBWFhEx976/108WTafpbQsS45V+pMlk4OKp6k=;
 b=LON5c+HaCN9Boxh6vFCBEkyY1Kk6yDvW3XK20gq5dmKQKC5XHFNFli5lrclUWszB3hT4yxssfP8xYUQzrk9pZloYYaSgr/F4HEq6BxuqJ7EKzsNQXscDtiC27WY1+10E9hlrAE1io3hWGsfeBJdhIr06bEZgRC3n0rHIDmg0Ki7mj3mXypj6hbKfKvl0W6e5vbbRx2M1sMQVOv69aKl52LLADWndMCAzvMokyImsDrO+uNIq/MWsNVNZbZOU97pFkI/fYfcHY0Yk6guliBb9al34xB3tmhck6Hx0ZKPtm2txWFzgBxzGRCsS9bOl3QpbsW6vbXTFBwl61Rlpg9SHVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hhQiCWBWFhEx976/108WTafpbQsS45V+pMlk4OKp6k=;
 b=gX0lY88XOU+1tcgR6wWDXMAjDOr/kKFRzPjucVV2q+jcSagYsb0+fvdxXyAnBfXDMXQzpOyTbBYSomZRvCJhI2g/2pD+M4tPNancjSZSOjKhkBjbLLww+0QiQGlPajp2hsbodPwuZ1ZSa9y5mdC6XXitb+9vi+X3lQuAMYIIl1Y=
Received: from BN9PR03CA0215.namprd03.prod.outlook.com (2603:10b6:408:f8::10)
 by IA1PR12MB9467.namprd12.prod.outlook.com (2603:10b6:208:594::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 5 Oct
 2026 09:42:37 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::13) by BN9PR03CA0215.outlook.office365.com
 (2603:10b6:408:f8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 09:42:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 09:42:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:42:34 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 04:42:26 -0500
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v4 04/15] iio: adc: xilinx-xadc: Drop unnecessary masking and dead code
Date: Mon, 5 Oct 2026 15:11:54 +0530
Message-ID: <20261005094205.1045874-5-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|IA1PR12MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0d8d94-81ef-41b7-73e2-08df22c4fdd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	7Z6cLJI8Iv1HZGmYu9fhhZil22ZUAzzU9EIHLPmGV8xpc+UpGQD2rV5lFdyXc/O/uKPW2oYFiOOcz/0NVlfX0ZG3hzJNMWQDl5VhZ6xP6F7qITuk2FhzdvVGd0cQdmyFf9YFExtYlPRCRv0wd7K9Dz4i52wgBVEK6D94VWnym+Ca+eWgJ2Yn4+/n5OVccLBn5HdJ2h5cyAuQly8pCXKMSqCxfWYLuXZVdJTx9F8ZoIcFub/I4yIBJGcO4dRQY60Vv8V0TNPcIkM10bscsWi+Q9csxCmUhnqTgW7n9gL1P38ojA2te2lNze8w45rdpvlR68hli75/XNYYy43jOxS1xws2wwyEQ425IkpJQn18YSZVhoOWed0rpEZgKxnPKWmjykL5BnT4ml6DXc+G2z6FqLvEx2JJqvaWJ5wsmMBg1bfF2t9aDnNweJIJvOFx8awuUtR+jkFqpfk2AjNGylScmoYihsudYjBQMmNJ+Pn2B9Mgse3lBN+QaOXYHh3iKbDhUJA6eUYquhlITUtXQoXbKOPdrPfI0z4AYuBFCn7+HMMgfvUtT3B86kGa7iamjKvbmgxd5C4XE4ofKvKtqlvoualPSABpCPHlDDSdxKGwu44O4eEm4nh1gP9DeSLFy6nQuOpst5rjYlwuON8LPYLVBvlB8rjjDhC44dJCl6VRp3QSL5UDJtW2ifwUW28+ZOEsWE08+OS4ZRJBUx1PonEUXQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	agDbBglYMiGm++W9+8DIM1vsC5dRhRN51fUVw8kFBIdOl5a2nA6aixL6JzPBW+oBNqQB5FCnmb0R7fTJxvVpkSWlIkEHLEzRr4EOSyIRrRqYKn59VSOM/Nri1ZmnuQToqG1JVX39NmQux/AL2LauYc5AG8l+YCf7WJeBHrrC9VMsYpLqV+Tvt5eYxhunExkqvBRUHnx2+TDzemD7XFash/1l3q4YU3L0ZgfSmlNBLaw/3W44LrqdmgnO90CYeI5nQu740wSHJwzAM2XwI/QtXBGhRCwwbs7+YEKCl1iw6uBq5zz1mPTjIigqaWlO1O2Yb8N/CftaXvgXhoCL/OSz//8KR6Gsm4oY26EUL29Gp2HVDiLx/i8zTQ6BHo+7gEJIll9eWu/qIMA3x7zIp+zpou6Q23/JeC0u7+VDTGDM5vxawYWhItUU5M2s6RQMI8EJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:42:37.7026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0d8d94-81ef-41b7-73e2-08df22c4fdd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9467

Remove a no-operation bitwise-OR with zero (dead code) and the redundant
16-bit masking when storing values into u16 destinations, where the
mask has no effect. Also remove the unused macros.

No functional change intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 24 ++--------------------
 drivers/iio/adc/xilinx-xadc.h      | 33 ------------------------------
 2 files changed, 2 insertions(+), 55 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 1c60d4f38ffe..b4a3e6f967c4 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -47,35 +47,20 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
 #define XADC_ZYNQ_REG_CTL		0x18
 
 #define XADC_ZYNQ_CFG_ENABLE		BIT(31)
-#define XADC_ZYNQ_CFG_CFIFOTH_MASK	(0xf << 20)
-#define XADC_ZYNQ_CFG_CFIFOTH_OFFSET	20
 #define XADC_ZYNQ_CFG_DFIFOTH_MASK	(0xf << 16)
 #define XADC_ZYNQ_CFG_DFIFOTH_OFFSET	16
-#define XADC_ZYNQ_CFG_WEDGE		BIT(13)
 #define XADC_ZYNQ_CFG_REDGE		BIT(12)
 #define XADC_ZYNQ_CFG_TCKRATE_MASK	(0x3 << 8)
 #define XADC_ZYNQ_CFG_TCKRATE_DIV2	(0x0 << 8)
 #define XADC_ZYNQ_CFG_TCKRATE_DIV4	(0x1 << 8)
 #define XADC_ZYNQ_CFG_TCKRATE_DIV8	(0x2 << 8)
 #define XADC_ZYNQ_CFG_TCKRATE_DIV16	(0x3 << 8)
-#define XADC_ZYNQ_CFG_IGAP_MASK		0x1f
 #define XADC_ZYNQ_CFG_IGAP(x)		(x)
 
-#define XADC_ZYNQ_INT_CFIFO_LTH		BIT(9)
 #define XADC_ZYNQ_INT_DFIFO_GTH		BIT(8)
 #define XADC_ZYNQ_INT_ALARM_MASK	0xff
-#define XADC_ZYNQ_INT_ALARM_OFFSET	0
 
-#define XADC_ZYNQ_STATUS_CFIFO_LVL_MASK	(0xf << 16)
-#define XADC_ZYNQ_STATUS_CFIFO_LVL_OFFSET	16
-#define XADC_ZYNQ_STATUS_DFIFO_LVL_MASK	(0xf << 12)
-#define XADC_ZYNQ_STATUS_DFIFO_LVL_OFFSET	12
-#define XADC_ZYNQ_STATUS_CFIFOF		BIT(11)
-#define XADC_ZYNQ_STATUS_CFIFOE		BIT(10)
-#define XADC_ZYNQ_STATUS_DFIFOF		BIT(9)
 #define XADC_ZYNQ_STATUS_DFIFOE		BIT(8)
-#define XADC_ZYNQ_STATUS_OT		BIT(7)
-#define XADC_ZYNQ_STATUS_ALM(x)		BIT(x)
 
 #define XADC_ZYNQ_CTL_RESET		BIT(4)
 
@@ -87,10 +72,6 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
 
 /* AXI register definitions */
 #define XADC_AXI_REG_RESET		0x00
-#define XADC_AXI_REG_STATUS		0x04
-#define XADC_AXI_REG_ALARM_STATUS	0x08
-#define XADC_AXI_REG_CONVST		0x0c
-#define XADC_AXI_REG_XADC_RESET		0x10
 #define XADC_AXI_REG_GIER		0x5c
 #define XADC_AXI_REG_IPISR		0x60
 #define XADC_AXI_REG_IPIER		0x68
@@ -182,7 +163,6 @@ static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
 	xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
 	tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
-	tmp |= 0 << XADC_ZYNQ_CFG_DFIFOTH_OFFSET;
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
 
 	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
@@ -230,7 +210,7 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &resp);
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &resp);
 
-	*val = resp & 0xffff;
+	*val = resp;
 
 	return 0;
 }
@@ -452,7 +432,7 @@ static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 	u32 val32;
 
 	xadc_read_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4, &val32);
-	*val = val32 & 0xffff;
+	*val = val32;
 
 	return 0;
 }
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index fb911ed87600..8449fb741370 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -130,21 +130,6 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 va
 #define XADC_REG_VCCO_DDR	0x0f
 #define XADC_REG_VAUX(x)	(0x10 + (x))
 
-#define XADC_REG_MAX_TEMP	0x20
-#define XADC_REG_MAX_VCCINT	0x21
-#define XADC_REG_MAX_VCCAUX	0x22
-#define XADC_REG_MAX_VCCBRAM	0x23
-#define XADC_REG_MIN_TEMP	0x24
-#define XADC_REG_MIN_VCCINT	0x25
-#define XADC_REG_MIN_VCCAUX	0x26
-#define XADC_REG_MIN_VCCBRAM	0x27
-#define XADC_REG_MAX_VCCPINT	0x28
-#define XADC_REG_MAX_VCCPAUX	0x29
-#define XADC_REG_MAX_VCCO_DDR	0x2a
-#define XADC_REG_MIN_VCCPINT	0x2c
-#define XADC_REG_MIN_VCCPAUX	0x2d
-#define XADC_REG_MIN_VCCO_DDR	0x2e
-
 #define XADC_REG_CONF0		0x40
 #define XADC_REG_CONF1		0x41
 #define XADC_REG_CONF2		0x42
@@ -152,18 +137,13 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 va
 #define XADC_REG_INPUT_MODE(x)	(0x4c + (x))
 #define XADC_REG_THRESHOLD(x)	(0x50 + (x))
 
-#define XADC_REG_FLAG		0x3f
-
 #define XADC_CONF0_EC			BIT(9)
-#define XADC_CONF0_ACQ			BIT(8)
 #define XADC_CONF0_MUX			BIT(11)
 #define XADC_CONF0_CHAN(x)		(x)
 
 #define XADC_CONF1_SEQ_MASK		(0xf << 12)
 #define XADC_CONF1_SEQ_DEFAULT		(0 << 12)
-#define XADC_CONF1_SEQ_SINGLE_PASS	(1 << 12)
 #define XADC_CONF1_SEQ_CONTINUOUS	(2 << 12)
-#define XADC_CONF1_SEQ_SINGLE_CHANNEL	(3 << 12)
 #define XADC_CONF1_SEQ_SIMULTANEOUS	(4 << 12)
 #define XADC_CONF1_SEQ_INDEPENDENT	(8 << 12)
 #define XADC_CONF1_ALARM_MASK		0x0f0f
@@ -176,7 +156,6 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 va
 #define XADC_CONF2_PD_ADC_B	(0x2 << 4)
 #define XADC_CONF2_PD_BOTH	(0x3 << 4)
 
-#define XADC_ALARM_TEMP_MASK		BIT(0)
 #define XADC_ALARM_VCCINT_MASK		BIT(1)
 #define XADC_ALARM_VCCAUX_MASK		BIT(2)
 #define XADC_ALARM_OT_MASK		BIT(3)
@@ -189,17 +168,5 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 va
 #define XADC_THRESHOLD_VCCINT_MAX	0x1
 #define XADC_THRESHOLD_VCCAUX_MAX	0x2
 #define XADC_THRESHOLD_OT_MAX		0x3
-#define XADC_THRESHOLD_TEMP_MIN		0x4
-#define XADC_THRESHOLD_VCCINT_MIN	0x5
-#define XADC_THRESHOLD_VCCAUX_MIN	0x6
-#define XADC_THRESHOLD_OT_MIN		0x7
-#define XADC_THRESHOLD_VCCBRAM_MAX	0x8
-#define XADC_THRESHOLD_VCCPINT_MAX	0x9
-#define XADC_THRESHOLD_VCCPAUX_MAX	0xa
-#define XADC_THRESHOLD_VCCODDR_MAX	0xb
-#define XADC_THRESHOLD_VCCBRAM_MIN	0xc
-#define XADC_THRESHOLD_VCCPINT_MIN	0xd
-#define XADC_THRESHOLD_VCCPAUX_MIN	0xe
-#define XADC_THRESHOLD_VCCODDR_MIN	0xf
 
 #endif
-- 
2.34.1

