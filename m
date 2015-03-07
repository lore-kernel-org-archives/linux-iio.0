Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58360 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbbCGSH1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Mar 2015 13:07:27 -0500
Message-ID: <54FB3E5C.7080803@kernel.org>
Date: Sat, 07 Mar 2015 18:07:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Markus Pargmann <mpa@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>
CC: Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Denis Carikli <denis@eukrea.com>,
	=?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v7 1/8] ARM: dt: Binding documentation for imx25 ADC/TSC
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de> <1425369498-25541-2-git-send-email-mpa@pengutronix.de> <2620642.Qp1W4O8uh6@wuerfel> <20150305071252.GA8062@pengutronix.de>
In-Reply-To: <20150305071252.GA8062@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/03/15 07:12, Markus Pargmann wrote:
> Hi,
> 
> On Tue, Mar 03, 2015 at 10:02:12AM +0100, Arnd Bergmann wrote:
>> On Tuesday 03 March 2015 08:58:11 Markus Pargmann wrote:
>>> +Example:
>>> +       tscadc: tscadc@50030000 {
>>> +               compatible = "fsl,imx25-tsadc";
>>> +               reg = <0x50030000 0xc>;
>>> +               interrupts = <46>;
>>> +               clocks = <&clks 119>;
>>> +               clock-names = "ipg";
>>> +               interrupt-controller;
>>> +               #interrupt-cells = <1>;
>>> +               #address-cells = <1>;
>>> +               #size-cells = <1>;
>>> +               ranges;
>>> +
>>> +               tsc: tcq@50030400 {
>>> +                       compatible = "fsl,imx25-tcq";
>>> +                       reg = <0x50030400 0x60>;
>>> +                       ...
>>> +               };
>>> +
>>> +               adc: gcq@50030800 {
>>> +                       compatible = "fsl,imx25-gcq";
>>> +                       reg = <0x50030800 0x60>;
>>> +                       ...
>>> +               };
>>> +       };
>>>
>>
>> I wonder if we should just treat this MFD as a single IIO device
>> that also registers to the input layer.
>>
>> Are there any other registers in the 0x50030000-0x50031000
>> range, or could the fsl,imx25-tcq and fsl,imx25-gcq devices
>> be reused outside of a fsl,imx25-tsadc device?
> 
> There are no other registers in this range. The tcq and gcq devices can
> not be used outside of the tsadc. gcq and tcq are identical units so it
> may work to use both of them as gcq for example but nothing else.
> 
> It may work to have this as single IIO device. However this would be a
> major rework of this series. There are a lot less users of imx25 than
> imx6 for example. And of these users barely anyone uses this unit at
> all. I really would like to get these drivers mainline so others can use
> it. But after 1 year and 7 versions of this series I don't want to put
> a lot of work into these drivers. I think there are other components in
> the kernel where the time is better used.
> 
> Best Regards,
> 
> Markus
> 
I was pretty much against the IIO driver registering with input at least
where it was vaguely separable.  Pushed a few drivers in this direction.
Slightly more code, but often these devices are pretty separable (even
if like here it's two identical hardware blocks) and we normally get
a whole chunk of touch screen specific magic hardware that isn't of
general use.

It would be lovely to try and generalize some of this stuff and have
the touchscreen driver act as a client of IIO, but the
hardware is too fiddly for it to be obvious how to do it so far.

Jonathan


