Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35758 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbdC1MCf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Mar 2017 08:02:35 -0400
Date: Tue, 28 Mar 2017 13:01:48 +0100
From: Andrea della Porta <sfaragnaus@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coding style issue resolved
Message-ID: <20170328120148.GA2332@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Coding style issue resolved.

Signed-off-by: Andrea della Porta <sfaragnaus@gmail.com>
---
 drivers/staging/iio/accel/adis16209.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index 52fa2e0..159a687 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -255,9 +255,9 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 		}
 		addr = adis16209_addresses[chan->scan_index][0];
 		ret = adis_read_reg_16(st, addr, &val16);
-		if (ret) {
+		if (ret)
 			return ret;
-		}
+
 		val16 &= (1 << bits) - 1;
 		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
 		*val = val16;
-- 
2.4.10

