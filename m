Return-Path: <SRS0=p/QY=TR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C405FC04AB4
	for <linux-iio@archiver.kernel.org>; Fri, 17 May 2019 15:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8635420578
	for <linux-iio@archiver.kernel.org>; Fri, 17 May 2019 15:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k61PYtg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfEQPo6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 17 May 2019 11:44:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55727 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729214AbfEQPo6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 May 2019 11:44:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id x64so7379741wmb.5;
        Fri, 17 May 2019 08:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h4O+JRlbWeC+gbeDKXavJ2OzVFIPFbBGitJDrGVsGfA=;
        b=k61PYtg5BO6fmjdBURTaAanXbkQMhA4N1gvTbaxBfVz80Xgl6irEBj1Sr3XTkI9nv3
         /7n8ci6pzasWZJM9tXjjxk5Z0mYhSbIi9kaDuWnVUSnBGmR/UCssFM66tNG2cIKkRMEs
         xMU/Y4h1E+WxB+/yfAIm4aPZJFJ/+Pxui9UQDK2WnL+hGogkcjelGXdI1byuHSyVEPGM
         RCPqVcOAutpjsma3CWapyGR3i+IYRQo/psgIgGntkqAzQUJh4nFBLbCQWy9yFCENAodX
         8eRHnLL73dd11gDu8zTmkBjsorrg7xcoWLofN+93+ljKkfPxX2onbCOQAzO3qZTXpfRy
         9BxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h4O+JRlbWeC+gbeDKXavJ2OzVFIPFbBGitJDrGVsGfA=;
        b=RqCVxku4XSlobdlg6c6TpJ+4MNrvT/mx+kNoVuogKsPDrps+MYj7/OsbjnGNsA+BUO
         6fXN5D21PJjvD17t6iNkg4gprVJ1xPaSXuLjYZXD8soaYlJsSrzQMyB3+to+GNL8SbMV
         wzw3DuLRU+AhL0yfZM1VOoX7mW4t7N/SPyn2sMnPznCjn3ODd95T2YRh+xuasb+ond3l
         xgggPXTf4XAV8gFnukwyDh0+oGb3kb4ThsmZdttqhyedAVzhxfRlmO7RyyfEGrhTpJuy
         SajbCcUK2yuxDXZJ2tmGdbi4hYbmZIUpI5j+HgVlbuFEE0QjGQUTzKiTZkYnj/d4yfxg
         5zaQ==
X-Gm-Message-State: APjAAAXYcaRc7c14A3579KfmCbJ76rArVAbKjub0IaBsdBwWWP6ZpavT
        dw26QXnKTxb6mQXJI16uu8WpNXSL230=
X-Google-Smtp-Source: APXvYqw41bURtZLYfBBPOA5OOH6/i37/WFkVDSWAUxCEAvCc3F3kC/ozMsd37kJWrzv+VR8lpVD7ug==
X-Received: by 2002:a1c:7312:: with SMTP id d18mr2741689wmb.147.1558107895135;
        Fri, 17 May 2019 08:44:55 -0700 (PDT)
Received: from localhost.localdomain ([188.24.21.151])
        by smtp.gmail.com with ESMTPSA id k63sm1503312wmf.35.2019.05.17.08.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 08:44:54 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH][V3] dt-bindings: iio: accel: adxl345: switch to YAML bindings
Date:   Fri, 17 May 2019 18:44:41 +0300
Message-Id: <20190517154441.27080-1-ardeleanalex@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516133609.10975-1-alexandru.ardelean@analog.com>
References: <20190516133609.10975-1-alexandru.ardelean@analog.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

The ADX345 supports both I2C & SPI bindings.
This change switches from old text bindings, to YAML bindings, and also
tries to make use of the recent multiple-examples support.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changelog v1 -> v2:
* dropped interrupt-parent from DT, as suggested by Rob

Changelog v2 -> v3:
* add Rob's Reviewed-by tag
* add YAML file to MAINTAINERS - main reason for this V3

 .../bindings/iio/accel/adi,adxl345.yaml       | 72 +++++++++++++++++++
 .../devicetree/bindings/iio/accel/adxl345.txt | 39 ----------
 MAINTAINERS                                   |  1 +
 3 files changed, 73 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/adxl345.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
new file mode 100644
index 000000000000..7ba167e2e1ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accelerometers/adi,adxl345.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADXL345/ADXL375 3-Axis Digital Accelerometers
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+description: |
+  Analog Devices ADXL345/ADXL375 3-Axis Digital Accelerometers that supports
+  both I2C & SPI interfaces.
+    http://www.analog.com/en/products/mems/accelerometers/adxl345.html
+    http://www.analog.com/en/products/sensors-mems/accelerometers/adxl375.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adxl345
+      - adi,adxl375
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* Example for a I2C device node */
+        accelerometer@2a {
+            compatible = "adi,adxl345";
+            reg = <0x53>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* Example for a SPI device node */
+        accelerometer@0 {
+            compatible = "adi,adxl345";
+            reg = <0>;
+            spi-max-frequency = <5000000>;
+            spi-cpol;
+            spi-cpha;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/iio/accel/adxl345.txt b/Documentation/devicetree/bindings/iio/accel/adxl345.txt
deleted file mode 100644
index f9525f6e3d43..000000000000
--- a/Documentation/devicetree/bindings/iio/accel/adxl345.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-Analog Devices ADXL345/ADXL375 3-Axis Digital Accelerometers
-
-http://www.analog.com/en/products/mems/accelerometers/adxl345.html
-http://www.analog.com/en/products/sensors-mems/accelerometers/adxl375.html
-
-Required properties:
- - compatible : should be one of
-		"adi,adxl345"
-		"adi,adxl375"
- - reg : the I2C address or SPI chip select number of the sensor
-
-Required properties for SPI bus usage:
- - spi-max-frequency : set maximum clock frequency, must be 5000000
- - spi-cpol and spi-cpha : must be defined for adxl345 to enable SPI mode 3
-
-Optional properties:
- - interrupts: interrupt mapping for IRQ as documented in
-   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-
-Example for a I2C device node:
-
-	accelerometer@2a {
-		compatible = "adi,adxl345";
-		reg = <0x53>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-Example for a SPI device node:
-
-	accelerometer@0 {
-		compatible = "adi,adxl345";
-		reg = <0>;
-		spi-max-frequency = <5000000>;
-		spi-cpol;
-		spi-cpha;
-		interrupt-parent = <&gpio1>;
-		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 43a9cebb2c19..54c8e14fae98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -551,6 +551,7 @@ W:	http://wiki.analog.com/ADXL345
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/input/misc/adxl34x.c
+F:	Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
 
 ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
-- 
2.17.1

