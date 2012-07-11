Return-Path: <dan.carpenter@oracle.com>
Date: Wed, 11 Jul 2012 09:34:43 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] iio: double unlock on error path
Message-ID: <20120711063443.GE11812@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

We should be holding the mutex when we goto error_free_chans.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index e2aded0..b5afc2f 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -198,11 +198,12 @@ struct iio_channel *iio_channel_get_all(const char *name)
 		iio_device_get(chans[mapind].indio_dev);
 		mapind++;
 	}
-	mutex_unlock(&iio_map_list_lock);
 	if (mapind == 0) {
 		ret = -ENODEV;
 		goto error_free_chans;
 	}
+	mutex_unlock(&iio_map_list_lock);
+
 	return chans;
 
 error_free_chans:
