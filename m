Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33517 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbcADMRZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jan 2016 07:17:25 -0500
Subject: Re: [PATCH 4/5] Staging: iio: cdc: ad7150: Prefer using the BIT macro
To: Shraddha Barke <shraddha.6596@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1451388451-10342-1-git-send-email-shraddha.6596@gmail.com>
 <1451388451-10342-5-git-send-email-shraddha.6596@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <568A62D0.8090907@kernel.org>
Date: Mon, 4 Jan 2016 12:17:20 +0000
MIME-Version: 1.0
In-Reply-To: <1451388451-10342-5-git-send-email-shraddha.6596@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/12/15 11:27, Shraddha Barke wrote:
> Replace bit shifting on 1 with the BIT(x) macro
> 
> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
Applied.
> ---
>  drivers/staging/iio/cdc/ad7150.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index e8d0ff2..0b934f7 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -21,8 +21,8 @@
>   */
>  
>  #define AD7150_STATUS              0
> -#define AD7150_STATUS_OUT1         (1 << 3)
> -#define AD7150_STATUS_OUT2         (1 << 5)
> +#define AD7150_STATUS_OUT1         BIT(3)
> +#define AD7150_STATUS_OUT2         BIT(5)
>  #define AD7150_CH1_DATA_HIGH       1
>  #define AD7150_CH2_DATA_HIGH       3
>  #define AD7150_CH1_AVG_HIGH        5
> @@ -36,7 +36,7 @@
>  #define AD7150_CH2_TIMEOUT         13
>  #define AD7150_CH2_SETUP           14
>  #define AD7150_CFG                 15
> -#define AD7150_CFG_FIX             (1 << 7)
> +#define AD7150_CFG_FIX             BIT(7)
>  #define AD7150_PD_TIMER            16
>  #define AD7150_CH1_CAPDAC          17
>  #define AD7150_CH2_CAPDAC          18
> 

