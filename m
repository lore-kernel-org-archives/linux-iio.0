Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88B232D7C7;
	Fri, 20 Feb 2026 05:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771566028; cv=fail; b=eqQR8Smj2wJ8Sap0iOAdbC2WT89a++9p0S8TdpSxmJAg8r94nD7Iov7QPbKk9YKKWlSzNqqOjMdb7xKwDWqWIcJyuiLHWF4riq7yrUo0HnF/qNnKLtdsJi2iL1peojrWpwDBrMQ0hKbwiKinPQaKBs5qpabXdt+AFxSbB/05BAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771566028; c=relaxed/simple;
	bh=cABC2NvSKeq4F9yJzwA7pAwQG6iL4uSOIMinii8PGzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4KaiO0umR0F2xut6EeTh3pp5J6zcDUepmextGQvLd6C+5LzeRnQTuG5+WzGlPL0gVbYsq9RmzAsJTjY2vvrOECGn7p0xq5G5r7Hkd7R38VR30KCbdXFlXRX1s6Xo1zJBYI5O/LRc2Msy3vUvFokPFG2rIQ5ygUTkUCPIuqEKng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j5t5oIe7; arc=fail smtp.client-ip=40.107.209.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j5t5oIe7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Df/B6BCclTKyQjLqiHeKXpTlbEe615Eq9BqhI/TMEb/KXVeb5M31RO1E8vyNV9Dz4ttpY4dth+UkuiHWZuYHj5BRHd3CiUsgyVGbMCkWQmo73W5M2BXRW0LKYPEufUe0/3+JBjffoUQCJjP5gWiHcyF0IeNuPP6edC7L0nGoKJ2I1CQSBA4jrqPM60Rg6qFWjwAeI2T6P8nIVUZrppR4g+uzgatmrNWrAH9ef/lpP5xT02PpCq5/DWaockTgtqWNkvJFV2+E4Yi5j9jaqhh8+dv3ZccBBJ3sBTrRskm0freMjO7JgsTLDGQEx4i9ki/4/DONcWYWc48DMkAYtWqqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0s3noTtF6Hni4LX6d32K+0ujpVrmcbtXakJxKqrlIo=;
 b=OCVlYKI1kqa+xYAlApd52s2otgCD9OEsRMnK0cl7YABN4a/QJj/LYZuRs/RYjTyLWEQMVzpTRRP9ZljQKtW87bzNloJVLDuEqghsx4jazMiKKdiS5/Ihr3x+pn9q9LLur/c6H4unUw4dqXHvwNrI9mG0wWcwnmHPM1d7BHH577NCa8dooL3qLCOwMb7LUpI6UDkv9YjNAlQL/8W+mnfvzF8u8oxWXtN/InOnGFsTtlQgvUOfH/rsxElDFzCW/Zd/PRwt1qPWv2uFeJ3pxjPtUJVliGQXCItbk/9eChCiGHu9CBk4/fsGAlSFOvrUNsulgW331h//GsK3prDjwB5L+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0s3noTtF6Hni4LX6d32K+0ujpVrmcbtXakJxKqrlIo=;
 b=j5t5oIe7LDJucOSF4qC9l1hCiPTmfyXRJpo/FKuIAkvd6MrHuPrlTIYYJVlcsi76ei7XPVdtgmwYsR9Hcfa2NB0Z7yIBLoki9qf6vicADCepd/t205h1k+BIsEbH6P+6OXFZA4tRDTtOszg7UbYv4rbbcRJ1pdzRzrB6dK0bgZA=
