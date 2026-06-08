Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF953264E7;
	Mon,  8 Jun 2026 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943891; cv=fail; b=fpO9dXFyb4sCEZ+PySry9yNS/uKPU3ZZgRA00bdWKpOkumBQ06J9KhwIRIBimGK+RCdsWIAJzo5zreXlEtSCljct6+oIjn8LVSGuWntSj00DUL9Iqqa7jOQZzPaMVIdzo1Dhkgky7tixYMp/6N1eVsizGsCgNj2P9LL+okfwklc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943891; c=relaxed/simple;
	bh=6h+sJJhQP8+8zkNxGZp5CA2IONaBfVrLoOflUIn5PoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbO+HeCCytcm9nj0nXf3+CC6soEi8fsxhDA904RsEyXr8RXqW0WiR4vB4nsKqsULvHfLt5Gv60/wkBKlO5dKjrxG0KHO26OIFknhFPsXaMa7XtF8OAG975F/CtpT1iLqOQbUrW692dnlLqvtGfi0NIZaG3Um/3v/BwymvVFsEgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KzxbvBen; arc=fail smtp.client-ip=52.101.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KzxbvBen"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o80t7mSII0+dE2syMLPRhCjIvb3dLVVcf7QxHp10PRzhhx0sC8tu8ou8HW6cnW1Jbic52iJyrQAq0i8a8geeJ0mv6ocbBkfIMjA4vPuOOxrYiJghg7IEiB9aDlJCBLysU3s2GZ87hG9uX3D5vkwjJxY4Gri9HhMGfuucDKq0Iwx63HIW2JNEhW5XPCkoSe8EbM4u5U1eZzEPXjnNWYKopLqq/+Dc79gjzKqk7nDRcQqVpJv7Nw8p4GdE9KUHwl9LUnAn+3YPx/Bc72q8WZg0gfL7Zic4y9hhZikr2y/F5accteJ/H5Dlqlazzv3gT45fz3t5wXjLUwIOvpVeV6I0rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saY3gN3fXoDp+njFpd67Euxlhz+vm56GrS1Qg8J9GMw=;
 b=HDRqYJXt59QwhMIiRKnYP+zKUDCupWocTQu5PxNksUjfTVS0I6eErp9u1tJECY7lA3vQ0s6qgnk6FiJxiboQmc/mRzK1ZhN3ce/xkab1Mqfg/UYWiD9nPiKxIKciPjMu9EWxyQolb9BVgQyeEchiKW7iuyFJhvhSNCjIu/mmNUC+eyOMSuLzcDtddSiluQrU73d/5peuJ7+5eQ2Re3GBgkN340wBnGU2C+BtBwleDzkzfQzjb16Clgw42hQE9Egs4Ursp1Ocqg/Cq2UDh2pIzDdWFcfll4aUv8ZkEs3j3wy2NeSdFebDIeG1xwbO/Kmyoa0HlPNHACHtOwdZ7hRO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saY3gN3fXoDp+njFpd67Euxlhz+vm56GrS1Qg8J9GMw=;
 b=KzxbvBenWczgq+3E69LXC5i3oUCe97SFcyZvc+Ftfksdfk/RebBrQbTOo1QQCybBXbeGMSXcykrt2reWbxYClgtvAUQgBJcWt1dPb+GGnPvdYy33SXXxBrVVVKSYI0uazMRD39A70eTMuofj3uptfKPP+wWbJqccDgZUol3z6Q4=
Received: from SJ0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:a03:33e::7)
 by CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 18:38:06 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::6) by SJ0PR03CA0032.outlook.office365.com
 (2603:10b6:a03:33e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 18:38:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 18:38:06 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 13:38:05 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 8 Jun 2026 13:38:04 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 1/5] dt-bindings: iio: adc: add xlnx,versal-sysmon binding
Date: Mon, 8 Jun 2026 19:37:57 +0100
Message-ID: <20260608183801.1257051-2-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608183801.1257051-1-salih.erim@amd.com>
References: <20260608183801.1257051-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|CY5PR12MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0e14eb-1ff4-4f23-60cf-08dec58d1502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|7416014|22082099003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	wgHeD6R93ZboIAgpeShC0tg0H+Kdnd+1WiMX6GrETkSJDSjMwfzQhV15oz2ZUyMnNjjK1ZEHj/Cvc25ajUVnIABI/WIpvESv8mxiz31QYlKJVvCTx5jF5pYWCOdP2B17cKlwmT6GcmA6Rlf4HdxDQ2MYTgzx/tJBNSXU1iEri6p9Ltl7LotM9bZIZannGJf3brGwiRp8zk6PDU+WW9LQ/P8AuBh3KpuA/qStzAasHzvKJqCPXR4FBo8f6D/9vuSvDJJBEHevpA40ihFwyW9zOpFH/RbW3yLcmmALPgkDVLJLyVTSPmByhXxEktBuWhgbflwUdymncPiuh3o97jB6XcdD8N0Q98+sKWmLqao1arvtF+FOjlS9zbBt3z4LxX5ppcXc4xHBIbTlDdcaga3CLyxq4FZlSOxsYyXuYfucXQOAV2kyLicHwXih9B24Lv/B2ZQuwtcaDbTHYFdREgQ6p3coZy1xXMBreh64uTiieZP6mTQTcrxC4Xy8DQMD9uQwWXLqe6TAe5G/rMHQcOyz/y/H6+jG3aDYSMJzP8fF6nxzHoe1zc27QDEpqoCFHm4ZkYbQGhAshyYwfXaMxXANrdidDkDSFFjvSf4S5N8BBaQ0OIRPCHIm/qmF3SkvrXg0L/E2UMmcETaVF6oB5Oqo5OrvOfUU3NcBcc4VKnh657bUlbpBLxbMDR8Bn9bzfFVm
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(7416014)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DdqhcxSOGHE2ikb5HPVgQ6F1N2Y45BxF6r5cYdntzTXrCn8i9RK2Y/KeI9Isv1uoSfZjTrMEh7jpgM8lQFNeUA/gKM6Fi4tZuQd9HTolMqBs4msjrqiVqQXxsO2n481VRjGVX6QJuPxG9SmOndaBfGA8CsP/AnpC7jykbkdutFGIb5lHfA44WxmtnR8OCqF7gJ5OZA2jIKnpYeLa4GDsVXnqdR8ndtCwPgjn722todZl0wA+YkVcr5vFJwPp9LN0FrMeA3ECawbsLbmPcQFK9fqRwsKCyx+GXuCH3y55mnjKJ0YAoeLVHQYhOiXsBWJDKspA2D2xi4pl7vYQZvmHX9eF5qDMiZPFtNlQd4Z8t22sQP1S8HhN71qOZa0b5mMDgLjR/FUeTe6NpRiRaHv9rSIeqposFMhoT7VSRM8zSeBHINJxl/33JulUegp1D2UX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 18:38:06.5926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0e14eb-1ff4-4f23-60cf-08dec58d1502
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053

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

