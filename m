Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4903CC64ED8
	for <linux-iio@archiver.kernel.org>; Mon, 27 Feb 2023 21:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjB0VMt (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 27 Feb 2023 16:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjB0VMr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2023 16:12:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDF02687A
        for <linux-iio@vger.kernel.org>; Mon, 27 Feb 2023 13:12:42 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWknQ-00050E-Vo; Mon, 27 Feb 2023 22:12:33 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWknQ-000hzX-4p; Mon, 27 Feb 2023 22:12:32 +0100
Received: from mfe by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWknP-000jX0-9r; Mon, 27 Feb 2023 22:12:31 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     puranjay12@gmail.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v5 1/5] dt-bindings: iio: ti,tmp117: fix documentation link
Date:   Mon, 27 Feb 2023 22:12:26 +0100
Message-Id: <20230227211230.165073-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230227211230.165073-1-m.felsch@pengutronix.de>
References: <20230227211230.165073-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix the broken link to point to the correct homepage.

Fixes: 5e713b25d137 ("dt-bindings: iio: temperature: Add DT bindings for TMP117")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v5:
- no changes
v4:
- no changes
v3:
- no changes
v2:
- added Krzysztof ack

 .../devicetree/bindings/iio/temperature/ti,tmp117.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
index 347bc16a4671b..8d1ec4d39b28c 100644
--- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
@@ -9,7 +9,7 @@ title: "TI TMP117 - Digital temperature sensor with integrated NV memory"
 description: |
     TI TMP117 - Digital temperature sensor with integrated NV memory that supports
     I2C interface.
-      https://www.ti.com/lit/gpn/tmp1
+      https://www.ti.com/lit/gpn/tmp117
 
 maintainers:
   - Puranjay Mohan <puranjay12@gmail.com>
-- 
2.30.2

