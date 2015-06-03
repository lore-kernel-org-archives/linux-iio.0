Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-080.synserver.de ([212.40.185.80]:1060 "EHLO
	smtp-out-080.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965197AbbFCRNu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jun 2015 13:13:50 -0400
Message-ID: <556F35C9.4090208@metafoo.de>
Date: Wed, 03 Jun 2015 19:13:45 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Octavian Purdila <octavian.purdila@intel.com>
CC: Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] change "client->irq >= 0" to "client->irq > 0"
References: <1433280853-3988-1-git-send-email-octavian.purdila@intel.com> <20150603110241.GK1715@piout.net>
In-Reply-To: <20150603110241.GK1715@piout.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/03/2015 01:02 PM, Alexandre Belloni wrote:
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

If IRQ 0 is valid, that's a bug. IRQ 0 has been an invalid IRQ number in the 
global IRQ namespace for a while now. Though architectures are allowed to 
have a valid IRQ 0, but it may only be used inside the architecture code 
itself and must not be used for IRQs that are potentially be used by drivers.

- Lars

