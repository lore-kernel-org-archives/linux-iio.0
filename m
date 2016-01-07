Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36447 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbcAGPWH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Jan 2016 10:22:07 -0500
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: marex@denx.de, marxin.liska@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH] iio: light: acpi-als: Report data as processed rather than raw
Date: Thu,  7 Jan 2016 16:21:45 +0100
Message-Id: <1452180105-9584-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As per the ACPI specification (Revision 5.0) [1], the data coming
from the sensor represent the ambient light illuminance reading
expressed in lux. Use IIO_CHAN_INFO_PROCESSED instead of
IIO_CHAN_INFO_RAW to signify that the data are pre-processed.

[1] http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/iio/light/acpi-als.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 60537ec..a53be07 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -54,7 +54,7 @@ static const struct iio_chan_spec acpi_als_channels[] = {
 			.realbits	= 32,
 			.storagebits	= 32,
 		},
-		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate	= BIT(IIO_CHAN_INFO_PROCESSED),
 	},
 };
 
@@ -152,7 +152,7 @@ static int acpi_als_read_raw(struct iio_dev *indio_dev,
 	s32 temp_val;
 	int ret;
 
-	if (mask != IIO_CHAN_INFO_RAW)
+	if (mask != IIO_CHAN_INFO_PROCESSED)
 		return -EINVAL;
 
 	/* we support only illumination (_ALI) so far. */
-- 
2.7.0.rc3

