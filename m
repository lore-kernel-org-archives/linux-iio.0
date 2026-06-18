Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD703E715A;
	Thu, 18 Jun 2026 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777684; cv=fail; b=b/onk6nlB3r1Lib5nrZbJM152R1Nf/J3jlBbHn4K9MCn7Gnh3BU5zrRcIWYbhWN+h0VE/+OIGxqAj5JnEacBtVIOQP+hc2hszrW/md4lACDReGn0FfhspZjqcIV0TPhvyY18Ue/7eg8MRsnu68FNDETHdTvqH0TVzYKig/SMdWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777684; c=relaxed/simple;
	bh=rF3U4PLD9T5tJP0KprE3uPAj5nh7AZE6801tihHMTF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBB3EKZyNiA9UI011gDbsw4cG32SkCrEmEodkd8Y6nAzwvI1c6tBsnPZCDT3YBp7CDjLbjCY2bmRMsjKuBKbIRAYs+j1QPeY/BXsxM/OdORJJatK65ZupTjePYVeGyd0doUWw1VH58N94+1PoXgK+P0pTUuhGnpZsdXZybeCTHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Pl3tNL9; arc=fail smtp.client-ip=40.93.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Pl3tNL9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuzAXkTeOAwgF/mktSONNyUevKP6IpkXNxo0+Q3eW+M99SAnIK0D4XEXxAII93ZpXXDqsWtmemTH+Dmmax8YIG74fqVOKegYe5YxkGYkwppiMIw1YYjr7yq3lbfqzAx/Qrl0SymvHOj5DX1GXwWpAlfw5lwvxc2lddLDNCo2ATBPOVMyNJJy4mjj1WQi4EL09NGeS4PNMdFchR3dukIPCwLlP42e0R0gpKiK/GSBSTuulN/doMyTqdbaTicBslLoI6jFWaDkkIKDtWcDYoBJjPYMJZtDNFhR2wvQZnWxXHeHdjWSorcRKrqbvpJKBQSBxpBToc5IomPNfTaNa6cMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdE0dWU0s/L3lgS58BS3I5aA3B1YEYBhs4pAdB8FopA=;
 b=H1sGmg6/GMEsB4YdgAQYaQayM48KarhwOImxDYdZJrzDeFsVZjl/f9WAk3Hfo9ug2GRrS/jtoX4xLXfvgiSAJ5AT7578l3y7IRgiZw6kaUCCZ+rBOdFwIRaym29IpwryEIf/j1Xm/c9A7xPQR1d3a+kyBYzdkXg5mv+4Xb+UzEyGqR6LKTVc+SJCnQvveZSh8YIuwIg4g1BLO1GRS2nnbIVlDJP6j6R3Got2CysgsP/fZnLy8l1MG/pgvP1X9xNkJfPOh3h2EdnuO7C6NeZ7OxqdzF+yc3OkAm97bKMa8DYTAx4TbvsbXUGgEw+YfoaILAa0NePxqPflBWjMM737Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdE0dWU0s/L3lgS58BS3I5aA3B1YEYBhs4pAdB8FopA=;
 b=5Pl3tNL9hO9GKlQDE/BkSQki9hq1QavRmcc0nCOGA8kISZ6wjkTaMthB76esDIYmtvOakRmVwqUdZQc0wv66sbR+avddUXWgjtECCqkRUWUWX4VUHgMQtNvOCO7dKYzrWlrVNUMYvZ85e60fa8GS39ft+Vh43lCVPt5pGHPgfc8=
Received: from SJ0PR03CA0240.namprd03.prod.outlook.com (2603:10b6:a03:39f::35)
 by BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 10:14:28 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::3a) by SJ0PR03CA0240.outlook.office365.com
 (2603:10b6:a03:39f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 10:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 10:14:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 05:14:25 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 05:14:25 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 18 Jun 2026 05:14:23 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v10 1/5] dt-bindings: iio: adc: add xlnx,versal-sysmon binding
Date: Thu, 18 Jun 2026 11:14:10 +0100
Message-ID: <20260618101414.3462934-2-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618101414.3462934-1-salih.erim@amd.com>
References: <20260618101414.3462934-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: e81f8aae-029e-406d-40ec-08decd2260fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|23010399003|82310400026|376014|13003099007|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	tKHTmdhUdLZIKM2idA9omTsPeB3fXvKID1bV3peEVuAksLsxk+un6U2pbjo1vRuYuN/lfdwq9ws2NgBJXi8sOEDbxn1KvNky4S25vT+8b5UjF0OkUTGq53ihIoNmQIZEgicV9dYOz5DugwCh6pwX3UH2DqCfTZSZJqaVEwdlbHIcQHFTN1SRVtquMrfA/X7Y6FBeVNvi7g7jcGGNXKJUWXzChFANFzxxFoVL0QZWzU72DGkF/CZfaA8m1OwSLD42JXiIwaNpLtl7jNz9iqW2hV6VuGJP/yc1AAsUNe/j65NpsfnCaaXj0cQIB5s5TX5sw6M0Rve8xMI7iW2LbVznANxJ5GMyXoYW7DUqrSM8H1cUa7ZsQyaROfzx93eLZ6JyR72oGVFZvk7gheWgLoCtiF8Sqsl7pNbKZTLAOIoEHvhg5VVD8wa6VAj8LJbISCkRd1WArc6zB1UyDBQH4eOPioBLjCBwRg7WY07x7+1EtK0RieVrqO1liSlEIOt4f4rvFunjYTL5KBoawB161JM213qH8NnMzQYC3UxxnB3Ar6eyHUYXZp5J3Y+dD94Y+K5DpnXWvVTTsoOwPIehqHTHERjJVk/9T9A/s9z1n/ZZPKIk+O45ZQ4BrIDR1shoXkDDagGGuHdAVTSNuwI9JtNx+LiZMMIMt1COPjCxkmVOtjAqMTQAUu8B1QTOPNKnQ6b/
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(23010399003)(82310400026)(376014)(13003099007)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CX092hmZDtRAmqkBpI0VksMoKYUqmqlzJLuE3bf2IZOkxtyI7qGWYhCmXUdt+Bj9IkGbr9jCc77Vq9MZccnlVcRF1xnByjBzj/IsRzjJpUSMbVxrU0Cfh05F28eH7kaeXv+NOWzvwPkONM3JAFmMbXPTwFwvc14cem3DQBTqByVbhHz1zneghx0G6IZZB/anJigFKcUcDUaKOqTadeePMvjWKfeBsDXDPgJtVoonuov1NUiA0fh/AjgHjRhqpmcx+XxzLf5ZsN308Xsa2jsHScYi5FTWaL7KJVGFc+QlU0eHHc5QDR9NlHfWVAjeGRb6tPBsOBOdugla2qcR5l5RpJ3bIImMvkmvaoRmnJ7I+vNFhm2RZnKUsmd9KD+8mLct5u/L9U70Q1SxTA83/4xiXXfNDHIiHIdNYHosV/dDFAME4baakJhStOwnlXHTJ7JN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:14:27.1679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e81f8aae-029e-406d-40ec-08decd2260fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523

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
Changes in v10:
  - No code changes

Changes in v9:
  - No code changes

Changes in v8:
  - No code changes

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

