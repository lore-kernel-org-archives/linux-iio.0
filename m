Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Fugang Duan <B38611@freescale.com>
Subject: [PATCH] iio:adc:vf610 ensure correct handing of interruption of wait for completion
Date: Sat,  1 Mar 2014 22:02:47 +0000
Message-Id: <1393711367-2210-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Issue highlighted by smatch warning:

CHECK   drivers/iio/adc/vf610_adc.c
drivers/iio/adc/vf610_adc.c:466 vf610_read_raw() warn: unsigned 'ret' is never less than zero.

As wait_for_completion_interruptible_timeout can return -ERESTARTSTSYS, if
interrupted, ret must be signed.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Fugang Duan <B38611@freescale.com>
---
 drivers/iio/adc/vf610_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 37f542e..44799eb5 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -447,7 +447,7 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
 {
 	struct vf610_adc *info = iio_priv(indio_dev);
 	unsigned int hc_cfg;
-	unsigned long ret;
+	long ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-- 
1.9.0
