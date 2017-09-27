Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33625 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbdI0O5L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Sep 2017 10:57:11 -0400
Received: by mail-oi0-f67.google.com with SMTP id z73so9000124oia.0
        for <linux-iio@vger.kernel.org>; Wed, 27 Sep 2017 07:57:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170924151702.776d1ec6@archlinux>
References: <20170918065952.GA5386@himanshi-Inspiron-5558> <20170924151702.776d1ec6@archlinux>
From: Himanshi Jain <himshijain.hj@gmail.com>
Date: Wed, 27 Sep 2017 20:27:09 +0530
Message-ID: <CAKJRnmPZoDgtk0vSZydQ9MG_NUD6-NGEY9u8Nkc24vDzVZDQXQ@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: ade7753: replace mlock with driver private lock
To: Jonathan Cameron <jic23@kernel.org>
Cc: outreachy-kernel <outreachy-kernel@googlegroups.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Sep 24, 2017 at 7:47 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 18 Sep 2017 12:29:52 +0530
> Himanshi Jain <himshijain.hj@gmail.com> wrote:
>
>> Replace driver usage of mlock with driver private lock to meet the new
>> model where usage of iio_dev->mlock is being redefined as protecting
>> operating mode changes(changes between BUFFER* and DIRECT modes).
>>
>> Signed-off-by: Himanshi Jain <himshijain.hj@gmail.com>
>
> A well presented patch making a sensible change.  My only thought here
> is that ultimately we could cover bother the buffer protection and
> the state protection with a single lock.
>
> Hmm. The new lock (as was the old mlock code) is providing protection
> to ensure we end up with consistent state when changing the
> sampling frequency between the sampling frequency and the
> bus clock speed (which has different maximum values depending
> on the current sampling frequency). In similar cases we have
> expanded the meaning on the buffer lock to fulfil both roles
> - that could be done here as well, although you have to be careful
> about deadlocks.
>

I have understood how to use a single lock for both the purposes as you have
quoted in Katie's patch too i.e. by making an unlocked version of the function
ade7753_spi_write_reg_16(). And since the function is not publicly available
to be used, an unlocked version will not create any issue(which is why I am
assuming, we are not using nested locks - Please correct me if I am wrong.)

I will submit a new patch with a single lock.

> On reflection I think this patch is worthwhile applying even
> if this new lock gets dropped again in some later rework of this
> driver.
>
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.
>

Thank you for reviewing and applying the patch and guiding for a better logical
solution.

> Thanks,
>
> Jonathan
>> ---
>>  drivers/staging/iio/meter/ade7753.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
>> index ce26abdea..745c5a6 100644
>> --- a/drivers/staging/iio/meter/ade7753.c
>> +++ b/drivers/staging/iio/meter/ade7753.c
>> @@ -81,10 +81,12 @@
>>   * @tx:         transmit buffer
>>   * @rx:         receive buffer
>>   * @buf_lock:       mutex to protect tx and rx
>> + * @lock:    protect sensor data
>>   **/
>>  struct ade7753_state {
>>       struct spi_device   *us;
>>       struct mutex        buf_lock;
>> +     struct mutex        lock; /* protect sensor data */
>>       u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
>>       u8          rx[ADE7753_MAX_RX];
>>  };
>> @@ -483,7 +485,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
>>       if (!val)
>>               return -EINVAL;
>>
>> -     mutex_lock(&indio_dev->mlock);
>> +     mutex_lock(&st->lock);
>>
>>       t = 27900 / val;
>>       if (t > 0)
>> @@ -504,7 +506,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
>>       ret = ade7753_spi_write_reg_16(dev, ADE7753_MODE, reg);
>>
>>  out:
>> -     mutex_unlock(&indio_dev->mlock);
>> +     mutex_unlock(&st->lock);
>>
>>       return ret ? ret : len;
>>  }
>> @@ -580,6 +582,7 @@ static int ade7753_probe(struct spi_device *spi)
>>       st = iio_priv(indio_dev);
>>       st->us = spi;
>>       mutex_init(&st->buf_lock);
>> +     mutex_init(&st->lock);
>>
>>       indio_dev->name = spi->dev.driver->name;
>>       indio_dev->dev.parent = &spi->dev;
>
