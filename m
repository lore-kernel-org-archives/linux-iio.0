Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB453F7AB1
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778831919; cv=none; b=tsnQu0BgNAeEAw76XnLZlwad3qfUFdoEky19+/LW2NKBdxtJ29itI2iHHTOER1lpP8hvz4P1X0yVJFM89fZwUF6Oe7WeFw/pR/IXon25JfrE1zgl+q8rmaBqp6Nj+31HK4J5QC6W9ddcIvoFreKjbQhY/kh4AVYIaYxSnZHYlZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778831919; c=relaxed/simple;
	bh=b66pnBT8a97F3xfRqp9174x/oLh8WkkmAfQefImwv9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrHeLdOksybFnAnkCCd+/nl9Sk1E+S5UaS7DOd/WxIZvEzZHN1Qx1MBHYnTDiGuYThSdOvaHQ5+NjKiNp28SwrBNegIRFbowhT6APfw5s0eF5OAuWVYI1lRrgIO3HZH2G/FslVkCQ5vU6kN4OZTd0680sjb/MP3w+n4FL+CteHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHxDHimO; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHxDHimO"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36643b96b99so6476664a91.0
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 00:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778831916; x=1779436716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cl4rPiyhUQMqgrmFZmcx0RjrEneUBteFh/YjQtcvgsc=;
        b=iHxDHimO4F/jZsyQ0fCITL1FsMwozJ/HmEYV2Fhcd/k42IJJTTpv9XAzMpJFSX9k+6
         WmUrEwiDZt5i2tyMDPLa7xIIwAOzDqLTZKWJ9gq5CB6AVJHLZoN9L4DDD2GYy99ixtDL
         TBcqe3ujy4i+F4fAG+gzbTNJ25otwD2YzD85SDCCmTLgmW8Oky7jCsXO1wFV9rxTlkfn
         IChFzzrGzv963+BkaxWRxgl9wgRAfVqMwDfFB/J4zgUSQ0N+2CNqXOSlH6hFxEMca69V
         xxLYNM+6sdXEQQL2ce+xU2NKBJ7mc7eUD8E7IC2vBMl8WUCbibc28uiRRwuzP21k+gw6
         QaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778831916; x=1779436716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cl4rPiyhUQMqgrmFZmcx0RjrEneUBteFh/YjQtcvgsc=;
        b=Iziu1zyLhpLPk7vEuL0ILAT8svwgOAB28QY51lfKOhCi3/NIqWhotOLcHDni8SZtiR
         sY0YT+KAY7uw42njGAdL/72KoBU5aNa2cWh3y4WiGBwAvq6g784f/24xqW0Cd+7S8a2v
         JSLzEG4uD5wYTBuID+1lVCBGNh+25ynKdXu5siqrmid0cyS+SyzRl7k4MX0Ph3X/Y8uw
         yuJNORMH2MryrPlFmt526yvUDg6B+odsJgY5iEJkK33NeGTFkJdmlgOCqtVaMrult5nR
         OVOI9mS98OwIsep9LU66QdyKfARGBJGR+k6xCN1XRof68PvKdQvjLCxtJAqI6xYZPrux
         Z5uA==
X-Forwarded-Encrypted: i=1; AFNElJ8sWtoBQH24C+oPMDYsNqVmbQOP1BTXudTxfnr21TjgG2I6QCx3OGxR4rTLcHwXFSdcLmx29jBtSZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpLXOA8AOpgy71fsHKGitQc3s7cEsAMhu6nZrj23sdb7WX2Gew
	IEycAzLIlNstQ0dqgyqXDhukB9YBEczgnhdHFN6Fy4cnw1+4Z0I1Y72d
X-Gm-Gg: Acq92OFGX7/p9rgi/K2LmpWpAOk49ZbtquFEbdp6jI4oNmFzBqI8AY58qvbanH/laVH
	KIJJbeOaqiREkbkMOA1SF4EcBH+Hmpfc1H7UVcNbmoiQItNdZ2C/QFg/lTIWfc4Oer874OXUlCZ
	mxYd5o3tW0I4hLYCgC2VS+TKmwwQo+qbbLIdvsjDPLF2wxE6I1m/6HHlLebPIKxzkJVRjSC0JhA
	mRyo9DmQ63VOgRXWX3ab0VicNMdjBHgqn+0PkgjVJNH1QZ/vaINrAWGXXrY/ksL6qxP55M3SvXK
	zzPQEnVjH9b3vFLzCyqtf8FLHybgOAihWQ5mp2XJqzXyfRalVEBXPMXopJa4pNlAfdjtzcDQkvC
	d9E3bkJXU0R18HbLWOFhK0pF6rH6ShuEnrppYQAPcuHzuHRNZr8o33DBCYd36HQKVJ05prUbbUj
	wc7DH7qekig6d9htkEvWdKZreSrb9ANpWFe+cUfwKVFvv9feuVOag=
