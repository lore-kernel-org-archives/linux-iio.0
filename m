Return-Path: <SRS0=vKzs=5K=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D59CC43331
	for <linux-iio@archiver.kernel.org>; Wed, 25 Mar 2020 11:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBD420714
	for <linux-iio@archiver.kernel.org>; Wed, 25 Mar 2020 11:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgCYLJO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:09:14 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:37636 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgCYLJO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 25 Mar 2020 07:09:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 356F7FB07;
        Wed, 25 Mar 2020 12:09:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3ofBYs3GjJsl; Wed, 25 Mar 2020 12:09:08 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 623B0401F4; Wed, 25 Mar 2020 12:09:08 +0100 (CET)
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
Subject: [PATCH v3 2/4] dt-bindings: iio: light: vcnl4000: Add near-level
Date:   Wed, 25 Mar 2020 12:09:06 +0100
Message-Id: <f0ad40351d7ab12f79d2c29f738443514ae0fb76.1585134362.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1585134362.git.agx@sigxcpu.org>
References: <cover.1585134362.git.agx@sigxcpu.org>
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
 .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
index 21ef2eb7a205..ac9e3bb6a505 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
@@ -25,6 +25,13 @@ properties:
   reg:
     maxItems: 1
 
+  near-level:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Raw proximity values equal or above this level should be
+      considered 'near' to the device (an object is near to the
+      sensor).
+
 required:
   - compatible
   - reg
@@ -40,6 +47,7 @@ examples:
       light-sensor@51 {
               compatible = "vishay,vcnl4200";
               reg = <0x51>;
+              near-level = <220>;
       };
   };
 ...
-- 
2.23.0

