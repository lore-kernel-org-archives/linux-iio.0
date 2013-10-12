Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47535 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab3JLLdK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 07:33:10 -0400
Message-ID: <525941A0.7090706@kernel.org>
Date: Sat, 12 Oct 2013 13:33:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>, Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Stefan Roese <sr@denx.de>,
	Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH 2/2] staging:iio: Allow to build SoC specific drivers
 when COMPILE_TEST is set
References: <1381152374-16567-1-git-send-email-lars@metafoo.de> <1381152374-16567-2-git-send-email-lars@metafoo.de> <5252B6BB.8020902@metafoo.de> <201310071635.49502.marex@denx.de>
In-Reply-To: <201310071635.49502.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/07/13 15:35, Marek Vasut wrote:
> Dear Lars-Peter Clausen,
> 
>> On 10/07/2013 03:26 PM, Lars-Peter Clausen wrote:
>>> None of the SPEAr, LPC32XX or MXS ADC drivers have a compile time
>>> dependency on their respective platform. So make it possible to build
>>> the drivers when CONFIG_COMPILE_TEST is set. This makes it easier to
>>> compile test changes.
>>>

I'm getting a ERROR: "stmp_reset_block" [drivers/staging/iio/adc/mxs-lradc.ko] undefined!

Also for reference also the following warnings from a build with sparse enabled.

  CHECK   drivers/staging/iio/adc/mxs-lradc.c

drivers/staging/iio/adc/mxs-lradc.c:1298:25: warning: incorrect type in argument 1 (different address spaces)
drivers/staging/iio/adc/mxs-lradc.c:1298:25:    expected void const *ptr
drivers/staging/iio/adc/mxs-lradc.c:1298:25:    got void [noderef] <asn:2>*base
drivers/staging/iio/adc/mxs-lradc.c:1299:37: warning: incorrect type in argument 1 (different address spaces)
drivers/staging/iio/adc/mxs-lradc.c:1299:37:    expected void const *ptr
drivers/staging/iio/adc/mxs-lradc.c:1299:37:    got void [noderef] <asn:2>*base
  CC [M]  drivers/staging/iio/adc/mxs-lradc.o
  CHECK   drivers/staging/iio/adc/spear_adc.c
drivers/staging/iio/adc/spear_adc.c:321:18: warning: cast removes address space of expression
drivers/staging/iio/adc/spear_adc.c:320:33: warning: incorrect type in assignment (different address spaces)
drivers/staging/iio/adc/spear_adc.c:320:33:    expected struct adc_regs_spear3xx [noderef] <asn:2>*adc_base_spear3xx
drivers/staging/iio/adc/spear_adc.c:320:33:    got struct adc_regs_spear3xx *<noident>


I haven't even glanced at what caused these as yet.

>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>> Cc: Stefan Roese <sr@denx.de>
>>> Cc: Marek Vasut <marex@denx.de
>>
>> Missing > here, added Marek to Cc manually
> 
> Thanks. Makes sense to me
> 
> Reviewed-by: Marek Vasut <marex@denx.de>
> 
> Best regards,
> Marek Vasut
> 

