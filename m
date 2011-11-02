Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Michael Hennerich
	<michael.hennerich@analog.com>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] staging:iio: Make write_event_value callback optional
Date: Wed, 2 Nov 2011 09:40:00 +0100
Message-ID: <1320223202-26219-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Some devices have fixed thresholds which can not be modified so make the
write_event_value callback optional, so the drivers for these devices do not
have to implement a boilerplate no-op callback.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index cfa4fcb..d2eea07 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -782,6 +782,9 @@ static ssize_t iio_ev_value_store(struct device *dev,
 	unsigned long val;
 	int ret;
 
+	if (!indio_dev->info->write_event_value)
+		return -EINVAL;
+
 	ret = strict_strtoul(buf, 10, &val);
 	if (ret)
 		return ret;
-- 
1.7.7
