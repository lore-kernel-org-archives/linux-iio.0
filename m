Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-038.synserver.de ([212.40.185.38]:1033 "EHLO
	smtp-out-037.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751741Ab3JLLvk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 07:51:40 -0400
Message-ID: <5259383F.8060103@metafoo.de>
Date: Sat, 12 Oct 2013 13:53:35 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
	Stefan Roese <sr@denx.de>, Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH 2/2] staging:iio: Allow to build SoC specific drivers
 when COMPILE_TEST is set
References: <1381152374-16567-1-git-send-email-lars@metafoo.de> <1381152374-16567-2-git-send-email-lars@metafoo.de> <5252B6BB.8020902@metafoo.de> <201310071635.49502.marex@denx.de> <525941A0.7090706@kernel.org>
In-Reply-To: <525941A0.7090706@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/12/2013 02:33 PM, Jonathan Cameron wrote:
> On 10/07/13 15:35, Marek Vasut wrote:
>> Dear Lars-Peter Clausen,
>>
>>> On 10/07/2013 03:26 PM, Lars-Peter Clausen wrote:
>>>> None of the SPEAr, LPC32XX or MXS ADC drivers have a compile time
>>>> dependency on their respective platform. So make it possible to build
>>>> the drivers when CONFIG_COMPILE_TEST is set. This makes it easier to
>>>> compile test changes.
>>>>
> 
> I'm getting a ERROR: "stmp_reset_block" [drivers/staging/iio/adc/mxs-lradc.ko] undefined!

It's called CONFIG_COMPILE_TEST for a reason and not CONFIG_LINK_TEST ;) Ok,
I guess I should have not been lazy and actually also link tested. It looks
as if the driver needs to select the STMP_DEVICE symbol in it's Kconfig
entry. It is automatically selected by ARCH_MXS, so we didn't see the error
before, but other drivers using that function also select the Kconfig
symbol, so I think it is the right thing to do. I'll add a patch which adds
the select and then resend the series.

> 
> Also for reference also the following warnings from a build with sparse enabled.
> 
>   CHECK   drivers/staging/iio/adc/mxs-lradc.c
> 
> drivers/staging/iio/adc/mxs-lradc.c:1298:25: warning: incorrect type in argument 1 (different address spaces)
> drivers/staging/iio/adc/mxs-lradc.c:1298:25:    expected void const *ptr
> drivers/staging/iio/adc/mxs-lradc.c:1298:25:    got void [noderef] <asn:2>*base
> drivers/staging/iio/adc/mxs-lradc.c:1299:37: warning: incorrect type in argument 1 (different address spaces)
> drivers/staging/iio/adc/mxs-lradc.c:1299:37:    expected void const *ptr
> drivers/staging/iio/adc/mxs-lradc.c:1299:37:    got void [noderef] <asn:2>*base 

The one above will be gone after you updated your sparse installation to the
latest version.

>   CC [M]  drivers/staging/iio/adc/mxs-lradc.o
>   CHECK   drivers/staging/iio/adc/spear_adc.c
> drivers/staging/iio/adc/spear_adc.c:321:18: warning: cast removes address space of expression
> drivers/staging/iio/adc/spear_adc.c:320:33: warning: incorrect type in assignment (different address spaces)
> drivers/staging/iio/adc/spear_adc.c:320:33:    expected struct adc_regs_spear3xx [noderef] <asn:2>*adc_base_spear3xx
> drivers/staging/iio/adc/spear_adc.c:320:33:    got struct adc_regs_spear3xx *<noident>
> 

This one is a bit ugly as it used a struct to access io mapped registers.
The sparse warning can be eliminated though by annotating the struct pointer
with __iomem.

- Lars
