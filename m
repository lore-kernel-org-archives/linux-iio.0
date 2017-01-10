Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57935 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdAJVRc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2017 16:17:32 -0500
Subject: Re: [PATCH 1/1] iio: adc: tlc4541: add support for TI tlc4541 adc
To: Phil Reid <preid@electromag.com.au>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1483606546-13629-1-git-send-email-preid@electromag.com.au>
 <alpine.DEB.2.02.1701051004320.16779@pmeerw.net>
 <d2b5f8fe-f9ce-bf9b-b5d8-facc10936290@electromag.com.au>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cc1c336e-3a1c-5985-ef75-ea58e00a0c1c@kernel.org>
Date: Tue, 10 Jan 2017 21:17:28 +0000
MIME-Version: 1.0
In-Reply-To: <d2b5f8fe-f9ce-bf9b-b5d8-facc10936290@electromag.com.au>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/01/17 06:26, Phil Reid wrote:
> G'day Peter,
> 
> Thanks for the review.
> 
> On 5/01/2017 17:21, Peter Meerwald-Stadler wrote:
> <snip>
>>> +
>>> +#define TLC4541_V_CHAN(index, bits) {                                 \
>>> +        .type = IIO_VOLTAGE,                                  \
>>> +        .indexed = 1,                                         \
>>
>> no need if there is just one channel
>>
>>> +        .channel = index,                                     \
>>> +        .info_mask_separate       = BIT(IIO_CHAN_INFO_RAW),   \
>>> +        .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
>>> +        .address = index,                                     \
>>
>> .address not needed
>>
>>> +        .scan_index = index,                                  \
>>> +        .scan_type = {                                        \
>>> +            .sign = 'u',                                  \
>>> +            .realbits = (bits),                           \
>>> +            .storagebits = 16,                            \
>>> +            .endianness = IIO_BE,                         \
>>> +        },                                                    \
>>> +    }
>>> +
>>> +#define DECLARE_TLC4541_CHANNELS(name, bits) \
>>
>> this flexibility is only needed when further chips are added; maybe start
>> simple and only implement what is needed at first
> I'll add the spec for to the TLC3541 which is a 14-bit version of this chip.
> I don't have one to test, but it looks pretty straight forward.
> 
>>
>>> +const struct iio_chan_spec name ## _channels[] = { \
>>> +    TLC4541_V_CHAN(0, bits), \
>>> +    IIO_CHAN_SOFT_TIMESTAMP(1), \
>>> +}
>>> +
>>> +static DECLARE_TLC4541_CHANNELS(tlc4541, 16);
>>> +
>>> +static const struct tlc4541_chip_info tlc4541_chip_info[] = {
>>> +    [TLC4541] = {
>>> +        .channels = tlc4541_channels,
>>> +        .num_channels = ARRAY_SIZE(tlc4541_channels),
>>> +    },
>>> +};
>>> +
>>> +static irqreturn_t tlc4541_trigger_handler(int irq, void *p)
>>> +{
>>> +    struct iio_poll_func *pf = p;
>>> +    struct iio_dev *indio_dev = pf->indio_dev;
>>> +    struct tlc4541_state *st = iio_priv(indio_dev);
>>> +    u16 buf[8]; /* 2 bytes data + 6 bytes padding + 8 bytes timestamp */
>>> +    int ret;
>>> +
>>> +    ret = spi_sync(st->spi, &st->scan_single_msg);
>>> +    if (ret < 0)
>>> +        goto done;
>>> +
>>> +    buf[0] = be16_to_cpu(st->rx_buf[0]);
>>
>> endianness is set to IIO_BE in scan_type, so this conversion is not needed
>> and maybe also buf and the copy can be avoided if rx_buf is large enough
> 
> I was doing the conversion in IIO_CHAN_INFO_RAW as well.
> Is it required there? I'm guessing yes.
Yes. That path is outputting a human readable string so needs to be the write
way around.
> 
>>
>>> +    iio_push_to_buffers_with_timestamp(indio_dev, buf,
>>> +                       iio_get_time_ns(indio_dev));
>>> +
>>> +done:
>>> +    iio_trigger_notify_done(indio_dev->trig);
>>> +    return IRQ_HANDLED;
>>> +}
>>> +
>>> +static int tlc4541_get_range(struct tlc4541_state *st)
>>> +{
>>> +    int vref;
>>> +
>>> +    vref = regulator_get_voltage(st->reg);
>>> +    if (vref < 0)
>>> +        return vref;
>>> +
>>> +    vref /= 1000;
>>> +
>>> +    return vref;
>>> +}
>>> +
>>> +static int tlc4541_read_raw(struct iio_dev *indio_dev,
>>> +                struct iio_chan_spec const *chan,
>>> +                int *val,
>>> +                int *val2,
>>> +                long m)
>>> +{
>>> +    int ret = 0;
>>> +    struct tlc4541_state *st = iio_priv(indio_dev);
>>> +
>>> +    switch (m) {
>>> +    case IIO_CHAN_INFO_RAW:
>>> +        ret = iio_device_claim_direct_mode(indio_dev);
>>> +        if (ret)
>>> +            return ret;
>>> +        ret = spi_sync(st->spi, &st->scan_single_msg);
>>> +        iio_device_release_direct_mode(indio_dev);
>>> +        if (ret < 0)
>>> +            return ret;
>>> +        *val = be16_to_cpu(st->rx_buf[0]);
>>
>> on page 12 of the datasheet, the conversion results is in two registers?
>> and rx_buf has two elements?
>>
>> haven't investigated in detail -- maybe a comment would be good to detail
>> operation?
> I set that to 4 bytes because I also use that for the dummy 24 clock cycles
> at the beginning as well. I think that documentation is a bit misleading.
> Possible due to the tlc3451 datasheet being  very similar. Those two registers
> are 14 bits and 2 bits wide respectively. The SPI cycle time shows data is
> available in the first 16 bits.
> 
> 
>>
>>> +        return IIO_VAL_INT;
>>> +    case IIO_CHAN_INFO_SCALE:
>>> +        ret = tlc4541_get_range(st);
>>> +        if (ret < 0)
>>> +            return ret;
>>> +        *val = ret;
>>> +        *val2 = chan->scan_type.realbits;
>>> +        return IIO_VAL_FRACTIONAL_LOG2;
>>> +    }
>>> +    return -EINVAL;
>>> +}
> <snip>
> 
> 

