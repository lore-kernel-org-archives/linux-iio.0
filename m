Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH] stagging:iio:ad9834: add devicetree property support
To: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>,
 linux-iio@vger.kernel.org
References: <20160911105229.25791-1-gwenhael.goavec-merou@trabucayre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Paul Cercueil <paul.cercueil@analog.com>, devel@driverdev.osuosl.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2bd4af3a-1ea3-3dde-92c8-7aac1d0205f1@metafoo.de>
Date: Mon, 12 Sep 2016 14:02:07 +0200
MIME-Version: 1.0
In-Reply-To: <20160911105229.25791-1-gwenhael.goavec-merou@trabucayre.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

Hi,

Thanks for the patch.

On 09/11/2016 12:52 PM, Gwenhael Goavec-Merou wrote:
> +static struct ad9834_platform_data *ad9834_parse_dt(struct spi_device *spi)
> +{
> +	struct ad9834_platform_data *pdata;
> +	struct device_node *np = spi->dev.of_node;
> +
> +	pdata = devm_kzalloc(&spi->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (of_property_read_u32(np, "mclk", &pdata->mclk))
> +		return ERR_PTR(-ENODEV);

The input clock should be using the standard clock bindings.

> +	if (of_property_read_u32(np, "freq0", &pdata->freq0))
> +		return ERR_PTR(-ENODEV);
> +	if (of_property_read_u32(np, "freq1", &pdata->freq1))
> +		return ERR_PTR(-ENODEV);
> +	if (of_property_read_u16(np, "phase0", &pdata->phase0))
> +		return ERR_PTR(-ENODEV);
> +	if (of_property_read_u16(np, "phase1", &pdata->phase1))
> +		return ERR_PTR(-ENODEV);
> +	pdata->en_div2 = of_property_read_bool(np, "en_div2");
> +	pdata->en_signbit_msb_out = of_property_read_bool(np,
> +					"en_signbit_msb_out");

The other attributes seem to be more runtime configuration data, rather than
hardware description. Maybe just choose a fixed default.

- Lars
