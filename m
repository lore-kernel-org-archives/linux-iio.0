Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45846 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbeCHSpy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Mar 2018 13:45:54 -0500
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        garsilva@embeddedor.com, keescook@chromium.org,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] iio: potentiometer: ds1803: Remove VLA usage
Date: Fri,  9 Mar 2018 00:15:33 +0530
Message-Id: <1520534733-1743-1-git-send-email-himanshujha199640@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In preparation to enabling -Wvla, remove VLA usage and replace it
with fixed a fixed length array and therefore, prevent potential
stack overflow attacks.

Fixed as a part of the discussion to remove all VLAs from the kernel:
https://lkml.org/lkml/2018/3/7/621

Cc: keescook@chromium.org
Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/iio/potentiometer/ds1803.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index 9b0ff4a..6bf12c9 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -64,7 +64,7 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
 	struct ds1803_data *data = iio_priv(indio_dev);
 	int pot = chan->channel;
 	int ret;
-	u8 result[indio_dev->num_channels];
+	u8 result[ARRAY_SIZE(ds1803_channels)];
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-- 
2.7.4

