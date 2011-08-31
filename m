Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:45035 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab1HaLLW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 31 Aug 2011 07:11:22 -0400
Message-ID: <4E5E18C8.9000306@cam.ac.uk>
Date: Wed, 31 Aug 2011 12:19:36 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 03/12] iio: ad7291: Fix AD7291_T_SENSE_MASK
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com> <1314788260-5791-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314788260-5791-3-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/31/11 11:57, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> AD7291_T_SENSE_MASK must set bit-7.
> Change definition style.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Merged
> ---
>  drivers/staging/iio/adc/ad7291.c |   28 ++++++++++++++--------------
>  1 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
> index d47df4a..dda6bcb 100644
> --- a/drivers/staging/iio/adc/ad7291.c
> +++ b/drivers/staging/iio/adc/ad7291.c
> @@ -37,30 +37,30 @@
>  #define AD7291_T_AVERAGE		3
>  #define AD7291_VOLTAGE_LIMIT_BASE	4
>  #define AD7291_VOLTAGE_LIMIT_COUNT	8
> -#define AD7291_T_SENSE_HIGH		0x1c
> -#define AD7291_T_SENSE_LOW		0x1d
> -#define AD7291_T_SENSE_HYST		0x1e
> -#define AD7291_VOLTAGE_ALERT_STATUS	0x1f
> +#define AD7291_T_SENSE_HIGH		0x1C
> +#define AD7291_T_SENSE_LOW		0x1D
> +#define AD7291_T_SENSE_HYST		0x1E
> +#define AD7291_VOLTAGE_ALERT_STATUS	0x1F
>  #define AD7291_T_ALERT_STATUS		0x20
>  
>  /*
>   * AD7291 command
>   */
> -#define AD7291_AUTOCYCLE		0x1
> -#define AD7291_RESET			0x2
> -#define AD7291_ALERT_CLEAR		0x4
> -#define AD7291_ALERT_POLARITY		0x8
> -#define AD7291_EXT_REF			0x10
> -#define AD7291_NOISE_DELAY		0x20
> -#define AD7291_T_SENSE_MASK		0x40
> -#define AD7291_VOLTAGE_MASK		0xff00
> +#define AD7291_AUTOCYCLE		(1 << 0)
> +#define AD7291_RESET			(1 << 1)
> +#define AD7291_ALERT_CLEAR		(1 << 2)
> +#define AD7291_ALERT_POLARITY		(1 << 3)
> +#define AD7291_EXT_REF			(1 << 4)
> +#define AD7291_NOISE_DELAY		(1 << 5)
> +#define AD7291_T_SENSE_MASK		(1 << 7)
> +#define AD7291_VOLTAGE_MASK		0xFF00
>  #define AD7291_VOLTAGE_OFFSET		0x8
>  
>  /*
>   * AD7291 value masks
>   */
> -#define AD7291_CHANNEL_MASK		0xf000
> -#define AD7291_VALUE_MASK		0xfff
> +#define AD7291_CHANNEL_MASK		0xF000
> +#define AD7291_VALUE_MASK		0xFFF
>  #define AD7291_T_VALUE_SIGN		0x400
>  #define AD7291_T_VALUE_FLOAT_OFFSET	2
>  #define AD7291_T_VALUE_FLOAT_MASK	0x2

