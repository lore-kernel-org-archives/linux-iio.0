Return-Path: <SRS0=8e7N=DS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A0AC43457
	for <linux-iio@archiver.kernel.org>; Sun, 11 Oct 2020 17:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1951C2225F
	for <linux-iio@archiver.kernel.org>; Sun, 11 Oct 2020 17:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602436214;
	bh=HGOCALvmV6kwRRyc/HcmOZgT215SjxIj/QLK65WfRz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TfarrW/3ZSo2ZkiPl7AAPCWVS29Bz334gwehwyzmE+6P5ojx7YH3wD08B5g65ooht
	 CAYjksBawRCJeddZfvMFV6YvkVTLN+4dB1d5sRt3vWIFabc3vljf2TrpjrrOP8PRtW
	 5FE9aZ/6dfOuZBDA1pRpaiiXBQe6u7N66knTYKf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgJKRKN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 11 Oct 2020 13:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730277AbgJKRKN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:13 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C83802222C;
        Sun, 11 Oct 2020 17:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436212;
        bh=HGOCALvmV6kwRRyc/HcmOZgT215SjxIj/QLK65WfRz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b2UYhHArDsauYGSeAPELCco2WR5hkcOOkY+Ml2GBW8LAgh+DWvVZjXdLm2Gkvf+iQ
         pjCYfSfO1UFHwCe7KH1ORsk61q7qZHGovKkt61b5JBT7CagDrvaVfzQtWGT93JKAWx
         TUhiY+O86N0bU0z6kUDyiltwBxJhYYX89EJVzna8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH 10/29] dt-bindings:iio:proximity:st,vl53l0x yaml conversion
Date:   Sun, 11 Oct 2020 18:07:30 +0100
Message-Id: <20201011170749.243680-11-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Straight forward conversion from txt to yaml.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

