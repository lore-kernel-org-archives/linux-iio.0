Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39905 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293Ab2L0MO7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 27 Dec 2012 07:14:59 -0500
Message-ID: <50DC3BC1.4060909@kernel.org>
Date: Thu, 27 Dec 2012 12:14:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	linux-iio@vger.kernel.org,
	Ludovic Desroches <ludovic.desroches@atmel.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] IIO: AT91: add lowres, sleep and sample&hold time
 missing support
References: <20121219183236.GP23971@game.jcrosoft.org> <50D2EDBE.3020805@atmel.com>
In-Reply-To: <50D2EDBE.3020805@atmel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/20/2012 10:51 AM, Nicolas Ferre wrote:
> On 12/19/2012 07:32 PM, Jean-Christophe PLAGNIOL-VILLARD :
>> Hi,
>>
>> 	The current adc driver is missing some key feature support
>> 	 - select high/low resolution support
>> 	 - sleep mode
>> 	 - Sample and Hold Time
>>
>> 	 This patch seris fix it
>> 	 Without it the current driver is not usable in most of the case
>>
>> Jean-Christophe PLAGNIOL-VILLARD (2):
>>       ARM: AT91: IIO: add sleep mode support
>>       ARM: AT91: IIO: fix missing Sample and Hold time
>>
>> Ludovic Desroches (1):
>>       ARM: AT91: IIO: add low and high res support for adc
>>
>>  Documentation/devicetree/bindings/arm/atmel-adc.txt |   13 ++++++++++++
>>  arch/arm/boot/dts/at91sam9260.dtsi                  |    3 +++
>>  arch/arm/boot/dts/at91sam9g45.dtsi                  |    3 +++
>>  arch/arm/boot/dts/at91sam9x5.dtsi                   |    3 +++
>>  drivers/iio/adc/at91_adc.c                          |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
> 
> As this series is touching both a driver and the DT files, we will have
> to pay attention to the path that we will take for upstream.
> 
> Arm-soc is my preferred location...

I don't particularly care as I don't know of anything else that is planned for
this cycle that will touch this driver but generally I'd consider this series
driver changes with additions to the device tree to support new functionality.

The only reason to merge through the arm-soc tree I can see is that there is
likely to be more churn in the device tree files.

There is also the question of whether that missing sample and hold time is
a fix we want to push out this cycle, or whether it can wait for the next
merge window.  I'm not clear from the description.

Jonathan

> 
> 
> Bye,
> 
>>  5 files changed, 107 insertions(+), 5 deletions(-)
>>
>> Best Regards,
>> J.
>>
> 
> 
