Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46183 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbbEGXdm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2015 19:33:42 -0400
Message-ID: <554BE954.6030001@kernel.org>
Date: Thu, 07 May 2015 23:38:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: kfifo: Set update_needed to false only if a buffer
 was allocated
References: <1430569876-31428-1-git-send-email-gabriele.mzt@gmail.com>
In-Reply-To: <1430569876-31428-1-git-send-email-gabriele.mzt@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/15 13:31, Gabriele Mazzotta wrote:
> Check whether the allocation of a new kfifo buffer failed or not before
> setting the update_needed flag to false. This will make
> iio_request_update_kfifo() try to allocate a new buffer the next time a
> buffer update is requested.
> 
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Applied to the fixes to greg branch of iio.git

The way things are going right now, I might actually get time to
push this out on Saturday.... Which is more than I expected this
morning.

J
> ---
>  drivers/iio/kfifo_buf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
> index 847ca56..55c267b 100644
> --- a/drivers/iio/kfifo_buf.c
> +++ b/drivers/iio/kfifo_buf.c
> @@ -38,7 +38,8 @@ static int iio_request_update_kfifo(struct iio_buffer *r)
>  		kfifo_free(&buf->kf);
>  		ret = __iio_allocate_kfifo(buf, buf->buffer.bytes_per_datum,
>  				   buf->buffer.length);
> -		buf->update_needed = false;
> +		if (ret >= 0)
> +			buf->update_needed = false;
>  	} else {
>  		kfifo_reset_out(&buf->kf);
>  	}
> 

