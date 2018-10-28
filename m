Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:46750 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeJ2ARZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Oct 2018 20:17:25 -0400
Date: Sun, 28 Oct 2018 15:32:27 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH V3 1/2] iio:dac:ti-dac7311 Add driver for Texas
 Instrument DAC7311
Message-ID: <20181028153227.768d3966@archlinux>
In-Reply-To: <20181022210340.1136-1-charles-antoine.couret@essensium.com>
References: <20181022210340.1136-1-charles-antoine.couret@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 22 Oct 2018 23:03:39 +0200
Charles-Antoine Couret <charles-antoine.couret@essensium.com> wrote:

> It is a driver for Texas Instruments 8/10/12-bit 1-channel
> compatible with DAC6311 and DAC5311 chips.
> 
> Datasheet of this chip:
> http://www.ti.com/lit/ds/symlink/dac7311.pdf
> 
> Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>

Only the same point around not defining out the of table when
CONFIG_OF isn't set (as it's used by ACPI sometimes).

I would just have fixed that up, but there seems to be just enough stuff that
needs changing in the binding patch that I'd rather we went to a v4 and
gave Rob plenty of time to give the binding one last look.

...

> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id ti_dac_of_id[] = {
> +	{ .compatible = "ti,dac5311" },
> +	{ .compatible = "ti,dac6311" },
> +	{ .compatible = "ti,dac7311" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ti_dac_of_id);
> +#endif
> +
> +static const struct spi_device_id ti_dac_spi_id[] = {
> +	{ "dac5311", ID_DAC5311  },
> +	{ "dac6311", ID_DAC6311 },
> +	{ "dac7311", ID_DAC7311 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ti_dac_spi_id);
> +
> +static struct spi_driver ti_dac_driver = {
> +	.driver = {
> +		.name		= "ti-dac7311",
> +		.of_match_table	= of_match_ptr(ti_dac_of_id),

As with previous driver, please don't make of_match_table presence
dependent on CONFIG_OF as it's used by ACPI as well (odd but true!)

> +	},
> +	.probe	  = ti_dac_probe,
> +	.remove   = ti_dac_remove,
> +	.id_table = ti_dac_spi_id,
> +};
> +module_spi_driver(ti_dac_driver);
> +
> +MODULE_AUTHOR("Charles-Antoine Couret <charles-antoine.couret@essensium.com>");
> +MODULE_DESCRIPTION("Texas Instruments 8/10/12-bit 1-channel DAC driver");
> +MODULE_LICENSE("GPL v2");
