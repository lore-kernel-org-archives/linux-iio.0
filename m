Return-Path: <SRS0=PRbX=CO=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412D3C433E2
	for <linux-iio@archiver.kernel.org>; Sat,  5 Sep 2020 17:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C4732086A
	for <linux-iio@archiver.kernel.org>; Sat,  5 Sep 2020 17:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599327189;
	bh=E38bXaztWbprGXLGB3ZptLRYv4BC3A7eIgpDTMmcQ14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oj4m8Hd4VHKWCW3tWHZxJIvvTaK1Vg3+rBgBu1+j0VV5G305W581J5UTX2m9N5PY2
	 36HjREfwnZVMy2bBgCvkPK06bMOVt6UQA4Qx2xQuG6NOev8kXBofMD6g1AwRGcT6gp
	 GTgDRUuEUw8Tgda590QqJ7jW2VsfOAj179BErIoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgIERcn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 5 Sep 2020 13:32:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbgIERcl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:32:41 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2414208FE;
        Sat,  5 Sep 2020 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599327160;
        bh=E38bXaztWbprGXLGB3ZptLRYv4BC3A7eIgpDTMmcQ14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sgicZQzFKsBeyZiSxeRpzebkXK4FZo5JwMq5/hIgD8gYnYX8OPA/Z5/VTme3ZtHrv
         j+GGu1QEIWjshH6yIvgWU1ha+QHgOOhgk+L7mH3RFkfRDpnt416aZLtWlNhPwsqSZk
         U4YYb646wWoyMSn3tydO5HQnHwQ7B/rWMbZBFCUM=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Subject: [PATCH 10/20] dt-bindings:iio:adc:lpc3220-adc yaml conversion
Date:   Sat,  5 Sep 2020 18:29:54 +0100
Message-Id: <20200905173004.216081-11-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905173004.216081-1-jic23@kernel.org>
References: <20200905173004.216081-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Renamed to remove the wild cards.  These go wrong far too often so
in general preferred to use the name of a specific part.  As this
binding only provides one compatible, I went with that.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>
---
 .../bindings/iio/adc/lpc32xx-adc.txt          | 21 --------
 .../bindings/iio/adc/nxp,lpc3220-adc.yaml     | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt
deleted file mode 100644
index 3a1bc669bd51..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-* NXP LPC32xx SoC ADC controller
-
-Required properties:
-- compatible: must be "nxp,lpc3220-adc"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: The ADC interrupt
-
-Optional:
- - vref-supply: The regulator supply ADC reference voltage, optional
-   for legacy reason, but highly encouraging to us in new device tree
-
-Example:
-
-	adc@40048000 {
-		compatible = "nxp,lpc3220-adc";
-		reg = <0x40048000 0x1000>;
-		interrupt-parent = <&mic>;
-		interrupts = <39 0>;
-		vref-supply = <&vcc>;
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,lpc3220-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,lpc3220-adc.yaml
new file mode 100644
index 000000000000..2c5032be83bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,lpc3220-adc.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nxp,lpc3220-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC3220 SoC ADC controller
+
+maintainers:
+  - Gregory Clement <gregory.clement@bootlin.com>
+
+description:
+  This hardware block has been used on several LPC32XX SoCs.
+
+properties:
+  compatible:
+    const: nxp,lpc3220-adc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vref-supply: true
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        adc@40048000 {
+            compatible = "nxp,lpc3220-adc";
+            reg = <0x40048000 0x1000>;
+            interrupt-parent = <&mic>;
+            interrupts = <39 0>;
+            vref-supply = <&vcc>;
+        };
+    };
+...
-- 
2.28.0

