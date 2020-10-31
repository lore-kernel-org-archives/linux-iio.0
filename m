Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE773C55179
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 18:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AFD320724
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 18:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604170322;
	bh=Nu2J9vKa1fygViBKeycZdTwrrBZvrFRMzcwEz4+VvgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rJp5TOdtTuHKYWtfNY2ZHjdLL4a91STHI0Zfs+8B/iygq/d9diRQBfHZdfVK0Bywb
	 LSYOVsrJ4/eYnUBQXQBkF8ReIbIMxHGOp5dv5/JXDQ8MWc0WBjCQ9XtGE+O7g6jHxi
	 8FiwD45i5k5F0gktBfYldLkIdx9F10wP3uRUm/ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgJaSwC (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 14:52:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSwB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:01 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F8D92071A;
        Sat, 31 Oct 2020 18:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170321;
        bh=Nu2J9vKa1fygViBKeycZdTwrrBZvrFRMzcwEz4+VvgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJ5CcmD+xZGItti+vzbWQD9zWPB1sWl9cqFHqlCRZSrFIPsoYavXd57ye6PNiUP1z
         4hMYltUgD6L8xPm9pB9C7p65shdyNZ2OQJTQl629pgzax9ymZSBYZc0d/CH+DaSAkA
         jBafqGlSo2zeXs5SmPQCE8bWrxajqDpzBInLrx4A=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 23/46] dt-bindings:iio:magnetometer:fsl,mag3110: txt to yaml conversion
Date:   Sat, 31 Oct 2020 18:48:31 +0000
Message-Id: <20201031184854.745828-24-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Dropped a few bits of help text in here that didn't seem to add anything
that wasn't fairly obvious.  Otherwise simple format conversion

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Anson Huang <Anson.Huang@nxp.com>
---
 .../iio/magnetometer/fsl,mag3110.yaml         | 48 +++++++++++++++++++
 .../bindings/iio/magnetometer/mag3110.txt     | 27 -----------
 2 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/fsl,mag3110.yaml b/Documentation/devicetree/bindings/iio/magnetometer/fsl,mag3110.yaml
new file mode 100644
index 000000000000..6b54d32323fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/fsl,mag3110.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/fsl,mag3110.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MAG3110 magnetometer sensor
+
+maintainers:
+  - Anson Huang <Anson.Huang@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,mag3110
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+  vddio-supply: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@e {
+            compatible = "fsl,mag3110";
+            reg = <0x0e>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_i2c3_mag3110_int>;
+            interrupt-parent = <&gpio3>;
+            interrupts = <16 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/magnetometer/mag3110.txt b/Documentation/devicetree/bindings/iio/magnetometer/mag3110.txt
deleted file mode 100644
index bdd40bcaaa1f..000000000000
--- a/Documentation/devicetree/bindings/iio/magnetometer/mag3110.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* FREESCALE MAG3110 magnetometer sensor
-
-Required properties:
-
-  - compatible : should be "fsl,mag3110"
-  - reg : the I2C address of the magnetometer
-
-Optional properties:
-
-  - interrupts: the sole interrupt generated by the device
-
-  Refer to interrupt-controller/interrupts.txt for generic interrupt client
-  node bindings.
-
-  - vdd-supply: phandle to the regulator that provides power to the sensor.
-  - vddio-supply: phandle to the regulator that provides power to the sensor's IO.
-
-Example:
-
-magnetometer@e {
-	compatible = "fsl,mag3110";
-	reg = <0x0e>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3_mag3110_int>;
-	interrupt-parent = <&gpio3>;
-	interrupts = <16 IRQ_TYPE_EDGE_RISING>;
-};
-- 
2.28.0

