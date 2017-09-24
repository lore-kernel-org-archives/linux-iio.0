Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752138AbdIXNMU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Sep 2017 09:12:20 -0400
Date: Sun, 24 Sep 2017 14:12:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Harinath Nampally <harinath922@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, amsfield22@gmail.com,
        martink@posteo.de
Subject: Re: [PATCH 1/2] iio: accel: mma8452: Fix code style warning
Message-ID: <20170924141215.37066dff@archlinux>
In-Reply-To: <1506200190-11115-2-git-send-email-harinath922@gmail.com>
References: <1506200190-11115-1-git-send-email-harinath922@gmail.com>
        <1506200190-11115-2-git-send-email-harinath922@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 23 Sep 2017 16:56:29 -0400
Harinath Nampally <harinath922@gmail.com> wrote:

> Replace symbolic permissions with octal permissions
> to improve code readability.
> 
> Issue found by checkpatch.
> 
> Signed-off-by: Harinath Nampally <harinath922@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/mma8452.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index c352555..4a33a26 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -418,11 +418,11 @@ static ssize_t mma8452_show_os_ratio_avail(struct device *dev,
>  }
>  
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(mma8452_show_samp_freq_avail);
> -static IIO_DEVICE_ATTR(in_accel_scale_available, S_IRUGO,
> +static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
>  		       mma8452_show_scale_avail, NULL, 0);
>  static IIO_DEVICE_ATTR(in_accel_filter_high_pass_3db_frequency_available,
> -		       S_IRUGO, mma8452_show_hp_cutoff_avail, NULL, 0);
> -static IIO_DEVICE_ATTR(in_accel_oversampling_ratio_available, S_IRUGO,
> +		       0444, mma8452_show_hp_cutoff_avail, NULL, 0);
> +static IIO_DEVICE_ATTR(in_accel_oversampling_ratio_available, 0444,
>  		       mma8452_show_os_ratio_avail, NULL, 0);
>  
>  static int mma8452_get_samp_freq_index(struct mma8452_data *data,

