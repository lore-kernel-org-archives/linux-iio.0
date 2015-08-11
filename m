Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:54440 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950AbbHKSqf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 11 Aug 2015 14:46:35 -0400
Message-ID: <55CA4302.8080609@gmx.de>
Date: Tue, 11 Aug 2015 20:46:26 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: event_monitor: report unsupported events
References: <1439296478-19567-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1439296478-19567-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Linus Walleij schrieb am 11.08.2015 um 14:34:
> This makes the event monitor bail out with a helpful error
> message if a device does not support events, as a related
> fix to iio core now makes it return -ENODEV properly.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  tools/iio/iio_event_monitor.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index cd3fd41b481d..d51eb04202e9 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -284,7 +284,11 @@ int main(int argc, char **argv)
>  	ret = ioctl(fd, IIO_GET_EVENT_FD_IOCTL, &event_fd);
>  	if (ret == -1 || event_fd == -1) {
>  		ret = -errno;
> -		fprintf(stderr, "Failed to retrieve event fd\n");
> +		if (ret == -ENODEV)
> +			fprintf(stderr,
> +				"This device does not support events\n");
> +		else
> +			fprintf(stderr, "Failed to retrieve event fd\n");
>  		if (close(fd) == -1)
>  			perror("Failed to close character device file");
>  
> 

