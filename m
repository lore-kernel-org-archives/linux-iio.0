Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:54997 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755094Ab2F3Mz0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jun 2012 08:55:26 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: Fix inkern remove incorrect put of device
Date: Sat, 30 Jun 2012 13:55:23 +0100
Message-Id: <1341060923-10311-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The device_get is after this point so on error we should not be
removing it.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/inkern.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 9a46ca6..e2aded0 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -193,7 +193,6 @@ struct iio_channel *iio_channel_get_all(const char *name)
 						c->map->adc_channel_label);
 		if (chans[mapind].channel == NULL) {
 			ret = -EINVAL;
-			iio_device_put(chans[mapind].indio_dev);
 			goto error_free_chans;
 		}
 		iio_device_get(chans[mapind].indio_dev);
-- 
1.7.11.1

