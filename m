Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.10]:16312 "EHLO
	mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752970Ab3GCQlP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jul 2013 12:41:15 -0400
Message-ID: <51D453AE.3020005@digi.com>
Date: Wed, 3 Jul 2013 18:39:10 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"marex@denx.de" <marex@denx.de>,
	"alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: [PATCH RFC] iio: mxs-lradc: add scaling to enable divide_by_two
 operation
References: <1372845969-31776-1-git-send-email-hector.palacios@digi.com> <51D400FF.5060803@metafoo.de>
In-Reply-To: <51D400FF.5060803@metafoo.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Lars,

On 07/03/2013 12:46 PM, Lars-Peter Clausen wrote:
> The scale attribute reports the scale of the raw value. To gain the value of
> the result in mV you have to multiply the raw attribute with the scale
> attribute. The scale attribute does not return the result of a conversion with
> a scale different applied.

Thank you for the guidance, I misunderstood the whole thing.

> I suggest you implement this in two steps. First implement the scale property
> for all channels. Use a LUT for each channel's fullscale value (in mV) and
> implement reading the scale like this.
>
> case IIO_CHAN_INFO_SCALE:
> *val = lut[chan->channel];
> *val2 = chan->scan_type.realbits;
> return IIO_VAL_FRACTIONAL_LOG2;
>
> The next step is to make the scale modifiable for channels which support this.

I'm sorry, it's the first time I work with an iio driver and I'm afraid I don't 
understand this.
Let's say the fullscale value for channel 0 is 1.85V by default (when divide_by_two is 
disabled) and 3.7V (when enabled).

The channel's realbits is currently set to 18, because (although the ADC resolution is 
12 bits) the device can read several samples and return an accumulated value in 18 bits.

Now, considering the default case where 1.85V is the max ref voltage and considering 
that the driver only reads one sample during the raw_read operation (12 bits), what 
value should a read of 'scale' return?

	scale = Vref_mv / ((1 << 12) - 1) = 1850 /4095 = 0.45177045 ?

That is, the value to multiply the raw value to get the voltage in mV?
So that if reading the 'raw' returns say 425 and reading scale returns 0.45177 the 
measured voltage is 425 * 0.45177 = 192mV?


Then let's say I have implemented a function to modify the scale (which should 
eventually allow me to enable/disable the by two divisor). What is the user supposed 
to write to the 'scale'? Is he supposed to supply a decimal number like 0.45177 * 2 = 
0.903? This would be pretty odd.
Should I create a table instead so that writing a 0 means divisor disabled and writing 
1 means divisor enabled, for example?

Does the iio provide any descriptor that automatically shows the value in mV (already 
converted)?

Thank you for your help.
Best regards,
--
Hector Palacios
