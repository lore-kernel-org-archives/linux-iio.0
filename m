Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276B746D0B5;
	Thu,  1 Oct 2026 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866662; cv=fail; b=CEePrkBUy+ekThEj7g5ZRj1pw8rzdmNupHouiYi948dF3yCHD+9y2oJb/UHDOnncX1AII/2ADRiDk51VlBcu8WKto/oa2+sF/ig599lSKBgvI9AoV+KampPdUx6r6JUk5NBHIo9kWld5ZveKqkRz17/m/C7MhG+RhhkUwqk655k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866662; c=relaxed/simple;
	bh=/m7c1Pbhk+lksugLwJmv9wiJmJX1qbMegl8H/u0ab/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uliELuKSdiID9VxQl/SQJDtLy9Vi0ivS74GL/BBkbIfsIHLgiPu/IzQZO5VlmJO3Sh/hmNNn8FAOQOoFraZdWMe5LZAIPp9Pv3EbD0UQOqpGvUTRPl18LT9io4bzAmoaAlKP6/j26OdSKn60Xz4gDGZqQ9T0gf+SbZs6pvMVTjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ctl+mU3K; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ctl+mU3K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvMLQdl+/FYygPSIaPJlqiXCYzIhJRdNOgHvOisiSdui7t+XXXtnXQDDRAvnL3ze1FGV+ct0+61sgIF7H2qh8kj2ZE2lBuU17U/uuZQJpnruFRxBc5Puc0vw51TiJen3jwV8dcHjn/F7klIAEd/5pMYChRqZmhGHnqfO4We6ytwPpjBr16fgZHW7qNtB3i8K+F8j0r8E6U4blcOJ6IIocakQJ73bebI72jtGEu0MxHKFWGU+oRl4bPKHZ9Jj3LU8SEWg6t+VjYr3qzOp71Q4SYE35Jf9lGNmTqePJq2yBGLthycuJKCPxTavD2GimVG6hx1mr0P0L98/1h+RJZbHSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBnYWeGMv5EmKOUlcf2CObnB03eJ2iBN/Zsm3hmHKZQ=;
 b=OYqtGEWuon8ym1o52hTf7NNq7GUJXTlR6E+CxHh4mO7uiMhfVZzasnc0axgIQLGjA9uyw2lo9lY98xQ3E0XY7G6NMEP/a0ePJh0J4FLCSTQrEjUVVO3C/pgZjHUY9H/vAS7kyYYYWjCVBGYYb4JWF4S70OCYZyBVLvC9r8X7Yc4jXUyvOMkL5F2IrCHwkKUv/pl0sDiwxrhYK4s3nz1AvgivdUHD8BTc8L3TDCwaYThstw10bFN57evNBC1lxDbjjA29/iqDxBwRysEW1tpYmngVPnMV3hW7YAxYDn9wF2Bt3XM4qcqYnZIs8CrUpGBiPiGiSQ3toZ/ox2DsT0CTaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBnYWeGMv5EmKOUlcf2CObnB03eJ2iBN/Zsm3hmHKZQ=;
 b=ctl+mU3KxinsBkMrK4pbcQzLByDoOPZBgEGjTVcqBmNZn26Og5eBtCDkh2OtXjARBZW9wfaSX5gBq9uSF/FNLlAHDuxTqoxa/QYNdAgSgbyONudhXsW2F1nQCaXg3n1iIPtYYE0gjIwlFFOBd4DFHLMDPK8n+11AXtWr+YnvSViiNCMuBXFMhn9Cf7P6b5PXBOfJNhl0CmAhp7FevCCy5+fabFaDkyDPjNgU+cJvSttCPRQnpafIkBQbo1XXHiuNH//Z4upapYQipWkAitCIOdIxPQ9hPk68kSciDuXuWi08+WEpktC14O3CU4wqeZwApDA8CPhhRaEHR0Gvb7tC0g==
Received: from PAYP264CA0028.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::15)
 by DBAPR10MB4011.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 14:57:35 +0000
