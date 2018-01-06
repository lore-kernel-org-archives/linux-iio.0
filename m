Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753628AbeAFPIi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jan 2018 10:08:38 -0500
Date: Sat, 6 Jan 2018 15:08:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: venkat.prashanth2498@gmail.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH V3] Drivers:iio:dac: Remove unneeded conversion to bool
Message-ID: <20180106150833.558ae146@archlinux>
In-Reply-To: <1515250409-3240-1-git-send-email-venkat.prashanth2498@gmail.com>
References: <1515250409-3240-1-git-send-email-venkat.prashanth2498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  6 Jan 2018 20:23:29 +0530
venkat.prashanth2498@gmail.com wrote:

> From: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
> 
> This is a patch to the mcp4725.c file which
> fixes the following coccinelle warning:
> 
> WARNING: conversion to bool not needed here
> 
> Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
Much better.

I'm afraid what I missed previously is that Andrew Davis actually
fixed this back in December.  It won't be visible yet in the
staging tree but is in the iio tree testing branch.

Sorry about that, I didn't realise until I discovered the patch
wouldn't apply.

Jonathan

> ---
> change log v2:-
> Fixed version log issue.
> 
> change log v1:-
> Instead of inadvertent removal of complete statement, only the
> conversion to bool is removed.
> ---
>  drivers/iio/dac/mcp4725.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index afa856d..8b5aad4 100644
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

