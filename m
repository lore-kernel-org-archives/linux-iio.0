Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:58183 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbcBOJVb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2016 04:21:31 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	"Andrew F . Davis" <afd@ti.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: health/afe4403: mark suspend/resume functions __maybe_unused
Date: Mon, 15 Feb 2016 10:20:49 +0100
Message-ID: <3204595.MT2N1UgYF8@wuerfel>
In-Reply-To: <CAEnQRZBSYy2inu0mUtXEdhEKWQj5i-YUFDL61prvC_8P_L0adQ@mail.gmail.com>
References: <1455526993-2132098-1-git-send-email-arnd@arndb.de> <CAEnQRZBSYy2inu0mUtXEdhEKWQj5i-YUFDL61prvC_8P_L0adQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Monday 15 February 2016 11:18:20 Daniel Baluta wrote:
> On Mon, Feb 15, 2016 at 11:02 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > The newly added afe4403 driver implements suspend/resume using the
> > SIMPLE_DEV_PM_OPS() macro, which leaves out references to the actual
> > functions when CONFIG_PM is disabled, causing a harmless warning:
> >
> > health/afe4403.c:509:12: error: 'afe4403_suspend' defined but not used
> > health/afe4403.c:530:12: error: 'afe4403_resume' defined but not used
> >
> > This marks the functions as __maybe_unused so we don't get those
> > warnings.
> >
> Or we could put _suspend and _resume under CONFIG_PM_SLEEP.

That never works reliably. I still have a backlog of ~50 patches
of drivers that got this wrong in the past.

> We have:
> 
> :~/w/iio/drivers/iio$ ack-grep SIMPLE_DEV_PM_OPS | wc -l
> 31
> 
> and only 2 drivers using __maybe_unused.
> 
> :~/w/iio/drivers/iio$ ack-grep maybe_unused
> gyro/itg3200_core.c
> 354:static int __maybe_unused itg3200_suspend(struct device *dev)
> 365:static int __maybe_unused itg3200_resume(struct device *dev)
> 
> adc/imx7d_adc.c
> 553:static int __maybe_unused imx7d_adc_suspend(struct device *dev)
> 566:static int __maybe_unused imx7d_adc_resume(struct device *dev)
> 
> For consistency, we should use CONFIG_PM_SLEEP and get rid of __maybe_unused.

I hope to eventually kill off all the CONFIG_PM_SLEEP checks and then
make it work automatically by redefining SIMPLE_DEV_PM_OPS so it
leaves an unused reference to the functions.

	Arnd
