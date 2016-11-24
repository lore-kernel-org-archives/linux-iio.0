Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51101 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756918AbcKXUfL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2016 15:35:11 -0500
Subject: Re: [PATCH v2] iio: adc: New driver for TI ADS7950 chips
To: David Lechner <david@lechnology.com>
References: <1479666484-2582-1-git-send-email-david@lechnology.com>
 <d1d05bf8-f4e7-0bf1-66a7-56683cb69d65@lechnology.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3c1d72a3-ae0e-5de8-5d17-586e5b0c5112@kernel.org>
Date: Thu, 24 Nov 2016 20:35:07 +0000
MIME-Version: 1.0
In-Reply-To: <d1d05bf8-f4e7-0bf1-66a7-56683cb69d65@lechnology.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/11/16 19:52, David Lechner wrote:
> On 11/20/2016 12:28 PM, David Lechner wrote:
>> This adds a new driver for the TI ADS7950 family of ADC chips. These
>> communicate using SPI and come in 8/10/12-bit and 4/8/12/16 channel
>> varieties.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>
>> v2 changes:
>>
>> * Got rid of XX wildcards - using ADS7950 everywhere
>> * Fixed some macro parentheses issues
>> * Added TI_ prefix to macros to match ti_ prefixes used elsewhere
>> * Added space in rx_buf for holding timestamp
>> * Use iio_device_claim_direct_mode() and spi_message_init_with_transfers()
>>   helper functions
>> * Don't use dev_info() at end of probe
>> * Minor spelling and code style fixes
>>
>>  drivers/iio/adc/Kconfig      |  13 ++
>>  drivers/iio/adc/Makefile     |   1 +
>>  drivers/iio/adc/ti-ads7950.c | 488 +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 502 insertions(+)
>>  create mode 100644 drivers/iio/adc/ti-ads7950.c
>>
> 
> ...
> 
>> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
>> new file mode 100644
>> index 0000000..d0b76bd
>> --- /dev/null
>> +++ b/drivers/iio/adc/ti-ads7950.c
> 
> ...
> 
>> +static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
>> +{
>> +    struct iio_poll_func *pf = p;
>> +    struct iio_dev *indio_dev = pf->indio_dev;
>> +    struct ti_ads7950_state *st = iio_priv(indio_dev);
>> +    int b_sent;
>> +
>> +    b_sent = spi_sync(st->spi, &st->ring_msg);
> 
> hmm, I copied this from another driver, but spi_sync() in IRQ handler does not sound like a good idea (spi_sync() can sleep). I will replace it with spi_async().
Umm.. spi_async doesn't make any sense here...

Key thing is that here you are in a threaded interrupt so sleeping is fine and
here I'd imagine it leads to simpler code.

It's a bit old but https://lwn.net/Articles/302043/ has a good description.

> 
> 
>> +    if (b_sent)
>> +        goto done;
>> +
>> +    iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
>> +                       iio_get_time_ns(indio_dev));
>> +
>> +done:
>> +    iio_trigger_notify_done(indio_dev->trig);
>> +
>> +    return IRQ_HANDLED;
>> +}
> 
> ...
> 
>> +static int ti_ads7950_read_raw(struct iio_dev *indio_dev,
>> +                   struct iio_chan_spec const *chan,
>> +                   int *val, int *val2, long m)
>> +{
>> +    struct ti_ads7950_state *st = iio_priv(indio_dev);
>> +    int ret;
>> +
>> +    switch (m) {
>> +    case IIO_CHAN_INFO_RAW:
>> +
>> +        ret = iio_device_claim_direct_mode(indio_dev);
>> +        if (ret < 0)
>> +            return ret;
>> +
>> +        ret = ti_ads7950_scan_direct(st, chan->address);
>> +        iio_device_release_direct_mode(indio_dev);
>> +        if (ret < 0)
>> +            return ret;
>> +
>> +        if (chan->address != TI_ADS7950_EXTRACT(ret, 12, 4))
>> +            return -EIO;
>> +
>> +        *val = TI_ADS7950_EXTRACT(ret, 0, 12);
> 
> I'm not sure if I am doing this right. There are 8- 10- and 12-bit
> versions of this chip. The 8- and 10-bit versions still return a
> 12-bit number where the last 4 or 2 bits are always 0. Should I be
> shifting the 12-bit value here based on the chip being used so that
> *val is 0-255 for 8-bit and 0-1023 for 10-bit? Or should this be
> *really* raw and not even use TI_ADS7950_EXTRACT() to mask the
> channel address bits?
>> +
>> +        return IIO_VAL_INT;
>> +    case IIO_CHAN_INFO_SCALE:
>> +        ret = ti_ads7950_get_range(st);
>> +        if (ret < 0)
>> +            return ret;
>> +
>> +        *val = ret;
>> +        *val2 = chan->scan_type.realbits;
>> +
>> +        return IIO_VAL_FRACTIONAL_LOG2;
>> +    }
>> +
>> +    return -EINVAL;
>> +}
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

