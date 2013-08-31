Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42609 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab3HaRQP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Aug 2013 13:16:15 -0400
Message-ID: <522232F0.2020503@kernel.org>
Date: Sat, 31 Aug 2013 19:16:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Remove trailing ; from function definitions
References: <1377040517-11928-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1377040517-11928-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I thought we'd killed off all of these ages ago.

Good find and applied to iio.git togreg branch.
Our first patch for the 3.13 cycle.

On 08/21/13 00:15, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>  include/linux/iio/iio.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 45a99ef..c8e94a8 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -458,7 +458,7 @@ static inline void iio_device_put(struct iio_dev *indio_dev)
>  {
>  	if (indio_dev)
>  		put_device(&indio_dev->dev);
> -};
> +}
>  
>  /**
>   * dev_to_iio_dev() - Get IIO device struct from a device struct
> @@ -565,7 +565,7 @@ static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
>  {
>  	return indio_dev->currentmode
>  		& (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE);
> -};
> +}
>  
>  /**
>   * iio_get_debugfs_dentry() - helper function to get the debugfs_dentry
> @@ -575,12 +575,12 @@ static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
>  static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
>  {
>  	return indio_dev->debugfs_dentry;
> -};
> +}
>  #else
>  static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
>  {
>  	return NULL;
> -};
> +}
>  #endif
>  
>  int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
> 
