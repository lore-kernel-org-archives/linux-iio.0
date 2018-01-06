Return-Path: <SRS0=fQ2w=EB=tobin.cc=me@kernel.org>
From: "Tobin C. Harding" <me@tobin.cc>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] iio: add field identifier for @use_count kernel-doc
Date: Sun,  7 Jan 2018 08:56:06 +1100
Message-Id: <1515275766-31302-3-git-send-email-me@tobin.cc>
In-Reply-To: <1515275766-31302-1-git-send-email-me@tobin.cc>
References: <1515275766-31302-1-git-send-email-me@tobin.cc>
List-ID: <linux-iio@vger.kernel.org>

Kernel-doc for @use_count does not currently have a field identifier.
All the rest of the fields do. @use_count is used internally and should
not be accessed directly by the driver so it should be marked as so.

Add [INTERN] identifier to @use_count field.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 include/linux/iio/trigger.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 390789d43369..b19b7204ef84 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -49,7 +49,7 @@ struct iio_trigger_ops {
  * @dev:		[DRIVER] associated device (if relevant)
  * @list:		[INTERN] used in maintenance of global trigger list
  * @alloc_list:		[DRIVER] used for driver specific trigger list
- * @use_count:		use count for the trigger
+ * @use_count:		[INTERN] use count for the trigger.
  * @subirq_chip:	[INTERN] associate 'virtual' irq chip.
  * @subirq_base:	[INTERN] base number for irqs provided by trigger.
  * @subirqs:		[INTERN] information about the 'child' irqs.
-- 
2.7.4
