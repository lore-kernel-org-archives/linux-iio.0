Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751073AbdL2M4Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Dec 2017 07:56:16 -0500
Date: Fri, 29 Dec 2017 12:56:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marc CAPDEVILLE <m.capdeville@no-log.org>
Cc: Kevin Tsai <ktsai@capellamicro.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] iio : cm32181 : cosmetic cleanup
Message-ID: <20171229125610.67b21757@archlinux>
In-Reply-To: <20171225155723.6338-4-m.capdeville@no-log.org>
References: <20171225155723.6338-1-m.capdeville@no-log.org>
        <20171225155723.6338-4-m.capdeville@no-log.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 25 Dec 2017 16:57:23 +0100
Marc CAPDEVILLE <m.capdeville@no-log.org> wrote:

> Somme cosmetic cleanup suggested by Peter Meerwald-Stadler.
> 
> Macro name :
>    MLUX_PER_LUX => CM32181_MLUX_PER_LUX
> 
> Constante name :
>    als_it_bits => cm32181_als_it_bits
>    als_it_value => cm32181_als_it_value
> 
> Comment :
>    Registers Address => Register Addresses
> 
> Suggested-by:  Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Signed-off-by: Marc CAPDEVILLE <m.capdeville@no-log.org>
This is all fine. For my reference please add

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/light/cm32181.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index 96c08755e6e3..3e6b244d5cd1 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -22,7 +22,7 @@
>  #include <linux/acpi.h>
>  #include <linux/of_device.h>
>  
> -/* Registers Address */
> +/* Register Addresses */
>  #define CM32181_REG_ADDR_CMD		0x00
>  #define CM32181_REG_ADDR_ALS		0x04
>  #define CM32181_REG_ADDR_STATUS		0x06
> @@ -48,7 +48,7 @@
>  #define CM32181_MLUX_PER_BIT_BASE_IT	800000	/* Based on IT=800ms */
>  #define	CM32181_CALIBSCALE_DEFAULT	1000
>  #define CM32181_CALIBSCALE_RESOLUTION	1000
> -#define MLUX_PER_LUX			1000
> +#define CM32181_MLUX_PER_LUX		1000
>  
>  #define CM32181_ID			0x81
>  #define CM3218_ID			0x18
> @@ -59,8 +59,8 @@ static const u8 cm32181_reg[CM32181_CONF_REG_NUM] = {
>  	CM32181_REG_ADDR_CMD,
>  };
>  
> -static const int als_it_bits[] = {12, 8, 0, 1, 2, 3};
> -static const int als_it_value[] = {25000, 50000, 100000, 200000, 400000,
> +static const int cm32181_als_it_bits[] = {12, 8, 0, 1, 2, 3};
> +static const int cm32181_als_it_value[] = {25000, 50000, 100000, 200000, 400000,
>  	800000};
>  
>  struct cm32181_chip {
> @@ -137,9 +137,9 @@ static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val2)
>  	als_it = cm32181->conf_regs[CM32181_REG_ADDR_CMD];
>  	als_it &= CM32181_CMD_ALS_IT_MASK;
>  	als_it >>= CM32181_CMD_ALS_IT_SHIFT;
> -	for (i = 0; i < ARRAY_SIZE(als_it_bits); i++) {
> -		if (als_it == als_it_bits[i]) {
> -			*val2 = als_it_value[i];
> +	for (i = 0; i < ARRAY_SIZE(cm32181_als_it_bits); i++) {
> +		if (als_it == cm32181_als_it_bits[i]) {
> +			*val2 = cm32181_als_it_value[i];
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		}
>  	}
> @@ -162,14 +162,14 @@ static int cm32181_write_als_it(struct cm32181_chip *cm32181, int val)
>  	u16 als_it;
>  	int ret, i, n;
>  
> -	n = ARRAY_SIZE(als_it_value);
> +	n = ARRAY_SIZE(cm32181_als_it_value);
>  	for (i = 0; i < n; i++)
> -		if (val <= als_it_value[i])
> +		if (val <= cm32181_als_it_value[i])
>  			break;
>  	if (i >= n)
>  		i = n - 1;
>  
> -	als_it = als_it_bits[i];
> +	als_it = cm32181_als_it_bits[i];
>  	als_it <<= CM32181_CMD_ALS_IT_SHIFT;
>  
>  	mutex_lock(&cm32181->lock);
> @@ -215,7 +215,7 @@ static int cm32181_get_lux(struct cm32181_chip *cm32181)
>  	lux *= ret;
>  	lux *= cm32181->calibscale;
>  	lux /= CM32181_CALIBSCALE_RESOLUTION;
> -	lux /= MLUX_PER_LUX;
> +	lux /= CM32181_MLUX_PER_LUX;
>  
>  	if (lux > 0xFFFF)
>  		lux = 0xFFFF;
> @@ -283,9 +283,9 @@ static ssize_t cm32181_get_it_available(struct device *dev,
>  {
>  	int i, n, len;
>  
> -	n = ARRAY_SIZE(als_it_value);
> +	n = ARRAY_SIZE(cm32181_als_it_value);
>  	for (i = 0, len = 0; i < n; i++)
> -		len += sprintf(buf + len, "0.%06u ", als_it_value[i]);
> +		len += sprintf(buf + len, "0.%06u ", cm32181_als_it_value[i]);
>  	return len + sprintf(buf + len, "\n");
>  }
>  

