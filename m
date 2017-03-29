Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:59687
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753303AbdC2UhO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 16:37:14 -0400
Date: Wed, 29 Mar 2017 22:37:11 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
cc: lars@metafoo.de, outreachy-kernel@googlegroups.com,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2] staging: iio: Remove unneeded
 parentheses.
In-Reply-To: <20170329160551.GA7230@arushi-HP-Pavilion-Notebook>
Message-ID: <alpine.DEB.2.20.1703292236290.2146@hadrien>
References: <20170329160551.GA7230@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Wed, 29 Mar 2017, Arushi Singhal wrote:

> Remove the extra parenthesis remove the checkpatch issue.

The patch replaces 1 << x by calls to BIT.  That doesn't correspond to the
commit message.

julia

>
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
> changes in v2
>  -done the changes according to the current tree
>
>  drivers/staging/iio/cdc/ad7746.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index c2c8aa5585e4..7fa9913386f5 100644
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
> +#define AD7746_CAPSETUP_CAPEN		BIT(7)
> +#define AD7746_CAPSETUP_CIN2		BIT(6) /* AD7746 only */
> +#define AD7746_CAPSETUP_CAPDIFF		BIT(5)
> +#define AD7746_CAPSETUP_CACHOP		BIT(0)
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
> +#define AD7746_VTSETUP_EXTREF		BIT(4)
> +#define AD7746_VTSETUP_VTSHORT		BIT(1)
> +#define AD7746_VTSETUP_VTCHOP		BIT(0)
>
>  /* Excitation Setup Register Bit Designations (AD7746_REG_EXC_SETUP) */
>  #define AD7746_EXCSETUP_CLKCTRL		BIT(7)
> @@ -82,7 +82,7 @@
>  #define AD7746_CONF_MODE_GAIN_CAL	(6 << 0)
>
>  /* CAPDAC Register Bit Designations (AD7746_REG_CAPDACx) */
> -#define AD7746_CAPDAC_DACEN		(1 << 7)
> +#define AD7746_CAPDAC_DACEN		BIT(7)
>  #define AD7746_CAPDAC_DACP(x)		((x) & 0x7F)
>
>  /*
> --
> 2.11.0
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170329160551.GA7230%40arushi-HP-Pavilion-Notebook.
> For more options, visit https://groups.google.com/d/optout.
>
