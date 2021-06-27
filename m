Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84728C49EAB
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jun 2021 16:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E76761A1D
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jun 2021 16:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhF0Qd3 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 27 Jun 2021 12:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231339AbhF0Qd2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Jun 2021 12:33:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A69D9619AD;
        Sun, 27 Jun 2021 16:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624811464;
        bh=Ksk17R4D3ghCvdxqXTL/5nJIgq88JtydCqN7MwYh3Ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jSIwj/3ULuFdX1bPE4S+8sOVBGTC60fQK0JQotcbBYVx3sXK3oj/L27ZTUwy/jMVp
         zWWS0ybl+yXbQdY4VfE6UEIEhaNp+luo/PEabD6UPCxnJVIAU2pfNHJ5sLfVjTc4/i
         kHRUv0bMoGpM84kHR0J6RSaxk5UL/b8G6IoK9IKZZt4qDssJ9CijyUViQkw4qbGpuk
         MwSOlES4XlzRaKuVPvb+FTWY2AdqkSR+fJ7vdbtTOwzSo5rCLgpXGQh7ac4D66mzsC
         G16kfKDgscC9l0pASWjICr1pl9QLN5n27M9mFK47mfa+z/D6dSuxQAHpGTLk8ehrfE
         ipD7sva2snEHg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 13/15] dt-bindings: iio: dac: adi,ad5791: Add missing bindings document
Date:   Sun, 27 Jun 2021 17:32:42 +0100
Message-Id: <20210627163244.1090296-14-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210627163244.1090296-1-jic23@kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Documenting existing bindings for this device.

The Linux driver in theory 'works' without the two supplies that I have
listed as required, but without a valid scale.  As such I've
documented it as required.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>
---
 .../bindings/iio/dac/adi,ad5791.yaml          | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
new file mode 100644
index 000000000000..650d1ebdcec3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5791.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5791 and similar DACs
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Jonathan Cameron <jic23@kernel.org>
+
+properties:
+
+  compatible:
+    enum:
+      - adi,ad5760
+      - adi,ad5780
+      - adi,ad5781
+      - adi,ad5790
+      - adi,ad5791
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  vdd-supply: true
+  vss-supply: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vss-supply
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad5791";
+            reg = <0>;
+            vss-supply = <&dac_vss>;
+            vdd-supply = <&dac_vdd>;
+        };
+    };
+...
-- 
2.32.0

