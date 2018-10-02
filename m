Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33189 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJBHkt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Oct 2018 03:40:49 -0400
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Joe Perches <joe@perches.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V2] iio: adc: Fix Renesas GyroADC MAINTAINERS entry
Date: Tue,  2 Oct 2018 03:00:13 +0200
Message-Id: <20181002010013.8765-1-marek.vasut+renesas@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix the F: entry in MAINTAINERS file, point it to the correct file.
While at it, add DT binding doc F: entry too.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Joe Perches <joe@perches.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
V2: Add DT binding doc F: entry
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1cd17e09970c..3f0abbfe1dd2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12471,7 +12471,8 @@ RENESAS R-CAR GYROADC DRIVER
 M:	Marek Vasut <marek.vasut@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-F:	drivers/iio/adc/rcar_gyro_adc.c
+F:	Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
+F:	drivers/iio/adc/rcar-gyroadc.c
 
 RENESAS R-CAR I2C DRIVERS
 M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
-- 
2.18.0
