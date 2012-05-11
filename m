Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:40182 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758854Ab2EKM1m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 May 2012 08:27:42 -0400
Message-ID: <4FAD05BA.4090701@cam.ac.uk>
Date: Fri, 11 May 2012 13:27:38 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio:dummy: Remove outdated comment
References: <1336737869-16186-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1336737869-16186-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/11/2012 1:04 PM, Lars-Peter Clausen wrote:
> iio_device_free has to be called regardless of whether the device has been
> registered or not when freeing it.
Good spot,
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/staging/iio/iio_simple_dummy.c |    2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
> index 3b4513c..3104119 100644
> --- a/drivers/staging/iio/iio_simple_dummy.c
> +++ b/drivers/staging/iio/iio_simple_dummy.c
> @@ -470,8 +470,6 @@ error_unconfigure_buffer:
>   error_unregister_events:
>   	iio_simple_dummy_events_unregister(indio_dev);
>   error_free_device:
> -	/* Note free device should only be called, before registration
> -	 * has succeeded. */
>   	iio_device_free(indio_dev);
>   error_ret:
>   	return ret;

