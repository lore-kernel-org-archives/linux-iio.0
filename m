Return-Path: <SRS0=CopR=BT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1BDC433DF
	for <linux-iio@archiver.kernel.org>; Sun,  9 Aug 2020 11:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DECB2065D
	for <linux-iio@archiver.kernel.org>; Sun,  9 Aug 2020 11:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596972012;
	bh=CAzT3HPKe2SQrpGNfbhdhwDB86fP9HyD4MBfA8HPvVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pzbs9Ywjkw8bJiLj4mjP0rk8xohUdKcD1Se4iIfhg40Y6ML1lt4mPGTSdbLFIzcxg
	 TDyOGjSBqZsbMREKayriL2ba/uX2LvA7plmuPDDyA962BSTRBlfz6QNkt/UxnsdSpE
	 ee7qdFhlZAXtbp+rzF+6lAXMduTaEWyFqVnVM3KQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgHILUL (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 9 Aug 2020 07:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgHILUL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 07:20:11 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5692620772;
        Sun,  9 Aug 2020 11:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596972010;
        bh=CAzT3HPKe2SQrpGNfbhdhwDB86fP9HyD4MBfA8HPvVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ckN5hj2NGVUyDXDC6Mm7Q31owdOSqoRbYN2wDANNGS0BNrdy0LTvf6uBE5MuE1v45
         pjfeUtyerLw1OLM0g+Sr4Gs5xmMhQ9S9kkh0kkxp3hJeaERFt7mscIPEV5tdgd0DKC
         JD+yr8S6+V79vwJAqTU/WKLwxgf3VBlJPHvOFPeU=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 08/13] dt-bindings: iio: adc: ti,adc12138 yaml conversion.
Date:   Sun,  9 Aug 2020 12:17:48 +0100
Message-Id: <20200809111753.156236-9-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809111753.156236-1-jic23@kernel.org>
References: <20200809111753.156236-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple binding conversion.  Only addition was #io-channel-cells to
allow for potential consumers of the channels on this device.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
---
 .../bindings/iio/adc/ti,adc12138.yaml         | 85 +++++++++++++++++++
 .../bindings/iio/adc/ti-adc12138.txt          | 37 --------
 2 files changed, 85 insertions(+), 37 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc12138.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc12138.yaml
new file mode 100644
index 000000000000..3e8c43aa8ef3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc12138.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,adc12138.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADC12138 and similar self-calibrating ADCs
+
+maintainers:
+  - Akinobu Mita <akinobu.mita@gmail.com>
+
+description: |
+  13 bit ADCs with 1, 2 or 8 inputs and self calibrating circuitry to
+  correct for linearity, zero and full scale errors.
+
+properties:
+  compatible:
+    enum:
+      - ti,adc12130
+      - ti,adc12132
+      - ti,adc12138
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: End of Conversion (EOC) interrupt
+
+  clocks:
+    maxItems: 1
+    description: Conversion clock input.
+
+  spi-max-frequency: true
+
+  vref-p-supply:
+    description: The regulator supply for positive analog voltage reference
+
+  vref-n-suppy:
+    description: |
+      The regulator supply for negative analog voltage reference
+      (Note that this must not go below GND or exceed vref-p)
+      If not specified, this is assumed to be analog ground.
+
+  ti,acquisition-time:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 6, 10, 18, 34]
+    description: |
+      The number of conversion clock periods for the S/H's acquisition time.
+      For high source impedances, this value can be increased to 18 or 34.
+      For less ADC accuracy and/or slower CCLK frequencies this value may be
+      decreased to 6.  See section 6.0 INPUT SOURCE RESISTANCE in the
+      datasheet for details.
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - vref-p-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,adc12138";
+            reg = <0>;
+            interrupts = <28 IRQ_TYPE_EDGE_RISING>;
+            interrupt-parent = <&gpio1>;
+            clocks = <&cclk>;
+            vref-p-supply = <&ldo4_reg>;
+            spi-max-frequency = <5000000>;
+            ti,acquisition-time = <6>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt
deleted file mode 100644
index 049a1d36f013..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-* Texas Instruments' ADC12130/ADC12132/ADC12138
-
-Required properties:
- - compatible: Should be one of
-	* "ti,adc12130"
-	* "ti,adc12132"
-	* "ti,adc12138"
- - reg: SPI chip select number for the device
- - interrupts: Should contain interrupt for EOC (end of conversion)
- - clocks: phandle to conversion clock input
- - spi-max-frequency: Definision as per
-	Documentation/devicetree/bindings/spi/spi-bus.txt
- - vref-p-supply: The regulator supply for positive analog voltage reference
-
-Optional properties:
- - vref-n-supply: The regulator supply for negative analog voltage reference
-	(Note that this must not go below GND or exceed vref-p)
-	If not specified, this is assumed to be analog ground.
- - ti,acquisition-time: The number of conversion clock periods for the S/H's
-	acquisition time.  Should be one of 6, 10, 18, 34.  If not specified,
-	default value of 10 is used.
-	For high source impedances, this value can be increased to 18 or 34.
-	For less ADC accuracy and/or slower CCLK frequencies this value may be
-	decreased to 6.  See section 6.0 INPUT SOURCE RESISTANCE in the
-	datasheet for details.
-
-Example:
-adc@0 {
-	compatible = "ti,adc12138";
-	reg = <0>;
-	interrupts = <28 IRQ_TYPE_EDGE_RISING>;
-	interrupt-parent = <&gpio1>;
-	clocks = <&cclk>;
-	vref-p-supply = <&ldo4_reg>;
-	spi-max-frequency = <5000000>;
-	ti,acquisition-time = <6>;
-};
-- 
2.28.0

