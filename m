Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B515026D4DD
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783233269; cv=none; b=dcolDeRUIOEMFLJ7cmao8XI6t5jDS6XCVsrOQwLbicr7blR5vDd6cKBs8nB7COEh0OWrLCh51aV/OVEKw8k6tqHkjZuakPg1MFMfUmM01S6K1D4mDkEWTjuLNhtwK7TxsvcUvyxUORfTHRZ8jOdeSiTBOM7y7QyvdKaxytjbbJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783233269; c=relaxed/simple;
	bh=mI6JpstHq79ss97RLmBW5ZMpjBAldYlYI48eUjPaURs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V5IZXnRPl/5XC3t0ET46D8/KwJgHTK1QoZ3a4fEh0+CbRAXcfmv3NSYNjszqsWw51PKLJOByz++eTJPRaoODpnWkutZRhI44a4OQXjUgmK2bY1GV6Gzqf5lAWXw6V6B6um0h7NfCZmmYgwXu0ITzHx7cxbsGPLTuWsTw+Zt93b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0lXJCDY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0lXJCDY"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c00f74baso11643575e9.0
        for <linux-iio@vger.kernel.org>; Sat, 04 Jul 2026 23:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783233266; x=1783838066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zmdu4l5oC2o3xpqXR0SLxS3RQTGeyS4u8caych2t6oU=;
        b=O0lXJCDYWg3lf+Tp3gyKl7D/VuzGpbh58Ugl+haEuBuREvjyRa3PGAQgnDe1J8r6YL
         1yBquZWH7tBwKsUSLZVKGzxv4Joaiwtv8i2bDY2M4KTePRJghDz2JV3uzS47Y8zLiPcI
         pz6+AUwTq1lt2mSpH8aEMWnhnaCAZgImUFKzEDMfeUd8sl5lPpONN1DyT+MpzLm5NQhZ
         ywg0e8X4XgprHsNBR7qQwbcNwKXd3zrhVbdyQ3M3lvAChU8rSNEbS+pfGv/iOODI1tQ9
         Cupj/gN9X8UUe+v8k+uV7uVOtGZBCXtxS5GTE1tvAKwCPoPmVEHEzcXGgbwH9aFGGR2g
         a+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783233266; x=1783838066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmdu4l5oC2o3xpqXR0SLxS3RQTGeyS4u8caych2t6oU=;
        b=YoYUUS1uI833lbynXTLYstTlAORWOLPXNrqmSBiGI3fSFjFLeFo68IgEIBx0aVHXAV
         ksWNbzUDgwu+oFVS5+7WpXk27g8bwkr8G2V7Ha7dXfAjP6sancXUGXl/mF9jdDdfifzc
         F4HbvqVSPB+3t1KR7u6MsdJeHcMrqssHCJtbnBMz9KD+xS8EsthT5kgRwkuaAfBLiGV0
         whzlHdjRZdvTjrMGhX1CeQdk9mGei9O0bBR6DNVBxcofuyTvm/+hvpJolYkSlrZ/RS/c
         pgPULt3SLZTui4w9ZvbmMmhNX2iQmBcqsx+koiTwp7MnkP/Xppvv1XeLeL87Nhoei6qO
         ozWA==
X-Forwarded-Encrypted: i=1; AFNElJ9CKvalsjUagD525HtHc0Jeqip7J56a+S3PQ8SzPaOtEHazutWXfQYK3NXhZ2uasPJnSMRdbNHeJg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJUizZ7D2FA/zkj4iiIrN5k50pF9rDkSvN70+yIbsBpgLe/nez
	Vkka/dgKKjXHJX3Kn4JbHftz43igMaOFlPRY/A1nEcVTIAibylrl7GKY
