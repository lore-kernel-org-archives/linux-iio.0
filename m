Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:54086 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758126Ab2DMJY0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 05:24:26 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/4] staging:iio:light:tsl2563 channel spec buglet / always reading same adc.
Date: Fri, 13 Apr 2012 10:24:18 +0100
Message-Id: <1334309061-21073-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1334309061-21073-1-git-send-email-jic23@kernel.org>
References: <1334309061-21073-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The IIO_LIGHT channel was not marked as being a processed_val despite
clearly being in lux.

The IIO_INTENSITY channel reads were dependent on channel and that isn't
specified for either adc (as they now use modifiers).  Hence use the
modifier instead.

Reported-by: Jon Brenner <jbrenner@taosinc.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/light/tsl2563.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 546c95a..beb51d7 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -465,7 +465,7 @@ static int tsl2563_write_raw(struct iio_dev *indio_dev,
 {
 	struct tsl2563_chip *chip = iio_priv(indio_dev);
 
-	if (chan->channel == 0)
+	if (chan->channel == IIO_MOD_LIGHT_BOTH)
 		chip->calib0 = calib_from_sysfs(val);
 	else
 		chip->calib1 = calib_from_sysfs(val);
@@ -534,6 +534,7 @@ static const struct iio_chan_spec tsl2563_channels[] = {
 	{
 		.type = IIO_LIGHT,
 		.indexed = 1,
+		.processed_val = 1,
 		.channel = 0,
 	}, {
 		.type = IIO_INTENSITY,
-- 
1.7.0.4

