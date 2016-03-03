Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.lysator.liu.se ([130.236.254.3]:58143 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758680AbcCCXKW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Mar 2016 18:10:22 -0500
From: Peter Rosin <peda@lysator.liu.se>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Peter Rosin <peda@axentia.se>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>, Ge Gao <GGao@invensense.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] iio: Fix ABBA deadlock in inv-mpu6050
Date: Fri,  4 Mar 2016 00:09:58 +0100
Message-Id: <1457046598-15367-1-git-send-email-peda@lysator.liu.se>
In-Reply-To: <CAEnQRZCKJuYTxckGzcFvyTfvonwBqQW37D7Y5RqyeBbd2iPkKA@mail.gmail.com>
References: <CAEnQRZCKJuYTxckGzcFvyTfvonwBqQW37D7Y5RqyeBbd2iPkKA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

Hi Daniel,

Daniel Baluta wrote:
>On Mon, Feb 22, 2016 at 1:17 AM, Wolfram Sang wrote:
>> On Thu, Feb 18, 2016 at 05:53:05PM +0200, Daniel Baluta wrote:
>>> Sending this as an RFC because I don't know if style fixes are appropriate
>>> for this driver and also not sure if deadlock fix is the best solution.

*snip*

>> We recently had a bigger patch series fixing locking problems related to
>> muxes. I sadly didn't have the time to review it. Can you have a look if
>> it helps your case?
>>
>> http://thread.gmane.org/gmane.linux.drivers.i2c/26169
> 
> Tested this and the deadlock is still there :(.

I assume that when you tested v3 of my series, you did nothing
to actually make use of the new stuff available in the mux-core?
If you didn't do anything to make use of the new stuff, the
driver should behave as before.

So, please try this patch on top of my recently posted v4 of the
"i2c mux cleanup and locking update" series [1]. I have not tested
this patch at all, but I have the feeling it could do the trick...

Cheers,
Peter

[1] https://marc.info/?l=linux-iio&m=145704469628330&w=3

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 642f22013d17..02b56e631973 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -79,35 +79,6 @@ int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 d)
 	return i2c_smbus_write_i2c_block_data(st->client, reg, 1, &d);
 }
 
-/*
- * The i2c read/write needs to happen in unlocked mode. As the parent
- * adapter is common. If we use locked versions, it will fail as
- * the mux adapter will lock the parent i2c adapter, while calling
- * select/deselect functions.
- */
-static int inv_mpu6050_write_reg_unlocked(struct inv_mpu6050_state *st,
-					  u8 reg, u8 d)
-{
-	int ret;
-	u8 buf[2];
-	struct i2c_msg msg[1] = {
-		{
-			.addr = st->client->addr,
-			.flags = 0,
-			.len = sizeof(buf),
-			.buf = buf,
-		}
-	};
-
-	buf[0] = reg;
-	buf[1] = d;
-	ret = __i2c_transfer(st->client->adapter, msg, 1);
-	if (ret != 1)
-		return ret;
-
-	return 0;
-}
-
 static int inv_mpu6050_select_bypass(struct i2c_mux_core *muxc, u32 chan_id)
 {
 	struct iio_dev *indio_dev = i2c_mux_priv(muxc);
@@ -117,8 +88,7 @@ static int inv_mpu6050_select_bypass(struct i2c_mux_core *muxc, u32 chan_id)
 	/* Use the same mutex which was used everywhere to protect power-op */
 	mutex_lock(&indio_dev->mlock);
 	if (!st->powerup_count) {
-		ret = inv_mpu6050_write_reg_unlocked(st, st->reg->pwr_mgmt_1,
-						     0);
+		ret = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_1, 0);
 		if (ret)
 			goto write_error;
 
@@ -126,9 +96,9 @@ static int inv_mpu6050_select_bypass(struct i2c_mux_core *muxc, u32 chan_id)
 	}
 	if (!ret) {
 		st->powerup_count++;
-		ret = inv_mpu6050_write_reg_unlocked(st, st->reg->int_pin_cfg,
-						     st->client->irq |
-						     INV_MPU6050_BIT_BYPASS_EN);
+		ret = inv_mpu6050_write_reg(st, st->reg->int_pin_cfg,
+					    st->client->irq |
+					    INV_MPU6050_BIT_BYPASS_EN);
 	}
 write_error:
 	mutex_unlock(&indio_dev->mlock);
@@ -143,12 +113,11 @@ static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
 
 	mutex_lock(&indio_dev->mlock);
 	/* It doesn't really mattter, if any of the calls fails */
-	inv_mpu6050_write_reg_unlocked(st, st->reg->int_pin_cfg,
-				       st->client->irq);
+	inv_mpu6050_write_reg(st, st->reg->int_pin_cfg, st->client->irq);
 	st->powerup_count--;
 	if (!st->powerup_count)
-		inv_mpu6050_write_reg_unlocked(st, st->reg->pwr_mgmt_1,
-					       INV_MPU6050_BIT_SLEEP);
+		inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_1,
+				      INV_MPU6050_BIT_SLEEP);
 	mutex_unlock(&indio_dev->mlock);
 
 	return 0;
@@ -839,8 +808,8 @@ static int inv_mpu_probe(struct i2c_client *client,
 		goto out_remove_trigger;
 	}
 
-	st->muxc = i2c_mux_one_adapter(client->adapter, &client->dev, 0, 0,
-				       0, 0, 0,
+	st->muxc = i2c_mux_one_adapter(client->adapter, &client->dev, 0,
+				       I2C_CONTROLLED_MUX, 0, 0, 0,
 				       inv_mpu6050_select_bypass,
 				       inv_mpu6050_deselect_bypass);
 	if (IS_ERR(st->muxc)) {
-- 
2.1.4

