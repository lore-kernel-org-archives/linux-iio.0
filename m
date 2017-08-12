Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750844AbdHLMDN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Aug 2017 08:03:13 -0400
Date: Sat, 12 Aug 2017 13:02:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iio: srf08: change text in Kconfig
Message-ID: <20170812130257.5bcf7b86@archlinux>
In-Reply-To: <20170802232634.GA15420@arbeit>
References: <20170802232634.GA15420@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 3 Aug 2017 01:26:34 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Changed text in menu entry and help text to reflect recent changes
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Please merge this back into the relevant patches.

Yes it will generate more churn, but it will also be correct any stage
in the series being applied which is what we are looking for.

Jonathan
> ---
>  drivers/iio/proximity/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index 5b81a8c9d438..7a06ef4ced39 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -57,14 +57,14 @@ config SX9500
>  	  module will be called sx9500.
>  
>  config SRF08
> -	tristate "Devantech SRF08 ultrasonic ranger sensor"
> +	tristate "Devantech SRF02/SRF08/SRF10 ultrasonic ranger sensor"
>  	depends on I2C
>  	help
> -	  Say Y here to build a driver for Devantech SRF08 ultrasonic
> -	  ranger sensor. This driver can be used to measure the distance
> -	  of objects.
> +	  Say Y here to build a driver for Devantech SRF02/SRF08/SRF10
> +	  ultrasonic ranger sensor with I2C interfaces. This driver can be
> +	  used to measure the distance of objects.
>  
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called srf08.
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called srf08.
>  
>  endmenu

