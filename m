Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.1]:62812 "EHLO
	mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752356Ab3GEOfe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jul 2013 10:35:34 -0400
Message-ID: <51D6D9A3.4010607@digi.com>
Date: Fri, 5 Jul 2013 16:35:15 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: [PATCH 1/4] iio: mxs-lradc: change the realbits to 12
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <201307051337.39215.marex@denx.de> <51D6BED7.6060703@digi.com> <201307051510.29011.marex@denx.de>
In-Reply-To: <201307051510.29011.marex@denx.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/05/2013 03:10 PM, Marek Vasut wrote:
> Dear Hector Palacios,
>
>> Dear Marek,
>>
>> On 07/05/2013 01:37 PM, Marek Vasut wrote:
>>> Dear Hector Palacios,
>>>
>>>> The LRADC virtual channels have an 18 bit field to store the sum of up
>>>> to 2^5 accumulated samples. The read_raw function however only operates
>>>> over a single sample (12 bit resolution).
>>>> In order to use this field for scaling operations, we need it to be the
>>>> exact resolution value of the LRADC.
>>>
>>> How would this work once the accumulation is supported?
>>
>> As I see it, when you read a channel the driver should give you the 12-bit
>> value either of one single sample or of N samples.
>
> The hardware will always give you 18 bit value, let's call it A of N accumulated
> samples, each 12 bit long. N is in range of 1 to 32 .
>
> The driver currently supports N = 1.
>
> Do I understand it correctly that if we want to support N > 1, we have to do the
> division of A / N in the driver and therefore we will again report only a 12-bit
> value to the userland ?
>
> If so,
>
> Acked-by: Marek Vasut <marex@denx.de>

That's what I would expect. I mean, what is A worth for? It's just a sum, it tells 
nothing. The value that really carries information is A / N, which is the average value.

@Lars: is there any driver that allows to read N samples? Does the IIO subsystem 
supply such interface (i.e. a file called n_samples that you can program from userland 
to trigger a read of that N samples in order to get the average value when you read 
that channel)?

Best regards,
--
Hector Palacios
