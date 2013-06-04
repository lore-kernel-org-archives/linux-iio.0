Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-024.synserver.de ([212.40.185.24]:1422 "EHLO
	smtp-out-019.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754008Ab3FDQXA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2013 12:23:00 -0400
Message-ID: <51ADF315.1060108@metafoo.de>
Date: Tue, 04 Jun 2013 16:00:53 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, mirq-linux@rere.qmqm.pl
Subject: Re: [PATCH 0/4 V2]  iio: Rework the generic trigger-gpio trigger
 and move out of staging
References: <1370199616-25500-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1370199616-25500-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/02/2013 09:00 PM, Jonathan Cameron wrote:
> Only changes here are dropping the irq_res_cnt as it unused (thanks Lars) and
> a rebase as a result of some Kconfig dependency changes.
> 
> I still don't have a hardware setup, but this is so simple that unless
> someone shouts I'll probably send it upstream in fairly soon anyway.
> 
> Jonathan
> 
> Previous message:
> 
> Hi all,
> 
> This is an RFC for a couple of reasons.
> 
> 1) I'm not sure how people feel about the move to multiple platform devices
> (patch 3).
> 2) I don't actually have a simple test setup for this one.  I can put one
> together but it might be a while before I get it done.
> 
> Anyhow, the purpose of this set is to respond to Lars-Peter's comments
> when I originally asked if anyone minded it moving out of staging as it
> was before this.  Lars raised the point that having one driver instance
> register multiple triggers just made life more complicated, and instead
> it might be better to have multiple driver instances, with one trigger each.
> Lars also pointed out that the name of the driver was silly given there
> was nolonger a requirement that the source of the interrupts be a gpio
> and there hasn't been for quite some time.
> 
> All comments welcome. Particularly wrt to patch 3.

Looks all good to me. FWIW:

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

> 
> Jonathan Cameron (4):
>   staging:iio:trigger:gpio bug in release of gpio in error path
>   staging:iio:triggers: rename iio-trig-gpio to iio-trig-interrupt
>   staging:iio:triggers:interrupt trigger - one per platform device.
>   iio:triggers:interrupt trigger - move out of staging.
> 
>  drivers/iio/trigger/Kconfig                 |   9 ++
>  drivers/iio/trigger/Makefile                |   1 +
>  drivers/iio/trigger/iio-trig-interrupt.c    | 121 ++++++++++++++++++++
>  drivers/staging/iio/trigger/Kconfig         |   6 -
>  drivers/staging/iio/trigger/Makefile        |   1 -
>  drivers/staging/iio/trigger/iio-trig-gpio.c | 167 ----------------------------
>  6 files changed, 131 insertions(+), 174 deletions(-)
>  create mode 100644 drivers/iio/trigger/iio-trig-interrupt.c
>  delete mode 100644 drivers/staging/iio/trigger/iio-trig-gpio.c
> 

