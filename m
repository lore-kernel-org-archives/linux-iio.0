Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH 4/5] iio:light:stk3310: use correct names and type for state
Date: Sat,  4 Jul 2015 17:57:00 +0200
Message-Id: <e034d85ca54ed9f46c2d494fc4af7e7e67a2ad6a.1436024257.git.knaack.h@gmx.de>
In-Reply-To: <cover.1436024257.git.knaack.h@gmx.de>
References: <cover.1436024257.git.knaack.h@gmx.de>
In-Reply-To: <cover.1436024257.git.knaack.h@gmx.de>
References: <cover.1436024257.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Indicate the bit number of predefined states, make use of these names and
change the state type in _resume to u8 to avoid type casting.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/light/stk3310.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 3650c0c..be715c7 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -35,8 +35,8 @@
 #define STK3310_REG_ID				0x3E
 #define STK3310_MAX_REG				0x80
 
-#define STK3310_STATE_EN_PS			0x01
-#define STK3310_STATE_EN_ALS			0x02
+#define STK3310_STATE_EN_PS			BIT(0)
+#define STK3310_STATE_EN_ALS			BIT(1)
 #define STK3310_STATE_STANDBY			0x00
 
 #define STK3310_CHIP_ID_VAL			0x13
@@ -436,8 +436,8 @@ static int stk3310_set_state(struct stk3310_data *data, u8 state)
 		dev_err(&client->dev, "failed to change sensor state\n");
 	} else if (state != STK3310_STATE_STANDBY) {
 		/* Don't reset the 'enabled' flags if we're going in standby */
-		data->ps_enabled  = !!(state & 0x01);
-		data->als_enabled = !!(state & 0x02);
+		data->ps_enabled  = !!(state & STK3310_STATE_EN_PS);
+		data->als_enabled = !!(state & STK3310_STATE_EN_ALS);
 	}
 	mutex_unlock(&data->lock);
 
@@ -684,7 +684,7 @@ static int stk3310_suspend(struct device *dev)
 
 static int stk3310_resume(struct device *dev)
 {
-	int state = 0;
+	u8 state = 0;
 	struct stk3310_data *data;
 
 	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
-- 
2.3.6
