Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45624 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbHBSH7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 14:07:59 -0400
Subject: Re: [PATCH v2 4/8] iio:adc:berlin2-adc: constify iio_chan_spec
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <cover.1438035998.git.knaack.h@gmx.de>
 <9c7a4354629cc61c05ea31ac2678dd659a65f38a.1438035998.git.knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE5C7E.5060401@kernel.org>
Date: Sun, 2 Aug 2015 19:07:58 +0100
MIME-Version: 1.0
In-Reply-To: <9c7a4354629cc61c05ea31ac2678dd659a65f38a.1438035998.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/07/15 23:39, Hartmut Knaack wrote:
> Mark berlin2_adc_channels array as constant.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Applied
> ---
>  drivers/iio/adc/berlin2-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
> index ed31a0a8d78e..745061091bd3 100644
> --- a/drivers/iio/adc/berlin2-adc.c
> +++ b/drivers/iio/adc/berlin2-adc.c
> @@ -86,7 +86,7 @@ struct berlin2_adc_priv {
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>  		}
>  
> -static struct iio_chan_spec berlin2_adc_channels[] = {
> +static const struct iio_chan_spec berlin2_adc_channels[] = {
>  	BERLIN2_ADC_CHANNEL(0, IIO_VOLTAGE),	/* external input */
>  	BERLIN2_ADC_CHANNEL(1, IIO_VOLTAGE),	/* external input */
>  	BERLIN2_ADC_CHANNEL(2, IIO_VOLTAGE),	/* external input */
> 

