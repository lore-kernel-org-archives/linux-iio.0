Return-Path: <dan.carpenter@oracle.com>
Date: Fri, 8 Jun 2012 09:54:32 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch 1/2 -next] iio: frequency: adf4350: using an uninitialized
 variable
Message-ID: <20120608065432.GC26673@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

GCC complains that we use an uninitialized variable if the user passes
an invalid parameter to adf4350_read().  I decided that we should return
-EINVAL instead in that case.

However, when I looked up at adf4350_write() it returned -ENODEV for
that condition.  In the end, I decided the -EINVAL was the right thing
and I change adf4350_write() to match.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index fd4c850..4729bba 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -272,7 +272,7 @@ static ssize_t adf4350_write(struct iio_dev *indio_dev,
 		adf4350_sync_config(st);
 		break;
 	default:
-		ret = -ENODEV;
+		ret = -EINVAL;
 	}
 	mutex_unlock(&indio_dev->mlock);
 
@@ -310,6 +310,8 @@ static ssize_t adf4350_read(struct iio_dev *indio_dev,
 	case ADF4350_PWRDOWN:
 		val = !!(st->regs[ADF4350_REG2] & ADF4350_REG2_POWER_DOWN_EN);
 		break;
+	default:
+		ret = -EINVAL;
 	}
 	mutex_unlock(&indio_dev->mlock);
 
