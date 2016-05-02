Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:62329 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbcEBM3v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 May 2016 08:29:51 -0400
Subject: Re: [PATCH 0/3] mxs-lradc: Add support for current sources
To: Jonathan Cameron <jic23@kernel.org>,
	Harald Geyer <harald@ccbib.org>
References: <1461333147-11873-1-git-send-email-harald@ccbib.org>
 <572379F5.8000501@i2se.com> <aadb3f41413d093312c0af3e4c207a8a@ccbib.org>
 <ac57f3e9-f8f2-a6ef-52fa-0a13d7df5d4f@kernel.org>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Marek Vasut <marex@denx.de>,
	linux-arm-kernel@lists.infradead.org
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <57274814.3090208@i2se.com>
Date: Mon, 2 May 2016 14:29:08 +0200
MIME-Version: 1.0
In-Reply-To: <ac57f3e9-f8f2-a6ef-52fa-0a13d7df5d4f@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Harald,

Am 01.05.2016 um 20:02 schrieb Jonathan Cameron:
> On 29/04/16 18:45, Harald Geyer wrote:
>> Hi Stefan!
>>
>> On 29.04.2016 17:12, Stefan Wahren wrote:
>>> Hi Harald,
>>>
>>> Am 22.04.2016 um 15:52 schrieb Harald Geyer:
>>>> Patch 1/3 changes the driver and updates the binding documentation
>>>> (I guess it is still in staging.)
>>>>
>>>> Patches 2/3 and 3/3 add the devicetree nodes to imx23 and imx28 boards.
>>>> I'd like to get input whether this is actually desired. On boards where
>>>> these regulators would never be enabled this costs a few extra bytes of
>>>> RAM for allocation of the device data, because the nodes can't be easily
>>>> removed in .dts files which are including the .dtsi files. The alternative
>>>> is to add the new nodes to many .dts files, which would be a lot code
>>>> duplication.
>>> if i get it right the real intention of this patch series is to make the
>>> mxs-lradc provide resistance values instead of voltages.
>> ... or even temperature values if a thermistor is connected.
>>
>>> So how about
>>> dropping the whole regulator stuff and provide the values as
>>> IIO_RESISTANCE via iio interface?
>> Can you elaborate on this?
>>
>> My thinking is that there should be a thermistor (or whatever else) driver,
>> that is a consumer of the regulator and a consumer of the IIO_VOLTAGE
>> iio channel and provides a new device with an IIO_RESISTANCE or IIO_TEMP
>> channel. Maybe there is a simpler solution, that I'm missing?
> I agree with that approach - need a way to describe the upstream hardware - so
> will need a thermistor driver

okay, this makes more sense to me. In this case it would be good to have
this new driver in this patch series. So it's possible to verify the
matching binding.

>> Actually I'm not 100% happy with the above solution myself, because if we
>> start supporting devices that act as an iio-multiplexer (some device that
>> is an iio consumer and provides many new iio channels and can control
>> via gpios which of it child channels is actually routed to the upstream
>> device) I don't know how to properly manage the regulator device.
> Hmm. Are you talking about muxing the regulator as well?  That will get
> complex indeed.  Might be possible to cheat and imply the regulators are
> always connected to all inputs...  or do you want to dynamically change
> the regulator output?  That gets messy fast - though in theory might be
> possible...
>> However since this is only hypothetical ATM, I think we don't have to
>> worry about this too much.
>>
>>> Btw this feature should be only added to dts files where is actually used.
>> Ok, so how do we figure out which boards these are?
>> I use this on the olinuxino and I guess all evaluation boards support the
>> use case too. The others I don't know enough about to be sure and I guess
>> it's not a good idea to just wait until somebody speaks up and complains
>> that the feature is missing on board X ...

The imx23 dtsi file specifies features on SoC level and i think this
should be kept. We shouldn't implement features for ADC pins without
deeper knowledge about these boards.

Maybe we could introduce a new dtsi file in order to reduce copy &
paste. But at first the OlinuXino should be a good starting point ...

Regards
Stefan

