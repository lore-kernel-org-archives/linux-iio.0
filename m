Return-Path: <SRS0=b3IJ=CT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE11BC43461
	for <linux-iio@archiver.kernel.org>; Thu, 10 Sep 2020 17:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 916AF20C09
	for <linux-iio@archiver.kernel.org>; Thu, 10 Sep 2020 17:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599758381;
	bh=E5MilslhrwDTn9643nyVveDghPC9CwnzqfWv/QBY2oA=;
	h=From:To:Subject:Date:List-ID:From;
	b=AnNvfKU/UwTUN6FOYhRmc2Qb8rfEOO8z3TNP7QJFIIRYoU+/MnRaBrjBQjq8Re7GH
	 zIcEJkc8H70apM5UIEAroWWoYYxW99NXvyJk1K/Png77RQXgXPKhIkS8GgF4b/0P7e
	 O3L23WvKULG9J3kBEN/6UoPwIakUK4HOt7trDDvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIJQc4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgIJQU1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 12:20:27 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25690206A1;
        Thu, 10 Sep 2020 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599754781;
        bh=E5MilslhrwDTn9643nyVveDghPC9CwnzqfWv/QBY2oA=;
        h=From:To:Subject:Date:From;
        b=OF8xq9xhv+JmwGyjqxkh9SDIuZDYO3T85mMKEHok2TZefbQyNUqptmBg2DbF5ESAi
         LA0FbreygSKV8b+pD5lSmoAtnGHNg3P3w99wFmGyqwNUcESwwHhY65ypiOtty5g9uJ
         CwR/Z7tFZBQ1RAj5U3e+1I9vhJXj5CLb+xGhPJSg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: exynos-adc: require second interrupt with touch screen
Date:   Thu, 10 Sep 2020 18:19:32 +0200
Message-Id: <20200910161933.9156-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADC in S3C/S5P/Exynos SoCs can be used also for handling touch
screen.  In such case the second interrupt is required.  This second
interrupt can be anyway provided, even without touch screens.  This
fixes dtbs_check warnings like:

  arch/arm/boot/dts/s5pv210-aquila.dt.yaml: adc@e1700000: interrupts: [[23], [24]] is too long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>

---

Changes since v1:
1. Fix if:has-touchscreen, as pointed by Rob.
2. Add Ack.
---
 .../bindings/iio/adc/samsung,exynos-adc.yaml       | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index cc3c8ea6a894..17a08be3fe85 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -41,7 +41,10 @@ properties:
     maxItems: 2
 
   interrupts:
-    maxItems: 1
+    description:
+      ADC interrupt followed by optional touchscreen interrupt.
+    minItems: 1
+    maxItems: 2
 
   "#io-channel-cells":
     const: 1
@@ -107,6 +110,15 @@ allOf:
           items:
             - const: adc
 
+  - if:
+      required:
+        - has-touchscreen
+    then:
+      properties:
+        interrupts:
+          minItems: 2
+          maxItems: 2
+
 examples:
   - |
     adc: adc@12d10000 {
-- 
2.17.1

