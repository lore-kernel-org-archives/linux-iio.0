Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] iio: light: hid-sensor-prox: Fix modifier
Date: Tue, 14 Apr 2015 14:53:22 -0700
Message-Id: <1429048402-5311-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Currently in_proximity_(null)_raw is getting presented as raw sysfs
attribute. Same with the scan_elements.
The modifier doesn't apply to this channel.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/light/hid-sensor-prox.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 91ecc46..dc618b4 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -43,8 +43,6 @@ struct prox_state {
 static const struct iio_chan_spec prox_channels[] = {
 	{
 		.type = IIO_PROXIMITY,
-		.modified = 1,
-		.channel2 = IIO_NO_MOD,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		BIT(IIO_CHAN_INFO_SCALE) |
-- 
2.1.0
