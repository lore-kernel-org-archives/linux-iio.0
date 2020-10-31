Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20063C56201
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4FD32087D
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604151843;
	bh=/tssV8ENpEKSPfbzWWOXrigv2BAKg2zyaH8lTXcLg9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IzKKEplU0B6gHMjvpMj+1FYoOFnOqDwtVeFWlkncNq3taCPS5TdmfBysnxhiOzrYj
	 9MZlaz9uk6sbe9eS+5qfup4wHje5F0bAUAKDba3wHvLQvhthvTr/P8z7NO4dzEXER7
	 WWQAm1cnZjy21dUAyxypH9vaCoUa+6rZrWTVwKb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgJaNoD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 09:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgJaNoD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:44:03 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45C4F20853;
        Sat, 31 Oct 2020 13:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151842;
        bh=/tssV8ENpEKSPfbzWWOXrigv2BAKg2zyaH8lTXcLg9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvpGSJauczDRqQQNe0ctH1FSyeVVZSWiX4COhLbT0S++CTvnN7uqTzUjkh4D9VQZr
         bcF5viYZUt2j4jOYXA+6a7rOxuRS5rjSFNZmIGyywPprzlhpKycS9EX4ylUgPgAwKk
         QjDvjJyXqIF/4s58eDLriDshNMiIGCIJ7NQHiLzU=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 14/29] dt-bindings:iio:dac:ti,dac7512 yaml conversion
Date:   Sat, 31 Oct 2020 13:40:55 +0000
Message-Id: <20201031134110.724233-15-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This one is a bit interesting because the binding was moved from
misc a while back, but the linux support for this device is
provided via the ad5446 DAC driver which doesn't currently
have a binding.

For now, lets just convert this file over, but we may want to
think about consolidating this with proper documentation of
the bindings for the other parts supported by the ad5446 driver.

As Daniel Mack does not seem to have been active since 2015,
I've put myself as maintainer of this binding for now.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/dac/ti,dac7512.txt           | 20 ---------
 .../bindings/iio/dac/ti,dac7512.yaml          | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7512.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7512.txt
deleted file mode 100644
index 1db45939dac9..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac7512.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-TI DAC7512 DEVICETREE BINDINGS
-
-Required properties:
-
-	- "compatible"		Must be set to "ti,dac7512"
-
-Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
-apply. In particular, "reg" and "spi-max-frequency" properties must be given.
-
-
-Example:
-
-	spi_master {
-		dac7512: dac7512@0 {
-			compatible = "ti,dac7512";
-			reg = <0>; /* CS0 */
-			spi-max-frequency = <1000000>;
-		};
-	};
-
diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7512.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac7512.yaml
new file mode 100644
index 000000000000..4277cf8a4a2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7512.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/ti,dac7512.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments DAC7512 DAC
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+properties:
+  compatible:
+    const: ti,dac7512
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    description:
+      Maximum frequency is reduced for supply voltage of less than 3.6V
+    maximum: 30000000
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
+        dac@0 {
+            compatible = "ti,dac7512";
+            reg = <0>; /* CS0 */
+            spi-max-frequency = <1000000>;
+        };
+    };
+...
-- 
2.28.0

