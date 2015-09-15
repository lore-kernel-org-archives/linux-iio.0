Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:33736 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbbIOHtf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2015 03:49:35 -0400
Received: by lamp12 with SMTP id p12so100598797lam.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2015 00:49:33 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [RESEND PATCH 2/4] iio: percolate error if event fd fails
Date: Tue, 15 Sep 2015 09:49:25 +0200
Message-Id: <1442303365-11811-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This makes the error from iio_event_getfd() percolate up
to userspace properly so we can know for sure there is no
events on this device (-ENODEV returned). Before this patch
we would bail out looking for the unsupported evens on the
erroneous (negative) file descriptor.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/industrialio-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index b3fcc2c449d8..b347524d1b6d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1153,6 +1153,8 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	if (cmd == IIO_GET_EVENT_FD_IOCTL) {
 		fd = iio_event_getfd(indio_dev);
+		if (fd < 0)
+			return fd;
 		if (copy_to_user(ip, &fd, sizeof(fd)))
 			return -EFAULT;
 		return 0;
-- 
2.4.3

