Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4111C388F9
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 18:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A026820706
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 18:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604170313;
	bh=dyozSHBidbCpE68HDPMTN5188ZmV/mBciN/Dv709ZRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TQzsn444K5XFw/cJK1CKg3bXyFjWmxvvg1v0Kv/M5NaqCNkzyBIYyJJ08yWZgZP+K
	 orxrVMz8PnMocliORZt9+uNfJ3nrTYzfh57ixvJ+gKJE9cTHs/Q1L574mIEiB20eYU
	 yje9XttrU/XBerlorT5a3RiWbuj1zVZbN0ffQUPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgJaSvx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 14:51:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSvx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:51:53 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 629AE2071A;
        Sat, 31 Oct 2020 18:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170312;
        bh=dyozSHBidbCpE68HDPMTN5188ZmV/mBciN/Dv709ZRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GdENXmvMx/J/PeKGH2T0a8lsao9nVsDjKQPyen76ssNu9NrxMlAsU1FANd4E80d4g
         rDoZgVhQPJsOF/smBi2FDBAgJKhs1S4yWnhvQVm5LBNuEcCFH8wb18T/v/IW2mHU0O
         /r2fJzRCd5lN4PgXeHP9vns7lQ3SnG0JRmEO1Jds=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH 17/46] dt-bindings:iio:light:maxim,max44009: txt to yaml conversion.
Date:   Sat, 31 Oct 2020 18:48:25 +0000
Message-Id: <20201031184854.745828-18-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Straight forward format conversion.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Robert Eshleman <bobbyeshleman@gmail.com>
---
 .../bindings/iio/light/max44009.txt           | 24 ----------
 .../bindings/iio/light/maxim,max44009.yaml    | 45 +++++++++++++++++++
 2 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/max44009.txt b/Documentation/devicetree/bindings/iio/light/max44009.txt
deleted file mode 100644
index 4a98848e35c0..000000000000
--- a/Documentation/devicetree/bindings/iio/light/max44009.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-* MAX44009 Ambient Light Sensor
-
-Required properties:
-
-- compatible: should be "maxim,max44009"
-- reg: the I2C address of the device (default is <0x4a>)
-
-Optional properties:
-
-- interrupts: interrupt mapping for GPIO IRQ. Should be configured with
-  IRQ_TYPE_EDGE_FALLING.
-
-Refer to interrupt-controller/interrupts.txt for generic interrupt client
-node bindings.
-
-Example:
-
-light-sensor@4a {
-	compatible = "maxim,max44009";
-	reg = <0x4a>;
-
-	interrupt-parent = <&gpio1>;
-	interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
-};
diff --git a/Documentation/devicetree/bindings/iio/light/maxim,max44009.yaml b/Documentation/devicetree/bindings/iio/light/maxim,max44009.yaml
new file mode 100644
index 000000000000..5911bd93bcb1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/maxim,max44009.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/maxim,max44009.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAX44009 Ambient Light Sensor
+
+maintainers:
+  - Robert Eshleman <bobbyeshleman@gmail.com>
+
+properties:
+  compatible:
+    const: maxim,max44009
+
+  reg:
+    maxItems: 1
+    description: Default address is 0x4a
+
+  interrupts:
+    maxItems: 1
+    description: Should be configured with type IRQ_TYPE_EDGE_FALLING
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@4a {
+            compatible = "maxim,max44009";
+            reg = <0x4a>;
+
+            interrupt-parent = <&gpio1>;
+            interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
+...
-- 
2.28.0

