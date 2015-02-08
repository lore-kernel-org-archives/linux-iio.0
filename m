Return-Path: <tolga.ceylan@gmail.com>
From: Tolga Ceylan <tolga.ceylan@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org ,
	devel@driverdev.osuosl.org ,
	linux-kernel@vger.kernel.org
Cc: tolga.ceylan@gmail.com
Subject: [PATCH 1/1] Staging: iio: Coding style correction
Date: Sat,  7 Feb 2015 23:40:33 -0800
Message-Id: <1423381233-11810-1-git-send-email-tolga.ceylan@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Line over 80 characters corrected

Signed-off-by: Tolga Ceylan <tolga.ceylan@gmail.com>
---
 drivers/staging/iio/meter/ade7854-i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 5b33c7f..5d0671a 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -195,7 +195,8 @@ static int ade7854_i2c_read_reg_32(struct device *dev,
 	if (ret)
 		goto out;
 
-	*val = (st->rx[0] << 24) | (st->rx[1] << 16) | (st->rx[2] << 8) | st->rx[3];
+	*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
+		(st->rx[2] << 8) | st->rx[3];
 out:
 	mutex_unlock(&st->buf_lock);
 	return ret;
-- 
2.3.0
