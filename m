Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012027.outbound.protection.outlook.com [40.107.200.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA243806B0;
	Sun, 14 Jun 2026 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480256; cv=fail; b=HT1vI/vJqVTGicH76bZl0QUJEImn8o03j8Yuwg3bYVvRYpzyqqPLCyrWU1ST9wAWjZWul4khjkAlWOBXySMdn3UNVMB03590Hd43M3WFcwEpmWs4pSXqUhdFcfaG2Ye4y7XTIsya3qIJC8SaJfK2rQbGMw7UA7TCWbUwM5iLuO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480256; c=relaxed/simple;
	bh=AMxaw9xbcV7M42H9BvcWA83P1Rw6y0/rMj2MOgr5QfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EH6eK+rovAjNHBf4H1pnhiWSNmn5GN2jihFVlHGzr0a6mJt3C/Ff18riffqSPrPLvxc01cBI6JNQlEVmP3UxBoPonXP5TVgPSWhhbBQKGAdLsSRgHb77IIiHdZL9hXMmEN9rse8iQjH1IQ+bTdjFGnyIQe8EC59tekMP49bQMBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ze1zxIJI; arc=fail smtp.client-ip=40.107.200.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ze1zxIJI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BviM7Uqq92cqO5vXyaerabzArlC/syHWH40Tc6mKkjWd4+FOijukw0T41BLtC3700csafvu5u61+EYxCPCvygzkCu2bFq/ivU5kYxhAyDDLY7MhvceVB5iQyW9l3HLRMv7FOSSSBj1RswqYJdMLunOpMlXpgskD8kIjv1LZ/O8rWk64+eOnnZXJqEklU8JX4Vy7Af/uuHJp0VVnevObncLILm0Zq+fmbUpwzSHUL5gBcCbR5I99I4jqvJ/QIyGs6BcQ5+4YWu6PMLm++z1kyzRQbAkZXRERt00/9VvuXpLAGif13/NqKnqTp6cShe/3MPkfiFrZIm03tHKZDCLbE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoBr1URY+CgVcqfnd2/BiqcmFhaqapMyuDEjCnQE2Ro=;
 b=Ib7VOam+1Tpm1CDqb/pC79Yj1/Wui5zPJ9hK1ZBeqowiDOqHTQ2BhsxdAAgAExKe2abmKIMT+M+Mv3cN6aCd1Ocs9ELnAGWoGkG/MjHqT901P/aVqT1aFBAwtO1A/G/re+8Hw5L9CkIivxKj76aPKMkTDDxDFlHTMUegh3bNb9RrhuJffo7eZOGQXZIUE1ipCIY+U8xKIV3cRgWToOp/Gk9kBNFg1j4DoCtwGZxPyWQMcIGAqH2IkLtf5ljPMQjvXgbwMMWu47+FleDwXOpQ2juIUQgaJn8NTiFxbxgkyGpadYjQYKVzbH/4EkIB0Fu11sFH9JxH7uNc6HQmtjXPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoBr1URY+CgVcqfnd2/BiqcmFhaqapMyuDEjCnQE2Ro=;
 b=ze1zxIJI5VBDLtzcJ0FnkwfQxcNFY+qymMbQeKeSlws3reuuWoDEWUqSuEKkXL+91EPzVzb6f8NMBPU1BBk8ZUYKG6OroLMlvsMYbCpQ6zRlfcNQAIVoNlc0rDSvKiTo8a5CnBmR7YAycdVVuyoUuzXga66ZMmBL1JI2b7S63FY=
Received: from BL1PR13CA0373.namprd13.prod.outlook.com (2603:10b6:208:2c0::18)
 by IA1PR12MB8556.namprd12.prod.outlook.com (2603:10b6:208:452::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Sun, 14 Jun
 2026 23:37:28 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::7) by BL1PR13CA0373.outlook.office365.com
 (2603:10b6:208:2c0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.6 via Frontend Transport; Sun, 14
 Jun 2026 23:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 23:37:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 14 Jun
 2026 18:37:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 14 Jun
 2026 16:37:27 -0700
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sun, 14 Jun 2026 18:37:25 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v7 1/5] dt-bindings: iio: adc: add xlnx,versal-sysmon binding
Date: Mon, 15 Jun 2026 00:37:18 +0100
Message-ID: <20260614233722.2603459-2-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260614233722.2603459-1-salih.erim@amd.com>
References: <20260614233722.2603459-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|IA1PR12MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5a1c7e-cfde-4305-3970-08deca6de545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|23010399003|36860700016|13003099007|22082099003|18002099003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	vKg6RbBEd5v4O6+TOUWenkWuyFkgN8g73XGW3KM8ZrbvIMrfQITrivhd8Yr7H5ks2YcX1i6BHr2Xp6GdaSiNUza1GSLBmdepTHqjqymM8U8BieWYDwBXyyJAZfGsd4Acg6Pznka9UIGXaMqJ64GvRXq59ku7L5zyAQzKtvptugfiWIPPLoGFfSFQ1In4DcEatRuDubOUlaT7Se5QZhw42wviiJQom93YTSKGJuxNYhQ9BFgTedMVHIvXLAu55i5KJ+rQBsq/RWsNnQvKKjlIHmYEjSgAIeFX11TIv5gu25DO/2eroTIwre6pvEdB8bPTwbsonx1FqDyS/Y4eOoi0VyWgnQTkf7Av6ZmshbftKWF11yiQUc8UYefAe/Qs4oDC8LMuw0tuFys0RzkPt+ekFlWKwYOM9YJKwcejnzyXMjfpwHEPq8NWjEAcZkdZzEBqbGBt1OROIoCsBhIjTb3ab+Y/j0TnPbPoEb9dBhRWhhQ7RQBmWQTywx9ZI30BsxYgkEhzpKSumNYMkZ/Nk3ZQByGdpjqEq3r+ZVy50yVeGrvSDnuBFTk5g3SwcUzZGvzHvnomDbZFRjkPMr1B8RVlFTkgqvxTtjkGwmenhIFAsvnwQAeKcpkJVk0tTXwRgxs2wVkzI9IdUWZSRzsrXgBxGOQLyjnpm/nVDKRiSvFGWbPybjL3swixbOh17cWOXSil
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(23010399003)(36860700016)(13003099007)(22082099003)(18002099003)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tOZC/Ej5p3gA6JcocM0NGy8PMsCecuvivr4PwRzbzzBwViuiXBDIEwiyLGm2v9t/ROhFIky8f4IssRCq0EO2cRRDeeASJJYWlzJvymJY/aC/JOeE30Z5F0g36UYM/GReG+I6eFfsKw7eHK5YnBSDCi/HM9hkFK2QjhhZlFQq2wrMChUM/8vOSy7ARZYiRCF+Lcp6OACepA2n8WoqL/v1Bu/ilhIfykUNeCS4GDAQyqlFMWEzQMYbyW8nrfnoth3P84XDBbQt7ahEzMrU805B9XOecUDOjnERHqziStg0+HHZrF20X9vtkV299EMzKMPClt8rfjgnZwKeJipCXqKXtrkfLw2nhPbBdR8mVlkCfX/giE6pxEssW66jMXJxWV7xa0ud22rolNiYH2yVT1TB6o7DYe4zRKtKPkevlZ9BjSL8NQERmtCC4aSFBqEA4BzC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 23:37:27.9511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5a1c7e-cfde-4305-3970-08deca6de545
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8556

Add devicetree binding for the AMD/Xilinx Versal System Monitor (SysMon).

The Versal SysMon is the successor to the Zynq UltraScale+ AMS block,
providing on-chip voltage and temperature monitoring. The hardware
supports up to 160 supply voltage measurement points and up to 64
temperature satellites distributed across the SoC, with configurable
threshold alarms and oversampling. The device can be accessed via
memory-mapped I/O or via an I2C interface.

Supply and temperature channels are described as child nodes under
container nodes, referencing the standard adc.yaml binding for
channel properties.

Co-developed-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Salih Erim <salih.erim@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v7:
  - No code changes

Changes in v6:
  - No code changes

Changes in v5:
  - No code changes

Changes in v4:
  - Add Reviewed-by tag from Krzysztof Kozlowski

Changes in v3:
  - Use single compatible (xlnx,versal-sysmon only), remove
    xlnx,versal-sysmon-i2c (Krzysztof)
  - Rename supply-channels container to voltage-channels (Krzysztof)
  - Use single quotes in patternProperties regex (Krzysztof)
  - Drop label description from channel properties (Krzysztof)
  - Drop bipolar from channel properties (Krzysztof)
  - Remove xlnx,aie-temp property from binding and example (Krzysztof)

Changes in v2:
  - Restructured to container nodes (supply-channels, temperature-channels)
    with channel@N children referencing adc.yaml
  - Added xlnx,versal-sysmon-i2c compatible
  - Descriptions rewritten to describe hardware only
  - Example simplified to #address-cells = <1>
  - Interrupt example uses GIC_SPI/IRQ_TYPE_LEVEL_HIGH constants
  - Commit description explains hardware context instead of schema layout
  - reg required for both MMIO and I2C, interrupts optional
  - Hex unit-addresses (channel@a not channel@10) per DTSpec
  - patternProperties regex updated to accept hex digits [0-9a-f]
  - Example trimmed to minimal variants (one basic + one bipolar supply,
    one AIE temperature channel)
 .../bindings/iio/adc/xlnx,versal-sysmon.yaml  | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
new file mode 100644
index 00000000000..1ad58e3d616
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/xlnx,versal-sysmon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD/Xilinx Versal System Monitor
+
+maintainers:
+  - Salih Erim <salih.erim@amd.com>
+
+description:
+  The AMD/Xilinx Versal System Monitor (SysMon) is the successor to the
+  Zynq UltraScale+ AMS block. It provides on-chip voltage and temperature
+  monitoring with up to 160 voltage measurement points and up to
+  64 temperature satellites distributed across the SoC. The hardware
+  supports configurable threshold alarms and oversampling. The device
+  can be accessed via memory-mapped I/O or via an I2C interface.
+
+properties:
+  compatible:
+    const: xlnx,versal-sysmon
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#io-channel-cells':
+    const: 1
+
+  voltage-channels:
+    type: object
+    description:
+      Container for voltage measurement channels.
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      '^channel@([0-9a-f]|[1-9][0-9a-f])$':
+        $ref: adc.yaml
+
+        description:
+          Measures a voltage rail. The register index and rail
+          name are assigned by the hardware design tool (Vivado).
+
+        properties:
+          reg:
+            minimum: 0
+            maximum: 159
+            description:
+              Voltage measurement register index assigned by the hardware
+              design tool.
+
+        required:
+          - reg
+          - label
+
+        unevaluatedProperties: false
+
+    required:
+      - '#address-cells'
+      - '#size-cells'
+
+    additionalProperties: false
+
+  temperature-channels:
+    type: object
+    description:
+      Container for temperature satellite measurement channels.
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      '^channel@([1-9a-f]|[1-3][0-9a-f]|40)$':
+        $ref: adc.yaml
+
+        description:
+          Reads a temperature satellite sensor. Each satellite monitors
+          a specific region of the SoC die.
+
+        properties:
+          reg:
+            minimum: 1
+            maximum: 64
+            description:
+              Temperature satellite number (1-based hardware index).
+
+        required:
+          - reg
+          - label
+
+        unevaluatedProperties: false
+
+    required:
+      - '#address-cells'
+      - '#size-cells'
+
+    additionalProperties: false
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
+
+    sysmon@f1270000 {
+        compatible = "xlnx,versal-sysmon";
+        reg = <0xf1270000 0x4000>;
+        interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+        #io-channel-cells = <1>;
+
+        voltage-channels {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                label = "vccaux";
+            };
+
+            channel@3 {
+                reg = <3>;
+                label = "vcc_ram";
+                bipolar;
+            };
+        };
+
+        temperature-channels {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@a {
+                reg = <10>;
+                label = "aie-temp-ch1";
+            };
+        };
+    };
-- 
2.48.1

