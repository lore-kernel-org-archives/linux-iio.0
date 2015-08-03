Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35502 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbbHCKBl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2015 06:01:41 -0400
Date: Mon, 3 Aug 2015 13:00:47 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH] iio: event: Remove negative error code from iio_event_poll
Message-ID: <3a7c7c8ea195b6bb8b6972a22a487d870b2faec0.1438595639.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Negative return values are not supported by iio_event_poll since
its return type is unsigned int.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 drivers/iio/industrialio-event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index b2f63f9..eb44dab 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -80,7 +80,7 @@ EXPORT_SYMBOL(iio_push_event);
  * @wait:	Poll table pointer to add the wait queue on
  *
  * Return: (POLLIN | POLLRDNORM) if data is available for reading
- *	   or a negative error code on failure
+ *	   or 0 on failure
  */
 static unsigned int iio_event_poll(struct file *filep,
 			     struct poll_table_struct *wait)
@@ -90,7 +90,7 @@ static unsigned int iio_event_poll(struct file *filep,
 	unsigned int events = 0;
 
 	if (!indio_dev->info)
-		return -ENODEV;
+		return events;
 
 	poll_wait(filep, &ev_int->wait, wait);
 
-- 
1.9.1

