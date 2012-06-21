Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-066.synserver.de ([212.40.185.66]:1194 "EHLO
	smtp-out-141.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759462Ab2FUPiC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jun 2012 11:38:02 -0400
Message-ID: <4FE340B7.8060809@metafoo.de>
Date: Thu, 21 Jun 2012 17:41:43 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio:adc: Add AD7265/AD7266 support
References: <1340039656-19403-1-git-send-email-lars@metafoo.de> <4FE32CDA.7040001@cam.ac.uk>
In-Reply-To: <4FE32CDA.7040001@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/21/2012 04:16 PM, Jonathan Cameron wrote:
> On 6/18/2012 6:14 PM, Lars-Peter Clausen wrote:
>> This patch adds support for the Analog Devices AD7265 and AD7266
>> Analog-to-Digital converters.
> Mostly fine.  I'm unconvinced the complexity around the
> channel array creation is necessary.  Might save a little on
> data but loses in readability!
> 
> Jonathan
>>
>> [...]
>> +static int __devinit ad7266_alloc_channels(struct iio_dev *indio_dev)
>> +{
>> +    struct ad7266_state *st = iio_priv(indio_dev);
>> +    const struct iio_chan_spec *channel_template;
>> +    struct iio_chan_spec *channels;
>> +    unsigned long *scan_masks;
>> +    unsigned int num_channels;
>> +
> 
> I'm unclear on why all this complexity is necessary.
> We aren't dealing with huge numbers of channels here.
> Why can't we just have a couple of const static arrays and
> pick between them?  This is just nasty to read for a
> fairly small gain.
> 

Hm, I doubt that the code looks less messy if we do it that way. It would
add another level of indention and we'd have the same code twice once for
the fixed case and once for the non-fixed case. It would more or less look
like this:

    if (!st->fixed_addr) {
        if (st->mode == AD7266_MODE_SINGLE_ENDED) {
            if (st->range == AD7266_RANGE_VREF) {
                channel_template = ad7266_channels_u;
                num_channels = ARRAY_SIZE(ad7266_channels_u);
            } else {
                channel_template = ad7266_channels_s;
                num_channels = ARRAY_SIZE(ad7266_channels_s);
            }
            scan_masks = ad7266_available_scan_masks;
        } else {
            channel_template = ad7266_channels_diff;
            num_channels = ARRAY_SIZE(ad7266_channels_diff);
            scan_masks = ad7266_available_scan_masks_diff;
        }
    else {
        if (st->mode == AD7266_MODE_SINGLE_ENDED) {
            if (st->range == AD7266_RANGE_VREF) {
                channel_template = ad7266_channels_u_fixed;
                num_channels = ARRAY_SIZE(ad7266_channels_u_fixed);
            } else {
                channel_template = ad7266_channels_s_fixed;
                num_channels = ARRAY_SIZE(ad7266_channels_s_fixed);
            }
        } else {
            channel_template = ad7266_channels_diff_fixed;
            num_channels = ARRAY_SIZE(ad7266_channels_diff_fixed);
        }
        indio_dev->available_scan_masks = ad7266_available_scan_masks_fixed;
    }


>> +    if (st->mode == AD7266_MODE_SINGLE_ENDED) {
>> +        if (st->range == AD7266_RANGE_VREF) {
>> +            channel_template = ad7266_channels_u;
>> +            num_channels = ARRAY_SIZE(ad7266_channels_u);
>> +        } else {
>> +            channel_template = ad7266_channels_s;
>> +            num_channels = ARRAY_SIZE(ad7266_channels_s);
>> +        }
>> +        scan_masks = ad7266_available_scan_masks;
>> +    } else {
>> +        channel_template = ad7266_channels_diff;
>> +        num_channels = ARRAY_SIZE(ad7266_channels_diff);
>> +        scan_masks = ad7266_available_scan_masks_diff;
>> +    }
>> +
>> +    if (!st->fixed_addr) {
>> +        indio_dev->available_scan_masks = scan_masks;
>> +        indio_dev->masklength = indio_dev->num_channels;
>> +    } else {
> check patch is moaning at me about this next line being two long.

But breaking the line here certainly does not improve readability. The 80
chars is more of a soft limit.

>> +        indio_dev->available_scan_masks = ad7266_available_scan_masks_fixed;
>> +        indio_dev->masklength = 2;
>> +        num_channels = 2;
>> +    }
>> +
>> +    channels = kcalloc(num_channels + 1, sizeof(*channels),
>> +            GFP_KERNEL);
>> +    if (!channels)
>> +        return -ENOMEM;
>> +
>> +    memcpy(channels, channel_template, num_channels * sizeof(*channels));
>> +    channels[num_channels] =
>> +        (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(num_channels);
>> +
>> +    indio_dev->num_channels = num_channels + 1;
>> +    indio_dev->channels = channels;
>> +
>> +    return 0;
>> +}
>> +

[...]

Thanks,
- Lars
