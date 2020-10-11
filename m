Return-Path: <SRS0=8e7N=DS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C0EC43457
	for <linux-iio@archiver.kernel.org>; Sun, 11 Oct 2020 17:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C8D2222A
	for <linux-iio@archiver.kernel.org>; Sun, 11 Oct 2020 17:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602436223;
	bh=oYSRXi5KXytWS06Rl5Sa+dkqckw7KqJnXcIibndU3kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dHPfMe41dkpbR7FoyJQTfXNLLrRN9EdS3Jbgvu5ZOn/judEwdpOBDbCtGuDHNWySK
	 Y9d3ejuFW7c3vPRSHMQt1F8Rv6wErPYKZqI6h//vaKwEwVwQu3bfog2t+7IWJLx1p4
	 RuVkFY6MYzbikVazXaVW1wD8CHdHZeEFBb3vsIXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbgJKRKW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 11 Oct 2020 13:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbgJKRKW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:22 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4A7122244;
        Sun, 11 Oct 2020 17:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436221;
        bh=oYSRXi5KXytWS06Rl5Sa+dkqckw7KqJnXcIibndU3kQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CKd1c2XQExvi47SVIwMb0lQRveUsmtoakWjK3VT7II/UZx3LvVsIv7vFYKwblTziI
         TVeZJoR+xbXVowYFR6iZWjFu5mfW8Tc6/hCMpI3Qx5SjQwVT+FrwqFycKb2G8zMqez
         K7DhD5cWwGaak3d0wYP1Y2mJ62utrCy2zHhiMQG8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 16/29] dt-bindings:iio:dac:ti,dac082s085 yaml conversion
Date:   Sun, 11 Oct 2020 18:07:36 +0100
Message-Id: <20201011170749.243680-17-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Fairly simple conversion, but it could be tighter than currently
specified.

Is there a clean way to specify a negative dependency?
For now I have just put in the description field that we must have
spi-cpol or spi-cpha but not both.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lukas Wunner <lukas@wunner.de>
---
 .../bindings/iio/dac/ti,dac082s085.yaml       | 58 +++++++++++++++++++
 .../bindings/iio/dac/ti-dac082s085.txt        | 34 -----------
 2 files changed, 58 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
new file mode 100644
index 000000000000..255481f2fee9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/ti,dac082s085.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments DAC082s085 and similar DACs
+
+description:
+  A familly of Texas Instruments 8/10/12-bit 2/4-channel DACs
+
+maintainers:
+  - Lukas Wunner <lukas@wunner.de>
+
+properties:
+  compatible:
+    enum:
+      - ti,dac082s085
+      - ti,dac102s085
+      - ti,dac122s085
+      - ti,dac084s085
+      - ti,dac104s085
+      - ti,dac124s085
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+  spi-cpol:
+    description:
+      Should be either spi-cpha, or spi-cpol but not both.
+
+  vref-supply: true
+
+  spi-max-frequency: true
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
+            compatible = "ti,dac082s085";
+            reg = <0>;
+            spi-max-frequency = <40000000>;
+            spi-cpol;
+            spi-cpha;
+            vref-supply = <&vref_2v5_reg>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt b/Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
deleted file mode 100644
index 9cb0e10df704..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-Texas Instruments 8/10/12-bit 2/4-channel DAC driver
-
-Required properties:
- - compatible:		Must be one of:
-			"ti,dac082s085"
-			"ti,dac102s085"
-			"ti,dac122s085"
-			"ti,dac084s085"
-			"ti,dac104s085"
-			"ti,dac124s085"
- - reg: 		Chip select number.
- - spi-cpha, spi-cpol:	SPI mode (0,1) or (1,0) must be used, so specify
-			either spi-cpha or spi-cpol (but not both).
- - vref-supply: 	Phandle to the external reference voltage supply.
-
-For other required and optional properties of SPI slave nodes please refer to
-../../spi/spi-bus.txt.
-
-Example:
-	vref_2v5_reg: regulator-vref {
-		compatible = "regulator-fixed";
-		regulator-name = "2v5";
-		regulator-min-microvolt = <2500000>;
-		regulator-max-microvolt = <2500000>;
-		regulator-always-on;
-	};
-
-	dac@0 {
-		compatible = "ti,dac082s085";
-		reg = <0>;
-		spi-max-frequency = <40000000>;
-		spi-cpol;
-		vref-supply = <&vref_2v5_reg>;
-	};
-- 
2.28.0

