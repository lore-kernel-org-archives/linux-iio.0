Return-Path: <SRS0=ZcV1=CS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66975C2D0E1
	for <linux-iio@archiver.kernel.org>; Wed,  9 Sep 2020 18:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23F1721D46
	for <linux-iio@archiver.kernel.org>; Wed,  9 Sep 2020 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599674695;
	bh=4WGAK8AbbHJfYhD9ddvP6Zim7kuzGr7UghvSwQy6YRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ww3xq7ICjAKiZ1OAyWV2huHYxvNhCHM1lZpsNtlpxrI/fx8MsBMcpf5ZrSnPZEX99
	 TLfH13P229dz7n/EF8Ck+tWOX1Q32ObUCA41pBID9HS4NKx/mezUAECBybllqvvuGS
	 BRaqCAM58Bbm0Iu9LPDxjNB1/DCNmTpCz97fMzFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgIISEw (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730145AbgIISCc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 14:02:32 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6251921D80;
        Wed,  9 Sep 2020 18:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599674550;
        bh=4WGAK8AbbHJfYhD9ddvP6Zim7kuzGr7UghvSwQy6YRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/dxyfxU3gVeHvDXM4lSieav/NVBX32nX+UQeOXqzPcea3joc90NIbu6Zhjoq7J4n
         7f7sPGrsAq6HZ6pLPBPazg01KcI60E5N92rq85SuhwPGCK0NfeGkcXMpM+uQOqC79C
         VViCI4qM/+CNz16rxiM/SFqN3eCtBvXbhNipk6UA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v2 07/20] dt-bindings:iio:adc:nuvoton,nau7802 yaml conversion
Date:   Wed,  9 Sep 2020 18:59:33 +0100
Message-Id: <20200909175946.395313-8-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909175946.395313-1-jic23@kernel.org>
References: <20200909175946.395313-1-jic23@kernel.org>
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

