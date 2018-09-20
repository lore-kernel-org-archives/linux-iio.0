Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34646 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732496AbeITTZ6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Sep 2018 15:25:58 -0400
From: Song Qiang <songqiang1304521@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, shubhrajyoti@ti.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH] iio: magnetometer: hmc5843: Replace a return value.
Date: Thu, 20 Sep 2018 21:42:19 +0800
Message-Id: <20180920134219.8402-1-songqiang1304521@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This error apparently is caused by timed out event, so a -ETIMEDOUT
should be used instead of a -EIO, and it also tells user what happened
, so this dev_err may not be needed anymore.

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
---
I used ./scripts/get_maintainer.pl to get maintainers about this file,
I thought this script searches maintainers with looking up MAINTAINER,
is that right?
So I searched MAINTAINER and also found nothing related to hmc5843.
In the declearation area I can see Shubhrajyoti Datta 
<shubhrajyoti@ti.com> wroted this driver and several other people
including Peter Meerwald have contributed. Is this driver now a orphan?
Or if it is, I think we may also need to add it to the MAINTAINER file.
I'm also familiar with this device, I think I can add interrupt support
later.

 drivers/iio/magnetometer/hmc5843_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
index ada142fb7aa3..4fb393c3854c 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -170,8 +170,7 @@ static int hmc5843_wait_measurement(struct hmc5843_data *data)
 	}
 
 	if (tries < 0) {
-		dev_err(data->dev, "data not ready\n");
-		return -EIO;
+		return -ETIMEDOUT;
 	}
 
 	return 0;
-- 
2.17.1
