Return-Path: <SRS0=WrMm=BK=gmail.com=bhumirks@kernel.org>
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] iio: sw_trigger: make the function argument as const
Date: Wed, 11 Oct 2017 18:51:35 +0200
Message-Id: <1507740695-3053-1-git-send-email-bhumirks@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This is a follow-up patch for:
https://patchwork.kernel.org/patch/9999649/

Make the argument of the function iio_swt_group_init_type_name const as
it is only passed to the function config_group_init_type_name having the
argument as const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 include/linux/iio/sw_trigger.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/sw_trigger.h b/include/linux/iio/sw_trigger.h
index c97eab6..0c43738 100644
--- a/include/linux/iio/sw_trigger.h
+++ b/include/linux/iio/sw_trigger.h
@@ -60,7 +60,7 @@ struct iio_sw_trigger *to_iio_sw_trigger(struct config_item *item)
 static inline
 void iio_swt_group_init_type_name(struct iio_sw_trigger *t,
 				  const char *name,
-				  struct config_item_type *type)
+				  const struct config_item_type *type)
 {
 #if IS_ENABLED(CONFIG_CONFIGFS_FS)
 	config_group_init_type_name(&t->group, name, type);
-- 
1.9.1
