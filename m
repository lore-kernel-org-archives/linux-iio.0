Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:42517 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdCAFds (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Mar 2017 00:33:48 -0500
Subject: Re: [PATCH] staging: iio: ad7280a: Move contents of header file to
 source file
To: sayli karnik <karniksayli1995@gmail.com>,
        outreachy-kernel@googlegroups.com
References: <20170228182630.GA10423@sayli-HP-15-Notebook-PC>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <7a8ae020-2c89-933a-4e3a-ff7771626a57@metafoo.de>
Date: Tue, 28 Feb 2017 19:32:44 +0100
MIME-Version: 1.0
In-Reply-To: <20170228182630.GA10423@sayli-HP-15-Notebook-PC>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/28/2017 07:26 PM, sayli karnik wrote:
> The contents of the header file are used only by this single
> source file.  Move content into .c and remove .h.

Hi,

Thanks for the patch. I'm afraid that these are values that are supposed to
be used to initialize the fields in the platform data struct. So they have
to stay in the header as well.

If you want to clean this up, convert at least the enumerations to a enum
data type, so that it is clear what their function is.

> 
> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7280a.c | 15 +++++++++++++++
>  drivers/staging/iio/adc/ad7280a.h | 15 ---------------
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index ee679ac..44d13dc 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -22,6 +22,21 @@
>  
>  #include "ad7280a.h"
>  
> +#define AD7280A_ACQ_TIME_400ns			0
> +#define AD7280A_ACQ_TIME_800ns			1
> +#define AD7280A_ACQ_TIME_1200ns			2
> +#define AD7280A_ACQ_TIME_1600ns			3
> +
> +#define AD7280A_CONV_AVG_DIS			0
> +#define AD7280A_CONV_AVG_2			1
> +#define AD7280A_CONV_AVG_4			2
> +#define AD7280A_CONV_AVG_8			3
> +
> +#define AD7280A_ALERT_REMOVE_VIN5		BIT(2)
> +#define AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
> +#define AD7280A_ALERT_REMOVE_AUX5		BIT(0)
> +#define AD7280A_ALERT_REMOVE_AUX4_AUX5		BIT(1)
> +
>  /* Registers */
>  #define AD7280A_CELL_VOLTAGE_1		0x0  /* D11 to D0, Read only */
>  #define AD7280A_CELL_VOLTAGE_2		0x1  /* D11 to D0, Read only */
> diff --git a/drivers/staging/iio/adc/ad7280a.h b/drivers/staging/iio/adc/ad7280a.h
> index ccfb90d..1b50dd8 100644
> --- a/drivers/staging/iio/adc/ad7280a.h
> +++ b/drivers/staging/iio/adc/ad7280a.h
> @@ -13,21 +13,6 @@
>   * TODO: struct ad7280_platform_data needs to go into include/linux/iio
>   */
>  
> -#define AD7280A_ACQ_TIME_400ns			0
> -#define AD7280A_ACQ_TIME_800ns			1
> -#define AD7280A_ACQ_TIME_1200ns			2
> -#define AD7280A_ACQ_TIME_1600ns			3
> -
> -#define AD7280A_CONV_AVG_DIS			0
> -#define AD7280A_CONV_AVG_2			1
> -#define AD7280A_CONV_AVG_4			2
> -#define AD7280A_CONV_AVG_8			3
> -
> -#define AD7280A_ALERT_REMOVE_VIN5		BIT(2)
> -#define AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
> -#define AD7280A_ALERT_REMOVE_AUX5		BIT(0)
> -#define AD7280A_ALERT_REMOVE_AUX4_AUX5		BIT(1)
> -
>  struct ad7280_platform_data {
>  	unsigned int		acquisition_time;
>  	unsigned int		conversion_averaging;
> 

