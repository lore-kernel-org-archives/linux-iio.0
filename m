Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6951C388F7
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A52320731
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604151841;
	bh=lPG/Bw+GgrpAAqesEvCxvokLf1ENkNXz+lkIoA7KaFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VriAUXIBT+jl4QN43rqmVw9gVhe7xR6Ks8J7Ch6OhueXb2GoIaqHv4VRzA9FmgZNI
	 nOV0O/1DjM7PPdFU5ZG9e/VD9Mv8U3zBGAzT5vR9kEMngqnMD47mp/2aXgXHe1z2o9
	 wdjnIg8hhyjLbWDhp7lNj4YFHjMMT5YpD4M1mbbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgJaNoA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 09:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbgJaNoA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:44:00 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18B5620825;
        Sat, 31 Oct 2020 13:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151839;
        bh=lPG/Bw+GgrpAAqesEvCxvokLf1ENkNXz+lkIoA7KaFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bqnuo6M36bUTYDW02BUOpwduzHbQ9kZQCm+ToAh5F7LQpEq/CRUTzZsYAGW2Gjo26
         XRqWri2CCD8EEa5pr26BJcmard69UmDkl1k8fbb7d6ttDJ/oeJPyij6VrnZugdN6lM
         xIH8doUZ8SwnkqVfB2a6kMZ2fJADKkBWaYzQ34JY=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v2 12/29] dt-bindings:iio:dac:ti,dac5571 yaml conversion.
Date:   Sat, 31 Oct 2020 13:40:53 +0000
Message-Id: <20201031134110.724233-13-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A few tweaks in this conversion.
* The example didn't have the I2C address of 4C in the node name so
  fixed that.
* The reference voltage in the txt file is an optional binding, but
  the driver is making use of it to provide the scaling of the output
  channels.  As such I have made it required going forwards.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Sean Nyekjaer <sean@geanix.com>
Cc: Sean Nyekjaer <sean@geanix.com>
---
 .../bindings/iio/dac/ti,dac5571.txt           | 24 ---------
 .../bindings/iio/dac/ti,dac5571.yaml          | 52 +++++++++++++++++++
 2 files changed, 52 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt
deleted file mode 100644
index 03af6b9a4d07..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-* Texas Instruments DAC5571 Family
-
-Required properties:
- - compatible: Should contain
-    "ti,dac5571"
-    "ti,dac6571"
-    "ti,dac7571"
-    "ti,dac5574"
-    "ti,dac6574"
-    "ti,dac7574"
-    "ti,dac5573"
-    "ti,dac6573"
-    "ti,dac7573"
- - reg: Should contain the DAC I2C address
-
-Optional properties:
- - vref-supply: The regulator supply for DAC reference voltage
-
-Example:
-dac@0 {
-	compatible = "ti,dac5571";
-	reg = <0x4C>;
-	vref-supply = <&vdd_supply>;
-};
diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
new file mode 100644
index 000000000000..714191724f7c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/ti,dac5571.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments DAC5571 Family
+
+maintainers:
+  - Sean Nyekjaer <sean@geanix.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,dac5571
+      - ti,dac6571
+      - ti,dac7571
+      - ti,dac5574
+      - ti,dac6574
+      - ti,dac7574
+      - ti,dac5573
+      - ti,dac6573
+      - ti,dac7573
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      Reference voltage must be supplied to establish the scaling of the
+      output voltage.
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@4c {
+            compatible = "ti,dac5571";
+            reg = <0x4C>;
+            vref-supply = <&vdd_supply>;
+        };
+    };
+...
-- 
2.28.0

