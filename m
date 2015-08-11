Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:35127 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933715AbbHKJ4q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Aug 2015 05:56:46 -0400
Received: by lahi9 with SMTP id i9so37538223lah.2
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2015 02:56:44 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: percolate error if event fd fails
Date: Tue, 11 Aug 2015 11:56:40 +0200
Message-Id: <1439287000-31506-1-git-send-email-linus.walleij@linaro.org>
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
index 3524b0de8721..9492aa443a26 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1130,6 +1130,8 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	if (cmd == IIO_GET_EVENT_FD_IOCTL) {
 		fd = iio_event_getfd(indio_dev);
+		if (fd < 0)
+			return fd;
 		if (copy_to_user(ip, &fd, sizeof(fd)))
 			return -EFAULT;
 		return 0;
-- 
2.4.3

