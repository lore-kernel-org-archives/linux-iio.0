Return-Path: <knaack.h@gmx.de>
Message-ID: <5492012C.3070206@gmx.de>
Date: Wed, 17 Dec 2014 23:18:20 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Karol Wrona <k.wrona@samsung.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Karol Wrona <wrona.vy@gmail.com>
Subject: Re: [PATCH v3 4/5] iio: common: ssp_sensors: Add sensorhub
 accelerometer sensor
References: <1417809290-9662-1-git-send-email-k.wrona@samsung.com> <1417809290-9662-5-git-send-email-k.wrona@samsung.com>
In-Reply-To: <1417809290-9662-5-git-send-email-k.wrona@samsung.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Karol Wrona schrieb am 05.12.2014 um 20:54:
> This patch adds accelerometer iio driver which uses sensorhub as data
> provider.
> 
Also looking very good now. One more whitespace issue remaining.
> Change-Id: I4686741b7401ec5cbf4b5d0f2a5cc146fbe24d53
> Signed-off-by: Karol Wrona <k.wrona@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/iio/accel/Makefile           |    1 +
>  drivers/iio/accel/ssp_accel_sensor.c |  203 ++++++++++++++++++++++++++++++++++
>  2 files changed, 204 insertions(+)
>  create mode 100644 drivers/iio/accel/ssp_accel_sensor.c
> 

> +static struct platform_driver ssp_accel_driver = {
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name = SSP_ACCEL_NAME,
> +		.of_match_table = ssp_accel_id_table,
> +	},
> +	.probe = ssp_accel_probe,
> +	.remove =  ssp_accel_remove,
Double whitespace.
> +};
> +
> +module_platform_driver(ssp_accel_driver);
> +
> +MODULE_AUTHOR("Karol Wrona <k.wrona@samsung.com>");
> +MODULE_DESCRIPTION("Samsung sensorhub accelerometers driver");
> +MODULE_LICENSE("GPL");
> 
