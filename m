Return-Path: <rupran@einserver.de>
From: Andreas Ruprecht <rupran@einserver.de>
To: devel@linuxdriverproject.org
Cc: dan.carpenter@oracle.com,
	gregkh@suse.de,
	jic23@cam.ac.uk,
	linux-iio@vger.kernel.org,
	Andreas Ruprecht <rupran@einserver.de>
Subject: [PATCH 1/3] Staging: iio/accel: Changed data type in adis16220_write_16bit to u16
Date: Sun, 27 Nov 2011 23:17:40 +0100
Message-Id: <1322432262-16533-1-git-send-email-rupran@einserver.de>
In-Reply-To: <20111124205657.GL3258@mwanda>
References: <20111124205657.GL3258@mwanda>
List-ID: <linux-iio@vger.kernel.org>

In the adis16220_write_16bit() function we used a long value to store
parsed data from the char* buffer buf.
The called function to actually write the data,
adis16220_spi_write_reg_16(), takes a u16 value as a parameter, so up
to now a value larger than u16 was silently ignored as it was only
truncated when passing the parameter.
Now this function will only accept values fitting into a u16.

Additionally the parsing function was changed to overcome the now
obsolete strict_strtol() function.

Signed-off-by: Andreas Ruprecht <rupran@einserver.de>
---
 drivers/staging/iio/accel/adis16220_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 6d4503d..bb72eb3 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -167,9 +167,9 @@ static ssize_t adis16220_write_16bit(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
-	long val;
+	u16 val;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtou16(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 	ret = adis16220_spi_write_reg_16(indio_dev, this_attr->address, val);
-- 
1.7.5.4
