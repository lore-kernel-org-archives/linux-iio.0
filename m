Return-Path: <SRS0=R23/=RZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55A8C43381
	for <linux-iio@archiver.kernel.org>; Fri, 22 Mar 2019 11:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE3B21925
	for <linux-iio@archiver.kernel.org>; Fri, 22 Mar 2019 11:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfCVLL3 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:11:29 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:39057 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfCVLL3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Mar 2019 07:11:29 -0400
X-Originating-IP: 109.213.38.144
Received: from localhost (alyon-652-1-47-144.w109-213.abo.wanadoo.fr [109.213.38.144])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 0894640014;
        Fri, 22 Mar 2019 11:11:24 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: Add bindings for TI ADS8344 A/DC chips
Date:   Fri, 22 Mar 2019 12:11:07 +0100
Message-Id: <20190322111108.19383-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322111108.19383-1-gregory.clement@bootlin.com>
References: <20190322111108.19383-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds device tree bindings for the TI ADS8344 A/DC chips.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../bindings/iio/adc/ti-ads8344.txt           | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt b/Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt
new file mode 100644
index 000000000000..e47c3759a82b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt
@@ -0,0 +1,19 @@
+* Texas Instruments ADS8344 A/DC chip
+
+Required properties:
+ - compatible: Must be "ti,ads8344"
+ - reg: SPI chip select number for the device
+ - vref-supply: phandle to a regulator node that supplies the
+   reference voltage
+
+Recommended properties:
+ - spi-max-frequency: Definition as per
+		Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Example:
+adc@0 {
+	compatible = "ti,ads8344";
+	reg = <0>;
+	vref-supply = <&refin_supply>;
+	spi-max-frequency = <10000000>;
+};
-- 
2.20.1

