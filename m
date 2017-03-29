Return-Path: <SRS0=uhZd=3H=gmail.com=sfaragnaus@kernel.org>
Date: Wed, 29 Mar 2017 09:36:24 +0100
From: Andrea della Porta <sfaragnaus@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging:iio:accel:adis16029 fixed checkpatch issue - drop
 braces around single if statement
Message-ID: <20170329083624.GA3281@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Fixed the followinf checkpatch warning:
WARNING: braces {} are not necessary for single statement blocks
#258: FILE: drivers/staging/iio/accel/adis16209.c:258:
+		if (ret) {
+			return ret;
+		}

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
