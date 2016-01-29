Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39779 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbcA2SGj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 29 Jan 2016 13:06:39 -0500
Date: Fri, 29 Jan 2016 12:05:42 -0600
From: Andreas Dannenberg <dannenberg@ti.com>
To: Alexander Koch <mail@alexanderkoch.net>, <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
	<mhornung.linux@gmail.com>, <balbi@ti.com>,
	<fengguang.wu@intel.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] iio: light: opt3001: Enable operation w/o IRQ
Message-ID: <20160129180542.GD7960@LTA0797059A>
References: <1452960878-1727-1-git-send-email-mail@alexanderkoch.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1452960878-1727-1-git-send-email-mail@alexanderkoch.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jan 16, 2016 at 05:14:35PM +0100, Alexander Koch wrote:
> This patch series aims at enabling IRQ-less operation for the TI OPT3001 light
> sensor.

Jon,
I was checking to see if the DT bindings have been updated to reflect
the interrupt-less operation however I can't seem to find it in the
Kernel tree. The last activity I can find is this one...

https://patchwork.ozlabs.org/patch/490819/

I guess it may have slipped through the cracks so I'm going to update
the bindings document and re-submit.

Regards,
Andreas

> 
> The current version of the driver requires an interrupt line to be connected to
> the INT pin of the sensor, through which the IIO framework gets notified about
> readout values being ready. In the datasheet this is described as optional (sec.
> 8.1.1).
> 
> In my use case of the OPT3001 I do not have any interrupt lines or GPIOs
> available to connect the INT pin to, so I have implemented an interrupt-less
> operation mode that simply sleeps for the specified worst-case readout time
> instead of waiting for the interrupt.
> 
> This change is transparent as interrupt-less operation mode is done only when no
> valid interrupt no. is configured via device tree.
> 
> Patches are taken against linux-next/master, tested by compilation,
> checkpatch.pl and by running on an embedded developer board (both IRQ-enabled
> and IRQ-less mode).
> 
> 
> Changes from v1:
> 
>  - use type bool for introduced member 'use_irq'
>  - include trivial refactoring step that changes the types of two other members
>    to bool, in order to match 'use_irq'
> 
> 
> Alexander Koch (3):
>   iio: light: opt3001: extract int. time constants
>   iio: light: opt3001: trivial type refactoring
>   iio: light: opt3001: enable operation w/o IRQ
> 
>  drivers/iio/light/opt3001.c | 156 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 106 insertions(+), 50 deletions(-)
> 
> -- 
> 2.7.0
> 
