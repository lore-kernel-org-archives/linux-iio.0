Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:32880 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756631AbcHWCpd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Aug 2016 22:45:33 -0400
From: Clifton Barnes <clifton.a.barnes@gmail.com>
To: jic23@kernel.org
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Clifton Barnes <clifton.a.barnes@gmail.com>
Subject: [PATCH] staging: iio: accel: sca3000: remove extra space
Date: Mon, 22 Aug 2016 22:45:05 -0400
Message-Id: <1471920305-9474-1-git-send-email-clifton.a.barnes@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

fix checkpatch.pl warning about 'Statements should start on a
tabstop'

Signed-off-by: Clifton Barnes <clifton.a.barnes@gmail.com>
---
 drivers/staging/iio/accel/sca3000_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index b5625f5..61f3241 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -412,7 +412,7 @@ static const struct iio_event_spec sca3000_event = {
 		},						\
 		.event_spec = &sca3000_event,			\
 		.num_event_specs = 1,				\
-	 }
+	}
 
 static const struct iio_chan_spec sca3000_channels[] = {
 	SCA3000_CHAN(0, IIO_MOD_X),
-- 
2.7.4

