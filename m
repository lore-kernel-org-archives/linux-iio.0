Return-Path: <sangjung.woo@samsung.com>
From: Sangjung Woo <sangjung.woo@samsung.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sangjung Woo <sangjung.woo@samsung.com>
Subject: [PATCH] staging:iio: fix wrong usage of dev_set_name()
Date: Thu, 03 Oct 2013 23:57:21 +0900
Message-id: <1380812241-11589-1-git-send-email-sangjung.woo@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

The second parameter of dev_set_name() is format string. In order to
avoid any potential accidents such as segmentation fault, basic format
parameter "%s" should be used in this case.

Signed-off-by: Sangjung Woo <sangjung.woo@samsung.com>
---
 drivers/staging/iio/iio_dummy_evgen.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/iio_dummy_evgen.c b/drivers/staging/iio/iio_dummy_evgen.c
index 132d278..2c06d16 100644
--- a/drivers/staging/iio/iio_dummy_evgen.c
+++ b/drivers/staging/iio/iio_dummy_evgen.c
@@ -205,7 +205,7 @@ static __init int iio_dummy_evgen_init(void)
 	if (ret < 0)
 		return ret;
 	device_initialize(&iio_evgen_dev);
-	dev_set_name(&iio_evgen_dev, "iio_evgen");
+	dev_set_name(&iio_evgen_dev, "%s", "iio_evgen");
 	return device_add(&iio_evgen_dev);
 }
 module_init(iio_dummy_evgen_init);
-- 
1.7.9.5
