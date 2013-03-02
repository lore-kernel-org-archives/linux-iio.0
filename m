Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35725 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab3CBQRi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:38 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 26/67] iio:dac:ad5686 move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:16:43 +0000
Message-Id: <1362241044-3534-27-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5686.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 5e554af..06439b1 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -276,9 +276,9 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
 		.indexed = 1,					\
 		.output = 1,					\
 		.channel = chan,				\
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |	\
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,			\
-		.address = AD5686_ADDR_DAC(chan),			\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
+		.address = AD5686_ADDR_DAC(chan),		\
 		.scan_type = IIO_ST('u', bits, 16, shift),	\
 		.ext_info = ad5686_ext_info,			\
 }
-- 
1.8.1.4

