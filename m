Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220BF369234;
	Tue, 23 Jun 2026 01:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178851; cv=fail; b=Mv6Mqte85oPLmFNsyqrbwNWEx7P3zXN223uqJdZWUa9qcIUhPX5KEs7KumU1Dk8fHVQjsxeB0k75iJzU6+6+9ZYibeZIMu+sTo6WgOEKEYEbBTBII/k7ctS7sjO1icZiFGevXCAamgtpbIBpHRqxMcaxR9zqOrPQnnWgR2MWkKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178851; c=relaxed/simple;
	bh=deIKJCCbk/+RhkHVakoEoOsXorm3+9JwyUUyiScs4i0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKok1sN+6Hz4sk1hE7nqY7SKpNezD44as7qT+bQn59DGRLbGO/d9PYTlI9CqxtYFwOrMUVdxhLZv7e6wHCB/sun+Hf0Rh/wOSaR6m4Dpa/GeKqudMqxn04rtOWmRsRFATsF94E0EZqfHGOfIwWZMCOM+G80Z/mkbkYvloEyN8bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0sB1+7Bf; arc=fail smtp.client-ip=52.101.85.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0sB1+7Bf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbtYor355y49TTa3oOTKfNrYqf3xAl7SDqHJ7uSefFE3PtZC3SGtdRM2JopkJYt9MFK23bEzMfM7pvbJKci300sidM01vjE6K9x3p3jGDHxDMu1b/8ImKODj/oLt8anKzIweqZspesm+Wec13qzCpzWtRQKQ64bPMvXiP5mg1juaR/cGPvD4LlGemFreQNqXRTu005eYzT7LqcnS93JvKx/cMNWuKl2verNCmZ6clixMl48M/ah2MPj41v+rcf8sGvXjCt/AprdxcLABRHVxYGb8Yuft8qefU8mtavfK66Bqo3bPO2AUa6CPZMSTCSVW32yEwWGVODt+8qoTN1L7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+VoURl1UbCL6lOJ5ALMBeyUAAnTi1eyIBNyoPIPeMs=;
 b=A/x/00OOKcUMoj+ez02hMiRAyJg75AKo+RRp9G8qXhi2wK+gfiqRGlnISiBICfV93ttapULWbbW6vXusWzjRFjGXyRpGHwLft7+MMRz8l7hRvStBMSz7YDFeqJn5Vrv7oXW3D/MX5nDridGvFeBLamyLTIXjkXRvmtcp9jymJZews+5jiE2LjEpo2KZ+peKApVnHosACclYHkvHNGFkTwtN/fKQSrX4chzYeeaNe/6HImtkcy68JIHlsBQlT6yMi0wVsLy43v90JLT1OaVKeEzjaO+c9i5AJAEWhMqEktXUYDPrxWUwVEMpFozVlW4AkT9Vtv7HhQR5KLKl7eNHaWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+VoURl1UbCL6lOJ5ALMBeyUAAnTi1eyIBNyoPIPeMs=;
 b=0sB1+7BfHJvO9fh27k6sFs1YP/Ht6bhqdP6g2slsqDDk4+aB74waxG1mhQlaStP5fxbrTkrNn//hvc6RBpmVWZMM9PJY2MqXtbyicXvvRY5j8WlpZ+zDqgG6fbZUBxRuBd1+IHKpQxq4CF/A91T/WUZiv03BM77zEzUP+uyXctw=
Received: from BY3PR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:39b::29)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 01:40:46 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::a5) by BY3PR05CA0054.outlook.office365.com
 (2603:10b6:a03:39b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 01:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 01:40:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 20:40:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 18:40:44 -0700
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 22 Jun 2026 20:40:43 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v11 1/5] dt-bindings: iio: adc: add xlnx,versal-sysmon binding
Date: Tue, 23 Jun 2026 02:40:32 +0100
Message-ID: <20260623014036.3865402-2-salih.erim@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260623014036.3865402-1-salih.erim@amd.com>
References: <20260623014036.3865402-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a9da3c-9035-402d-ef20-08ded0c87225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|376014|7416014|82310400026|18002099003|13003099007|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	yN9LkbLqtRbiamZVzVR/e4EM1ABljP+o52VYvtyRvlq3HX7hKd1DCn2BR4yHpqW0zBF5e5DAF5KD92ryordp4O1n8ekHO8emmp2QuLnt+S07FY+X3pjeW+7fJ9B8+ZlTTYjzw3Y3Yfn7WFRSXuD0ReaIXQi2UVD9DqjtRS/HKp1iZmNLcRm87n+08xHADV/nvdDEcBMZGpRepSyEzCNf3wEPZGkUzGe1UoyoILnrqeOox8eFL+xbOGaxMbN0cUwF2kvKs9OwB4Ty8ktQknz+5EEXl/O6AyvdjIfJxRmvriaRXcKni5LgGyy/MnQl3BZOKp71Z9oiY2hnnB16b+kmI2DBnaioQ5R/E0kn1SS/lq9QF6/nbPQEELQn+5CN/KZ79nLXJ/sh4ZVsr4yK5Wcn8P8mXN0XKRbgo80ih79Goj/5WTsPyWkdziqe1vgYgzTAPOiwTaRoHSJfYRNA9glFok4zaHs+MF5DbDTuuMS68wA/YiT8Ef320YE8IDU47o7yvWTLeNtfdT663VZRxNUp/dvq9Utwgmh4sEy+mA0Qjp5PFh553RdxWffgGMegxLs/B5SWZsZTzjiDFwzyArAfGr1MDFn+7BCT93ABX2T04ge9xPtiX8DNN0tb3cgiB2fsu9Zuybn5ZqTPpYRfvxb7FQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(7416014)(82310400026)(18002099003)(13003099007)(22082099003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xO4qTS5OFR9Z/0Etcasv6Rr+yhuAQQC+QXcXxhXUido55P0SzcyMG2AR9/hZy4vhLKkk8KHpSYmic+mHjICgCHiwmtT+rgiHtM76XwJKYvC4RzxmbqnlgfBIeaUqVTCS5hdBUXR04t32ebDE+cs3JP+31R801b8KsivQBdF0c72xBltFTJI3BY4k41IW89NFrK0FrBzcemKK4H6YiFnOynIwe0FiDqPA0K2DAXHw2cOwWz8NTMgw0Cm7iZsswWp3GnNCkoP+rhqXrcZCPOODxPyQmpVceY3/trusAFq2im5OL5990kgt8S6K8lPgQiqaNCjWLHbv/U/Eu42vyYsIdOKfYAh6dUhFsdQIP9bSFy97iX97BHbEnEtWUNUlOplGEQKs2sPq3XfpSPYi/yBzZq9LhsYRerdvhbYmD0i12GiGgYbvxPVLmIKK6WHNwzqf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 01:40:45.8987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a9da3c-9035-402d-ef20-08ded0c87225
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431

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
Changes in v11:
  - No code changes

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

