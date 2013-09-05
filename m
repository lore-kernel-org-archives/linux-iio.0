Return-Path: <lars@metafoo.de>
Message-ID: <5228DA76.8080101@metafoo.de>
Date: Thu, 05 Sep 2013 21:24:38 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: refactor info mask and ext_info attribute creation.
References: <1376841012-7542-1-git-send-email-jic23@kernel.org> <1376841012-7542-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1376841012-7542-3-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

[...]
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index cdb034d..ad59fee 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -38,6 +38,9 @@ enum iio_chan_info_enum {
>   	IIO_CHAN_INFO_HYSTERESIS,
>   };
>
> +enum iio_shared_by { IIO_SEPARATE,
> +		     IIO_SHARED_BY_TYPE };
> +

That's not kernel style formating, is it?

enum iio_shared_by {
	IIO_SEPARATE,
	IIO_SHARED_BY_TYPE,
};

... looks much better in my opinion

[...]
