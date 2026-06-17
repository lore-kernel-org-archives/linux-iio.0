Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FE733F374;
	Wed, 17 Jun 2026 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719330; cv=fail; b=Q8SRJSfMbGoIeA5breR+m/jL3Jqphd85MibJK18pS3CKvW/dYWjRIQHsHGMAstciKDMZoii0lWNCot4jL8Z7FR94qagmfYGvn+8jqbO8ouADJHnjAt1gz1nqFaEiQ0lL/OXiNf8iAHBz/D+RSKA8ZZbo9kkgOGsezql0bT6ccgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719330; c=relaxed/simple;
	bh=NbyipWxp93jQavbJLENxHwjm+HUfq21ToaMUES6morI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LaH6TVymbuC2I+bt3KFYkU3tDLEwQAdQg9JSKx0r0cpQyCOZuUsRqBUJHheiTG7Zlq70GSpWYu84jFvBRXzetxixdR3OPqxnBznbH9e8mdRLInWs3k0itnackAELPISEcAXjqIsiwMMIfIUKErlnMx2Ga3wRVrDOzNe8Yw4d5bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ytc859Jb; arc=fail smtp.client-ip=40.107.200.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ytc859Jb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYYm/DlQwh+/ssh6IiUO1As0Nx/ZMm6RXPdLZoSu9eOK0CuQ2uuxZC7IQdJJQZdfCbuQtI8YxVrzLH3E8t88O/fpkyoTwBhe8D0gqpY05bBKHkp/0t7KK2DUPobmhIZJU2qy/kDVs/WWxH3x6CUg/9+RAjv8km3SkEtJ0+hWfATaSq7ZvPcnYLTh1GkCcIbe/5VBZJOwqmmo6oS0X4U4XxQ4YnNTpXSppG2wjB0b6vvEocYdGviTdd5nClA8p0GkkRoz8SgYzo/bQyxdXB7Uh0nkQU0BiD1mAeW+i1SGDQWVZa/qihuBBH2iclEy2mxg3brSa35PfOr/p/1IPSbfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xl9OA2l1UrUnwsXrY3ysLtuH0OXqujiSyEfFT6dLU10=;
 b=pd0n9giYQXSBVXJWaGaSR4odBNyd/r3PY22briBa9KgZXa1t9VI8Mb4JyCpbpvJlz32ljMT3kM0SHlDC8Tlq9gPDoSsl+FMN2kdb57U+tFGgDIiwQRR3cvEVQrr6Qlh1+dO4adZDbQzFwrkG1a1b7DIYZAGVBMkBeq2zEZWQCsWJadgFQDBwaatxEtAaR8iX8JRFA/PZCZmYYH9jkwBkNJFOsjNBW2ZTzS3Sfvrf/rffFP/7m/sv+dQH9So3psmMMogajNm2I7Izx6LKte/+cCBf2CpU3a3aYhiscoOxZ5UYD6p5yn87ieIOBfJYuJdZ3YOKxwoq/pJ8tl8/pmhR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xl9OA2l1UrUnwsXrY3ysLtuH0OXqujiSyEfFT6dLU10=;
 b=Ytc859JbnQ1EuT1W6oYFNg7gpAGYBPhvzG0QIVAXCcoO3AP4pi610DPOAUW4dxliZOBptOQ93xODD5678YNmmzz+WHxxZbo6dtOkDl1qP6rUQyUJuBsNwNFa6ylIvS8g6tLw8MiZdSqT6fKh1gNZSwyejZ4GeFFN+iT1ht4PzIE=
Received: from MW4PR03CA0312.namprd03.prod.outlook.com (2603:10b6:303:dd::17)
 by LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 18:02:06 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::44) by MW4PR03CA0312.outlook.office365.com
 (2603:10b6:303:dd::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Wed,
 17 Jun 2026 18:02:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 18:02:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 13:01:56 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 13:01:54 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v9 1/5] dt-bindings: iio: adc: add xlnx,versal-sysmon binding
Date: Wed, 17 Jun 2026 19:01:43 +0100
Message-ID: <20260617180147.3370346-2-salih.erim@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260617180147.3370346-1-salih.erim@amd.com>
References: <20260617180147.3370346-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|LV8PR12MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c70d83-2aac-4287-dceb-08decc9a8abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|82310400026|1800799024|11063799006|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dkp2woQeL+eAOF0cHTrKIcHehmeB5KaqCre6n7DSo2Rl4upJKDk8hkYRePePKYE/YBJiscOwkZrfDDvg6zNJWLjL7r0W07B4i/29KsyQg86FRLxZvEpgLPfk7Kag2lHwsmidZROI9HQnURg4b20DxGMSJL2Af8p6VViGAs0XjG+h3RKpMpVKs/iTIB0xOwEriy+r7ALWQQ02oHO4newAcZ75IqyLpgSptMhO16F+lEqDOWv6fHqU8KYwNS/wX8FME3sSNltb/+V482V1NQWPRpz7zJs54Aem8VXLBoRRzM+dpAo0cZ09ymBbkZFFCugPzoQSBFde7c5pOIPDyixUkr4f7CtTm+7d1em0RK/FgaeEI+XKCUibHsLR1OVr9UKIzYXi9hAXCLDRkWHJvye4Hwjo/qLNgTzJElJ9D4B679oEDPhnsUn9RMF/hqFRB2hZ1ckzl6NjVD5+470eP4Q/I2iw4IPMQWMtR5cZk8kwLiigGn8jjVgGMhk2hifzO+LvHtDMyhrj9HZ01qQWJs8nk1DLsZ1E7F6mn7Yxt2GBtPqCAHEwxmU3ErY92OsaZ5yJlKQQTaOm/VCGyeJ872BIh7QXnw0k9EiWJIvTCFo424s+yWIRkB0SxFabokrys2SW+i6gLtk7ZBXHaEVCYKmi4biUypWyMI7ls5Nc/M1l6n6SJqZo/C7w+ho8fmyAEscf
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(82310400026)(1800799024)(11063799006)(56012099006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uM9nclzRuk3F5q/deX6z0NxoXN68YV5O5uiVpgSJJ7InHnuWoB22hhS4BMJzo6Xd2RwNjuqUOBenoTTEtw3YZ4y6wAH5y7J6tecMLE4ANUkDAQm6oTSZrb0y3iMMsKYM+O9jxlQ3zdIKBmrf3NEN+VVFrhS1lhc/8bfDpkYAf/Nl5ZYCVS2tSVcckReyO20ZyZ/RKkotMIgyO7oa+zcheCGkxFeT8IlYLxyb7uKZpa8KUOElpP2dTenMtZF8ijxLUlL0NHoHnr3g4qW9oyXcFbbWiY+J8nxvkzDwRL7EPmdBYuwcAFRMhwBdNqcg9A4W5lZO7by/qxGelOmdlE8oY1bdP+HgFN7EtQC8+voHODu3VPxWwoLA8o77hTjkDNeZkLg7QfMLwfPd1Llb2NmIvUTlwYSFOaux+ASYGkpW8hHnFOL2kFavgmfHvwJhXJxG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 18:02:05.6785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c70d83-2aac-4287-dceb-08decc9a8abb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9715

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

