Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46852 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbbEDQRX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2015 12:17:23 -0400
Message-ID: <55479B8E.1070801@kernel.org>
Date: Mon, 04 May 2015 17:17:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
CC: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 01/10] iio: st_sensors: print error when failing to get
 IRQ
References: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/04/15 14:15, Linus Walleij wrote:
> Print a proper error message if we're missing the trigger
> IRQ.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git which will get pushed out
as testing sometime in the next few days...
> ---
>  drivers/iio/common/st_sensors/st_sensors_trigger.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 8d8ca6f1e16a..3e907040c2c7 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -37,8 +37,10 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>  			IRQF_TRIGGER_RISING,
>  			sdata->trig->name,
>  			sdata->trig);
> -	if (err)
> +	if (err) {
> +		dev_err(&indio_dev->dev, "failed to request trigger IRQ.\n");
>  		goto request_irq_error;
> +	}
>  
>  	iio_trigger_set_drvdata(sdata->trig, indio_dev);
>  	sdata->trig->ops = trigger_ops;
> 

