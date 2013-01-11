Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bluegiga.fi ([194.100.31.45]:17620 "EHLO darkblue.bluegiga.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754071Ab3AKIbt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 11 Jan 2013 03:31:49 -0500
Message-ID: <50EFCDF2.7090207@bluegiga.com>
Date: Fri, 11 Jan 2013 10:31:46 +0200
From: Lauri Hintsala <lauri.hintsala@bluegiga.com>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawn.guo@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/2 V3] iio: mxs: Implement support for touchscreen
References: <1357861431-8978-1-git-send-email-marex@denx.de>
In-Reply-To: <1357861431-8978-1-git-send-email-marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 01/11/2013 01:43 AM, Marek Vasut wrote:
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
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>   .../bindings/staging/iio/adc/mxs-lradc.txt         |    6 +
>   drivers/staging/iio/adc/mxs-lradc.c                |  473 +++++++++++++++++++-
>   2 files changed, 455 insertions(+), 24 deletions(-)

Works fine with apx4devkit.

Tested-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>

Best Regards,
Lauri Hintsala
