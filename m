Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH] iio:light:ltr501 bug in parameter sanity check.
Date: Sat,  2 May 2015 11:25:48 +0100
Message-Id: <1430562348-27802-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Clearly the intent was to error if the value was not 0 or 1.
As implemented we have (A != 0 || A != 1) which is always true
as A is never both 0 and 1 at the same time.

As the autobuilder suggested, && makes more sense for this error
check.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Daniel Baluta <daniel.baluta@intel.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
This is obvious enough that I'll probably apply it shortly whether or
not I get Acks.  However, Acks always good!

drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index ca4bf470a332..280eff19b872 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -976,7 +976,7 @@ static int ltr501_write_event_config(struct iio_dev *indio_dev,
 	int ret;
 
 	/* only 1 and 0 are valid inputs */
-	if (state != 1  || state != 0)
+	if (state != 1  && state != 0)
 		return -EINVAL;
 
 	switch (chan->type) {
-- 
2.3.5
