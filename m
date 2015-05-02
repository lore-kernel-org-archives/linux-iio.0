Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58520 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbbEBLFK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 May 2015 07:05:10 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH] staging:iio:light: Add some missing brackets to make sure code works as intended. Note this is not a bug due to the fact the region cannot be reached without the sanity check passing. The autobuilder reported it as missaligned code which is kind of true as well.
Date: Sat,  2 May 2015 12:05:05 +0100
Message-Id: <1430564705-31119-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Cc: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 drivers/staging/iio/light/isl29018.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 08ca9a4172e3..e646c5d24004 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -369,12 +369,13 @@ static int isl29018_write_raw(struct iio_dev *indio_dev,
 		}
 		break;
 	case IIO_CHAN_INFO_INT_TIME:
-		if (chan->type == IIO_LIGHT)
+		if (chan->type == IIO_LIGHT) {
 			if (val != 0) {
 				mutex_unlock(&chip->lock);
 				return -EINVAL;
 			}
 			ret = isl29018_set_integration_time(chip, val2);
+		}
 		break;
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type == IIO_LIGHT)
-- 
2.3.5

