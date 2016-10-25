Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:42788 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753069AbcJYSov (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 14:44:51 -0400
From: Colin King <colin.king@canonical.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: cdc: ad7746: set ret on IIO_VOLTAGE case
Date: Tue, 25 Oct 2016 19:44:40 +0100
Message-Id: <20161025184440.4274-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

For a IIO_VOLTAGE case, ret is not being set causing an
uninitialized value being returned by ad7746_read_raw. Fix
this by setting ret to IIO_VAL_INT for this specific case.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/iio/cdc/ad7746.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index f41251c..a5828f9 100644
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
2.9.3

