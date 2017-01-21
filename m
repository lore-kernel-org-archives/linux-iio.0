Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34901 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdAUN3N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 08:29:13 -0500
Subject: Re: [PATCHv5 1/2] iio: adc: Add Maxim MAX11100 driver
To: jacopo mondi <jacopo@jmondi.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
References: <1484757053-7102-1-git-send-email-jacopo+renesas@jmondi.org>
 <1484757053-7102-2-git-send-email-jacopo+renesas@jmondi.org>
 <alpine.DEB.2.02.1701191911380.13521@pmeerw.net>
 <5bd80d06-bb7e-3082-066f-06dbf9a66435@jmondi.org>
Cc: wsa+renesas@sang-engineering.com, linux-iio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <76d4a9c3-fc1f-4f03-7da5-66bc80da07ed@kernel.org>
Date: Sat, 21 Jan 2017 13:29:11 +0000
MIME-Version: 1.0
In-Reply-To: <5bd80d06-bb7e-3082-066f-06dbf9a66435@jmondi.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/01/17 21:47, jacopo mondi wrote:
> Hi Peter,
> 
> On 19/01/2017 19:15, Peter Meerwald-Stadler wrote:
>>
>>> Add iio driver for Maxim MAX11100 single-channel ADC.
>>
>> minor comments, maybe Jonathan can fix it up when taking this...
>>
>>> +struct max11100_state {
>>> +    const struct max11100_chip_desc *desc;
>>> +    struct regulator *vref_reg;
>>> +    struct spi_device *spi;
>>> +
>>> +    /*
>>> +     * DMA (thus cache coherency maintenance) requires the
>>> +     * transfer buffers to live in their own cache lines.
>>> +     */
>>> +    u8 buffer[3] ____cacheline_aligned;
>>> +};
>>> +
>>> +static struct iio_chan_spec max11100_channels[] = {
>>> +    { /* [0] */
>>> +        .type = IIO_VOLTAGE,
>>> +        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>> +                      BIT(IIO_CHAN_INFO_SCALE),
>>> +    },
>>> +};
>>> +
>>> +static struct max11100_chip_desc {
>>> +    unsigned int num_chan;
>>> +    const struct iio_chan_spec *channels;
>>> +} max11100_desc = {
>>> +    .num_chan = ARRAY_SIZE(max11100_channels),
>>> +    .channels = max11100_channels,
>>> +};
>>
>> for just one supported chip, this is more complicated than necessary...
>>
> 
> I can get rid of this, yes, but it's much nicer than hard-coding
> those values in indio_dev fields ;)
It's abstraction for something that doesn't need to be abstracted.  Adds
a few lines of code that needs checking for no gain.  Hence
it's gone.
>>> +
>>> +static int max11100_read_single(struct iio_dev *indio_dev, int *val)
>>> +{
>>> +    int ret;
>>> +    struct max11100_state *state = iio_priv(indio_dev);
>>> +
>>> +    ret = spi_read(state->spi, state->buffer, sizeof(state->buffer));
>>> +    if (ret) {
>>> +        dev_err(&indio_dev->dev, "SPI transfer failed\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    /* the first 8 bits sent out from ADC must be 0s */
>>> +    if (state->buffer[0]) {
>>> +        dev_err(&indio_dev->dev, "Invalid value: buffer[0] != 0\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    *val = (state->buffer[1] << 8) | state->buffer[2];
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int max11100_read_raw(struct iio_dev *indio_dev,
>>> +                 struct iio_chan_spec const *chan,
>>> +                 int *val, int *val2, long info)
>>> +{
>>> +    int ret, vref_uv;
>>> +    struct max11100_state *state = iio_priv(indio_dev);
>>> +
>>> +    switch (info) {
>>> +    case IIO_CHAN_INFO_RAW:
>>> +        ret = max11100_read_single(indio_dev, val);
>>> +        if (ret)
>>> +            return ret;
>>> +
>>> +        return IIO_VAL_INT;
>>> +
>>> +    case IIO_CHAN_INFO_SCALE:
>>> +        vref_uv = regulator_get_voltage(state->vref_reg);
>>> +        if (vref_uv < 0)
>>> +            /* dummy regulator "get_voltage" returns -EINVAL */
>>> +            return -EINVAL;
>>> +
>>> +        *val =  vref_uv / 1000;
>>> +        *val2 = MAX11100_LSB_DIV;
>>> +        return IIO_VAL_FRACTIONAL;
>>> +    }
>>> +
>>> +    return -EINVAL;
>>> +}
>>> +
>>> +static const struct iio_info max11100_info = {
>>> +    .driver_module = THIS_MODULE,
>>> +    .read_raw = max11100_read_raw,
>>> +};
>>> +
>>> +static int max11100_probe(struct spi_device *spi)
>>> +{
>>> +    int ret;
>>> +    struct iio_dev *indio_dev;
>>> +    struct max11100_state *state;
>>> +
>>> +    indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
>>> +    if (!indio_dev)
>>> +        return -ENOMEM;
>>> +
>>> +    spi_set_drvdata(spi, indio_dev);
>>> +
>>> +    state = iio_priv(indio_dev);
>>> +    state->spi = spi;
>>> +    state->desc = &max11100_desc;
>>> +
>>> +    indio_dev->dev.parent = &spi->dev;
>>> +    indio_dev->dev.of_node = spi->dev.of_node;
>>> +    indio_dev->name = "max11100";
>>> +    indio_dev->info = &max11100_info;
>>> +    indio_dev->modes = INDIO_DIRECT_MODE;
>>> +    indio_dev->channels = state->desc->channels;
>>> +    indio_dev->num_channels = state->desc->num_chan;
>>> +
>>> +    state->vref_reg = devm_regulator_get(&spi->dev, "vref");
>>> +    if (IS_ERR(state->vref_reg))
>>> +        return PTR_ERR(state->vref_reg);
>>> +
>>> +    ret = regulator_enable(state->vref_reg);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = iio_device_register(indio_dev);
>>> +    if (ret)
>>> +        goto disable_regulator;
>>> +
>>> +    return 0;
>>> +
>>> +disable_regulator:
>>> +    regulator_disable(state->vref_reg);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int max11100_remove(struct spi_device *spi)
>>> +{
>>> +    struct iio_dev *indio_dev = spi_get_drvdata(spi);
>>> +    struct max11100_state *state = iio_priv(indio_dev);
>>> +
>>> +    regulator_disable(state->vref_reg);
>>
>> should be the other way around, first _unregister(), then
>> regulator_disable()
>>
>> reverse order as in _probe()
>>
> 
> Yeah, that's right...
Fixed up.
> 
> Let's see, I can send v6 with no issues, or Jonathan can do that if he prefers to.
> Just let me know :)
I'll do it as minor stuff.

Applied with changes as above to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> 
> Thanks
>    j
> 
> 
>>> +
>>> +    iio_device_unregister(indio_dev);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct of_device_id max11100_ids[] = {
>>> +    {.compatible = "maxim,max11100"},
>>> +    { },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, max11100_ids);
>>> +
>>> +static struct spi_driver max11100_driver = {
>>> +    .driver = {
>>> +        .name    = "max11100",
>>> +        .owner    = THIS_MODULE,
>>> +        .of_match_table = of_match_ptr(max11100_ids),
>>> +    },
>>> +    .probe        = max11100_probe,
>>> +    .remove        = max11100_remove,
>>> +};
>>> +
>>> +module_spi_driver(max11100_driver);
>>> +
>>> +MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
>>> +MODULE_DESCRIPTION("Maxim max11100 ADC Driver");
>>> +MODULE_LICENSE("GPL v2");
>>>
>>
> 

