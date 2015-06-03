Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38076 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933099AbbFCRF6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jun 2015 13:05:58 -0400
Received: by wibdt2 with SMTP id dt2so20831079wib.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2015 10:05:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150603110241.GK1715@piout.net>
References: <1433280853-3988-1-git-send-email-octavian.purdila@intel.com>
	<20150603110241.GK1715@piout.net>
Date: Wed, 3 Jun 2015 20:05:56 +0300
Message-ID: <CAE1zot+nb9dc=pUZBphf8yMKyUbNk98QTTcHsmy2b3677yzn+A@mail.gmail.com>
Subject: Re: [PATCH 0/2] change "client->irq >= 0" to "client->irq > 0"
From: Octavian Purdila <octavian.purdila@intel.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	rtc-linux@googlegroups.com, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jun 3, 2015 at 2:02 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 03/06/2015 at 00:34:11 +0300, Octavian Purdila wrote :
>> This fixes an issue introduces by commit dab472eb931b ("i2c / ACPI:
>> Use 0 to indicate that device does not have interrupt assigned") where
>> drivers will try to request IRQ 0 when no GpioInt is defined in ACPI.
>>
>> The same issue occurs when the device is instantiated via device tree
>> with no IRQ, or from the i2c sysfs interface, even before the patch
>> above.
>>
>> Linus, since the commit above was already merged in the GPIO tree,
>> should these fixes be merged also via the GPIO tree (with ACKs from
>> the others subsystem maintainers)?
>>
>
> Side question, has it been considered that IRQ 0 is valid on some
> platform and that means i2c devices will not be able to be wired to that
> IRQ anymore? Though, I don't think there are any existing design that
> does so.
>

Device tree instantiation does not allow you to used IRQ 0 anyway. And
here is what Linus said about this:

http://yarchive.net/comp/linux/no_irq.html
