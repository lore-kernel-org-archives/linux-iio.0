Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 1/2] iio: magn: bmc150_magn: add locking comment for runtime resume
Date: Thu, 23 Jul 2015 20:15:01 +0300
Message-Id: <1437671702-20994-2-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1437671702-20994-1-git-send-email-irina.tirdea@intel.com>
References: <1437671702-20994-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Runtime resume function is called with the data->mutex lock held.
Add a comment to indicate this.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 074a99d..d66f8cf 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -1043,6 +1043,9 @@ static int bmc150_magn_runtime_suspend(struct device *dev)
 	return 0;
 }
 
+/*
+ * Should be called with data->mutex held.
+ */
 static int bmc150_magn_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
-- 
1.9.1
