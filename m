Return-Path: <SRS0=IsJM=34=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD44C35242
	for <linux-iio@archiver.kernel.org>; Sat,  8 Feb 2020 17:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50A720733
	for <linux-iio@archiver.kernel.org>; Sat,  8 Feb 2020 17:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581182723;
	bh=Hn8ogQ7PMeebgcoGZ7IqHhieWdq8yOPtFPaWFRdQLFU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XAsaY3ccf+e1Th0BXNFwMXt5ZvG601WY7RYiSFLtHI8qhgHe8givN2LTBYCyAH7/j
	 nPKV2DAzw2ECOlPqZRpwjEV2+gILvoiVN44QRUwTJDPEYmc3u+IgHA8e2xhcoP/nRV
	 VapW+jHE1AAh+iPSKABjyExtaKek4sxryZXS4qyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBHRZX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 8 Feb 2020 12:25:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbgBHRZX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Feb 2020 12:25:23 -0500
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBF2220658;
        Sat,  8 Feb 2020 17:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581182721;
        bh=Hn8ogQ7PMeebgcoGZ7IqHhieWdq8yOPtFPaWFRdQLFU=;
        h=From:To:Cc:Subject:Date:From;
        b=G1DKwQcRDNeUXuRLquSwrIStexDj/OBaiNb7Ho004leq02ISI8xXh9B9RT4z6wcnM
         M2tKSD9xdA4xhJAX+Y5YqekeICGdFoI+2oe/Xt4Kqa0mYJB5nd9ZnZqzdk2x3feE0x
         atXxN9Lrp3dNG0qmoQxqiT0QgVw4TOeLoQruQOck=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] dt-bindings: iio: adc: max1363 etc i2c ADC binding conversion
Date:   Sat,  8 Feb 2020 17:23:12 +0000
Message-Id: <20200208172312.467454-1-jic23@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Split the binding in two to reflect the threshold monitor capabilities
and hence interrupts vs the more straight forward parts that
don't have this facility.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../devicetree/bindings/iio/adc/max1363.txt   | 63 ---------------
 .../bindings/iio/adc/maxim,max1238.yaml       | 76 +++++++++++++++++++
 .../bindings/iio/adc/maxim,max1363.yaml       | 50 ++++++++++++
 3 files changed, 126 insertions(+), 63 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/max1363.txt b/Documentation/devicetree/bindings/iio/adc/max1363.txt
deleted file mode 100644
index 94a9011dd860..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/max1363.txt
+++ /dev/null
@@ -1,63 +0,0 @@
-* Maxim 1x3x/136x/116xx Analog to Digital Converter (ADC)
-
-The node for this driver must be a child node of a I2C controller, hence
-all mandatory properties for your controller must be specified. See directory:
-
-        Documentation/devicetree/bindings/i2c
-
-for more details.
-
-Required properties:
-  - compatible: Should be one of
-		"maxim,max1361"
-		"maxim,max1362"
-		"maxim,max1363"
-		"maxim,max1364"
-		"maxim,max1036"
-		"maxim,max1037"
-		"maxim,max1038"
-		"maxim,max1039"
-		"maxim,max1136"
-		"maxim,max1137"
-		"maxim,max1138"
-		"maxim,max1139"
-		"maxim,max1236"
-		"maxim,max1237"
-		"maxim,max1238"
-		"maxim,max1239"
-		"maxim,max11600"
-		"maxim,max11601"
-		"maxim,max11602"
-		"maxim,max11603"
-		"maxim,max11604"
-		"maxim,max11605"
-		"maxim,max11606"
-		"maxim,max11607"
-		"maxim,max11608"
-		"maxim,max11609"
-		"maxim,max11610"
-		"maxim,max11611"
-		"maxim,max11612"
-		"maxim,max11613"
-		"maxim,max11614"
-		"maxim,max11615"
-		"maxim,max11616"
-		"maxim,max11617"
-		"maxim,max11644"
-		"maxim,max11645"
-		"maxim,max11646"
-		"maxim,max11647"
-  - reg: Should contain the ADC I2C address
-
-Optional properties:
-  - vcc-supply: phandle to the regulator that provides power to the ADC.
-  - vref-supply: phandle to the regulator for ADC reference voltage.
-  - interrupts: IRQ line for the ADC. If not used the driver will use
-    polling.
-
-Example:
-adc: max11644@36 {
-	compatible = "maxim,max11644";
-	reg = <0x36>;
-	vref-supply = <&adc_vref>;
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
new file mode 100644
index 000000000000..a0ebb4680140
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/maxim,max1238.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX1238 and similar ADCs
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description: |
+   Family of simple ADCs with i2c inteface and internal references.
+
+properties:
+  compatible:
+    enum:
+      - maxim,max1036
+      - maxim,max1037
+      - maxim,max1038
+      - maxim,max1039
+      - maxim,max1136
+      - maxim,max1137
+      - maxim,max1138
+      - maxim,max1139
+      - maxim,max1236
+      - maxim,max1237
+      - maxim,max1238
+      - maxim,max1239
+      - maxim,max11600
+      - maxim,max11601
+      - maxim,max11602
+      - maxim,max11603
+      - maxim,max11604
+      - maxim,max11605
+      - maxim,max11606
+      - maxim,max11607
+      - maxim,max11608
+      - maxim,max11609
+      - maxim,max11610
+      - maxim,max11611
+      - maxim,max11612
+      - maxim,max11613
+      - maxim,max11614
+      - maxim,max11615
+      - maxim,max11616
+      - maxim,max11617
+      - maxim,max11644
+      - maxim,max11645
+      - maxim,max11646
+      - maxim,max11647
+
+  reg:
+    maxItems: 1
+
+  vcc-supply: true
+  vref-supply:
+    description: Optional external reference.  If not supplied, internal
+      reference will be used.
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@36 {
+            compatible = "maxim,max1238";
+            reg = <0x36>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1363.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1363.yaml
new file mode 100644
index 000000000000..01706b4ccb1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1363.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/maxim,max1363.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX1363 and similar ADCs
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description: |
+   Family of ADCs with i2c inteface, internal references and threshold
+   monitoring.
+
+properties:
+  compatible:
+    enum:
+      - maxim,max1361,
+      - maxim,max1362
+      - maxim,max1363
+      - maxim,max1364
+
+  reg:
+    maxItems: 1
+
+  vcc-supply: true
+  vref-supply:
+    description: Optional external reference.  If not supplied, internal
+      reference will be used.
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@36 {
+            compatible = "maxim,max1363";
+            reg = <0x36>;
+        };
+    };
+...
-- 
2.25.0

