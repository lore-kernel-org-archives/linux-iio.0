Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43170 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbdCYQOj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 12:14:39 -0400
Subject: Re: [PATCH] staging: iio: Remove extra Parenthesis.
To: Arushi Singhal <arushisinghal19971997@gmail.com>, lars@metafoo.de
References: <20170324135533.GA5346@arushi-HP-Pavilion-Notebook>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a37507e2-467f-d98c-d348-82d97c9d4b45@kernel.org>
Date: Sat, 25 Mar 2017 16:05:16 +0000
MIME-Version: 1.0
In-Reply-To: <20170324135533.GA5346@arushi-HP-Pavilion-Notebook>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/17 13:55, Arushi Singhal wrote:
> Remove the extra parenthesis remove the checkpatch issue.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7746.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 033a41fd9bee..b4afc12f827f 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -50,10 +50,10 @@
>  #define AD7746_STATUS_RDYCAP		BIT(0)
>  
>  /* Capacitive Channel Setup Register Bit Designations (AD7746_REG_CAP_SETUP) */
> -#define AD7746_CAPSETUP_CAPEN		(BIT(7))
> -#define AD7746_CAPSETUP_CIN2		(BIT(6)) /* AD7746 only */
> -#define AD7746_CAPSETUP_CAPDIFF		(BIT(5))
> -#define AD7746_CAPSETUP_CACHOP		(BIT(0))
> +#define AD7746_CAPSETUP_CAPEN		BIT(7)
> +#define AD7746_CAPSETUP_CIN2		BIT(6) /* AD7746 only */
> +#define AD7746_CAPSETUP_CAPDIFF		BIT(5)
> +#define AD7746_CAPSETUP_CACHOP		BIT(0)
>  
>  /* Voltage/Temperature Setup Register Bit Designations (AD7746_REG_VT_SETUP) */
>  #define AD7746_VTSETUP_VTEN		(1 << 7)
> @@ -61,9 +61,9 @@
>  #define AD7746_VTSETUP_VTMD_EXT_TEMP	(1 << 5)
>  #define AD7746_VTSETUP_VTMD_VDD_MON	(2 << 5)
>  #define AD7746_VTSETUP_VTMD_EXT_VIN	(3 << 5)
> -#define AD7746_VTSETUP_EXTREF		(BIT(4))
> -#define AD7746_VTSETUP_VTSHORT		(BIT(1))
> -#define AD7746_VTSETUP_VTCHOP		(BIT(0))
> +#define AD7746_VTSETUP_EXTREF		BIT(4)
> +#define AD7746_VTSETUP_VTSHORT		BIT(1)
> +#define AD7746_VTSETUP_VTCHOP		BIT(0)
>  
>  /* Excitation Setup Register Bit Designations (AD7746_REG_EXC_SETUP) */
>  #define AD7746_EXCSETUP_CLKCTRL		BIT(7)
> @@ -87,7 +87,7 @@
>  #define AD7746_CONF_MODE_GAIN_CAL	(6 << 0)
>  
>  /* CAPDAC Register Bit Designations (AD7746_REG_CAPDACx) */
> -#define AD7746_CAPDAC_DACEN		(BIT(7))
> +#define AD7746_CAPDAC_DACEN		BIT(7)
>  #define AD7746_CAPDAC_DACP(x)		((x) & 0x7F)
>  
>  /*
> 

