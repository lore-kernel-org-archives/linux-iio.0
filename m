Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53776 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298Ab3JAJ6Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 05:58:25 -0400
Message-ID: <524AAAEC.8020006@kernel.org>
Date: Tue, 01 Oct 2013 11:58:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Juergen Beisert <jbe@pengutronix.de>, linux-iio@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
	marex@denx.de, fabio.estevam@freescale.com, jic23@cam.ac.uk,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 2/9] Staging/iio/adc/touchscreen/MXS: distinguish i.MX23's
 and i.MX28's LRADC
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <1379946998-23041-3-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1379946998-23041-3-git-send-email-jbe@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/23/13 15:36, Juergen Beisert wrote:
> The LRADC units in i.MX23 and i.MX28 differ and we need to distinguish both
> SoC variants in order to make the touchscreen work on i.MX23
> 
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-input@vger.kernel.org
> CC: devel@driverdev.osuosl.org
> CC: Marek Vasut <marex@denx.de>
> CC: Fabio Estevam <fabio.estevam@freescale.com>
> CC: Jonathan Cameron <jic23@cam.ac.uk>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 00b61ac..3abc91f 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -177,6 +177,8 @@ struct mxs_lradc {
>  
>  	struct input_dev	*ts_input;
>  	struct work_struct	ts_work;
> +
> +	enum mxs_lradc_id	soc;
>  };
>  
>  #define	LRADC_CTRL0				0x00
> @@ -923,6 +925,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>  	}
>  
>  	lradc = iio_priv(iio);
> +	lradc->soc = (enum mxs_lradc_id)of_id->data;
>  
>  	/* Grab the memory area */
>  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 
