Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59134 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758894Ab3B0UkN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:13 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 18/67] iio:dac:ad5064 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:24 +0000
Message-Id: <1361997553-31058-19-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5064.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index 2fe1d4e..76e0836 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -297,8 +297,8 @@ static const struct iio_chan_spec_ext_info ad5064_ext_info[] = {
 	.indexed = 1,						\
 	.output = 1,						\
 	.channel = (chan),					\
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |		\
-	IIO_CHAN_INFO_SCALE_SEPARATE_BIT,			\
+	.info_mask_separate = IIO_CHAN_INFO_RAW |		\
+	IIO_CHAN_INFO_SCALE,					\
 	.address = AD5064_ADDR_DAC(chan),			\
 	.scan_type = IIO_ST('u', (bits), 16, 20 - (bits)),	\
 	.ext_info = ad5064_ext_info,				\
-- 
1.8.1.1

