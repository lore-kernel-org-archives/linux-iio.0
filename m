Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 6/8] iio:magnetometer:bmc150_magn: protect runtime_resume with mutex
Date: Fri, 17 Jul 2015 10:52:29 +0200
Message-Id: <d6c36de684250b41333124b476b0d29bab00b22a.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437090791.git.knaack.h@gmx.de>
References: <cover.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437090791.git.knaack.h@gmx.de>
References: <cover.1437090791.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Protect bmc150_magn_runtime_resume() with a mutex, as done with other
suspend/resume functions.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/magnetometer/bmc150_magn.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index e1f804b2b244..ac0cdbde813b 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -1052,9 +1052,14 @@ static int bmc150_magn_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
+	int ret;
 
-	return bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
-					  true);
+	mutex_lock(&data->mutex);
+	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
+					 true);
+	mutex_unlock(&data->mutex);
+
+	return ret;
 }
 #endif
 
-- 
2.4.3
