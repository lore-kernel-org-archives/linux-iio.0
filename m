Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F6357D0F
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753720; cv=none; b=RyPkuZeroP6dcZeI4TK/LsEOQSMz5lvsjT+/V1kchB/XO2mIAhoFQYTvbrSiX90ZYdH8vmlp0JX6570b4xCPJurkvXKimhLpRCcfXg1GtbYYiXRMvRBFC2cmZxexGWLFvkOt6IuWM9S8bUcW1V7QxSdlNxVj3ZLJe46QWzLqdZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753720; c=relaxed/simple;
	bh=OUN+pfzR5anohMB5Jqn5sg8VfCunB66oixWjJ/x8nhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7yC+hzKq8sPIVghUpQ8bdzqDnz6Vjipp/1CpItTnvpj+3TsE1DE8vWqo6zl1baBXq/q2QGBp/Ma7wrts2oy5gVL3197DKd0FZaoAS1flmQ24rejeyyhERn08sQp11ysf53OEAyA8bZDZ15eHYD7wy4iLatvVnnmu5REUFr5QGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQsHxrON; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQsHxrON"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so7642925e9.3
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789753713; x=1790358513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kDUreuc76Q9stUrtsT2uw4I0y03Sjd0Pb3pKM1mRunI=;
        b=XQsHxrON8Z4wIU88EqA03RDwB15mC/yqZhwCp4RZDBdaFmSDQLzMT/clTmlqJqndfE
         3fj1NYWFbes1mkDvwjgBlSxhEw60BRmNKujYRuXmVp4kVbJ6Q73Jmbr5AGQQmHY3GO9X
         zOicSeexWZOKoWEiAMalZSFMciN2cP/qO9klIQxUOpy+izhOCo0h4sm0hyCPUW0qeoCq
         zMJB+zuCGteJKBjbPtj+0RYXdZExaBX6BOrBoC40zcikA7iX5rutwE+jd0iwtDZLxl6s
         mLFjxUcnw6Ovs+wgfHYsQaUauer7JHFpbSWDIeEwaddXzM+7URbv8y/WAG8S77Z5Khsy
         jV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789753713; x=1790358513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kDUreuc76Q9stUrtsT2uw4I0y03Sjd0Pb3pKM1mRunI=;
        b=FpOBn2lB+tcLxU+5+KOsfvPqUFENAW6hJeaWhzGdM3b2Z/muNqVQ/np1zls81GG40R
         1mRvWwpXaOPYzTudGwpwV6pjGO10H1O97/hX4LTvdo6Bl/5wYkY4mO3iV00p1HlJva/x
         zVWzNqhstfVhGQCfXRfZRhwSDS5bwH6S9RcvmeE6+nUj43QkfulgnEpHIwwqnO+yIPv8
         YFZ5QEZopL49zRvTFtndN3ljNURS6EbuF6sjTt/hCY4kiYgWmaF5WDugugo+cJkYg8IZ
         oyAa8EEMHIlgqmGbbAEWP89OwLTkCbk4TU7NZlkTNeuSFLCWaMmnm6JwCtP9BSPfGQVP
         Y6ZQ==
X-Gm-Message-State: AFuF++lUErk2VCb04z9lEerlRWSAwHRofFO5YUvHZJMxmLa7JrtV5rOg
	kXF8EYTsFMu5GDWI2dnM2o+2uI4SpAAJxJhPhCg6s+r6Vc5cJvoP4Qlo
X-Gm-Gg: AYBFou2Ig1zoccfYibHbsdGFRQzlreuY218gtGmD+Oh6Fgdpz02GoXUgJ4nG0LICTrN
	TR+zKyCBlatrF6i+uRumKvfXTzTTUTcpcGO/u0emjc0anpGlvXmDc3PB4j43Ujjw3HeQeTFmJG3
	tErrSnNSysmSDl8DmrEXWH+HNjgyYKZgPt8T8ZXn908XObflxF4+h296TGvtg2vdDwz49bhp6aJ
	Kjtk3b27qDNlelPdd5CQWS8H2IPMxE54xc7M1YSAzJlbQxTkP0Rgpq6WvUtGA2+CotDL7c3V4xg
	lbHwuDc+Togf228AohcQktFjKJtrr2lRmyqFVzy3qHgl/K5PQWdc8Xo62jLzzWs3yAbnX7RuvFF
	NOcCSAVXd5S2GM1ykm8gozniFtmI/U+3du0MdxJxSZg6PBNJeMamO2u8p+qcP/JBQ544W0rOLeC
	Y4EJpJ/bcRZqtk3IkgDDp94L9iWWAJThZOrYmyIMvUDNoOCbg6byYHdqJllYP1rrbPHqfD6h7Fr
	2gdHCGQNtcr7+6J2olFvAi6jAgEOxf+zooPP3ynH+LBy2zVcSgmMeULNg==
X-Received: by 2002:a05:600c:8518:b0:49d:28c4:b304 with SMTP id 5b1f17b1804b1-49fc5741563mr45794005e9.29.1789753712600;
        Fri, 18 Sep 2026 10:48:32 -0700 (PDT)
