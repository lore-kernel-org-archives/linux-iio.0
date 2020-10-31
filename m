Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6622C4742C
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B835B20731
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604151842;
	bh=h8jmvAkXUDEug6/omVnWMW1SRAWXoJkdcbmOBiyC3t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mUiJry9+3EQ5RiJ/++48BovZsk3loA6kMxEXCmIbFH8Q0hR2zIsqcg05syEED1xpV
	 vIouktOiUNsb00ts4XPvtVZUK28PPcrbdL4K+leiCVy7w4UuVHX3/g1PDUqL6KhrEo
	 TAf4E/Lz+9DaI1ry6TUkt014uiJ4uBNuOfSaE0ZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgJaNoC (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 09:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgJaNoB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:44:01 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE94320723;
        Sat, 31 Oct 2020 13:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151840;
        bh=h8jmvAkXUDEug6/omVnWMW1SRAWXoJkdcbmOBiyC3t0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pontkMC5xkA12CqxwNA0iG5G7tGIlB+pt3mi5bCTZXok44WYOt1s/1ac0UjATz/Jk
         VT/HixMsFu32CuqIDeXLSKlNSJCn1w5TMsg4lXZcMoz7mc+q+TPwCEintoqIIRudIC
         MgEI/GHUxjilfMBHM87hblEBsYE4+p1kXCEl471g=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Subject: [PATCH v2 13/29] dt-bindings:iio:dac:ti,dac7311 yaml conversion
Date:   Sat, 31 Oct 2020 13:40:54 +0000
Message-Id: <20201031134110.724233-14-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Very simple conversion of this binding from txt to yaml.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
---
 .../bindings/iio/dac/ti,dac7311.txt           | 23 ---------
 .../bindings/iio/dac/ti,dac7311.yaml          | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
deleted file mode 100644
index e5a507db5e01..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-TI DAC7311 device tree bindings
-
-Required properties:
-- compatible: must be set to:
-	* "ti,dac7311"
-	* "ti,dac6311"
-	* "ti,dac5311"
-- reg: spi chip select number for the device
-- vref-supply: The regulator supply for ADC reference voltage
-
-Optional properties:
-- spi-max-frequency: Max SPI frequency to use
-
-Example:
-
-	spi_master {
-		dac@0 {
-			compatible = "ti,dac7311";
-			reg = <0>; /* CS0 */
-			spi-max-frequency = <1000000>;
-			vref-supply = <&vdd_supply>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7311.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.yaml
new file mode 100644
index 000000000000..10be98d1f19c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/ti,dac7311.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments DAC5311 and similar SPI DACs
+
+maintainers:
+  - Charles-Antoine Couret <charles-antoine.couret@essensium.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,dac7311
+      - ti,dac6311
+      - ti,dac5311
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      Reference voltage must be supplied to establish the scaling of the
+      output voltage.
+
+  spi-max-frequency: true
+
+required:
+  - compatible
+  - reg
+  - vref-supply
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
+            compatible = "ti,dac7311";
+            reg = <0>; /* CS0 */
+            spi-max-frequency = <1000000>;
+            vref-supply = <&vdd_supply>;
+        };
+    };
+...
-- 
2.28.0

