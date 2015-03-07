Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58631 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbbCGTFZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Mar 2015 14:05:25 -0500
Message-ID: <54FB4BF1.3050102@kernel.org>
Date: Sat, 07 Mar 2015 19:05:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Harald Geyer <harald@ccbib.org>,
	John Stultz <john.stultz@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
CC: linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 2/3] iio: Provide new API to get the current resolution
 of timestamps
References: <1425329766-14703-1-git-send-email-harald@ccbib.org> <1425329766-14703-3-git-send-email-harald@ccbib.org>
In-Reply-To: <1425329766-14703-3-git-send-email-harald@ccbib.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/03/15 20:56, Harald Geyer wrote:
> Signed-off-by: Harald Geyer <harald@ccbib.org>
This use of the iio_get_timestamp call is very driver
specific. I'd be tempted not to wrap it at all and
to call your ktime_get_resolution_ns directly in the driver.
Arguably, don't use the wrapper on the timestamp either
as the intent of that is to provide a consistent way
of getting times that are reported to userspace via the
iio chrdevs.  I'm not entirely sure why a wrapper made
sense a long time ago for that use either though!

Jonathan
> ---
>  include/linux/iio/iio.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 80d8550..2d352a0 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -286,6 +286,11 @@ static inline s64 iio_get_time_ns(void)
>  	return ktime_get_real_ns();
>  }
>  
> +static inline u32 iio_get_time_resolution_ns(void)
> +{
> +	return ktime_get_resolution_ns();
> +}
> +
>  /* Device operating modes */
>  #define INDIO_DIRECT_MODE		0x01
>  #define INDIO_BUFFER_TRIGGERED		0x02
> 

