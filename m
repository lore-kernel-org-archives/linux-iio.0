Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Matt Ranostay <mranostay@gmail.com>,
	george.mccollister@gmail.com
Subject: [PATCH 3/3] iio: proximity: as3935: fix buffer stack trashing
Date: Sat, 21 May 2016 20:01:03 -0700
Message-Id: <1463886063-20004-4-git-send-email-mranostay@gmail.com>
In-Reply-To: <1463886063-20004-1-git-send-email-mranostay@gmail.com>
References: <1463886063-20004-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Buffer wasn't of a valid size to allow the timestamp, and correct padding.
This patchset also moves the buffer off the stack, and onto the heap.

Cc: george.mccollister@gmail.com
Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/proximity/as3935.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index 6aed024..8730451 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -64,6 +64,7 @@ struct as3935_state {
 	struct delayed_work work;
 
 	u32 tune_cap;
+	u8 buffer[16]; /* 8-bit data + 54-bit padding + 64-bit timestamp */
 	u8 buf[2] ____cacheline_aligned;
 };
 
@@ -212,9 +213,10 @@ static irqreturn_t as3935_trigger_handler(int irq, void *private)
 	ret = as3935_read(st, AS3935_DATA, &val);
 	if (ret)
 		goto err_read;
-	val &= AS3935_DATA_MASK;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &val, pf->timestamp);
+	st->buffer[0] = val & AS3935_DATA_MASK;
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
+					   pf->timestamp);
 err_read:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.7.4
