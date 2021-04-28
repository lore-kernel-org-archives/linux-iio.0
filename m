Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67090C433B4
	for <linux-iio@archiver.kernel.org>; Wed, 28 Apr 2021 08:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A2FE61424
	for <linux-iio@archiver.kernel.org>; Wed, 28 Apr 2021 08:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbhD1IXJ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 28 Apr 2021 04:23:09 -0400
Received: from first.geanix.com ([116.203.34.67]:54878 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231635AbhD1IXJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 28 Apr 2021 04:23:09 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id B285E466237;
        Wed, 28 Apr 2021 08:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1619598142; bh=rXBeEcA9CZf0wbgtQwxj0IR+2E3k+SkK1PjHdt8Xma8=;
        h=From:To:Cc:Subject:Date;
        b=IILr6Ar7iYI5TRHeUH14Vnp1SzVczjUfgotv5FG58NwLHxelZf0asoecXLDZlRVDO
         i0Hm4jh9cgSPkTminPa0tUGOf8k7K+PORJxs5LkFmFqFHtmMDYbACS8n99xTOqEQ6r
         pyPoN7Hpv0ei/B7k4MKzCqu8s0uX+IqlJq0DIG3wlU0ilBLNhXBlixAMijBK7LuThx
         Zq2pflRvp2H6u/hy0ONUHA/EiQyjWDqvaxm2yB0uB1/J3Yf0q40WXM7pHCrtbhrJCd
         ZD+qoM3OoVuDsrEnlL0+CnbStLLQYbX0drrMCk8JSUu/Un1STdalr2JTjo9swSxp0q
         Q4V/TRrz7AsKw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de, Nuno.Sa@analog.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [RFC PATCH 1/4] dt-bindings: iio: accel: fxls8962af: add interrupt options
Date:   Wed, 28 Apr 2021 10:22:00 +0200
Message-Id: <20210428082203.3587022-1-sean@geanix.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This in done for supporting hw buffered sampling

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
This series depends on "iio: accel: add support for
FXLS8962AF/FXLS8964AF accelerometers"

 .../bindings/iio/accel/nxp,fxls8962af.yaml           | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
index c7be7a1679ab..e0e5542377df 100644
--- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
@@ -32,6 +32,16 @@ properties:
   interrupts:
     maxItems: 1
 
+  interrupt-names:
+    maxItems: 1
+    items:
+      enum:
+        - INT1
+        - INT2
+
+  drive-open-drain:
+    type: boolean
+
 required:
   - compatible
   - reg
@@ -51,6 +61,7 @@ examples:
             reg = <0x62>;
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT1";
         };
     };
   - |
@@ -66,5 +77,6 @@ examples:
             spi-max-frequency = <4000000>;
             interrupt-parent = <&gpio0>;
             interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "INT1";
         };
     };
-- 
2.31.0

