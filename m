Return-Path: <SRS0=Nd8U=FQ=linux.intel.com=andriy.shevchenko@kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] iio: accel: bmc150: Remove redundant __func__ in dev_dbg()
Date: Thu, 22 Feb 2018 20:58:58 +0200
Message-Id: <20180222185858.28714-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Dynamic debug has a run time knob to enable function name printing.
Remove this from dev_dbg() calls.

Furthermore, functional tracing when enabled can show what function is
called, therefore remove empty dev_dbg() calls.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 870f92ef61c2..208f2d9f0e8a 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -336,8 +336,7 @@ static int bmc150_accel_update_slope(struct bmc150_accel_data *data)
 		return ret;
 	}
 
-	dev_dbg(dev, "%s: %x %x\n", __func__, data->slope_thres,
-		data->slope_dur);
+	dev_dbg(dev, "%x %x\n", data->slope_thres, data->slope_dur);
 
 	return ret;
 }
@@ -1716,7 +1715,6 @@ static int bmc150_accel_runtime_suspend(struct device *dev)
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	int ret;
 
-	dev_dbg(dev,  __func__);
 	ret = bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_SUSPEND, 0);
 	if (ret < 0)
 		return -EAGAIN;
@@ -1731,8 +1729,6 @@ static int bmc150_accel_runtime_resume(struct device *dev)
 	int ret;
 	int sleep_val;
 
-	dev_dbg(dev,  __func__);
-
 	ret = bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
 	if (ret < 0)
 		return ret;
-- 
2.16.1
