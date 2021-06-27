Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C620C48BC2
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jun 2021 16:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A34619F1
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jun 2021 16:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhF0QdP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 27 Jun 2021 12:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhF0QdP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Jun 2021 12:33:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 490F661A1D;
        Sun, 27 Jun 2021 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624811451;
        bh=HfMjNfSq0JGtXaPncbMa0LA4Gsa76nqTdhYAm6Yy0nM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NPamKmaAGR2E4MSEitB8Yk2nodEmnXBCxyfpEXLF5ESW8VPPj9LJju/92EorE5nns
         qRcpFztBPj0mFkECQGNBlyVVYJynf1co19LzXDEksEBqSzrqUhE9HSEz8xeo9344sE
         VQqTT7Fd6F0dVx8ba4iqvY3lAkgP3JgLkq+Hms1yuEKSyjyiTWstRxth1oX1UJalXE
         iuX3nmTT0qu87fE8xPxr/Qg1s43ysW3/J8zsXMk/inrMhJ+wKKHVgnCwPHUTbZJEcP
         FZpnu4hiBdhyvxLIGg4/hpp0x/JP4OdQhGbQ03SKeqFGTAGa9AnUEH/sUtXW3AVEsT
         xJ49mUdgHxwFA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 07/15] dt-bindings: iio: dac: ad5504: Add missing binding document
Date:   Sun, 27 Jun 2021 17:32:36 +0100
Message-Id: <20210627163244.1090296-8-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210627163244.1090296-1-jic23@kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Binding for this high voltage DAC with temperature event signal.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../bindings/iio/dac/adi,ad5504.yaml          | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
new file mode 100644
index 000000000000..9c2c038683b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5504.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5501 and AD5504 DACs
+
+maintainers:
+  - Lars-Peter Clausen <lars@metafoo.de>
+  - Jonathan Cameron <jic23@kernel.org>
+
+description:
+  High voltage (up to 60V) DACs with temperature sensor alarm function
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5501
+      - adi,ad5504
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Used for temperature alarm.
+    maxItems: 1
+
+  vcc-supply: true
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
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dac@0 {
+            reg = <0>;
+            compatible = "adi,ad5504";
+            vcc-supply = <&dac_vcc>;
+            interrupts = <55 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
+...
-- 
2.32.0

