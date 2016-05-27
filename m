Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34928 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168AbcE0Czc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 26 May 2016 22:55:32 -0400
Received: by mail-pf0-f196.google.com with SMTP id f144so4337575pfa.2
        for <linux-iio@vger.kernel.org>; Thu, 26 May 2016 19:55:32 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: humidity: hdc100x: fix IIO_TEMP channel reporting
Date: Thu, 26 May 2016 19:55:06 -0700
Message-Id: <1464317706-25569-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_TEMP channel was being incorrectly reported back as Celsius when it
should have been milliCelsius.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/humidity/hdc100x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index fa47676..7e73c56 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -211,7 +211,7 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type == IIO_TEMP) {
-			*val = 165;
+			*val = 165000;
 			*val2 = 65536 >> 2;
 			return IIO_VAL_FRACTIONAL;
 		} else {
-- 
2.7.4

