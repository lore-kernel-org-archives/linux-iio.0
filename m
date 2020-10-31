Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84300C56202
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 18:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537E520702
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 18:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604170325;
	bh=tOcrwtbSr7hbcaF8Jv3E95/oHdOCgnCEyE5zuMQCuk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gOURPy3yV7FEczpz1BjhZiNbQSsQ2YmymImni8pTmvdCY6HWp5UeSi9DLaRlJxuoW
	 meg4sepoNo3jRqgEaVGOU1FsNoTF3ojeTINYedArrGIPotr07alUgrR4J73aNFQLfU
	 njgd89ieFFAB65QeB1mMtM+1sWE80+3xKYVAEFKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgJaSwE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 14:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSwE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:04 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2079E20729;
        Sat, 31 Oct 2020 18:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170324;
        bh=tOcrwtbSr7hbcaF8Jv3E95/oHdOCgnCEyE5zuMQCuk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J0GJJ9ymvQ+NSSbeLP9HuyeqTHC6hApz7L2AM0zQRWeqC4xjgzioaF+ZAdDipUHUo
         /1z8RF7hFaXrf/4ijhVXX0y8bZdJ6x6nLMZdteP1nN8zs40/XQh3AkGciAwFFIVSoU
         YLRR9Q2kla6TRwum1ey22+IceElicQhrU6psdkMc=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 25/46] dt-bindings:iio:magnetometer:bosch,bmc150_magn: txt to yaml conversion.
Date:   Sat, 31 Oct 2020 18:48:33 +0000
Message-Id: <20201031184854.745828-26-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This describes the bindings for both stand along magnetometers and ones
which form part of a multi chip package.
Given original author hasn't been active remotely recently I've
put myself as maintainer for this one.  I would of course like to
hand this over to someone more appropriate so shout out if this is you!

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../bindings/iio/magnetometer/bmc150_magn.txt | 25 ---------
 .../iio/magnetometer/bosch,bmc150_magn.yaml   | 55 +++++++++++++++++++
 2 files changed, 55 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt b/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
deleted file mode 100644
index 22912e43b60c..000000000000
--- a/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-* Bosch BMC150 magnetometer sensor
-
-http://ae-bst.resource.bosch.com/media/products/dokumente/bmc150/BST-BMC150-DS000-04.pdf
-
-Required properties:
-
-  - compatible : should be one of:
-                 "bosch,bmc150_magn"
-                 "bosch,bmc156_magn"
-                 "bosch,bmm150"
-                 "bosch,bmm150_magn" (DEPRECATED, use bosch,bmm150)
-  - reg : the I2C address of the magnetometer
-
-Optional properties:
-
-  - interrupts : interrupt mapping for GPIO IRQ
-
-Example:
-
-bmc150_magn@12 {
-        compatible = "bosch,bmc150_magn";
-        reg = <0x12>;
-        interrupt-parent = <&gpio1>;
-        interrupts = <0 1>;
-};
diff --git a/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
new file mode 100644
index 000000000000..cdef7aeba708
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/bosch,bmc150_magn.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/bosch,bmc150_magn.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BMC150 magnetometer sensor
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description: |
+  Supports a range of parts, some of which form part of a multi die
+  package that also contains other sensors.  The interface is independent
+  however, so a separate driver is used to support the magnetometer part.
+  Datasheet at:
+  http://ae-bst.resource.bosch.com/media/products/dokumente/bmc150/BST-BMC150-DS000-04.pdf
+
+properties:
+  compatible:
+    description:
+      Note the bmm150_magn is a deprecated compatible as this part contains only
+      a magnetometer.
+    enum:
+      - bosch,bmc150_magn
+      - bosch,bmc156_magn
+      - bosch,bmm150
+      - bosch,bmm150_magn
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+additionalProperties: false
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
+        magnetometer@12 {
+            compatible = "bosch,bmc150_magn";
+            reg = <0x12>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <0 1>;
+        };
+    };
+...
-- 
2.28.0

