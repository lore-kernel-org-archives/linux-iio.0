Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752759AbeAFMXL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jan 2018 07:23:11 -0500
Date: Sat, 6 Jan 2018 12:23:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] iio: common: ssp_sensors: account for const type
 of of_device_id.data
Message-ID: <20180106122306.44085d25@archlinux>
In-Reply-To: <1514899688-27844-12-git-send-email-Julia.Lawall@lip6.fr>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
        <1514899688-27844-12-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue,  2 Jan 2018 14:28:07 +0100
Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> This driver creates a number of const structures that it stores in the
> data field of an of_device_id array.
> 
> Add const to the declaration of the location that receives a value
> from the data field to ensure that the compiler will continue to check
> that the value is not modified and remove the const-dropping cast on
> the access to the data field.
> 
> Done using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Thanks. Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Jonathan

> 
> ---
>  drivers/iio/common/ssp_sensors/ssp.h     |    2 +-
>  drivers/iio/common/ssp_sensors/ssp_dev.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -u -p a/drivers/iio/common/ssp_sensors/ssp.h b/drivers/iio/common/ssp_sensors/ssp.h
> --- a/drivers/iio/common/ssp_sensors/ssp.h
> +++ b/drivers/iio/common/ssp_sensors/ssp.h
> @@ -188,7 +188,7 @@ struct ssp_sensorhub_info {
>   */
>  struct ssp_data {
>  	struct spi_device *spi;
> -	struct ssp_sensorhub_info *sensorhub_info;
> +	const struct ssp_sensorhub_info *sensorhub_info;
>  	struct timer_list wdt_timer;
>  	struct work_struct work_wdt;
>  	struct delayed_work work_refresh;
> diff -u -p a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> @@ -486,7 +486,7 @@ static struct ssp_data *ssp_parse_dt(str
>  	if (!match)
>  		goto err_mcu_reset_gpio;
>  
> -	data->sensorhub_info = (struct ssp_sensorhub_info *)match->data;
> +	data->sensorhub_info = match->data;
>  
>  	dev_set_drvdata(dev, data);
>  
> 

