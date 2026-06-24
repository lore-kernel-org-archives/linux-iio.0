Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC573B38B7;
	Wed, 24 Jun 2026 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311970; cv=fail; b=N3THueEDKHAgfSqJW/nbSx6/r58jbpxVkkJ3lGq+lx4rAqPsKT202UBfrxplVO/eTAAhtgp3ESOg4qL3v/FsyrY7xMMRhDOFg0NOBWU5fsoTBKcyeWOONMM6CTFGsP/8M7SCnTHxbqYJGz1AmkD8Yi2AfgWBeAhcJf0NBKv1vFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311970; c=relaxed/simple;
	bh=fmClyXUY0ezX3ez3XIrGJTMg3nGWWQTfQPmV8gi/tmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKSJxRI+WG54q/W0du2t636yB+j+qCbQZBJH8TjGR3A3WeP/DUHGB88xOPagc+OSd6TjqQ+NeuNP84qwnp8aRMW+XFp+1v3XltSqeFlb6chrNyFYpJSBGOoKbhJVtI/M7sOmFfCIojf7oqpRFJd2lyJnRuYlNh+d1mOw2Cu7wYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EvSq/u59; arc=fail smtp.client-ip=52.101.62.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EvSq/u59"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8x6auGMt1rd6zn+2YOObrL6GbHkh/75zbn9D8fmWezYKwPLkT/tHBi4dPIg+YuN7bVTFf29GUy9wbIXiEmGv1zK32oymeNuvSn5WvqYP2iK4y3YXT2N5W5vumU36x2CPC7e7ovzYs8fzEkq1gdZpIiEJrPZ/CQED5zD5sOIjQ3ForP3qBhN7KxSqvpHTEl5o6Zb2+mDq/kdzEwg5hdgWQd10PvvIsOAK/WY6wsaAFRdhlkFkYCbPkaHG6ZVN0CC3/SlO9Y/UFwwZ2APTuyznMbIf8mdgRlEzf3Jb/8Q4SMvg8KydTDzq0Blo0fUpPCLYL6yX1Bvqwh94DOpnE2f9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qp6lfkJEyqRy2EDXNXi8jb4pZFvIV/HSBEyEp4w4IJw=;
 b=Y604Iriv0kXnPMlRrL2jrjS0qjIBz3+ozRoBbRrq2Tuh8hDkdUP0yCcDQXeFGsEBWM5rJkJyFze62TF/LUAD+p+t9gow3hOYwW+DNjqBf3UqUomF8YsJmD+W2zvapM9d64LHTQ5bMnraWMo5/I7DDWcfkz0hLp0yhSsszhk8MUsuGfK7gbYUfcQwYV+HWFrUQ1Ecq2rRx8IerMVD3EO9kvqdwB0BgK46ZR08fQOacOrJpsJf5IkrLZ6SB8lhBkQumL3aKl+rzfRRXMgbZobASN5EsYkG9dydkVFGhDU4AFFhDBnMZg4bGvUKzP70FUSkU6my1D+fRJ2fg+hiHUpHCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qp6lfkJEyqRy2EDXNXi8jb4pZFvIV/HSBEyEp4w4IJw=;
 b=EvSq/u59v19WqsiDcrkFeNmTF+eEQlIV+oTYAAlKrT3UBWbxerAlQ6q/XInyQR/n0dDVJJj7QRAY0Tu3u+rk76B2lKaqgTVnrFWbxcYHfDXPVuZuS5GBf/oxlcPTJRAJTbmypn0BjDrrNIWlUo6VhTpxt1xFN8KKUqYUYMgjRR4=
Received: from PH8PR21CA0007.namprd21.prod.outlook.com (2603:10b6:510:2ce::13)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 14:39:22 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::26) by PH8PR21CA0007.outlook.office365.com
 (2603:10b6:510:2ce::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6 via Frontend Transport; Wed, 24
 Jun 2026 14:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 14:39:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 09:38:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 07:37:54 -0700
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 24 Jun 2026 09:37:53 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <sai.krishna.potthuri@amd.com>, <linux@roeck-us.net>,
	<erimsalih@gmail.com>, <git@amd.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Salih Erim
	<salih.erim@amd.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v12 1/5] dt-bindings: iio: adc: add xlnx,versal-sysmon binding
Date: Wed, 24 Jun 2026 15:37:18 +0100
Message-ID: <20260624143722.4047649-2-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260624143722.4047649-1-salih.erim@amd.com>
References: <20260624143722.4047649-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 10166eb9-2f52-4d75-63d2-08ded1fe61dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|7416014|376014|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	OZ5RvkMrwVC/lWQkZTQqqQt2na0mnkyXaYCZf2y7WajrIK1w3xYB6XrPYG3fko6cScTMb98vVyucYXYeVPhItw75yLSSr6Tz31nVONzrijz+AU9PrpbTv/3gz8n8aEVztcMZS/4ANyB1hIRndF3qRrHU2y1w1a99YvleJ/qsRvDyoRenqpAc8T5AjzTYyzueKqg29cQB062suu/CFvl10O1PA374DjMDC22T3ZOxGecApyI9mNx+o9bPE+7+m/b3ZFDrjE8wnXKQ7loX6ZEinEfU6uhAOoLFdu0azOFYp2YFLI954HSxvfh0CxIWLdV8QgIvnZq6Cp2XP+m35DiKMyTRNrQC/v1qQOjDQ+8EWpQ0fZ+KCsgNCIvvp7YzVijMX3Ma8Ex7OqCL1F4K1yYD3fstu5N6moPXgv54LMzQeZS6fEEWgQjpRh0R6f5oCvTNDDTXO5zZJoAdZDSx/ef6K4iurlya5lklZozrykFbzoUMAUGvNp4EFTV3/c4iZeTgQLS0gqfimt9kJ+vFHa3jjyXPbu7VoAgCeT+OAvJ42g++E/LMzbgBd3fIqOmMmv4i1pwi3G34LNzndcnm7Nj+EK/XJdo8Rr3iS+ntrr1w/q6uTucP+coVcqB5v29r5nfkFd50pcswoseTdmbUTC2Q4A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(7416014)(376014)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bqRRVHvbOQXQ1bYoMLIenVFW4lXD9PRfboaYfgSDJOHaiOnq6mF5YLzrNZTHJ4uzd+PVA86zxSGmARmgUp/ZVC0tOFjlTD3DzJr8IXmF7Jp012a0uNif7RUOdVKZNOpuEKoz51y1y498GInGpIExrVU6wfpv/zc+fPj6igeKm6rDz/nU53T4WyJh2sEjYO5vs6Vqfg3/Kh9NWSPRciCtl/uaL6k5iG/++d9fdsV9T60uUTaX89VFTJkF2b1H1C0WP7BcM0UJRswhM0wnkMy9w8Yz183kZOqenx9BYE6B2490DiUWqQ0DUfcQbj5a5ke816K3J0xa6gwshuu4vRVgyR9tGS/twi/wypy1s/vs55kWHp2VGCHPqYnmMfYkNbeDzbXTOC610/qAODh01IppOMuS+oAx2J2tHBQyCBAzeKOLNO1h4BH0AOX7If25Kd5K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 14:39:22.6502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10166eb9-2f52-4d75-63d2-08ded1fe61dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807

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
Changes in v12:
  - No code changes

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

