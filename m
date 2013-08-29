Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ye0-f202.google.com ([209.85.213.202]:40839 "EHLO
	mail-ye0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab3H2UOO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2013 16:14:14 -0400
Received: by mail-ye0-f202.google.com with SMTP id r9so81638yen.1
        for <linux-iio@vger.kernel.org>; Thu, 29 Aug 2013 13:14:14 -0700 (PDT)
From: Derek Basehore <dbasehore@chromium.org>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bill Pemberton <wfp5p@virginia.edu>,
	Bryan Freed <bfreed@chromium.org>,
	Derek Basehore <dbasehore@chromium.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: isl29018: Fix uninitialized value
Date: Thu, 29 Aug 2013 13:14:10 -0700
Message-Id: <1377807250-30150-1-git-send-email-dbasehore@chromium.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The lux_uscale value is not initialized at probe. The value will be
uninitialized unless a value is written to it through the iio channel interface.
This fixes that.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
Reviewed-on: https://gerrit.chromium.org/gerrit/65998
---
 drivers/staging/iio/light/isl29018.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 82478a5..28c6386 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -564,6 +564,7 @@ static int isl29018_probe(struct i2c_client *client,
 	mutex_init(&chip->lock);
 
 	chip->lux_scale = 1;
+	chip->lux_uscale = 0;
 	chip->range = 1000;
 	chip->adc_bit = 16;
 	chip->suspended = false;
-- 
1.8.4

