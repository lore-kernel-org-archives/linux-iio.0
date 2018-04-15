Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751890AbeDOPND (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Apr 2018 11:13:03 -0400
Date: Sun, 15 Apr 2018 16:12:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/14] staging: iio: ad7746: Remove unused defines
Message-ID: <20180415161257.77769dc8@archlinux>
In-Reply-To: <1523637411-8531-8-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1523637411-8531-8-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 13 Apr 2018 13:36:44 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 7 -------
>  drivers/staging/iio/cdc/ad7746.h | 5 -----
>  2 files changed, 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index f53612a..d39ab34 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -25,7 +25,6 @@
>   * AD7746 Register Definition
>   */
>  
> -#define AD7746_REG_STATUS		0
>  #define AD7746_REG_CAP_DATA_HIGH	1
>  #define AD7746_REG_VT_DATA_HIGH		4
>  #define AD7746_REG_CAP_SETUP		7
> @@ -38,12 +37,6 @@
>  #define AD7746_REG_CAP_GAINH		15
>  #define AD7746_REG_VOLT_GAINH		17
>  
> -/* Status Register Bit Designations (AD7746_REG_STATUS) */
> -#define AD7746_STATUS_EXCERR		BIT(3)
> -#define AD7746_STATUS_RDY		BIT(2)
> -#define AD7746_STATUS_RDYVT		BIT(1)
> -#define AD7746_STATUS_RDYCAP		BIT(0)
> -
There is a pretty strong argument that the driver 'should' be
checking the status register...

I would leave it the defines here.  When they are acting
as 'documentation' of the register layout of a device, they
do little harm and can be very useful.

>  /* Capacitive Channel Setup Register Bit Designations (AD7746_REG_CAP_SETUP) */
>  #define AD7746_CAPSETUP_CAPEN		BIT(7)
>  #define AD7746_CAPSETUP_CIN2		BIT(6) /* AD7746 only */
> diff --git a/drivers/staging/iio/cdc/ad7746.h b/drivers/staging/iio/cdc/ad7746.h
> index ea8572d..2fbcee8 100644
> --- a/drivers/staging/iio/cdc/ad7746.h
> +++ b/drivers/staging/iio/cdc/ad7746.h
> @@ -13,11 +13,6 @@
>   * TODO: struct ad7746_platform_data needs to go into include/linux/iio
>   */
>  
> -#define AD7466_EXCLVL_0		0 /* +-VDD/8 */
> -#define AD7466_EXCLVL_1		1 /* +-VDD/4 */
> -#define AD7466_EXCLVL_2		2 /* +-VDD * 3/8 */
> -#define AD7466_EXCLVL_3		3 /* +-VDD/2 */
> -

Think about what these are for.... They aren't unused
if you are actually using platform data on a given oard.

>  struct ad7746_platform_data {
>  	unsigned char exclvl;	/*Excitation Voltage Level */
>  	bool exca_en;		/* enables EXCA pin as the excitation output */

