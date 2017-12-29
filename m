Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750869AbdL2QWz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Dec 2017 11:22:55 -0500
Date: Fri, 29 Dec 2017 16:22:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@free-electrons.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 10/14] iio: adc: at91-sama5d2_adc: force trigger removal
 on module remove
Message-ID: <20171229162250.7d68a0c8@archlinux>
In-Reply-To: <1513955241-10985-11-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
        <1513955241-10985-11-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 22 Dec 2017 17:07:17 +0200
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> On module remove, if we do not call trigger remove, the trigger
> stays in the subsystem, and on further module insert, we will have
> multiple triggers, and the old one is not usable.
> Have to call the remove function on module remove to solve this.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

This needs more explanation.  I can't see why the managed removal
isn't sufficient.  On removal the dev should have gone away taking
the trigger with it.

If it isn't then it looks like a straight forward bug that needs fixing.

Jonathan

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 4eff835..7b9febc 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1180,6 +1180,9 @@ static int at91_adc_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  
> +	if (st->selected_trig->hw_trig)
> +		devm_iio_trigger_unregister(&indio_dev->dev, st->trig);
> +
>  	iio_device_unregister(indio_dev);
>  
>  	at91_adc_dma_disable(pdev);

