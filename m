Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50753 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751062AbdE1Ja4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 May 2017 05:30:56 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] iio: use proper name for the R-Car SoC
Date: Sun, 28 May 2017 11:30:46 +0200
Message-Id: <20170528093051.11816-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20170528093051.11816-1-wsa+renesas@sang-engineering.com>
References: <20170528093051.11816-1-wsa+renesas@sang-engineering.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

It is 'R-Car', not 'RCar'. No code or binding changes, only descriptive text.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
I suggest this trivial patch should be picked individually per susbsystem.

 Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
index f5b0adae6010a0..b1fea95ff516d6 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
@@ -1,4 +1,4 @@
-* Renesas RCar GyroADC device driver
+* Renesas R-Car GyroADC device driver
 
 The GyroADC block is a reduced SPI block with up to 8 chipselect lines,
 which supports the SPI protocol of a selected few SPI ADCs. The SPI ADCs
-- 
2.11.0

