Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF323233938;
	Sat,  6 Jun 2026 05:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780723055; cv=fail; b=uYI4bnX878PGgkyyydjxEhs5d56vMwtN+cvspOqjnJJN5Tpm1iYDoDzu6fqatIpij46Ydn6yxrFfirHT/X2IOE75V3Pk0DjfnWVL3baknFKp/ahhgpamqYnrFcDYZp9HjE0pbOgq0OEeWOLMadajrnO3GuyWokWbU09bFsYRw94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780723055; c=relaxed/simple;
	bh=TOTj47dT6INyWdjs4A9RF1wJr/xqD4ixwueX1DS2vfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fey6+LU1eltJJBJW5VQATMxV9ApcZEe8VQt9jLidrsinBLB542Zvow9IKGx1bFAi+pvAME+F077pEn+6WIQqwlB3AzkKEHP3QkkC4o814/ejoVEkSqmd81heRG555sBLRmtKeLuaz85/m0IaoIG85i9NhvjJ3XgXqixZoJ9rrq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HcLA7SSo; arc=fail smtp.client-ip=52.101.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HcLA7SSo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7lWx+QUrrKhHgY7Gn5QQVuhAkV+Y80AdB+Zn0AUxiJM7PW315zcrr/Ej+s45mLBFNMi31BgxdLwZZ2mNOZ6x29aXhA3ca9BWgz/hcrZgEYQnAGXF+CnnxAgDaIHyjzmTSM1QVo1K3TP3JImYhI5geuMNU1pl/FCcTvMC73GIN/4f7fnl5PFGmR0Bu48qQ5IXjXzNI7raR+8gsvxAZonMo0btwv1XTZ+vhMgC33o252rU0tDC5nv1fLEpT8FAuS2BirzXM+iCjz8tJfHMw4a8kIJqrHaU1Zm9pkJlu3ozgiVUiQ8tZojVm5dhVjsBz8ztoEzHSDSibOrC6JhNe7sBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/r4SFV2f1gvIPIGbTH5GdGVu/6v6BXswa6Cebvnvxf4=;
 b=pgnQAq9VE//djCMUBuAmnHmdNFcXZ7EeNuDEPeLp1Xh9bNSIb5u3Lshh+oOrNagtlhMcvAxESVmk3IEHay/D4n7fFr37nh0Kt/M0TbMXM6qmgx2uyQXJlpXbgr5wChCuYCK2AZfOKBGQZx3IQAxypeTXAQCHP7axJuaW0th04G3N9OwitXodDXG3uYyLvMq3DH+vRNfKNyb7YgfnLl4AU0ae3sFQVHhyPs9V9YR9R2RAQLd9G6Mjn2BEX+N4RNjgn3Ij5tp8GvZllrmsbnAK6//XuRSAG/i0yEVWp8OLe3GnJ0+fWiPPgHyaJBawO50TgPttL5azIhx3KSx21eQ7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/r4SFV2f1gvIPIGbTH5GdGVu/6v6BXswa6Cebvnvxf4=;
 b=HcLA7SSorw6PEot5hQhW47YJHli0K/g1Z/cawg5MtpdjLtP/HUo5FzK+Ww6WMrwbH1niMjmlJv+gjnqnTvAdq3GAquc4kn7oHyux2zp0ISDoyEACr6qPZOHR5t5AcQG0+Mr1KRvziULbdCGDWH2W88yoeuKdtWePDnXonN+y9eY=
Received: from SJ0PR05CA0006.namprd05.prod.outlook.com (2603:10b6:a03:33b::11)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Sat, 6 Jun 2026
 05:17:29 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::1) by SJ0PR05CA0006.outlook.office365.com
 (2603:10b6:a03:33b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Sat, 6
 Jun 2026 05:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sat, 6 Jun 2026 05:17:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 00:17:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 00:17:27 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 6 Jun 2026 00:17:26 -0500
From: Salih Erim <salih.erim@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Conall O'Griofa
	<conall.ogriofa@amd.com>, Michal Simek <michal.simek@amd.com>, Guenter Roeck
	<linux@roeck-us.net>, Salih Erim <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/5] dt-bindings: iio: adc: add xlnx,versal-sysmon binding
Date: Sat, 6 Jun 2026 06:17:03 +0100
Message-ID: <20260606051707.535281-2-salih.erim@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20260606051707.535281-1-salih.erim@amd.com>
References: <20260606051707.535281-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: 536b8dd8-6505-4b41-17b9-08dec38ae759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|11063799006|56012099006|3023799007|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	hxuC6fgEDO9KYvqPVl++cqa6nnRFzBUC5jNFWxbFrfJ9RYqC6tmp5MC56XJSja4Fdy2ka5Z2hh3WScwVisYMeSsO+G0Unx/0X6PtHYZWQNgy1cbPk89YNCv+OQr68TcxC/hTJr+5gYHy9GEk715TdYf1pYvmVnPN6bXay1wsr2ur/saiMnJ5KORX6qjsEf9VEumfH9c3VdSGmsUubsuzzQicSwwBh809cf6MlOk2r8cSH1Or9BXLWNkNhmF/ThblKcnhAZrzd6+BSikUgDse+cEpO5VLg70EVMqwoeOu1u3A7wmMagbSMX2uZuWXUp81pJkcGM8UdwROumX8aGNI++ZZ7Qyfq3sN8eCDemTz52Ib9itWMko2UgbftbOA8JQd0HXfuNn8leXs3vyC6wMHN30vNFxOl8WKxln3w3rE1c6PJAAVloJmGyv/EmK1jqhOlhxmr2WAPOphobecVzacC0xI1/PDyUrvw76OPAHgnbD9NcLRavugIi47pbZVdm/X6v9k7Dl3vDxa54pZCugBWDntW0Nc9fWQXB+s16XkjPaKZ/QDStD97tVugKfLhw/lXNmZEak9tlKYN9GuZu+6TS516xw2HUZVT7w9rEIBMxjlNELkI89W63cJCllxbbPPA1SB/nGz+m7m2pkVKKnacV670BijgcfvWZLvfWzCgW4hmj888AXpXWwbSHajF4/X
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XJv3wuzdbMvqzhCeJOyNgsZZFXGh5eVDeMLn2kXvve2yOgj74GDQj45kG4bG+xZhAdV1pNTz3Quy+oz1enKbYfALFAL12naXY6o5Lxkt2i/tRbQDqGiuax6Mri2xOlgzsIEbwt8V5672G+mzTMkBymrSqHJ29nZiep6YuxNFAIvzjE8syElT7TeO8GfJVc+YROg0DMMAmdie/gXy6Cph4AwgZSruAZiMQLwdNDHiLV43jS3h94O7QyL7nqpvgnwBJsS+AmWtCQ1kEIUAjwpJ3x6zZFR+8+/uaMiZ47gpnkwWbrhhcx7ckhd8gLtg/Q61zLVhzxxbExuoHpHF7hYaH0XxXK+8zjHna+kUfmSrAgxtKs8gfHonUGWgVtayn5+sEUD+TVUb0c4s5wp6UJ7Z8tst6BoLTnj1r65bvyCRx7C2pKkRT0OwSI4GJAa+LLQZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2026 05:17:28.6119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 536b8dd8-6505-4b41-17b9-08dec38ae759
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786

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

