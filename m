Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35730 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261Ab3CBQRf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:35 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/67] iio:adc:ad7887 move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:16:28 +0000
Message-Id: <1362241044-3534-12-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7887.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index a33d5cd..dd15a5b 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -207,8 +207,8 @@ static const struct ad7887_chip_info ad7887_chip_info_tbl[] = {
 			.type = IIO_VOLTAGE,
 			.indexed = 1,
 			.channel = 1,
-			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SHARED_BIT,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 			.address = 1,
 			.scan_index = 1,
 			.scan_type = IIO_ST('u', 12, 16, 0),
@@ -217,8 +217,8 @@ static const struct ad7887_chip_info ad7887_chip_info_tbl[] = {
 			.type = IIO_VOLTAGE,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-			IIO_CHAN_INFO_SCALE_SHARED_BIT,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 			.address = 0,
 			.scan_index = 0,
 			.scan_type = IIO_ST('u', 12, 16, 0),
-- 
1.8.1.4

