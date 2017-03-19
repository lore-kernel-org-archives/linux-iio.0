Return-Path: <SRS0=PUWh=24=gmail.com=singhalsimran0@kernel.org>
MIME-Version: 1.0
In-Reply-To: <9d3c64ac-c7ae-fe6f-9afc-8cfd7931fb61@kernel.org>
References: <20170318184428.GA12858@singhal-Inspiron-5558> <9d3c64ac-c7ae-fe6f-9afc-8cfd7931fb61@kernel.org>
From: SIMRAN SINGHAL <singhalsimran0@gmail.com>
Date: Sun, 19 Mar 2017 15:54:20 +0530
Message-ID: <CALrZqyPYPY1KR3c2-dgdh5wJZ5mfGbbbVngxW57M9e_fqKX8wQ@mail.gmail.com>
Subject: Re: [PATCH v4] staging: Use buf_lock instead of mlock and Refactor code
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	outreachy-kernel <outreachy-kernel@googlegroups.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Mar 19, 2017 at 3:45 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 18/03/17 18:44, simran singhal wrote:
>> The IIO subsystem is redefining iio_dev->mlock to be used by
>> the IIO core only for protecting device operating mode changes.
>> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
>>
>> In this driver, mlock was being used to protect hardware state
>> changes. Replace it with buf_lock in the devices global data.
>>
>> As buf_lock protects both the adis16060_spi_write() and
>> adis16060_spi_read() functions and both are always called in
>> pair. First write, then read. Thus, refactor the code to have
>> one single function adis16060_spi_write_than_read() which is
>> protected by the existing buf_lock.
>>
>> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
> Hi Simran,
>
> A couple of minor comments and opportunity to further improve
> the, now simpler, code flow.
>
> Thanks,
>
> Jonathan
>> ---
>>
>>  v4:
>>    -Refactored code
>>    -change commit subject
>>    -change commit message
>>
>>  drivers/staging/iio/gyro/adis16060_core.c | 37 ++++++++++++-------------------
>>  1 file changed, 14 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
>> index c9d46e7..39ddd55 100644
>> --- a/drivers/staging/iio/gyro/adis16060_core.c
>> +++ b/drivers/staging/iio/gyro/adis16060_core.c
>> @@ -40,7 +40,7 @@ struct adis16060_state {
>>
>>  static struct iio_dev *adis16060_iio_dev;
>>
>> -static int adis16060_spi_write(struct iio_dev *indio_dev, u8 val)
>> +static int adis16060_spi_write_than_read(struct iio_dev *indio_dev, u8 val, u16 *val2)
> val and val2 often have specific meanings in IIO.  I'd prefer these to be renamed to
> val => conf (as it sets the configuration) and val2 => val.
>>  {
>>       int ret;
>>       struct adis16060_state *st = iio_priv(indio_dev);
>> @@ -48,17 +48,11 @@ static int adis16060_spi_write(struct iio_dev *indio_dev, u8 val)
>>       mutex_lock(&st->buf_lock);
>>       st->buf[2] = val; /* The last 8 bits clocked in are latched */
>>       ret = spi_write(st->us_w, st->buf, 3);
>> -     mutex_unlock(&st->buf_lock);
>>
>> -     return ret;
>> -}
>> -
>> -static int adis16060_spi_read(struct iio_dev *indio_dev, u16 *val)
>> -{
>> -     int ret;
>> -     struct adis16060_state *st = iio_priv(indio_dev);
>> -
>> -     mutex_lock(&st->buf_lock);
>> +     if (ret < 0) {
>> +             mutex_unlock(&st->buf_lock);
>> +             return ret;
>> +     }
>>
>>       ret = spi_read(st->us_r, st->buf, 3);
>>
>> @@ -67,10 +61,10 @@ static int adis16060_spi_read(struct iio_dev *indio_dev, u16 *val)
>>        * starts to place data MSB first on the DOUT line at
>>        * the 6th falling edge of SCLK
>>        */
>> -     if (!ret)
>> -             *val = ((st->buf[0] & 0x3) << 12) |
>> -                     (st->buf[1] << 4) |
>> -                     ((st->buf[2] >> 4) & 0xF);
>> +        if (!ret)
> Please run checkpatch.pl over your patches.  Looks like
> you ended up with spaces instead of a tab in the line above.

OOPS! My bad should have run checkpatch.pl
over patch.

Will correct all the checkpatch.pl issues and resend.

>> +             *val2 = ((st->buf[0] & 0x3) << 12) |
>> +                      (st->buf[1] << 4) |
>> +                      ((st->buf[2] >> 4) & 0xF);
>>       mutex_unlock(&st->buf_lock);
>>
>>       return ret;
>> @@ -83,20 +77,17 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
>>  {
>>       u16 tval = 0;
>>       int ret;
>> +     struct adis16060_state *st = iio_priv(indio_dev);
>>
>>       switch (mask) {
>>       case IIO_CHAN_INFO_RAW:
>>               /* Take the iio_dev status lock */
>> -             mutex_lock(&indio_dev->mlock);
>> -             ret = adis16060_spi_write(indio_dev, chan->address);
>> +             mutex_lock(&st->buf_lock);
>> +             ret = adis16060_spi_write_than_read(indio_dev, chan->address, &tval);
>>               if (ret < 0)
>>                       goto out_unlock;
>>
>> -             ret = adis16060_spi_read(indio_dev, &tval);
>> -             if (ret < 0)
> This ugly goto construction arguably made sense when there were two of them.  Now
> you have only one just bring the mutex_unlock inline and return directly.

Will remove this and resend.

>> -                     goto out_unlock;
>> -
>> -             mutex_unlock(&indio_dev->mlock);
>> +             mutex_unlock(&st->buf_lock);
>>               *val = tval;
>>               return IIO_VAL_INT;
>>       case IIO_CHAN_INFO_OFFSET:
>> @@ -112,7 +103,7 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
>>       return -EINVAL;
>>
>>  out_unlock:
>> -     mutex_unlock(&indio_dev->mlock);
>> +     mutex_unlock(&st->buf_lock);
>>       return ret;
>>  }
>>
>>
>
