Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36160 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbbEBMb1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 May 2015 08:31:27 -0400
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH] iio: kfifo: Set update_needed to false only if a buffer was allocated
Date: Sat,  2 May 2015 14:31:16 +0200
Message-Id: <1430569876-31428-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Check whether the allocation of a new kfifo buffer failed or not before
setting the update_needed flag to false. This will make
iio_request_update_kfifo() try to allocate a new buffer the next time a
buffer update is requested.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/iio/kfifo_buf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index 847ca56..55c267b 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -38,7 +38,8 @@ static int iio_request_update_kfifo(struct iio_buffer *r)
 		kfifo_free(&buf->kf);
 		ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
 				   buf->buffer.length);
-		buf->update_needed = false;
+		if (ret >= 0)
+			buf->update_needed = false;
 	} else {
 		kfifo_reset_out(&buf->kf);
 	}
-- 
2.1.4

