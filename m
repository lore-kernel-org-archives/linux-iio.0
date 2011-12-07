Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:kfifo_buf: Fix potential buffer overflow in iio_read_first_n_kfifo
Date: Wed, 7 Dec 2011 15:43:34 +0100
Message-ID: <1323269014-21611-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

n is the number of bytes to read, not the number of samples. So if there is
enough data available we will write to the userspace buffer beyond its bounds.
Fix this by copying n bytes maximum. Also round n down to the next multiple of
the sample size, so we will only read complete samples. If the buffer is too
small to hold at least one sample return -EINVAL.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/kfifo_buf.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
index a64ebbf..930029b 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -161,7 +161,11 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
 	int ret, copied;
 	struct iio_kfifo *kf = iio_to_kfifo(r);
 
-	ret = kfifo_to_user(&kf->kf, buf, r->bytes_per_datum*n, &copied);
+	if (n < r->bytes_per_datum)
+		return -EINVAL;
+
+	n = rounddown(n, r->bytes_per_datum);
+	ret = kfifo_to_user(&kf->kf, buf, n, &copied);
 
 	return copied;
 }
-- 
1.7.7.3
