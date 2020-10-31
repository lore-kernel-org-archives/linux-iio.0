Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FDBC388F9
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EDCF20723
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604151838;
	bh=UKMAY6ZJvobbEok4Rzl44g+rI86poMmEZOZ3CRq137Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LLfmg8rgsJ9NCVgUVwv3s4jUj9Pmb9GH1pPt6v1+Up4NIb45Po9s5XI0p5V2R6+Gz
	 p3cspZAZDEz0dIZZvsufVN7j4SCHm3SvrkIY2uZXEEK8Ml5Di8lkNQfbDocjniNbkh
	 s1nxjRzOAhgkC1GAQv+ksZRzMUvi8CqcAJiwkRI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgJaNn5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 09:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbgJaNn4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:43:56 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D48882071A;
        Sat, 31 Oct 2020 13:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151836;
        bh=UKMAY6ZJvobbEok4Rzl44g+rI86poMmEZOZ3CRq137Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NktSSGFRNxVSns2xBBBTCGXCRqrDyJ8UNdPOHjvGyvzHg1bmJiTaGrJO1R6Gr93dG
         tg2DExytqmkQZ77jW36zGciNCj4CZrIXIKh/geTREjynPqIKNqGZKbT2wUKSWPWGco
         UxSgkobv9W8iEbMPGqnrSwv6PVEObZ6yHj8Uezsc=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v2 10/29] dt-bindings:iio:proximity:st,vl53l0x yaml conversion
Date:   Sat, 31 Oct 2020 13:40:51 +0000
Message-Id: <20201031134110.724233-11-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Straight forward conversion from txt to yaml.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Song Qiang <songqiang1304521@gmail.com>
---
 .../bindings/iio/proximity/st,vl53l0x.yaml    | 42 +++++++++++++++++++
 .../bindings/iio/proximity/vl53l0x.txt        | 18 --------
 2 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml b/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
new file mode 100644
index 000000000000..656460d9d8c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/st,vl53l0x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST VL53L0X ToF ranging sensor
+
+maintainers:
+  - Song Qiang <songqiang1304521@gmail.com>
+
+properties:
+  compatible:
+    const: st,vl53l0x
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        proximity@29 {
+            compatible = "st,vl53l0x";
+            reg = <0x29>;
+            interrupt-parent = <&gpio>;
+            interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
deleted file mode 100644
index dfe00eb961cd..000000000000
--- a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-ST VL53L0X ToF ranging sensor
-
-Required properties:
-	- compatible: must be "st,vl53l0x"
-	- reg: i2c address where to find the device
-
-Optional properties:
-	- interrupts:	Interrupt for notifying that new measurement is ready.
-			If no interrupt is specified, polling is used.
-
-Example:
-
-vl53l0x@29 {
-	compatible = "st,vl53l0x";
-	reg = <0x29>;
-	interrupt-parent = <&gpio>;
-	interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
-};
-- 
2.28.0

