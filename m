Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37783 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbaARLJl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jan 2014 06:09:41 -0500
Message-ID: <52DA6104.4050405@kernel.org>
Date: Sat, 18 Jan 2014 11:09:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/6] staging:iio:accel:sca3000: Channels missing in temp_output
 case
References: <1389648514-31429-1-git-send-email-pmeerw@pmeerw.net> <1389648514-31429-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389648514-31429-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 13/01/14 21:28, Peter Meerwald wrote:
> issues introduced here 25888dc5,
> staging:iio:sca3000 extract old event handling and move to poll for events
>
Ouch
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

> ---
>   drivers/staging/iio/accel/sca3000_core.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index 159272e..0123bc0 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -1170,11 +1170,10 @@ static int sca3000_probe(struct spi_device *spi)
>   	indio_dev->name = spi_get_device_id(spi)->name;
>   	if (st->info->temp_output)
>   		indio_dev->info = &sca3000_info_with_temp;
> -	else {
> +	else
>   		indio_dev->info = &sca3000_info;
> -		indio_dev->channels = sca3000_channels;
> -		indio_dev->num_channels = ARRAY_SIZE(sca3000_channels);
> -	}
> +	indio_dev->channels = sca3000_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(sca3000_channels);
>   	indio_dev->modes = INDIO_DIRECT_MODE;
>
>   	sca3000_configure_ring(indio_dev);
>
