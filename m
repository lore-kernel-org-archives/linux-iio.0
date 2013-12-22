Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47748 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163Ab3LVRnx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Dec 2013 12:43:53 -0500
Message-ID: <52B724D8.1080107@kernel.org>
Date: Sun, 22 Dec 2013 17:43:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 07/15] iio:ad5791: Do not store transfer buffers on the
 stack
References: <1385383327-28181-1-git-send-email-lars@metafoo.de> <1385383327-28181-7-git-send-email-lars@metafoo.de> <5299C779.3070601@kernel.org> <52B72314.2040400@kernel.org> <52B7241F.7090305@metafoo.de>
In-Reply-To: <52B7241F.7090305@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/22/13 17:40, Lars-Peter Clausen wrote:
> On 12/22/2013 06:36 PM, Jonathan Cameron wrote:
>> On 11/30/13 11:09, Jonathan Cameron wrote:
>>> On 11/25/13 12:41, Lars-Peter Clausen wrote:
>>>> Some SPI controllers may not be able to handle transfer buffers that are placed
>>>> on the stack.
>>>>
>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>> Applied to the togreg branch of iio.git
>>>
>>> Thanks
>>
>> I really didn't review this series well enough.  This should probably have
>> gone in as a fix rather that through the togreg branch as should the other sp
>> driver.  Bit late now though given the size of the patch.
>>
>> Sorry it has taken me so long to do a pull request to Greg.  I always
>> get a bit lazy on the stuff for next as can always do it tomorrow!
>>
>> Slipped rather long this time though!
> 
> I think most SPI driver simply don't care as they don't do any DMA. So as long as there is a board with a DMA SPI
> controller + this chip combination that is in active use I don't think the patch needs to go into fixes.

Not vital, but generally I'd got for fixes for this sort of thing, because it's entirely plausible
someone will base there tree off an old mainline with patches adding dma support to their driver.