X-Received: by 2002:a17:90b:57c7:b0:365:7e4d:bcb8 with SMTP id 98e67ed59e1d1-369519cdb59mr2843557a91.1.1778831916312;
        Fri, 15 May 2026 00:58:36 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d008:80b:a00:27ff:feb6:42dd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36959c7eacesm542040a91.2.2026.05.15.00.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 00:58:35 -0700 (PDT)
From: Pramod Maurya <pramod.nexgen@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pramod.nexgen@gmail.com
Subject: [PATCH v4 1/3] dt-bindings: iio: adc: Convert xilinx-xadc bindings to YAML schema
Date: Fri, 15 May 2026 03:57:34 -0400
Message-ID: <20260515075736.172172-2-pramod.nexgen@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515075736.172172-1-pramod.nexgen@gmail.com>
References: <20260510083219.70224-1-pramod.nexgen@gmail.com>
 <20260515075736.172172-1-pramod.nexgen@gmail.com>
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

The xlnx,channels subnode retains its legacy name (including the comma)
for backwards compatibility with existing device trees.

Place xlnx,channels under properties: now that dt-schema PR#195 allows
comma-containing nodenames for long-established bindings. Fix reg
constraints inside channel subnodes to use maxItems and an items block
rather than bare minimum/maximum keywords which are silently ignored on
array types. Remove the redundant type: boolean from xlnx,bipolar since
the $ref to /schemas/types.yaml#/definitions/flag already implies it.

Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
---
Changes in v4:
- Move xlnx,channels from patternProperties: to properties: per Rob
  Herring's guidance (keywords.yaml: "Fixed strings belong in properties")
  This requires a companion dt-schema update to add xlnx,channels as an
  object-type exception in vendor-props.yaml (like adi,channels).
- Fix reg constraints inside channel subnodes: remove items block with
  minimum/maximum which is invalid for cell arrays per cell.yaml; the
  valid channel range (0-16) is documented in the description instead.
- Remove redundant type: boolean from xlnx,bipolar; the $ref to
  /schemas/types.yaml#/definitions/flag already implies boolean type.
- Fix patternProperties regex for channel subnodes to "^channel@([0-9a-f]|10)$"
  covering all valid hex unit addresses for channels 0-16.

Changes in v3:
- Move xlnx,channels from properties: to patternProperties: to satisfy
  vendor-props.yaml meta-schema (reversed in v4, see above)

Changes in v2:
- Fix patternProperties regex to use lowercase hex unit addresses
- Add allOf/if/then conditional requiring xlnx,external-mux-channel
  when xlnx,external-mux is "single" or "dual"

 .../bindings/iio/adc/xilinx-xadc.txt          | 141 ------------
 .../bindings/iio/adc/xlnx,xadc.yaml           | 210 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 3 files changed, 217 insertions(+), 141 deletions(-)
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
index 000000000000..06a0ce498352
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xlnx,xadc.yaml
@@ -0,0 +1,210 @@
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
+  The xlnx,channels subnode name contains a comma as part of the legacy
+  device tree binding that has been in use for over a decade. This name is
+  retained for backwards compatibility with existing device trees.
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
+      Selects the external multiplexer mode. If omitted, no external
+      multiplexer is used.
+    enum:
+      - none
+      - single
+      - dual
+
+  xlnx,external-mux-channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Configures which pair of pins is used to sample data in external
+      multiplexer mode. Required when xlnx,external-mux is "single" or
+      "dual".
+
+      Valid values for single external multiplexer mode:
+        0: VP/VN
+        1: VAUXP[0]/VAUXN[0]
+        2: VAUXP[1]/VAUXN[1]
+        ...
+        16: VAUXP[15]/VAUXN[15]
+
+      Valid values for dual external multiplexer mode:
+        1: VAUXP[0]/VAUXN[0] - VAUXP[8]/VAUXN[8]
+        2: VAUXP[1]/VAUXN[1] - VAUXP[9]/VAUXN[9]
+        ...
+        8: VAUXP[7]/VAUXN[7] - VAUXP[15]/VAUXN[15]
+    minimum: 0
+    maximum: 16
+
+  xlnx,channels:
+    type: object
+    description:
+      List of external channels connected to the ADC. If this node is
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
+            maxItems: 1
+
+          xlnx,bipolar:
+            $ref: /schemas/types.yaml#/definitions/flag
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
index b2040011a386..58d35c17704d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29266,6 +29266,13 @@ F:	Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
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

