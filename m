Return-Path: <k.wrona@samsung.com>
From: Karol Wrona <k.wrona@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>,
 Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH v2 3/3] iio: core: Get rid of misleading comment
Date: Fri, 19 Dec 2014 18:39:26 +0100
Message-id: <1419010766-13557-4-git-send-email-k.wrona@samsung.com>
In-reply-to: <1419010766-13557-1-git-send-email-k.wrona@samsung.com>
References: <1419010766-13557-1-git-send-email-k.wrona@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

This comment did not fit here.  It explains why devm_kmalloc
uses dr_alloc.  Generally is not needed at all.

Signed-off-by: Karol Wrona <k.wrona@samsung.com>
---
 drivers/iio/industrialio-core.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index af3e76d..1d030ae 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1035,7 +1035,6 @@ struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv)
 	if (!ptr)
 		return NULL;
 
-	/* use raw alloc_dr for kmalloc caller tracing */
 	iio_dev = iio_device_alloc(sizeof_priv);
 	if (iio_dev) {
 		*ptr = iio_dev;
-- 
1.7.9.5
