Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:60225 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752976AbbHDUHn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 4 Aug 2015 16:07:43 -0400
Message-ID: <55C11B86.3090401@gmx.de>
Date: Tue, 04 Aug 2015 22:07:34 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: lsiio: fix error code handling error
References: <1438698109-12356-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1438698109-12356-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Linus Walleij schrieb am 04.08.2015 um 16:21:
> commit acf50b3586f8d8a7530b905e111dda41876d38f4
> "tools:iio:lsiio: add error handling"
> introduced error handling of errors returned from
> read_sysfs_string(), but with a simple if (retval),
> missing the fact that these functions return a positive
> value if the read was successful.
> 
> As a result lsiio regresses and does not show any
> devices on my filesystem. Fix this by checking for
> only negative error codes.
> 
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  tools/iio/lsiio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/iio/lsiio.c b/tools/iio/lsiio.c
> index b59ee1733924..b2c028cc7cac 100644
> --- a/tools/iio/lsiio.c
> +++ b/tools/iio/lsiio.c
> @@ -70,7 +70,7 @@ static int dump_one_device(const char *dev_dir_name)
>  	if (retval != 1)
>  		return -EINVAL;
>  	retval = read_sysfs_string("name", dev_dir_name, name);
> -	if (retval)
> +	if (retval < 0)
>  		return retval;
>  
>  	printf("Device %03d: %s\n", dev_idx, name);
> @@ -91,7 +91,7 @@ static int dump_one_trigger(const char *dev_dir_name)
>  	if (retval != 1)
>  		return -EINVAL;
>  	retval = read_sysfs_string("name", dev_dir_name, name);
> -	if (retval)
> +	if (retval < 0)
>  		return retval;
>  
>  	printf("Trigger %03d: %s\n", dev_idx, name);
> 

