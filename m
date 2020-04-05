Return-Path: <SRS0=q/te=5V=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E4EC2BABC
	for <linux-iio@archiver.kernel.org>; Sun,  5 Apr 2020 13:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3A020672
	for <linux-iio@archiver.kernel.org>; Sun,  5 Apr 2020 13:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgDENuz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 5 Apr 2020 09:50:55 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:44818 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727193AbgDENun (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 09:50:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 9417BFB03;
        Sun,  5 Apr 2020 15:50:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O42RKypAh9pA; Sun,  5 Apr 2020 15:50:36 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 068CE414D9; Sun,  5 Apr 2020 15:50:33 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH v4 3/5] dt-bindings: iio: light: vcnl4000: Add proximity-near-level
Date:   Sun,  5 Apr 2020 15:50:30 +0200
Message-Id: <9bbbc30e5e8e67e50ddacb4cadc180fa5c7f7bd0.1586094535.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1586094535.git.agx@sigxcpu.org>
References: <cover.1586094535.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This value indicates when userspace should consider an object
near to the sensor/device.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml     | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
index 21ef2eb7a205..da8f2e872535 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
@@ -13,6 +13,9 @@ description: |
   Ambient light sensing with proximity detection over an i2c
   interface.
 
+allOf:
+  - $ref: ../common.yaml#
+
 properties:
   compatible:
     enum:
@@ -21,10 +24,11 @@ properties:
       - vishay,vcnl4020
       - vishay,vcnl4040
       - vishay,vcnl4200
-
   reg:
     maxItems: 1
 
+  proximity-near-level: true
+
 required:
   - compatible
   - reg
@@ -40,6 +44,7 @@ examples:
       light-sensor@51 {
               compatible = "vishay,vcnl4200";
               reg = <0x51>;
+              proximity-near-level = <220>;
       };
   };
 ...
-- 
2.23.0

