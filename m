Return-Path: <rupran@einserver.de>
From: Andreas Ruprecht <rupran@einserver.de>
To: devel@linuxdriverproject.org
Cc: dan.carpenter@oracle.com,
	gregkh@suse.de,
	jic23@cam.ac.uk,
	linux-iio@vger.kernel.org,
	Andreas Ruprecht <rupran@einserver.de>
Subject: [PATCH 2/3] Staging: iio/accel: Changed data type for val to unsigned long in write_frequency
Date: Sun, 27 Nov 2011 23:17:41 +0100
Message-Id: <1322432262-16533-2-git-send-email-rupran@einserver.de>
In-Reply-To: <1322432262-16533-1-git-send-email-rupran@einserver.de>
References: <20111124205657.GL3258@mwanda>
 <1322432262-16533-1-git-send-email-rupran@einserver.de>
List-ID: <linux-iio@vger.kernel.org>

In lis3102dq_write_frequency() we used a long variable to store the
value parsed from the char* buffer buf, as there only was a
strict_strtol() function to parse values.
Now we have got kstrto* which allows us to convert to the right data
type in most cases.

In this particular function we want to write a frequency value, and it
doesn't make sense to allow negative values here (as Dan Carpenter
pointed out in a previous email).
This means we can now parse the value into an unsigned long and get an
error for invalid (e.g. negative) values.

Signed-off-by: Andreas Ruprecht <rupran@einserver.de>
---
 drivers/staging/iio/accel/lis3l02dq_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 559545a..5566809 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -331,11 +331,11 @@ static ssize_t lis3l02dq_write_frequency(struct device *dev,
 					 size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	long val;
+	unsigned long val;
 	int ret;
 	u8 t;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtoul(buf, 10, &val);
 	if (ret)
 		return ret;
 
-- 
1.7.5.4
