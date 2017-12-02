Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751745AbdLBMWp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Dec 2017 07:22:45 -0500
Date: Sat, 2 Dec 2017 12:22:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org, samuel@sortiz.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: trigger: Fix platform_get_irq's error checking
Message-ID: <20171202122241.54c9d376@archlinux>
In-Reply-To: <1512056616-21065-2-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512056616-21065-1-git-send-email-arvind.yadav.cs@gmail.com>
        <1512056616-21065-2-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 30 Nov 2017 21:13:34 +0530
Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:

> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Applied to the togreg branch of iio.git.  This is probably just
a theoretical problem as obviously the blackfin trigger only runs
on blackfin boards and I assume they only return 0.

Anyhow, nothing wrong with tidying it up as might possible get
cut and paste to somewhere it does matter in future!

Jonathan

> ---
>  drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> index d80dcf8..f389f5c 100644
> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> +++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> @@ -187,9 +187,9 @@ static int iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	st->irq = platform_get_irq(pdev, 0);
> -	if (!st->irq) {
> +	if (st->irq < 0) {
>  		dev_err(&pdev->dev, "No IRQs specified");
> -		return -ENODEV;
> +		return st->irq;
>  	}
>  
>  	ret = iio_bfin_tmr_get_number(st->irq);

