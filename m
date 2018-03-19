Return-Path: <SRS0=B+Oq=GJ=infradead.org=rdunlap@kernel.org>
Subject: Re: [PATCH 1/3] iio: rename the multiplexer category to wrapper
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20180319170246.26830-1-peda@axentia.se>
 <20180319170246.26830-2-peda@axentia.se>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6b97bd50-b2bb-2695-4efb-16bc70fd638b@infradead.org>
Date: Mon, 19 Mar 2018 11:36:32 -0700
MIME-Version: 1.0
In-Reply-To: <20180319170246.26830-2-peda@axentia.se>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 03/19/2018 10:02 AM, Peter Rosin wrote:
> Paves the way for other wrappers.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---

> diff --git a/drivers/iio/multiplexer/Kconfig b/drivers/iio/wrapper/Kconfig
> similarity index 88%
> rename from drivers/iio/multiplexer/Kconfig
> rename to drivers/iio/wrapper/Kconfig
> index 735a7b0e6fd8..f27de347c9b3 100644
> --- a/drivers/iio/multiplexer/Kconfig
> +++ b/drivers/iio/wrapper/Kconfig
> @@ -1,9 +1,9 @@
>  #
> -# Multiplexer drivers
> +# Wrapper drivers
>  #
>  # When adding new entries keep the list in alphabetical order
>  
> -menu "Multiplexers"
> +menu "Wrapers"

         Wrappers

>  
>  config IIO_MUX
>  	tristate "IIO multiplexer driver"


-- 
~Randy
