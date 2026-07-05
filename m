Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D410913E41A
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783241619; cv=none; b=ggBNx5veDYeZgUdyk7n18ItlakDAHfyiu0RmWOqBFU30jAlFUVWWlVRk1+qM7RQbTUkaxsiqciC6dPPXVcET2CIE+hyHofJK6Vb4SEAH4+VL46fDW6JohQvAxmO/e6O/jp7ZuWoVeKOdffC/4I1sW9AHdMoKjo1Cr7x1/L+S6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783241619; c=relaxed/simple;
	bh=s6HIcV4HTSFWc5vfRv4FqGcjv3OhDT70bCWryJUAz68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oAhKBau6+Liie+L2hJJzkihtKfMHAA1GNzPNxRWS+ZD/D6YLHAdbfO1QCnkzUUGoCRmFGVgJgKVeTEmnxgu1MrzwJKSlhm/8m1v1UwS8TJ1BRPTnOCdbll4HVdM+8bKeZ16lVzmdRoF18A9C/WXHuw/+io7pbN9w06OPzooYIyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzB0sRU4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzB0sRU4"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-474303f3c72so1119573f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 01:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783241615; x=1783846415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ah/zRB/XuriwXpF5NOF9MEJmfk7QHzQ87OYCQjCuCrw=;
        b=SzB0sRU4HJm9jhG1aNpcz9rnuQ1jQ2HwkXLBEhQXIKuUVaWdOUD0NpCai4Zh62AUkD
         QahXvXnm48htWodNA97Q82ZMb/YtELutQc2cytI+Og4Cj1PK6vYIWZSmXIk6UDs/k7s6
         UXB8pgD/ncLkGVb4M2WbtkTvJWZCR+86xoPdPl5AqQ865XMaIpsj/AmFRe+8T/+cU07Q
         uZeZ3oIfHCvazMtNyYZQpvoX2cPfSRFlgZyQ/X9x17XzqvMKLYnfMyYbCRXf+pYAt3wM
         t1YAOxzgCcsPUDuAE7aOxG14ldZcUjLuNQD9K/AksyNNcVPuNqoLOjfmZjrQbrwxGh1v
         zpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783241615; x=1783846415;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ah/zRB/XuriwXpF5NOF9MEJmfk7QHzQ87OYCQjCuCrw=;
        b=cFVnIGrnfJq4lxORq9K5KIFRuNoqn+DTLUEvZHRHlkgOlfRZYnQPr1qryQLA3e+EOH
         MwAwIgLXyE5YJxedTkj/eaiOE3BqOugPI9Ywc7ViSvbqPec+G7y1T8gc0VojVuQfwcbN
         VbrmVdCBz90GraYTCY0nBKJj7A5J9Y3593ldDioDzpocq8S58fUcR2gn714cubYRSRhJ
         495OeSOLqo4VqeMfv9MsMP/mv8oDqnh2EQWao9oOISyrQvayg5+OOOZoQNJ21YO5uNYl
         fYG7Veqr6z60Til9FoU2iv9YYUjjhKZPrjmUr//on0e580a92MFNYXqOUU6c44JelIa/
         EkbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0/w8T/PPIRk4dMJ/7orHBBr8byMbSjBVbVl/68WjpIqjJf9NL83//OfTeHdGxV20HrdLYv0e+wnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/1IKZXbwO7JA/BGp7T361mPhv06YoChlR91hYhGDmIoWTLyGa
	Dzdvbc8EXmtZCTZHBg7d2wlVfo6Q/zky3NfhWB1FQ/vk/LiI3vIIXcCD
X-Gm-Gg: AfdE7ckNKH56/AzBqvRVABVXwxjU1UbHuZzF8OUqU1CmRZTnHwYVCg5NrmBwtPIGUlK
	4z+B1sYIBP6cZsa7X+00nWwKqtbfw9eRvd05J3+bYgA1rxlBHBFpTJOXDdglpLPqWQI/2Pl97Pl
	jp9oHIEAjkyGGpbwZhnLcZjpk3A3rRhj+RSCECbqfMnjJuDx/4K3ZfnYH3GkgLD25mIWm64sciT
	yZApso20XvUIC3oG6KG/u6pHPl4av8rNg8J9CaroTwnJiI2DK3uRp26xZC4EnRdUIWEPCpUXNZV
	Hrt1N5TAFevPgt4UPddhIHOd3kCV0+rqY5mZzPKQCIZ6XeLp38mU9h5JejAkZ/sTv7VBNB6ONhj
	F8SNcP1vo7G95xtlAwWcKJ/Xer54P+jVO1USpi2KI5bVeGY2ZQOB+q2eyLzNluC/hbmbLGrHNo0
	ztwGS6+Q==
X-Received: by 2002:a05:6000:1847:b0:475:e3fe:8ac3 with SMTP id ffacd0b85a97d-47aa92c0701mr7196920f8f.8.1783241614935;
        Sun, 05 Jul 2026 01:53:34 -0700 (PDT)
Received: from avermoal ([185.13.176.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm14649722f8f.11.2026.07.05.01.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:53:34 -0700 (PDT)
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
Date: Sun,  5 Jul 2026 14:53:08 +0600
Message-ID: <20260705085308.8819-2-avermoal@gmail.com>
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
 .../bindings/iio/adc/xilinx-xadc.txt          | 141 -------------
 .../bindings/iio/adc/xilinx-xadc.yaml         | 186 ++++++++++++++++++
 2 files changed, 186 insertions(+), 141 deletions(-)
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
index 000000000000..d61635516ce2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml
@@ -0,0 +1,186 @@
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
+            maxItems: 1
+          xlnx,bipolar:
+            description: If present, the channel is used in bipolar mode.
+            type: boolean
+        required:
+          - reg
+        additionalProperties: false
+    required:
+      - "#address-cells"
+      - "#size-cells"
+    additionalProperties: false
+
+allOf:
+  - if:
+      required:
+        - xlnx,external-mux
+      properties:
+        xlnx,external-mux:
+          enum: [single, dual]
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

Changes in v2:
- Fix conditional requirement for xlnx,external-mux-channel (add if/required block)
- Correct reg type in child nodes (use maxItems: 1 instead of items)
- Make #address-cells and #size-cells required under xlnx,channels
2.52.0

