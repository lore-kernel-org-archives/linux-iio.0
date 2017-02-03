Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:64968 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752072AbdBCTi0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Feb 2017 14:38:26 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: handle unknow of_device_id data
Date: Fri,  3 Feb 2017 18:01:23 +0100
Message-Id: <20170203193756.3848151-1-arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If we get an unknown 'childmode' value, a number of variables are not
initialized properly:

drivers/iio/adc/rcar-gyroadc.c: In function 'rcar_gyroadc_probe':
drivers/iio/adc/rcar-gyroadc.c:390:5: error: 'num_channels' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/iio/adc/rcar-gyroadc.c:426:22: error: 'sample_width' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/iio/adc/rcar-gyroadc.c:428:23: error: 'channels' may be used uninitialized in this function [-Werror=maybe-uninitialized]

The driver is currently correct, but handling this properly is more robust
for possible modifications.

There is also a false-positive warning about adcmode being possibly uninitialized,
but that cannot happen as we also check the 'first' flag:

drivers/iio/adc/rcar-gyroadc.c:398:26: error: 'adcmode' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This adds an initialization for 'adcmode' and bails out for any unknown childmode.

Fixes: 059c53b32329 ("iio: adc: Add Renesas GyroADC driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/adc/rcar-gyroadc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index 0c44f72c32a8..331ff9a673be 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -336,7 +336,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 	struct device_node *child;
 	struct regulator *vref;
 	unsigned int reg;
-	unsigned int adcmode, childmode;
+	unsigned int adcmode = -1, childmode;
 	unsigned int sample_width;
 	unsigned int num_channels;
 	int ret, first = 1;
@@ -366,6 +366,9 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 			channels = rcar_gyroadc_iio_channels_3;
 			num_channels = ARRAY_SIZE(rcar_gyroadc_iio_channels_3);
 			break;
+		default:
+			dev_err(dev, "unknown device type");
+			return -EINVAL;
 		}
 
 		/*
-- 
2.9.0