X-Gm-Gg: AfdE7cnjki3IgrT26IkmXeZc60zNiu0cBy8cuqoHvMWTriwQrWyT2YhkEzzkzR+ILQ3
	NhzgPb+lpZ7O/ffA8824gHiRx5htEo55XGIyTcZHy6CrQU7ugv1t6HTjvJ/lPzYdhFAFh/ov2oQ
	xKCqIf3eA/gW7lVSzo2lYcIZ8xkXBxucE8QCoLpRzobnMuXZa55UM3hZuF9hYBgmFjsvX/HDE5n
	i1pLdFS+qPdCLGkKHAdlzhgvMwyiZG039c7FjFWeFHeEJ6mkj9EWdJnQjIUksHpJbLS4ft4w0mw
	+MDko0z4MG4nlswSKR+syZPZUN4nKfpbMPYK7UOKCFpsLnJBuDWTpvk7yBmkc5bVvZpaRuJO4fk
	UHaIlonvvjvBd7CfDUw+JuFfk/YiQ+YRX0n1XKF9y1NsqocA6gVqsTf+pUGQMBJ5onLxkjIR8qh
	sEqBmcjg==
X-Received: by 2002:a05:600c:a20c:b0:490:bd1d:4732 with SMTP id 5b1f17b1804b1-493d11f19f2mr33697475e9.23.1783233265840;
        Sat, 04 Jul 2026 23:34:25 -0700 (PDT)
