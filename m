Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36902 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593AbbGXNWk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2015 09:22:40 -0400
Date: Fri, 24 Jul 2015 16:21:50 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH 4/6] iio: event: Add missing fields in kernel docs
Message-ID: <a446690ea75ff4c5dd304b4bffb2200975e284cc.1437737942.git.cristina.opriceana@gmail.com>
References: <cover.1437737942.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1437737942.git.cristina.opriceana@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix kernel docs warnings by adding the missing fields,
each with its associated description.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 drivers/iio/industrialio-event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 894d813..b2f63f9 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -32,6 +32,7 @@
  * @dev_attr_list:	list of event interface sysfs attribute
  * @flags:		file operations related flags including busy flag.
  * @group:		event interface sysfs attribute group
+ * @read_lock:		lock to protect kfifo read operations
  */
 struct iio_event_interface {
 	wait_queue_head_t	wait;
@@ -75,6 +76,11 @@ EXPORT_SYMBOL(iio_push_event);
 
 /**
  * iio_event_poll() - poll the event queue to find out if it has data
+ * @filep:	File structure pointer to identify the device
+ * @wait:	Poll table pointer to add the wait queue on
+ *
+ * Return: (POLLIN | POLLRDNORM) if data is available for reading
+ *	   or a negative error code on failure
  */
 static unsigned int iio_event_poll(struct file *filep,
 			     struct poll_table_struct *wait)
-- 
1.9.1

