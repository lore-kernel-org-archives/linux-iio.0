Return-Path: <luisbg@osg.samsung.com>
From: Luis de Bethencourt <luisbg@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [PATCH] iio: buffer: add missing descriptions in iio_buffer_access_funcs
Date: Wed, 23 Mar 2016 12:34:41 +0000
Message-Id: <1458736481-8928-1-git-send-email-luisbg@osg.samsung.com>
List-ID: <linux-iio@vger.kernel.org>

The members buffer_group and attrs of iio_buffer_access_funcs have no
descriptions for the documentation. Adding them.

Fixes: 08e7e0adaa17 ("iio: buffer: Allocate standard attributes in the core")
Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
Hi,

I noticed these warnings when running make htmldocs:
.//include/linux/iio/buffer.h:114: warning: No description found for parameter 'buffer_group'
.//include/linux/iio/buffer.h:114: warning: No description found for parameter 'attrs'


Thanks,
Luis

 include/linux/iio/buffer.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 2ec3ad5..70a5164 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -83,10 +83,12 @@ struct iio_buffer_access_funcs {
  * @access:		[DRIVER] buffer access functions associated with the
  *			implementation.
  * @scan_el_dev_attr_list:[INTERN] list of scan element related attributes.
+ * @buffer_group:	[INTERN] attributes of the buffer group
  * @scan_el_group:	[DRIVER] attribute group for those attributes not
  *			created from the iio_chan_info array.
  * @pollq:		[INTERN] wait queue to allow for polling on the buffer.
  * @stufftoread:	[INTERN] flag to indicate new data.
+ * @attrs:		[INTERN] standard attributes of the buffer
  * @demux_list:		[INTERN] list of operations required to demux the scan.
  * @demux_bounce:	[INTERN] buffer for doing gather from incoming scan.
  * @buffer_list:	[INTERN] entry in the devices list of current buffers.
-- 
2.5.1
