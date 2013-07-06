Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37850 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab3GFKIT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Jul 2013 06:08:19 -0400
Message-ID: <51D7EC93.7050300@kernel.org>
Date: Sat, 06 Jul 2013 11:08:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Hector Palacios <hector.palacios@digi.com>,
	Marek Vasut <marex@denx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: [PATCH 1/4] iio: mxs-lradc: change the realbits to 12
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <201307051337.39215.marex@denx.de> <51D6BED7.6060703@digi.com> <201307051510.29011.marex@denx.de> <51D6D9A3.4010607@digi.com> <51D6FFAB.2050501@metafoo.de>
In-Reply-To: <51D6FFAB.2050501@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/05/2013 06:17 PM, Lars-Peter Clausen wrote:
> On 07/05/2013 04:35 PM, Hector Palacios wrote:
>> On 07/05/2013 03:10 PM, Marek Vasut wrote:
>>> Dear Hector Palacios,
>>>
>>>> Dear Marek,
>>>>
>>>> On 07/05/2013 01:37 PM, Marek Vasut wrote:
>>>>> Dear Hector Palacios,
>>>>>
>>>>>> The LRADC virtual channels have an 18 bit field to store the sum of up
>>>>>> to 2^5 accumulated samples. The read_raw function however only operates
>>>>>> over a single sample (12 bit resolution).
>>>>>> In order to use this field for scaling operations, we need it to be the
>>>>>> exact resolution value of the LRADC.
>>>>>
>>>>> How would this work once the accumulation is supported?
>>>>
>>>> As I see it, when you read a channel the driver should give you the 12-bit
>>>> value either of one single sample or of N samples.
>>>
>>> The hardware will always give you 18 bit value, let's call it A of N accumulated
>>> samples, each 12 bit long. N is in range of 1 to 32 .
>>>
>>> The driver currently supports N = 1.
>>>
>>> Do I understand it correctly that if we want to support N > 1, we have to do the
>>> division of A / N in the driver and therefore we will again report only a 12-bit
>>> value to the userland ?
>>>
>>> If so,
>>>
>>> Acked-by: Marek Vasut <marex@denx.de>
>>
>> That's what I would expect. I mean, what is A worth for? It's just a sum, it
>> tells nothing. The value that really carries information is A / N, which is the
>> average value.
>>
>> @Lars: is there any driver that allows to read N samples? Does the IIO
>> subsystem supply such interface (i.e. a file called n_samples that you can
>> program from userland to trigger a read of that N samples in order to get the
>> average value when you read that channel)?
> 
> The ad7606 has the 'oversampling_ratio' attribute. On the other hand the ad7606
> is not the best example either and this is a custom API. But well that's what
> it is and since it's not the only device that supports oversampling we should
> try and standardize a property name for this. The ad7606 does the averaging in
> hardware though.

There is some 'filtering' abi defined and arguably this is just a mean filter with
a particular width window, perhaps treating it like that is the cleanest abi wise.
The intent was always to extend this filtering ABI to describe common filter types
but it hasn't happened yet :)  (that oversampling_ratio is horrible and doesn't
generalize nicely at all).

Propose an ABI addition for what you need....
Just to start things off, my gut feeling would be somethign along the lines of

in_voltageX_filter_mean_width

with appropriate additions to info_mask as there are plenty of devices that do this
(though usually with on board division as Lars suggested - though often for
short widths they just fill the last few bits with 0's).

On this note, one of the more 'interesting' uses of the buffering infrastructure
is that you can do software implementations of simple filters to cut down on the data
flow to userspace. If only there was more time in the day ;)

Jonathan


> 
> - Lars
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
