Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:55921 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030221Ab2LHTmg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Dec 2012 14:42:36 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so1430819oag.19
        for <linux-iio@vger.kernel.org>; Sat, 08 Dec 2012 11:42:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1354893893-26338-3-git-send-email-marex@denx.de>
References: <1354893893-26338-1-git-send-email-marex@denx.de>
	<1354893893-26338-3-git-send-email-marex@denx.de>
Date: Sat, 8 Dec 2012 17:42:36 -0200
Message-ID: <CAOMZO5B_Dx_+KRn6h+erCj+CY3zk06MXODX-Nm1tcpao9mL2zg@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: mxs: Implement support for touchscreen
From: Fabio Estevam <festevam@gmail.com>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Dec 7, 2012 at 1:24 PM, Marek Vasut <marex@denx.de> wrote:
> This patch implements support for sampling of a touchscreen into
> the MXS LRADC driver. The LRADC block allows configuring some of
> it's channels into special mode where they either output the drive
> voltage or sample it, allowing it to operate a 4-wire or 5-wire
> resistive touchscreen.
>
> In case the touchscreen mode is enabled, the LRADC slot #7 is
> reserved for touchscreen only, therefore it is not possible to
> sample 8 LRADC channels at time, but only 7 channels.
>
> The touchscreen controller is configured such that the PENDOWN event
> disables touchscreen interrupts and triggers execution of worker
> thread, which then polls the touchscreen controller for X, Y and
> Pressure values. This reduces the overhead of interrupt-driven
> operation. Upon the PENUP event, the worker thread re-enables the
> PENDOWN detection interrupt and exits.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../bindings/staging/iio/adc/mxs-lradc.txt         |    6 +
>  drivers/staging/iio/adc/mxs-lradc.c                |  435 +++++++++++++++++++-

What about adding the touchscreen support into a separate file, so
that users can select/deselect it via Kconfig option?

Not everyone using lradc would be necessarily interested in the
touchscreen functionality, so better to let it optional.

Thanks,

Fabio Estevam
