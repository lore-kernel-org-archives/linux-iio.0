Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:33493 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754AbbFWSqK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 23 Jun 2015 14:46:10 -0400
From: Tomasz Duszynski <tduszyns@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	tduszyns@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: pressure: ms5611: remove IIO_CHAN_INFO_SCALE from mask
Date: Tue, 23 Jun 2015 20:45:47 +0200
Message-Id: <1435085148-12404-1-git-send-email-tduszyns@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_CHAN_INFO_SCALE is useful whenever conversion to standard units is done
in userspace. In this case conversion is handled by driver so this bit
is unnecessary.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/pressure/ms5611_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index e42c853..1109513 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -163,13 +163,11 @@ static int ms5611_read_raw(struct iio_dev *indio_dev,
 static const struct iio_chan_spec ms5611_channels[] = {
 	{
 		.type = IIO_PRESSURE,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-			BIT(IIO_CHAN_INFO_SCALE)
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
 	},
 	{
 		.type = IIO_TEMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-			BIT(IIO_CHAN_INFO_SCALE)
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
 	}
 };
 
-- 
2.4.4

