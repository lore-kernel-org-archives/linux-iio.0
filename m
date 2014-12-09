Return-Path: <k.wrona@samsung.com>
From: Karol Wrona <k.wrona@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>,
 Karol Wrona <k.wrona@samsung.com>
Subject: [RFC PATCH 1/2] iio: kfifo: Remove unused argument in
 iio_kfifo_allocate
Date: Tue, 09 Dec 2014 20:29:44 +0100
Message-id: <1418153385-18212-2-git-send-email-k.wrona@samsung.com>
In-reply-to: <1418153385-18212-1-git-send-email-k.wrona@samsung.com>
References: <1418153385-18212-1-git-send-email-k.wrona@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

indio_dev was unused in function body plus some small style fix - add new
lines after "if(sth) return sth" and before the last return statement.

Change-Id: I9495c778dc7bc87cc4503e890397b576966c44fd
Signed-off-by: Karol Wrona <k.wrona@samsung.com>
---
 drivers/iio/kfifo_buf.c       |    4 +++-
 include/linux/iio/kfifo_buf.h |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index 7134e8a..5b5387c 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -166,19 +166,21 @@ static const struct iio_buffer_access_funcs kfifo_access_funcs = {
 	.release = &iio_kfifo_buffer_release,
 };
 
-struct iio_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev)
+struct iio_buffer *iio_kfifo_allocate(void)
 {
 	struct iio_kfifo *kf;
 
 	kf = kzalloc(sizeof *kf, GFP_KERNEL);
 	if (!kf)
 		return NULL;
+
 	kf->update_needed = true;
 	iio_buffer_init(&kf->buffer);
 	kf->buffer.attrs = &iio_kfifo_attribute_group;
 	kf->buffer.access = &kfifo_access_funcs;
 	kf->buffer.length = 2;
 	mutex_init(&kf->user_lock);
+
 	return &kf->buffer;
 }
 EXPORT_SYMBOL(iio_kfifo_allocate);
diff --git a/include/linux/iio/kfifo_buf.h b/include/linux/iio/kfifo_buf.h
index 25eeac7..1a8d57a 100644
--- a/include/linux/iio/kfifo_buf.h
+++ b/include/linux/iio/kfifo_buf.h
@@ -5,7 +5,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 
-struct iio_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev);
+struct iio_buffer *iio_kfifo_allocate(void);
 void iio_kfifo_free(struct iio_buffer *r);
 
 #endif
-- 
1.7.9.5
