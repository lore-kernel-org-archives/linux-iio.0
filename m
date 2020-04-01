Return-Path: <SRS0=slhR=5R=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2879C2BA12
	for <linux-iio@archiver.kernel.org>; Wed,  1 Apr 2020 18:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D48207FF
	for <linux-iio@archiver.kernel.org>; Wed,  1 Apr 2020 18:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="whLXAyiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbgDASqt (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:46:49 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:49903 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgDASqt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2020 14:46:49 -0400
From:   Alexandru Lazar <alazar@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1585766807;
        bh=7fnFSy+sEmwQpklZYylFDBkgyCMloNhpV7NmOpPWkAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=whLXAyiHNDHwPSzi9O+7bAJmkyCevmqk5rFFGKmrxx9HuNlTZFGroeLW1cux6uf2o
         Jz0IkiFZyL/sRxTXLkXMp42kaw+X7iZR2lC7znzL/H8cdtDJHOBB2pzhXvjdhFiJdZ
         8nkn1PlQmxqDFPagVoNsQhKRzXZeAjsku3vCLLJdQhvQNi//VoktKp5eyVxeHPLecN
         e0rUq31+8xLbGui75E0BFDdk06mbbUesuZFIevPXfHXDWhAYAzEm7tN8HVfkk4l4NF
         ZI1m4Yka7Zv6Koc+WQz5vJEPHUYP6B5+YECOZtr3c/pXrfZAro8Iti12i2wo550qcQ
         RUXLMoDJ/tAGg==
To:     linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, Alexandru Lazar <alazar@startmail.com>
Subject: [PATCH v6 1/2] dt-bindings: iio: adc: Add MAX1241 bindings
Date:   Wed,  1 Apr 2020 21:51:37 +0300
Message-Id: <20200401185138.10673-2-alazar@startmail.com>
In-Reply-To: <20200401185138.10673-1-alazar@startmail.com>
References: <20200401185138.10673-1-alazar@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device-tree bindings documentation for the MAX1241 device driver.

Signed-off-by: Alexandru Lazar <alazar@startmail.com>
---
 .../bindings/iio/adc/maxim,max1241.yaml       | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
new file mode 100644
index 000000000000..7da9e4153ac1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020 Alexandru Lazar
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/maxim,max1241.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX1241 12-bit, single-channel analog to digital converter
+
+maintainers:
+  - Alexandru Lazar <alazar@startmail.com>
+
+description: |
+  Bindings for the max1241 12-bit, single-channel ADC device. Datasheet
+  can be found at:
+    https://datasheets.maximintegrated.com/en/ds/MAX1240-MAX1241.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max1241
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description:
+      Device tree identifier of the regulator that powers the ADC.
+
+  vref-supply:
+    description:
+      Device tree identifier of the regulator that provides the external
+      reference voltage.
+    maxItems: 1
+
+  shutdown-gpios:
+    description:
+      GPIO spec for the GPIO pin connected to the ADC's /SHDN pin. If
+      specified, the /SHDN pin will be asserted between conversions,
+      thus enabling power-down mode.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vref-supply
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+        adc@0 {
+            compatible = "maxim,max1241";
+            reg = <0>;
+            vdd-supply = <&adc_vdd>;
+            vref-supply = <&adc_vref>;
+            spi-max-frequency = <1000000>;
+            shutdown-gpios = <&gpio 26 1>;
+        };
+    };
-- 
2.20.1

