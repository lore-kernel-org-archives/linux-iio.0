Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59554 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbbGEMvi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 08:51:38 -0400
Message-ID: <55992857.9030702@kernel.org>
Date: Sun, 05 Jul 2015 13:51:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Crt Mori <cmo@melexis.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: mlx90614: Replace offset sign and define magic numbers
References: <CAKv63uv5RZxmtVpMMAZ=xtTwMQZ8D=LxPHQ+ZHezj=814_m6eg@mail.gmail.com> <alpine.DEB.2.02.1506291413340.16737@pmeerw.net> <CAKv63utcGsuqOvdG0iEQntomBY0ub0ze++tT=mzx2K3CCURsZg@mail.gmail.com>
In-Reply-To: <CAKv63utcGsuqOvdG0iEQntomBY0ub0ze++tT=mzx2K3CCURsZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/06/15 15:43, Crt Mori wrote:
>>> Translates the magic constant numbers to named macros and add some
>>> additional comments about their meaning. Also changed the offset to
>>> negative as usual equation is: (raw + offset)*scale and in this
>>> case offset should be negative (as we deduct 273.15 Kelvin to get
>>> temperature in Celsius)..
> 
>> On 29 June 2015 at 14:19, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>> looks good; strictly, this patch is
>> (a) a bugfix (the offset should be negative),
>> (b) cleanup to replace constants by macros.
> 
> I agree, but other things are more design than a proper change.
True, but the fix may well go via a faster route and be backported
to older kernels.  The other stuff is good, but we can take our time
with it.  Please split the patch and repost.
> 
> I would also like you to reconsider the usage of
> IIO_CHAN_INFO_PROCESSED which would report calculated value
> to avoid knowing the sensor specifics and just provide general output
> (this would avoid different calculations of final temperature for different
> sensors).
If it can't be done via a straight linear map, then processed is the
only option.  If it can then it really doesn't matter as generic
userspace will handle it just fine.
> 
>>>
>>> The diff is made towards togreg branch as that branch seems to have the
>>> most recent updates of mlx90614 driver (many are yet to be merged).
>>>
>>> Signed-off-by: Crt Mori <cmo@melexis.com>
>>> ---
>>>  drivers/iio/temperature/mlx90614.c | 20 ++++++++++++++------
>>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/iio/temperature/mlx90614.c
>>> b/drivers/iio/temperature/mlx90614.c
>>> index cb2e8ad..909278a 100644
>>> --- a/drivers/iio/temperature/mlx90614.c
>>> +++ b/drivers/iio/temperature/mlx90614.c
>>> @@ -65,6 +65,13 @@
>>>
>>>  #define MLX90614_AUTOSLEEP_DELAY 5000 /* default autosleep delay */
>>>
>>> +/* Magic constants */
>>> +#define MLX90614_CONST_OFFSET_DEC -13657 /* decimal part of the Kelvin
>>> offset */
>>> +#define MLX90614_CONST_OFFSET_REM 500000 /* remainder of offset
>>> (273.15*50) */
>>> +#define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */
>>> +#define MLX90614_CONST_RAW_EMISSIVITY_MAX 65535 /* max value for
>>> emissivity */
>>> +#define MLX90614_CONST_EMISSIVITY_RESOLUTION 15259 /* 1/65535 ~
>>> 0.000015259 */
>>> +
>>>  struct mlx90614_data {
>>>         struct i2c_client *client;
>>>         struct mutex lock; /* for EEPROM access only */
>>> @@ -204,11 +211,11 @@ static int mlx90614_read_raw(struct iio_dev
>>> *indio_dev,
>>>                 *val = ret;
>>>                 return IIO_VAL_INT;
>>>         case IIO_CHAN_INFO_OFFSET:
>>> -               *val = 13657;
>>> -               *val2 = 500000;
>>> +               *val = MLX90614_CONST_OFFSET_DEC;
>>> +               *val2 = MLX90614_CONST_OFFSET_REM;
>>>                 return IIO_VAL_INT_PLUS_MICRO;
>>>         case IIO_CHAN_INFO_SCALE:
>>> -               *val = 20;
>>> +               *val = MLX90614_CONST_SCALE;
>>>                 return IIO_VAL_INT;
>>>         case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
>>>                 mlx90614_power_get(data, false);
>>> @@ -221,12 +228,12 @@ static int mlx90614_read_raw(struct iio_dev
>>> *indio_dev,
>>>                 if (ret < 0)
>>>                         return ret;
>>>
>>> -               if (ret == 65535) {
>>> +               if (ret == MLX90614_CONST_RAW_EMISSIVITY_MAX) {
>>>                         *val = 1;
>>>                         *val2 = 0;
>>>                 } else {
>>>                         *val = 0;
>>> -                       *val2 = ret * 15259; /* 1/65535 ~ 0.000015259 */
>>> +                       *val2 = ret * MLX90614_CONST_EMISSIVITY_RESOLUTION;
>>>                 }
>>>                 return IIO_VAL_INT_PLUS_NANO;
>>>         default:
>>> @@ -245,7 +252,8 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
>>>         case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
>>>                 if (val < 0 || val2 < 0 || val > 1 || (val == 1 && val2 !=
>>> 0))
>>>                         return -EINVAL;
>>> -               val = val * 65535 + val2 / 15259; /* 1/65535 ~ 0.000015259
>>> */
>>> +               val = val * MLX90614_CONST_RAW_EMISSIVITY_MAX +
>>> +                       val2 / MLX90614_CONST_EMISSIVITY_RESOLUTION;
>>>
>>>                 mlx90614_power_get(data, false);
>>>                 mutex_lock(&data->lock);
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

