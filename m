Return-Path: <SRS0=YhDW=3S=gmail.com=pushkar.iit@kernel.org>
From: Pushkar Jambhlekar <pushkar.iit@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Pushkar Jambhlekar <pushkar.iit@gmail.com>
Subject: [PATCH] drivers/staging/iio: braces {} are not necessary for single statement blocks
Date: Mon, 10 Apr 2017 10:08:07 +0530
Message-Id: <1491799087-2742-1-git-send-email-pushkar.iit@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Handling checkpatch.pl warning for if block. For single if statement block, braces are not neccessary. Making code consistent with linux kernel coding guidelines.

Signed-off-by: Pushkar Jambhlekar <pushkar.iit@gmail.com>
---
 drivers/staging/iio/accel/adis16203.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index faa2869..401386a 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -205,9 +205,9 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 		bits = 14;
 		addr = adis16203_addresses[chan->scan_index];
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
2.7.4
