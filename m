Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:53734 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751437AbbFCLCo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jun 2015 07:02:44 -0400
Date: Wed, 3 Jun 2015 13:02:41 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] change "client->irq >= 0" to "client->irq > 0"
Message-ID: <20150603110241.GK1715@piout.net>
References: <1433280853-3988-1-git-send-email-octavian.purdila@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433280853-3988-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/06/2015 at 00:34:11 +0300, Octavian Purdila wrote :
> This fixes an issue introduces by commit dab472eb931b ("i2c / ACPI:
> Use 0 to indicate that device does not have interrupt assigned") where
> drivers will try to request IRQ 0 when no GpioInt is defined in ACPI.
> 
> The same issue occurs when the device is instantiated via device tree
> with no IRQ, or from the i2c sysfs interface, even before the patch
> above.
> 
> Linus, since the commit above was already merged in the GPIO tree,
> should these fixes be merged also via the GPIO tree (with ACKs from
> the others subsystem maintainers)?
> 

Side question, has it been considered that IRQ 0 is valid on some
platform and that means i2c devices will not be able to be wired to that
IRQ anymore? Though, I don't think there are any existing design that
does so.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
