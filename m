Return-Path: <dan.carpenter@oracle.com>
Date: Thu, 6 Oct 2011 09:15:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Bryan Freed <bfreed@chromium.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org
Subject: [patch 1/2] Staging: iio/light/tsl2563: unlock on an error path
Message-ID: <20111006061503.GA14701@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

We need to unlock here before returning.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 3707772..8977f58 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -518,7 +518,8 @@ static int tsl2563_read_raw(struct iio_dev *indio_dev,
 		ret = IIO_VAL_INT;
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		goto error_ret;
 	}
 
 error_ret:
