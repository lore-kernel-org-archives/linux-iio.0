Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33831 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760472AbdAKKso (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jan 2017 05:48:44 -0500
Received: by mail-lf0-f41.google.com with SMTP id v186so79880931lfa.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Jan 2017 02:48:43 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: inkern: pass through raw values if no scaling
Date: Wed, 11 Jan 2017 11:48:39 +0100
Message-Id: <20170111104839.11129-1-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When a consumer calls iio_read_channel_processed() the IIO core
tries to apply scaling to the value, but if the channel only
supports reading raw values, we should return that raw value
to the cosumer instead of an error.

This is what userspace is expected to do with sensors only
providing raw values so the kernel should do the same, so as to
avoid adding scaling boilerplate to drivers for hardware that
actually return processed values from raw reads.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/inkern.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index b0f4630a163f..7a13535dc3e9 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -601,8 +601,14 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 
 	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
 					IIO_CHAN_INFO_SCALE);
-	if (scale_type < 0)
-		return scale_type;
+	if (scale_type < 0) {
+		/*
+		 * Just pass raw values as processed if no scaling is
+		 * available.
+		 */
+		*processed = raw;
+		return 0;
+	}
 
 	switch (scale_type) {
 	case IIO_VAL_INT:
-- 
2.9.3

