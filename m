Return-Path: <rupran@einserver.de>
From: Andreas Ruprecht <rupran@einserver.de>
To: devel@linuxdriverproject.org
Cc: gregkh@suse.de,
	jic23@cam.ac.uk,
	linux-iio@vger.kernel.org,
	Andreas Ruprecht <rupran@einserver.de>
Subject: [PATCH 2/2] Staging: iio/accel: Added a range check for val in store_measurement_mode()
Date: Fri,  2 Dec 2011 17:30:23 +0100
Message-Id: <1322843423-18178-2-git-send-email-rupran@einserver.de>
In-Reply-To: <1322843423-18178-1-git-send-email-rupran@einserver.de>
References: <4ED7EE04.3010308@kernel.org>
 <1322843423-18178-1-git-send-email-rupran@einserver.de>
List-ID: <linux-iio@vger.kernel.org>

In sca3000_store_measurement_mode() we use val to and it with a mask.
This mask is only two bits long (as we are only interested in the
lowest two bits), so a value bigger than 3 was silently ignored so
far.

Now this function will return -EINVAL, if val is bigger than 3.

Signed-off-by: Andreas Ruprecht <rupran@einserver.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/sca3000_core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index a33e742..052005c 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -388,6 +388,10 @@ sca3000_store_measurement_mode(struct device *dev,
 	ret = kstrtou8(buf, 10, &val);
 	if (ret)
 		goto error_ret;
+	if (val > 3) {
+		ret = -EINVAL;
+		goto error_ret;
+	}
 	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
 	if (ret)
 		goto error_ret;
-- 
1.7.5.4
