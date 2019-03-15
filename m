Return-Path: <SRS0=RKAC=RS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8456C43381
	for <linux-iio@archiver.kernel.org>; Fri, 15 Mar 2019 10:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C192184C
	for <linux-iio@archiver.kernel.org>; Fri, 15 Mar 2019 10:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfCOKB6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:01:58 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60159 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbfCOKB6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Mar 2019 06:01:58 -0400
X-Originating-IP: 109.213.80.250
Received: from localhost (alyon-652-1-57-250.w109-213.abo.wanadoo.fr [109.213.80.250])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 0596340028;
        Fri, 15 Mar 2019 10:01:53 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 4/4] dt-bindings: iio: adc: lpc32xx-adc: Document vref-supply
Date:   Fri, 15 Mar 2019 10:52:31 +0100
Message-Id: <20190315095231.17001-5-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315095231.17001-1-gregory.clement@bootlin.com>
References: <20190315095231.17001-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As most of the other ADC the lpc32xx one use a vref-supply property:
document it.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt b/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt
index b3629d3a9adf..3a1bc669bd51 100644
--- a/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.txt
@@ -6,6 +6,10 @@ Required properties:
   region.
 - interrupts: The ADC interrupt
 
+Optional:
+ - vref-supply: The regulator supply ADC reference voltage, optional
+   for legacy reason, but highly encouraging to us in new device tree
+
 Example:
 
 	adc@40048000 {
@@ -13,4 +17,5 @@ Example:
 		reg = <0x40048000 0x1000>;
 		interrupt-parent = <&mic>;
 		interrupts = <39 0>;
+		vref-supply = <&vcc>;
 	};
-- 
2.20.1

