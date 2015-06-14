Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44295 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbbFNOIK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jun 2015 10:08:10 -0400
Message-ID: <557D8AC8.5070208@kernel.org>
Date: Sun, 14 Jun 2015 15:08:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH 1/2] iio: light: hid-sensor-prox: Fit assignment in one
 line
References: <1431111241-7472-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1431111241-7472-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/05/15 19:54, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> There is no need to do the assignment to indio_dev->num_channels in two
> lines code.
> 
> Put it in one line.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/light/hid-sensor-prox.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index 124a8f8..4ed42df 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -286,8 +286,7 @@ static int hid_prox_probe(struct platform_device *pdev)
>  		goto error_free_dev_mem;
>  	}
>  
> -	indio_dev->num_channels =
> -				ARRAY_SIZE(prox_channels);
> +	indio_dev->num_channels = ARRAY_SIZE(prox_channels);
>  	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->info = &prox_info;
>  	indio_dev->name = name;
> 

