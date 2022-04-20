Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA684C4332F
	for <linux-iio@archiver.kernel.org>; Wed, 20 Apr 2022 11:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378069AbiDTL3S (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Apr 2022 07:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354709AbiDTL3R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Apr 2022 07:29:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667345FE6;
        Wed, 20 Apr 2022 04:26:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aferraris)
        with ESMTPSA id 6E02C1F4375D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650453989;
        bh=PDQk8Hg2XmGeAhw+vnz6Kqr/MRl2sSD13MWqXSmdmNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fVzTvgfLnjb/DzKK6Unoni3TLPrSMJ6tPUe53F3JnZPnOUXLHdTcI/POmlSEu+aQF
         d7t2f3cbbwfawtPhbZxsIkrLhhLsMd9qDV1jx1miedYHpE54RJUFwXuphWiP216DJI
         tWf26zjeYQgGfTtKrNxJ+Tr2tQuEhJwJfQnzlYNlBHdYLugQSHQvuu4ssIh5nOtqg6
         GlxBZq3piukjvIuTegbgyZlmZtfifO77cvouoRiZQrLHXPLfqVhlQ2lnvpGB4tDIRU
         PKdWkAT4zjPbfv0szY+Til3VVxqU3xVhJf4e7+oT+I18UfVWWgE6Sf8yaS+Y3d+LSl
         KWE8u7CANzmJw==
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH v2 1/2] dt-bindings: iio: light: stk33xx: Add proximity-near-level
Date:   Wed, 20 Apr 2022 13:25:39 +0200
Message-Id: <20220420112540.91907-2-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420112540.91907-1-arnaud.ferraris@collabora.com>
References: <20220420112540.91907-1-arnaud.ferraris@collabora.com>
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

