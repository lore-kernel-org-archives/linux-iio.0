Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:34374 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab1JTLyq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2011 07:54:46 -0400
Message-ID: <4EA00C0A.6060404@cam.ac.uk>
Date: Thu, 20 Oct 2011 12:54:50 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] staging:iio:trigger:bfin-timer: Fix compile error
References: <1319110681-29726-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1319110681-29726-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/20/11 12:38, Lars-Peter Clausen wrote:
oops.

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/trigger/iio-trig-bfin-timer.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> index 243f38f..1cbb25d 100644
> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> +++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> @@ -144,7 +144,7 @@ static int iio_bfin_tmr_get_number(int irq)
>  }
>  
>  static const struct iio_trigger_ops iio_bfin_tmr_trigger_ops = {
> -	owner = THIS_MODULE,
> +	.owner = THIS_MODULE,
>  };
>  
>  static int __devinit iio_bfin_tmr_trigger_probe(struct platform_device *pdev)

