Return-Path: <SRS0=8e7N=DS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22452C433DF
	for <linux-iio@archiver.kernel.org>; Sun, 11 Oct 2020 17:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5FA322261
	for <linux-iio@archiver.kernel.org>; Sun, 11 Oct 2020 17:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602436235;
	bh=+5Ja9jEOJIU53upi4o7CwBb5NI0WghHNGhYp7Kpyck4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k/tH2a2lm+MV3wg2Fyz5gg5rNQ7WAY0HGPwP/fkIQGAQRXkaARVfdHnli++a/KY1v
	 czS//sEFOoyynoDk5tikNYG/mhlRVTTfGn+V9jOA69ifQjk7d++uzIzqgHJXxS8VBG
	 NpztyUDJ/N3fe95WU5/U2TpZ1wYnksoFvzKSilvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388243AbgJKRKf (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 11 Oct 2020 13:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbgJKRKf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:35 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32EB12222F;
        Sun, 11 Oct 2020 17:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436234;
        bh=+5Ja9jEOJIU53upi4o7CwBb5NI0WghHNGhYp7Kpyck4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GzqHqpOMxj3UWUhUYaUmA/kUG74fBktX23oDDNPO/KEpOILpcstoy1qbeoQ4mxDNG
         ZB01vG56BW44IKayw06kmqvAL/gujXHaiyiZbQY0T/RWxtr5ZR0RAegcO7eF7Ax5eQ
         eJqDy4jEiCIOKou+GF0EEy70CT/oOzhYfRZr5Fd8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?= 
        <vianney.leclement@essensium.com>, Crt Mori <cmo@melexis.com>
Subject: [PATCH 24/29] dt-bindings:iio:temperature:melexis,mlx90614 yaml conversion
Date:   Sun, 11 Oct 2020 18:07:44 +0100
Message-Id: <20201011170749.243680-25-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple conversion from txt to yaml.
I've listed all 3 authors of the driver as maintainers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
Cc: Crt Mori <cmo@melexis.com>
---
 .../iio/temperature/melexis,mlx90614.yaml     | 51 +++++++++++++++++++
 .../bindings/iio/temperature/mlx90614.txt     | 24 ---------
 2 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
new file mode 100644
index 000000000000..dcda203b2ba5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
@@ -0,0 +1,51 @@
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
+  - Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
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

