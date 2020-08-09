Return-Path: <SRS0=CopR=BT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA75C433EA
	for <linux-iio@archiver.kernel.org>; Sun,  9 Aug 2020 11:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CF62076C
	for <linux-iio@archiver.kernel.org>; Sun,  9 Aug 2020 11:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596972008;
	bh=Yi7NOX20oAGRIEcrgpDQgWZBLUpOfCrio5toa1FhB1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZtyP8O8NU4rl8fUiPIq3sg5+zUmtxGqgJDtBd4X5NaaQOI5nVS3JmJhX4cXZXhMOn
	 KoOML7jNiDhJx4RkNxsnriHEmF72wdosYcDrjGcnj1YjZZlfaiSUMkahfE1JymoxuO
	 AGZkz9LI6VoedbqcBQKkBHmdXwu9FDqrENKK2s3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHILUH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 9 Aug 2020 07:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgHILUG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 07:20:06 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AB15206D8;
        Sun,  9 Aug 2020 11:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596972006;
        bh=Yi7NOX20oAGRIEcrgpDQgWZBLUpOfCrio5toa1FhB1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RbcHddB7h0KN8m50oja2Vs0a246hI/R0IONtVVLsW6iwyOnPYhaNMVQfXckcgC04E
         EFDvpF4VfaZadC2bu2v+3V0c6T1SaT+It4VoR8980UjVekA3Lbg/zqIaWr/Ubv+g2K
         vWPRXnwFN05DefOAI2/97SRusRWkSQNXzBrU6GJQ=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 05/13] dt-bindings: iio: adc: ti,adc161s626 yaml conversion.
Date:   Sun,  9 Aug 2020 12:17:45 +0100
Message-Id: <20200809111753.156236-6-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809111753.156236-1-jic23@kernel.org>
References: <20200809111753.156236-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple conversion for this ADC driver.  Note that I haven't put
limits on the spi-max-sampling-frequency because the adc161s626
doesn't state one clearly defined value.

Added the #io-channel-cells property to allow for consumers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 .../bindings/iio/adc/ti,adc161s626.yaml       | 51 +++++++++++++++++++
 .../bindings/iio/adc/ti-adc161s626.txt        | 18 -------
 2 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc161s626.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc161s626.yaml
new file mode 100644
index 000000000000..3f4f334d6f73
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc161s626.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,adc161s626.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADC141S626 and ADC161S626 ADCs
+
+maintainers:
+  - Matt Ranostay <matt.ranostay@konsulko.com>
+
+description: |
+  Single channel 14/16bit differential ADCs
+
+properties:
+  compatible:
+    enum:
+      - ti,adc141s626
+      - ti,adc161s626
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  vdda-supply: true
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
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,adc161s626";
+            vdda-supply = <&vdda_fixed>;
+            reg = <0>;
+            spi-max-frequency = <4300000>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt
deleted file mode 100644
index 3d25011f0c99..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-* Texas Instruments ADC141S626 and ADC161S626 chips
-
-Required properties:
- - compatible: Should be "ti,adc141s626" or "ti,adc161s626"
- - reg: spi chip select number for the device
- - vdda-supply: supply voltage to VDDA pin
-
-Recommended properties:
- - spi-max-frequency: Definition as per
-		Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Example:
-adc@0 {
-	compatible = "ti,adc161s626";
-	vdda-supply = <&vdda_fixed>;
-	reg = <0>;
-	spi-max-frequency = <4300000>;
-};
-- 
2.28.0

