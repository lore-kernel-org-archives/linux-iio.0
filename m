Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35690 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754099AbdCaPJF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Mar 2017 11:09:05 -0400
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: iio: light: Remove useless type conversion
Date: Fri, 31 Mar 2017 20:38:50 +0530
Message-Id: <1490972930-15476-4-git-send-email-singhalsimran0@gmail.com>
In-Reply-To: <1490972930-15476-1-git-send-email-singhalsimran0@gmail.com>
References: <1490972930-15476-1-git-send-email-singhalsimran0@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some type conversions like casting a pointer to a pointer of same type,
casting to the original type using addressof(&) operator etc. are not
needed. Therefore, remove them. Done using coccinelle:

@@
type t;
t *p;
t a;
@@
(
- (t)(a)
+ a
|
- (t *)(p)
+ p
|
- (t *)(&a)
+ &a
)

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/staging/iio/light/tsl2x7x_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index ea15bc1..0490c1d 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -624,7 +624,7 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
 	dev_info(&chip->client->dev,
 		 "%s als_calibrate completed\n", chip->client->name);
 
-	return (int)gain_trim_val;
+	return gain_trim_val;
 }
 
 static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
-- 
2.7.4

