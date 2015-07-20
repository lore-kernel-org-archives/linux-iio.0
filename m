Return-Path: <cmo@melexis.com>
MIME-Version: 1.0
In-Reply-To: <55AD3645.4000801@kernel.org>
References: <CAKv63utwT_KTvTYcOogAWQ4NUcVUsAFvFgWwqa2rZ+5+1bM7Cw@mail.gmail.com>
 <55AB8B13.7090907@kernel.org> <CAKv63ut35A_f2P_xdrtCtsc8mPztDx1h2PaFz4JYC1r5NhR-Ww@mail.gmail.com>
 <55AD3645.4000801@kernel.org>
From: Crt Mori <cmo@melexis.com>
Date: Mon, 20 Jul 2015 21:09:45 +0200
Message-ID: <CAKv63ut5O7J3UuDRPthnmWRYZSFT9+n39uXv6L+C7aoZW6TLrQ@mail.gmail.com>
Subject: Re: [PATCH] iio: mlx90614: Define magic numbers
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	=?UTF-8?Q?Vianney_le_Cl=C3=A9ment_de_Saint=2DMarcq?= <vianney.leclement@essensium.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 20 July 2015 at 19:56, Jonathan Cameron <jic23@kernel.org> wrote:
> On 19/07/15 21:14, Crt Mori wrote:
>> Translates the magic constant numbers to named macros and add some
>> additional comments about their meaning.
>>
>> The diff is made towards togreg branch as that branch seems to have the
>> most recent updates of mlx90614 driver (many are yet to be merged).
>>
>> Signed-off-by: Crt Mori <cmo@melexis.com <mailto:cmo@melexis.com>>
>> Acked-by: Peter Meerwald <pmeerw@pmeerw.net <mailto:pmeerw@pmeerw.net>>
> Hi Crt,
>
> Sorry to be a pain.  Could you send this as a fresh patch on it's own.
> It's tricky to use standard tools to pull it out of an email like this.
>
> Also, could you check the spacing below as I think your email client
> may have eaten some.
>
> J
No problem. I gotta master this gmail with patches if I want to send
stuff in future. I hope
other patches came through in better state. I hope it got through now OK.

Crt

