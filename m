Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59688 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab3LKSpt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2013 13:45:49 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, o.v.kravchenko@globallogic.com,
	stigge@antcom.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 09/24] iio:dac:ad5421 replaces IIO_ST macro with explicit entries to struct scan_type
Date: Wed, 11 Dec 2013 18:45:27 +0000
Message-Id: <1386787542-19666-10-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-1-git-send-email-jic23@kernel.org>
References: <1386787542-19666-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_ST is going away as it is a pain to maintain.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/dac/ad5421.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index 1cb15d8e94b7..904c3024c93b 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -114,7 +114,11 @@ static const struct iio_chan_spec ad5421_channels[] = {
 			BIT(IIO_CHAN_INFO_CALIBBIAS),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
 			BIT(IIO_CHAN_INFO_OFFSET),
-		.scan_type = IIO_ST('u', 16, 16, 0),
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			},
 		.event_spec = ad5421_current_event,
 		.num_event_specs = ARRAY_SIZE(ad5421_current_event),
 	},
-- 
1.8.4.2

