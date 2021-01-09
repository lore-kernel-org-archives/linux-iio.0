Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AF1C43142
	for <linux-iio@archiver.kernel.org>; Sat,  9 Jan 2021 23:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8F32399A
	for <linux-iio@archiver.kernel.org>; Sat,  9 Jan 2021 23:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbhAIXNV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 9 Jan 2021 18:13:21 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:41667 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbhAIXNU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 Jan 2021 18:13:20 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D90B0FF804;
        Sat,  9 Jan 2021 23:12:37 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 1/6] dt-bindings: trivial-devices: reorder memsic devices
Date:   Sun, 10 Jan 2021 00:11:43 +0100
Message-Id: <20210109231148.1168104-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109231148.1168104-1-alexandre.belloni@bootlin.com>
References: <20210109231148.1168104-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Reorder memsic compatible strings alphabetically

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index bdc2dc318178..e9b64be4b91e 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -148,10 +148,6 @@ properties:
           - maxim,max31730
             # mCube 3-axis 8-bit digital accelerometer
           - mcube,mc3230
-            # MEMSIC magnetometer
-          - memsic,mmc35240
-            # MEMSIC 2-axis 8-bit digital accelerometer
-          - memsic,mxc6225
             # Measurement Specialities I2C temperature and humidity sensor
           - meas,htu21
             # Measurement Specialities I2C pressure and temperature sensor
@@ -166,6 +162,10 @@ properties:
           - meas,ms8607-temppressure
             # Measurement Specialties temperature sensor
           - meas,tsys01
+            # MEMSIC magnetometer
+          - memsic,mmc35240
+            # MEMSIC 2-axis 8-bit digital accelerometer
+          - memsic,mxc6225
             # Microchip differential I2C ADC, 1 Channel, 18 bit
           - microchip,mcp3421
             # Microchip differential I2C ADC, 2 Channel, 18 bit
-- 
2.29.2

