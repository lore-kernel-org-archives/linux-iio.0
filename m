Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-124.synserver.de ([212.40.185.124]:1045 "EHLO
	smtp-out-124.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756642Ab2JROmG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Oct 2012 10:42:06 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] iio: Don't compare boolean values to true/false
Date: Thu, 18 Oct 2012 16:43:18 +0200
Message-Id: <1350571399-17723-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1350571399-17723-1-git-send-email-lars@metafoo.de>
References: <1350571399-17723-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes the following warnings from coccicheck:
	drivers/iio/inkern.c:81:6-14: WARNING: Comparison to bool
	drivers/iio/dac/ad5686.c:191:5-11: WARNING: Comparison to bool

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5686.c |    2 +-
 drivers/iio/inkern.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 6948d75..bc92ff9 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -188,7 +188,7 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	if (readin == true)
+	if (readin)
 		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
 	else
 		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index f2b78d4..5230a33 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -78,7 +78,7 @@ int iio_map_array_unregister(struct iio_dev *indio_dev,
 				found_it = true;
 				break;
 			}
-		if (found_it == false) {
+		if (!found_it) {
 			ret = -ENODEV;
 			goto error_ret;
 		}
-- 
1.7.10.4

