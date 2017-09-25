Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34720 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934575AbdIYKkQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Sep 2017 06:40:16 -0400
From: Harinath Nampally <harinath922@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, amsfield22@gmail.com,
        martink@posteo.de
Subject: [PATCH v3 3/3] iio: accel: mma8452: Rename read/write event value callbacks to generic function name.
Date: Mon, 25 Sep 2017 06:40:08 -0400
Message-Id: <1506336008-4480-4-git-send-email-harinath922@gmail.com>
In-Reply-To: <1506336008-4480-1-git-send-email-harinath922@gmail.com>
References: <1506336008-4480-1-git-send-email-harinath922@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

'mma8452_read_thresh' and 'mma8452_write_thresh' functions
does more than just read/write threshold values.
They also handle  IIO_EV_INFO_HIGH_PASS_FILTER_3DB and
IIO_EV_INFO_PERIOD therefore renaming to generic names.

Improves code readability, no impact on functionality.

Signed-off-by: Harinath Nampally <harinath922@gmail.com>
---
 drivers/iio/accel/mma8452.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 74b6221..43c3a6b 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -792,7 +792,7 @@ static int mma8452_get_event_regs(struct mma8452_data *data,
 	}
 }
 
-static int mma8452_read_thresh(struct iio_dev *indio_dev,
+static int mma8452_read_event_value(struct iio_dev *indio_dev,
 			       const struct iio_chan_spec *chan,
 			       enum iio_event_type type,
 			       enum iio_event_direction dir,
@@ -855,7 +855,7 @@ static int mma8452_read_thresh(struct iio_dev *indio_dev,
 	}
 }
 
-static int mma8452_write_thresh(struct iio_dev *indio_dev,
+static int mma8452_write_event_value(struct iio_dev *indio_dev,
 				const struct iio_chan_spec *chan,
 				enum iio_event_type type,
 				enum iio_event_direction dir,
@@ -1391,8 +1391,8 @@ static const struct iio_info mma8452_info = {
 	.read_raw = &mma8452_read_raw,
 	.write_raw = &mma8452_write_raw,
 	.event_attrs = &mma8452_event_attribute_group,
-	.read_event_value = &mma8452_read_thresh,
-	.write_event_value = &mma8452_write_thresh,
+	.read_event_value = &mma8452_read_event_value,
+	.write_event_value = &mma8452_write_event_value,
 	.read_event_config = &mma8452_read_event_config,
 	.write_event_config = &mma8452_write_event_config,
 	.debugfs_reg_access = &mma8452_reg_access_dbg,
-- 
2.7.4

