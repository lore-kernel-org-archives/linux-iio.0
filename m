Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38194 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbbHVSD4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Aug 2015 14:03:56 -0400
Subject: Re: [PATCH 15/18] iio: adc128s052: Add OF match table
To: Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-kernel@vger.kernel.org
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
 <1440054451-1223-16-git-send-email-javier@osg.samsung.com>
Cc: =?UTF-8?Q?Urs_F=c3=a4ssler?= <urs.fassler@bytesatwork.ch>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55D8B98A.6040504@kernel.org>
Date: Sat, 22 Aug 2015 19:03:54 +0100
MIME-Version: 1.0
In-Reply-To: <1440054451-1223-16-git-send-email-javier@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/08/15 08:07, Javier Martinez Canillas wrote:
> The Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt DT binding
> doc lists "ti,adc128s052" or "ti,adc122s021" as compatible strings but the
> corresponding driver does not have an OF match table. Add the table to the
> driver so the SPI core can do an OF style match.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Applied to the togreg branch of iio.git - pushed out as testing for the 
autobuilders to play with it.

Thanks,

Jonathan
> ---
> 
>  drivers/iio/adc/ti-adc128s052.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 915be6b60097..98c0d2b444bf 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -174,6 +174,13 @@ static int adc128_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> +static const struct of_device_id adc128_of_match[] = {
> +	{ .compatible = "ti,adc128s052", },
> +	{ .compatible = "ti,adc122s021", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, adc128_of_match);
> +
>  static const struct spi_device_id adc128_id[] = {
>  	{ "adc128s052", 0},	/* index into adc128_config */
>  	{ "adc122s021",	1},
> @@ -184,6 +191,7 @@ MODULE_DEVICE_TABLE(spi, adc128_id);
>  static struct spi_driver adc128_driver = {
>  	.driver = {
>  		.name = "adc128s052",
> +		.of_match_table = of_match_ptr(adc128_of_match),
>  		.owner = THIS_MODULE,
>  	},
>  	.probe = adc128_probe,
> 

