Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-194.synserver.de ([212.40.185.194]:1041 "EHLO
	smtp-out-194.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755233Ab3JOI2a (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2013 04:28:30 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/4] iio:kfifo: Fix memory leak
Date: Tue, 15 Oct 2013 10:30:27 +0200
Message-Id: <1381825830-25581-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We need to free the kfifo when we release the buffer, otherwise the fifos memory
will be leaked.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
New in v2

Btw. This is all against togreg, since it is probably already to late for
fixes-togreg.
---
 drivers/iio/kfifo_buf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index b4ac55a..ce51092 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -132,7 +132,10 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
 
 static void iio_kfifo_buffer_release(struct iio_buffer *buffer)
 {
-	kfree(iio_to_kfifo(buffer));
+	struct iio_kfifo *kf = iio_to_kfifo(buffer);
+
+	kfifo_free(&kf->kf);
+	kfree(kf);
 }
 
 static const struct iio_buffer_access_funcs kfifo_access_funcs = {
-- 
1.8.0

