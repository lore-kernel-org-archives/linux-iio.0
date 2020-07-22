Return-Path: <SRS0=Obq9=BB=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC60C433EC
	for <linux-iio@archiver.kernel.org>; Wed, 22 Jul 2020 17:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A4A3206D7
	for <linux-iio@archiver.kernel.org>; Wed, 22 Jul 2020 17:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595438072;
	bh=hy/4WcXA8LfPbW1/1mwdmw2sETcGcxYhBgoiA4NkpNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n8VFjAakM06eUM6vq5Yvm57n3pitBR0ukaa5LgT0bS7moYA6tFkG8ot+NhXpcmWC/
	 bMF6ddjJAlHoOG/+YSFF8eydNCrEDQ6Oa5qyhEMuTV6OAETGuSm5luDp24W5BxB8Sr
	 sFJVB6UiFkaPCKBDwWqazE4o9iDdkmxYNfu/NATA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbgGVROb (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731843AbgGVROa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 13:14:30 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0863207DD;
        Wed, 22 Jul 2020 17:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595438069;
        bh=hy/4WcXA8LfPbW1/1mwdmw2sETcGcxYhBgoiA4NkpNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MPeO1shUeWP79+OKhz4U3ivTkzvcuwJK3St7YyHLgXmxiXcTwJNIS/BxLbU/262jI
         iM2t55zF7t5neRyCr6JF0nQLNF8N5x3MBQKFgTmN2sFXR4ZoAxBWmKaXc7PRcqOJ2v
         a3rq2Zscl28zw1QPhLbKLNqTfy1h3jyKgGLiGvyk=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/3] dt-bindings: iio: adc: maxim,max11100 yaml conversion
Date:   Wed, 22 Jul 2020 18:12:22 +0100
Message-Id: <20200722171224.989138-2-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722171224.989138-1-jic23@kernel.org>
References: <20200722171224.989138-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Straight forward conversion for this SPI ADC.
Added limits on spi-max-frequency from datasheet (0.1 to 4.8MHz)

Cc: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../devicetree/bindings/iio/adc/max11100.txt  | 18 -------
 .../bindings/iio/adc/maxim,max11100.yaml      | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/max11100.txt b/Documentation/devicetree/bindings/iio/adc/max11100.txt
deleted file mode 100644
index b7f7177b8aca..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/max11100.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* Maxim max11100 Analog to Digital Converter (ADC)
-
-Required properties:
-  - compatible: Should be "maxim,max11100"
-  - reg: the adc unit address
-  - vref-supply: phandle to the regulator that provides reference voltage
-
-Optional properties:
-  - spi-max-frequency: SPI maximum frequency
-
-Example:
-
-max11100: adc@0 {
-        compatible = "maxim,max11100";
-        reg = <0>;
-        vref-supply = <&adc0_vref>;
-        spi-max-frequency = <240000>;
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max11100.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max11100.yaml
new file mode 100644
index 000000000000..0cf87556ef82
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max11100.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/maxim,max11100.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX11100 ADC
+
+maintainers:
+  - Jacopo Mondi <jacopo@jmondi.org>
+
+description: |
+    Single channel 16 bit ADC with SPI interface.
+
+properties:
+  compatible:
+    const: maxim,max11100
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description: External reference, needed to establish input scaling.
+
+  spi-max-frequency:
+    minimum: 100000
+    maximum: 4800000
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "maxim,max11100";
+            reg = <0>;
+            vref-supply = <&adc_vref>;
+            spi-max-frequency = <240000>;
+        };
+    };
+...
-- 
2.27.0

