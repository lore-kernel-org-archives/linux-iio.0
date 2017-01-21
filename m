Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36088 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750900AbdAURf3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 12:35:29 -0500
Date: Sat, 21 Jan 2017 17:35:24 +0000
In-Reply-To: <20170121164909.nlwp4qh7ax3jj7zd@basecamp.onstation.org>
References: <20170117092502.6951-1-masneyb@onstation.org> <20170117092502.6951-16-masneyb@onstation.org> <6e3abe6c-b275-64ca-f223-4cc10ee0ba71@kernel.org> <20170121164909.nlwp4qh7ax3jj7zd@basecamp.onstation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v2 15/15] staging: iio: isl29028: add runtime power management support
To: Brian Masney <masneyb@onstation.org>
CC: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <F7EE151C-C1D7-424F-BAD7-9D762C891200@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 21 January 2017 16:49:09 GMT+00:00, Brian Masney <masneyb@onstation.org> wrote:
>On Sat, Jan 21, 2017 at 02:58:12PM +0000, Jonathan Cameron wrote:
>> On 17/01/17 09:25, Brian Masney wrote:
>> > This patch adds runtime power management support to the isl29028
>driver.
>> > It defaults to powering off the device after two seconds of
>inactivity.
>> > 
>> > isl29028_chip_init_and_power_on() currently only zeros the
>CONFIGURE
>> > register on the chip, which will cause the chip to turn off. This
>patch
>> > also renames that function to isl29028_clear_configure_reg() since
>it is
>> > now used in several places.
>> > 
>> > Signed-off-by: Brian Masney <masneyb@onstation.org>
>> Whilst I'm not against it by an means, runtime PM is hardly a
>requirement
>> for moving out of staging! Good stuff though so I'm not going to turn
>it
>> down ;)
>
>Thanks. I know it wasn't a requirement for a staging graduation but I
>did it just for the fun of it to learn more about power management in
>the kernel.
>
>> I'm not 100% sure about the one comment I made at the end.
>> It's a very unlikely to occur condition anyway, but if you want to
>follow up
>> with a patch on that then feel free.
>
>See below.
>
>> Applied to the togreg branch of iio.git and pushed out as testing for
>> the autobuilders to play with it.
>> 
>> thanks,
>> 
>> Jonathan
>> > ---
>> >  drivers/staging/iio/light/isl29028.c | 118
>++++++++++++++++++++++++++++++++---
>> >  1 file changed, 110 insertions(+), 8 deletions(-)
>> > 
>> > diff --git a/drivers/staging/iio/light/isl29028.c
>b/drivers/staging/iio/light/isl29028.c
>> > index 598a5a5..a3264f7 100644
>> > --- a/drivers/staging/iio/light/isl29028.c
>> > +++ b/drivers/staging/iio/light/isl29028.c
>> > @@ -26,6 +26,7 @@
>> >  #include <linux/regmap.h>
>> >  #include <linux/iio/iio.h>
>> >  #include <linux/iio/sysfs.h>
>> > +#include <linux/pm_runtime.h>
>> >  
>> >  #define ISL29028_CONV_TIME_MS			100
>> >  
>> > @@ -60,6 +61,8 @@
>> >  
>> >  #define ISL29028_NUM_REGS			(ISL29028_REG_TEST2_MODE + 1)
>> >  
>> > +#define ISL29028_POWER_OFF_DELAY_MS		2000
>> > +
>> >  enum isl29028_als_ir_mode {
>> >  	ISL29028_MODE_NONE = 0,
>> >  	ISL29028_MODE_ALS,
>> > @@ -297,6 +300,23 @@ static int isl29028_ir_get(struct
>isl29028_chip *chip, int *ir_data)
>> >  	return isl29028_read_als_ir(chip, ir_data);
>> >  }
>> >  
>> > +static int isl29028_set_pm_runtime_busy(struct isl29028_chip
>*chip, bool on)
>> > +{
>> > +	struct device *dev = regmap_get_device(chip->regmap);
>> > +	int ret;
>> > +
>> > +	if (on) {
>> > +		ret = pm_runtime_get_sync(dev);
>> > +		if (ret < 0)
>> > +			pm_runtime_put_noidle(dev);
>> > +	} else {
>> > +		pm_runtime_mark_last_busy(dev);
>> > +		ret = pm_runtime_put_autosuspend(dev);
>> > +	}
>> > +
>> > +	return ret;
>> > +}
>> > +
>> >  /* Channel IO */
>> >  static int isl29028_write_raw(struct iio_dev *indio_dev,
>> >  			      struct iio_chan_spec const *chan,
>> > @@ -304,9 +324,15 @@ static int isl29028_write_raw(struct iio_dev
>*indio_dev,
>> >  {
>> >  	struct isl29028_chip *chip = iio_priv(indio_dev);
>> >  	struct device *dev = regmap_get_device(chip->regmap);
>> > -	int ret = -EINVAL;
>> > +	int ret;
>> > +
>> > +	ret = isl29028_set_pm_runtime_busy(chip, true);
>> > +	if (ret < 0)
>> > +		return ret;
>> >  
>> >  	mutex_lock(&chip->lock);
>> > +
>> > +	ret = -EINVAL;
>> >  	switch (chan->type) {
>> >  	case IIO_PROXIMITY:
>> >  		if (mask != IIO_CHAN_INFO_SAMP_FREQ) {
>> > @@ -350,6 +376,13 @@ static int isl29028_write_raw(struct iio_dev
>*indio_dev,
>> >  
>> >  	mutex_unlock(&chip->lock);
>> >  
>> > +	if (ret < 0)
>> > +		return ret;
>> > +
>> > +	ret = isl29028_set_pm_runtime_busy(chip, false);
>> > +	if (ret < 0)
>> > +		return ret;
>> > +
>> >  	return ret;
>> >  }
>> >  
>> > @@ -359,9 +392,15 @@ static int isl29028_read_raw(struct iio_dev
>*indio_dev,
>> >  {
>> >  	struct isl29028_chip *chip = iio_priv(indio_dev);
>> >  	struct device *dev = regmap_get_device(chip->regmap);
>> > -	int ret = -EINVAL;
>> > +	int ret, pm_ret;
>> > +
>> > +	ret = isl29028_set_pm_runtime_busy(chip, true);
>> > +	if (ret < 0)
>> > +		return ret;
>> >  
>> >  	mutex_lock(&chip->lock);
>> > +
>> > +	ret = -EINVAL;
>> >  	switch (mask) {
>> >  	case IIO_CHAN_INFO_RAW:
>> >  	case IIO_CHAN_INFO_PROCESSED:
>> > @@ -405,6 +444,18 @@ static int isl29028_read_raw(struct iio_dev
>*indio_dev,
>> >  
>> >  	mutex_unlock(&chip->lock);
>> >  
>> > +	if (ret < 0)
>> > +		return ret;
>> > +
>> > +	/**
>> > +	 * Preserve the ret variable if the call to
>> > +	 * isl29028_set_pm_runtime_busy() is successful so the reading
>> > +	 * (if applicable) is returned to user space.
>> > +	 */
>> > +	pm_ret = isl29028_set_pm_runtime_busy(chip, false);
>> > +	if (pm_ret < 0)
>> > +		return pm_ret;
>> > +
>> >  	return ret;
>> >  }
>> >  
>> > @@ -445,17 +496,18 @@ static const struct iio_info isl29028_info =
>{
>> >  	.write_raw = isl29028_write_raw,
>> >  };
>> >  
>> > -static int isl29028_chip_init_and_power_on(struct isl29028_chip
>*chip)
>> > +static int isl29028_clear_configure_reg(struct isl29028_chip
>*chip)
>> >  {
>> >  	struct device *dev = regmap_get_device(chip->regmap);
>> >  	int ret;
>> >  
>> >  	ret = regmap_write(chip->regmap, ISL29028_REG_CONFIGURE, 0x0);
>> > -	if (ret < 0) {
>> > +	if (ret < 0)
>> >  		dev_err(dev, "%s(): Error %d clearing the CONFIGURE register\n",
>> >  			__func__, ret);
>> > -		return ret;
>> > -	}
>> > +
>> > +	chip->als_ir_mode = ISL29028_MODE_NONE;
>> > +	chip->enable_prox = false;
>> >  
>> >  	return ret;
>> >  }
>> > @@ -509,7 +561,6 @@ static int isl29028_probe(struct i2c_client
>*client,
>> >  	chip->enable_prox  = false;
>> >  	chip->prox_sampling = 20;
>> >  	chip->lux_scale = 2000;
>> > -	chip->als_ir_mode = ISL29028_MODE_NONE;
>> >  
>> >  	ret = regmap_write(chip->regmap, ISL29028_REG_TEST1_MODE, 0x0);
>> >  	if (ret < 0) {
>> > @@ -527,7 +578,7 @@ static int isl29028_probe(struct i2c_client
>*client,
>> >  		return ret;
>> >  	}
>> >  
>> > -	ret = isl29028_chip_init_and_power_on(chip);
>> > +	ret = isl29028_clear_configure_reg(chip);
>> >  	if (ret < 0)
>> >  		return ret;
>> >  
>> > @@ -538,6 +589,11 @@ static int isl29028_probe(struct i2c_client
>*client,
>> >  	indio_dev->dev.parent = &client->dev;
>> >  	indio_dev->modes = INDIO_DIRECT_MODE;
>> >  
>> > +	pm_runtime_enable(&client->dev);
>> > +	pm_runtime_set_autosuspend_delay(&client->dev,
>> > +					 ISL29028_POWER_OFF_DELAY_MS);
>> > +	pm_runtime_use_autosuspend(&client->dev);
>> > +
>> >  	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>> >  	if (ret < 0) {
>> >  		dev_err(&client->dev,
>> > @@ -549,6 +605,50 @@ static int isl29028_probe(struct i2c_client
>*client,
>> >  	return 0;
>> >  }
>> >  
>> > +static int isl29028_remove(struct i2c_client *client)
>> > +{
>> > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> > +	struct isl29028_chip *chip = iio_priv(indio_dev);
>> > +
>> > +	iio_device_unregister(indio_dev);
>> > +
>> > +	pm_runtime_disable(&client->dev);
>> > +	pm_runtime_set_suspended(&client->dev);
>> > +	pm_runtime_put_noidle(&client->dev);
>> > +
>> > +	return isl29028_clear_configure_reg(chip);
>> > +}
>> > +
>> > +static int __maybe_unused isl29028_suspend(struct device *dev)
>> > +{
>> > +	struct iio_dev *indio_dev =
>i2c_get_clientdata(to_i2c_client(dev));
>> > +	struct isl29028_chip *chip = iio_priv(indio_dev);
>> > +	int ret;
>> > +
>> > +	mutex_lock(&chip->lock);
>> > +
>> > +	ret = isl29028_clear_configure_reg(chip);
>> I'm stretching a bit, but there might be a race here.
>> If we get a suspend and resume in under the time it takes for
>> the auto suspend to conclude it is good to suspend, it might think
>> the device is still ready to go when it isn't.
>
>I don't believe that there is a race condition in that situation since
>all of the i2c calls outside of the probe and remove functions come
>from
>either isl29028_write_raw(), isl29028_read_raw(), or
>isl29028_suspend().
>All of three of those functions lock a common mutex.
Was more thinking that you are disabling the device without letting runtime pm know.
So it might not bring it up again....
Not chased the paths in enough depth to be sure.
>
>I just noticed that isl29028_remove() doesn't lock that shared mutex
>when the device is removed and the chip is powered off. This is
>unlikely to be an issue but I'll send a follow up patch in my next
>series fixing that just to be sure.
>
>Brian
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
