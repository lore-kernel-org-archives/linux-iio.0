Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43893 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbbFUN2h (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:28:37 -0400
Message-ID: <5586BC04.8010301@kernel.org>
Date: Sun, 21 Jun 2015 14:28:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH v2 6/7] iio:light:cm3323: make use of GENMASK
References: <cover.1434578207.git.knaack.h@gmx.de> <4c312fabbb090163d1b071e489441e3d02a842dd.1434578207.git.knaack.h@gmx.de>
In-Reply-To: <4c312fabbb090163d1b071e489441e3d02a842dd.1434578207.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/06/15 23:32, Hartmut Knaack wrote:
> Use GENMASK to define the integration time bitmask.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied
> ---
>  drivers/iio/light/cm3323.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
> index 2c49ec2..1fc9f78 100644
> --- a/drivers/iio/light/cm3323.c
> +++ b/drivers/iio/light/cm3323.c
> @@ -29,7 +29,7 @@
>  
>  #define CM3323_CONF_SD_BIT	BIT(0) /* sensor disable */
>  #define CM3323_CONF_AF_BIT	BIT(1) /* auto/manual force mode */
> -#define CM3323_CONF_IT_MASK	(BIT(4) | BIT(5) | BIT(6))
> +#define CM3323_CONF_IT_MASK	GENMASK(6, 4)
>  #define CM3323_CONF_IT_SHIFT	4
>  
>  #define CM3323_INT_TIME_AVAILABLE "0.04 0.08 0.16 0.32 0.64 1.28"
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
