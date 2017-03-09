Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:59950 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754508AbdCIQU3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Mar 2017 11:20:29 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Miguel Robles <miguel.robles@farole.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: sw-device: Fix config group initialization
Date: Thu,  9 Mar 2017 17:20:04 +0100
Message-Id: <1489076404-11490-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the IS_ENABLED() helper macro to ensure that the configfs group is
initialized either when configfs is built-in or when configfs is built as a
module. Otherwise software device creation will result in undefined
behaviour when configfs is built as a mdoule since the configfs group for
the device not properly initialized.

Similar to commit b2f0c09664b7 ("iio: sw-trigger: Fix config group
initialization").

Fixes: 0f3a8c3f34f7 ("iio: Add support for creating IIO devices via configfs")
Reported-by: Miguel Robles <miguel.robles@farole.net>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/iio/sw_device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/sw_device.h b/include/linux/iio/sw_device.h
index 23ca415..fa79319 100644
--- a/include/linux/iio/sw_device.h
+++ b/include/linux/iio/sw_device.h
@@ -62,7 +62,7 @@ void iio_swd_group_init_type_name(struct iio_sw_device *d,
 				  const char *name,
 				  struct config_item_type *type)
 {
-#ifdef CONFIG_CONFIGFS_FS
+#if IS_ENABLED(CONFIG_CONFIGFS_FS)
 	config_group_init_type_name(&d->group, name, type);
 #endif
 }
-- 
2.1.4

