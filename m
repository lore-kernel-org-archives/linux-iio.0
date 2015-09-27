Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34687 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbbI0GTD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2015 02:19:03 -0400
Received: by padhy16 with SMTP id hy16so143936721pad.1
        for <linux-iio@vger.kernel.org>; Sat, 26 Sep 2015 23:19:02 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: hdc100x: correct IIO_CHAN_INFO_OFFSET value
Date: Sat, 26 Sep 2015 23:18:57 -0700
Message-Id: <1443334737-3772-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Previous offset wasn't applied in the correct order and invalid.
This patchset fixes this issue, and also has the correct scale value
applied to the offset.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/humidity/hdc100x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 2824578..a7f61e8 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -221,8 +221,9 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
 		}
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = -40;
-		return IIO_VAL_INT;
+		*val = -3971;
+		*val2 = 879096;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
-- 
1.9.1

