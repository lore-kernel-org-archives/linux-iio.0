Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbeIPPHq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Sep 2018 11:07:46 -0400
Date: Sun, 16 Sep 2018 10:45:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: ryang <decatf@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: bh1750: Add device tree support
Message-ID: <20180916104526.2c386591@archlinux>
In-Reply-To: <387c145949692c0318f90d98426be95c82ea2e58.1537033044.git.decatf@gmail.com>
References: <c414a26cdc176d9982f3c609fa39cf245ac939be.1537033044.git.decatf@gmail.com>
        <387c145949692c0318f90d98426be95c82ea2e58.1537033044.git.decatf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 15 Sep 2018 13:42:14 -0400
ryang <decatf@gmail.com> wrote:

> Add device tree support for ROHM BH1750 series ambient light sensors.
> 
> Signed-off-by: ryang <decatf@gmail.com>
Just to check, how is it picking up on the enum value which is provided
in the i2c_device_id entries?

i.e. What is setting id->driver_data in the probe?
There may be something in the i2c core that I'm missing that will do the
association but I don't remember anything trying to do this.

Jonathan

> ---
>  drivers/iio/light/bh1750.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> index a814828e69f5..50b599abb383 100644
> --- a/drivers/iio/light/bh1750.c
> +++ b/drivers/iio/light/bh1750.c
> @@ -315,9 +315,19 @@ static const struct i2c_device_id bh1750_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, bh1750_id);
>  
> +static const struct of_device_id bh1750_of_match[] = {
> +	{ .compatible = "rohm,bh1710", },
> +	{ .compatible = "rohm,bh1715", },
> +	{ .compatible = "rohm,bh1721", },
> +	{ .compatible = "rohm,bh1750", },
> +	{ .compatible = "rohm,bh1751", },
> +	{ }
> +};
> +
>  static struct i2c_driver bh1750_driver = {
>  	.driver = {
>  		.name = "bh1750",
> +		.of_match_table = of_match_ptr(bh1750_of_match),
>  		.pm = BH1750_PM_OPS,
>  	},
>  	.probe = bh1750_probe,