Received: from BYAPR05CA0044.namprd05.prod.outlook.com (2603:10b6:a03:74::21)
 by DS0PR12MB7779.namprd12.prod.outlook.com (2603:10b6:8:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Fri, 20 Feb
 2026 05:40:21 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:74:cafe::cb) by BYAPR05CA0044.outlook.office365.com
 (2603:10b6:a03:74::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Fri,
 20 Feb 2026 05:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Fri, 20 Feb 2026 05:40:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 23:40:19 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 23:40:18 -0600
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Feb 2026 23:40:15 -0600
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
Subject: [PATCH 5/5] dt-bindings: iio: adc: xilinx-xadc: convert to YAML format
Date: Fri, 20 Feb 2026 11:09:41 +0530
Message-ID: <20260220053941.611415-6-sai.krishna.potthuri@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|DS0PR12MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: cd98b2f5-0e70-4142-ff0a-08de7042898b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sxLyfxJNzBiI+sM8Rbw4atm0aJgowUZFE+qHsSeEao4mYJ39uaVNkZArM8Rd?=
 =?us-ascii?Q?m0M0gTF/ggrI7+La0vpHDZIcnl/xXdaxET0MYSmjlQItLpzIGq4h2nQ8cV8s?=
 =?us-ascii?Q?Rl2cFKtp3Wcoj3mab+CdY7ptfWyI80LMBmVmGDHPPOcUOn+Pr4Z4+rfdGx7N?=
 =?us-ascii?Q?kbZ8RofydqMqfLd7e6H4OcG4vYcUMT34dGB/e37OsJ/qvTLUQNz0TXhyDodK?=
 =?us-ascii?Q?Sq6iDC4kD1yv4auiPMKGyIqnGarZz2Jz3RVhDSGr5r3U47Y8YD/gz1zSWR/j?=
 =?us-ascii?Q?zFAAJble5zszN1VIsSCX7mtadue7RS+ihTn+7KgGT7LZbiNy8OGNabIhogQw?=
 =?us-ascii?Q?sOFXNrTAroZINZmDga1vCCoW7m/z39USmvqG681UvBlcak/+RUOPf8/z9jTf?=
 =?us-ascii?Q?nKHJEJFNH5L5t+g/0hZlJazCfeuAeRb2od/XHdH3yJvDX/JK5Uwr2D9oXU0C?=
 =?us-ascii?Q?+AqL0AdoyV3aEqgw7mSwzjjQaPH+AyF94GO/7D7CNfKZFwLRqnP3r6S+BZb0?=
 =?us-ascii?Q?K2d69XpNUfPWWXZ4YZwB4VZJqd03vfSP09+Z+ThTQZPMZaGuaNnzH/a2ns+O?=
 =?us-ascii?Q?benHWzhr3Hlu/Xt7Htf5uw+O4Yv0Q7drUErWBkCkZcsZOf3qaB3OAylxl8zY?=
 =?us-ascii?Q?clRdzpCoZFc+4u8RyY/MDXYhzY6EMtisVm9zVr8sgZXV+grbg6XuKhpwdLTS?=
 =?us-ascii?Q?/cHMzIhRl0bmfCRnLt6EGtSKMkLQwCaf8eub3vWSaLiBiTqUjW6hrAHW53OT?=
 =?us-ascii?Q?VQXB4Y1dPTCjsg2G4LN+4xdlgu7upJxC4O9P/cVgB7YRvP9Ie3oel9Q9EkgC?=
 =?us-ascii?Q?H7PI8fI1zdF5150ZIv8ZikYK0pxgRrD9JYja7m/fmYmt2QQrSLRqEP1zb2Ai?=
 =?us-ascii?Q?pB/n4jA4R1rFAd/aAyLcu1hWRhs/mIbBFeR3qUGM/EzQ0nYME6hRodzkpifd?=
 =?us-ascii?Q?LYMpnyVhkOYZVcXLNaj4hZcjXvUTMnbYsJCV+sM6cXoNkFA2KvhzNOjUInG0?=
 =?us-ascii?Q?UnMpIq+BNnvAtG/ffYI8ex+Odqq3ClbdvUZ02kklxmcQr4gKpewsJZTSOpmZ?=
 =?us-ascii?Q?Jy8qq3l66oWKXbYwpjvgDjRGDEyJHVv285FbDoAdn4nUOgj4mBwEnvoCK6Ih?=
 =?us-ascii?Q?ISXR7jp7T7+Y2tWl7WoLU+YuV4AFhmIDz5Cl8nyf/Q/w53/j2mhTYqGo57+q?=
 =?us-ascii?Q?xaB4/3eSoqna4QWObPuxsYZGsfuDw/84c52DvI8iLUNRhgKLmbC7cDe8b0k6?=
 =?us-ascii?Q?pLVuBlL5a8eB5wOENymPTwpuVZsS+nFIudsRJm0SpQABzcFr5g08kpADkbfr?=
 =?us-ascii?Q?enKHiN63skbgh/VliS+ifMnGs421g9D6alaSULB0PGsy6DZok0BOkoVhK4zy?=
 =?us-ascii?Q?l29CG7+Vd6vdXt5V+3wvStuVm6DW8VEafokN0L0OxYTTOcwNKgfZdDEe3NDm?=
 =?us-ascii?Q?zqYs/cJOUINpseylbThcUMDL3SoS81GyWRP5GOIKuIB///B3CKzSN4iYNE2S?=
 =?us-ascii?Q?8CVXnpiJH8aVqpjvMTs74cXzMusnzZZaCL6zy5Fvt+nj1lnLY5FkUOho+uux?=
 =?us-ascii?Q?5F1iqe5+gsSU9iNXMjHyPuiDET5uIiWQ86RNtv7ECO3f3IZ0HX7YUuxK8rlB?=
 =?us-ascii?Q?IAMTItkl+4tvwJX6yWIL1Pk4U4LZviWB+nTHAKRdtAKGmZQEuniKl/LdFYPC?=
 =?us-ascii?Q?tjuYZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	APj8okI4ah1y0rJwCzJL4wIz/7ySX9mY9ctgPEuRCQ7iGt1jghfOQzQhnjK3XU01D92pBNSwn1FdlO2nb6i34mfG9Ap5nKjmt5+FjCuIGkZladzr0ZKUCfJbRuhv+TCOhwcX6pd/mfA8V//BqKggKgIyKBlZ62lH1HrMeJ5ZTxFajR3mwyiXFH7LondiVFbQedyU49N4VBmBnwOe6SC7Y6IarDcGondxBuTvEqIJUzSnFCyyyzrUqjT1h7/wkRDImHMmweoGkqfpnFnr9Wm3WPFNfv3ApufJCsK/mdPa3PkbxRhq6bP7mkQh6jD5/5wbBmcd5/1Bjey4GlEGIoK70e8bfk1tKZ0ImvX0WH0NcqrZlu7J6zlgPYv6AHZRhCxrOqJ0TfEmDwnp6bph8LDbDQcYuFpEO8VaAdfB0WDXmLWtTzhyzSAmcnJ31xXA9Hq6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 05:40:21.0189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd98b2f5-0e70-4142-ff0a-08de7042898b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7779

Convert the xilinx-xadc.txt Devicetree binding to a YAML schema format
and remove the old text binding.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 .../bindings/iio/adc/xilinx-xadc.txt          | 141 -------------
 .../bindings/iio/adc/xilinx-xadc.yaml         | 194 ++++++++++++++++++
 2 files changed, 194 insertions(+), 141 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
deleted file mode 100644
index f42e18078376..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
+++ /dev/null
@@ -1,141 +0,0 @@
-Xilinx XADC device driver
-
-This binding document describes the bindings for the Xilinx 7 Series XADC as well
-as the UltraScale/UltraScale+ System Monitor.
-
-The Xilinx XADC is an ADC that can be found in the Series 7 FPGAs from Xilinx.
-The XADC has a DRP interface for communication. Currently two different
-frontends for the DRP interface exist. One that is only available on the ZYNQ
-family as a hardmacro in the SoC portion of the ZYNQ. The other one is available
-on all series 7 platforms and is a softmacro with a AXI interface. This binding
-document describes the bindings for both of them since the bindings are very
-similar.
-
-The Xilinx System Monitor is an ADC that is found in the UltraScale and
-UltraScale+ FPGAs from Xilinx. The System Monitor provides a DRP interface for
-communication. Xilinx provides a standard IP core that can be used to access the
-System Monitor through an AXI interface in the FPGA fabric. This IP core is
-called the Xilinx System Management Wizard. This document describes the bindings
-for this IP.
-
-Required properties:
-	- compatible: Should be one of
-		* "xlnx,zynq-xadc-1.00.a": When using the ZYNQ device
-		  configuration interface to interface to the XADC hardmacro.
-		* "xlnx,axi-xadc-1.00.a": When using the axi-xadc pcore to
-		  interface to the XADC hardmacro.
-		* "xlnx,system-management-wiz-1.3": When using the
-		  Xilinx System Management Wizard fabric IP core to access the
-		  UltraScale and UltraScale+ System Monitor.
-	- reg: Address and length of the register set for the device
-	- interrupts: Interrupt for the XADC control interface.
-	- clocks: When using the ZYNQ this must be the ZYNQ PCAP clock,
-	  when using the axi-xadc or the axi-system-management-wizard this must be
-	  the clock that provides the clock to the AXI bus interface of the core.
-
-Optional properties:
-	- xlnx,external-mux:
-		* "none": No external multiplexer is used, this is the default
-		  if the property is omitted.
-		* "single": External multiplexer mode is used with one
-		   multiplexer.
-		* "dual": External multiplexer mode is used with two
-		  multiplexers for simultaneous sampling.
-	- xlnx,external-mux-channel: Configures which pair of pins is used to
-	  sample data in external mux mode.
-	  Valid values for single external multiplexer mode are:
-		0: VP/VN
-		1: VAUXP[0]/VAUXN[0]
-		2: VAUXP[1]/VAUXN[1]
-		...
-		16: VAUXP[15]/VAUXN[15]
-	  Valid values for dual external multiplexer mode are:
-		1: VAUXP[0]/VAUXN[0] - VAUXP[8]/VAUXN[8]
-		2: VAUXP[1]/VAUXN[1] - VAUXP[9]/VAUXN[9]
-		...
-		8: VAUXP[7]/VAUXN[7] - VAUXP[15]/VAUXN[15]
-
-	  This property needs to be present if the device is configured for
-	  external multiplexer mode (either single or dual). If the device is
-	  not using external multiplexer mode the property is ignored.
-	- xnlx,channels: List of external channels that are connected to the ADC
-	  Required properties:
-		* #address-cells: Should be 1.
-		* #size-cells: Should be 0.
-
-	  The child nodes of this node represent the external channels which are
-	  connected to the ADC. If the property is no present no external
-	  channels will be assumed to be connected.
-
-	  Each child node represents one channel and has the following
-	  properties:
-		Required properties:
-			* reg: Pair of pins the channel is connected to.
-				0: VP/VN
-				1: VAUXP[0]/VAUXN[0]
-				2: VAUXP[1]/VAUXN[1]
-				...
-				16: VAUXP[15]/VAUXN[15]
-			  Note each channel number should only be used at most
-			  once.
-		Optional properties:
-			* xlnx,bipolar: If set the channel is used in bipolar
-			  mode.
-
-
-Examples:
-	xadc@f8007100 {
-		compatible = "xlnx,zynq-xadc-1.00.a";
-		reg = <0xf8007100 0x20>;
-		interrupts = <0 7 4>;
-		interrupt-parent = <&gic>;
-		clocks = <&pcap_clk>;
-
-		xlnx,channels {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			channel@0 {
-				reg = <0>;
-			};
-			channel@1 {
-				reg = <1>;
-			};
-			channel@8 {
-				reg = <8>;
-			};
-		};
-	};
-
-	xadc@43200000 {
-		compatible = "xlnx,axi-xadc-1.00.a";
-		reg = <0x43200000 0x1000>;
-		interrupts = <0 53 4>;
-		interrupt-parent = <&gic>;
-		clocks = <&fpga1_clk>;
-
-		xlnx,channels {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			channel@0 {
-				reg = <0>;
-				xlnx,bipolar;
-			};
-		};
-	};
-
-	adc@80000000 {
-		compatible = "xlnx,system-management-wiz-1.3";
-		reg = <0x80000000 0x1000>;
-		interrupts = <0 81 4>;
-		interrupt-parent = <&gic>;
-		clocks = <&fpga1_clk>;
-
-		xlnx,channels {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			channel@0 {
-				reg = <0>;
-				xlnx,bipolar;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml
new file mode 100644
index 000000000000..17508fef1f43
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml
@@ -0,0 +1,194 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/xilinx-xadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx XADC and System Monitor ADC
+
+description:
+  The Xilinx XADC is an ADC that can be found in the Series 7 FPGAs from Xilinx.
+  The XADC has a DRP interface for communication. Currently two different
+  frontends for the DRP interface exist. One that is only available on the ZYNQ
+  family as a hardmacro in the SoC portion of the ZYNQ. The other one is available
+  on all series 7 platforms and is a softmacro with an AXI interface.
+
+  The Xilinx System Monitor is an ADC that is found in the UltraScale and
+  UltraScale+ FPGAs from Xilinx. The System Monitor provides a DRP interface for
+  communication. Xilinx provides a standard IP core that can be used to access the
+  System Monitor through an AXI interface in the FPGA fabric. This IP core is
+  called the Xilinx System Management Wizard.
+
+  The System Management Wizard can also be accessed via I2C interface for remote
+  monitoring scenarios where the system Management Wizard is located on a different chip.
+
+maintainers:
+  - Lars-Peter Clausen <lars@metafoo.de>
+  - Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
+
+properties:
+  compatible:
+    enum:
+      - xlnx,zynq-xadc-1.00.a
+      - xlnx,axi-xadc-1.00.a
+      - xlnx,system-management-wiz-1.3
+      - xlnx,system-management-wiz-1.3-remote
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      When using the ZYNQ this must be the ZYNQ PCAP clock,
+      when using the axi-xadc or the axi-system-management-wizard this must be
+      the clock that provides the clock to the AXI bus interface of the core.
+
+  xlnx,external-mux:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - none
+      - single
+      - dual
+    default: none
+    description: |
+      External multiplexer configuration:
+      - "none": No external multiplexer is used (default)
+      - "single": External multiplexer mode is used with one multiplexer
+      - "dual": External multiplexer mode is used with two multiplexers
+        for simultaneous sampling
+
+  xlnx,external-mux-channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 16
+    description: |
+      Configures which pair of pins is used to sample data in external mux mode.
+      Valid values for single external multiplexer mode are 0-16:
+      0: VP/VN
+      1-16: VAUXP[0-15]/VAUXN[0-15]
+      Valid values for dual external multiplexer mode are 1-8:
+      1-8: VAUXP[0-7]/VAUXN[0-7] - VAUXP[8-15]/VAUXN[8-15]
+      This property needs to be present if the device is configured for
+      external multiplexer mode (either single or dual).
+
+  xlnx,channels:
+    $ref: '#/$defs/channels'
+
+allOf:
+  - if:
+      required:
+        - xlnx,external-mux
+      properties:
+        xlnx,external-mux:
+          enum:
+            - single
+            - dual
+    then:
+      required:
+        - xlnx,external-mux-channel
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+$defs:
+  channels:
+    type: object
+    description: List of external channels that are connected to the ADC
+    properties:
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^channel@([0-9]|1[0-6])$":
+        type: object
+        properties:
+          reg:
+            minimum: 0
+            maximum: 16
+            description: |
+              Pair of pins the channel is connected to:
+                0: VP/VN
+                1-16: VAUXP[0-15]/VAUXN[0-15]
+              Note each channel number should only be used at most once.
+
+          xlnx,bipolar:
+            type: boolean
+            description: If set, the channel is used in bipolar mode
+
+        required:
+          - reg
+
+        unevaluatedProperties: false
+
+    required:
+      - '#address-cells'
+      - '#size-cells'
+
+    unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    xadc@f8007100 {
+        compatible = "xlnx,zynq-xadc-1.00.a";
+        reg = <0xf8007100 0x20>;
+        interrupts = <0 7 4>;
+        clocks = <&pcap_clk>;
+
+        xlnx,channels {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                reg = <0>;
+            };
+            channel@1 {
+                reg = <1>;
+            };
+            channel@8 {
+                reg = <8>;
+            };
+        };
+    };
+
+  - |
+    xadc@43200000 {
+        compatible = "xlnx,axi-xadc-1.00.a";
+        reg = <0x43200000 0x1000>;
+        interrupts = <0 53 4>;
+        clocks = <&fpga1_clk>;
+
+        xlnx,channels {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                reg = <0>;
+                xlnx,bipolar;
+            };
+        };
+    };
+
+  - |
+    adc@80000000 {
+        compatible = "xlnx,system-management-wiz-1.3";
+        reg = <0x80000000 0x1000>;
+        interrupts = <0 81 4>;
+        clocks = <&fpga1_clk>;
+
+        xlnx,channels {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                reg = <0>;
+                xlnx,bipolar;
+            };
+        };
+    };
-- 
2.25.1

