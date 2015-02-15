Return-Path: <tolga.ceylan@gmail.com>
From: Tolga Ceylan <tolga.ceylan@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	tolga.ceylan@gmail.com
Subject: [PATCH 2/3] Staging: iio: meter: ade7854-i2c: code style improvements
Date: Sat, 14 Feb 2015 20:32:44 -0800
Message-Id: <1423974765-1782-2-git-send-email-tolga.ceylan@gmail.com>
In-Reply-To: <1423974765-1782-1-git-send-email-tolga.ceylan@gmail.com>
References: <1423974765-1782-1-git-send-email-tolga.ceylan@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Code reformatting based on checkpatch.pl with --strict:
Lines over 80 characters were fixed

Signed-off-by: Tolga Ceylan <tolga.ceylan@gmail.com>
---
 drivers/staging/iio/meter/ade7854-i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 85a7e84..5e6fbe4 100644
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
