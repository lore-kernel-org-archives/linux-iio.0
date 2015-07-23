Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:27021 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbbGWM6o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2015 08:58:44 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: gpadc iio support for tlw6037/palmas [was: twl6030-gpadc support for twl6037]
From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <1437594062.2382998.330577153.4CE28783@webmail.messagingengine.com>
Date: Thu, 23 Jul 2015 14:58:26 +0200
Cc: Belisko Marek <marek.belisko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Axel Lin <axel.lin@ingics.com>, linux-iio@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>,
	linux-omap <linux-omap@vger.kernel.org>, balajitk@ti.com,
	oleksandr.kozaruk@ti.com,
	Michael Mrozek <EvilDragon@openpandora.org>,
	Grazvydas Ignotas <notaz@openpandora.org>
Message-Id: <CB1BA4C2-51EC-493D-A290-E506DE974605@goldelico.com>
References: <CAAfyv354=J+iDgLcu9KRZSScGSzYrRsCMmUEc_tW84GfduSebw@mail.gmail.com> <CAAfyv35bUMZKfMQDJYwD_uGRNOiqLqAB4UG=gREgCSWa8vhjdw@mail.gmail.com> <1437593628.2381718.330572297.2F6F1C50@webmail.messagingengine.com> <1437594062.2382998.330577153.4CE28783@webmail.messagingengine.com>
To: Graeme Gregory <gg@slimlogic.co.uk>,
	Laxman Dewangan <ldewangan@nvidia.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Graeme,

Am 22.07.2015 um 21:41 schrieb Graeme Gregory <gg@slimlogic.co.uk>:

> 
> 
> On Wed, 22 Jul 2015, at 08:33 PM, Graeme Gregory wrote:
>> 
>> 
>> On Wed, 22 Jul 2015, at 08:28 PM, Belisko Marek wrote:
>>> Adding also twl6030-gpadc driver authors to loop
>>> 
>>> On Mon, Jul 20, 2015 at 8:57 AM, Belisko Marek <marek.belisko@gmail.com>
>>> wrote:
>>>> Hi all,
>>>> 
>>>> I'm trying to figure out what is relation between palmas mfd driver
>>>> and twl-core for twl603x devices.
>>>> twl-core driver seems to be older than palmas driver but seems both
>>>> export same functionality (except that palmas have defined structs for
>>>> gpadc but functionality is missing). My main focus is to add support
>>>> for twl6037 to gpadc iio driver in iio/adc/twl6030-gpadc which is
>>>> using twl-core for twl6030 and twl6032. Adding twl6037 support should
>>>> be straightforward but dts file used in omap5-uevm using palmas driver
>>>> and not twl6030. So it's completely confusing to me how to proceed or
>>>> which direction is correct. Seems I'm missing some parts of puzzle ;)
>>>> Thanks for any hints.
>>>> 
>> Phoenix is twl6030, twl6032
>> 
>> Palmas is twl6035, twl6037 and maybe others.
>> 
>> Phoenix and Palmas are two totally different chips but marketing gave
>> them numbers near each other for unknown reasons.
>> 
> Also this might be useful.
> 
> https://github.com/slimlogic/linux/commit/312a6a1c8013fd056431c31567b43d8eef40f333
> 
> A pre IIO palmas ADC driver which I never got around to upstreaming
> because TIpocalypse left me with no access to a palmas chip.

We managed to integrate your code into our 4.1 kernel (needed minor fixes mainly for
irq initialization) and it appears to work on the omap5432evm. Especially channels
in6_channel and in7_channel in /sys/bus/platform/drivers/palmas-gpadc/48070000.i2c:palmas@48:gpadc
show reasonable (and slightly fluctuating) volt values.

Now the question is how to proceed. We could either write some drivers/iio/adc/palmas-gpadc.c
wrapper around your driver, or could try this one which appears to be a pure iio implementation:

https://android.googlesource.com/kernel/tegra.git/+/28f245bb8f590f61bb244f1b4d03f4b4919d32ea/Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
https://android.googlesource.com/kernel/tegra/+/aaabb2e045f31e5a970109ffdaae900dd403d17e/drivers/staging/iio/adc/palmas_gpadc.c

Do you think the latter has a chance to be accepted upstream?

The reason we ask is that we neither want to write new code if something exists nor base
our work on something that can not be upstreamed.

We have added the author(s) of this tegra/android driver so they can please also comment
on their plans for submitting the driver upstream.

BR and thank you,
Nikolaus and Marek

