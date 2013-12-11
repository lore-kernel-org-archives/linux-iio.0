Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59693 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab3LKSpv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2013 13:45:51 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, o.v.kravchenko@globallogic.com,
	stigge@antcom.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 18/24] iio:dac:max517 drop specification of scan type as unused in this driver.
Date: Wed, 11 Dec 2013 18:45:36 +0000
Message-Id: <1386787542-19666-19-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-1-git-send-email-jic23@kernel.org>
References: <1386787542-19666-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_ST is going away as it is a pain to maintain so the simplest path with
this driver is to not specify the unused scan type.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/dac/max517.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index 6e1903537950..de76e6a34c1e 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -146,7 +146,6 @@ static const struct iio_info max517_info = {
 	.channel = (chan),				\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
 	BIT(IIO_CHAN_INFO_SCALE),			\
-	.scan_type = IIO_ST('u', 8, 8, 0),		\
 }
 
 static const struct iio_chan_spec max517_channels[] = {
-- 
1.8.4.2

