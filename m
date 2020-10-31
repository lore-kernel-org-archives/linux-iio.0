Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38D0C56201
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1FB72074F
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604151849;
	bh=vAIXIIPv/QX99oQLMAKb/FKaJE7nsMJTp2LJl2IktbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qHUz1sk98p+8HEBoen9Gzqk3rPSsntkJhd6HgqIiWwkpdVLdGQyEXwYJ+dH7BolwJ
	 sKRGvpcfuAIXH6ElRt0zmwRLF1BOYxVyopBvOsQYJ/rahrsxVol2pqth/ill0v95BM
	 lLppXlLU9Vu6wVEU1CHjn237otGUurFfBsSYVyOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgJaNoJ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 09:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgJaNoJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:44:09 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A0F1208B6;
        Sat, 31 Oct 2020 13:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151848;
        bh=vAIXIIPv/QX99oQLMAKb/FKaJE7nsMJTp2LJl2IktbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mqJKWfA1qQf84mT0sMtLNKZz4fkO/TxMP7q3nxa9PF7Q6MqSsn28AwY8wNt9wBiWz
         yoQRrIe2HCLi7LhenwGaJz3jdUPajrtNU4qf8UTnScfUBEJHBuVpFX8XWRaTXTBKF+
         7pqWA5+c/Ek2v2lCzJeg8+lv8fZAgOGZ+SrZzr9U=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>,
        "Ismail H . Kose" <ihkose@gmail.com>
Subject: [PATCH v2 18/29] dt-bindings:iio:dac:maxim,ds4424 yaml conversion
Date:   Sat, 31 Oct 2020 13:40:59 +0000
Message-Id: <20201031134110.724233-19-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple conversion of this straight forward binding.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Ismail H. Kose <ihkose@gmail.com>
---
 .../devicetree/bindings/iio/dac/ds4424.txt    | 20 ---------
 .../bindings/iio/dac/maxim,ds4424.yaml        | 45 +++++++++++++++++++
 2 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ds4424.txt b/Documentation/devicetree/bindings/iio/dac/ds4424.txt
deleted file mode 100644
index eaebbf8dab40..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/ds4424.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Maxim Integrated DS4422/DS4424 7-bit Sink/Source Current DAC Device Driver
-
-Datasheet publicly available at:
-https://datasheets.maximintegrated.com/en/ds/DS4422-DS4424.pdf
-
-Required properties:
-	- compatible: Should be one of
-		maxim,ds4422
-		maxim,ds4424
-	- reg: Should contain the DAC I2C address
-
-Optional properties:
-	- vcc-supply: Power supply is optional. If not defined, driver will ignore it.
-
-Example:
-	ds4224@10 {
-		compatible = "maxim,ds4424";
-		reg = <0x10>; /* When A0, A1 pins are ground */
-		vcc-supply = <&vcc_3v3>;
-	};
diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
new file mode 100644
index 000000000000..264fa7c5fe3a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/maxim,ds4424.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated DS4422/DS4424 7-bit Sink/Source Current DAC
+
+maintainers:
+  - Ismail Kose <ihkose@gmail.com>
+
+description: |
+  Datasheet publicly available at:
+  https://datasheets.maximintegrated.com/en/ds/DS4422-DS4424.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,ds4422
+      - maxim,ds4424
+
+  reg:
+    maxItems: 1
+
+  vcc-supply: true
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
+
+        dac@10 {
+            compatible = "maxim,ds4424";
+            reg = <0x10>; /* When A0, A1 pins are ground */
+            vcc-supply = <&vcc_3v3>;
+        };
+    };
+...
-- 
2.28.0

