Return-Path: <k.wrona@samsung.com>
Message-id: <5591186F.6000505@samsung.com>
Date: Mon, 29 Jun 2015 12:05:35 +0200
From: Karol Wrona <k.wrona@samsung.com>
MIME-version: 1.0
To: Antonio Borneo <borneo.antonio@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: ssp_sensors: Remove redundant spi driver bus
 initialization
References: <1435070714-24174-1-git-send-email-borneo.antonio@gmail.com>
 <1435071148-24453-1-git-send-email-borneo.antonio@gmail.com>
In-reply-to: <1435071148-24453-1-git-send-email-borneo.antonio@gmail.com>
Content-type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 06/23/2015 04:52 PM, Antonio Borneo wrote:
> In ancient times it was necessary to manually initialize the bus
> field of an spi_driver to spi_bus_type. These days this is done in
> spi_register_driver(), so we can drop the manual assignment.
> 
> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
> To: Jonathan Cameron <jic23@kernel.org>
> To: Lars-Peter Clausen <lars@metafoo.de>
> To: Karol Wrona <k.wrona@samsung.com>
> To: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/iio/common/ssp_sensors/ssp_dev.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
> index 9a40097..d338bb5 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> @@ -700,7 +700,6 @@ static struct spi_driver ssp_driver = {
>  	.remove = ssp_remove,
>  	.driver = {
>  		.pm = &ssp_pm_ops,
> -		.bus = &spi_bus_type,
>  		.owner = THIS_MODULE,
>  		.of_match_table = of_match_ptr(ssp_of_match),
>  		.name = "sensorhub"
> 
Acked-by: Karol Wrona <k.wrona@samsung.com>
