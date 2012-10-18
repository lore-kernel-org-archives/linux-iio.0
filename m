Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51700 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914Ab2JSFaF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Oct 2012 01:30:05 -0400
Message-ID: <507FC48B.6030803@kernel.org>
Date: Thu, 18 Oct 2012 09:57:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	drivers@analog.com
Subject: Re: [PATCH 01/11] iio: Add some helper macros for unit conversion
References: <1350293734-21951-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1350293734-21951-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/15/2012 10:35 AM, Lars-Peter Clausen wrote:
> Some datasheets use a different unit to specify the channel scale than what IIO
> expects it to be. This patch adds two helper macros which allow to convert units
> commonly used in datasheets to IIO units:
>
>  * acceleration: g -> meter / second**2
>  * angular velocity: degree (/ second) -> rad (/ second)
>
> This makes it much more convenient to specify and also easier to verify a
> channel's scale attribute.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Good idea applied to togreg branch of iio.git (or at least will
be when I get home from travelling).

> ---
>  include/linux/iio/iio.h |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index c0ae76a..7806c24 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -618,4 +618,20 @@ static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
>  };
>  #endif
>
> +/**
> + * IIO_DEGREE_TO_RAD() - Convert degree to rad
> + * @deg: A value in degree
> + *
> + * Returns the given value converted from degree to rad
> + */
> +#define IIO_DEGREE_TO_RAD(deg) (((deg) * 314159ULL + 9000000ULL) / 18000000ULL)
> +
> +/**
> + * IIO_G_TO_M_S_2() - Convert g to meter / second**2
> + * @g: A value in g
> + *
> + * Returns the given value converted from g to meter / second**2
> + */
> +#define IIO_G_TO_M_S_2(g) ((g) * 980665ULL / 100000ULL)
> +
>  #endif /* _INDUSTRIAL_IO_H_ */
>
