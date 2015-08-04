Return-Path: <pebolle@tiscali.nl>
Message-ID: <1438680636.8734.45.camel@tiscali.nl>
Subject: Re: [PATCH 2/3] iio: temperature: add max6675 thermocouple
 converter driver
From: Paul Bolle <pebolle@tiscali.nl>
To: Matt Porter <mporter@konsulko.com>
Cc: Linux IIO List <linux-iio@vger.kernel.org>, Devicetree List
 <devicetree@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Tue, 04 Aug 2015 11:30:36 +0200
In-Reply-To: <1438635410-3757-3-git-send-email-mporter@konsulko.com>
References: <1438635410-3757-1-git-send-email-mporter@konsulko.com>
	 <1438635410-3757-3-git-send-email-mporter@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On ma, 2015-08-03 at 16:56 -0400, Matt Porter wrote:
> --- /dev/null
> +++ b/drivers/iio/temperature/max6675.c
> +static const struct spi_device_id max6675_spi_ids[] = {
> +	{"max6675", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(spi, max6675_spi_ids);

> +MODULE_ALIAS("spi:max6675");

For the "spi" alias this is "belt and suspenders":
    modinfo ./max6675.ko | grep alias
    alias:          spi:max6675
    alias:          acpi*:MXIM6675:*
    alias:          of:N*T*Cmaxim,max6675*
    alias:          spi:max6675

I'd drop the MODULE_ALIAS().

(Mark Brown made it quite clear I shouldn't nag people about the origin
of the various strings used in these module aliases. So I won't. But if
you'd volunteer to explain me where "max6675" might come from for the
spi alias that would, at least, satisfy my curiosity.)

Thanks,


Paul Bolle
