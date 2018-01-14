Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751060AbeANLDY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jan 2018 06:03:24 -0500
Date: Sun, 14 Jan 2018 11:03:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        raltherr@google.com, joel@jms.id.au, arvind.yadav.cs@gmail.com,
        mykolak@mellanox.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: aspeed: Fix error handling path
Message-ID: <20180114110319.3bffcb4d@archlinux>
In-Reply-To: <20180108064736.15991-1-christophe.jaillet@wanadoo.fr>
References: <20180108064736.15991-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  8 Jan 2018 07:47:36 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> The labels and branching order of the error path of 'aspeed_adc_probe()'
> are broken.
> Re-order the labels and goto statements.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to the fixes-togreg-post-rc1 branch of iio.git.

The patch doesn't apply that far back so I'm going to assume
you are right and that it was a merge conflict that went wrong.

Anyhow, will go in sometime after rc1.

Thanks,

Jonathan

> ---
> Not sure where it comes from.
> Merge conflict incorrectly fixed?
> ---
>  drivers/iio/adc/aspeed_adc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 327a49ba1991..9515ca165dfd 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -243,7 +243,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  					 ASPEED_ADC_INIT_POLLING_TIME,
>  					 ASPEED_ADC_INIT_TIMEOUT);
>  		if (ret)
> -			goto scaler_error;
> +			goto poll_timeout_error;
>  	}
>  
>  	/* Start all channels in normal mode. */
> @@ -274,9 +274,10 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	writel(ASPEED_OPERATION_MODE_POWER_DOWN,
>  		data->base + ASPEED_REG_ENGINE_CONTROL);
>  	clk_disable_unprepare(data->clk_scaler->clk);
> -reset_error:
> -	reset_control_assert(data->rst);
>  clk_enable_error:
> +poll_timeout_error:
> +	reset_control_assert(data->rst);
> +reset_error:
>  	clk_hw_unregister_divider(data->clk_scaler);
>  scaler_error:
>  	clk_hw_unregister_divider(data->clk_prescaler);

