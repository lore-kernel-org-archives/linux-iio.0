Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:60801 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754494AbcLWS5w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2016 13:57:52 -0500
From: Thomas Preisner <thomas.preisner+linux@fau.de>
To: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc: linux-kernel@i4.cs.fau.de, milan.stephan+linux@fau.de,
        thomas.preisner+linux@fau.de, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Subject: [PATCH] drivers: staging: iio: cdc: fix return value
Date: Fri, 23 Dec 2016 19:51:07 +0100
Message-Id: <1482519067-5354-1-git-send-email-thomas.preisner+linux@fau.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

At the end of function ad7150_write_event_config(), "return 0" seems
improper. It may be better to return the value of ret.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=188871

Reported-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Thomas Preisner <thomas.preisner+linux@fau.de>
Signed-off-by: Milan Stephan <milan.stephan+linux@fau.de>
---
 drivers/staging/iio/cdc/ad7150.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 6998c3d..04861eb 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -274,7 +274,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
 error_ret:
 	mutex_unlock(&chip->state_lock);
 
-	return 0;
+	return ret;
 }
 
 static int ad7150_read_event_value(struct iio_dev *indio_dev,
-- 
2.7.4

