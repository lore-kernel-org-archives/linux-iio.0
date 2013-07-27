Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:60598 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752084Ab3G0PcE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 27 Jul 2013 11:32:04 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Shubhrajyoti Datta <shubhrajyoti@ti.com>
Subject: [PATCH 4/9] staging:iio:hmc5843: 'add' is a poor abbreviation for address
Date: Sat, 27 Jul 2013 17:31:47 +0200
Message-Id: <1374939112-18237-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net>
References: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 79117ad..465dc2a 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -556,14 +556,14 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-#define HMC5843_CHANNEL(axis, add)					\
+#define HMC5843_CHANNEL(axis, addr)					\
 	{								\
 		.type = IIO_MAGN,					\
 		.modified = 1,						\
 		.channel2 = IIO_MOD_##axis,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
-		.address = add						\
+		.address = addr						\
 	}
 
 static const struct iio_chan_spec hmc5843_channels[] = {
-- 
1.8.3.4

