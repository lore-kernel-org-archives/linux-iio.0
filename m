Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59139 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759406Ab3B0UkT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:19 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 40/67] iio:light:adjd_s311 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:46 +0000
Message-Id: <1361997553-31058-41-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/light/adjd_s311.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index d5b9d39..8b4c5d2 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -207,8 +207,8 @@ static const struct iio_chan_spec_ext_info adjd_s311_ext_info[] = {
 	.type = IIO_INTENSITY, \
 	.modified = 1, \
 	.address = (IDX_##_color), \
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-		IIO_CHAN_INFO_HARDWAREGAIN_SEPARATE_BIT, \
+	.info_mask_separate = IIO_CHAN_INFO_RAW | \
+		IIO_CHAN_INFO_HARDWAREGAIN, \
 	.channel2 = (IIO_MOD_LIGHT_##_color), \
 	.scan_index = (_scan_idx), \
 	.scan_type = IIO_ST('u', 10, 16, 0), \
-- 
1.8.1.1

