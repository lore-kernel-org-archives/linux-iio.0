Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:56241 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752025AbaGLKvH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 12 Jul 2014 06:51:07 -0400
Message-ID: <53C11313.20803@gmx.de>
Date: Sat, 12 Jul 2014 12:50:59 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio: mma8452: Use correct acceleration units.
References: <20140711125431.22109.59659.stgit@localhost>
In-Reply-To: <20140711125431.22109.59659.stgit@localhost>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Martin Fuzzey schrieb:
> The userspace interface for acceleration sensors is documented as using
> m/s^2 units [Documentation/ABI/testing/sysfs-bus-iio]
>
> The fullscale raw value for the mma8452 (-2048) corresponds to -2G, -4G or -8G
> depending on the seleted mode.
>
> The scale table was converting to G rather than m/s^2.
> Change the scaling table to match the documented interface.
>
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> ---
>  drivers/iio/accel/mma8452.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 17aeea1..61eba5a 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -111,8 +111,13 @@ static const int mma8452_samp_freq[8][2] = {
>  	{6, 250000}, {1, 560000}
>  };
>  
The first line of the comment should just contain /*
> +/* Hardware has fullscale of -2G, -4G, -8G corresponding to raw value -2048
> + * The userspace interface uses m/s^2 and we declare micro units
> + * So scale factor is given by:
> + * 	g * N * 1000000 / 2048 for N = 2, 4, 8 and g=9.80665
> + */
>  static const int mma8452_scales[3][2] = {
> -	{0, 977}, {0, 1953}, {0, 3906}
> +	{0, 9577}, {0, 19154}, {0, 38307}
>  };
>  
>  static ssize_t mma8452_show_samp_freq_avail(struct device *dev,
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

