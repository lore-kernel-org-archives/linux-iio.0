Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58864 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbbGELTS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 07:19:18 -0400
Message-ID: <559912B5.9070709@kernel.org>
Date: Sun, 05 Jul 2015 12:19:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: Re: [PATCH 1/5] iio:light:stk3310: Fix REGMAP_I2C dependency
References: <cover.1436024257.git.knaack.h@gmx.de> <04af58f40b1fceec4430f6dbca26b3308655d54f.1436024257.git.knaack.h@gmx.de>
In-Reply-To: <04af58f40b1fceec4430f6dbca26b3308655d54f.1436024257.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/07/15 16:56, Hartmut Knaack wrote:
> The stk3310 driver makes use of regmap_i2c, so this dependency needs to be
> reflected in Kconfig.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the fixes-for-4.2 branch.  I wonder why the autobuilders didn't
pick up on this.

J
> ---
>  drivers/iio/light/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 730fa80..9c8b423 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -212,6 +212,7 @@ config LTR501
>  config STK3310
>  	tristate "STK3310 ALS and proximity sensor"
>  	depends on I2C
> +	select REGMAP_I2C
>  	help
>  	 Say yes here to get support for the Sensortek STK3310 ambient light
>  	 and proximity sensor. The STK3311 model is also supported by this
> 

