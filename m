Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:48265 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136Ab3GGUYW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 7 Jul 2013 16:24:22 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 4/5] iio staging: fix lis3l02dq, read error handling
Date: Sun,  7 Jul 2013 22:24:05 +0200
Message-Id: <1373228646-5356-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1373228646-5356-1-git-send-email-pmeerw@pmeerw.net>
References: <1373228646-5356-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/accel/lis3l02dq_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 1bfe5d8..8ed75a9 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -257,6 +257,8 @@ static int lis3l02dq_read_raw(struct iio_dev *indio_dev,
 			ret = lis3l02dq_read_reg_s16(indio_dev, reg, val);
 		}
 		mutex_unlock(&indio_dev->mlock);
+		if (ret < 0)
+			goto error_ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-- 
1.8.3.2