Received: from ZR1PEPF0000E461.eurprd04.prod.outlook.com
 (2603:10a6:102:11f:cafe::8b) by PAYP264CA0028.outlook.office365.com
 (2603:10a6:102:11f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 14:57:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 ZR1PEPF0000E461.mail.protection.outlook.com (10.167.241.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 14:57:35 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 1 Oct
 2026 17:03:29 +0200
Received: from localhost (10.48.87.64) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 1 Oct
 2026 16:57:34 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Olivier Moysan <olivier.moysan@foss.st.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: iio: adc: add bindings for stm32 mdf filter
Date: Thu, 1 Oct 2026 16:56:45 +0200
Message-ID: <20261001145702.2628429-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E461:EE_|DBAPR10MB4011:EE_
X-MS-Office365-Filtering-Correlation-Id: 83dc4752-4c80-473f-cd27-08df1fcc53e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|1800799024|82310400026|18002099003|22082099003|13003099007|921020|6133799003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	BQLB6bX7sy6bnUAG5Prqx6hCrTkWauR/+k3DXn6iFz7t8wxOuFjllyqu7qIC6Pw0zl8MDmN3MpOkn86HiERHU3zkE7ufc4rNyfa0MVnBu9yi027FUsTpWaSDZ9DrQnPFBaFkWcAQzIladNAPzN6Z9nMPqK6BDnWk6DzI7kRgz5KZofSMLsjJ7VTwYsurFVoYbhSP3lYa2nhx8OVF35RB98UWad8NwPh2N+8Nqyiu9fVWtjes9HuqOaTvQpZF97FnMjGv80yhFiAFsvDL10mZVaLOFfCG/IVZPVjWD+eES2ci1flejItZKsvece0giDbWcO10ElVoY31TwSLK0eyiiDAjuSYpPrh0Cold9Cm9/6366MTE6oZ9/d8EmDYK4y++1MakbV0TVlJKuJ9TaHcZHbwOIqpDtxk6nUHV8zeKyPAUwMfv8sTw9xYsRhZyYly8bOXaTHojjNCyRPMXbz2xAOV2HJEmzmYgNueX49iJdavR6ZDTijFm73YSko3zpvWNPNpmNlCTTg1KybyxKyHMdzdMPt2/HYX0iWNWCAUTfRAu9VIIOSAFbN6+epLb3eKJ+svwcFCd1ksoR5Y9JEEWNSrLC11uRicTVBgbZ5NqA1ypbaJLLnQUqkpdt3qJN+LOYMs/PKwFXD+yYj4TZOd9Vw7PhkD7PMUeFlnLKQTqtTM8IzJ3IQJcOqPJho763xVmDJ8S3v6lC7IrtjFHorKzKg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(13003099007)(921020)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kGc8YeOlzbhJxLM6/awNgq4iKez8pT2wUiSoJzn/kqL9utnWdIWVv3x8oH+mvR08hW4lqzoR3NijlKIF8OyKnuKT7dL4K4v/ZBmWh+Q9c7z71/M/k278VYE766NuEeNLRGFpDVCCMvbYkYuWvB5JwfdfFGBEKadtqj/VnOZxHORzYg+yS0huz8HhPAiun7MZHKrhOGEvTtcIG4TC8e1qPxuCsVmweEnRnmfnK75yoXhM+kApjQ3FbK3fmSnacQT1B4h/Xymo+n2lPWV6G1Li7e2kmvfLh4Qb2KRWz77H7nlzBoZ5M6F9DdYAUB/sfpOhkdMrU9mZuJl/m1Ef9gpd2P30JtcBsUrqJ+ZWUD2WXmfSd5UGTso7ENQxf9eciKEfzWk/2yqGY4RWhbKTkncSdzpnIw/afm6FSM8bOwF0/SYCa+HZx19vMY2bpltgOYrb
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:57:35.0663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83dc4752-4c80-473f-cd27-08df1fcc53e6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4011

Add bindings that describes STM32 MDF settings to support
digital filtering for Pulse Density Modulation (PDM) microphones
and analog sigma delta modulators.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 .../bindings/iio/adc/st,stm32-mdf-adc.yaml    | 383 ++++++++++++++++++
 1 file changed, 383 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
new file mode 100644
index 000000000000..f2fbc3e150e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
@@ -0,0 +1,383 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/st,stm32-mdf-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 Multi-function Digital Filter (MDF) ADC
+
+maintainers:
+  - Olivier Moysan <olivier.moysan@foss.st.com>
+
+description: |
+  STM32 MDF ADC is a sigma delta analog-to-digital converter dedicated to
+  interface external sigma delta modulators to STM32 micro controllers.
+
+properties:
+  compatible:
+    enum:
+      - st,stm32mp25-mdf
+      - st,stm32mp23-mdf
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    description: Internal clock used for MDF digital processing.
+    items:
+      - const: ker_ck
+
+  "#clock-cells":
+    enum: [0, 1]
+
+  clock-output-names:
+    description: |
+      CCK0 and CCK1 are optional output clocks, which share the same clock frequency,
+      but can be gated independently to save power.
+    minItems: 1
+    maxItems: 2
+    oneOf:
+      - items:
+          - const: cck0
+      - items:
+          - const: cck1
+      - items:
+          - const: cck0
+          - const: cck1
+
+  clock-frequency:
+    description: |
+      Common clock frequency (Hz) for CCK0 and CCK1 output clocks.
+      The frequency must be a multiple of the "ker_ck" clock frequency.
+    maximum: 25000000
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+  clock-ranges: true
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: mdf
+
+  access-controllers:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      Phandle to the rifsc device to check access right.
+
+  power-domains:
+    maxItems: 1
+
+  st,interleave:
+    description: |
+      List of phandles of interleaved filters. The indexes of interleaved filters must be
+      consecutives starting from 0 (i.e in range [0..N]). The samples from interleaved filters
+      are muxed in a single channel and retrieved through the device associated to the filter 0.
+      The filters 1..N have to be enabled, but inherit their configuration from filter 0.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - clocks
+  - clock-names
+  - clock-ranges
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+patternProperties:
+  "^sitf@[0-9]+$":
+    type: object
+    description: Serial interface child node
+
+    properties:
+      compatible:
+        enum:
+          - st,stm32mp25-sitf-mdf
+
+      reg:
+        description: Specify the SITF serial interface instance
+        maxItems: 1
+
+      clocks:
+        description: |
+          Serial interface clock (optional depending on interface mode)
+        maxItems: 1
+
+      st,sitf-mode:
+        description: |
+          Select serial interface protocol
+          - spi: SPI mode
+          - lf_spi: low frequency SPI mode for low power applications
+        $ref: /schemas/types.yaml#/definitions/string
+        enum:
+          - spi
+          - lf_spi
+
+    required:
+      - reg
+      - st,sitf-mode
+
+    additionalProperties: false
+
+  "^filter@[0-9]+$":
+    type: object
+    description: Digital filter path child node
+
+    properties:
+      compatible:
+        enum:
+          - st,stm32mp25-mdf-dmic
+          - st,stm32mp25-mdf-adc
+
+      reg:
+        description: Specify the MDF filter instance
+        maxItems: 1
+
+      interrupts:
+        maxItems: 1
+
+      clocks:
+        minItems: 1
+        description: Internal clock used for MDF digital processing and control blocks.
+
+      clock-names:
+        items:
+          - const: ker_ck
+
+      dmas:
+        maxItems: 1
+
+      dma-names:
+        items:
+          - const: rx
+
+      "#io-channel-cells":
+        const: 1
+
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+      st,cic-mode:
+        description: |
+          Cascaded-integrator-comb (CIC) filter configuration
+          - 0: MCIC & ACIC filters in FastSinc mode
+          - [1-3]: MCIC & ACIC filters in Sinc mode order 1 to 3
+          - [4-5]: Single CIC filter in Sinc mode order 4 to 5
+          For audio purpose it is recommended to use CIC Sinc4 or Sinc5
+          This property is mandatory for filter 0 or filters not used in interleave mode.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 5
+
+      st,delay:
+        description: Filter delay in samples
+        $ref: /schemas/types.yaml#/definitions/uint32
+        maximum: 127
+
+      st,rs-filter-bypass:
+        description: Bypass RSFLT reshaping filter.
+        $ref: /schemas/types.yaml#/definitions/flag
+
+      st,hpf-filter-cutoff-bp:
+        description: |
+          High Pass Filter (HPF) cut-off frequency expressed as a fraction of the PCM sampling rate.
+          Cut-off frequency = st,hpf-filter-cutoff-bp x Fpcm / 10000.
+          If this property is not defined the HPF is disabled.
+        enum: [625, 1250, 2500, 9500]
+
+      st,sync:
+        description:
+          Synchronize to another filter.
+          Must contain the phandle of the filter providing the synchronization.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/phandle-array
+          - maxItems: 1
+
+      st,sitf:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        items:
+          - items:
+              - description: Phandle of the serial interface connected to the digital filter
+              - description: |
+                  The phandle's argument selects the bitstream on the falling or rising edge
+                  of the serial interface clock:
+                  - 0: rising edge
+                  - 1: falling edge
+                enum: [0, 1]
+                default: 0
+        description:
+          Should be phandle/bitstream pair.
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+      - dmas
+      - dma-names
+      - "#io-channel-cells"
+      - "#address-cells"
+      - "#size-cells"
+      - st,sitf
+
+    unevaluatedProperties: false
+
+    patternProperties:
+      "^channel@([0-7])$":
+        type: object
+        $ref: adc.yaml
+        description: Represents the external channel which is connected to the MDF.
+
+        properties:
+          reg:
+            maximum: 7
+
+          io-backends:
+            description:
+              Used to pipe external sigma delta modulator or internal ADC backend to MDF
+              channel.
+            maxItems: 1
+
+        required:
+          - reg
+
+        unevaluatedProperties: false
+
+    allOf:
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: st,stm32mp25-mdf-adc
+
+        then:
+          patternProperties:
+            "^channel@[0-7]$":
+              required:
+                - io-backends
+
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: st,stm32mp25-mdf-dmic
+
+        then:
+          patternProperties:
+            "^mdf-dai+$":
+              type: object
+              description: child node
+
+              properties:
+                compatible:
+                  enum:
+                    - st,stm32mp25-mdf-dai
+
+                "#sound-dai-cells":
+                  const: 0
+
+                io-channels:
+                  description:
+                    From common IIO binding. Used to pipe external sigma delta
+                    modulator or internal ADC output to MDF channel.
+
+                power-domains:
+                  maxItems: 1
+
+                port:
+                  $ref: /schemas/sound/audio-graph-port.yaml#
+                  unevaluatedProperties: false
+
+              required:
+                - compatible
+                - "#sound-dai-cells"
+                - io-channels
+
+              additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mdf1: mdf@504d0000 {
+      compatible = "st,stm32mp25-mdf";
+      ranges = <0 0x504d0000 0x1000>;
+      reg = <0x504d0000 0x8>, <0x504d0ff0 0x10>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      clocks = <&rcc CK_KER_MDF1>;
+      clock-names = "ker_ck";
+      clock-ranges;
+      #clock-cells = <1>;
+      clock-output-names = "cck0", "cck1";
+      clock-frequency = <2048000>;
+
+      sitf5: sitf@300 {
+        compatible = "st,stm32mp25-sitf-mdf";
+        reg = <0x300 0x4>;
+        st,sitf-mode = "spi";
+        clocks = <&mdf1 0>;
+      };
+
+      filter0: filter@84 {
+        compatible = "st,stm32mp25-mdf-dmic";
+        reg = <0x84 0x70>;
+        #io-channel-cells = <1>;
+        interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&hpdma 63 0x63 0x12 0>;
+        dma-names = "rx";
+        st,cic-mode = <5>;
+        st,sitf = <&sitf5 0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+          reg = <0>;
+        };
+
+        asoc_pdm0: mdf-dai {
+          compatible = "st,stm32mp25-mdf-dai";
+          #sound-dai-cells = <0>;
+          io-channels = <&filter0 0>;
+        };
+      };
+
+      filter1: filter@104  {
+        compatible = "st,stm32mp25-mdf-adc";
+        reg = <0x104 0x70>;
+        #io-channel-cells = <1>;
+        interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&hpdma 64 0x63 0x12 0>;
+        dma-names = "rx";
+        st,cic-mode = <2>;
+        st,sitf = <&sitf5 1>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@1 {
+          reg = <1>;
+          settling-time-us = <1000>;
+          io-backends = <&sd_adc1>;
+        };
+      };
+    };
+
+...
-- 
2.43.0

