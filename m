Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6862367D1;
	Sat,  7 Feb 2026 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770474215; cv=none; b=r+o++ZfQZSk7CxsgiUCxytXjktfx2JvI6rtvDe0eUWc/ryOGhn7U7IvbTtpzPuW5myZvfmU+ZKB8eEqd8Z5lWAs9/9mieORJQquPszaBDzkhWbgDLrckUfkl26Ivh8IP62YZbkuaSb3IYQqhxCev69kWAVCoOy8aX85vfI0hvEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770474215; c=relaxed/simple;
	bh=PaXJeCa7ehQYrL9NkvSabYSKB8sUME7VjEp1xAOQgq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snVtdflYnwpq8oR9J+58Hz4yoH8xzMkJPuURSptBXdWooMgYOEV7rtDRLH1EF7Nzd7W1Rgnqehe6YHHxfTX7wRCbpqXhpCqd7EcogHxcV+4ECkuow2CCumtO4y0Up6PFaYI9a0JuFP0a7A5IkgbBPUTKavkVp8fEomHiCNMfQ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIdB/TkQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIdB/TkQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C54C19423;
	Sat,  7 Feb 2026 14:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770474215;
	bh=PaXJeCa7ehQYrL9NkvSabYSKB8sUME7VjEp1xAOQgq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KIdB/TkQL/ZGLS78A6dtjBGPeM2qMnno5cMePyo7ReR4ymS+sA4N1Wb7I+hzix7tb
	 HpYMi279jfu6CjSE88pAby/DUjjgsntoy1W7NsabZ2U5rlLlzspcpnNyoakpzBtEl7
	 wf62u3Zz4UvzNHo8Y5e7CvE8f5Rj/IL4VdZ22XqTIxDw2mxt47MPlElgjiw8GH9v8x
	 FXXyh/OpY6BAXLWO0oP2jOReGwmqgG9GoO+nbro2Bjvw2SYzdP6MNv9DxTIh5XdVSF
	 FO/7wCM5WBfIONPdYchW6sekwZfSEAcWrW5WzbdA1abZr+C0KzhxDVStVhosu4eo5N
	 tp55MPCadsHlg==
Date: Sat, 7 Feb 2026 14:23:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: magnetometer: bmc150_magn: cleanup mutex usage
 and coding style
Message-ID: <20260207142328.6e96be14@jic23-huawei>
In-Reply-To: <20260206171814.91064-1-neelb2403@gmail.com>
References: <20260206171814.91064-1-neelb2403@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Feb 2026 12:18:14 -0500
Neel Bullywon <neelb2403@gmail.com> wrote:

Hi Neel,

The 'and' in the patch title is a clear sign that this should be
multiple patches.

Please break it up into separate patches for each type of change.
e.g. The cleanup.h / guard ones in one patch, coding style changes
     in another patch.

> Replace manual mutex lock/unlock calls with guard() to simplify error

Please fix whatever added blank lines to this commit message.

> 
> handling and reduce goto usage. This ensures RAII-style cleanup where
> 
> the mutex is always released automatically.
> 
> Replace msleep(5) with usleep_range(5000, 6000) to avoid checkpatch
> 
> warnings about short msleep delays.
> 
> Also fix several indentation and line wrapping style issues to verify
> 
> cleanly with checkpatch.
Checkpatch is a tool to provide suggestions. Make sure to also
look at whether the suggestions it is making actually improve readability
and are worth the costs of making the change.

Various comments inline

Thanks

Jonathan

