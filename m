Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:54309 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab3GDJRS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Jul 2013 05:17:18 -0400
Message-ID: <51D53D91.8020201@free-electrons.com>
Date: Thu, 04 Jul 2013 11:17:05 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
To: Hector Palacios <hector.palacios@digi.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"marex@denx.de" <marex@denx.de>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: [PATCH RFC] iio: mxs-lradc: add scaling to enable divide_by_two
 operation
References: <1372845969-31776-1-git-send-email-hector.palacios@digi.com> <51D400FF.5060803@metafoo.de> <51D453AE.3020005@digi.com> <51D4575E.2040002@free-electrons.com> <51D5392C.4020309@digi.com>
In-Reply-To: <51D5392C.4020309@digi.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 04/07/2013 10:58, Hector Palacios wrote:
> 
> The field of the register that stores the sample is 18 bits, but each
> sample is only 12 bits. The read_raw of a given channel will only read
> one sample and thus returns a value between 0 and 4095.
> If I use realbits here it will divide the Vref_mv by (1 << 18) and will
> give me a wrong scale value.
> Either we change the 'realbits' to 12 which is the real resolution of
> the ADC, or we leave it as 18 and use a 12 in this operation.
>

As said I didn't have a deep look at it so you are probably right.

>> Using IIO_VAL_FRACTIONAL_LOG2 allows you to avoid doing that computation
>> in your driver (sometimes, it is actually difficult to get it right
>> because you have to use 64 bits numbers).
>>
>> Also, it simplifies things a bit, you can then use something like:
>>
>> case IIO_CHAN_INFO_SCALE:
>> *val = lut[chan->channel];
>> *val2 = chan->scan_type.realbits - is_divide_by_two;
>> return IIO_VAL_FRACTIONAL_LOG2;
> 
> Yes, but not all channels have a by two divisor. Some have a by 4, so
> I'll need to work out a formula per channel divisor.
> When using IIO_VAL_FRACTIONAL_LOG2, val must be given in mV?
>

val is in mV indeed.

My first go at it was something along the lines:

*val = 1850;
*val2 = 12 - divider[chan->channel] - is_divide_by_two;

But as Lars suggested you could also have something like:

*val = Vmax[chan->channel];
*val2 = 12 - is_divide_by_two;



-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
