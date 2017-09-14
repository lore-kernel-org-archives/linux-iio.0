Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-cys01nam02on0044.outbound.protection.outlook.com ([104.47.37.44]:2400
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751133AbdINNuq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 Sep 2017 09:50:46 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH] staging: iio: ad7192: Use the dedicated reset function
Date: Thu, 14 Sep 2017 16:50:28 +0300
Message-ID: <1505397028-15461-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

SPI host drivers can use DMA to transfer data, so the buffer should be properly allocated.
Keeping it on the stack could cause an undefined behavior.

The dedicated reset function solves this issue.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/staging/iio/adc/ad7192.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index d11c6de..6150d27 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -223,11 +223,9 @@ static int ad7192_setup(struct ad7192_state *st,
 	struct iio_dev *indio_dev = spi_get_drvdata(st->sd.spi);
 	unsigned long long scale_uv;
 	int i, ret, id;
-	u8 ones[6];
 
 	/* reset the serial interface */
-	memset(&ones, 0xFF, 6);
-	ret = spi_write(st->sd.spi, &ones, 6);
+	ret = ad_sd_reset(&st->sd, 48);
 	if (ret < 0)
 		goto out;
 	usleep_range(500, 1000); /* Wait for at least 500us */
-- 
2.7.4

