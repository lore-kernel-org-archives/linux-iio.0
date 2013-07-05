Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:57730 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751579Ab3GEROK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jul 2013 13:14:10 -0400
Message-ID: <51D6FFAB.2050501@metafoo.de>
Date: Fri, 05 Jul 2013 19:17:31 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Hector Palacios <hector.palacios@digi.com>
CC: Marek Vasut <marex@denx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: [PATCH 1/4] iio: mxs-lradc: change the realbits to 12
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <201307051337.39215.marex@denx.de> <51D6BED7.6060703@digi.com> <201307051510.29011.marex@denx.de> <51D6D9A3.4010607@digi.com>
In-Reply-To: <51D6D9A3.4010607@digi.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/05/2013 04:35 PM, Hector Palacios wrote:
> On 07/05/2013 03:10 PM, Marek Vasut wrote:
>> Dear Hector Palacios,
>>
>>> Dear Marek,
>>>
>>> On 07/05/2013 01:37 PM, Marek Vasut wrote:
>>>> Dear Hector Palacios,
>>>>
>>>>> The LRADC virtual channels have an 18 bit field to store the sum of up
>>>>> to 2^5 accumulated samples. The read_raw function however only operates
>>>>> over a single sample (12 bit resolution).
>>>>> In order to use this field for scaling operations, we need it to be the
>>>>> exact resolution value of the LRADC.
>>>>
>>>> How would this work once the accumulation is supported?
>>>
>>> As I see it, when you read a channel the driver should give you the 12-bit
>>> value either of one single sample or of N samples.
>>
>> The hardware will always give you 18 bit value, let's call it A of N accumulated
>> samples, each 12 bit long. N is in range of 1 to 32 .
>>
>> The driver currently supports N = 1.
>>
>> Do I understand it correctly that if we want to support N > 1, we have to do the
>> division of A / N in the driver and therefore we will again report only a 12-bit
>> value to the userland ?
>>
>> If so,
>>
>> Acked-by: Marek Vasut <marex@denx.de>
> 
> That's what I would expect. I mean, what is A worth for? It's just a sum, it
> tells nothing. The value that really carries information is A / N, which is the
> average value.
> 
> @Lars: is there any driver that allows to read N samples? Does the IIO
> subsystem supply such interface (i.e. a file called n_samples that you can
> program from userland to trigger a read of that N samples in order to get the
> average value when you read that channel)?

The ad7606 has the 'oversampling_ratio' attribute. On the other hand the ad7606
is not the best example either and this is a custom API. But well that's what
it is and since it's not the only device that supports oversampling we should
try and standardize a property name for this. The ad7606 does the averaging in
hardware though.

- Lars