> 
> Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
> ---
> Changes in v4:
> - Replace scoped_guard() with guard() to avoid lexical scope issues with goto
>   and return values which caused logic errors in previous versions.
> - Replace msleep(5) with usleep_range(5000, 6000) to avoid checkpatch
>   warning.
> - Fix indentation and line wrapping to cleanliness.
> - Extend guard() usage to all mutex_lock() instances in the driver.
> 
> Changes in v3:
> - Add Reviewed-by tags.
> 
> Changes in v2:
> - Use guard() for mutex protection in bmc150_magn_data_rdy_trigger_set_state.
> 
>  drivers/iio/magnetometer/bmc150_magn.c | 371 ++++++++++++-------------
>  1 file changed, 174 insertions(+), 197 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index 73d9183a354b..8cd61ae46ca5 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -11,6 +11,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/i2c.h>
> +#include <linux/cleanup.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
> @@ -28,64 +29,64 @@
>  
>  #include "bmc150_magn.h"
>  
> -#define BMC150_MAGN_REG_CHIP_ID			0x40
> -#define BMC150_MAGN_CHIP_ID_VAL			0x32
> -
> -#define BMC150_MAGN_REG_X_L			0x42

What is the benefit in changing these indents?

Remember that every change to code brings cost in terms of making it
harder to backport fixes in future + review time and patch preparation
time today.


>  
>  #define BMC150_MAGN_REGVAL_TO_REPXY(regval) (((regval) * 2) + 1)
>  #define BMC150_MAGN_REGVAL_TO_REPZ(regval) ((regval) + 1)
> @@ -148,14 +149,9 @@ struct bmc150_magn_data {
>  static const struct {
>  	int freq;
>  	u8 reg_val;
> -} bmc150_magn_samp_freq_table[] = { {2, 0x01},
> -				    {6, 0x02},
> -				    {8, 0x03},
> -				    {10, 0x00},
> -				    {15, 0x04},
> -				    {20, 0x05},
> -				    {25, 0x06},
> -				    {30, 0x07} };
> +} bmc150_magn_samp_freq_table[] = { { 2, 0x01 },  { 6, 0x02 },	{ 8, 0x03 },
> +				    { 10, 0x00 }, { 15, 0x04 }, { 20, 0x05 },
> +				    { 25, 0x06 }, { 30, 0x07 } };
It was clearer with 1 per line.  The spaces being added are a good change
but not the combining on fewer lines. That hurts readability and there same
to be some tabs in there that make it worse.


