Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47984 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbdCMUci (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 16:32:38 -0400
Subject: Re: [PATCH] iio: dac: Add support for ltc2632 DACs
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
References: <20170302190127.23157-1-maxime.roussinbelanger@gmail.com>
 <08c5ea7c-e7fd-3ff9-06b3-d84245ef71f4@kernel.org>
 <A7311725-BCB9-4321-9C11-945BE7FA13CA@gmail.com>
Cc: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e5168f5a-137a-9223-c0dd-f31723e18441@kernel.org>
Date: Mon, 13 Mar 2017 20:32:36 +0000
MIME-Version: 1.0
In-Reply-To: <A7311725-BCB9-4321-9C11-945BE7FA13CA@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/03/17 15:59, Jean-Francois Dagenais wrote:
> Hi Jonathan,
> 
> Thanks for the great feedback. I am working with Maxime on this driver.
> 
>> On Mar 4, 2017, at 14:03, Jonathan Cameron <jic23@kernel.org> wrote:
>>
>>> +static const struct iio_chan_spec_ext_info ltc2632_ext_info[] = {
>>> +	{
>>> +		.name = "powerdown",
>> Why have this as a sysfs attribute? It's new ABI so should be documented
>> and justified.
>>
>> Normally having explicit power up and powerdown of devices is somewhat
>> frowned upon as it can often be implicitly done depending on the state
>> of the machine etc (runtime pm and similar). If that's not the case here
>> please provide some explanatory comments.
> 
> I understand what you mean. We just copy/pasted from a neighbouring driver but
> plan on using the feature. I will give you our use case as an example. We use
> this DAC to drive amplifiers in an acquisition subsystem. This subsystem may be
> offline for long durations (when no acquisition is taking place). The system
> still needs to be fully awake as the user is simply doing something else with
> the unit at that moment.
An interesting use case.  If we were to do this cleanly, the DAC would be explicitly
linked to a driver for the amplifiers (or the wider acquisition system).
Then we could look at doing runtime PM on the wider system and having that feed
back to the DAC driver.  Right now we don't have any callbacks for this, but it
doesn't seem like it would be that difficult to add.

This would require you to have an explicit representation of the whole of the
acquisition system and its dependencies however, which might be non trivial
to put together.
> 
> Trying to bear with you I would ask: are there ways to define different alert
> states with more granularity than "sleeping" and "awake", which would allow
> us to tie the powerdown state of the chips? If so, quick pointers would be
> appreciated.
Not really.

For the DAC case it's rather different to the more usual runtime pm type usage
in input devices.  There we know that if we don't 'look' then we don't know
what the state is (and hence can be powered down).  With DACs it is only whatever
they are wired too that can know whether they need to be powered up.  Afterall
they'll stay in whatever state we put them in indefinitely.

So I am coming around to explicit powerdown controls making sense for a DAC.
> 
>>>
>>> +#define LTC2632_CHANNEL(_chan, _bits) { \
>>> +		.type = IIO_VOLTAGE, \
>>> +		.indexed = 1, \
>>> +		.output = 1, \
>>> +		.channel = (_chan), \
>>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
>>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
>>> +		.address = (_chan), \
>>> +		.scan_type = { \
>>> +			.sign		= 'u', \
>>> +			.realbits	= (_bits), \
>>> +			.storagebits	= 16, \
>>> +			.shift		= 16 - (_bits), \
>> Hmm. Without buffers for output devices some of this is never used, but
>> it does provide 'documentation' of a type so fine to leave it here.
> 
> Guilty of plagiarism, we do not master the iio subsystem yet. We copied
> 5624r_spi.c and tweaked it for this chip. We did not intend to document by doing
> this. Can you suggest a different version of this struct?
The core isn't going to use it at all in a DAC currently.
So just don't bother filling in the parts you aren't using within the driver.
> 
> Thanks again!--
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

