Return-Path: <dan.carpenter@oracle.com>
Date: Sat, 29 Oct 2011 10:21:06 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org
Subject: [patch] Staging: iio/dac/ad5360.c: signedness bug in
 ad5360_read_raw()
Message-ID: <20111029072106.GD17780@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

ad5360_get_channel_vref() returns an int and scale_uv should be the
same.  Making it unsigned here breaks the error handling.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/staging/iio/dac/ad5360.c b/drivers/staging/iio/dac/ad5360.c
index 72d0f3f..cfeea72 100644
--- a/drivers/staging/iio/dac/ad5360.c
+++ b/drivers/staging/iio/dac/ad5360.c
@@ -371,8 +371,8 @@ static int ad5360_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad5360_state *st = iio_priv(indio_dev);
-	unsigned long scale_uv;
 	unsigned int ofs_index;
+	int scale_uv;
 	int ret;
 
 	switch (m) {
