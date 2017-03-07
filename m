Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:48048 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755758AbdCGTRx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Mar 2017 14:17:53 -0500
Date: Tue, 7 Mar 2017 20:17:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: sayli karnik <karniksayli1995@gmail.com>
Cc: outreachy-kernel@googlegroups.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: ad7280a: Group similar macros into enums
Message-ID: <20170307191746.GA22068@kroah.com>
References: <20170307191112.GA29306@sayli-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170307191112.GA29306@sayli-HP-15-Notebook-PC>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 08, 2017 at 12:41:12AM +0530, sayli karnik wrote:
> The patch groups similar macros into enum data types.

Why?

What benefit does this provide?

> 
> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
> ---
> Changes in v2:
> Corrected the order of both the enums.
> Used enum data type names instead of unsigned int inside struct
> ad7280_platform_data.
> 
>  drivers/staging/iio/adc/ad7280a.h | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.h b/drivers/staging/iio/adc/ad7280a.h
> index ccfb90d..e22694f 100644
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
> +enum ad7280a_acq_time {
> +	AD7280A_ACQ_TIME_400ns = 0,
> +	AD7280A_ACQ_TIME_800ns,
> +	AD7280A_ACQ_TIME_1200ns,
> +	AD7280A_ACQ_TIME_1600ns,

Before your change, you instantly knew that the 1600ns value needed to
be 3.  Now I need to count an enum.  Does this seem like a better
change?  Are you _sure_ the compiler sets the values properly?

thanks,

greg k-h
