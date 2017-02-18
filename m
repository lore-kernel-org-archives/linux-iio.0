Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:51606 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753461AbdBRUfT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2017 15:35:19 -0500
Subject: Re: [PATCH 1/3] staging: iio: ad7152: Use BIT() macro for left
 shifting 1
To: sayli karnik <karniksayli1995@gmail.com>,
        outreachy-kernel@googlegroups.com
References: <cover.1487448326.git.karniksayli1995@gmail.com>
 <2f967b89d81cadb4a96a3ce38e4bd5571fb2bd8c.1487448326.git.karniksayli1995@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <26f4107f-41ec-b504-10f0-e857a110d35c@metafoo.de>
Date: Sat, 18 Feb 2017 21:35:05 +0100
MIME-Version: 1.0
In-Reply-To: <2f967b89d81cadb4a96a3ce38e4bd5571fb2bd8c.1487448326.git.karniksayli1995@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/18/2017 09:20 PM, sayli karnik wrote:
> Replace left shifting on 1 with the BIT(x) macro as suggested by
> checkpatch.pl.
> 
> Done with coccinelle:
> @@ int g; @@
> 
> -(1 << g)
> +BIT(g)
> 
> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>

Hi,

Thanks for the patch. When doing these kind of conversions special care
needs to be taken to make sure that they make semantical sense.

The BIT(x) transform for example should only be done for single bit bitfields.

[...]
>  /* Status Register Bit Designations (AD7152_REG_STATUS) */
> -#define AD7152_STATUS_RDY1		(1 << 0)
> -#define AD7152_STATUS_RDY2		(1 << 1)
> -#define AD7152_STATUS_C1C2		(1 << 2)
> -#define AD7152_STATUS_PWDN		(1 << 7)
> +#define AD7152_STATUS_RDY1		BIT(0)
> +#define AD7152_STATUS_RDY2		BIT(1)
> +#define AD7152_STATUS_C1C2		BIT(2)
> +#define AD7152_STATUS_PWDN		BIT(7)

This is correct, these are all single bit bitfields.

>  
>  /* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
> -#define AD7152_SETUP_CAPDIFF		(1 << 5)
> +#define AD7152_SETUP_CAPDIFF		BIT(5)
>  #define AD7152_SETUP_RANGE_2pF		(0 << 6)
> -#define AD7152_SETUP_RANGE_0_5pF	(1 << 6)
> +#define AD7152_SETUP_RANGE_0_5pF	BIT(6)

This on the other hand is a multi-bit field with 1 being one of the possible
values. Hence this should be part of the second patch and use GENMASK instead.

In general when you have a whole bunch of values following the scheme of y
<< x. With 1 << x being one of them use GENMASK() rather than BIT().

>  #define AD7152_SETUP_RANGE_1pF		(2 << 6)
>  #define AD7152_SETUP_RANGE_4pF		(3 << 6)
>  #define AD7152_SETUP_RANGE(x)		((x) << 6)
>  
>  /* Config Register Bit Designations (AD7152_REG_CFG) */
> -#define AD7152_CONF_CH2EN		(1 << 3)
> -#define AD7152_CONF_CH1EN		(1 << 4)
> +#define AD7152_CONF_CH2EN		BIT(3)
> +#define AD7152_CONF_CH1EN		BIT(4)
>  #define AD7152_CONF_MODE_IDLE		(0 << 0)
> -#define AD7152_CONF_MODE_CONT_CONV	(1 << 0)
> +#define AD7152_CONF_MODE_CONT_CONV	BIT(0)

Same here.

>  #define AD7152_CONF_MODE_SINGLE_CONV	(2 << 0)
>  #define AD7152_CONF_MODE_OFFS_CAL	(5 << 0)
>  #define AD7152_CONF_MODE_GAIN_CAL	(6 << 0)
>  
>  /* Capdac Register Bit Designations (AD7152_REG_CAPDAC_XXX) */
> -#define AD7152_CAPDAC_DACEN		(1 << 7)
> +#define AD7152_CAPDAC_DACEN		BIT(7)
>  #define AD7152_CAPDAC_DACP(x)		((x) & 0x1F)
>  
>  /* CFG2 Register Bit Designations (AD7152_REG_CFG2) */
> 