Received: from localhost.localdomain ([176.220.123.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0f8563sm9871595e9.6.2026.09.18.10.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 10:48:32 -0700 (PDT)
From: Omer PALA <palaomer100@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: iio: adc: Add dt binding to xlnx,xadc
Date: Fri, 18 Sep 2026 20:48:09 +0300
Message-ID: <20260918174809.17502-1-palaomer100@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918145804.26957-1-palaomer100@gmail.com>
References: <20260918145804.26957-1-palaomer100@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add yaml devicetree binding for xlnx,zynq-xadc-1.00.a,
xlnx,axi-xadc-1.00.a and xlnx,system-management-wiz-1.3 from
xilinx-xadc.txt file.

Signed-off-by: Omer PALA <palaomer100@gmail.com>
---
 Changes in v2:
 - Fix logic in xlnx,channels node by adding missing required properties
   (#address-cells and #size-cells).
 - Update conditional logic in allOf section to enforce required properties
   for 'single' and 'dual' external-mux modes.
 - Add SPDX license identifier header at top of schema file.

.../bindings/iio/adc/xilinx-xadc.txt          | 141 -------------
 .../bindings/iio/adc/xlnx,xadc.yaml           | 185 ++++++++++++++++++
 2 files changed, 185 insertions(+), 141 deletions(-)
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
index 000000000..f9b717c29
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
@@ -0,0 +1,185 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/xlnx,xadc.yaml#
+$schema: http://devicetree.org/schemas/meta-schema.yaml#
+
+title: Xilinx XADC device driver
+
+maintainers:
+  - Omer PALA <palaomer100@gmail.com>
+
+description: |
+  This binding document describes the bindings for the Xilinx 7 Series XADC as well
+  as the UltraScale/UltraScale+ System Monitor.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,zynq-xadc-1.00.a
+      - xlnx,axi-xadc-1.00.a
+      - xlnx,system-management-wiz-1.3
+
+  reg:
+    description: Address and length of the register set for the device
+    maxItems: 1
+
+  interrupts:
+    description: Interrupt for the XADC control interface.
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupt-parent: true
+
+  xlnx,external-mux:
+    description: Selects the external mux mode.
+    enum: [none, single, dual]
+    default: none
+
+  xlnx,external-mux-channel:
+    description: >
+      Configures which pair of pins is used to sample data in
+      external mux mode.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  xlnx,channels:
+    type: object
+    description: List of external channels that are connected to the ADC.
+    properties:
+      "#address-cells":
+        const: 1
+      "#size-cells":
+        const: 0
+    required:
+      - "#address-cells"
+      - "#size-cells"
+    patternProperties:
+      "^channel@[0-9a-f]+$":
+        type: object
+        properties:
+          reg:
+            description: Pair of pins the channel is connected to
+            minimum: 0
+            maximum: 16
+          xlnx,bipolar:
+            description: If set the channel is used in bipolar mode.
+            $ref: /schemas/types.yaml#/definitions/flag
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
+allOf:
+  - if:
+      properties:
+        xlnx,external-mux:
+          const: none
+    then:
+      properties:
+        xlnx,external-mux-channel: false
+
+  - if:
+      properties:
+        xlnx,external-mux:
+          const: single
+    then:
+      properties:
+        xlnx,external-mux-channel:
+          minimum: 0
+          maximum: 16
+      required:
+        - xlnx,external-mux-channel
+
+  - if:
+      properties:
+        xlnx,external-mux:
+          const: dual
+    then:
+      properties:
+        xlnx,external-mux-channel:
+          minimum: 1
+          maximum: 8
+      required:
+        - xlnx,external-mux-channel
+
+examples:
+  - |
+    soc {
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      xadc@f8007100 {
+        compatible = "xlnx,zynq-xadc-1.00.a";
+        reg = <0xf8007100 0x20>;
+        interrupts = <0 7 4>;
+        interrupt-parent = <&gic>;
+        clocks = <&pcap_clk>;
+
+        xlnx,external-mux = "single";
+        xlnx,external-mux-channel = <0>;
+
+        xlnx,channels {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          channel@0 {
+            reg = <0>;
+          };
+          channel@1 {
+            reg = <1>;
+          };
+          channel@8 {
+            reg = <8>;
+          };
+        };
+      };
+      xadc@43200000 {
+        compatible = "xlnx,axi-xadc-1.00.a";
+        reg = <0x43200000 0x1000>;
+        interrupts = <0 53 4>;
+        interrupt-parent = <&gic>;
+        clocks = <&fpga1_clk>;
+
+        xlnx,external-mux = "single";
+        xlnx,external-mux-channel = <0>;
+
+        xlnx,channels {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          channel@0 {
+            reg = <0>;
+            xlnx,bipolar;
+          };
+        };
+      };
+      adc@80000000 {
+        compatible = "xlnx,system-management-wiz-1.3";
+        reg = <0x80000000 0x1000>;
+        interrupts = <0 81 4>;
+        interrupt-parent = <&gic>;
+        clocks = <&fpga1_clk>;
+
+        xlnx,external-mux = "single";
+        xlnx,external-mux-channel = <0>;
+
+        xlnx,channels {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          channel@0 {
+            reg = <0>;
+            xlnx,bipolar;
+          };
+        };
+      };
+    };
-- 
2.55.0

