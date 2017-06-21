Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbdFUT4T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Jun 2017 15:56:19 -0400
Date: Wed, 21 Jun 2017 20:56:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: accel: st_accel_spi: rename of_device_id table
 in st_accel_of_match
Message-ID: <20170621205614.40e572a3@kernel.org>
In-Reply-To: <20170620195212.23213-3-lorenzo.bianconi@st.com>
References: <20170620195212.23213-1-lorenzo.bianconi@st.com>
        <20170620195212.23213-3-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 20 Jun 2017 21:52:09 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> In order to add proper device tree support give a more general name
> to of_device_id table
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/st_accel_spi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> index 1a867f5563a4..d13742edee0e 100644
> --- a/drivers/iio/accel/st_accel_spi.c
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -62,17 +62,17 @@ static const struct spi_device_id st_accel_id_table[] = {
>  MODULE_DEVICE_TABLE(spi, st_accel_id_table);
>  
>  #ifdef CONFIG_OF
> -static const struct of_device_id lis302dl_spi_dt_ids[] = {
> +static const struct of_device_id st_accel_of_match[] = {
>  	{ .compatible = "st,lis302dl-spi" },
>  	{}
>  };
> -MODULE_DEVICE_TABLE(of, lis302dl_spi_dt_ids);
> +MODULE_DEVICE_TABLE(of, st_accel_of_match);
>  #endif
>  
>  static struct spi_driver st_accel_driver = {
>  	.driver = {
>  		.name = "st-accel-spi",
> -		.of_match_table = of_match_ptr(lis302dl_spi_dt_ids),
> +		.of_match_table = of_match_ptr(st_accel_of_match),
>  	},
>  	.probe = st_accel_spi_probe,
>  	.remove = st_accel_spi_remove,