>> ---
>>  drivers/iio/temperature/mlx90614.c | 20 ++++++++++++++------
>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/temperature/mlx90614.c
>> b/drivers/iio/temperature/mlx90614.c
>> index cb2e8ad..909278a 100644
>> --- a/drivers/iio/temperature/mlx90614.c
>> +++ b/drivers/iio/temperature/mlx90614.c
>> @@ -65,6 +65,13 @@
>>
>>  #define MLX90614_AUTOSLEEP_DELAY 5000 /* default autosleep delay */
>>
>> +/* Magic constants */
>> +#define MLX90614_CONST_OFFSET_DEC -13657 /* decimal part of the
>> Kelvin offset */
>> +#define MLX90614_CONST_OFFSET_REM 500000 /* remainder of offset (273.15*50) */
>> +#define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */
>> +#define MLX90614_CONST_RAW_EMISSIVITY_MAX 65535 /* max value for emissivity */
>> +#define MLX90614_CONST_EMISSIVITY_RESOLUTION 15259 /* 1/65535 ~ 0.000015259 */
>> +
>>  struct mlx90614_data {
>> struct i2c_client *client;
>> struct mutex lock; /* for EEPROM access only */
>> @@ -204,11 +211,11 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>> *val = ret;
>> return IIO_VAL_INT;
>> case IIO_CHAN_INFO_OFFSET:
>> -*val = 13657;
>> -*val2 = 500000;
>> +*val = MLX90614_CONST_OFFSET_DEC;
>> +*val2 = MLX90614_CONST_OFFSET_REM;
>> return IIO_VAL_INT_PLUS_MICRO;
>> case IIO_CHAN_INFO_SCALE:
>> -*val = 20;
>> +*val = MLX90614_CONST_SCALE;
>> return IIO_VAL_INT;
>> case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
>> mlx90614_power_get(data, false);
>> @@ -221,12 +228,12 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>> if (ret < 0)
>> return ret;
>>
>> -if (ret == 65535) {
>> +if (ret == MLX90614_CONST_RAW_EMISSIVITY_MAX) {
>> *val = 1;
>> *val2 = 0;
>> } else {
>> *val = 0;
>> -*val2 = ret * 15259; /* 1/65535 ~ 0.000015259 */
>> +*val2 = ret * MLX90614_CONST_EMISSIVITY_RESOLUTION;
>> }
>> return IIO_VAL_INT_PLUS_NANO;
>> default:
>> @@ -245,7 +252,8 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
>> case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
>> if (val < 0 || val2 < 0 || val > 1 || (val == 1 && val2 != 0))
>> return -EINVAL;
>> -val = val * 65535 + val2 / 15259; /* 1/65535 ~ 0.000015259 */
>> +val = val * MLX90614_CONST_RAW_EMISSIVITY_MAX +
>> +val2 / MLX90614_CONST_EMISSIVITY_RESOLUTION;
>>
>> mlx90614_power_get(data, false);
>> mutex_lock(&data->lock);
>>
>>
>> On 19 July 2015 at 13:33, Jonathan Cameron <jic23@kernel.org <mailto:jic23@kernel.org>> wrote:
>>
>>     On 05/07/15 19:07, Crt Mori wrote:
>>     > Translates the magic constant numbers to named macros and add some
>>     > additional comments about their meaning.
>>     >
>>     > The diff is made towards togreg branch as that branch seems to have the
>>     > most recent updates of mlx90614 driver (many are yet to be merged).
>>     >
>>     > Signed-off-by: Crt Mori <cmo@melexis.com <mailto:cmo@melexis.com>>
>>     > Acked-by: Peter Meerwald <pmeerw@pmeerw.net <mailto:pmeerw@pmeerw.net>>
>>     Crt,
>>
>>     This patch is malformed, probably as a result of your email client.
>>     It seems to have replaced tabs with spaces meaning I can't apply this
>>     without doing it line by line.
>>
>>     Could you take a look at Documentation/SubmittingPatches and the advice
>>     in there on how to lure an email client into not messing things up.
>>
>>     If you can't persuade that to work, I will take the occasional attachment.
>>
>>     Otherwise, the patch looks fine.
>>
>>     Jonathan
>>
>> I hope it is now OK? I needed to turn off google's mail mode, and apparently plain text
>> mode also translates tabs into spaces. I have now fixed the tabs and I hope they are
>> also sent. Please let me know - I will otherwise just pull some mail client and get it
>> working.
>>
>> Crt
>>
>>
>>     > ---
>>     >  drivers/iio/temperature/mlx90614.c | 20 ++++++++++++++------
>>     >  1 file changed, 14 insertions(+), 6 deletions(-)
>>     >
>>     > diff --git a/drivers/iio/temperature/mlx90614.c
>>     > b/drivers/iio/temperature/mlx90614.c
>>     > index cb2e8ad..909278a 100644
>>     > --- a/drivers/iio/temperature/mlx90614.c
>>     > +++ b/drivers/iio/temperature/mlx90614.c
>>     > @@ -65,6 +65,13 @@
>>     >
>>     >  #define MLX90614_AUTOSLEEP_DELAY 5000 /* default autosleep delay */
>>     >
>>     > +/* Magic constants */
>>     > +#define MLX90614_CONST_OFFSET_DEC -13657 /* decimal part of the
>>     > Kelvin offset */
>>     > +#define MLX90614_CONST_OFFSET_REM 500000 /* remainder of offset (273.15*50) */
>>     > +#define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */
>>     > +#define MLX90614_CONST_RAW_EMISSIVITY_MAX 65535 /* max value for emissivity */
>>     > +#define MLX90614_CONST_EMISSIVITY_RESOLUTION 15259 /* 1/65535 ~ 0.000015259 */
>>     > +
>>     >  struct mlx90614_data {
>>     >         struct i2c_client *client;
>>     >         struct mutex lock; /* for EEPROM access only */
>>     > @@ -204,11 +211,11 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>>     >                 *val = ret;
>>     >                 return IIO_VAL_INT;
>>     >         case IIO_CHAN_INFO_OFFSET:
>>     > -               *val = 13657;
>>     > -               *val2 = 500000;
>>     > +               *val = MLX90614_CONST_OFFSET_DEC;
>>     > +               *val2 = MLX90614_CONST_OFFSET_REM;
>>     >                 return IIO_VAL_INT_PLUS_MICRO;
>>     >         case IIO_CHAN_INFO_SCALE:
>>     > -               *val = 20;
>>     > +               *val = MLX90614_CONST_SCALE;
>>     >                 return IIO_VAL_INT;
>>     >         case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
>>     >                 mlx90614_power_get(data, false);
>>     > @@ -221,12 +228,12 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>>     >                 if (ret < 0)
>>     >                         return ret;
>>     >
>>     > -               if (ret == 65535) {
>>     > +               if (ret == MLX90614_CONST_RAW_EMISSIVITY_MAX) {
>>     >                         *val = 1;
>>     >                         *val2 = 0;
>>     >                 } else {
>>     >                         *val = 0;
>>     > -                       *val2 = ret * 15259; /* 1/65535 ~ 0.000015259 */
>>     > +                       *val2 = ret * MLX90614_CONST_EMISSIVITY_RESOLUTION;
>>     >                 }
>>     >                 return IIO_VAL_INT_PLUS_NANO;
>>     >         default:
>>     > @@ -245,7 +252,8 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
>>     >         case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
>>     >                 if (val < 0 || val2 < 0 || val > 1 || (val == 1 && val2 != 0))
>>     >                         return -EINVAL;
>>     > -               val = val * 65535 + val2 / 15259; /* 1/65535 ~ 0.000015259 */
>>     > +               val = val * MLX90614_CONST_RAW_EMISSIVITY_MAX +
>>     > +                       val2 / MLX90614_CONST_EMISSIVITY_RESOLUTION;
>>     >
>>     >                 mlx90614_power_get(data, false);
>>     >                 mutex_lock(&data->lock);
>>     >
>>
>>
>
