Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45446 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab3IRRvK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2013 13:51:10 -0400
Message-ID: <5239F62E.2070104@kernel.org>
Date: Wed, 18 Sep 2013 19:51:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lukasz Czerwinski <l.czerwinski@samsung.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: iio_device_add_event_sysfs() bugfix
References: <1379496100-27649-1-git-send-email-l.czerwinski@samsung.com>
In-Reply-To: <1379496100-27649-1-git-send-email-l.czerwinski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/18/13 10:21, Lukasz Czerwinski wrote:
> Fix mask generation for modified channels.
> 
> Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
Applied to the fixes-togreg branch of iio.git.

Thanks for doing this!

Jonathan
> ---
>  drivers/iio/industrialio-event.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 10aa9ef..f146acd 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -276,7 +276,7 @@ static int iio_device_add_event_sysfs(struct iio_dev *indio_dev,
>  			goto error_ret;
>  		}
>  		if (chan->modified)
> -			mask = IIO_MOD_EVENT_CODE(chan->type, 0, chan->channel,
> +			mask = IIO_MOD_EVENT_CODE(chan->type, 0, chan->channel2,
>  						  i/IIO_EV_DIR_MAX,
>  						  i%IIO_EV_DIR_MAX);
>  		else if (chan->differential)
> 
