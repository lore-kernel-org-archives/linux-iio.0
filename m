Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:49153 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992543AbbHHTRV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 15:17:21 -0400
Date: Sat, 8 Aug 2015 22:16:42 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Aybuke Ozdemir <aybuke.147@gmail.com>,
	Josselin Costanzi <josselin.costanzi@mobile-devices.fr>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	kernel-janitors@vger.kernel.org
Subject: [patch] iio: accel: sca3000: memory corruption in
 sca3000_read_first_n_hw_rb()
Message-ID: <20150808191642.GD8034@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

"num_read" is in byte units but we are write u16s so we end up write
twice as much as intended.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 23685e7..bd2c69f 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -116,7 +116,7 @@ static int sca3000_read_first_n_hw_rb(struct iio_buffer *r,
 	if (ret)
 		goto error_ret;
 
-	for (i = 0; i < num_read; i++)
+	for (i = 0; i < num_read / sizeof(u16); i++)
 		*(((u16 *)rx) + i) = be16_to_cpup((__be16 *)rx + i);
 
 	if (copy_to_user(buf, rx, num_read))
