Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54718 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbdJKOGB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Oct 2017 10:06:01 -0400
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] iio: sw_device: make the function argument as const
Date: Wed, 11 Oct 2017 16:05:47 +0200
Message-Id: <1507730747-13462-1-git-send-email-bhumirks@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a follow-up patch for:
https://patchwork.kernel.org/patch/9999649/

Make the argument of the function iio_swd_group_init_type_name const as
it is only passed to the function config_group_init_type_name having the
argument as const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
This change allows a lot of config_item_type structures to be const.

 include/linux/iio/sw_device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/sw_device.h b/include/linux/iio/sw_device.h
index fa79319..8642b91 100644
--- a/include/linux/iio/sw_device.h
+++ b/include/linux/iio/sw_device.h
@@ -60,7 +60,7 @@ struct iio_sw_device *to_iio_sw_device(struct config_item *item)
 static inline
 void iio_swd_group_init_type_name(struct iio_sw_device *d,
 				  const char *name,
-				  struct config_item_type *type)
+				  const struct config_item_type *type)
 {
 #if IS_ENABLED(CONFIG_CONFIGFS_FS)
 	config_group_init_type_name(&d->group, name, type);
-- 
1.9.1

