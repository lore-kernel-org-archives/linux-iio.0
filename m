Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752553AbdLJScb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Dec 2017 13:32:31 -0500
Date: Sun, 10 Dec 2017 18:32:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Andrew F. Davis" <afd@ti.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: mcp4725: Remove unneeded conversions to bool
Message-ID: <20171210183227.0ea17cef@archlinux>
In-Reply-To: <20171205191201.21572-1-afd@ti.com>
References: <20171205191201.21572-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 5 Dec 2017 13:12:01 -0600
"Andrew F. Davis" <afd@ti.com> wrote:

> Found with scripts/coccinelle/misc/boolconv.cocci.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/mcp4725.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index afa856d10c26..8b5aad4c32d9 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -476,7 +476,7 @@ static int mcp4725_probe(struct i2c_client *client,
>  		goto err_disable_vref_reg;
>  	}
>  	pd = (inbuf[0] >> 1) & 0x3;
> -	data->powerdown = pd > 0 ? true : false;
> +	data->powerdown = pd > 0;
>  	data->powerdown_mode = pd ? pd - 1 : 2; /* largest resistor to gnd */
>  	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
>  	if (data->id == MCP4726)

