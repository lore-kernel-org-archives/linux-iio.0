Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:35980 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab2LTKvp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Dec 2012 05:51:45 -0500
Message-ID: <50D2EDBE.3020805@atmel.com>
Date: Thu, 20 Dec 2012 11:51:42 +0100
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	<linux-iio@vger.kernel.org>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
CC: <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/3] IIO: AT91: add lowres, sleep and sample&hold time
 missing support
References: <20121219183236.GP23971@game.jcrosoft.org>
In-Reply-To: <20121219183236.GP23971@game.jcrosoft.org>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/19/2012 07:32 PM, Jean-Christophe PLAGNIOL-VILLARD :
> Hi,
> 
> 	The current adc driver is missing some key feature support
> 	 - select high/low resolution support
> 	 - sleep mode
> 	 - Sample and Hold Time
> 
> 	 This patch seris fix it
> 	 Without it the current driver is not usable in most of the case
> 
> Jean-Christophe PLAGNIOL-VILLARD (2):
>       ARM: AT91: IIO: add sleep mode support
>       ARM: AT91: IIO: fix missing Sample and Hold time
> 
> Ludovic Desroches (1):
>       ARM: AT91: IIO: add low and high res support for adc
> 
>  Documentation/devicetree/bindings/arm/atmel-adc.txt |   13 ++++++++++++
>  arch/arm/boot/dts/at91sam9260.dtsi                  |    3 +++
>  arch/arm/boot/dts/at91sam9g45.dtsi                  |    3 +++
>  arch/arm/boot/dts/at91sam9x5.dtsi                   |    3 +++
>  drivers/iio/adc/at91_adc.c                          |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----

As this series is touching both a driver and the DT files, we will have
to pay attention to the path that we will take for upstream.

Arm-soc is my preferred location...


Bye,

>  5 files changed, 107 insertions(+), 5 deletions(-)
> 
> Best Regards,
> J.
> 


-- 
Nicolas Ferre
