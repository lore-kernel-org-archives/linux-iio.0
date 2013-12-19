Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:46994 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab3LSJAq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 19 Dec 2013 04:00:46 -0500
Received: by mail-we0-f174.google.com with SMTP id q58so735988wes.5
        for <linux-iio@vger.kernel.org>; Thu, 19 Dec 2013 01:00:45 -0800 (PST)
Date: Thu, 19 Dec 2013 09:00:40 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Zubair Lutfullah <zubair.lutfullah@gmail.com>,
	Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] mfd: ti_am335x: drop am335x_tsc_se_update() from
 resume path
Message-ID: <20131219090040.GH2621@lee--X1>
References: <1387385577-24447-1-git-send-email-bigeasy@linutronix.de>
 <1387385577-24447-5-git-send-email-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1387385577-24447-5-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> The update of the SE register in MFD doesn't look right as it has
> nothing to do with it. The better place to do it is in TSC driver (which
> is already doint it) and in the ADC driver which needs this only in the
> continues mode.

When you resubmit the patch-set complete with Acks, please ensure you
spell check and proof read _all_ of your commit logs.

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 2 ++
>  drivers/mfd/ti_am335x_tscadc.c  | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)

For the MFD part:
  Acked-by: Lee Jones <lee.jones@linaro.org>

It's probably best that we suck these changes up through the MFD tree,
so once the review comments have been satisfied and we have all
relevant Acks I can take them in and create an immutable branch for
you guys to pull from if you like.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