Received: from avermoal ([185.13.176.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960af0sm12728592f8f.30.2026.07.04.23.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 23:34:25 -0700 (PDT)
From: Avermoal <avermoal@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Avermoal <avermoal@gmail.com>
Subject: [PATCH] dt-bindings: iio: adc: convert Xilinx XADC bindings to YAML
Date: Sun,  5 Jul 2026 12:34:13 +0600
Message-ID: <20260705063415.33076-1-avermoal@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the Xilinx XADC binding documentation from .txt to YAML format.
This conversion is part of the ongoing effort to migrate all DT bindings
to a machine-verifiable schema.

The new xilinx-xadc.yaml file was created from the original .txt and
includes all necessary properties, descriptions, and examples. The
conversion also fixes a minor typo in the 'xlnx,channels' property name.

Signed-off-by: Avermoal <avermoal@gmail.com>
---
 .../bindings/iio/adc/xilinx-xadc.txt          | 141 --------------
 .../bindings/iio/adc/xilinx-xadc.yaml         | 174 ++++++++++++++++++
 2 files changed, 174 insertions(+), 141 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
deleted file mode 100644
index f42e18078376..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
+++ /dev/null
@@ -1,141 +0,0 @@
-Xilinx XADC device driver
-
-This binding document describes the bindings for the Xilinx 7 Series XADC as well
-as the UltraScale/UltraScale+ System Monitor.
-
-The Xilinx XADC is an ADC that can be found in the Series 7 FPGAs from Xilinx.
-The XADC has a DRP interface for communication. Currently two different
-frontends for the DRP interface exist. One that is only available on the ZYNQ
-family as a hardmacro in the SoC portion of the ZYNQ. The other one is available
-on all series 7 platforms and is a softmacro with a AXI interface. This binding
-document describes the bindings for both of them since the bindings are very
-similar.
-
-The Xilinx System Monitor is an ADC that is found in the UltraScale and
-UltraScale+ FPGAs from Xilinx. The System Monitor provides a DRP interface for
-communication. Xilinx provides a standard IP core that can be used to access the
-System Monitor through an AXI interface in the FPGA fabric. This IP core is
-called the Xilinx System Management Wizard. This document describes the bindings
-for this IP.
-
-Required properties:
-	- compatible: Should be one of
-		* "xlnx,zynq-xadc-1.00.a": When using the ZYNQ device
-		  configuration interface to interface to the XADC hardmacro.
-		* "xlnx,axi-xadc-1.00.a": When using the axi-xadc pcore to
-		  interface to the XADC hardmacro.
-		* "xlnx,system-management-wiz-1.3": When using the
-		  Xilinx System Management Wizard fabric IP core to access the
-		  UltraScale and UltraScale+ System Monitor.
-	- reg: Address and length of the register set for the device
-	- interrupts: Interrupt for the XADC control interface.
-	- clocks: When using the ZYNQ this must be the ZYNQ PCAP clock,
-	  when using the axi-xadc or the axi-system-management-wizard this must be
-	  the clock that provides the clock to the AXI bus interface of the core.
-
-Optional properties:
-	- xlnx,external-mux:
-		* "none": No external multiplexer is used, this is the default
-		  if the property is omitted.
-		* "single": External multiplexer mode is used with one
-		   multiplexer.
-		* "dual": External multiplexer mode is used with two
-		  multiplexers for simultaneous sampling.
-	- xlnx,external-mux-channel: Configures which pair of pins is used to
-	  sample data in external mux mode.
-	  Valid values for single external multiplexer mode are:
-		0: VP/VN
-		1: VAUXP[0]/VAUXN[0]
-		2: VAUXP[1]/VAUXN[1]
-		...
-		16: VAUXP[15]/VAUXN[15]
-	  Valid values for dual external multiplexer mode are:
-		1: VAUXP[0]/VAUXN[0] - VAUXP[8]/VAUXN[8]
-		2: VAUXP[1]/VAUXN[1] - VAUXP[9]/VAUXN[9]
-		...
-		8: VAUXP[7]/VAUXN[7] - VAUXP[15]/VAUXN[15]
-
-	  This property needs to be present if the device is configured for
-	  external multiplexer mode (either single or dual). If the device is
-	  not using external multiplexer mode the property is ignored.
-	- xnlx,channels: List of external channels that are connected to the ADC
-	  Required properties:
-		* #address-cells: Should be 1.
-		* #size-cells: Should be 0.
-
-	  The child nodes of this node represent the external channels which are
-	  connected to the ADC. If the property is no present no external
-	  channels will be assumed to be connected.
-
-	  Each child node represents one channel and has the following
-	  properties:
-		Required properties:
-			* reg: Pair of pins the channel is connected to.
-				0: VP/VN
-				1: VAUXP[0]/VAUXN[0]
-				2: VAUXP[1]/VAUXN[1]
-				...
-				16: VAUXP[15]/VAUXN[15]
-			  Note each channel number should only be used at most
-			  once.
-		Optional properties:
-			* xlnx,bipolar: If set the channel is used in bipolar
-			  mode.
-
-
-Examples:
-	xadc@f8007100 {
-		compatible = "xlnx,zynq-xadc-1.00.a";
-		reg = <0xf8007100 0x20>;
-		interrupts = <0 7 4>;
-		interrupt-parent = <&gic>;
-		clocks = <&pcap_clk>;
-
-		xlnx,channels {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			channel@0 {
-				reg = <0>;
-			};
-			channel@1 {
-				reg = <1>;
-			};
-			channel@8 {
-				reg = <8>;
-			};
-		};
-	};
-
-	xadc@43200000 {
-		compatible = "xlnx,axi-xadc-1.00.a";
-		reg = <0x43200000 0x1000>;
-		interrupts = <0 53 4>;
-		interrupt-parent = <&gic>;
-		clocks = <&fpga1_clk>;
-
-		xlnx,channels {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			channel@0 {
-				reg = <0>;
-				xlnx,bipolar;
-			};
-		};
-	};
-
-	adc@80000000 {
-		compatible = "xlnx,system-management-wiz-1.3";
-		reg = <0x80000000 0x1000>;
-		interrupts = <0 81 4>;
-		interrupt-parent = <&gic>;
-		clocks = <&fpga1_clk>;
-
-		xlnx,channels {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			channel@0 {
-				reg = <0>;
-				xlnx,bipolar;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml
new file mode 100644
index 000000000000..a32b712d8485
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml
@@ -0,0 +1,174 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/xilinx-xadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx 7 Series XADC and UltraScale/UltraScale+ System Monitor
+
+maintainers:
+  - Avermoal <avermoal@gmail.com>
+
+description: |
+  The Xilinx XADC is an ADC that can be found in the Series 7 FPGAs from Xilinx.
+  The XADC has a DRP interface for communication. Currently two different
+  frontends for the DRP interface exist. One that is only available on the ZYNQ
+  family as a hardmacro in the SoC portion of the ZYNQ. The other one is
+  available on all series 7 platforms and is a softmacro with an AXI interface.
+  This binding document describes the bindings for both of them since the
+  bindings are very similar.
+
+  The Xilinx System Monitor is an ADC that is found in the UltraScale and
+  UltraScale+ FPGAs from Xilinx. The System Monitor provides a DRP interface
+  for communication. Xilinx provides a standard IP core that can be used to
+  access the System Monitor through an AXI interface in the FPGA fabric.
+  This IP core is called the Xilinx System Management Wizard. This document
+  describes the bindings for this IP.
+
+properties:
+  compatible:
+    description: |
+      Specifies the interface type and the target device.
+      - "xlnx,zynq-xadc-1.00.a"
+      for ZYNQ device configuration interface (hardmacro in SoC)
+      - "xlnx,axi-xadc-1.00.a"
+      for AXI pcore softmacro on all Series 7 FPGAs
+      - "xlnx,system-management-wiz-1.3"
+      for UltraScale/UltraScale+ System Monitor via AXI
+    enum:
+      - xlnx,zynq-xadc-1.00.a
+      - xlnx,axi-xadc-1.00.a
+      - xlnx,system-management-wiz-1.3
+
+  reg:
+    description: Address and length of the register set for the device.
+    maxItems: 1
+
+  interrupts:
+    description: Interrupt for the XADC control interface.
+    maxItems: 1
+
+  clocks:
+    description: |
+      When using the ZYNQ this must be the ZYNQ PCAP clock,
+      when using the axi-xadc or the axi-system-management-wizard this must be
+      the clock that provides the clock to the AXI bus interface of the core.
+    maxItems: 1
+
+  xlnx,external-mux:
+    description: |
+      External multiplexer mode. If omitted, defaults to "none".
+      - "none" – no external multiplexer (default)
+      - "single" – one external multiplexer
+      - "dual" – two external multiplexers for simultaneous sampling
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [none, single, dual]
+    default: none
+
+  xlnx,external-mux-channel:
+    description: |
+      Configures which pair of pins is used to sample data in external mux mode.
+      For single mode: 0 (VP/VN) or 1..16 (VAUXP[0..15]/VAUXN[0..15]).
+      For dual mode: 1..8, where the value n corresponds to the pair
+      (VAUXP[n-1]/VAUXN[n-1] and VAUXP[n+7]/VAUXN[n+7]).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 16
+
+  xlnx,channels:
+    description: |
+      Container for external channels that are connected to the ADC.
+      If this property is not present, no external channels will be assumed.
+    type: object
+    properties:
+      "#address-cells":
+        const: 1
+      "#size-cells":
+        const: 0
+    patternProperties:
+      "^channel@[0-9a-f]+$":
+        type: object
+        description: Each child node represents one external channel.
+        properties:
+          reg:
+            description: |
+              Pair of pins the channel is connected to.
+              0: VP/VN
+              1..16: VAUXP[0..15]/VAUXN[0..15]
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minimum: 0
+            maximum: 16
+          xlnx,bipolar:
+            description: If present, the channel is used in bipolar mode.
+            type: boolean
+        required:
+          - reg
+        additionalProperties: false
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    xadc@f8007100 {
+        compatible = "xlnx,zynq-xadc-1.00.a";
+        reg = <0xf8007100 0x20>;
+        interrupts = <0 7 4>;
+        interrupt-parent = <&gic>;
+        clocks = <&pcap_clk>;
+
+        xlnx,channels {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                reg = <0>;
+            };
+            channel@1 {
+                reg = <1>;
+            };
+            channel@8 {
+                reg = <8>;
+            };
+        };
+    };
+  - |
+    xadc@43200000 {
+        compatible = "xlnx,axi-xadc-1.00.a";
+        reg = <0x43200000 0x1000>;
+        interrupts = <0 53 4>;
+        interrupt-parent = <&gic>;
+        clocks = <&fpga1_clk>;
+
+        xlnx,channels {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                reg = <0>;
+                xlnx,bipolar;
+            };
+        };
+    };
+  - |
+    adc@80000000 {
+        compatible = "xlnx,system-management-wiz-1.3";
+        reg = <0x80000000 0x1000>;
+        interrupts = <0 81 4>;
+        interrupt-parent = <&gic>;
+        clocks = <&fpga1_clk>;
+
+        xlnx,channels {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                reg = <0>;
+                xlnx,bipolar;
+            };
+        };
+    };
+...
-- 
2.52.0

