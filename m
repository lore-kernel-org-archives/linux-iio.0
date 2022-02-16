Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95E3C433F5
	for <linux-iio@archiver.kernel.org>; Wed, 16 Feb 2022 16:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbiBPQXy (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:23:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbiBPQXw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Feb 2022 11:23:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3106322219C
        for <linux-iio@vger.kernel.org>; Wed, 16 Feb 2022 08:23:38 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1nKN5Z-00018P-6l; Wed, 16 Feb 2022 17:23:33 +0100
Received: from jlu by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1nKN5Y-00014N-Gk; Wed, 16 Feb 2022 17:23:32 +0100
From:   Jan Luebbe <jlu@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jan Luebbe <jlu@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] dt-bindings: iio: adc: microchip,mcp3201: fix interface type (I2C -> SPI)
Date:   Wed, 16 Feb 2022 17:23:12 +0100
Message-Id: <20220216162312.4064-1-jlu@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This family of ADCs uses SPI, not I2C.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 .../devicetree/bindings/iio/adc/microchip,mcp3201.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml
index cbbac4ce56d6..fcc1ba53b20d 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Oskar Andero <oskar.andero@gmail.com>
 
 description: |
-   Family of simple ADCs with an I2C inteface.
+   Family of simple ADCs with a SPI interface.
 
 properties:
   compatible:
-- 
2.30.2

