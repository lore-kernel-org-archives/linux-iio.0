Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37298 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbbBYUnv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Feb 2015 15:43:51 -0500
Message-ID: <54EDB82E.5050406@kernel.org>
Date: Wed, 25 Feb 2015 11:55:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: Re: [PATCH 2/2] iio: jsa1212: Constify struct regmap_config
References: <1424770909-7360-1-git-send-email-k.kozlowski@samsung.com> <1424770909-7360-2-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1424770909-7360-2-git-send-email-k.kozlowski@samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/02/15 09:41, Krzysztof Kozlowski wrote:
> The regmap_config struct may be const because it is not modified by the
> driver and regmap_init() accepts pointer to const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Applied to the togreg branch of iio.git.  I'm having another of my periodic
days in a clean room (with a very dirty laptop), so will be a day or two before
I'm back home and can push out as testing for the autobuilders to play.

On the plus side, the machine I'm working on isn't running so lots of time
for patch review...

Jonathan
> ---
>  drivers/iio/light/jsa1212.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
> index 29de7e7d9562..3a3af89beaf9 100644
> --- a/drivers/iio/light/jsa1212.c
> +++ b/drivers/iio/light/jsa1212.c
> @@ -308,7 +308,7 @@ static bool jsa1212_is_volatile_reg(struct device *dev, unsigned int reg)
>  	}
>  }
>  
> -static struct regmap_config jsa1212_regmap_config = {
> +static const struct regmap_config jsa1212_regmap_config = {
>  	.name =  JSA1212_REGMAP_NAME,
>  	.reg_bits = 8,
>  	.val_bits = 8,
> 

