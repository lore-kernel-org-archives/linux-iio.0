Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:34892 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754246Ab1JULjr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2011 07:39:47 -0400
Message-ID: <4EA15A09.3050109@cam.ac.uk>
Date: Fri, 21 Oct 2011 12:39:53 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 2/2] staging:iio: Use userspace types for iio_event_data
References: <4EA14C87.2020606@metafoo.de> <1319194778-7153-1-git-send-email-lars@metafoo.de> <1319194778-7153-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1319194778-7153-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/21/11 11:59, Lars-Peter Clausen wrote:
> Since we want to export struct iio_event_data to userspace use the userspace
> integer types. Also add a include to linux/types.h.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Will add to the series doing reorganization.

Thanks,
> ---
> Followup to "staging:iio: header reorganization". Based on linux-iio/master
> ---
>  drivers/staging/iio/events.h |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
> index fbc198e..d1f946e 100644
> --- a/drivers/staging/iio/events.h
> +++ b/drivers/staging/iio/events.h
> @@ -12,6 +12,7 @@
>  #define _IIO_EVENTS_H_
>  
>  #include <linux/ioctl.h>
> +#include <linux/types.h>
>  
>  /**
>   * struct iio_event_data - The actual event being pushed to userspace
> @@ -20,8 +21,8 @@
>   *		the interrupt handler)
>   */
>  struct iio_event_data {
> -	u64	id;
> -	s64	timestamp;
> +	__u64	id;
> +	__s64	timestamp;
>  };
>  
>  #define IIO_GET_EVENT_FD_IOCTL _IOR('i', 0x90, int)

