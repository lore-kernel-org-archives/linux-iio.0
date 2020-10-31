Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F6EC56202
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C5C20723
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604151836;
	bh=zrFrDfWrn8n2cXdcN3b2EusNLUdtH+VERVsS/sNUmz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kyeVk2sC1ZBNOFLVXWA6azPlxoff4g+fiBBvqrTGr+rDEfQlaODPUR0b6bcL309zJ
	 VuDSuhIvMQ5YaYDXuDjZjvAsZAz2KP2GCsqM1O2hoeY00QcP2RYtNdBqMW6H5jM0Sh
	 WkOr7H9u6hMyVD2+GNKRBTo+ttr6sM7pib8kT4Nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgJaNnz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 09:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbgJaNnz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:43:55 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E4A42074F;
        Sat, 31 Oct 2020 13:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151834;
        bh=zrFrDfWrn8n2cXdcN3b2EusNLUdtH+VERVsS/sNUmz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DhOsh1huF9GHSQQHWmZMkfDnwWx0ldOlcxLJEwvOAn5atmBjcQIV7BI47neW2uzMg
         AG73fsjvLHy4p4JfN0jNHEW1n7fZION9UbziYs7VL3JIuwbG4gW+KSyP15AnKClVbk
         1Hk3knsTfQ+uaokkjVj7HUlWK9QgcPAlof0BaimY=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 09/29] dt-bindings:iio:proximity:semtech,sx9500 yaml conversion.
Date:   Sat, 31 Oct 2020 13:40:50 +0000
Message-Id: <20201031134110.724233-10-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple conversion.  There hasn't been much activity around this driver
for a long time and I don't think I have any up to date contact details
for the original authors.  As such, I've listed myself as the binding
maintainer.  More than happy to hand it off to someone more relevant though!

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../iio/proximity/semtech,sx9500.yaml         | 50 +++++++++++++++++++
 .../bindings/iio/proximity/sx9500.txt         | 23 ---------
 2 files changed, 50 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9500.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9500.yaml
new file mode 100644
index 000000000000..66dd01506859
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9500.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/semtech,sx9500.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Semtech's SX9500 capacitive proximity button device
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+properties:
+  compatible:
+    const: semtech,sx9500
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      GPIO connected to the active low reset pin.
+    maxItems: 1
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        proximity@28 {
+            compatible = "semtech,sx9500";
+            reg = <0x28>;
+            interrupt-parent = <&gpio2>;
+            interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+            reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/proximity/sx9500.txt b/Documentation/devicetree/bindings/iio/proximity/sx9500.txt
deleted file mode 100644
index c54455db3bec..000000000000
--- a/Documentation/devicetree/bindings/iio/proximity/sx9500.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Semtech's SX9500 capacitive proximity button device driver
-
-Required properties:
-	- compatible: must be "semtech,sx9500"
-	- reg: i2c address where to find the device
-	- interrupts : the sole interrupt generated by the device
-
-	Refer to interrupt-controller/interrupts.txt for generic
-	interrupt client node bindings.
-
-Optional properties:
-	- reset-gpios: Reference to the GPIO connected to the device's active
-	  low reset pin.
-
-Example:
-
-sx9500@28 {
-	compatible = "semtech,sx9500";
-	reg = <0x28>;
-	interrupt-parent = <&gpio2>;
-	interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
-	reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
-};
-- 
2.28.0

