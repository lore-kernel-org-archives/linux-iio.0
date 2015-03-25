Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37705 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbbCYVMR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2015 17:12:17 -0400
Received: by wixw10 with SMTP id w10so56887776wix.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2015 14:12:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150325132116.GY1878@lahna.fi.intel.com>
References: <1427118025-4380-1-git-send-email-robert.dolca@intel.com>
	<551155C3.2030403@metafoo.de>
	<CAFPB+YdwrPoob1CPdUfSt2uBJWPi=6_0-d0NChj2agD6-z-8qw@mail.gmail.com>
	<551168F0.1090901@metafoo.de>
	<CACRpkdaOQ-onkgQJSyoVEQNtkZ9nF_4z=9jNdU-tug-TwvAAkQ@mail.gmail.com>
	<20150324150630.GP1878@lahna.fi.intel.com>
	<CACRpkdYmN5YnH5rcA13NerPKdx62TpQVi5Hwr1vchu13QUcaOw@mail.gmail.com>
	<20150325094327.GW1878@lahna.fi.intel.com>
	<20150325122505.GX1878@lahna.fi.intel.com>
	<20150325132116.GY1878@lahna.fi.intel.com>
Date: Wed, 25 Mar 2015 23:12:16 +0200
Message-ID: <CAE1zotJas26oRGdext7V69mNNyaYT3Ds7+Ruhg_kNKBf-Ewoew@mail.gmail.com>
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
From: Octavian Purdila <octavian.purdila@intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Robert Dolca <robert.dolca@gmail.com>,
	Robert Dolca <robert.dolca@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Denis CIOCCA <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 25, 2015 at 3:21 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Wed, Mar 25, 2015 at 02:25:05PM +0200, Mika Westerberg wrote:
>> I think we can do the same for ACPI GpioInts so that we introduce
>> acpi_gpio_irq_get() that translates from GpioInt to Linux IRQ
>> numberspace. Then we can do something like below in I2C core:
>>
>>       if (client->irq <= 0) {
>>               int irq = -ENOENT;
>>
>>                 if (dev->of_node)
>>                         irq = of_irq_get(dev->of_node, 0);
>>                 else if (ACPI_COMPANION(dev))
>>                         irq = acpi_gpio_irq_get(ACPI_COMPANION(dev), 0);
>>
>>               if (irq == -EPROBE_DEFER)
>>                         return irq;
>>                 if (irq < 0)
>>                         irq = 0;
>>
>>                 client->irq = irq;
>>       }
>>
>> Now it has the drawback that the first GpioInt will not be available to
>> the driver anymore (as a GPIO since it is locked) but if DT already does
>> the same we should be fine.
>
> Below patch should take care of this.
>

One issue we noticed is that now the gpio request and set input
directions operations are not called anymore. Some gpio controller
drivers (dln2, adnp, lynx_point from quickly browsing the code) do not
explicitly enable the GPIO pin nor set direction to input when the
interrupt is enabled. Depending on hardware this may be an issue - it
is on dln2 for example.

Should the gpio controllers enable and set to input in irq_enable,
irq_bus_sync_unlock, etc.? Or should this be done in gpiolib?
