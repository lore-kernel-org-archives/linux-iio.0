Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288AEC433FE
	for <linux-iio@archiver.kernel.org>; Fri, 15 Apr 2022 08:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351536AbiDOIxC (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 15 Apr 2022 04:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351535AbiDOIxB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Apr 2022 04:53:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3764B716B;
        Fri, 15 Apr 2022 01:50:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aferraris)
        with ESMTPSA id E68C91F40F07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650012632;
        bh=PDQk8Hg2XmGeAhw+vnz6Kqr/MRl2sSD13MWqXSmdmNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UMDiPpPUWC58PDk3Ald6Q8jESPJJaxacE4uElQPWCA8xsZB6J+MR/PQSFaRb9X11P
         DtqzRHJQjNanGilRwpQaH4FK2ZYiWEKAi63lduqP7YfAiriI1KFtEWW60Qw2VB7ZXc
         Gbid5KxQQSm6HjaaJfpJ3Zc5QwNNCcE3sg/5vuJKs4WCj90FWi90VJu5Ro5NdCL0sF
         ZvwajPcFBH6r4AVh8dSCL+3vhyI3xo8UHAdU4IhFF9U1VPXWCjaeqExQZQWX9ZtQ3u
         7f121pc+UWNxAiNi9DZGmGqSv3BI4ShUrZQcdC8UHpnUFrWWIQr1SvYtgXs9EfBrKr
         H2ngczZ8zqCvg==
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 1/2] dt-bindings: iio: light: stk33xx: Add proximity-near-level
Date:   Fri, 15 Apr 2022 10:50:17 +0200
Message-Id: <20220415085018.35063-2-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415085018.35063-1-arnaud.ferraris@collabora.com>
References: <20220415085018.35063-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This allows exporting the value from which userspace should assert an
object is "near".

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
index f92bf7b2b7f0..f6e22dc9814a 100644
--- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
+++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
@@ -13,6 +13,9 @@ maintainers:
 description: |
   Ambient light and proximity sensor over an i2c interface.
 
+allOf:
+  - $ref: ../common.yaml#
+
 properties:
   compatible:
     enum:
@@ -26,6 +29,8 @@ properties:
   interrupts:
     maxItems: 1
 
+  proximity-near-level: true
+
 required:
   - compatible
   - reg
@@ -44,6 +49,7 @@ examples:
         stk3310@48 {
                 compatible = "sensortek,stk3310";
                 reg = <0x48>;
+                proximity-near-level = <25>;
                 interrupt-parent = <&gpio1>;
                 interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
         };
-- 
2.35.1

