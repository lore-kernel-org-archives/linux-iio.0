Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58048 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbbHHLjn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 07:39:43 -0400
Subject: Re: [PATCH 2/3] iio: temperature: add max6675 thermocouple converter
 driver
To: Matt Porter <mporter@konsulko.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1438635410-3757-1-git-send-email-mporter@konsulko.com>
 <1438635410-3757-3-git-send-email-mporter@konsulko.com>
 <alpine.DEB.2.02.1508032313380.17732@pmeerw.net>
 <20150806173844.GI23173@beef>
Cc: Linux IIO List <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C5EA7C.70906@kernel.org>
Date: Sat, 8 Aug 2015 12:39:40 +0100
MIME-Version: 1.0
In-Reply-To: <20150806173844.GI23173@beef>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/08/15 18:38, Matt Porter wrote:
> On Mon, Aug 03, 2015 at 11:26:12PM +0200, Peter Meerwald wrote:
>> On Mon, 3 Aug 2015, Matt Porter wrote:
> 
> ...
> 
>>> +static int max6675_read(struct max6675_state *st, int *val)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = spi_read(st->spi, val, 2);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	/* Temperature is bits 14..3 */
>>> +	*val = (*val >> 3) & 0xfff;
>>
>> what about endianness conversion?
>> use be16_to_cpu()
> 
> Apologies, I spoke before engaging the brain on my first reply to this
> As specified by the SPI subsystem docs, SPI buffers are always stored
> in native endian order. There is no need for endianness conversion here.
First of all, which doc say this?
Secondly how does SPI know the endianness of the sensor which is what
actually matters here?  I2C can in theory make these guarantees as there
is an expected byte order on the wire (even if quite a few drivers don't
conform to the spec anyway). No such guarantee can exist for SPI.

Jonathan


> 
> -Matt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

