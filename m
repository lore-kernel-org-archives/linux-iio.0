Return-Path: <SRS0=WeWk=YH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66770ECE58E
	for <linux-iio@archiver.kernel.org>; Mon, 14 Oct 2019 18:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3D0217F9
	for <linux-iio@archiver.kernel.org>; Mon, 14 Oct 2019 18:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbfJNSte (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:49:34 -0400
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139]:39564
        "EHLO rjones.pdc.gateworks.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732791AbfJNSte (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2019 14:49:34 -0400
Received: by rjones.pdc.gateworks.com (Postfix, from userid 1002)
        id CC2EC1A47EEB; Mon, 14 Oct 2019 11:49:31 -0700 (PDT)
From:   Robert Jones <rjones@gateworks.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Jones <rjones@gateworks.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: imu: add fxos8700 imu binding
Date:   Mon, 14 Oct 2019 11:49:20 -0700
Message-Id: <20191014184921.22524-2-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20191014184921.22524-1-rjones@gateworks.com>
References: <20191010175648.10830-1-rjones@gateworks.com>
 <20191014184921.22524-1-rjones@gateworks.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds documentation for the Freescale FXOS8700 Inertial Measurement Unit
device-tree bindings.

Signed-off-by: Robert Jones <rjones@gateworks.com>
---
 .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml  | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
new file mode 100644
index 0000000..63bcb73
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/nxp,fxos8700.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale FXOS8700 Inertial Measurement Unit
+
+maintainers:
+  - Robert Jones <rjones@gateworks.com>
+
+description: |
+  Accelerometer and magnetometer combo device with an i2c and SPI interface.
+  https://www.nxp.com/products/sensors/motion-sensors/6-axis/digital-motion-sensor-3d-accelerometer-2g-4g-8g-plus-3d-magnetometer:FXOS8700CQ
+
+properties:
+  compatible:
+    enum:
+      - nxp,fxos8700
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
+
+  drive-open-drain:
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fxos8700@1e {
+          compatible = "nxp,fxos8700";
+          reg = <0x1e>;
+
+          interrupt-parent = <&gpio2>;
+          interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+          interrupt-names = "INT1";
+        };
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fxos8700@0 {
+          compatible = "nxp,fxos8700";
+          reg = <0>;
+
+          spi-max-frequency = <1000000>;
+          interrupt-parent = <&gpio1>;
+          interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+          interrupt-names = "INT2";
+        };
+    };
-- 
2.9.2

