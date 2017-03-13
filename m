Return-Path: <SRS0=+KzK=2W=gmail.com=singhalsimran0@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170312183121.GA7728@d830.WORKGROUP>
References: <20170312131052.GA21816@singhal-Inspiron-5558> <20170312183121.GA7728@d830.WORKGROUP>
From: SIMRAN SINGHAL <singhalsimran0@gmail.com>
Date: Mon, 13 Mar 2017 17:59:31 +0530
Message-ID: <CALrZqyO1GHEcwHDiC00SGVWiB1v2+JLU4E8PwxW8z0yNt62MXw@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: adis16060_core: Use private
 driver lock instead of mlock
To: Alison Schofield <amsfield22@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	outreachy-kernel <outreachy-kernel@googlegroups.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 13, 2017 at 12:01 AM, Alison Schofield <amsfield22@gmail.com> wrote:
> On Sun, Mar 12, 2017 at 06:40:52PM +0530, simran singhal wrote:
>> The IIO subsystem is redefining iio_dev->mlock to be used by
>> the IIO core only for protecting device operating mode changes.
>> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
>>
>> In this driver, mlock was being used to protect hardware state
>> changes.  Replace it with a lock in the devices global data.
>>
>> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
>
> This does not compile.
> alisons
>
Alison, this is compiling fine for me.
I tried it again using:
$make clean
$make allyesconfig
$make drivers/staging/iio/gyro/adis16060_core.o

>> ---
>>  drivers/staging/iio/gyro/adis16060_core.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
>> index c9d46e7..90a3a18 100644
>> --- a/drivers/staging/iio/gyro/adis16060_core.c
>> +++ b/drivers/staging/iio/gyro/adis16060_core.c
>> @@ -29,11 +29,13 @@
>>   * @us_r:            actual spi_device to read back data
>>   * @buf:             transmit or receive buffer
>>   * @buf_lock:                mutex to protect tx and rx
>> + * @lock:            protect sensor state
>>   **/
>>  struct adis16060_state {
>>       struct spi_device               *us_w;
>>       struct spi_device               *us_r;
>>       struct mutex                    buf_lock;
>> +     struct mutex                    lock;    /* protect sensor state */
>>
>>       u8 buf[3] ____cacheline_aligned;
>>  };
>> @@ -87,7 +89,7 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
>>       switch (mask) {
>>       case IIO_CHAN_INFO_RAW:
>>               /* Take the iio_dev status lock */
>> -             mutex_lock(&indio_dev->mlock);
>> +             mutex_lock(&st->lock);
>>               ret = adis16060_spi_write(indio_dev, chan->address);
>>               if (ret < 0)
>>                       goto out_unlock;
>> @@ -96,7 +98,7 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
>>               if (ret < 0)
>>                       goto out_unlock;
>>
>> -             mutex_unlock(&indio_dev->mlock);
>> +             mutex_unlock(&st->lock);
>>               *val = tval;
>>               return IIO_VAL_INT;
>>       case IIO_CHAN_INFO_OFFSET:
>> @@ -112,7 +114,7 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
>>       return -EINVAL;
>>
>>  out_unlock:
>> -     mutex_unlock(&indio_dev->mlock);
>> +     mutex_unlock(&st->lock);
>>       return ret;
>>  }
>>
>> --
>> 2.7.4
>>
>> --
>> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
>> To post to this group, send email to outreachy-kernel@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170312131052.GA21816%40singhal-Inspiron-5558.
>> For more options, visit https://groups.google.com/d/optout.
