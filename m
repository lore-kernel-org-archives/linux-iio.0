Return-Path: <knaack.h@gmx.de>
Message-ID: <5581F475.50202@gmx.de>
Date: Thu, 18 Jun 2015 00:28:05 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>, Kevin Tsai <ktsai@capellamicro.com>
Subject: Re: [PATCH 5/7] iio:light:cm3323: replace unneeded variable
References: <cover.1434492557.git.knaack.h@gmx.de>	<63c03818b555d02d00697d4e245c3e95e81ea074.1434492557.git.knaack.h@gmx.de> <CAEnQRZC2ypA8tVFg61Sic5RiqXyiNhTYhGYds0JskPRcEy=_hA@mail.gmail.com>
In-Reply-To: <CAEnQRZC2ypA8tVFg61Sic5RiqXyiNhTYhGYds0JskPRcEy=_hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Daniel Baluta schrieb am 17.06.2015 um 12:14:
> On Wed, Jun 17, 2015 at 1:17 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>> In cm3323_read_raw() i is used as return variable for the integration time
>> index. The also existing return variable ret however is unused in this
>> case, although appropriate. Replace i with ret and drop it.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> 
> Fair enough.
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
> 
> Are you using a tool for finding such situations? Or just code reading ? :)

Plain code reading FTW ;-) Working through a checklist and questioning every
piece of code for its benefit.

> 
>> ---
>>  drivers/iio/light/cm3323.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
>> index 8945e0c..6bb75e7 100644
>> --- a/drivers/iio/light/cm3323.c
>> +++ b/drivers/iio/light/cm3323.c
>> @@ -153,7 +153,7 @@ static int cm3323_read_raw(struct iio_dev *indio_dev,
>>                            struct iio_chan_spec const *chan, int *val,
>>                            int *val2, long mask)
>>  {
>> -       int i, ret;
>> +       int ret;
>>         struct cm3323_data *data = iio_priv(indio_dev);
>>
>>         switch (mask) {
>> @@ -170,14 +170,14 @@ static int cm3323_read_raw(struct iio_dev *indio_dev,
>>                 return IIO_VAL_INT;
>>         case IIO_CHAN_INFO_INT_TIME:
>>                 mutex_lock(&data->mutex);
>> -               i = cm3323_get_it_bits(data);
>> -               if (i < 0) {
>> +               ret = cm3323_get_it_bits(data);
>> +               if (ret < 0) {
>>                         mutex_unlock(&data->mutex);
>> -                       return i;
>> +                       return ret;
>>                 }
>>
>> -               *val = cm3323_int_time[i].val;
>> -               *val2 = cm3323_int_time[i].val2;
>> +               *val = cm3323_int_time[ret].val;
>> +               *val2 = cm3323_int_time[ret].val2;
>>                 mutex_unlock(&data->mutex);
>>
>>                 return IIO_VAL_INT_PLUS_MICRO;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
