Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59666 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab3LKSpr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2013 13:45:47 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, o.v.kravchenko@globallogic.com,
	stigge@antcom.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 02/24] iio:imu:adis16400 fix pressure channel scan type
Date: Wed, 11 Dec 2013 18:45:20 +0000
Message-Id: <1386787542-19666-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-1-git-send-email-jic23@kernel.org>
References: <1386787542-19666-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A single channel in this driver was using the IIO_ST macro.
This does not provide a parameter for setting the endianness of
the channel.  Thus this channel will have been reported as whatever
is the native endianness of the cpu rather than big endian. This
means it would be incorrect on little endian platforms.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/imu/adis16400_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index 3fb7757a1028..368660dfe135 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -651,7 +651,12 @@ static const struct iio_chan_spec adis16448_channels[] = {
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.address = ADIS16448_BARO_OUT,
 		.scan_index = ADIS16400_SCAN_BARO,
-		.scan_type = IIO_ST('s', 16, 16, 0),
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_BE,
+		},
 	},
 	ADIS16400_TEMP_CHAN(ADIS16448_TEMP_OUT, 12),
 	IIO_CHAN_SOFT_TIMESTAMP(11)
-- 
1.8.4.2

