Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:58351 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755630AbcJYP5N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 11:57:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: cdc/ad7746: fix missing return value
Date: Tue, 25 Oct 2016 17:56:23 +0200
Message-Id: <20161025155646.64112-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As found by "gcc -Wmaybe-uninitialized", the latest change to the
driver lacked an initalization for the return code in one of the
added cases:

drivers/staging/iio/cdc/ad7746.c: In function ‘ad7746_read_raw’:
drivers/staging/iio/cdc/ad7746.c:655:2: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]

This sets it to IIO_VAL_INT, which I think is what we want here.

Fixes: 2296c0623eb7 ("staging: iio: cdc: ad7746: implement IIO_CHAN_INFO_SAMP_FREQ")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/iio/cdc/ad7746.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index f41251ceeacd..a5828f9aa437 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -642,6 +642,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 		case IIO_VOLTAGE:
 			*val = ad7746_vt_filter_rate_table[
 					(chip->config >> 6) & 0x3][0];
+			ret = IIO_VAL_INT;
 			break;
 		default:
 			ret = -EINVAL;
-- 
2.9.0

