Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:50104 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616AbcE3Nu4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 May 2016 09:50:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Ioana Ciornei <ciorneiioana@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: fix ad7606_spi regression
Date: Mon, 30 May 2016 15:50:24 +0200
Message-Id: <1464616249-3523805-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As pointed out by Geert Uytterhoeven, the patch was incorrect
and breaks the driver, which was fortunately pointed out by
this gcc warning:

drivers/staging/iio/adc/ad7606_spi.c: In function ‘ad7606_spi_read_block’:
drivers/staging/iio/adc/ad7606_spi.c:34: warning: ‘data’ is used uninitialized in this function

The effect of the patch is that the data is copied into
a random memory location (from the uninitialized pointer)
instead of being byteswapped in place.

This adds the initialization for the 'data' variable back
to restore the original behavior.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Fixes: 87787e5ef727 ("Staging: iio: Fix sparse endian warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/iio/adc/ad7606_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index 825da0769936..9587fa86dc69 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -21,7 +21,7 @@ static int ad7606_spi_read_block(struct device *dev,
 {
 	struct spi_device *spi = to_spi_device(dev);
 	int i, ret;
-	unsigned short *data;
+	unsigned short *data = buf;
 	__be16 *bdata = buf;
 
 	ret = spi_read(spi, buf, count * 2);
-- 
2.7.0

