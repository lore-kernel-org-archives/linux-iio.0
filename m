Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:56471 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbcIVJpC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2016 05:45:02 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ioana Ciornei <ciorneiioana@gmail.com>,
        Ico Doornekamp <ico@pruts.nl>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: sca3000_core: avoid potentially uninitialized variable
Date: Thu, 22 Sep 2016 11:43:42 +0200
Message-Id: <20160922094432.2230485-1-arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The newly added __sca3000_get_base_freq function handles all valid
modes of the SCA3000_REG_ADDR_MODE register, but gcc notices
that any other value (i.e. 0x00) causes the base_freq variable to
not get initialized:

drivers/staging/iio/accel/sca3000_core.c: In function 'sca3000_write_raw':
drivers/staging/iio/accel/sca3000_core.c:527:23: error: 'base_freq' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This adds explicit error handling for unexpected register values,
to ensure this cannot happen.

Fixes: e0f3fc9b47e6 ("iio: accel: sca3000_core: implemented IIO_CHAN_INFO_SAMP_FREQ")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/iio/accel/sca3000_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index d626125d7af9..564b36d4f648 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -468,6 +468,8 @@ static inline int __sca3000_get_base_freq(struct sca3000_state *st,
 	case SCA3000_MEAS_MODE_OP_2:
 		*base_freq = info->option_mode_2_freq;
 		break;
+	default:
+		ret = -EINVAL;
 	}
 error_ret:
 	return ret;
-- 
2.9.0

