Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010003.outbound.protection.outlook.com [52.101.193.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D383FBB6A;
	Wed, 27 May 2026 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882152; cv=fail; b=JJ/N+pve6pMqlLKiJ2+90FFEUgsVvml8mqpXe/A24rghpIW3CVRk8HrzLsXkTYzLbbT+lVnYwiwVQjx8TkYgJEJrE/+YRn8JzV9Ii44FP/IRr+Vo25LTgaO5lA9/bfWY4blZztcw2R5gWPLdULDUOO6YamwVdPMbupHV86O0098=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882152; c=relaxed/simple;
	bh=FpJ0G2OpQfIRDwXdCPDXIMLdqYr2Lb/E6xyD4D3wyhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcGmcofTm37CXxzZ/uFDfJwtMt6jZk3It3wQ2BiWo5drogybSw9ePkWgEURrZ81YNqYZlfdmYUvikEFffoKIhlEOTloyPEixWOqBRfnRny2Ps416TCjJcP9XD8/wMfAFdWuHqG3eToq6aiOaBSwdO57q4cHatapnWnWwA3h8/8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1dkL07zj; arc=fail smtp.client-ip=52.101.193.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1dkL07zj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwL9xdZyJkCiWZWLNbwjl3et4opdnonjLQskq0YizxQ6K6v5GhpCWWcHxQpxjVtWkdAALT0vfbiJv98USoz/zaAT+zZCheGcRvcDe41f8DdgluIrDJW8lKcbSmIbrMcSTIX+DiJf0386BghElCrH/ZC4ZPejFuRn1YBSRh7ep8MjuPF8FszynaCNWxaE+rrYHKjelk60iEzbzF4ZzCJYLbng9AP1qbosN6AZH2a+E9+QMDZ3uJHPxXcwBss7ZaXOm4MxGjSjZXqb8Fhx/uAYvjkBYIMCW8Z1TLUSr/hWL8keLJiVlZjlxe2XUWxOGgLtJNt+ZpX2bvaEbkN0haaCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+IStlBnCWB9gly/PwaTB5uD+vmCQUjREmJM+BrsDc4=;
 b=ODmxc3W6lFiNYv8QSr2NF8S6gJyzke3prGLIfm5KwzT0jsYSxufG4OY3t8KFAN/q24HkMiJLlSSIyi1yblXSvPM1gr0zY75cTlJau6YUVyi8KlxGKvQp8sRl0akK5jJ4CQmvKS76ItxMkw90wgeT72yxDBVlQq3PGIfYPuI2g5TN3Cwz3vT2T8njzx2Ea61m6tnWd2X8xiM55Wn8grjcrRpvoiQBAdakOcjnOwyAbyPTUi6lD90sJ+Nuqan1o8WZgMbkrD3fsf8AENwBSNq+T94lvYYgQWQ5szGRSJC200HC2YMNVYbeSE6EjNNNK8pMNt1tDoW1VpPTwE+CGC4nqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+IStlBnCWB9gly/PwaTB5uD+vmCQUjREmJM+BrsDc4=;
 b=1dkL07zjcfnJ9CW1vF2XnXMjOu/tXam9ge5viNdM/JeaHWUpwWsadom9cx/rEriUFE+FqD1jNECMA/MZjEd5YDfFiYFgVpbm3fkp+AUMIX9VCP+PaampVEqd/J1Ibmya77kO4y6DRVj21tjiig3e2KZbcKWEyyR/srknFKd8lW4=
Received: from BY3PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:39a::19)
 by CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 11:42:25 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::8d) by BY3PR03CA0014.outlook.office365.com
 (2603:10b6:a03:39a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 11:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 11:42:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 06:42:20 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 27 May 2026 06:42:19 -0500
From: Salih Erim <salih.erim@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Conall O'Griofa
	<conall.ogriofa@amd.com>, Michal Simek <michal.simek@amd.com>, Guenter Roeck
	<linux@roeck-us.net>, Salih Erim <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v3 1/5] dt-bindings: iio: adc: add xlnx,versal-sysmon binding
Date: Wed, 27 May 2026 12:42:07 +0100
Message-ID: <20260527114211.174288-2-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527114211.174288-1-salih.erim@amd.com>
References: <20260527114211.174288-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: 80759011-1cdf-47f0-5c73-08debbe50565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|376014|1800799024|11063799006|3023799007|18002099003|22082099003|13003099007|56012099006;
X-Microsoft-Antispam-Message-Info:
	BAXYUtvrKnDyOSPi6j7o7Whc4Zz7Ih01o4GbjRYwQ4CSS61ARrKICS58+afdNrMFumh+eBVrAsob6dSweH2LcR80P9tunJ7YefZwK0UDD7ep8fGpPoRXtfK0bL2LRjjqsiKv/lYM+uupCxjmwuuPPPg4uKjWJLiV4kJoK3rlS2JZ7QdEx++0EzjAnJvVehkcv4HfB2nrBx3Yt2ObABZHe/l2AzIP+DCFTAS6PwUNt4B02Tsu9C0F7CUdIST+qp7FnAkq1bHQIxtBB9V5SsYpJ00MkWPAb61UjNf4xCXBnymFTCk39yPS8wwcjJ9u4/vA9lg4z/vR4W4Z7XkIGKWIjJW1EGzgfVnNNLkTMzKnbdUNK4hxyvitHm0mjKSN3T1QjCgbQ5ZnPvPM1SP5mNBe4cymSY9FUzy4YcKePCsNwQx5AZyWh4idPzLZLSoLg5PzZikNEAFjS/mO7zKvZpB+JvSs/KfCfEcbE1QcMFhOfK/rC0lsH9sj0tXeedgphWxRvAoX9W4ewoF9tcDlP9WElD84cWEEDd2U833WHNJKiNc3L3WvtfufymWau5ZBZU6BYJfT8MmIQRfSuLmr4NH1dhTDLflecUnJ4paIoMxY3xBeolwqigkWLe5nj4IQS9yP240NtYq6z63/357YgaeB61vGipdV7AANYIVNOHPUa3sFfmcSf7N+fNM6UOcbRUBN
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(376014)(1800799024)(11063799006)(3023799007)(18002099003)(22082099003)(13003099007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vqyT8RHBR351Pr6q06FvaQ1Z+D1hoHICVc2/4bK6vNc5iN821EH5dFEs0xlhJ5WeMIyj0NIgirMlg1BoU8/gn2DxaRBJz6xv/K2LJZe5RF79bdHmTker7mmg3X/JlpR/nK5rSZTrw1xx79lgXv9C5vW/NI4W+jKdSlAX/jahijalLYrrMILs3q+B8MhbPiV4e87NSpiyrvz88aLFiSH1skRWsfhkHPQLbuS0tAmz6BSM/Hpa6v0hRJidCndWLSFbU1hagUUcpszp9jFEg49YscDBGYgaOZ3rbeZnND4GE4tHnNgiPBEIj4RPrq2xWIWdMeLZ4lkydXUz0LIcd1N2nthL2bPevh/jP5GVSk5/WyD6GyYbQ709Ktv2E2Bbc5badThtFhT30E9LBGXQmyjyfjiZ1ESx6wrGNjV52xxVPh4xPQFhNQ9PHQfZxxeQDUFI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 11:42:24.4931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80759011-1cdf-47f0-5c73-08debbe50565
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790

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
---
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

