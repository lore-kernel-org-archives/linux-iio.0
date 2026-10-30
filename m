Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793330121;
	b=22S5uBUApnJQnnGr3xFaof1a6w9SBWuOelqDujBiu1Qu364kIOe3gCxL/KMdwRkr12/j
	 oOqZ8zZzjG2W0zHf3iROEXATU5pkNagAF64HHfZUmuNTC/WAt3/cFE+9uO3hZThKVVQom
	 u/nkkZs6i/qBaCKkRPCBfmyInQHwn4gaOYQ4pARLNQOSkrKNC9602GQzu7tfxX9ggidvJ
	 ioRS/UHYl/XGlTQNn/SCwH+n36mIIfW60oB/NKcg/AiDGvPgJvx/L4wa9Efay9rpZsV5J
	 N0LVI4oU0Bh/GTd2lcXVJo2EZB89RFlNoAODRh1ES/GHwiDDB0XBtI4tU3nZaguf7Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793330121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=641clQSedyAr6js8nLvcdTQj43W5pE3bK82vlQ2g1uE=;
	b=miyH4cnAmNNCIHgSjywKN1q15GxUIjvG+mszgDCY8+d1fiBElbP3J9jVrNxxP3tKwSWQ
	 lnguFmZGWuAS6WBGxleZwYarGhC8MRIsdnjxFGKuVI0I6Gd9laEqraZoG3vcJU/mbYecK
	 l4r9Ig/9thQKFWBVnuFKZoRjwDU+itaT5fQrh6yHBmwAR+c/VjiG2FmbHE2/3y0rISeZ9
	 vhIIkHQSuHSLW+lK4AIXqRINtZwhzHKHUXaZghj20/4Rwqz/wmHsTtLOQLXoi977Pmg+W
	 RqUBhgT1CJlTVe4ZdDYW0Cdi5dhxPw5klptMTWLmspIRTMun1B5IAXorQH5YJG5wj1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xL15a6kr;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9165C606A31F
	for <linux-iio@vger.kernel.org>; Fri, 30 Oct 2026 03:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9165C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xL15a6kr
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso67564a12.2
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 20:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793330121; x=1793934921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=641clQSedyAr6js8nLvcdTQj43W5pE3bK82vlQ2g1uE=;
        b=xL15a6krLbvCIT3U780ddPNT/ABi/CHbzO4KAdxU+oWODPgfF+RSafxBFSFecVv03C
         IiEwsF6sBwt1HKB5MvUrf+774NwZr9SDQrV2aJl30mEY9crjEOFseF5mVH0BDrTSUkok
         cpsnvVpbJFIPq0lBm41MfSkxi3CvTzJob+Amul7M1Awlpfrji+FMn9hadX/QC+fk5OEe
         172Z24qyCQ4qZ5J63VH5he9Iby18fIu65z6f8JY1L2McBX2H+q114vF8o9hUt5yWCcdr
         oFp7OPGCH9Am/zCYjWREqephIMlNGLxSkAHMcW0T0XHVlaKQKedQH6NayNEjGrnmr9it
         MJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793330121; x=1793934921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=641clQSedyAr6js8nLvcdTQj43W5pE3bK82vlQ2g1uE=;
        b=e4YPuHAex7MzuASN+68yhwfcEDoz0nzFQcQ3Qkh6MpKpGhk4wMeXIw8OlgBeLQ51yF
         +lZx+4yr0ai6RmyKUES+tpACn/hsfvRfLaP9KqTm3Ro+FKlTBGRG3+sbJi+Z5h20wRAt
         hrkCCa1hBftMSrw4o20oMaYJGNtGO2sO/n/82gL541EzddR5XVJ2sClWwIlSgffEheuj
         Jyam4dA7bauEcfsUQ2cWlUmnrmLdv9zJ6TuP43+QHHMFST6Cd/H5R86BfCxFddx6guK3
         knMJMAgpu2A5e6W/qpm5p8MQcIKhNKTRnCllsRBnPSK6hM8NvSAfeapoV2+DpOZKUn68
         L5Wg==
X-Forwarded-Encrypted: i=1; AKwUvBw8ZyphImLW7ePTeGJP0ybfYQBsYAaQrA4YELV0C0YW7F33hXeLZ43OQnBSRRlbVz7crnrFl51Qov4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjr6Qnp8DOBxsZ2LkyUcRV2R1xjbWGLvkfPgeEQpuC793OILsc
	480F0NAOREUDMBXAe0tcAo+wpmPg+ykj1l6LLCDm37Vvj5tm1/R3bsyQ
X-Gm-Gg: AYBFou0RGL8y8cXg7ao9IekWmYCnH7Pnr9+Uwpz64u6onwYdlHQD18MEig+HUAk6flz
	73R97NyV2IbLXeLgIOIEvAq8XzIDngM0HyotOd6ILrSosDx8qIejWpGUJr8P40QVLZpJf/0EUiw
	Cp61Xh4iEudAtuFeOMxv0AM7H5h1HkXDChUskU7kjvczYeVIdUn4pSZNKU8zcWjraO9SSPc2zcZ
	DrCh4tO7VMN7I0UylShz9GS7zrPZmgHoWYjQ05lBj6pI6DcwOz0JPLvafm4DYcrEyVfFxhZHeE5
	0k8BtwCddnLqs+H/fMJZ8eiJzccw4NIRDekHavTOtN1RyZhIKOuPZ15whwRAn/Z7z6kkYZHKGFR
	r2wMa2m/OO7Bit8YgsBLWBcoIkp2BGM/I1lgELbiOV7C4m2pu4lRlyCZazXuu3ebtqOyFuawJPV
	yqst0udLv0Fi8A44TUJ7EMmhtbjmKt4Xjwr/yJF/2kHleAjRg7PwNcQXWfoXYYoW9MxXhB2kVAw
	Sv4KOkCSQGfBYIbw996Uw8fZGUz9gfNmCaA1bFgWgOyz4LiC7tk0n9PVDh7rlZ0GHUxG0w8axCD
	NYLLGCS8opzGyb4FIojBoyluBEfLnsFTQJGHbM/p6hz6PGgV1W8muyvL7PWyCD/Fs2G1IluLwHn
	zfk05LCJr2M1fAa8=
