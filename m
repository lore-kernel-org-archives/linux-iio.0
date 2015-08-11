Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:35798 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933981AbbHKMeu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Aug 2015 08:34:50 -0400
Received: by lahi9 with SMTP id i9so39620709lah.2
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2015 05:34:42 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: event_monitor: report unsupported events
Date: Tue, 11 Aug 2015 14:34:38 +0200
Message-Id: <1439296478-19567-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This makes the event monitor bail out with a helpful error
message if a device does not support events, as a related
fix to iio core now makes it return -ENODEV properly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 tools/iio/iio_event_monitor.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index cd3fd41b481d..d51eb04202e9 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -284,7 +284,11 @@ int main(int argc, char **argv)
 	ret = ioctl(fd, IIO_GET_EVENT_FD_IOCTL, &event_fd);
 	if (ret == -1 || event_fd == -1) {
 		ret = -errno;
-		fprintf(stderr, "Failed to retrieve event fd\n");
+		if (ret == -ENODEV)
+			fprintf(stderr,
+				"This device does not support events\n");
+		else
+			fprintf(stderr, "Failed to retrieve event fd\n");
 		if (close(fd) == -1)
 			perror("Failed to close character device file");
 
-- 
2.4.3

