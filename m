Return-Path: <SRS0=DGW9=M4=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH] staging: iio: ad7816: Switch to the gpio descriptor
 interface
To: Nishad Kamdar <nishadkamdar@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 outreachy-kernel@googlegroups.com
References: <20181016144623.GA9890@nishad>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <929c42b8-34e7-60bb-5bd4-31faf53d62c2@metafoo.de>
Date: Tue, 16 Oct 2018 17:10:14 +0200
MIME-Version: 1.0
In-Reply-To: <20181016144623.GA9890@nishad>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 10/16/2018 04:46 PM, Nishad Kamdar wrote:
> Use the gpiod interface for rdwr_pin, convert_pin and busy_pin
> instead of the deprecated old non-descriptor interface.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>

Hi,

Thanks for the patch, this looks good.

One thing about the error messages though.

> +	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
> +	if (IS_ERR(chip->rdwr_pin)) {
> +		ret = PTR_ERR(chip->rdwr_pin);
>  		dev_err(&spi_dev->dev, "Fail to request rdwr gpio PIN %d.\n",
> -			chip->rdwr_pin);
> +			ret);

This previously showed the pin number which has now been replaced with the
error code. The message doesn't make that much sense semantically anymore.
Maybe replace it with something like

	"Failed to request rdwr GPIO: %d\n", ret

>  		return ret;
