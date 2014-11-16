Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52117 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbaKPUY6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 16 Nov 2014 15:24:58 -0500
Message-ID: <54690818.2000700@kernel.org>
Date: Sun, 16 Nov 2014 20:24:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 3/4] iio: accel: bmc150: set low default thresholds
References: <1412998534-31971-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1412998534-31971-4-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1412998534-31971-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/10/14 04:35, Srinivas Pandruvada wrote:
> Set the threshold to low by default. With this thresholds any movement
> on the device with this sensor will generate event.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
This is a slightly odd one.  It's not technically a 'fix' but rather a
change of default behaviour.  I'll take the view the previous version
was not intuitive so this is preferred and apply it to the fixes-togreg
branch of iio.git.

Jonathan
> ---
>  drivers/iio/accel/bmc150-accel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> index c6df8ee..969cb21 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -95,9 +95,9 @@
>  #define BMC150_ACCEL_SLOPE_THRES_MASK		0xFF
>  
>  /* Slope duration in terms of number of samples */
> -#define BMC150_ACCEL_DEF_SLOPE_DURATION	2
> +#define BMC150_ACCEL_DEF_SLOPE_DURATION		1
>  /* in terms of multiples of g's/LSB, based on range */
> -#define BMC150_ACCEL_DEF_SLOPE_THRESHOLD	5
> +#define BMC150_ACCEL_DEF_SLOPE_THRESHOLD	1
>  
>  #define BMC150_ACCEL_REG_XOUT_L		0x02
>  
> 

