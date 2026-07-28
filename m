Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9058F4302F8;
	Tue, 28 Jul 2026 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240242; cv=none; b=Gn+T1xxQZjk/x97/goc+tNyrqkMP3wlRVAI6RB2hFa4+ClDWWlS48prUqEB1rvV29gDh8HQIx6wIRFpG5ZPewt62PCg21W6ZQYGIwnAT/7QM64tX1D17Zjf3yrypalqyh0jZNuxe7LQV+gtc/TQ3A6E/xt7qE81pd2dNbAA7m1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240242; c=relaxed/simple;
	bh=V19fbSLzvHpzMsP6Mui6fJeygeZShodtkUsSnV2ejG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=S9EjxB4zzjfApeSGg8IJSAljNGRRKPFDb+Z95Vl0/NWr4UgKtBgquruRFeVSOnqVEV2MN9L2X5tie/nDgp+XHRIuMfA4nZsIrMdUqcxeJqL6F0hdmJKlg4YndCne0i+vWgALDGiLtmnjFGuwPLZLnhfw/cICIyjVZAJPvIv/vUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dl+ZpCH6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dl+ZpCH6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785240243; x=1816776243;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=V19fbSLzvHpzMsP6Mui6fJeygeZShodtkUsSnV2ejG4=;
  b=dl+ZpCH66eC1P6S084ySz4VeMhcI6IFzdeZ7CmBlFZyLBGEfu5jMwWuq
   V3I3cQOqU05nF/B4sYPnRRtGN+8AVysCAk+bUvpTdPjsULQotakESu1xD
   J1p6prc4LChajm289Pwq3nOKhGSxHckl2Jvr/ArXBPmP1C99O2OadI0ce
   A5wBiOcswM1KaxjwvwodDl7Cmk9y40npXjm3jxEOqlwd0fzd9qsQXEoYa
   VHWKPl15D/2tDuirtEY0JwYv3vBwPLrkKvkCNbxFGBUAVkPUpNnXHBE9v
   ktDOU2Cq1Ag7/zI/sIxjMsMFE1MMt+5ekHx63ICLabq/esGI4L/+dmITq
   A==;
X-CSE-ConnectionGUID: vSGaj8DwT5qoKbKogfo4Yg==
X-CSE-MsgGUID: OaCj1pGVT1+WvFf+EbZ1YQ==
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="228423002"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2026 05:04:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 28 Jul 2026 05:03:59 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 28 Jul 2026 05:03:56 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Tue, 28 Jul 2026 15:03:48 +0300
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: add support for PAC1711
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260728-pac1711-v2-1-609bc026093c@microchip.com>
References: <20260728-pac1711-v2-0-609bc026093c@microchip.com>
In-Reply-To: <20260728-pac1711-v2-0-609bc026093c@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785240233; l=9516;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=V19fbSLzvHpzMsP6Mui6fJeygeZShodtkUsSnV2ejG4=;
 b=zKgk+u4miKxkyxINA0j6YODQ8zgLwd6STztJS3Xz6K/Mg+6g+Lufk1/13ljTn4SnOQTMSe9eb
 2TfZpeKHThPBWqEpfdXwB5j2sfCYFCY+wajqCwUVfndjMiu1akmaGGE
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

This is the device tree schema for Microchip PAC1711, PAC1721, PAC1811 and
PAC1821 single-channel power monitor with accumulator. The PAC1711 and
PAC1721 devices use 12-bit resolution for voltage and current measurements
and 24 bits for power calculations, while PAC1811 and PAC1821 have 16-bit
resolution and use 32 bits for power calculations. The 56-bit accumulator
register accumulates power (energy) or current (Coulomb counter).

