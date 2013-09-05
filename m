Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:64597 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756179Ab3IETEa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 5 Sep 2013 15:04:30 -0400
Message-ID: <5228D5E0.6070503@metafoo.de>
Date: Thu, 05 Sep 2013 21:05:04 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Move kernel-doc for iio_str_to_fixpoint() to iio.h
References: <1378170374-27598-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378170374-27598-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/2013 03:06 AM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

Usually the kernel-doc is kept with the implementation

> ---
>   drivers/iio/industrialio-core.c |   10 ----------
>   include/linux/iio/iio.h         |   11 +++++++++++
>   2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 2cb4841..b27c4b5 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -409,16 +409,6 @@ static ssize_t iio_read_channel_info(struct device *dev,
>   	}
>   }
>
> -/**
> - * iio_str_to_fixpoint() - Parse a fixed-point number from a string
> - * @str: The string to parse
> - * @fract_mult: Multiplier for the first decimal place, should be a power of 10
> - * @integer: The integer part of the number
> - * @fract: The fractional part of the number
> - *
> - * Returns 0 on success, or a negative error code if the string could not be
> - * parsed.
> - */
>   int iio_str_to_fixpoint(const char *str, int fract_mult,
>   	int *integer, int *fract)
>   {
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 01edd67..d12518e 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -612,6 +612,17 @@ static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
>   }
>   #endif
>
> +
> +/**
> + * iio_str_to_fixpoint() - Parse a fixed-point number from a string
> + * @str: The string to parse
> + * @fract_mult: Multiplier for the first decimal place, should be a power of 10
> + * @integer: The integer part of the number
> + * @fract: The fractional part of the number
> + *
> + * Returns 0 on success, or a negative error code if the string could not be
> + * parsed.
> + */
>   int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
>   	int *fract);
>
>

