Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43868 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbbHWPod (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 23 Aug 2015 11:44:33 -0400
Subject: Re: [PATCH 2/3] iio: temperature: add max6675 thermocouple converter
 driver
To: Matt Porter <mporter@konsulko.com>
References: <1438635410-3757-1-git-send-email-mporter@konsulko.com>
 <1438635410-3757-3-git-send-email-mporter@konsulko.com>
 <alpine.DEB.2.02.1508032313380.17732@pmeerw.net>
 <20150806173844.GI23173@beef> <55C5EA7C.70906@kernel.org>
 <20150820002307.GD6276@beef>
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Linux IIO List <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55D9EA5F.4040206@kernel.org>
Date: Sun, 23 Aug 2015 16:44:31 +0100
MIME-Version: 1.0
In-Reply-To: <20150820002307.GD6276@beef>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/08/15 01:23, Matt Porter wrote:
> On Sat, Aug 08, 2015 at 12:39:40PM +0100, Jonathan Cameron wrote:
>> On 06/08/15 18:38, Matt Porter wrote:
>>> On Mon, Aug 03, 2015 at 11:26:12PM +0200, Peter Meerwald wrote:
>>>> On Mon, 3 Aug 2015, Matt Porter wrote:
>>>
>>> ...
>>>
>>>>> +static int max6675_read(struct max6675_state *st, int *val)
>>>>> +{
>>>>> +	int ret;
>>>>> +
>>>>> +	ret = spi_read(st->spi, val, 2);
>>>>> +	if (ret < 0)
>>>>> +		return ret;
>>>>> +
>>>>> +	/* Temperature is bits 14..3 */
>>>>> +	*val = (*val >> 3) & 0xfff;
>>>>
>>>> what about endianness conversion?
>>>> use be16_to_cpu()
>>>
>>> Apologies, I spoke before engaging the brain on my first reply to this
>>> As specified by the SPI subsystem docs, SPI buffers are always stored
>>> in native endian order. There is no need for endianness conversion here.
>> First of all, which doc say this?
>> Secondly how does SPI know the endianness of the sensor which is what
>> actually matters here?  I2C can in theory make these guarantees as there
>> is an expected byte order on the wire (even if quite a few drivers don't
>> conform to the spec anyway). No such guarantee can exist for SPI.
> 
> include/linux/spi/spi.h:
> 
>  * In-memory data values are always in native CPU byte order, translated
>  * from the wire byte order (big-endian except with SPI_LSB_FIRST).  So
>  * for example when bits_per_word is sixteen, buffers are 2N bytes long
>  * (@len = 2N) and hold N sixteen bit words in CPU byte order.
> 
> So, as you mention, there's no standardized byte order but it's
> controlled with the per transfer flag and big endian by default.
> 
Thanks, I'd never picked up on that before!

Jonathan
> 

