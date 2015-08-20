Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:33897 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbbHTUJ0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2015 16:09:26 -0400
Date: Thu, 20 Aug 2015 15:09:17 -0500
From: Michael Welling <mwelling@ieee.org>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Andrea Galbusera <gizero@gmail.com>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Manfred Schlaegl <manfred.schlaegl@gmx.at>,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@rosetechnology.dk>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH 13/18] iio: adc: mcp320x: Set struct spi_driver
 .of_match_table
Message-ID: <20150820200912.GA2866@deathstar>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
 <1440054451-1223-14-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440054451-1223-14-git-send-email-javier@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 20, 2015 at 09:07:26AM +0200, Javier Martinez Canillas wrote:
> The driver has an OF id table but the .of_match_table is not set so
> the SPI core can't do an OF style match and the table was unused.
> 

Is an OF style match necessary?

I have been using devicetree and it matches based on the .id_table.

Couldn't we just remove the mcp320x_dt_ids table instead?

> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  drivers/iio/adc/mcp320x.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index b19e4f9d16e0..41a21e986c1a 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -404,6 +404,7 @@ MODULE_DEVICE_TABLE(spi, mcp320x_id);
>  static struct spi_driver mcp320x_driver = {
>  	.driver = {
>  		.name = "mcp320x",
> +		.of_match_table = of_match_ptr(mcp320x_dt_ids),
>  		.owner = THIS_MODULE,
>  	},
>  	.probe = mcp320x_probe,
> -- 
> 2.4.3
> 
