Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751164AbeAAKHZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Jan 2018 05:07:25 -0500
Date: Mon, 1 Jan 2018 10:07:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: humidity: hts221: add regmap API support
Message-ID: <20180101100720.36300d55@archlinux>
In-Reply-To: <8577aaa06ca251a8688bb8fa48aa2d11747d67c4.1514588903.git.lorenzo.bianconi@redhat.com>
References: <cover.1514588903.git.lorenzo.bianconi@redhat.com>
        <8577aaa06ca251a8688bb8fa48aa2d11747d67c4.1514588903.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 30 Dec 2017 00:33:05 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Introduce regmap API support to access to i2c/spi bus instead of
> using a custom support.
> Remove lock mutex since concurrency is already managed by regmap API
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
One minor issue inline to be tidied up.  Not entirely sure why
the unaligned access was ever there but it doesn't look like it is
needed any more.

However, this isn't much to do with this patch so I'll take these
two and hopefully you will send a follow up to tidy that little
corner up as well.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/humidity/Kconfig         |   2 +
>  drivers/iio/humidity/hts221.h        |  21 +------
>  drivers/iio/humidity/hts221_buffer.c |  37 +++++------
>  drivers/iio/humidity/hts221_core.c   | 115 +++++++++++++----------------------
>  drivers/iio/humidity/hts221_i2c.c    |  64 ++++++-------------
>  drivers/iio/humidity/hts221_spi.c    |  81 ++++++------------------
>  6 files changed, 103 insertions(+), 217 deletions(-)
> 
> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> index 2c0fc9a400b8..1a0d458e4f4e 100644
> --- a/drivers/iio/humidity/Kconfig
> +++ b/drivers/iio/humidity/Kconfig
> @@ -68,10 +68,12 @@ config HTS221
>  config HTS221_I2C
>  	tristate
>  	depends on HTS221
> +	select REGMAP_I2C
>  
>  config HTS221_SPI
>  	tristate
>  	depends on HTS221
> +	select REGMAP_SPI
>  
>  config HTU21
>  	tristate "Measurement Specialties HTU21 humidity & temperature sensor"
> diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
> index c581af8c0f5d..e41a3d83e95d 100644
> --- a/drivers/iio/humidity/hts221.h
> +++ b/drivers/iio/humidity/hts221.h
> @@ -15,21 +15,8 @@
>  
>  #include <linux/iio/iio.h>
>  
> -#define HTS221_RX_MAX_LENGTH	8
> -#define HTS221_TX_MAX_LENGTH	8
> -
>  #define HTS221_DATA_SIZE	2
>  
> -struct hts221_transfer_buffer {
> -	u8 rx_buf[HTS221_RX_MAX_LENGTH];
> -	u8 tx_buf[HTS221_TX_MAX_LENGTH] ____cacheline_aligned;
> -};
> -
> -struct hts221_transfer_function {
> -	int (*read)(struct device *dev, u8 addr, int len, u8 *data);
> -	int (*write)(struct device *dev, u8 addr, int len, u8 *data);
> -};
> -
>  enum hts221_sensor_type {
>  	HTS221_SENSOR_H,
>  	HTS221_SENSOR_T,
> @@ -44,8 +31,8 @@ struct hts221_sensor {
>  struct hts221_hw {
>  	const char *name;
>  	struct device *dev;
> +	struct regmap *regmap;
>  
> -	struct mutex lock;
>  	struct iio_trigger *trig;
>  	int irq;
>  
> @@ -53,16 +40,12 @@ struct hts221_hw {
>  
>  	bool enabled;
>  	u8 odr;
> -
> -	const struct hts221_transfer_function *tf;
> -	struct hts221_transfer_buffer tb;
>  };
>  
>  extern const struct dev_pm_ops hts221_pm_ops;
>  
> -int hts221_write_with_mask(struct hts221_hw *hw, u8 addr, u8 mask, u8 val);
>  int hts221_probe(struct device *dev, int irq, const char *name,
> -		 const struct hts221_transfer_function *tf_ops);
> +		 struct regmap *regmap);
>  int hts221_set_enable(struct hts221_hw *hw, bool enable);
>  int hts221_allocate_buffers(struct hts221_hw *hw);
>  int hts221_allocate_trigger(struct hts221_hw *hw);
> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> index e971ea425268..29e0e9c1491a 100644
> --- a/drivers/iio/humidity/hts221_buffer.c
> +++ b/drivers/iio/humidity/hts221_buffer.c
> @@ -12,6 +12,8 @@
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqreturn.h>
> +#include <linux/regmap.h>
> +#include <linux/bitfield.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger.h>
> @@ -38,12 +40,10 @@ static int hts221_trig_set_state(struct iio_trigger *trig, bool state)
>  {
>  	struct iio_dev *iio_dev = iio_trigger_get_drvdata(trig);
>  	struct hts221_hw *hw = iio_priv(iio_dev);
> -	int err;
> -
> -	err = hts221_write_with_mask(hw, HTS221_REG_DRDY_EN_ADDR,
> -				     HTS221_REG_DRDY_EN_MASK, state);
>  
> -	return err < 0 ? err : 0;
> +	return regmap_update_bits(hw->regmap, HTS221_REG_DRDY_EN_ADDR,
> +				  HTS221_REG_DRDY_EN_MASK,
> +				  FIELD_PREP(HTS221_REG_DRDY_EN_MASK, state));
>  }
>  
>  static const struct iio_trigger_ops hts221_trigger_ops = {
> @@ -53,11 +53,9 @@ static const struct iio_trigger_ops hts221_trigger_ops = {
>  static irqreturn_t hts221_trigger_handler_thread(int irq, void *private)
>  {
>  	struct hts221_hw *hw = private;
> -	u8 status;
> -	int err;
> +	int err, status;
>  
> -	err = hw->tf->read(hw->dev, HTS221_REG_STATUS_ADDR, sizeof(status),
> -			   &status);
> +	err = regmap_read(hw->regmap, HTS221_REG_STATUS_ADDR, &status);
>  	if (err < 0)
>  		return IRQ_HANDLED;
>  
> @@ -102,8 +100,10 @@ int hts221_allocate_trigger(struct hts221_hw *hw)
>  		break;
>  	}
>  
> -	err = hts221_write_with_mask(hw, HTS221_REG_DRDY_HL_ADDR,
> -				     HTS221_REG_DRDY_HL_MASK, irq_active_low);
> +	err = regmap_update_bits(hw->regmap, HTS221_REG_DRDY_HL_ADDR,
> +				 HTS221_REG_DRDY_HL_MASK,
> +				 FIELD_PREP(HTS221_REG_DRDY_HL_MASK,
> +					    irq_active_low));
>  	if (err < 0)
>  		return err;
>  
> @@ -114,9 +114,10 @@ int hts221_allocate_trigger(struct hts221_hw *hw)
>  		open_drain = true;
>  	}
>  
> -	err = hts221_write_with_mask(hw, HTS221_REG_DRDY_PP_OD_ADDR,
> -				     HTS221_REG_DRDY_PP_OD_MASK,
> -				     open_drain);
> +	err = regmap_update_bits(hw->regmap, HTS221_REG_DRDY_PP_OD_ADDR,
> +				 HTS221_REG_DRDY_PP_OD_MASK,
> +				 FIELD_PREP(HTS221_REG_DRDY_PP_OD_MASK,
> +					    open_drain));
>  	if (err < 0)
>  		return err;
>  
> @@ -171,15 +172,15 @@ static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
>  
>  	/* humidity data */
>  	ch = &iio_dev->channels[HTS221_SENSOR_H];
> -	err = hw->tf->read(hw->dev, ch->address, HTS221_DATA_SIZE,
> -			   buffer);
> +	err = regmap_bulk_read(hw->regmap, ch->address,
> +			       buffer, HTS221_DATA_SIZE);
>  	if (err < 0)
>  		goto out;
>  
>  	/* temperature data */
>  	ch = &iio_dev->channels[HTS221_SENSOR_T];
> -	err = hw->tf->read(hw->dev, ch->address, HTS221_DATA_SIZE,
> -			   buffer + HTS221_DATA_SIZE);
> +	err = regmap_bulk_read(hw->regmap, ch->address,
> +			       buffer + HTS221_DATA_SIZE, HTS221_DATA_SIZE);
>  	if (err < 0)
>  		goto out;
>  
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index d3f7904766bd..75d442e7b510 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -15,6 +15,8 @@
>  #include <linux/delay.h>
>  #include <linux/pm.h>
>  #include <asm/unaligned.h>

The above include made me wonder what was going on that needed unaligned
accesses.  The answer is nothing does that I can see. You have

static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
{
	u8 data[HTS221_DATA_SIZE];
	int err;

	err = hts221_set_enable(hw, true);
	if (err < 0)
		return err;

	msleep(50);

	err = regmap_bulk_read(hw->regmap, addr, data, sizeof(data));
	if (err < 0)
		return err;

	hts221_set_enable(hw, false);

	*val = (s16)get_unaligned_le16(data);

It's aligned...

	return IIO_VAL_INT;
}

> +#include <linux/regmap.h>
> +#include <linux/bitfield.h>
>  
>  #include "hts221.h"
>  
> @@ -131,38 +133,11 @@ static const struct iio_chan_spec hts221_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(2),
>  };
>  
> -int hts221_write_with_mask(struct hts221_hw *hw, u8 addr, u8 mask, u8 val)
> -{
> -	u8 data;
> -	int err;
> -
> -	mutex_lock(&hw->lock);
> -
> -	err = hw->tf->read(hw->dev, addr, sizeof(data), &data);
> -	if (err < 0) {
> -		dev_err(hw->dev, "failed to read %02x register\n", addr);
> -		goto unlock;
> -	}
> -
> -	data = (data & ~mask) | ((val << __ffs(mask)) & mask);
> -
> -	err = hw->tf->write(hw->dev, addr, sizeof(data), &data);
> -	if (err < 0)
> -		dev_err(hw->dev, "failed to write %02x register\n", addr);
> -
> -unlock:
> -	mutex_unlock(&hw->lock);
> -
> -	return err;
> -}
> -
>  static int hts221_check_whoami(struct hts221_hw *hw)
>  {
> -	u8 data;
> -	int err;
> +	int err, data;
>  
> -	err = hw->tf->read(hw->dev, HTS221_REG_WHOAMI_ADDR, sizeof(data),
> -			   &data);
> +	err = regmap_read(hw->regmap, HTS221_REG_WHOAMI_ADDR, &data);
>  	if (err < 0) {
>  		dev_err(hw->dev, "failed to read whoami register\n");
>  		return err;
> @@ -188,8 +163,10 @@ static int hts221_update_odr(struct hts221_hw *hw, u8 odr)
>  	if (i == ARRAY_SIZE(hts221_odr_table))
>  		return -EINVAL;
>  
> -	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> -				     HTS221_ODR_MASK, hts221_odr_table[i].val);
> +	err = regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
> +				 HTS221_ODR_MASK,
> +				 FIELD_PREP(HTS221_ODR_MASK,
> +					    hts221_odr_table[i].val));
>  	if (err < 0)
>  		return err;
>  
> @@ -202,8 +179,8 @@ static int hts221_update_avg(struct hts221_hw *hw,
>  			     enum hts221_sensor_type type,
>  			     u16 val)
>  {
> -	int i, err;
>  	const struct hts221_avg *avg = &hts221_avg_list[type];
> +	int i, err, data;
>  
>  	for (i = 0; i < HTS221_AVG_DEPTH; i++)
>  		if (avg->avg_avl[i] == val)
> @@ -212,7 +189,9 @@ static int hts221_update_avg(struct hts221_hw *hw,
>  	if (i == HTS221_AVG_DEPTH)
>  		return -EINVAL;
>  
> -	err = hts221_write_with_mask(hw, avg->addr, avg->mask, i);
> +	data = ((i << __ffs(avg->mask)) & avg->mask);
> +	err = regmap_update_bits(hw->regmap, avg->addr,
> +				 avg->mask, data);
>  	if (err < 0)
>  		return err;
>  
> @@ -274,8 +253,9 @@ int hts221_set_enable(struct hts221_hw *hw, bool enable)
>  {
>  	int err;
>  
> -	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> -				     HTS221_ENABLE_MASK, enable);
> +	err = regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
> +				 HTS221_ENABLE_MASK,
> +				 FIELD_PREP(HTS221_ENABLE_MASK, enable));
>  	if (err < 0)
>  		return err;
>  
> @@ -286,35 +266,31 @@ int hts221_set_enable(struct hts221_hw *hw, bool enable)
>  
>  static int hts221_parse_temp_caldata(struct hts221_hw *hw)
>  {
> -	int err, *slope, *b_gen;
> +	int err, *slope, *b_gen, cal0, cal1;
>  	s16 cal_x0, cal_x1, cal_y0, cal_y1;
> -	u8 cal0, cal1;
>  
> -	err = hw->tf->read(hw->dev, HTS221_REG_0T_CAL_Y_H,
> -			   sizeof(cal0), &cal0);
> +	err = regmap_read(hw->regmap, HTS221_REG_0T_CAL_Y_H, &cal0);
>  	if (err < 0)
>  		return err;
>  
> -	err = hw->tf->read(hw->dev, HTS221_REG_T1_T0_CAL_Y_H,
> -			   sizeof(cal1), &cal1);
> +	err = regmap_read(hw->regmap, HTS221_REG_T1_T0_CAL_Y_H, &cal1);
>  	if (err < 0)
>  		return err;
>  	cal_y0 = (le16_to_cpu(cal1 & 0x3) << 8) | cal0;
>  
> -	err = hw->tf->read(hw->dev, HTS221_REG_1T_CAL_Y_H,
> -			   sizeof(cal0), &cal0);
> +	err = regmap_read(hw->regmap, HTS221_REG_1T_CAL_Y_H, &cal0);
>  	if (err < 0)
>  		return err;
>  	cal_y1 = (((cal1 & 0xc) >> 2) << 8) | cal0;
>  
> -	err = hw->tf->read(hw->dev, HTS221_REG_0T_CAL_X_L, sizeof(cal_x0),
> -			   (u8 *)&cal_x0);
> +	err = regmap_bulk_read(hw->regmap, HTS221_REG_0T_CAL_X_L,
> +			       &cal_x0, sizeof(cal_x0));
>  	if (err < 0)
>  		return err;
>  	cal_x0 = le16_to_cpu(cal_x0);
>  
> -	err = hw->tf->read(hw->dev, HTS221_REG_1T_CAL_X_L, sizeof(cal_x1),
> -			   (u8 *)&cal_x1);
> +	err = regmap_bulk_read(hw->regmap, HTS221_REG_1T_CAL_X_L,
> +			       &cal_x1, sizeof(cal_x1));
>  	if (err < 0)
>  		return err;
>  	cal_x1 = le16_to_cpu(cal_x1);
> @@ -332,30 +308,27 @@ static int hts221_parse_temp_caldata(struct hts221_hw *hw)
>  
>  static int hts221_parse_rh_caldata(struct hts221_hw *hw)
>  {
> -	int err, *slope, *b_gen;
> +	int err, *slope, *b_gen, data;
>  	s16 cal_x0, cal_x1, cal_y0, cal_y1;
> -	u8 data;
>  
> -	err = hw->tf->read(hw->dev, HTS221_REG_0RH_CAL_Y_H, sizeof(data),
> -			   &data);
> +	err = regmap_read(hw->regmap, HTS221_REG_0RH_CAL_Y_H, &data);
>  	if (err < 0)
>  		return err;
>  	cal_y0 = data;
>  
> -	err = hw->tf->read(hw->dev, HTS221_REG_1RH_CAL_Y_H, sizeof(data),
> -			   &data);
> +	err = regmap_read(hw->regmap, HTS221_REG_1RH_CAL_Y_H, &data);
>  	if (err < 0)
>  		return err;
>  	cal_y1 = data;
>  
> -	err = hw->tf->read(hw->dev, HTS221_REG_0RH_CAL_X_H, sizeof(cal_x0),
> -			   (u8 *)&cal_x0);
> +	err = regmap_bulk_read(hw->regmap, HTS221_REG_0RH_CAL_X_H,
> +			       &cal_x0, sizeof(cal_x0));
>  	if (err < 0)
>  		return err;
>  	cal_x0 = le16_to_cpu(cal_x0);
>  
> -	err = hw->tf->read(hw->dev, HTS221_REG_1RH_CAL_X_H, sizeof(cal_x1),
> -			   (u8 *)&cal_x1);
> +	err = regmap_bulk_read(hw->regmap, HTS221_REG_1RH_CAL_X_H,
> +			       &cal_x1, sizeof(cal_x1));
>  	if (err < 0)
>  		return err;
>  	cal_x1 = le16_to_cpu(cal_x1);
> @@ -440,7 +413,7 @@ static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
>  
>  	msleep(50);
>  
> -	err = hw->tf->read(hw->dev, addr, sizeof(data), data);
> +	err = regmap_bulk_read(hw->regmap, addr, data, sizeof(data));
>  	if (err < 0)
>  		return err;
>  
> @@ -582,7 +555,7 @@ static const struct iio_info hts221_info = {
>  static const unsigned long hts221_scan_masks[] = {0x3, 0x0};
>  
>  int hts221_probe(struct device *dev, int irq, const char *name,
> -		 const struct hts221_transfer_function *tf_ops)
> +		 struct regmap *regmap)
>  {
>  	struct iio_dev *iio_dev;
>  	struct hts221_hw *hw;
> @@ -599,9 +572,7 @@ int hts221_probe(struct device *dev, int irq, const char *name,
>  	hw->name = name;
>  	hw->dev = dev;
>  	hw->irq = irq;
> -	hw->tf = tf_ops;
> -
> -	mutex_init(&hw->lock);
> +	hw->regmap = regmap;
>  
>  	err = hts221_check_whoami(hw);
>  	if (err < 0)
> @@ -616,8 +587,9 @@ int hts221_probe(struct device *dev, int irq, const char *name,
>  	iio_dev->info = &hts221_info;
>  
>  	/* enable Block Data Update */
> -	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> -				     HTS221_BDU_MASK, 1);
> +	err = regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
> +				 HTS221_BDU_MASK,
> +				 FIELD_PREP(HTS221_BDU_MASK, 1));
>  	if (err < 0)
>  		return err;
>  
> @@ -673,12 +645,10 @@ static int __maybe_unused hts221_suspend(struct device *dev)
>  {
>  	struct iio_dev *iio_dev = dev_get_drvdata(dev);
>  	struct hts221_hw *hw = iio_priv(iio_dev);
> -	int err;
>  
> -	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> -				     HTS221_ENABLE_MASK, false);
> -
> -	return err < 0 ? err : 0;
> +	return regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
> +				  HTS221_ENABLE_MASK,
> +				  FIELD_PREP(HTS221_ENABLE_MASK, false));
>  }
>  
>  static int __maybe_unused hts221_resume(struct device *dev)
> @@ -688,9 +658,10 @@ static int __maybe_unused hts221_resume(struct device *dev)
>  	int err = 0;
>  
>  	if (hw->enabled)
> -		err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> -					     HTS221_ENABLE_MASK, true);
> -
> +		err = regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
> +					 HTS221_ENABLE_MASK,
> +					 FIELD_PREP(HTS221_ENABLE_MASK,
> +						    true));
>  	return err;
>  }
>  
> diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
> index 2c97350a0f76..b5b3f408a658 100644
> --- a/drivers/iio/humidity/hts221_i2c.c
> +++ b/drivers/iio/humidity/hts221_i2c.c
> @@ -13,61 +13,33 @@
>  #include <linux/acpi.h>
>  #include <linux/i2c.h>
>  #include <linux/slab.h>
> -#include "hts221.h"
> -
> -#define I2C_AUTO_INCREMENT	0x80
> -
> -static int hts221_i2c_read(struct device *dev, u8 addr, int len, u8 *data)
> -{
> -	struct i2c_msg msg[2];
> -	struct i2c_client *client = to_i2c_client(dev);
> -
> -	if (len > 1)
> -		addr |= I2C_AUTO_INCREMENT;
> -
> -	msg[0].addr = client->addr;
> -	msg[0].flags = client->flags;
> -	msg[0].len = 1;
> -	msg[0].buf = &addr;
> -
> -	msg[1].addr = client->addr;
> -	msg[1].flags = client->flags | I2C_M_RD;
> -	msg[1].len = len;
> -	msg[1].buf = data;
> -
> -	return i2c_transfer(client->adapter, msg, 2);
> -}
> +#include <linux/regmap.h>
>  
> -static int hts221_i2c_write(struct device *dev, u8 addr, int len, u8 *data)
> -{
> -	u8 send[len + 1];
> -	struct i2c_msg msg;
> -	struct i2c_client *client = to_i2c_client(dev);
> -
> -	if (len > 1)
> -		addr |= I2C_AUTO_INCREMENT;
> -
> -	send[0] = addr;
> -	memcpy(&send[1], data, len * sizeof(u8));
> -
> -	msg.addr = client->addr;
> -	msg.flags = client->flags;
> -	msg.len = len + 1;
> -	msg.buf = send;
> +#include "hts221.h"
>  
> -	return i2c_transfer(client->adapter, &msg, 1);
> -}
> +#define HTS221_I2C_AUTO_INCREMENT	BIT(7)
>  
> -static const struct hts221_transfer_function hts221_transfer_fn = {
> -	.read = hts221_i2c_read,
> -	.write = hts221_i2c_write,
> +static const struct regmap_config hts221_i2c_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.write_flag_mask = HTS221_I2C_AUTO_INCREMENT,
> +	.read_flag_mask = HTS221_I2C_AUTO_INCREMENT,
>  };
>  
>  static int hts221_i2c_probe(struct i2c_client *client,
>  			    const struct i2c_device_id *id)
>  {
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i2c(client, &hts221_i2c_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
> +			(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
>  	return hts221_probe(&client->dev, client->irq,
> -			    client->name, &hts221_transfer_fn);
> +			    client->name, regmap);
>  }
>  
>  static const struct acpi_device_id hts221_acpi_match[] = {
> diff --git a/drivers/iio/humidity/hts221_spi.c b/drivers/iio/humidity/hts221_spi.c
> index 55b29b53b9d1..9c005f037026 100644
> --- a/drivers/iio/humidity/hts221_spi.c
> +++ b/drivers/iio/humidity/hts221_spi.c
> @@ -12,76 +12,33 @@
>  #include <linux/module.h>
>  #include <linux/spi/spi.h>
>  #include <linux/slab.h>
> -#include "hts221.h"
> -
> -#define SENSORS_SPI_READ	0x80
> -#define SPI_AUTO_INCREMENT	0x40
> -
> -static int hts221_spi_read(struct device *dev, u8 addr, int len, u8 *data)
> -{
> -	int err;
> -	struct spi_device *spi = to_spi_device(dev);
> -	struct iio_dev *iio_dev = spi_get_drvdata(spi);
> -	struct hts221_hw *hw = iio_priv(iio_dev);
> -
> -	struct spi_transfer xfers[] = {
> -		{
> -			.tx_buf = hw->tb.tx_buf,
> -			.bits_per_word = 8,
> -			.len = 1,
> -		},
> -		{
> -			.rx_buf = hw->tb.rx_buf,
> -			.bits_per_word = 8,
> -			.len = len,
> -		}
> -	};
> -
> -	if (len > 1)
> -		addr |= SPI_AUTO_INCREMENT;
> -	hw->tb.tx_buf[0] = addr | SENSORS_SPI_READ;
> -
> -	err = spi_sync_transfer(spi, xfers,  ARRAY_SIZE(xfers));
> -	if (err < 0)
> -		return err;
> -
> -	memcpy(data, hw->tb.rx_buf, len * sizeof(u8));
> -
> -	return len;
> -}
> -
> -static int hts221_spi_write(struct device *dev, u8 addr, int len, u8 *data)
> -{
> -	struct spi_device *spi = to_spi_device(dev);
> -	struct iio_dev *iio_dev = spi_get_drvdata(spi);
> -	struct hts221_hw *hw = iio_priv(iio_dev);
> -
> -	struct spi_transfer xfers = {
> -		.tx_buf = hw->tb.tx_buf,
> -		.bits_per_word = 8,
> -		.len = len + 1,
> -	};
> -
> -	if (len >= HTS221_TX_MAX_LENGTH)
> -		return -ENOMEM;
> +#include <linux/regmap.h>
>  
> -	if (len > 1)
> -		addr |= SPI_AUTO_INCREMENT;
> -	hw->tb.tx_buf[0] = addr;
> -	memcpy(&hw->tb.tx_buf[1], data, len);
> +#include "hts221.h"
>  
> -	return spi_sync_transfer(spi, &xfers, 1);
> -}
> +#define HTS221_SPI_READ			BIT(7)
> +#define HTS221_SPI_AUTO_INCREMENT	BIT(6)
>  
> -static const struct hts221_transfer_function hts221_transfer_fn = {
> -	.read = hts221_spi_read,
> -	.write = hts221_spi_write,
> +static const struct regmap_config hts221_spi_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.write_flag_mask = HTS221_SPI_AUTO_INCREMENT,
> +	.read_flag_mask = HTS221_SPI_READ | HTS221_SPI_AUTO_INCREMENT,
>  };
>  
>  static int hts221_spi_probe(struct spi_device *spi)
>  {
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_spi(spi, &hts221_spi_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> +			(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
>  	return hts221_probe(&spi->dev, spi->irq,
> -			    spi->modalias, &hts221_transfer_fn);
> +			    spi->modalias, regmap);
>  }
>  
>  static const struct of_device_id hts221_spi_of_match[] = {

