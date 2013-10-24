Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33084 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137Ab3JXKLN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Oct 2013 06:11:13 -0400
Message-ID: <5269007B.6060907@kernel.org>
Date: Thu, 24 Oct 2013 12:11:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 7/9] iio: hid-sensors: Added Inclinometer 3D
References: <1382555476-15826-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1382555476-15826-7-git-send-email-srinivas.pandruvada@linux.intel.com> <5268FF38.7000305@kernel.org>
In-Reply-To: <5268FF38.7000305@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/13 12:06, Jonathan Cameron wrote:
> On 10/23/13 20:11, Srinivas Pandruvada wrote:
>> Added usage id processing for Inclinometer 3D. This uses IIO
>> interfaces for triggered buffer to present data to user
>> mode.This uses HID sensor framework for registering callback
>> events from the sensor hub.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Looks good.  One little comment inline... I'd probably not have mentioned that
> but as there is going to be another version fo the series, might as well tidy
> it up ;)

Just noticed another point to fix.  In read raw you have case 0:
We long ago defined IIO_CHAN_INFO_RAW to be 0 so please use the enum
rather than 0.

I'm guessing this might want some tidy up patches for any other remaining uses as well.

> 
> Thanks,
> 
>> +/* Channel definitions */
>> +static const struct iio_chan_spec incl_3d_channels[] = {
>> +	{
>> +		.type = IIO_INCLI,
>> +		.modified = 1,
>> +		.channel2 = IIO_MOD_X,
>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>> +		BIT(IIO_CHAN_INFO_SCALE) |
>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>> +		BIT(IIO_CHAN_INFO_HYSTERESIS),
>> +		.scan_index = CHANNEL_SCAN_INDEX_X,
>> +	}, {
>> +		.type = IIO_INCLI,
>> +		.modified = 1,
>> +		.channel2 = IIO_MOD_Y,
>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>> +		BIT(IIO_CHAN_INFO_SCALE) |
>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>> +		BIT(IIO_CHAN_INFO_HYSTERESIS),
>> +		.scan_index = CHANNEL_SCAN_INDEX_Y,
>> +	}, {
>> +		.type = IIO_INCLI,
>> +		.modified = 1,
>> +		.channel2 = IIO_MOD_Z,
>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>> +		BIT(IIO_CHAN_INFO_SCALE) |
>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>> +		BIT(IIO_CHAN_INFO_HYSTERESIS),
>> +		.scan_index = CHANNEL_SCAN_INDEX_Z,
>> +	}
>> +};
>> +
>> +/* Adjust channel real bits based on report 
> This would be cleaner if it just took the channel in question?
> so
> static void incl_3d_adjust_channel_bit_mask(struct iio_chan_spec *chan,
> 					    int size)
> {
> 	chan->scan_type.sign = 's';
> 	/* Real storage bits will change based on the report desc. */
> 	chan->scan_type.realbits = size * 8;
> 	/* Maximum size of a sample to capture is u32 */
> 	chan->scan_type.storagebits = sizeof(u32) * 8;
> }
> 
> then call as
> 
> 	incl_3d_adjust_channel_bit_mask(&channels[CHANNEL_SCAN_INDEX_X],
> 				st->incl[CHANNEL_SCAN_INDEX_X].size);
> 
>> +static void incl_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
>> +						int channel, int size)
>> +{
>> +	channels[channel].scan_type.sign = 's';
>> +	/* Real storage bits will change based on the report desc. */
>> +	channels[channel].scan_type.realbits = size * 8;
>> +	/* Maximum size of a sample to capture is u32 */
>> +	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
>> +}
>> +
> ...
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
