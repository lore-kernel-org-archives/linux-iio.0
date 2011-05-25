Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:36344 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112Ab1EYMpo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 May 2011 08:45:44 -0400
Message-ID: <4DDCFAA9.6010101@cam.ac.uk>
Date: Wed, 25 May 2011 13:48:41 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] iio: industrialio-trigger: set iio_poll_func private_data
References: <1306319952-24722-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1306319952-24722-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/25/11 11:39, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Failure to set iio_poll_func private_data, causes zero pointer access
> violations in all consumer trigger handlers.
Yikes.  Good spot. Not one of my better bits of refactoring.  Strange
thing is I could have sworn I tested that, but it clearly won't work
without your fix..  
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/industrialio-trigger.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
> index 6159023..d504aa2 100644
> --- a/drivers/staging/iio/industrialio-trigger.c
> +++ b/drivers/staging/iio/industrialio-trigger.c
> @@ -294,6 +294,7 @@ struct iio_poll_func
>  	pf->h = h;
>  	pf->thread = thread;
>  	pf->type = type;
> +	pf->private_data = private;
>  
>  	return pf;
>  }

