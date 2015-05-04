Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22003 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbbEDJNf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 4 May 2015 05:13:35 -0400
Date: Mon, 4 May 2015 12:13:33 +0300
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:prox:sx9500 trivial simplification of return path in
 init function.
Message-ID: <20150504091332.GB31334@vdogaru>
References: <1430562582-27932-1-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430562582-27932-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, May 02, 2015 at 11:29:42AM +0100, Jonathan Cameron wrote:
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Cc: Vlad Dogaru <vlad.dogaru@intel.com>
> ---
>  drivers/iio/proximity/sx9500.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Not sure if changes like this need a review, but this looks good to me.

> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index f1e9d734b6b6..323de9510ba5 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -860,10 +860,8 @@ static int sx9500_init_device(struct iio_dev *indio_dev)
>  	}
>  
>  	ret = sx9500_init_compensation(indio_dev);
> -	if (ret < 0)
> -		return ret;
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static void sx9500_gpio_probe(struct i2c_client *client,
> -- 
> 2.3.5
> 
