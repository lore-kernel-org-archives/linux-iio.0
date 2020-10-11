Return-Path: <SRS0=8e7N=DS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B047C43457
	for <linux-iio@archiver.kernel.org>; Sun, 11 Oct 2020 17:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D7E22244
	for <linux-iio@archiver.kernel.org>; Sun, 11 Oct 2020 17:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602436217;
	bh=FJN8Ixp4glxnK9UQpFSFwgaQX3HXL3GQWkpQ5vWA7DQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1rBJsEZuGHx6UpUkL7mDKAsXwvM9yodZL5rRnR1/+stCEXHK3Zk7PLub+zpglVZCS
	 QKiTQ2O1F5qWDLGXir8JiXQlxjUIrxg4E1eoqTS3UjigVsKBwCzJSnJOiFuwPIk274
	 uazxRyr3DZ2GeLGEmyEntjeH32Da36fh+JuZJtoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbgJKRKQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 11 Oct 2020 13:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387501AbgJKRKQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:16 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E76E52224A;
        Sun, 11 Oct 2020 17:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436216;
        bh=FJN8Ixp4glxnK9UQpFSFwgaQX3HXL3GQWkpQ5vWA7DQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jFbjhgw1OSSM7suz4OBybfLLpFfxO9Q7pR6BcAMMDSigjkxPr8juY7xhD7Iav7gnm
         1zwktD1dzTt06rw4IUQXRZwj59sPkFxvv0aPvyAqEHfLvKCctBICZrMuxv0bywJdRO
         hlCWfMsnGtsHJfwIqXsNlyfYbdFe8nirSM9foivc=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 12/29] dt-bindings:iio:dac:ti,dac5571 yaml conversion.
Date:   Sun, 11 Oct 2020 18:07:32 +0100
Message-Id: <20201011170749.243680-13-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
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

