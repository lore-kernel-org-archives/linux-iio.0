Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD05312832
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778401969; cv=none; b=OR6/diQxQVZYJbtWFJyUZdDMgx/5XlgX/cgaDWQroLZ5DD5KW3qFFsjbo9rYaohvdl3ygmsed57cX1npyJRlwgYqCExJeSWIc54EUP/YtqDb9fS8j7wOhVkKhVuvwpUZ9N3ddF8Nz74cQriGUG6w0ReEH5xGibAcSuo6XxYhUYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778401969; c=relaxed/simple;
	bh=o8pfL5G5rJZI01SeV6wPVWXErslsDBG0Ha3t12W/pMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YiSlm2k+dFZubD+AsxFmrzF3m8hiIXio3qlcMSJiMqokoWRwiNvP8RmajUM10z45f2YFQlogS773qwTTr8xnXyBYmt1zCWWNSKsB7lqm4OghCzT5J4vR48DLqH+0+Qe9fgpc0OYF+QWXOG0uQyj/EKfNhbjhbxXl9KCUbupU/ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSFeNGa6; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSFeNGa6"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3660daea6a5so1661509a91.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 01:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778401968; x=1779006768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uwl7uTUFZPbM8ps4vki7wqlVfVEhcSD+BeosCTjucic=;
        b=RSFeNGa6aoEiQ/THOt/dNGiCR/i4h3QYwOiXmJHIHFGV7pYep0QN4ckh+b7kZhWS6l
         uS5MgKV9Wm1tIDBPPW+fWqBrAWypINRorUCwsN3PAQvpb/Cs5eBFUby3JmhinnDpDkpl
         +Ie+f7coQ5wls/YbjRebTwZ/URSOLgoX/IwWXCdRV9uY4UgazIyyjy0isAUB30oAdzai
         /63T984RPZSm6CIpC2QLZvQ2yq5CkNELiUnPdX3hB7eWNgqt+e3+rqNn/hPN0uJOlkfN
         ar9XmVeznmPmbYTHVqrzxSEVx6TNjIdVLsJsxNcAkRnJbr0O+NkGS6Ja5XKlVAgejBg0
         sxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778401968; x=1779006768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uwl7uTUFZPbM8ps4vki7wqlVfVEhcSD+BeosCTjucic=;
        b=nDFqtCuK/GqDygXyHtdZL1epo1zxTfwxCSBiKyAI0/yat1qRWeVY2dgjNu+9JuEUY0
         24wY1eaJDIwoW706dJTjdCcrAKf4TJTah3kbco8SGaC4kYGkJk6SaFG94rk0LpKbfmf1
         CwlRwfk8zycmDX9GY+B5vLyzbEI8zfPQ5Xj7UcxxShzriftXYgYxIqI+JYF8ISviS5VI
         x0zwOkcNILAtEMgOPlUfzlidRlULOBcQunMtlCjwvxUsJVQnvB3sHf6J3t18bM4YPTKH
         BSaEUYH3bfhwf/pp0gryGQsz9pfpBnXJN+E5J6dIuHKns8JCh3zpsSM8IQLS1mstvbGG
         plJg==
X-Forwarded-Encrypted: i=1; AFNElJ8Gzwl4fxFXYxTPtvfdLQ18JNVut2a+Iyizz668tZuW9x1RfUUGdEj0axsrkhfo0sMVsgQ3MTc5bsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzv96BlJGNIXUWUG/cMc/FCx5G27wiS9vC24rN5eqzVsJjmzJW
	ThibSKAAwNWaU5ucm59gLT4O3BgzLwtGpR20kOBXfvEAapO0n1OCurZY
X-Gm-Gg: Acq92OGqj+jsp1po2xGz9kf13pEgLmqBzFiLyz34AoCYAr1WbhD7y7EH4ve1G4VHiHp
	NdX/0aTx544IvwbOTO4xJyk2xjN0CmNFx+xEJ7qH6flU9ppKetc1rwtRnC3axLW+vQ/G4wY4lhS
	UHK5t8trbHsUdrOVJjKlk5QmgvWBiRnctxefv4kt+Wqty7DVzFhBJqPR7jO4yM0P+ma1hxLmBTA
	GNVKJ6nV3ahCnRRckqIR/360IMCcKwIb1jjl3SArWh8uwHMrGUAlM9kZy4SF8Y4wIBUVCe7CH+n
	bk6gFzy++0giS4yxHSh5W+Kbu1o4ECQCiw5SGEzrCdv/we4p2HsUQUJtJtp2MGTEi9OLV3HG0+9
	7Tzo/Zq1WVI0lA0tUH/+QRrcqks7/Vwbw5b2kNtFixKSa4bH77zxEgYZdWlPulVkBhqwxjkRa5k
	54tXO4MpH06SEhewvfudu5y4T2rAzeTDQtuttwHyqj
X-Received: by 2002:a17:90b:3a4c:b0:35a:24f3:2c8e with SMTP id 98e67ed59e1d1-365abbe3c04mr18913912a91.9.1778401967242;
        Sun, 10 May 2026 01:32:47 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d008:80b:a00:27ff:feb6:42dd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d629f3b5sm4148283a91.8.2026.05.10.01.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 01:32:46 -0700 (PDT)
