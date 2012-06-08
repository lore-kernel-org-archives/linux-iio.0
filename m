Return-Path: <dan.carpenter@oracle.com>
Date: Fri, 8 Jun 2012 09:54:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch -next] iio: frequency: ad9523: unlock on error in
 ad9523_reg_access()
Message-ID: <20120608065403.GB26673@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

There was a return path which got missed accidentally.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 7272924..832e6ab 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -731,10 +731,12 @@ static int ad9523_reg_access(struct iio_dev *indio_dev,
 	} else {
 		ret = ad9523_read(indio_dev, reg | AD9523_R1B);
 		if (ret < 0)
-			return ret;
+			goto out_unlock;
 		*readval = ret;
 		ret = 0;
 	}
+
+out_unlock:
 	mutex_unlock(&indio_dev->mlock);
 
 	return ret;
