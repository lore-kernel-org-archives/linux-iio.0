Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49984 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851AbbITKxc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Sep 2015 06:53:32 -0400
Subject: Re: [RESEND PATCH 2/4] iio: percolate error if event fd fails
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1442303365-11811-1-git-send-email-linus.walleij@linaro.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55FE9029.9000302@kernel.org>
Date: Sun, 20 Sep 2015 11:53:29 +0100
MIME-Version: 1.0
In-Reply-To: <1442303365-11811-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/09/15 08:49, Linus Walleij wrote:
> This makes the error from iio_event_getfd() percolate up
> to userspace properly so we can know for sure there is no
> events on this device (-ENODEV returned). Before this patch
> we would bail out looking for the unsupported evens on the
> erroneous (negative) file descriptor.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Hi Linus,

I applied this one a while back - will be going upstream to Greg shortly.
Got delayed I think by just missing the merge window close.

Jonathan
> ---
>  drivers/iio/industrialio-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index b3fcc2c449d8..b347524d1b6d 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1153,6 +1153,8 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  
>  	if (cmd == IIO_GET_EVENT_FD_IOCTL) {
>  		fd = iio_event_getfd(indio_dev);
> +		if (fd < 0)
> +			return fd;
>  		if (copy_to_user(ip, &fd, sizeof(fd)))
>  			return -EFAULT;
>  		return 0;
> 

