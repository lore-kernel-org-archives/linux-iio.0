Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A111331EA0;
	Mon, 14 Sep 2026 03:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354969; cv=none; b=O/VEnEO55ccaFLMNzA9UQ8Z+OpE/nppGU4i62xmnC06dAyxZDbTRvbd/2UBA/xQi00SIBgiaoG/IO+LlHsY+gghpWh4ZxhbcnmTJaPFiHly90Tp6OGDALG77TCz5n5P2nCoD737Ifc3q2kC55jEfEbanvmNZ0/6l4Eh66CWAoOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354969; c=relaxed/simple;
	bh=NM9nDS6V1Ttt3+dzjhGTktluJ5Mx9bbeWCAE1KtIFPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGaQT2IROu0KXwLQQrA8SMUhQ6KCe72K+Xl0/enXFwBsA9Bj66otT3TQ1OUKeY+SW2o/hPkoyZ/JRKYGhrA/umKI7AyXqfnxVxEueIXMnWbs6WmfrYGeFF3rSevrv7kaPbPHucpT0IvFv2+7JeBkU2rcxTnRwUcpf4O3H50+tdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nyxHER3N; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nyxHER3N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hW
	f0AuAtSRuBMY7bBHxCY5GcoCoq852qX/DCCpTd/6w=; b=nyxHER3NIN1w/lY0dt
	V7LOxAHZIxRONPY1KHGrNMuHP+5f9Mx3ZdrrfdHF68CL9XHwY59bHtzQi4XkduzU
	aEMvXikpYEKYaorB2hY83dZg1MtF/XT0n3rAo/7kREfKfHxQBnuFL12JQjH2cfUJ
	I+B3OJ9nfymsTntLrjx3ZNfCI=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBnMo7CY6dqCnIwPA--.36790S2;
	Mon, 14 Sep 2026 11:02:27 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH] dt-bindings: iio: adc: xlnx,xadc: Convert to DT schema
Date: Mon, 14 Sep 2026 11:02:26 +0800
Message-ID: <20260914030226.437638-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBnMo7CY6dqCnIwPA--.36790S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw4xJF4xXry3KFy7trWDArb_yoWfCr18pF
	ZxCa9xtrs5tF13Wayftw18Ja4jy3Z5AF1rCFyqv34UCan8GFyjvry3Ka4SvF1j9rWIya47
	Xr1Yka429w1Duw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU1T5QUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5ASOBGqnY8QamQAA3D

Convert the Xilinx XADC and System Monitor binding from free-form text
to DT schema.

The xlnx,channels container and its channel child nodes are described as
a nested object, so that the external channels are validated as well.
The original text did not state that xlnx,bipolar is a boolean, but the
driver reads it with fwnode_property_read_bool(), so it is documented as
such.

The driver obtains the interrupt with platform_get_irq_optional(), so
interrupts is not listed as required even though the original text
described it that way.

The binding is placed in a file named after the compatible prefix, as it
covers both the 7 Series XADC and the UltraScale System Monitor.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 .../bindings/iio/adc/xilinx-xadc.txt          | 141 ------------------
 .../bindings/iio/adc/xlnx,xadc.yaml           | 123 +++++++++++++++
 2 files changed, 123 insertions(+), 141 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
deleted file mode 100644
index f42e18078..000000000
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
diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
new file mode 100644
index 000000000..564993ae6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/xlnx,xadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx XADC and System Monitor
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description:
+  The Xilinx XADC is an ADC found in the 7 Series FPGAs. It has a DRP
+  interface for communication, which can be reached either through the ZYNQ
+  device configuration interface or through the axi-xadc pcore. The Xilinx
+  System Monitor is an equivalent ADC found in the UltraScale and UltraScale+
+  FPGAs, accessed through the System Management Wizard IP core.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,zynq-xadc-1.00.a
+      - xlnx,axi-xadc-1.00.a
+      - xlnx,system-management-wiz-1.3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Interrupt for the XADC control interface.
+    maxItems: 1
+
+  clocks:
+    description:
+      When using the ZYNQ this is the ZYNQ PCAP clock. When using the
+      axi-xadc or the axi-system-management-wizard this is the clock that
+      feeds the AXI bus interface of the core.
+    maxItems: 1
+
+  xlnx,external-mux:
+    description:
+      External multiplexer mode. When omitted no external multiplexer is
+      assumed to be used.
+    enum: [none, single, dual]
+    default: none
+
+  xlnx,external-mux-channel:
+    description:
+      Which pair of pins is used to sample data in external multiplexer mode.
+      In single mode the valid range is 0 to 16, in dual mode 1 to 8. This
+      property is required when external multiplexer mode is used and is
+      otherwise ignored.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 16
+
+  xlnx,channels:
+    description:
+      Container for the external channels connected to the ADC. When this
+      node is absent no external channels are assumed to be connected.
+    type: object
+    additionalProperties: false
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^channel@[0-9a-f]+$":
+        type: object
+        additionalProperties: false
+
+        properties:
+          reg:
+            description:
+              Pair of pins the channel is connected to. 0 is VP/VN and 1 to
+              16 are VAUXP/VAUXN pairs. Each channel number may be used at
+              most once.
+            maxItems: 1
+
+          xlnx,bipolar:
+            description: If set the channel is used in bipolar mode.
+            type: boolean
+
+        required:
+          - reg
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    xadc@f8007100 {
+        compatible = "xlnx,zynq-xadc-1.00.a";
+        reg = <0xf8007100 0x20>;
+        interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-parent = <&gic>;
+        clocks = <&pcap_clk>;
+
+        xlnx,channels {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                xlnx,bipolar;
+            };
+        };
+    };
+...
-- 
2.43.0

