Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:22444 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbdGRKCH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jul 2017 06:02:07 -0400
Date: Tue, 18 Jul 2017 13:01:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jaya Durga <rjdurga@gmail.com>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de, jic23@kernel.org
Subject: Re: [PATCH 3/3] Staging: iio: adc: ad7280a.c: Fixed Macro argument
 reuse
Message-ID: <20170718100126.4mxihfhkipcujsqm@mwanda>
References: <1500371272-16701-1-git-send-email-rjdurga@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500371272-16701-1-git-send-email-rjdurga@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 18, 2017 at 03:17:52PM +0530, Jaya Durga wrote:
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index d5ab83f..cb94b7f 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -99,9 +99,12 @@
>  #define AD7280A_DEVADDR_MASTER		0
>  #define AD7280A_DEVADDR_ALL		0x1F
>  /* 5-bit device address is sent LSB first */
> -#define AD7280A_DEVADDR(addr)	(((addr & 0x1) << 4) | ((addr & 0x2) << 3) | \
> -				(addr & 0x4) | ((addr & 0x8) >> 3) | \
> -				((addr & 0x10) >> 4))
> +static inline unsigned int AD7280A_DEVADDR(unsigned int addr)

Don't make this inline.  GCC is going to ignore the inline anyway, and
make up its own mind about what to do.  Change the name to not be all
caps.  Generally, all caps means it's a macro.

> +{
> +	return ((((addr & 0x1) << 4) | ((addr & 0x2) << 3) |
> +		  (addr & 0x4) | ((addr & 0x8) >> 3) |
> +		  ((addr & 0x10) >> 4)));

We don't need all the parens.

	return ((addr & 0x1) << 4) |
	       ((addr & 0x2) << 3) |
		(addr & 0x4)       |
	       ((addr & 0x8) >> 3) |
	       ((addr & 0x10) >> 4);

regards,
dan carpenter

