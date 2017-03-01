Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:14583 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750738AbdCAGXv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Mar 2017 01:23:51 -0500
Date: Wed, 1 Mar 2017 07:23:29 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: sayli karnik <karniksayli1995@gmail.com>
cc: outreachy-kernel@googlegroups.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: ad7280a: Group similar
 macros into enums
In-Reply-To: <20170301052712.GA19851@sayli-HP-15-Notebook-PC>
Message-ID: <alpine.DEB.2.20.1703010723120.2079@hadrien>
References: <20170301052712.GA19851@sayli-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Wed, 1 Mar 2017, sayli karnik wrote:

> The patch groups similar macros into enum data types.

Like Alison said, I wonder why you changed the order.

julia

>
> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7280a.h | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/ad7280a.h b/drivers/staging/iio/adc/ad7280a.h
> index ccfb90d..08e97d4 100644
> --- a/drivers/staging/iio/adc/ad7280a.h
> +++ b/drivers/staging/iio/adc/ad7280a.h
> @@ -13,15 +13,19 @@
>   * TODO: struct ad7280_platform_data needs to go into include/linux/iio
>   */
>
> -#define AD7280A_ACQ_TIME_400ns			0
> -#define AD7280A_ACQ_TIME_800ns			1
> -#define AD7280A_ACQ_TIME_1200ns			2
> -#define AD7280A_ACQ_TIME_1600ns			3
> +enum {
> +	AD7280A_CONV_AVG_DIS = 0,
> +	AD7280A_CONV_AVG_2,
> +	AD7280A_CONV_AVG_4,
> +	AD7280A_CONV_AVG_8,
> +};
>
> -#define AD7280A_CONV_AVG_DIS			0
> -#define AD7280A_CONV_AVG_2			1
> -#define AD7280A_CONV_AVG_4			2
> -#define AD7280A_CONV_AVG_8			3
> +enum {
> +	AD7280A_ACQ_TIME_400ns = 0,
> +	AD7280A_ACQ_TIME_800ns,
> +	AD7280A_ACQ_TIME_1200ns,
> +	AD7280A_ACQ_TIME_1600ns,
> +};
>
>  #define AD7280A_ALERT_REMOVE_VIN5		BIT(2)
>  #define AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170301052712.GA19851%40sayli-HP-15-Notebook-PC.
> For more options, visit https://groups.google.com/d/optout.
>
