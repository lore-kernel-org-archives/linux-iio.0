Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 15/16] staging:iio:adc:ad7606 remove unused chip info elements.
Date: Fri, 23 Sep 2011 13:01:41 +0100
Message-Id: <1316779302-12357-16-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

These are now handled through the chan_spec arrays and no one
is using them anymore.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7606.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index 0d1bb26..35018c3 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -50,8 +50,6 @@ struct ad7606_platform_data {
 
 struct ad7606_chip_info {
 	const char			*name;
-	u8				bits;
-	char				sign;
 	u16				int_vref_mv;
 	struct iio_chan_spec		*channels;
 	unsigned			num_channels;
-- 
1.7.3.4
