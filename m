Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:41349 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933454Ab1KCQ1j (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Nov 2011 12:27:39 -0400
Message-ID: <4EB2C0F1.1030404@free-electrons.com>
Date: Thu, 03 Nov 2011 17:27:29 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Linus Walleij <linus.ml.walleij@gmail.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>
Subject: Re: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com> <1320315070-1700-1-git-send-email-maxime.ripard@free-electrons.com> <1320315070-1700-2-git-send-email-maxime.ripard@free-electrons.com> <CAKnu2MqTVPxioKyr-F6JWcdF5SRZjzLSFPt5A-6CkZO7HyeHRw@mail.gmail.com>
In-Reply-To: <CAKnu2MqTVPxioKyr-F6JWcdF5SRZjzLSFPt5A-6CkZO7HyeHRw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Linus,

On 03/11/2011 12:27, Linus Walleij wrote:
> 2011/11/3 Maxime Ripard <maxime.ripard@free-electrons.com>:
> 
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>  arch/arm/mach-at91/include/mach/board.h |   22 ++++++++++++++++++++++
>>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> We're not supposed to have platform data dependent to stuff in
> staging under arch/arm or anyplace else in the main kernel tree.
> 
> Please move this to
> drivers/staging/iio/adc/at91adc-board.h
> or so.

Won't moving this part to staging prevent from using this structure in
board files ? If so, how will I be able to declare a new board that is
using this ADC (or add the support for the ADC to a new one) ?

> As for calling the at91_add_device_adc() function (which I guess
> you want to do at some point) the pattern I followed for other
> drivers is to declare a dummy function in arch/arm/mach-*
> with __weak and let the staging driver override that. This way
> the staging driver can go away without any compilation trouble
> happening.

I don't really see why my changes will break the compilation if the
driver is no longer present in staging. At worst, the structure will be
filled but used by no one, right ?

Regards,

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
