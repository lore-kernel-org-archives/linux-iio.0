Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECBAC5DF9D
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F5DF20825
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604151853;
	bh=td9VXYGlk/QYLXW1nSdUA+5ZgE6IBV9wMbAFXH8Lpx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tfp7AUgjPL3W3DIS9ri24xx2EN0rOUQZc2YekqYCZhKEOM6ttMSVWAuQkD9SSz4Oa
	 2rBkdwrUdfJ5oeGXCeIUDk0/0lWYdNxR1Ji1fY3fgm7lzhEpSaQHnbB0Cb10RyyzvW
	 V0YZ0KWoRQkYKoKPDHgNBXNj5CvrL2E13WgMMxRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbgJaNoM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 09:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgJaNoM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:44:12 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8690320756;
        Sat, 31 Oct 2020 13:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151851;
        bh=td9VXYGlk/QYLXW1nSdUA+5ZgE6IBV9wMbAFXH8Lpx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mvM4dcz3IBUOuH6kRMW+APJWVGPswj6mSvtHY4rUbuTIY0JJodLfFxdDKt3YU7Qdr
         d5731NWMjZC6E4Xhdi36a158vNM/zFPKlBp4fXQVPihZDEwemeNhzAdjpMk7taxc+O
         reuRsTIWbnXN1ISWijuaJywqf+Fs2kxUaAVMIqM0=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, Tomas Novotny <tomas@novotny.cz>
Subject: [PATCH v2 20/29] dt-bindings:iio:dac:microchip,mcp4725 yaml conversion
Date:   Sat, 31 Oct 2020 13:41:01 +0000
Message-Id: <20201031134110.724233-21-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm not sure vdd-supply absolutely has to be provided if vref-supply
is, but as the previous binding docs stated it was required it seems
reasonable to leave it as such.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Tomas Novotny <tomas@novotny.cz>
---
 .../devicetree/bindings/iio/dac/mcp4725.txt   | 35 ---------
 .../bindings/iio/dac/microchip,mcp4725.yaml   | 71 +++++++++++++++++++
 2 files changed, 71 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/mcp4725.txt b/Documentation/devicetree/bindings/iio/dac/mcp4725.txt
deleted file mode 100644
index 1bc6c093fbfe..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/mcp4725.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-Microchip mcp4725 and mcp4726 DAC device driver
-
-Required properties:
-	- compatible: Must be "microchip,mcp4725" or "microchip,mcp4726"
-	- reg: Should contain the DAC I2C address
-	- vdd-supply: Phandle to the Vdd power supply. This supply is used as a
-	  voltage reference on mcp4725. It is used as a voltage reference on
-	  mcp4726 if there is no vref-supply specified.
-
-Optional properties (valid only for mcp4726):
-	- vref-supply: Optional phandle to the Vref power supply. Vref pin is
-	  used as a voltage reference when this supply is specified.
-	- microchip,vref-buffered: Boolean to enable buffering of the external
-	  Vref pin. This boolean is not valid without the vref-supply. Quoting
-	  the datasheet: This is offered in cases where the reference voltage
-	  does not have the current capability not to drop its voltage when
-	  connected to the internal resistor ladder circuit.
-
-Examples:
-
-	/* simple mcp4725 */
-	mcp4725@60 {
-		compatible = "microchip,mcp4725";
-		reg = <0x60>;
-		vdd-supply = <&vdac_vdd>;
-	};
-
-	/* mcp4726 with the buffered external reference voltage */
-	mcp4726@60 {
-		compatible = "microchip,mcp4726";
-		reg = <0x60>;
-		vdd-supply = <&vdac_vdd>;
-		vref-supply = <&vdac_vref>;
-		microchip,vref-buffered;
-	};
diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml
new file mode 100644
index 000000000000..271998610ceb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4725.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip mcp4725 and mcp4726 DAC
+
+maintainers:
+  - Tomas Novotny <tomas@novotny.cz>
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp4725
+      - microchip,mcp4726
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: |
+      Provides both power and acts as the reference supply on the mcp4725.
+      For the mcp4726 it will be used as the reference voltage if vref-supply
+      is not provided.
+
+  vref-supply:
+    description:
+      Vref pin is used as a voltage reference when this supply is specified.
+
+  microchip,vref-buffered:
+    type: boolean
+    description: |
+      Enable buffering of the external Vref pin. This boolean is not valid
+      without the vref-supply. Quoting the datasheet: This is offered in
+      cases where the reference voltage does not have the current
+      capability not to drop its voltage when connected to the internal
+      resistor ladder circuit.
+
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: microchip,mcp4726
+    then:
+      properties:
+        vref-supply: false
+        microchip,vref-buffered: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mcp4725@60 {
+            compatible = "microchip,mcp4725";
+            reg = <0x60>;
+            vdd-supply = <&vdac_vdd>;
+        };
+    };
+...
-- 
2.28.0

