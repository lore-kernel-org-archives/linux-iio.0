Return-Path: <SRS0=+A5L=2W=gmail.com=karniksayli1995@kernel.org>
MIME-Version: 1.0
In-Reply-To: <a81ede74-f294-7ccc-5e0d-431eae058128@metafoo.de>
References: <20170313104307.GA12480@sayli-HP-15-Notebook-PC> <a81ede74-f294-7ccc-5e0d-431eae058128@metafoo.de>
From: sayli karnik <karniksayli1995@gmail.com>
Date: Mon, 13 Mar 2017 19:42:43 +0530
Message-ID: <CAKG5xWg7-wifwSp3j-PmS20puo=BkOYrs0i3J9o2YFSsL2h=_g@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: ad7192: Replace mlock with private driver lock
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: outreachy-kernel <outreachy-kernel@googlegroups.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 13, 2017 at 5:22 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 03/13/2017 11:43 AM, sayli karnik wrote:
>> indio_dev->mlock should be used by the IIO core only for protecting
>> device operating mode changes. ie. Changes between INDIO_DIRECT_MODE,
>> INDIO_BUFFER_* modes.
>> Replace mlock with a lock in the device's global data to protect
>> hardware state changes.
>>
>> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
>> ---
>>  drivers/staging/iio/adc/ad7192.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
>> index 4fc8588..bed48e7 100644
>> --- a/drivers/staging/iio/adc/ad7192.c
>> +++ b/drivers/staging/iio/adc/ad7192.c
>> @@ -162,6 +162,7 @@ struct ad7192_state {
>>       u32                             scale_avail[8][2];
>>       u8                              gpocon;
>>       u8                              devid;
>> +     struct mutex                    lock;   /* protect sensor state */
>>
>>       struct ad_sigma_delta           sd;
>>  };
>> @@ -463,10 +464,10 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
>>       case IIO_CHAN_INFO_SCALE:
>>               switch (chan->type) {
>>               case IIO_VOLTAGE:
>> -                     mutex_lock(&indio_dev->mlock);
>> +                     mutex_lock(&st->lock);
>>                       *val = st->scale_avail[AD7192_CONF_GAIN(st->conf)][0];
>>                       *val2 = st->scale_avail[AD7192_CONF_GAIN(st->conf)][1];
>> -                     mutex_unlock(&indio_dev->mlock);
>> +                     mutex_unlock(&st->lock);
>
> Sorry, but this does not make too much sense. If this is the only place
> where the lock is used there isn't really any mutual exclusion going on
> since it doesn't prevent any other code from running concurrently.
>
> The purpose of taking the lock here is that st->conf is in a consistent
> state and is not in the process of being changed.
>
So you mean indio_dev->mlock is good to go here?

>>                       return IIO_VAL_INT_PLUS_NANO;
>>               case IIO_TEMP:
>>                       *val = 0;
>>
>
