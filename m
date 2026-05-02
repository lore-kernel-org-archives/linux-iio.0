Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC6327C08;
	Sat,  2 May 2026 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777720824; cv=fail; b=kHfNKwjxznM8DDupR0kDuin2wL53lX9OFBVM3Ro8bEgjL5rPDRv3WdYWx4exVbvtQEPWN814JjcyUGwKgicG17UQv+dxlwzdKwxYf4aw8HA+lxlUZ6HCWIBBAd+EzfbHDn82T/ZoM9dqfPMd4BNSF3sSpLb++f4EKgd+S2Xf8IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777720824; c=relaxed/simple;
	bh=wC1MQ4SH68XPYL4DkG5CKP3j4b8LSUZ3le5xboDnFHM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWtsSGg5ubbzcvrKcGgVvrEuisTmVYJJbPMTOvZkDTFuIqKPaaawCjGDxXOjECOPY0OCC9yvPHspk4OLAdhP5VXOJCe+leKRsYCd1QiMiimNM74q1c6ukcAgiY8tF6N/GI1ATlc2zT55B7vybdPN2WawNO8cNGy4rp1SUEMEITw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UjX0g6o7; arc=fail smtp.client-ip=40.93.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UjX0g6o7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPE0+SmyFDksD0els4UJJa1iK1V5PfgiqjlwpdsnSA1AkBuDoyFfB/KIuerjeMrXwkOTBCsxniDvPHS+fZUmvcH343/M2JjhoKEcFXnZGh3ANuhTkxrIV4oR1ZmvTuvq3qNB0Bpwt0kvK4xjYwSmXLTZIOSHmRPPRXZDRTcWDDa+QY0vlcbRNCK+4rOjPe3MuIxgjIvpxiJvhJqF9vWkt/e4BRZjEiVz1PTc2ZXME7xKmc3AjmNE/67ot1PxqTXK/68WMAfju8OelBL2cITdt06XpRVVBGhwIHKUwA+6WEzCcNrlTzuvVx66d18JO4BBreuWsqsDJTV5MeHZ9f/HXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ndNktcBLraVbE7GcuGArtdnf6qhQ8aamw9afbikuEc=;
 b=cBtBlqJd2kFgYhKusbAa3OXGKGAAumulsaecY6xOShepz6aXImPaDfG6mvIaoJ/gC2lOfKYXLqkezXWVBD+0aAWktQnqsG5BY3ITmocCRGW1PzdpdgkvdvxiolMwnXtZKfedk81d5f9TuptOAnG94MdfzbrHOC22E+spG9i2Co5Ulp9Q2t3IMgULwGO8dFF6MtAP9H92Qy0mkSpqQb5JyOGM1GmN2EOwRqjRfzgG7vezfRWAlFVeRHB0U0VyT0ZbK8TXIfBKXsKZGaIvIvTyq/Rv3hcfbytrADHqhDmqIdMvTIsb+xgkCfIZni8RB6DlbsJmS7PgUFOq42z/cJzWgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ndNktcBLraVbE7GcuGArtdnf6qhQ8aamw9afbikuEc=;
 b=UjX0g6o7tApFCVvXgd6UmoXkRBeT7dioLyMssSlkKjf0eHJcBlyAaZnBEPo3hznbp7Se5zGpAXM/heTsPzuxGNQ0BmbEGXEgypHbzJh9c2UmMF6CAo68jY8kPQmp99tOWzZ95usr9/Ul7e53/JLFwph7FoRbyWy+7YMr3KxNWjo=
