Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59139 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759275Ab3B0UkR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:40:17 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 32/67] iio:freq:ad9523 move to info_mask_(shared_by_type/separate)
Date: Wed, 27 Feb 2013 20:38:38 +0000
Message-Id: <1361997553-31058-33-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-1-git-send-email-jic23@kernel.org>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/frequency/ad9523.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 1ea132e..542da7d 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -920,10 +920,10 @@ static int ad9523_setup(struct iio_dev *indio_dev)
 			st->ad9523_channels[i].channel = chan->channel_num;
 			st->ad9523_channels[i].extend_name =
 				chan->extended_name;
-			st->ad9523_channels[i].info_mask =
-				IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-				IIO_CHAN_INFO_PHASE_SEPARATE_BIT |
-				IIO_CHAN_INFO_FREQUENCY_SEPARATE_BIT;
+			st->ad9523_channels[i].info_mask_separate =
+				IIO_CHAN_INFO_RAW |
+				IIO_CHAN_INFO_PHASE |
+				IIO_CHAN_INFO_FREQUENCY;
 		}
 	}
 
-- 
1.8.1.1

