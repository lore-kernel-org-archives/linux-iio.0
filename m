Return-Path: <SRS0=7Lrc=3V=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA6AC35246
	for <linux-iio@archiver.kernel.org>; Sat,  1 Feb 2020 18:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203F92067C
	for <linux-iio@archiver.kernel.org>; Sat,  1 Feb 2020 18:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgBASBA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:01:00 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:53940 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgBASBA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Feb 2020 13:01:00 -0500
Received: from localhost.localdomain (silversquare.silversquare.eu [185.174.184.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 3A9F5251DC;
        Sat,  1 Feb 2020 19:00:57 +0100 (CET)
From:   David Heidelberg <david@ixit.cz>
To:     linux-iio@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v3 1/7] dt-bindings: iio: light: add support for Dyna-Image AL3320A
Date:   Sat,  1 Feb 2020 19:00:18 +0100
Message-Id: <20200201180024.328700-2-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200201180024.328700-1-david@ixit.cz>
References: <20200201180024.328700-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit add dt-bindings support to al3320a driver and vendor-prefix
dynaimage.
Partly based on unmerged commit:
"iio: Add Dyna-Image AP3223 ambient light and proximity driver"


Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/iio/light/al3320a.yaml           | 45 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/al3320a.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/al3320a.yaml b/Documentation/devicetree/bindings/iio/light/al3320a.yaml
new file mode 100644
index 000000000000..08e7ee4bdf55
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/al3320a.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/al3320a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dyna-Image AL3320A sensor
+
+maintainers:
+  - David Heidelberg <david@ixit.cz>
+
+properties:
+  compatible:
+    const: dynaimage,al3320a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vdd-supply
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        al3320a@1c {
+            compatible = "dynaimage,al3320a";
+            reg = <0x1c>;
+            vdd-supply = <&vdd_reg>;
+            interrupts = <0 99 4>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9cd52d9e1f7f..8d2ebf3d0aa1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -267,6 +267,8 @@ patternProperties:
     description: Dragino Technology Co., Limited
   "^dserve,.*":
     description: dServe Technology B.V.
+  "^dynaimage,.*":
+    description: Dyna-Image
   "^ea,.*":
     description: Embedded Artists AB
   "^ebs-systart,.*":
-- 
2.25.0

