Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: [PATCH 2/3] iio:accel:bmc150-accel: make use of mask definition
Date: Mon, 15 Jun 2015 23:48:25 +0200
Message-Id: <a9a11f217224e458d8ffb2741b27f1ad92db1870.1434404216.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434404216.git.knaack.h@gmx.de>
References: <cover.1434404216.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434404216.git.knaack.h@gmx.de>
References: <cover.1434404216.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

BMC150_ACCEL_SLOPE_THRES_MASK was defined some time ago, but its 'magic'
value got used instead in bmc150_accel_write_event(). Make use of it for
improved readability.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/bmc150-accel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index cc5a357..36a9cd5 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -776,7 +776,7 @@ static int bmc150_accel_write_event(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
-		data->slope_thres = val & 0xFF;
+		data->slope_thres = val & BMC150_ACCEL_SLOPE_THRES_MASK;
 		break;
 	case IIO_EV_INFO_PERIOD:
 		data->slope_dur = val & BMC150_ACCEL_SLOPE_DUR_MASK;
-- 
2.3.6
