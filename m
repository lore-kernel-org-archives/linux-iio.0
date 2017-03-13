Return-Path: <SRS0=+KzK=2W=gmail.com=singhalsimran0@kernel.org>
MIME-Version: 1.0
In-Reply-To: <6e55c61d-7587-4191-1fc5-de43e26986d7@metafoo.de>
References: <20170312133250.GA7772@singhal-Inspiron-5558> <6e55c61d-7587-4191-1fc5-de43e26986d7@metafoo.de>
From: SIMRAN SINGHAL <singhalsimran0@gmail.com>
Date: Mon, 13 Mar 2017 18:03:17 +0530
Message-ID: <CALrZqyMfMvXmB4xRqxOog8eqqUE0q9WFyBAC6_ZEBc1voFJLyQ@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: ade7753: replace mlock with driver private lock
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Pete Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	outreachy-kernel <outreachy-kernel@googlegroups.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 13, 2017 at 5:30 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 03/12/2017 02:32 PM, simran singhal wrote:
>> The IIO subsystem is redefining iio_dev->mlock to be used by
>> the IIO core only for protecting device operating mode changes.
>> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
>>
>> In this driver, mlock was being used to protect hardware state
>> changes.  Replace it with a lock in the devices global data.
>>
>> Fix some coding style issues related to white space also.
>>
>> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
>> ---
>>  drivers/staging/iio/meter/ade7753.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
>> index dfd8b71..ca99d82 100644
>> --- a/drivers/staging/iio/meter/ade7753.c
>> +++ b/drivers/staging/iio/meter/ade7753.c
>> @@ -81,12 +81,14 @@
>>   * @tx:         transmit buffer
>>   * @rx:         receive buffer
>>   * @buf_lock:       mutex to protect tx and rx
>> + * @lock:    protect sensor state
>
> It might make sense to reuse the existing lock which currently protects the
> read/write functions. You can do this by introducing a variant of
> ade7753_spi_{read,write}_reg_16() that does not take a lock and use these to
> implement the read-modify-write cycle in a protected section.
>
> Looking through the driver there seem to be other places as well that do
> read-modify-write that should be protected by a lock, but currently are not.
> This might be a good task.
>

Are you trying to say that their is no need of introducing "lock",
I can using "buf_lock" only.

Thanks!

>>   **/
>>  struct ade7753_state {
>> -         struct spi_device   *us;
>> -                 struct mutex        buf_lock;
>> -                         u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
>> -                                 u8          rx[ADE7753_MAX_RX];
>> +     struct spi_device   *us;
>> +     struct mutex        buf_lock;
>> +     struct mutex        lock;       /* protect sensor state */
>> +     u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
>> +     u8          rx[ADE7753_MAX_RX];
>>  };
>>
>>  static int ade7753_spi_write_reg_8(struct device *dev,
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
