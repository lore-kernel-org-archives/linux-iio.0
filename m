Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E732D46C0;
	Tue, 16 Jun 2026 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615782; cv=fail; b=IenXBQWh3DuzHal/dj5RJYsJBBy0J1a73Z5sRwyG3SWEylm+wxfMnWRQyqn3VJsrxcC4kraeHupcK90fMQ4FqIGF7ct+smmGfJTumR91u6wEd/Qs+of+QkUAeDHpVAObfEtqT9V6KSfACu+zoQ6ygX++yxQVb+qzW1FFPj5Ohns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615782; c=relaxed/simple;
	bh=VW4jZfJdPCWshlsWknvUdj1Vjl29yy7SVjTt+LOOfzQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTnGyyZb2H3Ac0pCNOKtk9t6h3PWHQ0TvPXYnS3DsJKqLdINPnkrGCx0Y119GfyB/eJVs587ptD84iKO9C9dOhEeJeuU9QYm3732s9nu8CDY34hReOlBslR6+TaPFL4kaJjgwFn8ry9mnIdlga43XLcjU7tqgPNQGtHh6O6dL5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=onkLwOuD; arc=fail smtp.client-ip=40.107.209.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="onkLwOuD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWtk6W6BAk7vBC81UbyQ01b94kS+rrY7cBTH7fJQtidY0B0e16rRoyMzsmVCb4Bt1duPtF5M5YnLRHKJ1Mo1KlAsXdN+7ivuHnX4ibdMcQeUD5lSoYRRCEis+EaImJN5/eNgckIB0lIoHGFzTvOB7u7V7qWcKsbowmCNkCRUv1WWJ/CbPPizLHPl/296ieH0rrLPQHtgWkjdrcRUfjOChkpPV/iE/XAo2HSZaCMiJCELjS1H36XrddnnaY0o5a6J5GIEcbsJyNq//Pp6ZD7ULYOTWGBvUUtQcFD/USYrO2LXWk33JajW/cSGQQ8dQP9aaGk7AROlOykAF6gO7aacfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Wt0A9DFmifU/g3sTDU6CoaII+gwsRJQvIC6jQsAyZc=;
 b=XB6ImbIYRUJePu/nCwsUeMdNcXqTWF4L82YWmhHK9SbI3hZITwka7MJmIC+NybuBQmR/GVf5PK2B+PnXaOM+B5NJKlGS4Ri7NQJIFYfuM5TVRw1wqAFScK9r20tYRGugsMtpU+Eu6cJqvvN3gs6NW2TRaOh6raUQlxBnY/npbq5lFhD7W8Gs/OoEUTnbKFnOsODlJx1AY1Be5h7ZtPonn9GouDTyyZn7Gr17j6akyYNPLbV6IpZWgzDgVMs6Buanzf6ZYs7OkOKJtvKdD4a1zhlubuvaqBMjyW0v7ZJTyc8CavvLXqwnStwsMWX4mbE2ykHSU5cJZ1voGDml+6KL/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Wt0A9DFmifU/g3sTDU6CoaII+gwsRJQvIC6jQsAyZc=;
 b=onkLwOuDGDNDfQGCrz2r12oq9NeWq6ywHij8HPFgfUZzTgrPbXanV60uUn9bhCe/glM2+Ml4sMnTKNokZrSDUwJDJWHn3GN2WwQvdWxvvpU8YufcQMdcf8J9quu8fJBexlmThfYO2fZ8SevAkgAGrDIl5t1gN40G+vh61dQM8x0=
Received: from SJ0PR13CA0220.namprd13.prod.outlook.com (2603:10b6:a03:2c1::15)
 by IA0PPF8FC6E1236.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bda) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 13:16:17 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::70) by SJ0PR13CA0220.outlook.office365.com
 (2603:10b6:a03:2c1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Tue,
 16 Jun 2026 13:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 13:16:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 08:16:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 08:16:15 -0500
Received: from xirsalihe40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 08:16:13 -0500
From: Salih Erim <salih.erim@amd.com>
To: <jic23@kernel.org>, <andy@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <conall.ogriofa@amd.com>,
	<michal.simek@amd.com>, <linux@roeck-us.net>, <erimsalih@gmail.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Salih Erim <salih.erim@amd.com>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v8 1/5] dt-bindings: iio: adc: add xlnx,versal-sysmon binding
Date: Tue, 16 Jun 2026 14:15:55 +0100
Message-ID: <20260616131559.3029543-2-salih.erim@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260616131559.3029543-1-salih.erim@amd.com>
References: <20260616131559.3029543-1-salih.erim@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|IA0PPF8FC6E1236:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ded41f1-7338-44a4-8361-08decba972dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lB86aMET1BTYCCGglX4TfSqItHDEFhgH3mOxiyQbAeOS1CidmG6PhajrMFxiCPFi8r45kmdO1UEzFUaeYEpENGpu9XsZLlyQ/dGkWBK+RAkmJTomU6ykOOP8Og3ZPPm9j9oFPHlWFwuETAPU8X4pbe0vasqgFRRd9jcqGNCW0BRSHjf6s1pVy8IAFYBIMb7H43ooJ+EQmmDY/N91H1AvelsDCfHpmUQnMxxJUBwYVLVDsIv4mXiwnrphCJcgUNrvVS8ko2BBTnSxQfk2lINgWyEW/RD/GdrnUtRwiDrDtl8/ttJXQ7TEi0mJF6b/2ue01hi355A9DupO4THmcxvNsbb0922DI6JxSuxMAtkJ0mmkeaBqnGBWEnBJ2G9ztd2prazFG9dAQe5rYxDll42dFVceo7LKHhAMVztr3NsYZtaP//eqHInuLdTYXpU2n6dEfNWnRG2jiqgmUkhPMipp3fnljFhv63OGArU0KCslygwoT4VyBMwzaWsKcErNIWoiPkGV3SKNF1IkDmf0bpJdA4DSoxjwwveHs1DrUF4ckH4SH+5JX/UFeZOeQOK8fdMZfKUsjhINTqomK4E0MFpa5sRJ6TOpeNItnwTrT4FBTEbvvFCJzv60h//EdnF4fdKs7RWcbgiEEubS1W8TSZI20APbF3pNYAduwIEiG2RruxBPUL6apNNyabAPRiwjpq1e
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cuBJj/80wgV9fjqXZOmBBE+TD/B89Yd68p/kDtWQxlnGI0uTxyFm4jj7qgsX63jZI71vsNqsi/IS1U+hN+oFin89uJAE6h/w9p9+Iyn2b8adwibeqXHgM72LtXsD5Q4iUDSjv0dgcU6PkzOTBIPhyc/mfofpJx+VIbucOpZSiVA0LifvleRrCsrq/RbCUl0+A1AAAhnLiqIx1dxwG2Ji/G2te5WZ7SpputrGlHfJctHqdCBOdTtVAik6CceRWtWYPLQcO6K+NxvYx+xfqeYRZR7cjaLQjSMWVR4V1+ZI3iJk0QG1S3etqPka1EbTvXtJzGj3/4pPu6+g0uxEKjGROi2atuHp85Kve0BBPXcUgHff7akkUkEBFYFVXU6l4vVgO6RK6sb/30+dlm+GnzOanoVKse9O1dlrjag+YAIs2j6pdN4c0gRZOvStBC7UNqnM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 13:16:16.9238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ded41f1-7338-44a4-8361-08decba972dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8FC6E1236

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

