Return-Path: <SRS0=PRbX=CO=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5C5C2BBD0
	for <linux-iio@archiver.kernel.org>; Sat,  5 Sep 2020 17:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC55208DB
	for <linux-iio@archiver.kernel.org>; Sat,  5 Sep 2020 17:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599327189;
	bh=4WGAK8AbbHJfYhD9ddvP6Zim7kuzGr7UghvSwQy6YRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EkfPTKxwnbHDhEL426GeVQWaHHv9L75Hoawyk6XOYZy3YQiN7kCTYxyhsHIOXMlHk
	 jTXi2qKP9aMlSu2j2n9d+qoFZaK2IIOgl3O+nmP7lIf92r3Z+8juhVmooE3j7pZyRE
	 zs+Qv93I1mF6w228n7FVmkQfos/9Nb+/FAyMaenM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgIERco (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 5 Sep 2020 13:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbgIERch (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:32:37 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80280208DB;
        Sat,  5 Sep 2020 17:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599327156;
        bh=4WGAK8AbbHJfYhD9ddvP6Zim7kuzGr7UghvSwQy6YRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n6ht+dl7eb8KORmudM5jKs+Bl2/heHXE20ZZwYcba7EAyV9JwWg7ZqSYtPHzhNuuI
         +YHqLTKf6Ia+pL46Ml/SSh9xPN6SEMLzFvEsC9OS9lLeFxVscUzY4wvw/VjhHB+609
         TZtWGykiG1aVGxfHsS+ZVIKXYwE5DW6iPlPj6jvA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 07/20] dt-bindings:iio:adc:nuvoton,nau7802 yaml conversion
Date:   Sat,  5 Sep 2020 18:29:51 +0100
Message-Id: <20200905173004.216081-8-jic23@kernel.org>
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

A simple conversion from txt file to yaml.  I added the #io-channel-cells
property as optional to allow the channels of this ADCs to be used
to provide services to other drivers, for example if an analog
accelerometer is connected.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../bindings/iio/adc/nuvoton,nau7802.yaml     | 50 +++++++++++++++++++
 .../bindings/iio/adc/nuvoton-nau7802.txt      | 18 -------
 2 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nau7802.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nau7802.yaml
new file mode 100644
index 000000000000..bcd041ea28a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nau7802.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nuvoton,nau7802.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NAU7802 I2c Analog to Digital Converter (ADC)
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@free-electrons.com>
+  - Maxime Ripard <maxime.ripard@free-electrons.com>
+
+properties:
+  compatible:
+    const: nuvoton,nau7802
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  nuvoton,vldo:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Internal reference voltage in millivolts to be configured.
+    minimum: 2400
+    maximum: 4500
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        nau7802@2a {
+            compatible = "nuvoton,nau7802";
+            reg = <0x2a>;
+            nuvoton,vldo = <3000>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton-nau7802.txt b/Documentation/devicetree/bindings/iio/adc/nuvoton-nau7802.txt
deleted file mode 100644
index e9582e6fe350..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/nuvoton-nau7802.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* Nuvoton NAU7802 Analog to Digital Converter (ADC)
-
-Required properties:
-  - compatible: Should be "nuvoton,nau7802"
-  - reg: Should contain the ADC I2C address
-
-Optional properties:
-  - nuvoton,vldo: Internal reference voltage in millivolts to be
-    configured valid values are between 2400 mV and 4500 mV.
-  - interrupts: IRQ line for the ADC. If not used the driver will use
-    polling.
-
-Example:
-adc2: nau7802@2a {
-	compatible = "nuvoton,nau7802";
-	reg = <0x2a>;
-	nuvoton,vldo = <3000>;
-};
-- 
2.28.0