From: Pramod Maurya <pramod.nexgen@gmail.com>
To: jic23@kernel.org
Cc: pramod.nexgen@gmail.com,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: iio: adc: Convert xilinx-xadc bindings to YAML schema
Date: Sun, 10 May 2026 04:32:13 -0400
Message-ID: <20260510083219.70224-1-pramod.nexgen@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Xilinx XADC and UltraScale System Monitor device tree binding
from the legacy plain-text format to a YAML schema, enabling automated
validation with dt-schema.

The new binding covers the same hardware and compatible strings:
  - xlnx,zynq-xadc-1.00.a (ZYNQ hardmacro)
  - xlnx,axi-xadc-1.00.a  (AXI softmacro)
  - xlnx,system-management-wiz-1.3 (UltraScale System Management Wizard)

Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
---
Changes in v3:
- Move xlnx,channels from properties: to patternProperties: to satisfy
  vendor-props.yaml meta-schema, which requires vendor-prefixed entries
  in properties: to be type: boolean; xlnx,channels is a subnode (object)
  so it belongs in patternProperties:

Changes in v2:
- Fix patternProperties regex to use lowercase hex unit addresses
  (channel@a through channel@f) instead of decimal; correct range
  is now "^channel@([0-9a-f]|10)$"
- Add allOf/if/then conditional to enforce xlnx,external-mux-channel
  is required when xlnx,external-mux is "single" or "dual"

 .../bindings/iio/adc/xilinx-xadc.txt          | 141 ------------
 .../bindings/iio/adc/xlnx,xadc.yaml           | 205 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 3 files changed, 212 insertions(+), 141 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml

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
diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
new file mode 100644
index 000000000000..ab6f16109aeb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
@@ -0,0 +1,205 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/xlnx,xadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx XADC and UltraScale System Monitor
+
+maintainers:
+  - Lars-Peter Clausen <lars@metafoo.de>
+
+description: |
+  The Xilinx XADC is an ADC found in the Series 7 FPGAs. It has a DRP
+  (Dynamic Reconfiguration Port) interface for communication. Two different
+  frontends for the DRP interface are supported:
+
+    - ZYNQ hardmacro: available only on the ZYNQ family as a hardmacro in
+      the SoC portion of the ZYNQ device.
+    - AXI softmacro: available on all Series 7 platforms as a softmacro
+      with an AXI interface (PG019).
+
+  The Xilinx System Monitor is an ADC found in UltraScale and UltraScale+
+  FPGAs. It is accessed through the Xilinx System Management Wizard IP core
+  via an AXI interface in the FPGA fabric.
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
+    maxItems: 1
+
+  clocks:
+    description: |
+      When using the ZYNQ this must be the ZYNQ PCAP clock.
+      When using the axi-xadc or system-management-wiz this must be
+      the clock that provides the clock to the AXI bus interface.
+    maxItems: 1
+
+  xlnx,external-mux:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Selects the external multiplexer mode.
+    enum:
+      - none
+      - single
+      - dual
+
+  xlnx,external-mux-channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Configures which pair of pins is used to sample data in external
+      multiplexer mode. This property is required when the device is
+      configured for external multiplexer mode.
+
+      Valid values for single external multiplexer mode:
+        0: VP/VN
+        1-16: VAUXP[0]/VAUXN[0] through VAUXP[15]/VAUXN[15]
+
+      Valid values for dual external multiplexer mode:
+        1: VAUXP[0]/VAUXN[0] - VAUXP[8]/VAUXN[8]
+        2: VAUXP[1]/VAUXN[1] - VAUXP[9]/VAUXN[9]
+        ...
+        8: VAUXP[7]/VAUXN[7] - VAUXP[15]/VAUXN[15]
+    minimum: 0
+    maximum: 16
+
+patternProperties:
+  "^xlnx,channels$":
+    type: object
+    description:
+      List of external channels connected to the ADC. If this property is
+      absent, no external channels are assumed to be connected.
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^channel@([0-9a-f]|10)$":
+        type: object
+        description:
+          Represents an external channel connected to the ADC.
+
+        properties:
+          reg:
+            description: |
+              Pair of pins the channel is connected to.
+                0: VP/VN
+                1: VAUXP[0]/VAUXN[0]
+                2: VAUXP[1]/VAUXN[1]
+                ...
+                16: VAUXP[15]/VAUXN[15]
+            minimum: 0
+            maximum: 16
+
+          xlnx,bipolar:
+            $ref: /schemas/types.yaml#/definitions/flag
+            type: boolean
+            description:
+              If set, the channel is used in bipolar mode.
+
+        required:
+          - reg
+
+        additionalProperties: false
+
+    required:
+      - '#address-cells'
+      - '#size-cells'
+
+    additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        xlnx,external-mux:
+          enum:
+            - single
+            - dual
+      required:
+        - xlnx,external-mux
+    then:
+      required:
+        - xlnx,external-mux-channel
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    /* ZYNQ hardmacro example */
+    adc@f8007100 {
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
+
+  - |
+    /* AXI softmacro example */
+    adc@43200000 {
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
+
+  - |
+    /* UltraScale System Management Wizard example */
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..9b107057ad8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29226,6 +29226,13 @@ F:	Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
 F:	drivers/watchdog/of_xilinx_wdt.c
 F:	drivers/watchdog/xilinx_wwdt.c
 
+XILINX XADC DRIVER
+M:	Lars-Peter Clausen <lars@metafoo.de>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
+F:	drivers/iio/adc/xilinx-xadc*
+
 XILINX XDMA DRIVER
 M:	Lizhi Hou <lizhi.hou@amd.com>
 M:	Brian Xu <brian.xu@amd.com>
-- 
2.52.0

