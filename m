Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117BAC63777
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 18:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17CA20729
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 18:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604170353;
	bh=MVEG3qMzlUAecaJDH4LWqO64zUsYGda59XuCuxESiXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NMmq6x10U/IOIgscQ2YNC3AQKRqMl85yLxSJxF7EF8vFj68bG8qkssqidgftXcNSq
	 8VfJ3s5rrTYAFtht1wj7SLD9N0o8YfqDtzYi3YX9L6Vxc0nbxQlEnUt6TRfsSNh54b
	 SX6C7i7+TTZSoYwYJ+rbbJ0Lvg5/YX22ALnPpakU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgJaSwc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 14:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728500AbgJaSwa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:30 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 738DB20720;
        Sat, 31 Oct 2020 18:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170350;
        bh=MVEG3qMzlUAecaJDH4LWqO64zUsYGda59XuCuxESiXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OXfmaBPO/2t310lbNvj5aawakQh5tAJV58AvdEvEiLanKIBTCTY225HgXRu6nPnKT
         c/c9z5fIRw4I4DTRK74KWj5LkAw5O7jxdpyZ+Hw/fkWIqPQbG9FruBnDz3vSn8x7+G
         qUHUy0Aa4iOLXd3rJGn7pJ1txMQ1epBlXO2ZoiXY=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 43/46] dt-bindings:iio:gyro:bosch,bmg180: txt to yaml format conversion.
Date:   Sat, 31 Oct 2020 18:48:51 +0000
Message-Id: <20201031184854.745828-44-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Very simple direct conversion of existing txt file.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../bindings/iio/gyroscope/bmg160.txt         | 20 --------
 .../bindings/iio/gyroscope/bosch,bmg160.yaml  | 46 +++++++++++++++++++
 2 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt b/Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt
deleted file mode 100644
index bb43d1ad9c9f..000000000000
--- a/Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-* Bosch BMG160 triaxial rotation sensor (gyroscope)
-
-Required properties:
-
-  - compatible : should be "bosch,bmg160", "bosch,bmi055_gyro" or "bosch,bmi088_gyro"
-  - reg : the I2C address of the sensor (0x69)
-
-Optional properties:
-
-  - interrupts : interrupt mapping for GPIO IRQ, it should by configured with
-		flags IRQ_TYPE_EDGE_RISING
-
-Example:
-
-bmg160@69 {
-	compatible = "bosch,bmg160";
-	reg = <0x69>;
-	interrupt-parent = <&gpio6>;
-	interrupts = <18 (IRQ_TYPE_EDGE_RISING)>;
-};
diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
new file mode 100644
index 000000000000..0466483be6bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/gyroscope/bosch,bmg160.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BMG160 triaxial rotation sensor (gyroscope)
+
+maintainers:
+  - H. Nikolaus Schaller <hns@goldelico.com>
+
+properties:
+  compatible:
+    enum:
+      - bosch,bmg160
+      - bosch,bmi055_gyro
+      - bosch,bmi088_gyro
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    description:
+      Should be configured with type IRQ_TYPE_EDGE_RISING.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        gyroscope@69 {
+            compatible = "bosch,bmg160";
+            reg = <0x69>;
+            interrupt-parent = <&gpio6>;
+            interrupts = <18 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
+...
-- 
2.28.0