>  
> @@ -298,12 +291,11 @@ static int bmc150_magn_set_odr(struct bmc150_magn_data *data, int val)
>  
>  	for (i = 0; i < ARRAY_SIZE(bmc150_magn_samp_freq_table); i++) {
>  		if (bmc150_magn_samp_freq_table[i].freq == val) {
> -			ret = regmap_update_bits(data->regmap,
> -						 BMC150_MAGN_REG_OPMODE_ODR,
> -						 BMC150_MAGN_MASK_ODR,
> -						 bmc150_magn_samp_freq_table[i].
> -						 reg_val <<
> -						 BMC150_MAGN_SHIFT_ODR);
> +			ret = regmap_update_bits(
> +				data->regmap, BMC150_MAGN_REG_OPMODE_ODR,
> +				BMC150_MAGN_MASK_ODR,
> +				bmc150_magn_samp_freq_table[i].reg_val
> +					<< BMC150_MAGN_SHIFT_ODR);

This remains ugly after the reformat. I'd use a local variable for the shifted
reg_val then keep the original style.

>  	data->max_odr = max_odr;
> @@ -363,10 +354,15 @@ static s32 bmc150_magn_compensate_x(struct bmc150_magn_trim_regs *tregs, s16 x,
>  		rhall = xyz1;
>  
>  	val = ((s16)(((u16)((((s32)xyz1) << 14) / rhall)) - ((u16)0x4000)));
> -	val = ((s16)((((s32)x) * ((((((((s32)tregs->xy2) * ((((s32)val) *
> -	      ((s32)val)) >> 7)) + (((s32)val) *
> -	      ((s32)(((s16)tregs->xy1) << 7)))) >> 9) + ((s32)0x100000)) *
> -	      ((s32)(((s16)tregs->x2) + ((s16)0xA0)))) >> 12)) >> 13)) +
> +	val = ((s16)((((s32)x) *
> +		      ((((((((s32)tregs->xy2) *
> +			    ((((s32)val) * ((s32)val)) >> 7)) +
> +			   (((s32)val) * ((s32)(((s16)tregs->xy1) << 7)))) >>
> +			  9) +
> +			 ((s32)0x100000)) *
> +			((s32)(((s16)tregs->x2) + ((s16)0xA0)))) >>
> +		       12)) >>
> +		     13)) +
>  	      (((s16)tregs->x1) << 3);
>  
>  	return (s32)val;
> @@ -385,10 +381,15 @@ static s32 bmc150_magn_compensate_y(struct bmc150_magn_trim_regs *tregs, s16 y,
>  		rhall = xyz1;
>  
>  	val = ((s16)(((u16)((((s32)xyz1) << 14) / rhall)) - ((u16)0x4000)));
> -	val = ((s16)((((s32)y) * ((((((((s32)tregs->xy2) * ((((s32)val) *
> -	      ((s32)val)) >> 7)) + (((s32)val) *
> -	      ((s32)(((s16)tregs->xy1) << 7)))) >> 9) + ((s32)0x100000)) *
> -	      ((s32)(((s16)tregs->y2) + ((s16)0xA0)))) >> 12)) >> 13)) +
> +	val = ((s16)((((s32)y) *
> +		      ((((((((s32)tregs->xy2) *
> +			    ((((s32)val) * ((s32)val)) >> 7)) +
> +			   (((s32)val) * ((s32)(((s16)tregs->xy1) << 7)))) >>
> +			  9) +
> +			 ((s32)0x100000)) *
> +			((s32)(((s16)tregs->y2) + ((s16)0xA0)))) >>
> +		       12)) >>
> +		     13)) +
>  	      (((s16)tregs->y1) << 3);

There may be some improvements possible here, but some things
like having the shifts on separate lines definitely don't help.  Just have
some slightly long lines if that is useful to reformatting this.


> @@ -445,8 +447,8 @@ static int bmc150_magn_read_xyz(struct bmc150_magn_data *data, s32 *buffer)
>  }
>  
>  static int bmc150_magn_read_raw(struct iio_dev *indio_dev,
> -				struct iio_chan_spec const *chan,
> -				int *val, int *val2, long mask)
> +				struct iio_chan_spec const *chan, int *val,
> +				int *val2, long mask)
>  {
>  	struct bmc150_magn_data *data = iio_priv(indio_dev);
>  	int ret, tmp;
> @@ -456,29 +458,23 @@ static int bmc150_magn_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_RAW:
>  		if (iio_buffer_enabled(indio_dev))
>  			return -EBUSY;
> -		mutex_lock(&data->mutex);
> +		guard(mutex)(&data->mutex);

As below. Make sure the scope is clear when using scope based cleanup.
This is making a declaration (hidden by the macro) and we are normally
careful to define scope for those as well.


>  
>  		ret = bmc150_magn_set_power_state(data, true);
> -		if (ret < 0) {
> -			mutex_unlock(&data->mutex);
> +		if (ret < 0)
>  			return ret;
> -		}
>  
>  		ret = bmc150_magn_read_xyz(data, values);
>  		if (ret < 0) {
>  			bmc150_magn_set_power_state(data, false);
> -			mutex_unlock(&data->mutex);
>  			return ret;
>  		}
>  		*val = values[chan->scan_index];
>  
>  		ret = bmc150_magn_set_power_state(data, false);
> -		if (ret < 0) {
> -			mutex_unlock(&data->mutex);
> +		if (ret < 0)
>  			return ret;
> -		}
>  
> -		mutex_unlock(&data->mutex);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		/*
> @@ -520,8 +516,8 @@ static int bmc150_magn_read_raw(struct iio_dev *indio_dev,
>  }
>  
>  static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
> -				 struct iio_chan_spec const *chan,
> -				 int val, int val2, long mask)
> +				 struct iio_chan_spec const *chan, int val,
> +				 int val2, long mask)
>  {
>  	struct bmc150_magn_data *data = iio_priv(indio_dev);
>  	int ret;
> @@ -530,45 +526,33 @@ static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (val > data->max_odr)
>  			return -EINVAL;
> -		mutex_lock(&data->mutex);
> -		ret = bmc150_magn_set_odr(data, val);
> -		mutex_unlock(&data->mutex);
> -		return ret;
> +		guard(mutex)(&data->mutex);

What is the scope of this guard(). I.e. where is it cleaned up?
Generally if using it in a case block, we add scope so that is
clearl defined.


> +		return bmc150_magn_set_odr(data, val);
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		switch (chan->channel2) {
>  		case IIO_MOD_X:
>  		case IIO_MOD_Y:
>  			if (val < 1 || val > 511)
>  				return -EINVAL;
> -			mutex_lock(&data->mutex);
> +			guard(mutex)(&data->mutex);

Same with this one.

>  			ret = bmc150_magn_set_max_odr(data, val, 0, 0);
> -			if (ret < 0) {
> -				mutex_unlock(&data->mutex);
> +			if (ret < 0)
>  				return ret;
> -			}
> -			ret = regmap_update_bits(data->regmap,
> -						 BMC150_MAGN_REG_REP_XY,
> -						 BMC150_MAGN_REG_REP_DATAMASK,
> -						 BMC150_MAGN_REPXY_TO_REGVAL
> -						 (val));
> -			mutex_unlock(&data->mutex);
> -			return ret;
> +			return regmap_update_bits(
> +				data->regmap, BMC150_MAGN_REG_REP_XY,
> +				BMC150_MAGN_REG_REP_DATAMASK,
> +				BMC150_MAGN_REPXY_TO_REGVAL(val));
>  		case IIO_MOD_Z:
>  			if (val < 1 || val > 256)
>  				return -EINVAL;
> -			mutex_lock(&data->mutex);
> +			guard(mutex)(&data->mutex);
And this one.
>  			ret = bmc150_magn_set_max_odr(data, 0, val, 0);
> -			if (ret < 0) {
> -				mutex_unlock(&data->mutex);
> +			if (ret < 0)
>  				return ret;
> -			}
> -			ret = regmap_update_bits(data->regmap,
> -						 BMC150_MAGN_REG_REP_Z,
> -						 BMC150_MAGN_REG_REP_DATAMASK,
> -						 BMC150_MAGN_REPZ_TO_REGVAL
> -						 (val));
> -			mutex_unlock(&data->mutex);
> -			return ret;
> +			return regmap_update_bits(
> +				data->regmap, BMC150_MAGN_REG_REP_Z,
> +				BMC150_MAGN_REG_REP_DATAMASK,
> +				BMC150_MAGN_REPZ_TO_REGVAL(val));
>  		default:
>  			return -EINVAL;
>  		}
> @@ -600,7 +584,7 @@ static ssize_t bmc150_magn_show_samp_freq_avail(struct device *dev,
>  
>  static const struct iio_mount_matrix *
>  bmc150_magn_get_mount_matrix(const struct iio_dev *indio_dev,
> -			      const struct iio_chan_spec *chan)
> +			     const struct iio_chan_spec *chan)
>  {
>  	struct bmc150_magn_data *data = iio_priv(indio_dev);
>  
> @@ -609,7 +593,7 @@ bmc150_magn_get_mount_matrix(const struct iio_dev *indio_dev,
>  
>  static const struct iio_chan_spec_ext_info bmc150_magn_ext_info[] = {
>  	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bmc150_magn_get_mount_matrix),
> -	{ }
> +	{}

We are actually slowly enforcing standardisation in IIO to have
the space. It's an arbitrary choice but it's the one we've gone with.

>  };
>  
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(bmc150_magn_show_samp_freq_avail);
> @@ -623,23 +607,22 @@ static const struct attribute_group bmc150_magn_attrs_group = {
>  	.attrs = bmc150_magn_attributes,
>  };
>  
> -#define BMC150_MAGN_CHANNEL(_axis) {					\
> -	.type = IIO_MAGN,						\
> -	.modified = 1,							\
> -	.channel2 = IIO_MOD_##_axis,					\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> -			      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
> -				    BIT(IIO_CHAN_INFO_SCALE),		\
> -	.scan_index = AXIS_##_axis,					\
> -	.scan_type = {							\
> -		.sign = 's',						\
> -		.realbits = 32,						\
> -		.storagebits = 32,					\
> -		.endianness = IIO_LE					\
> -	},								\
> -	.ext_info = bmc150_magn_ext_info,				\
> -}
> +#define BMC150_MAGN_CHANNEL(_axis)                                           \
> +	{                                                                    \

Why?  What benefit does this style bring over the original?
To me the original is the better of the two.

> +		.type = IIO_MAGN,                                            \
> +		.modified = 1,                                               \
> +		.channel2 = IIO_MOD_##_axis,                                 \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |               \
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) |   \
> +					    BIT(IIO_CHAN_INFO_SCALE),        \
> +		.scan_index = AXIS_##_axis,                                  \
> +		.scan_type = { .sign = 's',                                  \
> +			       .realbits = 32,                               \
> +			       .storagebits = 32,                            \
> +			       .endianness = IIO_LE },                       \
> +		.ext_info = bmc150_magn_ext_info,                            \
> +	}
>  
>  static const struct iio_chan_spec bmc150_magn_channels[] = {
>  	BMC150_MAGN_CHANNEL(X),
> @@ -655,8 +638,8 @@ static const struct iio_info bmc150_magn_info = {
>  };
>  
>  static const unsigned long bmc150_magn_scan_masks[] = {
> -					BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
> -					0};
> +	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z), 0
Keep to one per line, but otherwise this formatting can indeed be improved.

> +};
>  
>  static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
>  {
> @@ -665,7 +648,8 @@ static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
>  	struct bmc150_magn_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&data->mutex);
> +	guard(mutex)(&data->mutex);
> +
>  	ret = bmc150_magn_read_xyz(data, data->scan.chans);
>  	if (ret < 0)
>  		goto err;
> @@ -674,7 +658,7 @@ static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
>  				    pf->timestamp);
>  
>  err:
> -	mutex_unlock(&data->mutex);
Read the guidance in cleanup.h  General rule is never combine use of anything
in there with a goto.  It explains why such combinations are fragile if not necessarily
buggy. I would just leave this function alone. Sometimes guard() is just not the right
tool for the job and we should stick to mutex_lock() / mutex_unlock()

> +
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> @@ -695,7 +679,7 @@ static int bmc150_magn_init(struct bmc150_magn_data *data)
>  	 * 3ms power-on time according to datasheet, let's better
>  	 * be safe than sorry and set this delay to 5ms.
>  	 */
> -	msleep(5);
> +	usleep_range(5000, 6000);

Why?  Look at fsleep() which exists for this sort of slightly fuzzy wait a while.


> @@ -794,7 +776,7 @@ static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  	struct bmc150_magn_data *data = iio_priv(indio_dev);
> -	int ret = 0;
> +	int ret;

This looks like a different type of change.   Also, Where did the
original patch changing this to guard() go?  Looks like we have a patch
on top here rather than that change being incorporated in v4 as it should be.

>  
>  	guard(mutex)(&data->mutex);
>  
> @@ -839,8 +821,8 @@ static const struct iio_buffer_setup_ops bmc150_magn_buffer_setup_ops = {
>  	.postdisable = bmc150_magn_buffer_postdisable,
>  };
>  
> -int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
> -		      int irq, const char *name)
> +int bmc150_magn_probe(struct device *dev, struct regmap *regmap, int irq,
> +		      const char *name)
>  {
>  	struct bmc150_magn_data *data;
>  	struct iio_dev *indio_dev;
> @@ -881,10 +863,9 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
>  	indio_dev->info = &bmc150_magn_info;
>  
>  	if (irq > 0) {
> -		data->dready_trig = devm_iio_trigger_alloc(dev,
> -							   "%s-dev%d",
> -							   indio_dev->name,
> -							   iio_device_id(indio_dev));
> +		data->dready_trig =
> +			devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> +					       iio_device_id(indio_dev));
This isn't an obvious improvement.  I wouldn't have minded
either style in the original code, but as noted above any change
has costs - there is not enough benefit in this one to make it
a good thing to do.

>  		if (!data->dready_trig) {
>  			ret = -ENOMEM;
>  			dev_err(dev, "iio trigger alloc failed\n");
> @@ -899,20 +880,17 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
>  			goto err_poweroff;
>  		}
>  
> -		ret = request_threaded_irq(irq,
> -					   iio_trigger_generic_data_rdy_poll,
> -					   NULL,
> -					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> -					   "bmc150_magn_event",
> -					   data->dready_trig);
> +		ret = request_threaded_irq(
> +			irq, iio_trigger_generic_data_rdy_poll, NULL,
> +			IRQF_TRIGGER_RISING | IRQF_ONESHOT, "bmc150_magn_event",
> +			data->dready_trig);

Why this change? If anything the original formatting was the preferred
option when the lines aren't really long (well over 80 chars)

>  		if (ret < 0) {
>  			dev_err(dev, "request irq %d failed\n", irq);
>  			goto err_trigger_unregister;
>  		}
>  	}
>  
> -	ret = iio_triggered_buffer_setup(indio_dev,
> -					 iio_pollfunc_store_time,
> +	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
>  					 bmc150_magn_trigger_handler,
>  					 &bmc150_magn_buffer_setup_ops);
This change is fine but alignment and white space changes belong in 
a patch that does nothing else. In here they are adding noise and
making it harder to see the real changes.

>  	if (ret < 0) {
> @@ -973,9 +951,11 @@ void bmc150_magn_remove(struct device *dev)
>  	if (data->dready_trig)
>  		iio_trigger_unregister(data->dready_trig);
>  
> -	mutex_lock(&data->mutex);
> -	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);
> -	mutex_unlock(&data->mutex);
> +	{
No to this style.
It's harder to read.

	scoped_guard(mutex, &data->mutex)
		bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND,
					   true);

or something along those lines is what should be done when a short scope
is needed.

> +		guard(mutex)(&data->mutex);
> +		bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND,
> +					   true);
> +	}
>  
>  	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
>  }

> @@ -1033,10 +1011,9 @@ static int bmc150_magn_resume(struct device *dev)
>  	struct bmc150_magn_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&data->mutex);
> +	guard(mutex)(&data->mutex);
>  	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
>  					 true);
> -	mutex_unlock(&data->mutex);
>  
>  	return ret;
Consider what you end up with here. The use of guard allow simple
improvements to the code that weren't possible without it.
	return bmc...
Note this is part of the switch to guard() so belongs in the patch
that does that.

>  }
> @@ -1044,8 +1021,8 @@ static int bmc150_magn_resume(struct device *dev)
>  
>  const struct dev_pm_ops bmc150_magn_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(bmc150_magn_suspend, bmc150_magn_resume)
> -	SET_RUNTIME_PM_OPS(bmc150_magn_runtime_suspend,
> -			   bmc150_magn_runtime_resume, NULL)
> +		SET_RUNTIME_PM_OPS(bmc150_magn_runtime_suspend,
> +				   bmc150_magn_runtime_resume, NULL)

This is wrong. Take a look at what those macros do... 
Key is the comma is there just in side the macro.


>  };
>  EXPORT_SYMBOL_NS(bmc150_magn_pm_ops, "IIO_BMC150_MAGN");
>  

