Return-Path: <vlad.dogaru@intel.com>
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org,
	knaack.h@gmx.de
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 2/2] iio: sx9500: fix bug in compensation code
Date: Tue, 30 Jun 2015 14:20:59 +0300
Message-Id: <1435663259-21998-3-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1435663259-21998-1-git-send-email-vlad.dogaru@intel.com>
References: <1435663259-21998-1-git-send-email-vlad.dogaru@intel.com>
List-ID: <linux-iio@vger.kernel.org>

The initial compensation was mistakingly toggling an extra bit in the
control register.  Fix this and make sure it's less likely to happen by
introducing an additional macro.

Reported-by: Hartmut Knaack <knaack.h@gmx.de>
Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
 drivers/iio/proximity/sx9500.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index ba1cbbe..798b973 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -80,6 +80,7 @@
 #define SX9500_COMPSTAT_MASK		GENMASK(3, 0)
 
 #define SX9500_NUM_CHANNELS		4
+#define SX9500_CHAN_MASK		GENMASK(SX9500_NUM_CHANNELS - 1, 0)
 
 struct sx9500_data {
 	struct mutex mutex;
@@ -802,8 +803,7 @@ static int sx9500_init_compensation(struct iio_dev *indio_dev)
 	unsigned int val;
 
 	ret = regmap_update_bits(data->regmap, SX9500_REG_PROX_CTRL0,
-				 GENMASK(SX9500_NUM_CHANNELS, 0),
-				 GENMASK(SX9500_NUM_CHANNELS, 0));
+				 SX9500_CHAN_MASK, SX9500_CHAN_MASK);
 	if (ret < 0)
 		return ret;
 
@@ -823,7 +823,7 @@ static int sx9500_init_compensation(struct iio_dev *indio_dev)
 
 out:
 	regmap_update_bits(data->regmap, SX9500_REG_PROX_CTRL0,
-			   GENMASK(SX9500_NUM_CHANNELS, 0), 0);
+			   SX9500_CHAN_MASK, 0);
 	return ret;
 }
 
-- 
1.9.1
