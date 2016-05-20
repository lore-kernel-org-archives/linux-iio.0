Return-Path: <leonard.crestez@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH] max44000: Remove scale from proximity
Date: Fri, 20 May 2016 17:44:36 +0300
Message-Id: <ecdf6ef45b5010c079dd7a2876204c20dcc4bfb7.1463755473.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This is not implemented and doesn't really make sense because IIO
proximity is unit-less.

Remove IIO_CHAN_INFO_SCALE from info_mask because so that the _scale
sysfs entry won't appear. This fixes userspace tools like generic_buffer
which abort when reads returns an error.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/light/max44000.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index e01e58a..f17cb2e 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -147,7 +147,6 @@ static const struct iio_chan_spec max44000_channels[] = {
 	{
 		.type = IIO_PROXIMITY,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 		.scan_index = MAX44000_SCAN_INDEX_PRX,
 		.scan_type = {
 			.sign		= 'u',
-- 
2.5.5
