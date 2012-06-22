Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:36235 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761494Ab2FVHc1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jun 2012 03:32:27 -0400
Message-ID: <4FE41F84.7060809@cam.ac.uk>
Date: Fri, 22 Jun 2012 08:32:20 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio:adc: Add AD7265/AD7266 support
References: <1340039656-19403-1-git-send-email-lars@metafoo.de> <4FE32CDA.7040001@cam.ac.uk> <4FE340B7.8060809@metafoo.de>
In-Reply-To: <4FE340B7.8060809@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/21/2012 4:41 PM, Lars-Peter Clausen wrote:
> On 06/21/2012 04:16 PM, Jonathan Cameron wrote:
>> On 6/18/2012 6:14 PM, Lars-Peter Clausen wrote:
>>> This patch adds support for the Analog Devices AD7265 and AD7266
>>> Analog-to-Digital converters.
>> Mostly fine.  I'm unconvinced the complexity around the
>> channel array creation is necessary.  Might save a little on
>> data but loses in readability!
>>
>> Jonathan
>>>
>>> [...]
>>> +static int __devinit ad7266_alloc_channels(struct iio_dev *indio_dev)
>>> +{
>>> +    struct ad7266_state *st = iio_priv(indio_dev);
>>> +    const struct iio_chan_spec *channel_template;
>>> +    struct iio_chan_spec *channels;
>>> +    unsigned long *scan_masks;
>>> +    unsigned int num_channels;
>>> +
>>
>> I'm unclear on why all this complexity is necessary.
>> We aren't dealing with huge numbers of channels here.
>> Why can't we just have a couple of const static arrays and
>> pick between them?  This is just nasty to read for a
>> fairly small gain.
>>
>
> Hm, I doubt that the code looks less messy if we do it that way. It would
> add another level of indention and we'd have the same code twice once for
> the fixed case and once for the non-fixed case. It would more or less look
> like this:
I'd still be happier with that than the memcpy.  That implies that stuff
in these is not const, whereas it is for a given setup.
>
>      if (!st->fixed_addr) {
>          if (st->mode == AD7266_MODE_SINGLE_ENDED) {
>              if (st->range == AD7266_RANGE_VREF) {
>                  channel_template = ad7266_channels_u;
>                  num_channels = ARRAY_SIZE(ad7266_channels_u);
>              } else {
>                  channel_template = ad7266_channels_s;
>                  num_channels = ARRAY_SIZE(ad7266_channels_s);
>              }
>              scan_masks = ad7266_available_scan_masks;
>          } else {
>              channel_template = ad7266_channels_diff;
>              num_channels = ARRAY_SIZE(ad7266_channels_diff);
>              scan_masks = ad7266_available_scan_masks_diff;
>          }
>      else {
>          if (st->mode == AD7266_MODE_SINGLE_ENDED) {
>              if (st->range == AD7266_RANGE_VREF) {
>                  channel_template = ad7266_channels_u_fixed;
>                  num_channels = ARRAY_SIZE(ad7266_channels_u_fixed);
>              } else {
>                  channel_template = ad7266_channels_s_fixed;
>                  num_channels = ARRAY_SIZE(ad7266_channels_s_fixed);
>              }
>          } else {
>              channel_template = ad7266_channels_diff_fixed;
>              num_channels = ARRAY_SIZE(ad7266_channels_diff_fixed);
>          }
>          indio_dev->available_scan_masks = ad7266_available_scan_masks_fixed;
>      }
>
Then use an array (little fiddly)

struct chan_set {
	struct iio_chan_spec *chans;
	int num_chans;
	int *scan_masks;
};
//index 0 is fixed_addr,
//index 1 is (st->mode == AD7266_MODE_SINGLE_ENDED)
//index 2 is (st->range == AD7266_RANGE_VREF)
static const
struct chan_set bob[2][2][2]
	= {{{{ad7266_channels_u, ARRAY_SIZE(ad7266_channels_u), 
ad7266_available_scan_masks},
	     {ad7266_channels_s, ARRAY_SIZE(ad7266_channels_s), 
ad7266_available_scan_masks}},
	    {{ad7266_channels_diff, ARRAY_SIZE(ad7266_channels_diff), 
ad7266_available_scan_masks_diff},
	     {ad7266_channels_diff, ARRAY_SIZE(ad7266_channels_diff), 
ad7266_available_scan_masks_diff}},
	   {{{ad7266_channels_u_fixed, ARRAY_SIZE(ad7266_channels_u_fixed), 
ad7266_available_scan_masks_fixed}},
	     {ad7266_channels_s_fixed, ARRAY_SIZE(ad7266_channels_s_fixed), 
ad7266_available_scan_masks_fixed}},
	    {{ad7266_channels_channels_diff_fixed, 
ARRAY_SIZE(ad7266_channels_diff_fixed), ad7266_available_scan_masks_fixed},
	     {ad7266_channels_channels_diff_fixed, 
ARRAY_SIZE(ad7266_channels_diff_fixed), 
ad7266_available_scan_masks_fixed}}}};

channel_template = bob[fixed_addr][st->mode == 
AD7266_MODE_SINGLE_ENDED][st->range == AD7266_RANGE_VREF].chans;
etc.

Hmm. not all that clean here, but does make it explicit that we are 
selecting from amongst a set of constant data.



>
>>> +    if (st->mode == AD7266_MODE_SINGLE_ENDED) {
>>> +        if (st->range == AD7266_RANGE_VREF) {
>>> +            channel_template = ad7266_channels_u;
>>> +            num_channels = ARRAY_SIZE(ad7266_channels_u);
>>> +        } else {
>>> +            channel_template = ad7266_channels_s;
>>> +            num_channels = ARRAY_SIZE(ad7266_channels_s);
>>> +        }
>>> +        scan_masks = ad7266_available_scan_masks;
>>> +    } else {
>>> +        channel_template = ad7266_channels_diff;
>>> +        num_channels = ARRAY_SIZE(ad7266_channels_diff);
>>> +        scan_masks = ad7266_available_scan_masks_diff;
>>> +    }
>>> +
>>> +    if (!st->fixed_addr) {
>>> +        indio_dev->available_scan_masks = scan_masks;
>>> +        indio_dev->masklength = indio_dev->num_channels;
>>> +    } else {
>> check patch is moaning at me about this next line being two long.
>
> But breaking the line here certainly does not improve readability. The 80
> chars is more of a soft limit.
It doesn't improved readability, but it also doesn't significantly worsen
it.  Perhaps shortening the naming might be an idea. 
ad7266_av_scan_masks_fixed
seems detailed enough to me!
>
>>> +        indio_dev->available_scan_masks = ad7266_available_scan_masks_fixed;
>>> +        indio_dev->masklength = 2;
>>> +        num_channels = 2;
>>> +    }
>>> +
>>> +    channels = kcalloc(num_channels + 1, sizeof(*channels),
>>> +            GFP_KERNEL);
>>> +    if (!channels)
>>> +        return -ENOMEM;
>>> +
>>> +    memcpy(channels, channel_template, num_channels * sizeof(*channels));
>>> +    channels[num_channels] =
>>> +        (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(num_channels);
>>> +
>>> +    indio_dev->num_channels = num_channels + 1;
>>> +    indio_dev->channels = channels;
>>> +
>>> +    return 0;
>>> +}
>>> +
>
> [...]
>
> Thanks,
> - Lars
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


