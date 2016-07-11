Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: sw-trigger: Fix config group initialization
Date: Mon, 11 Jul 2016 13:55:44 +0200
Message-Id: <1468238144-30654-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Use the IS_ENABLED() helper macro to ensure that the configfs group is
initialized either when configfs is built-in or when configfs is built as a
module. Otherwise software trigger creation will result in undefined
behaviour when configfs is built as a mdoule since the configfs group for
the trigger is not properly initialized.

Fixes: b662f809d410 ("iio: core: Introduce IIO software triggers")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Appologies if you received this twice, forgot the list on the first try.
---
 include/linux/iio/sw_trigger.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/sw_trigger.h b/include/linux/iio/sw_trigger.h
index 5198f8e..c97eab6 100644
--- a/include/linux/iio/sw_trigger.h
+++ b/include/linux/iio/sw_trigger.h
@@ -62,7 +62,7 @@ void iio_swt_group_init_type_name(struct iio_sw_trigger *t,
 				  const char *name,
 				  struct config_item_type *type)
 {
-#ifdef CONFIG_CONFIGFS_FS
+#if IS_ENABLED(CONFIG_CONFIGFS_FS)
 	config_group_init_type_name(&t->group, name, type);
 #endif
 }
-- 
2.1.4
