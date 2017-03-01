Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:46224 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbdCAQeS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Mar 2017 11:34:18 -0500
Subject: Re: [PATCH] staging: iio: ad7280a: Group similar macros into enums
To: sayli karnik <karniksayli1995@gmail.com>,
        outreachy-kernel@googlegroups.com
References: <20170301052712.GA19851@sayli-HP-15-Notebook-PC>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <1630a5da-d2ab-adc6-d704-c1b0b615fc31@metafoo.de>
Date: Wed, 1 Mar 2017 17:32:55 +0100
MIME-Version: 1.0
In-Reply-To: <20170301052712.GA19851@sayli-HP-15-Notebook-PC>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/01/2017 06:27 AM, sayli karnik wrote:
> The patch groups similar macros into enum data types.
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

Sorry, I should have been more specific on the previous mail. This should be
named enum, like 'enum ad7280a_conv_avg' and then use the enum type instead
of unsigned int for the field in the platform_data struct. This makes sure
that the there is a clear dependency between the values and the field.

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

Same here.

> +	AD7280A_ACQ_TIME_400ns = 0,
> +	AD7280A_ACQ_TIME_800ns,
> +	AD7280A_ACQ_TIME_1200ns,
> +	AD7280A_ACQ_TIME_1600ns,
> +};
>  
>  #define AD7280A_ALERT_REMOVE_VIN5		BIT(2)
>  #define AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
> 

