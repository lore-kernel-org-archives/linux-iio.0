Return-Path: <SRS0=hZNb=ZC=kroah.com=greg@kernel.org>
Date: Fri, 20 Jan 2017 10:59:52 +0100
From: Greg KH <greg@kroah.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: fix Kconfig warning
Message-ID: <20170120095952.GA9790@kroah.com>
References: <20170120094605.25602-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170120094605.25602-1-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jan 20, 2017 at 10:46:05AM +0100, Linus Walleij wrote:
> commit 762227721fe6225be5b6d233ef681aea5871f5f3
> "iio: accel: st_accel: handle deprecated bindings"
> attempted to be smart and let users use the old I2C
> driver and the new SPI driver, or the old SPI driver and
> the new I2C driver in combination for the LIS3LV02,
> and put the restrictions on the I2C and SPI subdrivers
> not not be combined with the old subdrivers.
> 
> This doesn't work since the IIO ST accel top-level
> component selects the I2C and SPI subdrivers, resulting
> in the following Kconfig noise:
> 
> warning: (IIO_ST_ACCEL_3AXIS) selects IIO_ST_ACCEL_I2C_3AXIS
> which has unmet direct dependencies (IIO && !SENSORS_LIS3_I2C
> && IIO_ST_ACCEL_3AXIS && IIO_ST_SENSORS_I2C)
> warning: (IIO_ST_ACCEL_3AXIS) selects IIO_ST_ACCEL_SPI_3AXIS
> which has unmet direct dependencies (IIO && !SENSORS_LIS3_SPI
> && IIO_ST_ACCEL_3AXIS && IIO_ST_SENSORS_SPI)
> (...)
> 
> This fixes the issue by putting the dependencies directly
> in the top-level component instead, so that it never gets
> to select its unselectable subcomponent.
> 
> Cc: Greg KH <greg@kroah.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Fixes: 762227721fe6 ("iio: accel: st_accel: handle deprecated bindings")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I guess Greg can apply the patch directly to quickly get
> rid of the Kconfig noise, else Jonathan can funnel it as
> a fix.

I'll be glad to take it if I can get an ack from Jonathan.

thanks for the quick response,

greg k-h
