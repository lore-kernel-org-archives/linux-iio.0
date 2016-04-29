Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:40240 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752404AbcD2RpW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 29 Apr 2016 13:45:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 29 Apr 2016 19:45:18 +0200
From: Harald Geyer <harald@ccbib.org>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Jonathan Cameron <jic23@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Marek Vasut <marex@denx.de>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/3] mxs-lradc: Add support for current sources
In-Reply-To: <572379F5.8000501@i2se.com>
References: <1461333147-11873-1-git-send-email-harald@ccbib.org>
 <572379F5.8000501@i2se.com>
Message-ID: <aadb3f41413d093312c0af3e4c207a8a@ccbib.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Stefan!

On 29.04.2016 17:12, Stefan Wahren wrote:
> Hi Harald,
>
> Am 22.04.2016 um 15:52 schrieb Harald Geyer:
>> Patch 1/3 changes the driver and updates the binding documentation
>> (I guess it is still in staging.)
>>
>> Patches 2/3 and 3/3 add the devicetree nodes to imx23 and imx28 
>> boards.
>> I'd like to get input whether this is actually desired. On boards 
>> where
>> these regulators would never be enabled this costs a few extra bytes 
>> of
>> RAM for allocation of the device data, because the nodes can't be 
>> easily
>> removed in .dts files which are including the .dtsi files. The 
>> alternative
>> is to add the new nodes to many .dts files, which would be a lot 
>> code
>> duplication.
>
> if i get it right the real intention of this patch series is to make 
> the
> mxs-lradc provide resistance values instead of voltages.

... or even temperature values if a thermistor is connected.

> So how about
> dropping the whole regulator stuff and provide the values as
> IIO_RESISTANCE via iio interface?

Can you elaborate on this?

My thinking is that there should be a thermistor (or whatever else) 
driver,
that is a consumer of the regulator and a consumer of the IIO_VOLTAGE
iio channel and provides a new device with an IIO_RESISTANCE or 
IIO_TEMP
channel. Maybe there is a simpler solution, that I'm missing?

Actually I'm not 100% happy with the above solution myself, because if 
we
start supporting devices that act as an iio-multiplexer (some device 
that
is an iio consumer and provides many new iio channels and can control
via gpios which of it child channels is actually routed to the upstream
device) I don't know how to properly manage the regulator device.
However since this is only hypothetical ATM, I think we don't have to
worry about this too much.

> Btw this feature should be only added to dts files where is actually 
> used.

Ok, so how do we figure out which boards these are?
I use this on the olinuxino and I guess all evaluation boards support 
the
use case too. The others I don't know enough about to be sure and I 
guess
it's not a good idea to just wait until somebody speaks up and 
complains
that the feature is missing on board X ...

Thanks,
Harald

> Regards
> Stefan
>
>>
>> Harald Geyer (3):
>>   iio: mxs-lradc: Add regulators for current sources
>>   ARM: dts: imx23: Provide regulators for the current sources of the
>>     LRADC
>>   ARM: dts: imx28: Provide regulators for the current sources of the
>>     LRADC
>>
>>  .../bindings/staging/iio/adc/mxs-lradc.txt         |  29 ++++
>>  arch/arm/boot/dts/imx23.dtsi                       |   8 ++
>>  arch/arm/boot/dts/imx28.dtsi                       |   8 ++
>>  drivers/iio/adc/Kconfig                            |   1 +
>>  drivers/iio/adc/mxs-lradc.c                        | 152 
>> +++++++++++++++++++++
>>  5 files changed, 198 insertions(+)
>>

-- 
If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w
or bitcoin 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS
