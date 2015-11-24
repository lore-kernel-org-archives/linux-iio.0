Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:51586 "EHLO
	anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751812AbbKXARP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2015 19:17:15 -0500
Subject: Re: iio: Non multiplexed ADC Data
To: Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <5652CEC5.7080804@electromag.com.au> <5652D931.8000205@metafoo.de>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <5653AC83.9020201@electromag.com.au>
Date: Tue, 24 Nov 2015 08:17:07 +0800
MIME-Version: 1.0
In-Reply-To: <5652D931.8000205@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

G'day Lars,

On 23/11/2015 5:15 PM, Lars-Peter Clausen wrote:
> On 11/23/2015 09:31 AM, Phil Reid wrote:
>> I'm in th eprocess of writing a driver for a custom ADC controller.
>> It's an FPGA based ADC controller with multiple ADC channels with a built in
>> DMA master.
>
> Is it a single ADC with a sequencer or multiple ADCs?
Multiple parallel ADC's with common clock and control.

>
>> All channels share some attributes, eg Sample rate, with other per channel
>> attributes, eg Gain.
>> The DMA controller de-multiplexes the ADC data by having a separate target
>> buffer for each channel.
>
> I'm curious, why?
It's a port of an existing system and each channels data is serialised independently.
There could be multiple devices collecting data with any number of channels active.
It's probably best to say the source data typically isn't multiplexed. Though with
some hardware it is streamed from the ADC as TDM stream and then de-multiplexed, other
hardware the streams are independent..
>
>> Look at the libiio interface this configuration doesn't seem to be catered for.
>> eg: iio_device_create_buffer creates a single buffer for all enabled
>> channels to share.
>>
>> The best way I can see is to create an iio device per channel and have them
>> share a common data block.
>> Not sure what interesting behaviour this may cause.
>
> Yes, you are right, this is not supported at the moment. But we'll have to
> add support for this at some point. In my opinion the best way to address
> this is to add multi-planar buffers, similar like you can for example find
> the in the video world[1], where different components can be in different
> buffers, rather than being interleaved in a single buffer.
>
I'll have a look to see if if that concept works for us. I was also thinking of something
like this by making some hardcoded assumptions about our data.


-- 
Regards
Phil Reid

