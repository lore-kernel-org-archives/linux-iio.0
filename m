Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48672 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbcLJRvK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Dec 2016 12:51:10 -0500
Subject: Re: [PATCH] Staging: iio: impedance-analyzer: ad5933: fix wrong
 comments
To: Nizam Haider <nizamhaider786@gmail.com>, pmeerw@pmeerw.net
References: <20161207174447.24128-1-nizamhaider786@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nizam Haider <nijam.h@hcl.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1eda9a06-063e-e865-9032-2883b4d26584@kernel.org>
Date: Sat, 10 Dec 2016 17:51:07 +0000
MIME-Version: 1.0
In-Reply-To: <20161207174447.24128-1-nizamhaider786@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/12/16 17:44, Nizam Haider wrote:
> according to datasheet complete control register is of 2 bytes.
> http://www.analog.com/media/en/technical-documentation/data-sheets/AD5933.pdf
> 
> Signed-off-by: Nizam Haider <nijam.h@hcl.com>
Applied to the togreg branch of iio.git - initially pushed out as testing so the
autobuilders can completely ignore this patch ;)

Jonathan
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 3892a74..f39e03a 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -23,8 +23,8 @@
>  #include <linux/iio/kfifo_buf.h>
>  
>  /* AD5933/AD5934 Registers */
> -#define AD5933_REG_CONTROL_HB		0x80	/* R/W, 2 bytes */
> -#define AD5933_REG_CONTROL_LB		0x81	/* R/W, 2 bytes */
> +#define AD5933_REG_CONTROL_HB		0x80	/* R/W, 1 byte */
> +#define AD5933_REG_CONTROL_LB		0x81	/* R/W, 1 byte */
>  #define AD5933_REG_FREQ_START		0x82	/* R/W, 3 bytes */
>  #define AD5933_REG_FREQ_INC		0x85	/* R/W, 3 bytes */
>  #define AD5933_REG_INC_NUM		0x88	/* R/W, 2 bytes, 9 bit */
> 

