Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from m50-135.163.com ([123.125.50.135]:49922 "EHLO m50-135.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753488AbcLCOlw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Dec 2016 09:41:52 -0500
From: Pan Bian <bianpan201602@163.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH 1/1] staging: iio: cdc: fix improper return value
Date: Sat,  3 Dec 2016 21:44:30 +0800
Message-Id: <1480772670-6898-1-git-send-email-bianpan201602@163.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

At the end of function ad7150_write_event_config(), directly returns 0.
As a result, the errors will be ignored by the callers. It may be better 
to return variable "ret".

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/staging/iio/cdc/ad7150.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 5578a07..50a5b0c2 100644
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
1.9.1


