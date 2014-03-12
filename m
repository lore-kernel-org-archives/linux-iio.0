Return-Path: <beomho.seo@samsung.com>
Message-id: <531FB0F4.9010400@samsung.com>
Date: Wed, 12 Mar 2014 09:57:24 +0900
From: Beomho Seo <beomho.seo@samsung.com>
MIME-version: 1.0
To: linux-iio@vger.kernel.org, Kevin Tsai <ktsai@capellamicro.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Myungjoo Ham <myungjoo.ham@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, wingt@capellamicro.com,
 josephh@capellamicro.com
Subject: [PATCH] iio: cm32181: Fix read integration time function
Content-type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

In read integration time function, assign 0 to val.
Because, prevent return inaccurate value when call read integration time.

Cc: Kevin Tsai <ktsai@capellamicro.com>
Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/iio/light/cm32181.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 47a6dba..d976e6c 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -221,6 +221,7 @@ static int cm32181_read_raw(struct iio_dev *indio_dev,
 		*val = cm32181->calibscale;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_INT_TIME:
+		*val = 0;
 		ret = cm32181_read_als_it(cm32181, val2);
 		return ret;
 	}
-- 
1.7.9.5

-- 
Best Regards,
