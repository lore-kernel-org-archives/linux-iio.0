Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33570 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbdIWU4h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Sep 2017 16:56:37 -0400
From: Harinath Nampally <harinath922@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, amsfield22@gmail.com,
        martink@posteo.de
Subject: [PATCH 1/2] iio: accel: mma8452: Fix code style warning 
Date: Sat, 23 Sep 2017 16:56:29 -0400
Message-Id: <1506200190-11115-2-git-send-email-harinath922@gmail.com>
In-Reply-To: <1506200190-11115-1-git-send-email-harinath922@gmail.com>
References: <1506200190-11115-1-git-send-email-harinath922@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace symbolic permissions with octal permissions
to improve code readability.

Issue found by checkpatch.

Signed-off-by: Harinath Nampally <harinath922@gmail.com>
---
 drivers/iio/accel/mma8452.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index c352555..4a33a26 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -418,11 +418,11 @@ static ssize_t mma8452_show_os_ratio_avail(struct device *dev,
 }
 
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(mma8452_show_samp_freq_avail);
-static IIO_DEVICE_ATTR(in_accel_scale_available, S_IRUGO,
+static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
 		       mma8452_show_scale_avail, NULL, 0);
 static IIO_DEVICE_ATTR(in_accel_filter_high_pass_3db_frequency_available,
-		       S_IRUGO, mma8452_show_hp_cutoff_avail, NULL, 0);
-static IIO_DEVICE_ATTR(in_accel_oversampling_ratio_available, S_IRUGO,
+		       0444, mma8452_show_hp_cutoff_avail, NULL, 0);
+static IIO_DEVICE_ATTR(in_accel_oversampling_ratio_available, 0444,
 		       mma8452_show_os_ratio_avail, NULL, 0);
 
 static int mma8452_get_samp_freq_index(struct mma8452_data *data,
-- 
2.7.4

