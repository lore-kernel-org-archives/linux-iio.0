Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59134 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758711Ab3B0UkM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:12 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH 14/67] iio:adc:ti-adc081 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:20 +0000
Message-Id: <1361997553-31058-15-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/iio/adc/ti-adc081c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index f4a46dd..893ba16 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -55,8 +55,8 @@ static int adc081c_read_raw(struct iio_dev *iio,
 
 static const struct iio_chan_spec adc081c_channel = {
 	.type = IIO_VOLTAGE,
-	.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
-		     IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+	.info_mask_shared_by_type = IIO_CHAN_INFO_SCALE,
+	.info_mask_separate = IIO_CHAN_INFO_RAW,
 };
 
 static const struct iio_info adc081c_info = {
-- 
1.8.1.1

