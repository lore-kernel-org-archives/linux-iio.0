Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 8/8] iio:magnetometer:bmc150_magn: use descriptive name for mask
Date: Fri, 17 Jul 2015 10:52:31 +0200
Message-Id: <81887eb78fef9a2a6c589cb6d4b1f5329c7149b6.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437090791.git.knaack.h@gmx.de>
References: <cover.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437090791.git.knaack.h@gmx.de>
References: <cover.1437090791.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Define and use a descriptive name for the repetition registers data mask,
instead of a 'magic' value.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/magnetometer/bmc150_magn.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index bdcf49ee75df..e8cf08ee2d15 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -85,6 +85,7 @@
 #define BMC150_MAGN_REG_HIGH_THRESH		0x50
 #define BMC150_MAGN_REG_REP_XY			0x51
 #define BMC150_MAGN_REG_REP_Z			0x52
+#define BMC150_MAGN_REG_REP_DATAMASK		GENMASK(7, 0)
 
 #define BMC150_MAGN_REG_TRIM_START		0x5D
 #define BMC150_MAGN_REG_TRIM_END		0x71
@@ -559,7 +560,7 @@ static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
 			}
 			ret = regmap_update_bits(data->regmap,
 						 BMC150_MAGN_REG_REP_XY,
-						 0xFF,
+						 BMC150_MAGN_REG_REP_DATAMASK,
 						 BMC150_MAGN_REPXY_TO_REGVAL
 						 (val));
 			mutex_unlock(&data->mutex);
@@ -575,7 +576,7 @@ static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
 			}
 			ret = regmap_update_bits(data->regmap,
 						 BMC150_MAGN_REG_REP_Z,
-						 0xFF,
+						 BMC150_MAGN_REG_REP_DATAMASK,
 						 BMC150_MAGN_REPZ_TO_REGVAL
 						 (val));
 			mutex_unlock(&data->mutex);
-- 
2.4.3
