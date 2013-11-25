Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/15] staging:iio:ad7746: Mark transfer buffer as __be32
Date: Mon, 25 Nov 2013 13:42:04 +0100
Message-Id: <1385383327-28181-12-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-1-git-send-email-lars@metafoo.de>
References: <1385383327-28181-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Fixes the following warnings from sparse:
	drivers/staging/iio/cdc/ad7746.c:599:25: warning: cast to restricted __be32
	drivers/staging/iio/cdc/ad7746.c:599:25: warning: cast to restricted __be32
	drivers/staging/iio/cdc/ad7746.c:599:25: warning: cast to restricted __be32
	drivers/staging/iio/cdc/ad7746.c:599:25: warning: cast to restricted __be32
	drivers/staging/iio/cdc/ad7746.c:599:25: warning: cast to restricted __be32
	drivers/staging/iio/cdc/ad7746.c:599:25: warning: cast to restricted __be32

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/cdc/ad7746.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 862d68d..01e15e2 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -567,7 +567,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 	u8 regval, reg;
 
 	union {
-		u32 d32;
+		__be32 d32;
 		u8 d8[4];
 	} data;
 
-- 
1.8.0
