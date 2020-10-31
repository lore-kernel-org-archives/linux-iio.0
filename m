Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC43C388F7
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 18:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B627320729
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 18:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604170312;
	bh=O5f3jidJR7i/UOt0KKH563VuD2QIarTgrn6pmkRfU2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0YjRUUo6CPSgHbBtChBJUaNSVg4dge+4HOMPVXRnfjbEn8oyxFPgtXlMyugwOy27a
	 4nKYs5e/TU9jI/GQ/3/wJ2OUTowWPeDt8P07ObzxbQ9stFHPOUK4r45hxQWtPUHcZx
	 b9uuWRQ113vqcBvIDJfzkhOhAEFClfWO5Sh6LXY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgJaSvw (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 14:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSvv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:51:51 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C016320720;
        Sat, 31 Oct 2020 18:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170311;
        bh=O5f3jidJR7i/UOt0KKH563VuD2QIarTgrn6pmkRfU2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u53l/HiY6JgFd7EOBq28TBH2nany3TyjulFBXFEDFptpLHGdiWHE4UxQxkeyFVnmA
         rYfzKGBNIB63gMIX1SmrtKyMS7ZUsFZKsS3Y4qg2mtrKVvRIvDTcNdZ5D6Wj7yr8bl
         wuTsPiJrkpCtIC2/YYiE6qbSqA0Wgfqlz/hVRi9w=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH 16/46] dt-bindings:iio:light:sharp,gp2ap020a00f: txt to yaml conversion.
Date:   Sat, 31 Oct 2020 18:48:24 +0000
Message-Id: <20201031184854.745828-17-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple conversion.  Maintainers as per original binding file authors,
but that was a long time back so as with others, if email addresses bounce
I'll switch this to me.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../bindings/iio/light/gp2ap020a00f.txt       | 21 --------
 .../iio/light/sharp,gp2ap020a00f.yaml         | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt b/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
deleted file mode 100644
index 9231c82317ad..000000000000
--- a/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-* Sharp GP2AP020A00F I2C Proximity/ALS sensor
-
-The proximity detector sensor requires power supply
-for its built-in led. It is also defined by this binding.
-
-Required properties:
-
-  - compatible : should be "sharp,gp2ap020a00f"
-  - reg : the I2C slave address of the light sensor
-  - interrupts : interrupt specifier for the sole interrupt generated
-		 by the device
-  - vled-supply : VLED power supply, as covered in ../regulator/regulator.txt
-
-Example:
-
-gp2ap020a00f@39 {
-	compatible = "sharp,gp2ap020a00f";
-	reg = <0x39>;
-	interrupts = <2 0>;
-	vled-supply = <...>;
-};
diff --git a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
new file mode 100644
index 000000000000..d6a4b47467f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/sharp,gp2ap020a00f.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sharp GP2AP020A00F I2C Proximity/ALS sensor
+
+maintainers:
+  - Jacek Anaszewski <j.anaszewski@samsung.com>
+  - Kyungmin Park <kyungmin.park@samsung.com>
+
+description: |
+  The proximity detector sensor requires power supply for its built-in led.
+
+properties:
+  compatible:
+    const: sharp,gp2ap020a00f
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vled-supply: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vled-supply
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@39 {
+            compatible = "sharp,gp2ap020a00f";
+            reg = <0x39>;
+            interrupts = <2 0>;
+            vled-supply = <&als_reg>;
+        };
+    };
+...
-- 
2.28.0

