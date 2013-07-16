Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47803 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589Ab3GPQ55 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 12:57:57 -0400
Message-ID: <51E57B95.1090909@kernel.org>
Date: Tue, 16 Jul 2013 17:57:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: Remove IIO_DEV_ATTR_RESET macro
References: <1373987283-32657-1-git-send-email-lars@metafoo.de> <1373987283-32657-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1373987283-32657-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/16/2013 04:08 PM, Lars-Peter Clausen wrote:
> There are no users of this macro left and we have come to the conclusion that it
> is not a good idea to expose the raw chip reset to userspace so the macro is
> very unlikely to be used in new drivers.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git.

Glad to see this one go.

Thanks,

Jonathan
> ---
>  include/linux/iio/sysfs.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
> index b7a934b..2958c96 100644
> --- a/include/linux/iio/sysfs.h
> +++ b/include/linux/iio/sysfs.h
> @@ -73,11 +73,6 @@ struct iio_const_attr {
>  	    .dev_attr = __ATTR(_name, S_IRUGO, iio_read_const_attr, NULL)}
>  
>  /* Generic attributes of onetype or another */
> -/**
> - * IIO_DEV_ATTR_RESET: resets the device
> - **/
> -#define IIO_DEV_ATTR_RESET(_store)			\
> -	IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, _store, 0)
>  
>  /**
>   * IIO_DEV_ATTR_SAMP_FREQ - sets any internal clock frequency
> 
