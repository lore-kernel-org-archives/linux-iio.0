Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:51650 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203AbbGXTKx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 24 Jul 2015 15:10:53 -0400
Message-ID: <55B28DB7.3050906@gmx.de>
Date: Fri, 24 Jul 2015 21:10:47 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Joo Aun Saw <jasaw@dius.com.au>, linux-iio@vger.kernel.org
CC: jic23@kernel.org
Subject: Re: [PATCH 1/2] tools: iio: Set caller's ci_array pointer to
 NULL after free
References: <1437751409-28837-1-git-send-email-jasaw@dius.com.au> <1437751409-28837-2-git-send-email-jasaw@dius.com.au>
In-Reply-To: <1437751409-28837-2-git-send-email-jasaw@dius.com.au>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Joo Aun Saw schrieb am 24.07.2015 um 17:23:
> From: Joo Aun Saw <jasaw@dius.com.au>
> 
> On error, caller's ci_array is freed and set to NULL to avoid
> potential double free. Counter is reset to zero for consistency.
> 

Hi,
I don't see a second attempt to free the array. In here, just dp gets
closed and the scan_el_dir string freed.
And in generic_buffer.c where it is accessed in the main function, there
is a jump into the error handler in case of an error, which just frees a
few strings (datardytrigger, trigger_name and dev_dir_name).
Any opinion welcome.
Thanks,

Hartmut

> Signed-off-by: Joo Aun Saw <jasaw@dius.com.au>
> ---
>  tools/iio/iio_utils.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index 1dcdf03..8731905 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -529,6 +529,8 @@ error_cleanup_array:
>  		free((*ci_array)[i].generic_name);
>  	}
>  	free(*ci_array);
> +	*ci_array = NULL;
> +	*counter = 0;
>  error_close_dir:
>  	if (dp)
>  		if (closedir(dp) == -1)
> 

