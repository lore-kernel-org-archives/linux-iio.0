Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:57884 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803AbaAJVhY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 10 Jan 2014 16:37:24 -0500
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Kravchenko Oleksandr <x0199363@ti.com>
Subject: [PATCH 2/2] iio:accel:bma180: Make LOW_PASS_FILTER_3DB_FREQUENCY shared_by_type
Date: Fri, 10 Jan 2014 22:37:21 +0100
Message-Id: <1389389841-7389-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389389841-7389-1-git-send-email-pmeerw@pmeerw.net>
References: <1389389841-7389-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

the property is not per-channel, but shared by type

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Kravchenko Oleksandr <x0199363@ti.com>
---
 drivers/iio/accel/bma180.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index bfec313..a7e68c8 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -451,9 +451,9 @@ static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##_axis,					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
 	.scan_index = AXIS_##_axis,					\
 	.scan_type = {							\
 		.sign = 's',						\
-- 
1.8.3.2

