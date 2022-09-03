Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B035ECAAD4
	for <linux-iio@archiver.kernel.org>; Sat,  3 Sep 2022 05:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiICFDH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 3 Sep 2022 01:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiICFDG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Sep 2022 01:03:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5945E86A0
        for <linux-iio@vger.kernel.org>; Fri,  2 Sep 2022 22:03:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1oULJ1-0000pv-53; Sat, 03 Sep 2022 07:02:55 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1oULIx-003cUv-W3; Sat, 03 Sep 2022 07:02:53 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1oULIz-00BNW4-9B; Sat, 03 Sep 2022 07:02:53 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 1/3] dt-bindings: iio: adc: ti,tsc2046: add vref-supply property
Date:   Sat,  3 Sep 2022 07:02:50 +0200
Message-Id: <20220903050252.2711950-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add property for the voltage reference supply.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml b/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
index 601d69971d84a..7faf12b1598b9 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
@@ -25,6 +25,9 @@ properties:
 
   spi-max-frequency: true
 
+  vref-supply:
+    description: Optional supply of the reference voltage
+
   "#io-channel-cells":
     const: 1
 
-- 
2.30.2

