Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48164 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936241AbdCVTa7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 15:30:59 -0400
Subject: Re: [PATCH v2] staging: iio: Replace a bit shift by a use of BIT.
To: Arushi Singhal <arushisinghal19971997@gmail.com>, lars@metafoo.de
References: <20170322164234.GA18805@arushi-HP-Pavilion-Notebook>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d0fc8f89-727c-b781-3a08-ed5eafb7e13e@kernel.org>
Date: Wed, 22 Mar 2017 19:30:52 +0000
MIME-Version: 1.0
In-Reply-To: <20170322164234.GA18805@arushi-HP-Pavilion-Notebook>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/03/17 16:42, Arushi Singhal wrote:
> This patch replaces bit shifting on 1 with the BIT(x) macro.
> This was done with coccinelle:
> @@
> constant c;
> @@
> 
> -1 << c
> +BIT(c)
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
> changes in v2
>  -remove/correct the wrong code.
> 
>  drivers/staging/iio/cdc/ad7150.c |  2 +-
>  drivers/staging/iio/cdc/ad7746.c | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index ca72af3e9d4b..a6f249e9c1e1 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -232,7 +232,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
>  	if (ret < 0)
>  		goto error_ret;
>  
> -	cfg = ret & ~((0x03 << 5) | (0x1 << 7));
> +	cfg = ret & ~((0x03 << 5) | BIT(7));
>  
>  	switch (type) {
>  	case IIO_EV_TYPE_MAG_ADAPTIVE:
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 81f8b9ee1120..453d3978879d 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -45,10 +45,10 @@
>  #define AD7746_STATUS_RDYCAP		BIT(0)
>  
>  /* Capacitive Channel Setup Register Bit Designations (AD7746_REG_CAP_SETUP) */
> -#define AD7746_CAPSETUP_CAPEN		(1 << 7)
> -#define AD7746_CAPSETUP_CIN2		(1 << 6) /* AD7746 only */
> -#define AD7746_CAPSETUP_CAPDIFF		(1 << 5)
> -#define AD7746_CAPSETUP_CACHOP		(1 << 0)
> +#define AD7746_CAPSETUP_CAPEN		(BIT(7))
> +#define AD7746_CAPSETUP_CIN2		(BIT(6)) /* AD7746 only */
> +#define AD7746_CAPSETUP_CAPDIFF		(BIT(5))
> +#define AD7746_CAPSETUP_CACHOP		(BIT(0))
>  
>  /* Voltage/Temperature Setup Register Bit Designations (AD7746_REG_VT_SETUP) */
>  #define AD7746_VTSETUP_VTEN		(1 << 7)
> @@ -56,9 +56,9 @@
>  #define AD7746_VTSETUP_VTMD_EXT_TEMP	(1 << 5)
>  #define AD7746_VTSETUP_VTMD_VDD_MON	(2 << 5)
>  #define AD7746_VTSETUP_VTMD_EXT_VIN	(3 << 5)
> -#define AD7746_VTSETUP_EXTREF		(1 << 4)
> -#define AD7746_VTSETUP_VTSHORT		(1 << 1)
> -#define AD7746_VTSETUP_VTCHOP		(1 << 0)
> +#define AD7746_VTSETUP_EXTREF		(BIT(4))
> +#define AD7746_VTSETUP_VTSHORT		(BIT(1))
> +#define AD7746_VTSETUP_VTCHOP		(BIT(0))
>  
>  /* Excitation Setup Register Bit Designations (AD7746_REG_EXC_SETUP) */
>  #define AD7746_EXCSETUP_CLKCTRL		BIT(7)
> @@ -82,7 +82,7 @@
>  #define AD7746_CONF_MODE_GAIN_CAL	(6 << 0)
>  
>  /* CAPDAC Register Bit Designations (AD7746_REG_CAPDACx) */
> -#define AD7746_CAPDAC_DACEN		(1 << 7)
> +#define AD7746_CAPDAC_DACEN		(BIT(7))
>  #define AD7746_CAPDAC_DACP(x)		((x) & 0x7F)
>  
>  /*
> 

