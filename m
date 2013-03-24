Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/4] staging:iio:magnetometer:ak8975 drop I2C_M_NOSTART flag in read_data
Date: Sun, 24 Mar 2013 16:58:28 +0000
Message-Id: <1364144310-32251-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1364144310-32251-1-git-send-email-jic23@kernel.org>
References: <1364144310-32251-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

This flag makes no sense whatsoever where it is.
Documentation/i2c/i2c-protocol states:

  If you set the I2C_M_NOSTART variable for the first partial message,
  we do not generate Addr, but we do generate the startbit S. This will
  probably confuse all other clients on your bus, so don't try this.

This is exactly what is going on here.  Likelihood given that the
driver never checked for this protocol mangling being available is that
it wasn't present on the test boards and hence this flag was simply
ignored.  No indication of why it would be necessary has been found in
the datasheets.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/magnetometer/ak8975.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 8726ea1..1428849 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -132,7 +132,6 @@ static int ak8975_read_data(struct i2c_client *client,
 	struct i2c_msg msg[2] = {
 		{
 			.addr = client->addr,
-			.flags = I2C_M_NOSTART,
 			.len = 1,
 			.buf = &reg,
 		}, {
-- 
1.8.1.4
