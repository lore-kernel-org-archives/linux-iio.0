Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:50120 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab1JUK7y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2011 06:59:54 -0400
Message-ID: <4EA150B1.8020404@cam.ac.uk>
Date: Fri, 21 Oct 2011 12:00:01 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 1/2] staging:iio: Add missing ioctl.h include to events.h
References: <4EA14C87.2020606@metafoo.de> <1319194778-7153-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1319194778-7153-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/21/11 11:59, Lars-Peter Clausen wrote:
> We need ioctl.h for _IOR.
Thanks, will merge in to V2 of that patch.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> Followup to "staging:iio: header reorganization". Based on linux-iio/master
> ---
>  drivers/staging/iio/events.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
> index 6867894..fbc198e 100644
> --- a/drivers/staging/iio/events.h
> +++ b/drivers/staging/iio/events.h
> @@ -11,6 +11,8 @@
>  #ifndef _IIO_EVENTS_H_
>  #define _IIO_EVENTS_H_
>  
> +#include <linux/ioctl.h>
> +
>  /**
>   * struct iio_event_data - The actual event being pushed to userspace
>   * @id:		event identifier

