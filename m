Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:38892 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbeIWC3o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Sep 2018 22:29:44 -0400
Date: Sat, 22 Sep 2018 16:34:49 -0400
From: r yang <decatf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: bh1750: Add device tree support
Message-ID: <20180922203449.GA20818@r>
References: <20180922195922.24791-1-decatf@gmail.com>
 <20180922195922.24791-2-decatf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180922195922.24791-2-decatf@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Sep 22, 2018 at 03:59:22PM -0400, ryang wrote:
> Add device tree support for ROHM BH1750 series ambient light sensors.
> 
> Signed-off-by: ryang <decatf@gmail.com>
> ---
> Changes in v2:
>      - Export module device table
> 
>  drivers/iio/light/bh1750.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> index c3a481452b67..ffe2e6d9c2e4 100644
> --- a/drivers/iio/light/bh1750.c
> +++ b/drivers/iio/light/bh1750.c
> @@ -307,9 +307,20 @@ static const struct i2c_device_id bh1750_id[] = {
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
> +MODULE_DEVICE_TABLE(of, bh1750_of_match);
> +
>  static struct i2c_driver bh1750_driver = {
>  	.driver = {
>  		.name = "bh1750",
> +		.of_match_table = of_match_ptr(bh1750_of_match),

Jonathan,

Don't take this patch. I realized that of_match_ptr is NULL when _not_
using CONFIG_OF. So that macro shouldn't be used. Apologies for the bit
of mess. I'll send a V3 shortly.

>  		.pm = &bh1750_pm_ops,
>  	},
>  	.probe = bh1750_probe,
> -- 
> 2.17.1
> 
