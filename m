Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60208 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932485AbcFAPzd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 1 Jun 2016 11:55:33 -0400
From: Luis de Bethencourt <luisbg@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [PATCH] staging: iio: ad5933: fix handling of settling time cycles
Date: Wed,  1 Jun 2016 16:55:25 +0100
Message-Id: <1464796525-9030-1-git-send-email-luisbg@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Correctly handle the settling time cycles value. The else branch was an
impossible condition (> 1022 in the else branch of > 511) and the handling
of the values was dividing by 2 and 4, with a left shift, instead of
multiplying.

Based on the Table 13 at the bottom of Page 25 of the Data Sheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5933.pdf

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---

Hi,

I decided to use the hexadecimal values instead of (1 << 10) and (1 << 9), for
briefness, I could resend using those instead if it is prefered.

I also decided to use multiplications instead of right-shifts for readability.
I could use change that as well.

Thanks,
Luis

 drivers/staging/iio/impedance-analyzer/ad5933.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 9f43976..3a2cf8f3 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -444,10 +444,13 @@ static ssize_t ad5933_store(struct device *dev,
 		st->settling_cycles = val;
 
 		/* 2x, 4x handling, see datasheet */
-		if (val > 511)
-			val = (val >> 1) | (1 << 9);
-		else if (val > 1022)
-			val = (val >> 2) | (3 << 9);
+		if (val & 0x400 && val & 0x200) {
+			val &= 0x1ff;
+			val *= 4;
+		} else if (val & 0x200) {
+			val &= 0x1ff;
+			val *= 2;
+		}
 
 		dat = cpu_to_be16(val);
 		ret = ad5933_i2c_write(st->client,
-- 
2.5.1

