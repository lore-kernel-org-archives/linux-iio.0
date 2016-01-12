Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35514 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbcALPV5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jan 2016 10:21:57 -0500
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de,
	marxin.liska@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v2] iio: light: acpi-als: Report data as processed
Date: Tue, 12 Jan 2016 16:21:39 +0100
Message-Id: <1452612099-26630-1-git-send-email-gabriele.mzt@gmail.com>
In-Reply-To: <1452180105-9584-1-git-send-email-gabriele.mzt@gmail.com>
References: <1452180105-9584-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As per the ACPI specification (Revision 5.0) [1], the data coming
from the sensor represent the ambient light illuminance reading
expressed in lux. So use IIO_CHAN_INFO_PROCESSED to signify that
the data are pre-processed.

However, to keep backward ABI compatibility, the IIO_CHAN_INFO_RAW
bit is not removed.

[1] http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/iio/light/acpi-als.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 60537ec..53201d9 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -54,7 +54,9 @@ static const struct iio_chan_spec acpi_als_channels[] = {
 			.realbits	= 32,
 			.storagebits	= 32,
 		},
-		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW),
+		/* _RAW is here for backward ABI compatibility */
+		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
+					  BIT(IIO_CHAN_INFO_PROCESSED),
 	},
 };
 
@@ -152,7 +154,7 @@ static int acpi_als_read_raw(struct iio_dev *indio_dev,
 	s32 temp_val;
 	int ret;
 
-	if (mask != IIO_CHAN_INFO_RAW)
+	if ((mask != IIO_CHAN_INFO_PROCESSED) && (mask != IIO_CHAN_INFO_RAW))
 		return -EINVAL;
 
 	/* we support only illumination (_ALI) so far. */
-- 
2.7.0.rc3

