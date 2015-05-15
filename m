Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18442 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993097AbbEOXnV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 15 May 2015 19:43:21 -0400
From: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org, pmeerw@pmeerw.net
Cc: srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v1 1/1] iio: ltr501: Fix proximity threshold boundary check
Date: Fri, 15 May 2015 16:42:56 -0700
Message-Id: <7acfd1ed6ffbaab2f64e77ef1959c7ce86161173.1431732634.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently, proximity sensor boundary check is done
inside the switch block but outside the case
statement.Since this code will never get executed,
moved the check outside the switch case statement.

   867          case IIO_PROXIMITY:
   868                  switch (dir) {
   // Following line has been moved outside the switch block.
   869                  if (val > LTR501_PS_THRESH_MASK)
   870                          return -EINVAL;
   871                  case IIO_EV_DIR_RISING:

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index ca4bf47..417369b 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -865,9 +865,9 @@ static int ltr501_write_thresh(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_PROXIMITY:
-		switch (dir) {
 		if (val > LTR501_PS_THRESH_MASK)
 			return -EINVAL;
+		switch (dir) {
 		case IIO_EV_DIR_RISING:
 			mutex_lock(&data->lock_ps);
 			ret = regmap_bulk_write(data->regmap,
-- 
1.9.1

