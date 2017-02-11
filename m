Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44958 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbdBKJru (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 04:47:50 -0500
Subject: Re: [PATCH 4/7] staging: iio: isl29028: use the runtime power
 management for system sleep
To: Brian Masney <masneyb@onstation.org>
References: <20170209015431.17380-1-masneyb@onstation.org>
 <20170209015431.17380-5-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f2298911-3fcd-f6ca-2af1-473fd5422cdd@kernel.org>
Date: Sat, 11 Feb 2017 09:47:48 +0000
MIME-Version: 1.0
In-Reply-To: <20170209015431.17380-5-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/02/17 01:54, Brian Masney wrote:
> With the introduction of runtime power management in commit 2db5054ac28d
> ("staging: iio: isl29028: add runtime power management support"), the
> system could go to sleep and turn off the device without notifying the
> runtime power management code. This patch changes the system suspend
> and resume to go through the runtime power management.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/isl29028.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index b63fdf70..ddd604d 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -656,7 +656,8 @@ static int __maybe_unused isl29028_resume(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops isl29028_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(isl29028_suspend, isl29028_resume)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
>  	SET_RUNTIME_PM_OPS(isl29028_suspend, isl29028_resume, NULL)
>  };
>  
> 

