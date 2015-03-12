Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54296 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbbCNOAn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Mar 2015 10:00:43 -0400
Message-ID: <55016764.4020003@kernel.org>
Date: Thu, 12 Mar 2015 10:16:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?U8O4cmVuIEFuZGVyc2Vu?= <san@rosetechnology.dk>
CC: linux-iio@vger.kernel.org
Subject: Re: [patch 1/2] iio: adc: Kconfig mcp320x change description Add
 more ADCs
References: <1426021927.5476.36.camel@sanws1.rosetechnology.dk>
In-Reply-To: <1426021927.5476.36.camel@sanws1.rosetechnology.dk>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/03/15 21:12, Søren Andersen wrote:
> I once submitted patches for adding support for more mcp ADCs
> But it seams that not all the patches is in the new kernel, so I try to resubmit
I think this came about because as you refined individual patches you
sent only those patches.  Normal convention is to send a new
copy of all of a series with the changed patches included.
That way all the patches are grouped together.

Anyhow, applied with this description removed.  It isn't
relevant information for the git history so should have
been below the ---

Applied to the togreg branch of iio.git, initially to be
pushed out as testing when I'm not on a train with no internet
access.

Jonathan
> 
> Signed-off-by: Soeren Andersen <san at rosetechnology.dk>
> ---
>  drivers/iio/adc/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 202daf8..9eaa8d1 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -186,10 +186,11 @@ config MAX1363
>  	  data via the iio dev interface.
>  
>  config MCP320X
> -	tristate "Microchip Technology MCP3204/08"
> +	tristate "Microchip Technology MCP3x01/02/04/08"
>  	depends on SPI
>  	help
> -	  Say yes here to build support for Microchip Technology's MCP3204 or
> +	  Say yes here to build support for Microchip Technology's
> +	  MCP3001, MCP3002, MCP3004, MCP3008, MCP3201, MCP3202, MCP3204 or
>  	  MCP3208 analog to digital converter.
>  
>  	  This driver can also be built as a module. If so, the module will be
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

