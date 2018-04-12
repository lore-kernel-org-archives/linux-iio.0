Return-Path: <SRS0=pK0i=HB=konsulko.com=matt.ranostay@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180412012559.GC17901@osadl.at>
References: <20180410061822.12750-1-matt.ranostay@konsulko.com> <20180412012559.GC17901@osadl.at>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Wed, 11 Apr 2018 20:52:49 -0700
Message-ID: <CAJCx=gkOwabBczXtpt=03=U+nVVSwq2fZhyHOPYY0OEjEsPWdw@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: use msleep() for long
 uncritical delays
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Nicholas Mc Guire <hofrat@osadl.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Wed, Apr 11, 2018 at 6:25 PM, Nicholas Mc Guire <der.herr@hofr.at> wrote:
> On Mon, Apr 09, 2018 at 11:18:22PM -0700, Matt Ranostay wrote:
>> usleep_range() uses hrtimers and provides no advantage over msleep()
>> for larger delays.
>>
>
> As the ATLAS_*_INT_TIME_IN_MS delays here are used exclusively for the
> usleep_ranges in the sustepnd case I guess that transformation is fine.

Yeah only reason I submitted it. Probably a bit pedantic I'll admit :)

>
>> Cc: Nicholas Mc Guire <hofrat@osadl.org>
>> Link: http://lkml.org/lkml/2017/1/11/377
>> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> Reviewed-by: Nicholas Mc Guire <hofrat@osadl.org>
>
>> ---
>>  drivers/iio/chemical/atlas-ph-sensor.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
>> index abfc4bbc4cfc..a406ad31b096 100644
>> --- a/drivers/iio/chemical/atlas-ph-sensor.c
>> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
>> @@ -61,9 +61,9 @@
>>  #define ATLAS_REG_ORP_CALIB_STATUS   0x0d
>>  #define ATLAS_REG_ORP_DATA           0x0e
>>
>> -#define ATLAS_PH_INT_TIME_IN_US              450000
>> -#define ATLAS_EC_INT_TIME_IN_US              650000
>> -#define ATLAS_ORP_INT_TIME_IN_US     450000
>> +#define ATLAS_PH_INT_TIME_IN_MS              450
>> +#define ATLAS_EC_INT_TIME_IN_MS              650
>> +#define ATLAS_ORP_INT_TIME_IN_MS     450
>>
>>  enum {
>>       ATLAS_PH_SM,
>> @@ -270,21 +270,21 @@ static struct atlas_device atlas_devices[] = {
>>                               .num_channels = 3,
>>                               .data_reg = ATLAS_REG_PH_DATA,
>>                               .calibration = &atlas_check_ph_calibration,
>> -                             .delay = ATLAS_PH_INT_TIME_IN_US,
>> +                             .delay = ATLAS_PH_INT_TIME_IN_MS,
>>       },
>>       [ATLAS_EC_SM] = {
>>                               .channels = atlas_ec_channels,
>>                               .num_channels = 5,
>>                               .data_reg = ATLAS_REG_EC_DATA,
>>                               .calibration = &atlas_check_ec_calibration,
>> -                             .delay = ATLAS_EC_INT_TIME_IN_US,
>> +                             .delay = ATLAS_EC_INT_TIME_IN_MS,
>>       },
>>       [ATLAS_ORP_SM] = {
>>                               .channels = atlas_orp_channels,
>>                               .num_channels = 2,
>>                               .data_reg = ATLAS_REG_ORP_DATA,
>>                               .calibration = &atlas_check_orp_calibration,
>> -                             .delay = ATLAS_ORP_INT_TIME_IN_US,
>> +                             .delay = ATLAS_ORP_INT_TIME_IN_MS,
>>       },
>>  };
>>
>> @@ -393,7 +393,7 @@ static int atlas_read_measurement(struct atlas_data *data, int reg, __be32 *val)
>>       }
>>
>>       if (suspended)
>> -             usleep_range(data->chip->delay, data->chip->delay + 100000);
>> +             msleep(data->chip->delay);
>>
>>       ret = regmap_bulk_read(data->regmap, reg, (u8 *) val, sizeof(*val));
>>
>> --
>> 2.14.1
>>