Never mind though ;)
> 
>>
>> Jonathan
>>
>>>> ---
>>>>   drivers/iio/dac/ad5791.c | 46 +++++++++++++++++++++-------------------------
>>>>   1 file changed, 21 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
>>>> index 1e7f4cd..79bf199 100644
>>>> --- a/drivers/iio/dac/ad5791.c
>>>> +++ b/drivers/iio/dac/ad5791.c
>>>> @@ -91,6 +91,11 @@ struct ad5791_state {
>>>>       unsigned            ctrl;
>>>>       unsigned            pwr_down_mode;
>>>>       bool                pwr_down;
>>>> +
>>>> +    union {
>>>> +        __be32 d32;
>>>> +        u8 d8[4];
>>>> +    } data[3] ____cacheline_aligned;
>>>>   };
>>>>
>>>>   /**
>>>> @@ -104,48 +109,39 @@ enum ad5791_supported_device_ids {
>>>>       ID_AD5791,
>>>>   };
>>>>
>>>> -static int ad5791_spi_write(struct spi_device *spi, u8 addr, u32 val)
>>>> +static int ad5791_spi_write(struct ad5791_state *st, u8 addr, u32 val)
>>>>   {
>>>> -    union {
>>>> -        __be32 d32;
>>>> -        u8 d8[4];
>>>> -    } data;
>>>> -
>>>> -    data.d32 = cpu_to_be32(AD5791_CMD_WRITE |
>>>> +    st->data[0].d32 = cpu_to_be32(AD5791_CMD_WRITE |
>>>>                     AD5791_ADDR(addr) |
>>>>                     (val & AD5791_DAC_MASK));
>>>>
>>>> -    return spi_write(spi, &data.d8[1], 3);
>>>> +    return spi_write(st->spi, &st->data[0].d8[1], 3);
>>>>   }
>>>>
>>>> -static int ad5791_spi_read(struct spi_device *spi, u8 addr, u32 *val)
>>>> +static int ad5791_spi_read(struct ad5791_state *st, u8 addr, u32 *val)
>>>>   {
>>>> -    union {
>>>> -        __be32 d32;
>>>> -        u8 d8[4];
>>>> -    } data[3];
>>>>       int ret;
>>>>       struct spi_transfer xfers[] = {
>>>>           {
>>>> -            .tx_buf = &data[0].d8[1],
>>>> +            .tx_buf = &st->data[0].d8[1],
>>>>               .bits_per_word = 8,
>>>>               .len = 3,
>>>>               .cs_change = 1,
>>>>           }, {
>>>> -            .tx_buf = &data[1].d8[1],
>>>> -            .rx_buf = &data[2].d8[1],
>>>> +            .tx_buf = &st->data[1].d8[1],
>>>> +            .rx_buf = &st->data[2].d8[1],
>>>>               .bits_per_word = 8,
>>>>               .len = 3,
>>>>           },
>>>>       };
>>>>
>>>> -    data[0].d32 = cpu_to_be32(AD5791_CMD_READ |
>>>> +    st->data[0].d32 = cpu_to_be32(AD5791_CMD_READ |
>>>>                     AD5791_ADDR(addr));
>>>> -    data[1].d32 = cpu_to_be32(AD5791_ADDR(AD5791_ADDR_NOOP));
>>>> +    st->data[1].d32 = cpu_to_be32(AD5791_ADDR(AD5791_ADDR_NOOP));
>>>>
>>>> -    ret = spi_sync_transfer(spi, xfers, ARRAY_SIZE(xfers));
>>>> +    ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
>>>>
>>>> -    *val = be32_to_cpu(data[2].d32);
>>>> +    *val = be32_to_cpu(st->data[2].d32);
>>>>
>>>>       return ret;
>>>>   }
>>>> @@ -210,7 +206,7 @@ static ssize_t ad5791_write_dac_powerdown(struct iio_dev *indio_dev,
>>>>       }
>>>>       st->pwr_down = pwr_down;
>>>>
>>>> -    ret = ad5791_spi_write(st->spi, AD5791_ADDR_CTRL, st->ctrl);
>>>> +    ret = ad5791_spi_write(st, AD5791_ADDR_CTRL, st->ctrl);
>>>>
>>>>       return ret ? ret : len;
>>>>   }
>>>> @@ -263,7 +259,7 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
>>>>
>>>>       switch (m) {
>>>>       case IIO_CHAN_INFO_RAW:
>>>> -        ret = ad5791_spi_read(st->spi, chan->address, val);
>>>> +        ret = ad5791_spi_read(st, chan->address, val);
>>>>           if (ret)
>>>>               return ret;
>>>>           *val &= AD5791_DAC_MASK;
>>>> @@ -330,7 +326,7 @@ static int ad5791_write_raw(struct iio_dev *indio_dev,
>>>>           val &= AD5791_RES_MASK(chan->scan_type.realbits);
>>>>           val <<= chan->scan_type.shift;
>>>>
>>>> -        return ad5791_spi_write(st->spi, chan->address, val);
>>>> +        return ad5791_spi_write(st, chan->address, val);
>>>>
>>>>       default:
>>>>           return -EINVAL;
>>>> @@ -393,7 +389,7 @@ static int ad5791_probe(struct spi_device *spi)
>>>>           dev_warn(&spi->dev, "reference voltage unspecified\n");
>>>>       }
>>>>
>>>> -    ret = ad5791_spi_write(spi, AD5791_ADDR_SW_CTRL, AD5791_SWCTRL_RESET);
>>>> +    ret = ad5791_spi_write(st, AD5791_ADDR_SW_CTRL, AD5791_SWCTRL_RESET);
>>>>       if (ret)
>>>>           goto error_disable_reg_neg;
>>>>
>>>> @@ -405,7 +401,7 @@ static int ad5791_probe(struct spi_device *spi)
>>>>             | ((pdata && pdata->use_rbuf_gain2) ? 0 : AD5791_CTRL_RBUF) |
>>>>             AD5791_CTRL_BIN2SC;
>>>>
>>>> -    ret = ad5791_spi_write(spi, AD5791_ADDR_CTRL, st->ctrl |
>>>> +    ret = ad5791_spi_write(st, AD5791_ADDR_CTRL, st->ctrl |
>>>>           AD5791_CTRL_OPGND | AD5791_CTRL_DACTRI);
>>>>       if (ret)
>>>>           goto error_disable_reg_neg;
>>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
