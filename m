Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:63504 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbcFTFAF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2016 01:00:05 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 0/9] iio: bmp280: improve driver
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <1466361242-2994-1-git-send-email-linus.walleij@linaro.org>
Date: Mon, 20 Jun 2016 06:56:49 +0200
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>
Message-Id: <20230B5B-1816-4802-B1BB-050DD3330186@goldelico.com>
References: <1466361242-2994-1-git-send-email-linus.walleij@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

> Am 19.06.2016 um 20:33 schrieb Linus Walleij <linus.walleij@linaro.org>:
> 
> The goal of the original exercise to enable the driver for my
> Dragonboard expanded when I found the *second* driver for this
> sensor in drivers/misc/bmp085.
> 
> So I wrote a patch series to bring the features of the IIO driver
> on par with the misc driver, and beyond it:
> 
> - The first patch set stuff augmenting DT bindings and adding
>  regulators and a reset GPIO.
> 
> - Split transport from core driver (separate I2C module)
> 
> - Added SPI support (which I cannot test, grateful for any help,
>  but pretty sure it works).
> 
> - Support for the BMP085 EOC interrupt mechanism rather than
>  waiting for the conversion to happen.
> 
> - Do not re-read calibration data all the time, also toss the
>  calibration into the entropy pool.
> 
> After this I think the misc driver can be replaced with this
> driver, but I'd love to hear from the maintainers of that driver
> if I've missed something. One of the patches adds all the authors
> of the misc driver listed there as I can clearly see code was
> copied into this driver at several points.
> 
> The only thing missing from the misc driver is the sysfs
> interface. If there is real userspace out there using it, we
> can implement a compatibility sysfs ABI. But then I'd like
> to know what userspace it is, so I can test it.

I will test on GTA04 as soon as I find a little time for it. We use
the sysfs only for debugging and this can also be done through
iio. So AFAIK there will be no functionality missing.

BR,
Nikolaus

