Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:60899 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756164AbcISNtJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2016 09:49:09 -0400
Subject: Re: [PATCH v2] stagging:iio:ad9834: add devicetree property support
To: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>,
        linux-iio@vger.kernel.org
References: <20160918085202.14740-1-gwenhael.goavec-merou@trabucayre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Paul Cercueil <paul.cercueil@analog.com>,
        devel@driverdev.osuosl.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <cea43942-494f-9740-db0b-e210dd5da092@metafoo.de>
Date: Mon, 19 Sep 2016 15:49:04 +0200
MIME-Version: 1.0
In-Reply-To: <20160918085202.14740-1-gwenhael.goavec-merou@trabucayre.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/18/2016 10:52 AM, Gwenhael Goavec-Merou wrote:
[...]
> +#if defined(CONFIG_OF)
> +static struct ad9834_platform_data *ad9834_parse_dt(struct spi_device *spi)
> +{
> +	struct ad9834_platform_data *pdata;
> +	struct device_node *np = spi->dev.of_node;
> +
> +	pdata = devm_kzalloc(&spi->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pdata->freq0 = 134000;
> +	of_property_read_u32(np, "freq0", &pdata->freq0);
> +
> +	pdata->freq1 = 134000;
> +	of_property_read_u32(np, "freq1", &pdata->freq1);
> +
> +	pdata->phase0 = 0;
> +	of_property_read_u16(np, "phase0", &pdata->phase0);
> +
> +	pdata->phase1 = 0;
> +	of_property_read_u16(np, "phase1", &pdata->phase1);
> +
> +	pdata->en_div2 = of_property_read_bool(np, "en_div2");
> +	pdata->en_signbit_msb_out = of_property_read_bool(np,
> +					"en_signbit_msb_out");

Sorry, I should have been more clear what I meant in the previous mail.

The devicetree describes the hardware, which components are present and how
they are connected to each other and sometimes system level operating
constraints.

The parameters above in my opinion are application specific configuration
parameters though. At least phase and frequency. I'm not quite sure what
exactly decides how the SIGN_OUT pin should be used, they might be hardware
setup dependent.

But I'm not that familiar with the typical usecase of these types of
devices, so if you disagree please say so. Maybe you can explain your setup
a bit and what you need from the chip and the driver.

> +
> +	return pdata;
> +}
> +#else
> +static struct ad9834_platform_data *ad9834_parse_dt(struct spi_device *spi)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  static int ad9834_probe(struct spi_device *spi)
>  {
>  	struct ad9834_platform_data *pdata = dev_get_platdata(&spi->dev);
>  	struct ad9834_state *st;
>  	struct iio_dev *indio_dev;
>  	struct regulator *reg;
> +	struct clk *clk = NULL;
>  	int ret;
>  
> +	if (!pdata && spi->dev.of_node) {
> +		pdata = ad9834_parse_dt(spi);
> +		if (IS_ERR(pdata))
> +			return PTR_ERR(pdata);
> +	}
> +
>  	if (!pdata) {
>  		dev_dbg(&spi->dev, "no platform data?\n");
>  		return -ENODEV;
>  	}
>  
> +	if (!pdata->mclk) {
> +		clk = devm_clk_get(&spi->dev, NULL);

I'd make the clock name explicit clk_get(..., "mclk");

> +		if (IS_ERR(clk))

Should be 'return PTR_ERR(clk);'. clk_get() will return EPROBE_DEFER if the
clock has been specified but is not yet available, but it will return an
error, if e.g. there is an error in the specification. We should propagate
this error.

> +			return -EPROBE_DEFER;
> +
> +		ret = clk_prepare_enable(clk);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
[...]
