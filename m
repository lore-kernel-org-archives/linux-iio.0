Return-Path: <SRS0=B57L=3N=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D84C32771
	for <linux-iio@archiver.kernel.org>; Fri, 24 Jan 2020 22:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEF22071A
	for <linux-iio@archiver.kernel.org>; Fri, 24 Jan 2020 22:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgAXWN7 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:13:59 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:33214 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728205AbgAXWN6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 24 Jan 2020 17:13:58 -0500
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id EC73C251E9;
        Fri, 24 Jan 2020 23:04:16 +0100 (CET)
From:   David Heidelberg <david@ixit.cz>
To:     linux-iio@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>
Subject: [PATCH 4/7] dt-bindings: iio: light: add support for Dyna-Image AL3010
Date:   Fri, 24 Jan 2020 23:03:43 +0100
Message-Id: <20200124220346.2655336-4-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124220346.2655336-1-david@ixit.cz>
References: <20200124220346.2655336-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Dyna-Image AL3010 is a 16-bit digital ambient light sensor which
provides a multiple gain function with linear response over a dynamic
range 1216/4863/19452/77806.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../devicetree/bindings/iio/light/al3010.yaml | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/al3010.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/al3010.yaml b/Documentation/devicetree/bindings/iio/light/al3010.yaml
new file mode 100644
index 000000000000..9cd1f34a6d63
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/al3010.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/al3010.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dyna-Image AL3010 sensor
+
+maintainers:
+  - David Heidelberg <david@ixit.cz>
+
+properties:
+  compatible:
+    const: dynaimage,al3010
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+required:
+  - compatible
+  - reg
+  - interrupt
+  - vdd-supply
+
+examples:
+  - |
+    i2c {
+        al3010@1c {
+            compatible = "dynaimage,al3010";
+            reg = <0x1c>;
+            vdd-supply = <&vdd_reg>;
+            interrupts = <0 99 4>;
+        };
+    };
-- 
2.25.0

