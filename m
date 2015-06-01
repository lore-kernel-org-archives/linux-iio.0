Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35767 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbbFAVRE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:17:04 -0400
Message-ID: <556C0E33.9050206@kernel.org>
Date: Mon, 01 Jun 2015 08:48:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Laurent Navet <laurent.navet@gmail.com>
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: remove unneeded test
References: <1433018136-7108-1-git-send-email-laurent.navet@gmail.com>
In-Reply-To: <1433018136-7108-1-git-send-email-laurent.navet@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/05/15 21:35, Laurent Navet wrote:
> The same code is executed regardless ret value, so this test
> can be removed.
> Also fix coverity scan CID 1268786.
> 
> Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
Applied to the togreg branch of iio.git.  Will push out
as testing when not stuck in a cleanroom with no net access
(but curiously with my less than entirely clean laptop ;)

Jonathan
> ---
>  drivers/iio/industrialio-buffer.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index df919f4..e7fbcce 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -806,8 +806,6 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
>  		ret = __iio_update_buffers(indio_dev,
>  					 NULL, indio_dev->buffer);
>  
> -	if (ret < 0)
> -		goto done;
>  done:
>  	mutex_unlock(&indio_dev->mlock);
>  	return (ret < 0) ? ret : len;
> 

