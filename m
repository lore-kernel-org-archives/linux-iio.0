Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.202]:43832 "EHLO
	mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752156Ab3GDO6b (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Jul 2013 10:58:31 -0400
Message-ID: <51D58BA1.2090906@digi.com>
Date: Thu, 4 Jul 2013 16:50:09 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"marex@denx.de" <marex@denx.de>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: [PATCH RFC] iio: mxs-lradc: add scaling to enable divide_by_two
 operation
References: <1372845969-31776-1-git-send-email-hector.palacios@digi.com> <51D400FF.5060803@metafoo.de> <51D453AE.3020005@digi.com> <51D4575E.2040002@free-electrons.com>
In-Reply-To: <51D4575E.2040002@free-electrons.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Alexandre,

On 07/03/2013 06:54 PM, Alexandre Belloni wrote:
>> Then let's say I have implemented a function to modify the scale (which
>> should eventually allow me to enable/disable the by two divisor). What
>> is the user supposed to write to the 'scale'? Is he supposed to supply a
>> decimal number like 0.45177 * 2 = 0.903? This would be pretty odd.
>> Should I create a table instead so that writing a 0 means divisor
>> disabled and writing 1 means divisor enabled, for example?
>>
>
> That is why you should provide an in_voltageX_scale_available file,
> providing a list of valid values.

Getting there...
So since all channels may have the optional divider by two I need to have two 
available scales per channel, for example:

	int	scale_avail[LRADC_MAX_TOTAL_CHANS][2][2];

where the first [2] is the number of available scales per channel (with divisor 
disabled/enabled) and the second [2] is for storing the integer and nanoV parts.

Then I must populate each channel with the two available scales:

	[0] = 0.451660156  	-> [0][0] = 0
				-> [0][1] = 451660156

	[1] = 0.903320312	-> [1][0] = 0
				-> [1][1] = 903320312

where the [0] value is calculated by dividing the Vref by the realbits and the [1] 
value is calculated by multiplying the [0] by two.

Then in the write_raw function I must check whether the integer and nano components 
(val, val2) match those of the array, and if they match the one at the component [1], 
then I can finally set the divisor flag on the register, or else clear it. Is this 
correct?

Best regards,
--
Hector Palacios
