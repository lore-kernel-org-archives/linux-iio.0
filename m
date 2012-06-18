Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41577 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab2FRHim (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jun 2012 03:38:42 -0400
Message-ID: <4FDEDB00.2080406@kernel.org>
Date: Mon, 18 Jun 2012 08:38:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: correct documentation for IIO_CONST_ATTR_SAMP_FREQ_AVAIL,
 match name of #define
References: <1339952599-22105-1-git-send-email-pmeerw@pmeerw.net> <1339952599-22105-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339952599-22105-5-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/17/2012 6:03 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   include/linux/iio/sysfs.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
> index bfedb73..b7a934b 100644
> --- a/include/linux/iio/sysfs.h
> +++ b/include/linux/iio/sysfs.h
> @@ -97,7 +97,7 @@ struct iio_const_attr {
>   #define IIO_DEV_ATTR_SAMP_FREQ_AVAIL(_show)				\
>   	IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO, _show, NULL, 0)
>   /**
> - * IIO_CONST_ATTR_AVAIL_SAMP_FREQ - list available sampling frequencies
> + * IIO_CONST_ATTR_SAMP_FREQ_AVAIL - list available sampling frequencies
>    * @_string: frequency string for the attribute
>    *
>    * Constant version