PAC1711 and PAC1811 measure up to 42V Full-Scale Range, respectively 9V for
PAC1721 and PAC1821.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 .../bindings/iio/adc/microchip,pac1711.yaml        | 209 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 215 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..846e7801a1667c312c753ab8ee4d5637e258e2e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
@@ -0,0 +1,209 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/microchip,pac1711.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PAC1711 Power Monitors with Accumulator
+
+maintainers:
+  - Ariana Lazar <ariana.lazar@microchip.com>
+
+description: |
+  This device is part of the Microchip family of Power Monitors with Accumulator.
+  Datasheet links:
+  [PAC1711]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/PAC1711-Data-Sheet-DS20007058.pdf
+  [PAC1721]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/PAC1721-Single-Channel-Power-Monitor-with-Accumulator-DS20007088.pdf
+  [PAC1811]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC1811-Data-Sheet-DS20007066.pdf
+  [PAC1821]: https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC1821-Data-Sheet-DS20007097.pdf
+
+  PAC1711, PAC1721, PAC1811 and PAC1821 are Single Channel Power Monitors
+  with Accumulator, having 12-bit or 16-bit resolution. The devices PAC1711
+  and PAC1811 can measure up to 42V Full-Scale Range, respectively 9V
+  Full-Scale Range for PAC1721 and PAC1821.
+
+properties:
+  compatible:
+    enum:
+      - microchip,pac1711
+      - microchip,pac1721
+      - microchip,pac1811
+      - microchip,pac1821
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  "#io-channel-cells":
+    const: 1
+
+  interrupts:
+    description:
+      Could be triggered by overvoltage, undervoltage, overcurrent, overpower,
+      undercurrent, step limit, accumulator overflow and accumulator count
+      overflow.
+    minItems: 1
+
+  interrupt-names:
+    items:
+      - enum: [alert0, alert1]
+
+  microchip,gpio0-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Defines the function of the pin. This is a multifunction gpio digital I/O
+      pin which can be configured as alert0 interrupt, GPIO digital input, GPIO
+      digital output or slow. When functioning as SLOW pin pulling the pin high
+      overrides the programmed sample rate and results in a sample rate of 8 sps
+      (Slow mode).
+    enum: [alert0, gpio0_input, gpio0_output, slow]
+    default: gpio0_input
+
+  microchip,gpio1-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Defines the function of the pin. This is a multifunction gpio digital I/O
+      pin which can be configured as alert1 interrupt, GPIO digital input, GPIO
+      digital output or slow. When functioning as SLOW pin pulling the pin high
+      overrides the programmed sample rate and results in a sample rate of 8 sps
+      (Slow mode).
+    enum: [alert1, gpio1_input, gpio1_output, slow]
+    default: gpio1_input
+
+  powerdown-gpios:
+    description:
+      Active low puts the device in power-down state. When the PWRDN pin is
+      pulled high, measurement and accumulation will resume using the default
+      register settings.
+    maxItems: 1
+
+  shunt-resistor-micro-ohms:
+    description:
+      Value in micro Ohms of the shunt resistor connected between
+      the VSENSEP and VSENSEN inputs, across which the current is measured.
+      Value is needed to compute the scaling of the measured current.
+
+  label:
+    description: Unique name to identify which device this is.
+
+  microchip,vbus-input-range-microvolt:
+    description: |
+      Specifies the voltage range in microvolts chosen for the voltage full
+      scale range (FSR). The range should be set as <minimum, maximum> by
+      hardware design and should not be changed during runtime.
+
+      The VBUS could be configured into the following full scale range:
+        - for PAC1711 or PAC1811:
+            - VBUS has unipolar 0V to 42V FSR (default)
+            - VBUS has bipolar -42V to 42V FSR
+            - VBUS has bipolar -21V to 21V FSR
+        - for PAC1721 or PAC1821:
+            - VBUS has unipolar 0V to 9V FSR (default)
+            - VBUS has bipolar -9V to 9V FSR
+            - VBUS has bipolar -4.5V to 4.5V FSR
+
+  microchip,vsense-input-range-microvolt:
+    description: |
+      Specifies the voltage range in microvolts chosen for the current full
+      scale range (FSR). The current is calculated by dividing the vsense
+      voltage by the value of the shunt resistor. The range should be set as
+      <minimum, maximum> by hardware design and it should not be changed during
+      runtime.
+
+      The VSENSE could be configured into the following full scale range:
+        - VSENSE has unipolar 0 mV to 100 mV FSR (default)
+        - VSENSE has bipolar -100 mV to 100 mV FSR
+        - VSENSE has bipolar -50 mV to 50 mV FSR
+    oneOf:
+      - items:
+          - const: 0
+          - const: 100000
+      - items:
+          - const: -100000
+          - const: 100000
+      - items:
+          - const: -50000
+          - const: 50000
+
+  microchip,accumulation-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      The Hardware Accumulator may be used to accumulate VPOWER or VSENSE values
+      for any channel. By setting the accumulator for a channel to accumulate
+      the VPOWER values gives a measure of accumulated power over a time period,
+      which is equivalent to energy. Setting the accumulator for a channel to
+      accumulate VSENSE values gives a measure of accumulated current, which is
+      equivalent to charge.
+
+      The Hardware Accumulator could be configured as:
+       "vpower" - Accumulator accumulates VPOWER (energy)
+       "vsense" - Accumulator accumulates VSENSE (Coulomb Counter)
+    enum: [vpower, vsense]
+    default: vpower
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - shunt-resistor-micro-ohms
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          pattern: "^microchip,pac1[78]11$"
+    then:
+      properties:
+        microchip,vbus-input-range-microvolt:
+          oneOf:
+            - items:
+                - const: 0
+                - const: 42000000
+            - items:
+                - const: -42000000
+                - const: 42000000
+            - items:
+                - const: -21000000
+                - const: 21000000
+          default: [0, 42000000]
+  - if:
+      properties:
+        compatible:
+          pattern: "^microchip,pac1[78]21$"
+    then:
+      properties:
+        microchip,vbus-input-range-microvolt:
+          oneOf:
+            - items:
+                - const: 0
+                - const: 9000000
+            - items:
+                - const: -9000000
+                - const: 9000000
+            - items:
+                - const: -4500000
+                - const: 4500000
+          default: [0, 9000000]
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        power-monitor@40 {
+            compatible = "microchip,pac1711";
+            reg = <0x40>;
+
+            shunt-resistor-micro-ohms = <10000>;
+            label = "VDD3V3";
+            vdd-supply = <&vdd>;
+            microchip,vbus-input-range-microvolt = <(-21000000) 21000000>;
+            microchip,vsense-input-range-microvolt = <(-50000) 50000>;
+            microchip,accumulation-mode = "vpower";
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa163f9fe8fe3f04bf66426f9a894409..399da37f79fd9768f29cc60aa5384a1ba9fe8afc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16337,6 +16337,12 @@ F:	Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
 F:	drivers/nvmem/microchip-otpc.c
 F:	include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
 
+MICROCHIP PAC1711 POWER/CURRENT MONITOR DRIVER
+M:	Ariana Lazar <ariana.lazar@microchip.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
+
 MICROCHIP PAC1921 POWER/CURRENT MONITOR DRIVER
 M:	Matteo Martelli <matteomartelli3@gmail.com>
 L:	linux-iio@vger.kernel.org

-- 
2.43.0