Received: from BY3PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:254::10)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sat, 2 May
 2026 11:20:17 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::a1) by BY3PR05CA0005.outlook.office365.com
 (2603:10b6:a03:254::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9 via Frontend Transport; Sat, 2
 May 2026 11:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sat, 2 May 2026 11:20:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 2 May
 2026 06:20:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 2 May
 2026 06:20:08 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sat, 2 May 2026 06:20:07 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <git@amd.com>
CC: <nuno.sa@analog.com>, <andy@kernel.org>, <dlechner@baylibre.com>,
	<michal.simek@amd.com>, <conall.ogriofa@amd.com>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>
Subject: [PATCH v2 1/5] dt-bindings: iio: adc: add xlnx,versal-sysmon binding
Date: Sat, 2 May 2026 12:19:47 +0100
Message-ID: <20260502111951.538488-2-salih.erim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260502111951.538488-1-salih.erim@amd.com>
References: <20260502111951.538488-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: a5517608-9392-4579-c047-08dea83cc9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|7416014|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/1G48+S97D02RPZkFWzIv6cCzJhpUkRwW7VnMHzaPmpOCQjelIOSUU2+3J9Et2Uxo467gIZASKZBOj8oaxo71Gw+RKd3ajc7uLTlO+vcDIVCIVTvikLod/NmpJTohGsWIaSDM9iYQ7AwtIxBDWvofCHDwHpgiluXfbh7L3G0TWTYeB/UcGnUAsgJ+WJlamdTBjbfNhg849h/fSAkiSR0HIwSFAR1H2ZFKL8+AD9ZZhSz9R1lE/67nHdnImM8M1PULpg78WahdmvKRBcw8oNduYVjIZOOOo9ol7NmbfQ91AR9p+BXyGoqfi9OVOsnLCMIiH80hkv1zxAHJwqJVKwDrlJvkvrrPXcYGeMmPHZbWwEOBd8PYz7LxNibzlnSFoMkB/znXVxVV0sYyfnJi22Yd0N1UowGZSDQ1AHKFiVeMpnW1/Ts2eSryoEE8IJ6TtZ6kiJ1GWHIJm9rd1bejgPVqDrCfuNq6F1G34jZGVKpSpBlRd7E9o+pL6nzo5veCjlkkMDLN0mP279hnrnSZMJgJHdWPQCi2l/p3LnhTZugTZ2bbUgO+GwntlY9WXTnaBRHKG2mcPFGyeiUgz8NbWB8OAYIOT0hlQ7cp9NlnG+enJlti36ShYErojj60/C80dabnz2GNXanyNUj9zdRQMdLpSu6gKVsXzURkIlsr2IYxOA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(7416014)(13003099007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ktyBf/t2KRE1yTQ9jmdeQlyvckuxKPd3CgIKCruOrePTs6Z51oFTA1LtJAaTW53Hc/A/rxMGf5w0mUanyfsw08qP2sDAUIslGvX3mFAS7fPcY8fqioEDFIUZz9ldArsNnDiQ0mrYQ5WzPsFLariHynGA+STvPbs6m140PFCozBWjiLrxBgX/qD6uATj4PblAQQjTBVKKOlMnGRbO5eDEaoUpv4xyPd2YHuXcU//gbxmFfJCVUIPWK+n8d6mZZuNlWMqA5ltK3sYWNiaNMQBmt6MJRzQ8aHjixdoqe9rTSKN5yNvEmqCs/bHPdxSHPBnCc+Gn3ksMXKckHj8LTlx0++vTQqjg9YciZ4qofoNpxF7EKACJCepUn3FfvhKIDhdO9X4FxDDbAdexYqYjj484EGDmdo/6aDdOPfGPmDlJdffhizew9npDif7rGVlg8cb3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 11:20:17.0835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5517608-9392-4579-c047-08dea83cc9e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548

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
 .../bindings/iio/adc/xlnx,versal-sysmon.yaml  | 172 ++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
new file mode 100644
index 00000000000..cdd8706fc02
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
@@ -0,0 +1,172 @@
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
+  monitoring with up to 160 supply voltage measurement points and up to
+  64 temperature satellites distributed across the SoC. The hardware
+  supports configurable threshold alarms and oversampling. The device
+  can be accessed via memory-mapped I/O or via an I2C interface.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,versal-sysmon
+      - xlnx,versal-sysmon-i2c
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
+  supply-channels:
+    type: object
+    description:
+      Container for supply voltage measurement channels.
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^channel@([0-9a-f]|[1-9][0-9a-f])$":
+        $ref: adc.yaml
+
+        description:
+          Measures a supply rail voltage. The register index and rail
+          name are assigned by the hardware design tool (Vivado).
+
+        properties:
+          reg:
+            minimum: 0
+            maximum: 159
+            description:
+              Supply measurement register index assigned by the hardware
+              design tool.
+
+          label:
+            description:
+              Name of the supply rail being monitored.
+
+          bipolar: true
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
+      "^channel@([1-9a-f]|[1-3][0-9a-f]|40)$":
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
+          label:
+            description:
+              Name identifying this temperature satellite.
+
+          xlnx,aie-temp:
+            type: boolean
+            description:
+              Indicates this satellite monitors an AI Engine tile.
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
+        supply-channels {
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
+                xlnx,aie-temp;
+            };
+        };
+    };
-- 
2.48.1

