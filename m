Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51463 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab3FDSDk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2013 14:03:40 -0400
Message-ID: <51AE2BF3.5080906@kernel.org>
Date: Tue, 04 Jun 2013 19:03:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, Lars-Peter.Clausen@analog.com,
	dan.carpenter@oracle.com
Subject: Re: [PATCH RESEND V2 2/4] iio: frequency: adf4350: cast value to
 unsigned to make code checkers happy
References: <1370266249-26338-1-git-send-email-michael.hennerich@analog.com> <1370266249-26338-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1370266249-26338-2-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/03/2013 02:30 PM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Applied to the togreg branch of iio.git.
> ---
>  include/linux/iio/frequency/adf4350.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/iio/frequency/adf4350.h b/include/linux/iio/frequency/adf4350.h
> index be91f34..ffd8c8f 100644
> --- a/include/linux/iio/frequency/adf4350.h
> +++ b/include/linux/iio/frequency/adf4350.h
> @@ -1,7 +1,7 @@
>  /*
>   * ADF4350/ADF4351 SPI PLL driver
>   *
> - * Copyright 2012 Analog Devices Inc.
> + * Copyright 2012-2013 Analog Devices Inc.
>   *
>   * Licensed under the GPL-2.
>   */
> @@ -41,7 +41,7 @@
>  #define ADF4350_REG2_RDIV2_EN			(1 << 24)
>  #define ADF4350_REG2_RMULT2_EN			(1 << 25)
>  #define ADF4350_REG2_MUXOUT(x)			((x) << 26)
> -#define ADF4350_REG2_NOISE_MODE(x)		((x) << 29)
> +#define ADF4350_REG2_NOISE_MODE(x)		(((unsigned)(x)) << 29)
>  #define ADF4350_MUXOUT_THREESTATE		0
>  #define ADF4350_MUXOUT_DVDD			1
>  #define ADF4350_MUXOUT_GND			2
> 
