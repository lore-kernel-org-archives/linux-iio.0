Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40494 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbcAWQeW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Jan 2016 11:34:22 -0500
Subject: Re: [PATCH] iio: adc: axp288: remove redundant duplicate const on
 axp288_adc_channels
To: Colin King <colin.king@canonical.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Krzysztof Kozlowski <k.kozlowski.k@gmail.com>,
	linux-iio@vger.kernel.org
References: <1453484962-25247-1-git-send-email-colin.king@canonical.com>
Cc: linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56A3AB8B.5050904@kernel.org>
Date: Sat, 23 Jan 2016 16:34:19 +0000
MIME-Version: 1.0
In-Reply-To: <1453484962-25247-1-git-send-email-colin.king@canonical.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/01/16 17:49, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> duplicate const can be removed, it is redundant. Found by static
> analysis using smatch.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Applied, thanks,

Jonathan
> ---
>  drivers/iio/adc/axp288_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
> index 0c904ed..7fd2494 100644
> --- a/drivers/iio/adc/axp288_adc.c
> +++ b/drivers/iio/adc/axp288_adc.c
> @@ -46,7 +46,7 @@ struct axp288_adc_info {
>  	struct regmap *regmap;
>  };
>  
> -static const struct iio_chan_spec const axp288_adc_channels[] = {
> +static const struct iio_chan_spec axp288_adc_channels[] = {
>  	{
>  		.indexed = 1,
>  		.type = IIO_TEMP,
> 

