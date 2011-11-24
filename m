Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail2.unitix.de ([176.9.2.175]:35343 "EHLO mail2.unitix.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271Ab1KXVby (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 24 Nov 2011 16:31:54 -0500
From: Arnd Hannemann <arnd@arndnet.de>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH] staging: iio: fix compile error
Date: Thu, 24 Nov 2011 22:25:50 +0100
Message-Id: <1322169950-21630-1-git-send-email-arnd@arndnet.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Commit b46413367961c2e8bd827e067a231be982aaeee2 introduced the following compile error:

  CC      drivers/staging/iio/industrialio-core.o
linux-2.6/drivers/staging/iio/industrialio-core.c: In function 'iio_event_getfd':
linux-2.6/drivers/staging/iio/industrialio-core.c:262:32: error: 'ev_int' undeclared (first use in this function)
linux-2.6/drivers/staging/iio/industrialio-core.c:262:32: note: each undeclared identifier is reported only once for each function it appears in

This patch fixes that.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 drivers/staging/iio/industrialio-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 2656409..a5b4a1f 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -243,6 +243,7 @@ static const struct file_operations iio_event_chrdev_fileops = {
 static int iio_event_getfd(struct iio_dev *indio_dev)
 {
 	int fd;
+	struct iio_event_interface *ev_int = indio_dev->event_interface;
 
 	if (indio_dev->event_interface == NULL)
 		return -ENODEV;
-- 
1.7.5.4

