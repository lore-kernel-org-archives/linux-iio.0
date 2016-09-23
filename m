Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34228 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761563AbcIWTU3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Sep 2016 15:20:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id 21so5664535pfy.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Sep 2016 12:20:29 -0700 (PDT)
Date: Sat, 24 Sep 2016 00:50:22 +0530
From: Sandhya Bankar <bankarsandhya512@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: [PATCH] drivers: iio: dac: Fix sparse warning
Message-ID: <20160923192022.GA10786@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixing below warnings:

drivers/iio/dac/ad5592r.c:58:41: warning: incorrect type in argument 2 (different base types)
drivers/iio/dac/ad5592r.c:58:41:    expected unsigned short [usertype] *buf
drivers/iio/dac/ad5592r.c:58:41:    got restricted __be16 *<noident>
drivers/iio/dac/ad5592r.c:62:41: warning: incorrect type in argument 2 (different base types)
drivers/iio/dac/ad5592r.c:62:41:    expected unsigned short [usertype] *buf
drivers/iio/dac/ad5592r.c:62:41:    got restricted __be16 *<noident>
drivers/iio/dac/ad5592r.c:92:41: warning: incorrect type in argument 2 (different base types)
drivers/iio/dac/ad5592r.c:92:41:    expected unsigned short [usertype] *buf
drivers/iio/dac/ad5592r.c:92:41:    got restricted __be16 *<noident>
drivers/iio/dac/ad5592r.c:110:41: warning: incorrect type in argument 2 (different base types)
drivers/iio/dac/ad5592r.c:110:41:    expected unsigned short [usertype] *buf
drivers/iio/dac/ad5592r.c:110:41:    got restricted __be16 *<noident>

Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
---
 drivers/iio/dac/ad5592r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5592r.c b/drivers/iio/dac/ad5592r.c
index 0b235a2..6eed5b7 100644
--- a/drivers/iio/dac/ad5592r.c
+++ b/drivers/iio/dac/ad5592r.c
@@ -17,7 +17,7 @@
 #define AD5592R_GPIO_READBACK_EN	BIT(10)
 #define AD5592R_LDAC_READBACK_EN	BIT(6)
 
-static int ad5592r_spi_wnop_r16(struct ad5592r_state *st, u16 *buf)
+static int ad5592r_spi_wnop_r16(struct ad5592r_state *st, __be16 *buf)
 {
 	struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
 	struct spi_transfer t = {
-- 
1.8.3.1

