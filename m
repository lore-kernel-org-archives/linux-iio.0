Return-Path: <SRS0=oN4t=AO=canonical.com=colin.king@kernel.org>
From: Colin King <colin.king@canonical.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: ade7759: fix signed extension bug on shift of a u8
Date: Wed, 13 Sep 2017 18:02:02 +0100
Message-Id: <20170913170202.8029-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The current shift of st->rx[2] left shifts a u8 24 bits left,
promotes the integer to a an int and then to a unsigned u64. If
the top bit of st->rx[2] is set then we end up with all the upper
bits being set to 1. Fix this by casting st->rx[2] to a u64 before
the 24 bit left shift.

Detected by CoverityScan CID#144940 ("Unintended sign extension")

Fixes: 2919fa54ef64 ("staging: iio: meter: new driver for ADE7759 devices")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/iio/meter/ade7759.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 1691760339da..02573c517d9d 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -172,7 +172,7 @@ static int ade7759_spi_read_reg_40(struct device *dev,
 				reg_address);
 		goto error_ret;
 	}
-	*val = ((u64)st->rx[1] << 32) | (st->rx[2] << 24) |
+	*val = ((u64)st->rx[1] << 32) | ((u64)st->rx[2] << 24) |
 		(st->rx[3] << 16) | (st->rx[4] << 8) | st->rx[5];
 
 error_ret:
-- 
2.14.1
