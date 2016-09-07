Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v1 1/2] iio:buffer: properly handle polling of unregistered device
Date: Wed, 7 Sep 2016 19:26:04 +0200
Message-ID: <76209c68a95ae086878c35713e2ac6c2a3776f69.1473269007.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1473269007.git.gregor.boirie@parrot.com>
References: <cover.1473269007.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Using iio_device_unregister() on a device currently in use may stall
userspace process polling for data availability (poll syscall).

If device has vanished before running the iio_buffer_fileops poll hook, the
latter will return empty poll event mask. Process will be stalled waiting
for events that will never come (if no timeout specified).

This patch ensures iio_buffer_poll() returns POLLERR if device has just
been unregistered in order to properly notify userspace process something
wrong happened (such as removable device unplugged).

Fixes: 1bdc029390 ("iio: industrialio-buffer: Fix iio_buffer_poll return value")
Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/industrialio-buffer.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 90462fc..b15b3386 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -162,13 +162,20 @@ unsigned int iio_buffer_poll(struct file *filp,
 {
 	struct iio_dev *indio_dev = filp->private_data;
 	struct iio_buffer *rb = indio_dev->buffer;
+	bool rdy;
 
 	if (!indio_dev->info)
-		return 0;
+		return POLLERR;
 
 	poll_wait(filp, &rb->pollq, wait);
-	if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
+	rdy = iio_buffer_ready(indio_dev, rb, rb->watermark, 0);
+
+	if (!indio_dev->info)
+		return POLLERR;
+
+	if (rdy)
 		return POLLIN | POLLRDNORM;
+
 	return 0;
 }
 
-- 
2.1.4
