Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47334 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbaAKLv6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jan 2014 06:51:58 -0500
Message-ID: <52D13067.7080404@kernel.org>
Date: Sat, 11 Jan 2014 11:52:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: Remove obsolete variable in adjd_s311 driver
References: <1389133774-28091-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389133774-28091-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 07/01/14 22:29, Peter Meerwald wrote:
> len variable become obsolete with
> iio_push_to_buffers_with_timestamp()
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git.

Thanks
> ---
>   drivers/iio/light/adjd_s311.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
> index f306847..1d8ecb7 100644
> --- a/drivers/iio/light/adjd_s311.c
> +++ b/drivers/iio/light/adjd_s311.c
> @@ -120,7 +120,6 @@ static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
>   	struct iio_dev *indio_dev = pf->indio_dev;
>   	struct adjd_s311_data *data = iio_priv(indio_dev);
>   	s64 time_ns = iio_get_time_ns();
> -	int len = 0;
>   	int i, j = 0;
>
>   	int ret = adjd_s311_req_data(indio_dev);
> @@ -135,7 +134,6 @@ static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
>   			goto done;
>
>   		data->buffer[j++] = ret & ADJD_S311_DATA_MASK;
> -		len += 2;
>   	}
>
>   	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer, time_ns);
>
