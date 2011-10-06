Return-Path: <dan.carpenter@oracle.com>
Date: Thu, 6 Oct 2011 09:17:00 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Mike Frysinger <vapier@gentoo.org>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org
Subject: [patch] Staging: iio/adc/ad7150: release lock on error
Message-ID: <20111006061700.GC14701@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

The error_ret label should have been before the mutex_unlock().  It's
a typo.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index 8943420..d1767d8 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -332,8 +332,8 @@ static int ad7150_write_event_value(struct iio_dev *indio_dev,
 	/* write back if active */
 	ret = ad7150_write_event_params(indio_dev, event_code);
 
-	mutex_unlock(&chip->state_lock);
 error_ret:
+	mutex_unlock(&chip->state_lock);
 	return ret;
 }
 
