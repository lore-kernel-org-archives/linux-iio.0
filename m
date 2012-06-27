Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-130.synserver.de ([212.40.185.130]:1028 "EHLO
	smtp-out-120.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750952Ab2F0Iyn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jun 2012 04:54:43 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:ad7793: Fix scan index for the "shorted" channel
Date: Wed, 27 Jun 2012 10:58:27 +0200
Message-Id: <1340787507-9372-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The code expects the scan index to match the offset of the channel into the
channel array. For the "shorted" the offset is 3, but the scan index is set to
2. Also the scan index 2 is already taken by the previous channel. As a result
the "shorted" channel will appear to be selected if the previous channel is
selected and vice versa and it is not possible to sample the "shorted" channel
in buffered mode.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7793.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 89873f4..76fdd71 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -758,7 +758,7 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.address = AD7793_CH_AIN1M_AIN1M,
 			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 			IIO_CHAN_INFO_SCALE_SHARED_BIT,
-			.scan_index = 2,
+			.scan_index = 3,
 			.scan_type = IIO_ST('s', 24, 32, 0)
 		},
 		.channel[4] = {
@@ -831,7 +831,7 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.address = AD7793_CH_AIN1M_AIN1M,
 			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 			IIO_CHAN_INFO_SCALE_SHARED_BIT,
-			.scan_index = 2,
+			.scan_index = 3,
 			.scan_type = IIO_ST('s', 16, 32, 0)
 		},
 		.channel[4] = {
-- 
1.7.10

