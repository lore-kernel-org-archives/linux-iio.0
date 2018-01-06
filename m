Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752875AbeAFMhC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jan 2018 07:37:02 -0500
Date: Sat, 6 Jan 2018 12:36:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: venkat.prashanth2498@gmail.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] Drivers:iio:dac: Remove unneeded conversion to bool
Message-ID: <20180106123657.294c1057@archlinux>
In-Reply-To: <1515082747-386-1-git-send-email-venkat.prashanth2498@gmail.com>
References: <1515082747-386-1-git-send-email-venkat.prashanth2498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  4 Jan 2018 21:49:07 +0530
venkat.prashanth2498@gmail.com wrote:

> From: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
> 
> This is a patch to the mcp4725.c file which
> fixes the following coccinelle warning:
> 
> WARNING: conversion to bool not needed here
> 
> Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
> 
Version log belongs below the --- cut line.
It is very useful when we are reviewing code, but not something we want to have
in the git history for ever.

Please send a V3 with that fixed.

Jonathan

> Changes since v1:
> -----------------
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

