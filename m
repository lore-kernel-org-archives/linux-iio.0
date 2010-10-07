Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com
CC: linux-iio@vger.kernel.org, drivers@analog.com, jic23@cam.ac.uk,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] staging: iio: iio_ring_rip_outer return immediately if rip_lots returns <= 0
Date: Thu, 7 Oct 2010 13:27:37 +0200
Message-ID: <1286450857-13254-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/industrialio-ring.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index edcf6be..d393ace 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -105,7 +105,7 @@ static ssize_t iio_ring_rip_outer(struct file *filp, char __user *buf,
 		return -EINVAL;
 	copied = rb->access.rip_lots(rb, count, &data, &dead_offset);
 
-	if (copied < 0) {
+	if (copied <= 0) {
 		ret = copied;
 		goto error_ret;
 	}
-- 
1.6.0.2
