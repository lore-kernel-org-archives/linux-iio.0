Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbeIVPR0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Sep 2018 11:17:26 -0400
Date: Sat, 22 Sep 2018 10:24:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Song Qiang <songqiang1304521@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        shubhrajyoti@ti.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: hmc5843: Fixed a comment error.
Message-ID: <20180922102428.7c92ccaf@archlinux>
In-Reply-To: <20180920134946.9072-1-songqiang1304521@gmail.com>
References: <20180920134946.9072-1-songqiang1304521@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 20 Sep 2018 21:49:46 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> Replace 'hcm5843' with 'hmc5843'.
> 
> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to ignore (because there will be other things
in there that they won't later today :)

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/hmc5843.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/hmc5843.h b/drivers/iio/magnetometer/hmc5843.h
> index 76a5d7484d8d..a75224cf99df 100644
> --- a/drivers/iio/magnetometer/hmc5843.h
> +++ b/drivers/iio/magnetometer/hmc5843.h
> @@ -31,7 +31,7 @@ enum hmc5843_ids {
>  };
>  
>  /**
> - * struct hcm5843_data	- device specific data
> + * struct hmc5843_data	- device specific data
>   * @dev:		actual device
>   * @lock:		update and read regmap data
>   * @regmap:		hardware access register maps
