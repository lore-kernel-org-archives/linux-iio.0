Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:58228 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbdCVMeY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 08:34:24 -0400
Subject: Re: [PATCH v2] staging: iio: Replace a bit shift by a use of BIT.
To: Arushi Singhal <arushisinghal19971997@gmail.com>
References: <20170322083824.GA26432@arushi-HP-Pavilion-Notebook>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <dcb17654-3fe2-4a80-0c51-e100c41b6a8d@metafoo.de>
Date: Wed, 22 Mar 2017 12:37:53 +0100
MIME-Version: 1.0
In-Reply-To: <20170322083824.GA26432@arushi-HP-Pavilion-Notebook>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/22/2017 09:38 AM, Arushi Singhal wrote:
> This patch replaces bit shifting on 1 with the BIT(x) macro.
> This was done with coccinelle:
> @@
> constant c;
> @@
> 
> -1 << c
> +BIT(c)

When it comes to doing this type of conversion semantics, i.e. the meaning
of the value, are important. The BIT() macro should only be used when the
value is really a 1 bit value. Otherwise it will be confusing to the reader
of the code.

Also one patch per driver please (Unless it is an absolutely identical
change to multiple driver, not just the same class of change).

> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
> changes in v2
>  -change the cc list
> 
>  drivers/staging/iio/adc/ad7816.c |  2 +-
>  drivers/staging/iio/cdc/ad7150.c |  2 +-
>  drivers/staging/iio/cdc/ad7746.c | 22 +++++++++++-----------
>  3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 17d280581e24..42f637ca0251 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -222,7 +222,7 @@ static ssize_t ad7816_show_value(struct device *dev,
>  		value = (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);
>  		data &= AD7816_TEMP_FLOAT_MASK;
>  		if (value < 0)
> -			data = (1 << AD7816_TEMP_FLOAT_OFFSET) - data;
> +			data = (BIT(AD7816_TEMP_FLOAT_OFFSET)) - data;

This for example is just a really poor implementation of unsigned binary to
signed conversion (The formula I think is straight from the datasheet).
Semantically talking about a 1-bit value here makes no sense. What the code
does is to construct a value that is equal to 2**AD7816_TEMP_FLOAT_OFFSET.

>  		return sprintf(buf, "%d.%.2d\n", value, data * 25);
>  	}
>  	return sprintf(buf, "%u\n", data);
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index ca72af3e9d4b..c5574b3ee939 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -232,7 +232,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
>  	if (ret < 0)
>  		goto error_ret;
>  
> -	cfg = ret & ~((0x03 << 5) | (0x1 << 7));
> +	cfg = ret & ~((0x03 << 5) | (BIT(7)));

This is OK. It's a one bit field that is set here.

>  
>  	switch (type) {
>  	case IIO_EV_TYPE_MAG_ADAPTIVE:
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 81f8b9ee1120..8c573817826f 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -45,20 +45,20 @@
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

These are all OK, they are single bit values or flags.

>  
>  /* Voltage/Temperature Setup Register Bit Designations (AD7746_REG_VT_SETUP) */
> -#define AD7746_VTSETUP_VTEN		(1 << 7)
> +#define AD7746_VTSETUP_VTEN		(BIT(7))
>  #define AD7746_VTSETUP_VTMD_INT_TEMP	(0 << 5)
> -#define AD7746_VTSETUP_VTMD_EXT_TEMP	(1 << 5)
> +#define AD7746_VTSETUP_VTMD_EXT_TEMP	(BIT(5))

This is not OK. This is a multi-bit field. b01 just happens to be one of the
valid values.

>  #define AD7746_VTSETUP_VTMD_VDD_MON	(2 << 5)
>  #define AD7746_VTSETUP_VTMD_EXT_VIN	(3 << 5)
> -#define AD7746_VTSETUP_EXTREF		(1 << 4)
> -#define AD7746_VTSETUP_VTSHORT		(1 << 1)
> -#define AD7746_VTSETUP_VTCHOP		(1 << 0)
> +#define AD7746_VTSETUP_EXTREF		(BIT(4))
> +#define AD7746_VTSETUP_VTSHORT		(BIT(1))
> +#define AD7746_VTSETUP_VTCHOP		(BIT(0))

These are OK. All single bit values.

>  
>  /* Excitation Setup Register Bit Designations (AD7746_REG_EXC_SETUP) */
>  #define AD7746_EXCSETUP_CLKCTRL		BIT(7)
> @@ -75,14 +75,14 @@
>  #define AD7746_CONF_VTFS_MASK		GENMASK(7, 6)
>  #define AD7746_CONF_CAPFS_MASK		GENMASK(5, 3)
>  #define AD7746_CONF_MODE_IDLE		(0 << 0)
> -#define AD7746_CONF_MODE_CONT_CONV	(1 << 0)
> +#define AD7746_CONF_MODE_CONT_CONV	(BIT(0))

This again is a multi-bit field where 1 is one of the possible values. So
not OK.

>  #define AD7746_CONF_MODE_SINGLE_CONV	(2 << 0)
>  #define AD7746_CONF_MODE_PWRDN		(3 << 0)
>  #define AD7746_CONF_MODE_OFFS_CAL	(5 << 0)
>  #define AD7746_CONF_MODE_GAIN_CAL	(6 << 0)
>  
>  /* CAPDAC Register Bit Designations (AD7746_REG_CAPDACx) */
> -#define AD7746_CAPDAC_DACEN		(1 << 7)
> +#define AD7746_CAPDAC_DACEN		(BIT(7))

OK.

>  #define AD7746_CAPDAC_DACP(x)		((x) & 0x7F)
>  
>  /*
> 

