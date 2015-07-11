Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48842 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbbGKRct (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jul 2015 13:32:49 -0400
Message-ID: <55A1533A.2080507@kernel.org>
Date: Sat, 11 Jul 2015 18:32:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Heiko Stuebner <heiko@sntech.de>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] iio: adc: rockchip_saradc: add missing MODULE_*
 data
References: <8215730.uluDfnE1h7@diego>
In-Reply-To: <8215730.uluDfnE1h7@diego>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/07/15 15:17, Heiko Stuebner wrote:
> The module-data is currently missing. This includes the license-information
> which makes the driver taint the kernel and miss symbols when compiled as
> module.
> 
> Fixes: 44d6f2ef94f9 ("iio: adc: add driver for Rockchip saradc")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Sorry Heiko,

Not entirely sure why I haven't picked this up before.

Anyhow, now applied to the fixes-for-4.2 branch of iio.git
and marked for stable.  I need to catch up with a bit of a
backlog, but should get a pull request out to Greg sometime
early next week.

Jonathan
> ---
>  drivers/iio/adc/rockchip_saradc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 8d4e019..9c311c1 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -349,3 +349,7 @@ static struct platform_driver rockchip_saradc_driver = {
>  };
>  
>  module_platform_driver(rockchip_saradc_driver);
> +
> +MODULE_AUTHOR("Heiko Stuebner <heiko@sntech.de>");
> +MODULE_DESCRIPTION("Rockchip SARADC driver");
> +MODULE_LICENSE("GPL v2");
> 

