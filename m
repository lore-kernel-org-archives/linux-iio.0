Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44275 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab3HDJC0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Aug 2013 05:02:26 -0400
Message-ID: <51FE26BA.8060709@kernel.org>
Date: Sun, 04 Aug 2013 11:02:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Shubhrajyoti Datta <shubhrajyoti@ti.com>
Subject: Re: [PATCH 2/9] staging:iio:hmc5843: Remove id register #defines,
 not used anymore
References: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net> <1374939112-18237-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1374939112-18237-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/27/13 16:31, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>
> ---
>  drivers/staging/iio/magnetometer/hmc5843.c | 3 ---
>  1 file changed, 3 deletions(-)
Applied to the togreg branch of iio.git

Thanks,
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index e5999d4..c281342 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -42,9 +42,6 @@
>  #define HMC5883_DATA_OUT_Y_MSB_REG		0x07
>  #define HMC5883_DATA_OUT_Y_LSB_REG		0x08
>  #define HMC5843_STATUS_REG			0x09
> -#define HMC5843_ID_REG_A			0x0A
> -#define HMC5843_ID_REG_B			0x0B
> -#define HMC5843_ID_REG_C			0x0C
>  
>  enum hmc5843_ids {
>  	HMC5843_ID,
> 
