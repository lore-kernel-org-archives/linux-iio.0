Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:39555 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755373Ab3FDQuq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2013 12:50:46 -0400
Date: Tue, 4 Jun 2013 09:50:35 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>, Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 16/19] mfd / input: ti_am335x_tsc: rename device from tsc
 to TI-tsc
Message-ID: <20130604165035.GE26400@core.coreip.homeip.net>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-17-git-send-email-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369681926-22185-17-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, May 27, 2013 at 09:12:03PM +0200, Sebastian Andrzej Siewior wrote:
> tsc is a very generic name. This patch adds a TI prefix to make it a
> little less generic.
> While here add an alias so the driver is loaded on demand.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c |    3 ++-
>  drivers/mfd/ti_am335x_tscadc.c            |    2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index 96accaa..2921163 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -543,11 +543,12 @@ static struct platform_driver ti_tsc_driver = {
>  	.probe	= titsc_probe,
>  	.remove	= titsc_remove,
>  	.driver	= {
> -		.name   = "tsc",
> +		.name   = "TI-tsc",

Still quite generic... Why not call it "TI-am335x-tsc"?

Thanks.

-- 
Dmitry
