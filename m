Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34801 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbcJAJ5m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2016 05:57:42 -0400
From: Bhumika Goyal <bhumirks@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] iio: Declare event_attrs field of iio_info structure as const
Date: Sat,  1 Oct 2016 15:27:18 +0530
Message-Id: <1475315838-15366-1-git-send-email-bhumirks@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The event_attrs field of iio_info structure is only initialized once
whenever an object of iio_info is created. After that this field
is never modified again anywhere in the kernel. So, declare event_attrs
field of iio_info as a const struct attribute_group.
Checked for occurences throughout the kernel using grep and
coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 include/linux/iio/iio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index b4a0679..4591d8e 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -381,7 +381,7 @@ struct iio_dev;
  **/
 struct iio_info {
 	struct module			*driver_module;
-	struct attribute_group		*event_attrs;
+	const struct attribute_group	*event_attrs;
 	const struct attribute_group	*attrs;
 
 	int (*read_raw)(struct iio_dev *indio_dev,
-- 
1.9.1

