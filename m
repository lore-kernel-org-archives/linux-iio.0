Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011013.outbound.protection.outlook.com [52.101.57.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A18364029;
	Mon, 23 Mar 2026 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774251990; cv=fail; b=AADPHbpFTy6NUq7LII9WWr56y1Y044IYqBrAyN9gKzBaj94RonlBxj9dZjVDuOb/SPcsAaYt1mrmsf20XTwEwp4y4vouLwkvPGyqFSUQThWfNqtdCXj/LPSis+uwpmXxW9Msg42tiMX7cEH4O9whDp3VBr7spzn5fbjcK3RLlgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774251990; c=relaxed/simple;
	bh=FxCTv5PWrtLeMkYxagbLgkKYO7D5QdEyp4QgIT6zNOM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poJ6FLfNLK3LHl3sA/FbJXnTGSauFfQ7oR2YZdAgGW6QR9u/qZL2alV8WAXRfMyhb+oDSvfLOUkDmMpLkmzmRqbnEzkzl6M14GKTI203qtIycaKHQX1nbNpCpAwY7374vR7hFE7Y/DQiT9z6aqrsLjAPGTn3pkOHI/9Qvpq7mQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rfab8b2k; arc=fail smtp.client-ip=52.101.57.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rfab8b2k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOV3RiD3YUtHqJTE7ngI4K/TIQ8C0aa02OW3mWBwS0DcL8xvQ1+suBYlodd1my0SOtKceHB33wgkpMVcpPFLaYw65tmstSfBQOkXs/rdc3ggQZhnIKg7PoJoha2PmHNPQsgz2gQrom50i3Mg2yIuav5HsJe4v8J7sn0b5t4nKQNMuBIh9D6ZRXTZnhjLV6edWdu5znzcAN67gkyaXuQl3Surjpg01lMrQDvLDpD8hJYDy822ZURXqYyiNQfUTUpMr66jUFAUhhUyKovk67v3L9mjZHilh1UZpMJUtx+mLTO96AlsKmgeS39qicSh88Y2DkOPe6fuMa9FI3GHZTpC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9MdYhasxLC4ZQk3/Kl7zCKc2Zrw/FHUwCXqWAqPBBs=;
 b=Fqrqwj4/rQ6R5ym/tuSF+fho65Mu6SYcpJ7iDcqzTYF7YFFzAZmNOo6S0lNlj2Klqne7GZLXRpAVRq492nd0wWQcnS5I3s9Z1ZRDAU8ykuQmm7TKDTP7c72bgQRYJRSjRinYlgYMy8+cU9v8boH392R3wbLwFU0ujwOpZ940cXf4pGVSG2QoUwm7o6R0r6n9zuZjwiKidcxhHaCLYHS/MxZMuRyGecTiFNoFyZKHxbEK8N9+jrRvcgXTBNAIVLO/n8WqHbzys3/nJmEmRNZeCligoh9PmaBeNOBUHsXGEOHVkZrXWMStlKWo7G/uYMAh6hnaRWxKxkmjtI3ETCNFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9MdYhasxLC4ZQk3/Kl7zCKc2Zrw/FHUwCXqWAqPBBs=;
 b=Rfab8b2kKwgVgKB5rM8hVQhLG7iFWKNekMMfGcVKXRRl45/W/EhF8e9ljVz6+WY9OQ55RG7hXhTjtXbaZFEB7vyvm34t+m9B1hekV5JqpQJV4TOsxxQRfhgnDsRC+S7erv7xhGcupdPe97DwFn63Ldx+FiRmJPzc0u6T2nCBD4A=
Received: from MN2PR05CA0036.namprd05.prod.outlook.com (2603:10b6:208:c0::49)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 07:46:20 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::70) by MN2PR05CA0036.outlook.office365.com
 (2603:10b6:208:c0::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 07:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 07:46:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 02:46:18 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 02:46:15 -0500
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
Subject: [PATCH v2 4/4] dt-bindings: iio: adc: xlnx,axi-xadc: convert to DT schema
Date: Mon, 23 Mar 2026 13:15:05 +0530
Message-ID: <20260323074505.3853353-5-sai.krishna.potthuri@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: a8146aba-334b-4feb-52ab-08de88b045b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8JnHcOpgE7gnEsrQbmdYZjasFgkjym/N83IhiFiWE6UTKwcDnbqis371H8/EhbFzMaQ9gAE5xloXY9MJrUjAPqxlWZPHBHtcuUvD5KpCT3qCsE5gbhrvWG+Y9me16YLAYOZvvnq1qN7a3bTwDr0BekulLBpH6YuV0wXHS8VqG6UHFXByqclAE66Lps4Z3ZcDPpyQXwI67s1UV4jOs8wTZSgz9/6t2wD9K2TPR76UjQ+g9WHj8mpr9ny++P8WmFhhDs9R6Uy5ZRJZyp4ML8Npw9Ibl7u4zkqAVuqZxUjq5CiXin2zoPyCj7Wcz+r5O6qecuu/M0GJVapPaGr1MsN4xtAW4dAbEjXjuyf/WwbzQ15+J15RSznP090erqTZtsV9PNC7DYkNxwkabClc6HmfmCMyutrq0lrTIKNGmxm2GklR3vyOLHwJdSQE8OEGGNdHwjKScgL3IKch+8QTXxJOEdBA+BwOTsyxZnVdvNKQy5MDHIfaFFy5JUMITW6qPkZq5fTWRLCI4AkduybwWvChUyN4HqXvwLIFWR1nRStskcR/sMAC8tJOxIJQQenzVXWdMgxwHU6Kq9CTBMbxYuVeqj92Bbllxt/INhG3vxQFsPhyWTTGgha0CLooiYL5MoY3QEMbkKg+y2yxQPefvc5fYNuV884AVZfwzc1s5uvsqp8WGJbdXfey1tLLobLIvrm30dW8sjqa7p74/3SFRt2JSnkAxtIYrnf4BrUYkYcyMcM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(13003099007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WW0eFh77wgbN1ty92zWSR4XG0KaGY+7I8/WkO8W5usZLZD2AeRIB4PEv/Lv2AWtr0GCNwdSgwBritHSRBVXO1EHVJhoqgLlKtRmW1Tx10pTGZyEyssZAFMwnlByKxgORzWbwR26xHF88rQIM5fyqvk7RXYWZs2kHLNU5TtxXaYjSE8b630JAYstHcU8q8iUH1QY1xQvRvsu06yel202bjFBCa4HHa/7GovoZdldSB5FgjvT8yHeExFra266CI3FkLYUQJbgHEFsMhrq8NutXg5mAUbOufs4oxoMfBwbqVLpWw8YTr0UTCDozgwsvQjHSPHyrLLz7cERCtkrb95X33u5iMbr8IXp9cr6Jj9eOJSIDobbrzJDidO9JRxMEyboyukv1Kg57sH4pNqCa1Tp0GuKktlq5GH0L/579ZVh/LkYZJev8iu9oE6a3OYD0m/K1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 07:46:19.8011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8146aba-334b-4feb-52ab-08de88b045b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364

Convert the xilinx-xadc.txt to DT schema and remove the old text binding.
Update xilinx-xadc binding path to YAML format in MAINTAINERS file.

The 'xlnx,channels' property is a container node(type: object) with
a vendor prefix, which triggers the below warning:
  "properties:xlnx,channels:type: 'boolean' was expected"

This cannot be changed because the original text binding specified
'xlnx,channels' since 2014, driver explicitly looks up "xlnx,channels"
using device_get_named_child_node() and removing the vendor prefix
would break backward compatibility with existing device trees.
Also, keep all vendor-prefixed properties from the original binding to
maintain backward compatibility with existing devicetrees and driver code.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 .../bindings/iio/adc/xilinx-xadc.txt          | 141 ----------------
 .../bindings/iio/adc/xlnx,axi-xadc.yaml       | 154 ++++++++++++++++++
 2 files changed, 154 insertions(+), 141 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,axi-xadc.yaml

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
diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,axi-xadc.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,axi-xadc.yaml
new file mode 100644
index 000000000000..e384928d60eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xlnx,axi-xadc.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/xlnx,axi-xadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx XADC and System Monitor ADC
+
+description:
+  The Xilinx XADC is an ADC that can be found in the Series 7 FPGAs from
+  Xilinx. The XADC has a DRP interface for communication. Currently two
+  different frontends for the DRP interface exist. One that is only available
+  on the ZYNQ family as a hardmacro in the SoC portion of the ZYNQ. The other
+  one is available on all series 7 platforms and is a softmacro with an AXI
+  interface.
+
+  The Xilinx System Monitor is an ADC that is found in the UltraScale and
+  UltraScale+ FPGAs from Xilinx. The System Monitor provides a DRP interface
+  for communication. Xilinx provides a standard IP core that can be used to
+  access the System Monitor through an AXI interface in the FPGA fabric. This
+  IP core is called the Xilinx System Management Wizard.
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
+      - "none": No external multiplexer is used
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
+    description: List of external channels that are connected to the ADC
+    type: object
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
+        additionalProperties: false
+
+    required:
+      - '#address-cells'
+      - '#size-cells'
+
+    additionalProperties: false
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
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    adc@f8007100 {
+        compatible = "xlnx,zynq-xadc-1.00.a";
+        reg = <0xf8007100 0x20>;
+        interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
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
-- 
2.25.1