X-Received: by 2002:a17:90b:1a8f:b0:3ad:eb38:9778 with SMTP id 98e67ed59e1d1-3ae897994dcmr757560a91.48.1793330120801;
        Thu, 29 Oct 2026 20:15:20 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e2a703esm6590630a91.0.2026.10.29.20.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 20:15:20 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
Date: Fri, 30 Oct 2026 11:15:00 +0800
Message-Id: <20261030031501.130290-2-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261030031501.130290-1-cwweng.linux@gmail.com>
References: <20261030031501.130290-1-cwweng.linux@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

Add a devicetree binding for the Enhanced Analog-to-Digital Converter
(EADC) found on Nuvoton MA35D1 SoCs.

The controller provides eight external analog inputs which can be used
as single-ended channels or as four fixed differential pairs: 0-4,
1-5, 2-6 and 3-7.

Describe the four hardware interrupt outputs, ADINT0 through ADINT3.
ADINT0 through ADINT2 are associated with the corresponding conversion
interrupt flags, while ADINT3 is shared by the ADIF3 conversion
interrupt and the ADCMPF0 through ADCMPF3 result-compare interrupt
sources.

Also describe the functional clock, optional reset, optional external
reference supply and optional DMA request.

Expose the controller as an IIO channel provider through the
DT #io-channel-cells property. The cell identifies the logical EADC
channel selected by the reg value of the corresponding channel child
node.

Restrict the channel binding to features supported by the MA35D1 EADC
hardware and use the common single-channel representation for
single-ended inputs.

Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml | 175 ++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
new file mode 100644
index 000000000000..97144a8eeb5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
@@ -0,0 +1,175 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nuvoton,ma35d1-eadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 Enhanced Analog-to-Digital Converter
+
+maintainers:
+  - Chi-Wen Weng <cwweng@nuvoton.com>
+
+description: |
+  The Nuvoton MA35D1 Enhanced Analog-to-Digital Converter (EADC) is a
+  12-bit successive approximation converter with eight external analog
+  inputs and one internally connected VBAT input.
+
+  The external inputs can be used as eight single-ended channels or as
+  four fixed differential pairs: 0-4, 1-5, 2-6 and 3-7. The internally
+  connected VBAT input is not described by a channel child node.
+
+  The controller provides four interrupt outputs, ADINT0 through ADINT3.
+  ADINT0, ADINT1 and ADINT2 are generated by the corresponding ADIF0,
+  ADIF1 and ADIF2 conversion interrupt flags. ADINT3 is shared by the
+  ADIF3 conversion interrupt flag and the ADCMPF0 through ADCMPF3 result
+  compare flags.
+
+properties:
+  compatible:
+    const: nuvoton,ma35d1-eadc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: ADINT0 conversion interrupt output generated by ADIF0
+      - description: ADINT1 conversion interrupt output generated by ADIF1
+      - description: ADINT2 conversion interrupt output generated by ADIF2
+      - description: >
+          ADINT3 shared interrupt output generated by ADIF3 or by the
+          ADCMPF0 through ADCMPF3 result compare flags
+
+  interrupt-names:
+    items:
+      - const: adint0
+      - const: adint1
+      - const: adint2
+      - const: adint3
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      Optional external reference voltage connected to the VREF pin. If this
+      supply is absent, the controller uses its internal 1.6 V reference.
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx
+
+  '#io-channel-cells':
+    const: 1
+    description:
+      The cell selects the logical EADC channel identified by the reg value
+      of the corresponding channel child node.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  '^channel@[0-7]$':
+    type: object
+    $ref: /schemas/iio/adc/adc.yaml#
+    unevaluatedProperties: false
+    description: |
+      External EADC channel description.
+
+      For a single-ended channel, single-channel specifies the external
+      analog input number (0 through 7), while reg provides the logical IIO
+      channel index.
+
+      For a differential channel, omit single-channel. The reg value selects
+      one of the four fixed hardware differential pairs: reg 0 selects 0-4,
+      reg 1 selects 1-5, reg 2 selects 2-6 and reg 3 selects 3-7.
+
+    properties:
+      reg:
+        maximum: 7
+
+      single-channel:
+        maximum: 7
+
+      # Differential pairs are fixed in hardware and are selected by reg.
+      diff-channels: false
+
+      bipolar: false
+
+      common-mode-channel: false
+
+      settling-time-us: false
+
+      oversampling-ratio: false
+
+    allOf:
+      - if:
+          not:
+            required:
+              - single-channel
+        then:
+          properties:
+            reg:
+              maximum: 3
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - '#io-channel-cells'
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        adc@40430000 {
+            compatible = "nuvoton,ma35d1-eadc";
+            reg = <0x0 0x40430000 0x0 0x10000>;
+            interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "adint0", "adint1", "adint2", "adint3";
+            clocks = <&clk EADC_GATE>;
+            resets = <&reset MA35D1_RESET_EADC0>;
+
+            #io-channel-cells = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                single-channel = <0>;
+            };
+
+            channel@1 {
+                reg = <1>;
+            };
+        };
+    };
+
+...
-- 
2.25.1

