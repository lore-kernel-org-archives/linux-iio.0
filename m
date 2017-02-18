Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:51930 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753461AbdBRUk4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2017 15:40:56 -0500
Subject: Re: [PATCH 2/3] staging: iio: ad7152: Use GENMASK() macro for left
 shifts
To: sayli karnik <karniksayli1995@gmail.com>,
        outreachy-kernel@googlegroups.com
References: <cover.1487448326.git.karniksayli1995@gmail.com>
 <92240a3dca0138880fe47a7df0a5e6df869c8199.1487448326.git.karniksayli1995@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <0b5ef4d0-14b5-1196-8bc4-deda9d8f75ce@metafoo.de>
Date: Sat, 18 Feb 2017 21:40:46 +0100
MIME-Version: 1.0
In-Reply-To: <92240a3dca0138880fe47a7df0a5e6df869c8199.1487448326.git.karniksayli1995@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/18/2017 09:21 PM, sayli karnik wrote:
> Use GENMASK() macro for left shifting integers.
> Done using coccinelle:
> @@ int a,b; @@
> 
> -(a << b)
> +GENMASK(a, b)
> 
> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>

Hi,

Thanks for the patch. Looks mostly good, but please rework the patch for
version 2 to address the comments for patch 1.

Some additional comments inline.

[...]
>  /* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
>  #define AD7152_SETUP_CAPDIFF		BIT(5)
> -#define AD7152_SETUP_RANGE_2pF		(0 << 6)
> +#define AD7152_SETUP_RANGE_2pF		GENMASK(0, 6)
>  #define AD7152_SETUP_RANGE_0_5pF	BIT(6)
> -#define AD7152_SETUP_RANGE_1pF		(2 << 6)
> -#define AD7152_SETUP_RANGE_4pF		(3 << 6)
> +#define AD7152_SETUP_RANGE_1pF		GENMASK(2, 6)
> +#define AD7152_SETUP_RANGE_4pF		GENMASK(3, 6)
>  #define AD7152_SETUP_RANGE(x)		((x) << 6)

AD7152_SETUP_RANGE() can also use the GENMASK() macro

[...]
>  /* CFG2 Register Bit Designations (AD7152_REG_CFG2) */
> -#define AD7152_CFG2_OSR(x)		(((x) & 0x3) << 4)
> +#define AD7152_CFG2_OSR(x)		GENMASK(((x) & 0x3), 4)

The extra parenthesis around (x) & 0x3 are no needed when using the macro
(the macro will add them).

