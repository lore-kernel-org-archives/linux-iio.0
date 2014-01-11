Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47345 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbaAKLwO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jan 2014 06:52:14 -0500
Message-ID: <52D13078.6040106@kernel.org>
Date: Sat, 11 Jan 2014 11:52:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: Remove obsolete variable in tcs3472 driver
References: <1389133774-28091-1-git-send-email-pmeerw@pmeerw.net> <1389133774-28091-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389133774-28091-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 07/01/14 22:29, Peter Meerwald wrote:
> len variable became obsolete with
> iio_push_to_buffers_with_timestamp()
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git.

Thanks,

> ---
>   drivers/iio/light/tcs3472.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> index 887fecf..fe063a0 100644
> --- a/drivers/iio/light/tcs3472.c
> +++ b/drivers/iio/light/tcs3472.c
> @@ -179,7 +179,6 @@ static irqreturn_t tcs3472_trigger_handler(int irq, void *p)
>   	struct iio_poll_func *pf = p;
>   	struct iio_dev *indio_dev = pf->indio_dev;
>   	struct tcs3472_data *data = iio_priv(indio_dev);
> -	int len = 0;
>   	int i, j = 0;
>
>   	int ret = tcs3472_req_data(data);
> @@ -194,7 +193,6 @@ static irqreturn_t tcs3472_trigger_handler(int irq, void *p)
>   			goto done;
>
>   		data->buffer[j++] = ret;
> -		len += 2;
>   	}
>
>   	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>
