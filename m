Return-Path: <SRS0=Iban=3A=gmail.com=singhalsimran0@kernel.org>
MIME-Version: 1.0
In-Reply-To: <5d65a41d-5290-eb55-6452-7bb8bfbdd9f2@kernel.org>
References: <1490119436-20042-1-git-send-email-singhalsimran0@gmail.com>
 <1490119436-20042-3-git-send-email-singhalsimran0@gmail.com> <5d65a41d-5290-eb55-6452-7bb8bfbdd9f2@kernel.org>
From: SIMRAN SINGHAL <singhalsimran0@gmail.com>
Date: Thu, 23 Mar 2017 23:42:33 +0530
Message-ID: <CALrZqyPkBCfAwr7=nO7QLXDfyC6cATDFmxFr32aSN+3D=jr8TQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] staging: iio: ade7753: Replace mlock with driver
 private lock
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	outreachy-kernel <outreachy-kernel@googlegroups.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Mar 23, 2017 at 1:55 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 21/03/17 18:03, simran singhal wrote:
>> The IIO subsystem is redefining iio_dev->mlock to be used by
>> the IIO core only for protecting device operating mode changes.
>> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
>>
>> In this driver, mlock was being used to protect hardware state
>> changes.  Replace it with a lock in the devices global data.
>>
>> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
> Mutex is not initialized...

Mutex is already initialized in ade7753_probe().

>> ---
>>  drivers/staging/iio/meter/ade7753.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
>> index b71fbd3..9674e05 100644
>> --- a/drivers/staging/iio/meter/ade7753.c
>> +++ b/drivers/staging/iio/meter/ade7753.c
>> @@ -80,11 +80,13 @@
>>   * @us:         actual spi_device
>>   * @tx:         transmit buffer
>>   * @rx:         receive buffer
>> + * @lock:       protect sensor state
>>   * @buf_lock:       mutex to protect tx and rx
>>   **/
>>  struct ade7753_state {
>>       struct spi_device   *us;
>>       struct mutex        buf_lock;
>> +     struct mutex        lock;  /* protect sensor state */
>>       u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
>>       u8          rx[ADE7753_MAX_RX];
>>  };
>> @@ -484,7 +486,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
>>       if (!val)
>>               return -EINVAL;
>>
>> -     mutex_lock(&indio_dev->mlock);
>> +     mutex_lock(&st->lock);
>>
>>       t = 27900 / val;
>>       if (t > 0)
>> @@ -505,7 +507,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
>>       ret = ade7753_spi_write_reg_16(dev, ADE7753_MODE, reg);
>>
>>  out:
>> -     mutex_unlock(&indio_dev->mlock);
>> +     mutex_unlock(&st->lock);
>>
>>       return ret ? ret : len;
>>  }
>>
>
