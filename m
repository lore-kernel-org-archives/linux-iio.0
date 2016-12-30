Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53157 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752859AbcL3UW2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 15:22:28 -0500
Subject: Re: [PATCH] iio: max44000: correct value in
 illuminance_integration_time_available
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-iio@vger.kernel.org
References: <1482945396-18604-1-git-send-email-akinobu.mita@gmail.com>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2c45861e-e813-624f-03f8-88b0bc95e60d@kernel.org>
Date: Fri, 30 Dec 2016 20:22:26 +0000
MIME-Version: 1.0
In-Reply-To: <1482945396-18604-1-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/12/16 17:16, Akinobu Mita wrote:
> According to the datasheet, the shortest available integration time for
> ALS ADC conversion is 1.5625ms but illuminance_integration_time_available
> sysfs file shows wrong value.
> 
> Cc: Crestez Dan Leonard <leonard.crestez@intel.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Good find.  Applied to the fixes-togreg-post-rc1 branch of iio.git
and marked for stable with a fixes tag added.  It might apply cleanly
along the way, but the original bug was quite a few patches back.

Jonathan
> ---
>  drivers/iio/light/max44000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
> index a144ca3..81bd8e8 100644
> --- a/drivers/iio/light/max44000.c
> +++ b/drivers/iio/light/max44000.c
> @@ -113,7 +113,7 @@ static const char max44000_int_time_avail_str[] =
>  	"0.100 "
>  	"0.025 "
>  	"0.00625 "
> -	"0.001625";
> +	"0.0015625";
>  
>  /* Available scales (internal to ulux) with pretty manual alignment: */
>  static const int max44000_scale_avail_ulux_array[] = {
> 

