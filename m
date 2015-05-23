Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50372 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757867AbbEWLcA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 May 2015 07:32:00 -0400
Message-ID: <5560652E.8060800@kernel.org>
Date: Sat, 23 May 2015 12:31:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Axel Lin <axel.lin@ingics.com>
CC: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: twl6030-gpadc: Fix modalias
References: <1432083200.7013.0.camel@ingics.com>
In-Reply-To: <1432083200.7013.0.camel@ingics.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/05/15 01:53, Axel Lin wrote:
> Remove extra space between platform prefix and DRIVER_NAME in MODULE_ALIAS.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/twl6030-gpadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
> index 89d8aa1..df12c57 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -1001,7 +1001,7 @@ static struct platform_driver twl6030_gpadc_driver = {
>  
>  module_platform_driver(twl6030_gpadc_driver);
>  
> -MODULE_ALIAS("platform: " DRIVER_NAME);
> +MODULE_ALIAS("platform:" DRIVER_NAME);
>  MODULE_AUTHOR("Balaji T K <balajitk@ti.com>");
>  MODULE_AUTHOR("Graeme Gregory <gg@slimlogic.co.uk>");
>  MODULE_AUTHOR("Oleksandr Kozaruk <oleksandr.kozaruk@ti.com");
> 

