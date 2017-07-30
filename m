Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754222AbdG3RB1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 30 Jul 2017 13:01:27 -0400
Date: Sun, 30 Jul 2017 18:01:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v3 05/11] iio: adc: ti-ads1015: don't return invalid
 value from buffer setup callbacks
Message-ID: <20170730180123.6984ffd2@kernel.org>
In-Reply-To: <1501427575-31045-6-git-send-email-akinobu.mita@gmail.com>
References: <1501427575-31045-1-git-send-email-akinobu.mita@gmail.com>
        <1501427575-31045-6-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 31 Jul 2017 00:12:49 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> pm_runtime_get_sync() and pm_runtime_put_autosuspend() return 0 on
> success, 1 if the device's runtime PM status was already requested status
> or error code on failure.  So a positive return value doesn't indicate an
> error condition.
> 
> However, any non-zero return values from buffer preenable and postdisable
> callbacks are recognized as an error and this driver reuses the return
> value from pm_runtime_get_sync() and pm_runtime_put_autosuspend() in
> these callbacks.  This change fixes the false error detections.
> 
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Applied to the fixes-togreg branch of iio.git marked for
stable.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ti-ads1015.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 8905f0d..1c475e2 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -235,7 +235,7 @@ static int ads1015_set_power_state(struct ads1015_data *data, bool on)
>  		ret = pm_runtime_put_autosuspend(dev);
>  	}
>  
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static

