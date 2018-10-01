Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51660 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbeJARfX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Oct 2018 13:35:23 -0400
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Joe Perches <joe@perches.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] iio: adc: Fix Renesas GyroADC MAINTAINERS entry
Date: Mon,  1 Oct 2018 12:58:04 +0200
Message-Id: <20181001105804.17802-1-marek.vasut+renesas@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix the F: entry in MAINTAINERS file, point it to the correct file.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Joe Perches <joe@perches.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1cd17e09970c..c945cacdee4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12471,7 +12471,7 @@ RENESAS R-CAR GYROADC DRIVER
 M:	Marek Vasut <marek.vasut@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-F:	drivers/iio/adc/rcar_gyro_adc.c
+F:	drivers/iio/adc/rcar-gyroadc.c
 
 RENESAS R-CAR I2C DRIVERS
 M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
-- 
2.18.0
