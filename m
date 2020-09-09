Return-Path: <SRS0=ZcV1=CS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34669C2D0E0
	for <linux-iio@archiver.kernel.org>; Wed,  9 Sep 2020 18:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E684421D7E
	for <linux-iio@archiver.kernel.org>; Wed,  9 Sep 2020 18:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599674766;
	bh=gT/krbdOva64tyJhEml19mVo5QwxHJLHEdlb5tBEbzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hpVVmqsva+b2ghzfIqkx9Rbcn8YWBrOXdQI8DHGAJzAMEchc/numm8qJ6jwBIB9qL
	 QkzFkRPfpHwp0g98DglDdsqYrrsWdIHCtyfRnsbRsO1BYASrVztbqgg5Ym2dYmqp8b
	 hjjd6FIFFg4TeT4p1rv0AL6lX2hH8U9R4Z9cIXmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgIISGE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729298AbgIISEa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 14:04:30 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A273F221EC;
        Wed,  9 Sep 2020 18:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599674565;
        bh=gT/krbdOva64tyJhEml19mVo5QwxHJLHEdlb5tBEbzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWkUUKGHUzM8AofFDzPL3oQ9afFUpxH1rPvJZZhc1SX+6TeJEmc611HhR8fyPYY5f
         KoY5PC92ACY2j/JUCsHzOHxVqnMfpU1BMIIod4hOecaa2TioBuRKnHRQIJPp8A4eOc
         ydvFhR75wMNWI03VWuOc4t7NxCmJp6u4RVF0Zm2Q=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Subject: [PATCH v2 17/20] dt-bindings:iio:adc:holt,hi8435 yaml conversion
Date:   Wed,  9 Sep 2020 18:59:43 +0100
Message-Id: <20200909175946.395313-18-jic23@kernel.org>
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

Very simple binding.  I've changed the example to use the node
name threshold-detector@0 as sensor@0 seemed too generic.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
---
 .../devicetree/bindings/iio/adc/hi8435.txt    | 21 --------
 .../bindings/iio/adc/holt,hi8435.yaml         | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/hi8435.txt b/Documentation/devicetree/bindings/iio/adc/hi8435.txt
deleted file mode 100644
index 3b0348c5e516..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/hi8435.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Holt Integrated Circuits HI-8435 threshold detector bindings
-
-Required properties:
- - compatible: should be "holt,hi8435"
- - reg: spi chip select number for the device
-
-Recommended properties:
- - spi-max-frequency: definition as per
-		Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Optional properties:
- - gpios: GPIO used for controlling the reset pin
-
-Example:
-sensor@0 {
-	compatible = "holt,hi8435";
-	reg = <0>;
-	gpios = <&gpio6 1 0>;
-
-	spi-max-frequency = <1000000>;
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/holt,hi8435.yaml b/Documentation/devicetree/bindings/iio/adc/holt,hi8435.yaml
new file mode 100644
index 000000000000..a35cf3876b86
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/holt,hi8435.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/holt,hi8435.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Holt Integrated Circuits HI-8435 SPI threshold detector
+
+maintainers:
+  - Vladimir Barinov <vladimir.barinov@cogentembedded.com>
+
+description: |
+  Datasheet: http://www.holtic.com/documents/427-hi-8435_v-rev-lpdf.do
+
+properties:
+  compatible:
+    const: holt,hi8435
+
+  reg:
+    maxItems: 1
+
+  gpios:
+    description:
+       GPIO used for controlling the reset pin
+
+  spi-max-frequency: true
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
+        threshold-detector@0 {
+            compatible = "holt,hi8435";
+            reg = <0>;
+            gpios = <&gpio6 1 0>;
+            spi-max-frequency = <1000000>;
+        };
+    };
+...
-- 
2.28.0

