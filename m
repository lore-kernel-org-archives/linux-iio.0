Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A33C4742C
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34EC20723
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604151859;
	bh=kpDngPab/R2d4KFy4iyytK0kxVH7yXPqsGEC02A7F3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kkUQPCGPBGevgLYEf9cOd48iTWkNEL3GbOKcyGa5nL+VIQAkjoDf6aBOHs/a9z3FY
	 KyknjyHq3jMblTkduYfw/10wn71MdaMdw8qbPl6qYbm8glemASim+lpmOJAyoXkGYz
	 TYbhmSAnDjkw/57uTCxCelocGfcr6jBdeI3sKrew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgJaNoT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 09:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgJaNoT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:44:19 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D945020791;
        Sat, 31 Oct 2020 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151858;
        bh=kpDngPab/R2d4KFy4iyytK0kxVH7yXPqsGEC02A7F3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AxbL43lZpCdgWVXYa1heA6ghCAtEwC+E+nGJX/yuvc+bCIRrkwjE6xFkjcQ8XOeUQ
         lRlB8P7JDYRQH9TDyZDcdwIiOO+FAJYre+rPk8k1ld0lPbP6ih97yRRmOfrWpx2RaY
         +TQT1/s2hf34QUW7UMRTUfEzcGKK6D+vzZgipGdo=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, Crt Mori <cmo@melexis.com>,
        Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 24/29] dt-bindings:iio:temperature:melexis,mlx90614 yaml conversion
Date:   Sat, 31 Oct 2020 13:41:05 +0000
Message-Id: <20201031134110.724233-25-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple conversion from txt to yaml.
I've listed all 3 authors of the driver as maintainers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Crt Mori <cmo@melexis.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
---
 .../iio/temperature/melexis,mlx90614.yaml     | 50 +++++++++++++++++++
 .../bindings/iio/temperature/mlx90614.txt     | 24 ---------
 2 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
new file mode 100644
index 000000000000..d6965a0c1cf3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/melexis,mlx90614.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Melexis MLX90614 contactless IR temperature sensor
+
+maintainers:
+  - Peter Meerwald <pmeerw@pmeerw.net>
+  - Crt Mori <cmo@melexis.com>
+
+description: |
+  http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-Sensors/MLX90614-615.aspx
+
+properties:
+  compatible:
+    const: melexis,mlx90614
+
+  reg:
+    maxItems: 1
+
+  wakeup-gpios:
+    description:
+      GPIO connected to the SDA line to hold low in order to wake up the
+      device.  In normal operation, the GPIO is set as input and will
+      not interfere in I2C communication.  There is no need for a GPIO
+      driving the SCL line.  If no GPIO is given, power management is disabled.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temp-sensor@5a {
+            compatible = "melexis,mlx90614";
+            reg = <0x5a>;
+            wakeup-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt b/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
deleted file mode 100644
index 9be57b036092..000000000000
--- a/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-* Melexis MLX90614 contactless IR temperature sensor
-
-http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-Sensors/MLX90614-615.aspx
-
-Required properties:
-
-  - compatible: should be "melexis,mlx90614"
-  - reg: the I2C address of the sensor
-
-Optional properties:
-
-  - wakeup-gpios: device tree identifier of the GPIO connected to the SDA line
-      to hold low in order to wake up the device.  In normal operation, the
-      GPIO is set as input and will not interfere in I2C communication.  There
-      is no need for a GPIO driving the SCL line.  If no GPIO is given, power
-      management is disabled.
-
-Example:
-
-mlx90614@5a {
-	compatible = "melexis,mlx90614";
-	reg = <0x5a>;
-	wakeup-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
-};
-- 
2.28.0

