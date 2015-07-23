Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 2/2] iio: magn: bmc150_magn: do not set power state twice when setting trigger state
Date: Thu, 23 Jul 2015 20:15:02 +0300
Message-Id: <1437671702-20994-3-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1437671702-20994-1-git-send-email-irina.tirdea@intel.com>
References: <1437671702-20994-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

When setting the trigger state, the device power state is set through
buffer preenable and postdisable hooks. There is no need
to also set it in the trigger set state call.

Remove duplicate set power state from the trigger set
state call.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index d66f8cf..38c2eb64 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -783,29 +783,23 @@ static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	if (state == data->dready_trigger_on)
 		goto err_unlock;
 
-	ret = bmc150_magn_set_power_state(data, state);
-	if (ret < 0)
-		goto err_unlock;
-
 	ret = regmap_update_bits(data->regmap, BMC150_MAGN_REG_INT_DRDY,
 				 BMC150_MAGN_MASK_DRDY_EN,
 				 state << BMC150_MAGN_SHIFT_DRDY_EN);
 	if (ret < 0)
-		goto err_poweroff;
+		goto err_unlock;
 
 	data->dready_trigger_on = state;
 
 	if (state) {
 		ret = bmc150_magn_reset_intr(data);
 		if (ret < 0)
-			goto err_poweroff;
+			goto err_unlock;
 	}
 	mutex_unlock(&data->mutex);
 
 	return 0;
 
-err_poweroff:
-	bmc150_magn_set_power_state(data, false);
 err_unlock:
 	mutex_unlock(&data->mutex);
 	return ret;
-- 
1.9.1
