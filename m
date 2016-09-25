Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:33834 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937926AbcIYLlJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Sep 2016 07:41:09 -0400
From: Brian Masney <masneyb@onstation.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 2/3] staging: iio: isl29018: made error handling consistent
Date: Sun, 25 Sep 2016 07:41:06 -0400
Message-Id: <1474803667-21776-2-git-send-email-masneyb@onstation.org>
In-Reply-To: <1474803667-21776-1-git-send-email-masneyb@onstation.org>
References: <1474803667-21776-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changed the processing of IIO_CHAN_INFO_INT_TIME in isl29018_write_raw()
to unlock the mutex and return at the end of the function if invalid
input is passed in. This makes the error handling code consistent with
the processing of IIO_CHAN_INFO_CALIBSCALE and IIO_CHAN_INFO_SCALE
within the same function.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29018.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index ad282f1..0a35588 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -364,13 +364,8 @@ static int isl29018_write_raw(struct iio_dev *indio_dev,
 		}
 		break;
 	case IIO_CHAN_INFO_INT_TIME:
-		if (chan->type == IIO_LIGHT) {
-			if (val) {
-				mutex_unlock(&chip->lock);
-				return -EINVAL;
-			}
+		if (chan->type == IIO_LIGHT && !val)
 			ret = isl29018_set_integration_time(chip, val2);
-		}
 		break;
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type == IIO_LIGHT)
-- 
2.7.4

