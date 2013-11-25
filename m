Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 09/15] iio:vcnl4000: Mark transfer buffer as __be16
Date: Mon, 25 Nov 2013 13:42:01 +0100
Message-Id: <1385383327-28181-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-1-git-send-email-lars@metafoo.de>
References: <1385383327-28181-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Fixes the following warnings from sparse:
	drivers/iio/light/vcnl4000.c:88:16: warning: cast to restricted __be16
	drivers/iio/light/vcnl4000.c:88:16: warning: cast to restricted __be16
	drivers/iio/light/vcnl4000.c:88:16: warning: cast to restricted __be16
	drivers/iio/light/vcnl4000.c:88:16: warning: cast to restricted __be16

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/light/vcnl4000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index ecb3341..2f2c9be 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -56,7 +56,7 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 				u8 rdy_mask, u8 data_reg, int *val)
 {
 	int tries = 20;
-	u16 buf;
+	__be16 buf;
 	int ret;
 
 	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND,
-- 
1.8.0
