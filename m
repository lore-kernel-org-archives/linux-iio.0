Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34580 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbbLHRqi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 8 Dec 2015 12:46:38 -0500
From: Anshul Garg <aksgarg1989@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anshul Garg <aksgarg1989@gmail.com>
Subject: [PATCH] iio/inkern.c Use list_for_each_entry_safe
Date: Tue,  8 Dec 2015 09:45:56 -0800
Message-Id: <1449596756-18133-1-git-send-email-aksgarg1989@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use list_for_each_entry_safe instead of list_for_each_safe
and list_entry call.

Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
---
 drivers/iio/inkern.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index c8bad3c..f764eb6 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -61,12 +61,10 @@ EXPORT_SYMBOL_GPL(iio_map_array_register);
 int iio_map_array_unregister(struct iio_dev *indio_dev)
 {
 	int ret = -ENODEV;
-	struct iio_map_internal *mapi;
-	struct list_head *pos, *tmp;
+	struct iio_map_internal *mapi, *next;
 
 	mutex_lock(&iio_map_list_lock);
-	list_for_each_safe(pos, tmp, &iio_map_list) {
-		mapi = list_entry(pos, struct iio_map_internal, l);
+	list_for_each_entry_safe(mapi, next, &iio_map_list, l) {
 		if (indio_dev == mapi->indio_dev) {
 			list_del(&mapi->l);
 			kfree(mapi);
-- 
1.7.9.5


---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

