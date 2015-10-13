Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 2/6] iio:iio_buffer_init(): Only set watermark if not already set
Date: Tue, 13 Oct 2015 18:10:25 +0200
Message-Id: <1444752629-3532-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1444752629-3532-1-git-send-email-lars@metafoo.de>
References: <1444752629-3532-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Only initialize the watermark field if it is still 0. This allows drivers
to provide a custom default watermark value. E.g. some driver might have a
fixed watermark or can only support watermarks within a certain range and
the initial value for the watermark should be within this range.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 7340922..5f2c8c8 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -193,7 +193,8 @@ void iio_buffer_init(struct iio_buffer *buffer)
 	INIT_LIST_HEAD(&buffer->buffer_list);
 	init_waitqueue_head(&buffer->pollq);
 	kref_init(&buffer->ref);
-	buffer->watermark = 1;
+	if (!buffer->watermark)
+		buffer->watermark = 1;
 }
 EXPORT_SYMBOL(iio_buffer_init);
 
-- 
2.1.4
