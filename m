Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59280 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946068AbbHHQUk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 12:20:40 -0400
Subject: Re: [PATCH] iio: event: Remove negative error code from
 iio_event_poll
To: Cristina Opriceana <cristina.opriceana@gmail.com>
References: <3a7c7c8ea195b6bb8b6972a22a487d870b2faec0.1438595639.git.cristina.opriceana@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C62C56.2030406@kernel.org>
Date: Sat, 8 Aug 2015 17:20:38 +0100
MIME-Version: 1.0
In-Reply-To: <3a7c7c8ea195b6bb8b6972a22a487d870b2faec0.1438595639.git.cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/08/15 11:00, Cristina Opriceana wrote:
> Negative return values are not supported by iio_event_poll since
> its return type is unsigned int.
> 
> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
As with the other one, the docs aren't yet there in the fixes tree where
I have applied this (by hand).  I've also added the fixes line and
marked it for stable.

Could you resend the docs updates after that patch has worked it's
way through to the togreg branch of iio.git

(I'll try and remember this as well!)

Thanks,

Jonathan
> ---
>  drivers/iio/industrialio-event.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index b2f63f9..eb44dab 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -80,7 +80,7 @@ EXPORT_SYMBOL(iio_push_event);
>   * @wait:	Poll table pointer to add the wait queue on
>   *
>   * Return: (POLLIN | POLLRDNORM) if data is available for reading
> - *	   or a negative error code on failure
> + *	   or 0 on failure
>   */
>  static unsigned int iio_event_poll(struct file *filep,
>  			     struct poll_table_struct *wait)
> @@ -90,7 +90,7 @@ static unsigned int iio_event_poll(struct file *filep,
>  	unsigned int events = 0;
>  
>  	if (!indio_dev->info)
> -		return -ENODEV;
> +		return events;
>  
>  	poll_wait(filep, &ev_int->wait, wait);
>  
> 

