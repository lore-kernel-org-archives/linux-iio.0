Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-228.synserver.de ([212.40.185.228]:1391 "HELO
	smtp-out-225.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1752465Ab1J0JBu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 27 Oct 2011 05:01:50 -0400
Message-ID: <4EA91E21.8080705@metafoo.de>
Date: Thu, 27 Oct 2011 11:02:25 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 2/3] staging:iio: IIO_EVENT_CODE: Clamp channel numbers
References: <1319705074-3082-1-git-send-email-lars@metafoo.de> <1319705074-3082-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1319705074-3082-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/27/2011 10:44 AM, Lars-Peter Clausen wrote:
> Make sure we only use the allotted space for channel numbers in the event mask
> and do not let them override other fields.
> 
> Since negative values are valid channel number, cast the channel number to
> signed when extracting it from an event mask.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/staging/iio/events.h |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
> index 7cf9306..fc2b7e5 100644
> --- a/drivers/staging/iio/events.h
> +++ b/drivers/staging/iio/events.h
> @@ -56,7 +56,8 @@ enum iio_event_direction {
>  		       type, chan, chan1, chan2)			\
>  	(((u64)type << 56) | ((u64)diff << 55) |			\
>  	 ((u64)direction << 48) | ((u64)modifier << 40) |		\
> -	 ((u64)chan_type << 32) | (chan2 << 16) | chan1 | chan)
> +	 ((u64)chan_type << 32) | (((u16)chan2) << 16) | ((u16)chan1) | \
> +	 ((u16)chan))
>  
>  
>  #define IIO_EV_DIR_MAX 4
> @@ -95,7 +96,7 @@ enum iio_event_direction {
>  
>  /* Event code number extraction depends on which type of event we have.
>   * Perhaps review this function in the future*/
> -#define IIO_EVENT_CODE_EXTRACT_NUM(mask) (mask & 0xFFFF)
> +#define IIO_EVENT_CODE_EXTRACT_NUM(mask) ((s16)(mask & 0xFFFF))
>  

Since we want to use it in userspace this should obviously be __s16, sorry.
Will fix this before sending the patch on.
