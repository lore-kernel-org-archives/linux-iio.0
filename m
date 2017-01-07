Return-Path: <SRS0=JsrJ=YV=poczta.fm=sst@kernel.org>
Date: Sat, 7 Jan 2017 22:58:51 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Matt Weber <matthew.weber@rockwellcollins.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org,
	cristina.moraru09@gmail.com,
	Maury Anderson <maury.anderson@rockwellcollins.com>
Subject: Re: [PATCH] iio: max5481: Add support for Maxim digital
 potentiometers
Message-ID: <20170107215851.GB1845@x220.localdomain>
References: <1481136052-1660-1-git-send-email-matthew.weber@rockwellcollins.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481136052-1660-1-git-send-email-matthew.weber@rockwellcollins.com>
List-ID: <linux-iio@vger.kernel.org>

On Dec 07, 2016 12:40, Matt Weber wrote:
> (...)
> +static int max5481_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct max5481_data *data;
> +	const struct spi_device_id *id = spi_get_device_id(spi);

This id will be null...

> +static const struct spi_device_id max5481_id_table[] = {
> +	{ "MAX5481", max5481 },
> +	{ "MAX5482", max5482 },
> +	{ "MAX5483", max5483 },
> +	{ "MAX5484", max5484 },

...because case size matter here.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, max5481_id_table);
> +
> +#if defined(CONFIG_OF)
> +static const struct of_device_id max5481_match[] = {
> +	{ .compatible = "maxim,max5481", .data = &max5481_cfg[max5481] },
> +	{ .compatible = "maxim,max5482", .data = &max5481_cfg[max5482] },
> +	{ .compatible = "maxim,max5483", .data = &max5481_cfg[max5483] },
> +	{ .compatible = "maxim,max5484", .data = &max5481_cfg[max5484] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max5481_match);
> +#endif
> +
> +#if defined(CONFIG_ACPI)
> +static const struct acpi_device_id max5481_acpi_match[] = {
> +	{ "MAX5481", max5481 },
> +	{ "MAX5482", max5482 },
> +	{ "MAX5483", max5483 },
> +	{ "MAX5484", max5484 },

I guess the same here, but I am not sure at the moment...

-- 
Slawomir Stepien
