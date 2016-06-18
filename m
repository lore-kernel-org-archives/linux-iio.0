Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.polytechnique.org ([129.104.30.34]:44387 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbcFRVVB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2016 17:21:01 -0400
From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: [PATCH 1/1] staging: iio: initialize data pointer before using it
Date: Sat, 18 Jun 2016 23:12:24 +0200
Message-Id: <20160618211224.23183-1-nicolas.iooss_linux@m4x.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

ad7606_spi_read_block() reads SPI big-endian data into a buffer which is
then converted to CPU byte-order with a second variable.  This variable,
data, has been left unitialized after commit 87787e5ef727 ("Staging:
iio: Fix sparse endian warning").

Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Fixes: 87787e5ef727 ("Staging: iio: Fix sparse endian warning")
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
2.8.3

