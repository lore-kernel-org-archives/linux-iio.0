Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59120 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757491Ab3B0UkK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:10 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 06/67] iio:st_sensors move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:12 +0000
Message-Id: <1361997553-31058-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Denis Ciocca <denis.ciocca@st.com>
---
 include/linux/iio/common/st_sensors.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 1f86a97..0894b3e 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -45,8 +45,8 @@
 { \
 	.type = device_type, \
 	.modified = 1, \
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-			IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
+	.info_mask_separate = IIO_CHAN_INFO_RAW | \
+			IIO_CHAN_INFO_SCALE, \
 	.scan_index = index, \
 	.channel2 = mod, \
 	.address = addr, \
-- 
1.8.1.1

