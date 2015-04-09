Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52791 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbbDIOKi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 10:10:38 -0400
Message-ID: <5526885C.8090904@kernel.org>
Date: Thu, 09 Apr 2015 15:10:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?=
	<vianney.leclement@essensium.com>, linux-iio@vger.kernel.org
CC: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 5/5] iio: mlx90614: Check for errors in read values
References: <1427704502-22347-1-git-send-email-vianney.leclement@essensium.com> <1427704502-22347-6-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1427704502-22347-6-git-send-email-vianney.leclement@essensium.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/03/15 09:35, Vianney le Clément de Saint-Marcq wrote:
> The device uses the MSB of the returned temperature value as an error
> flag.  Return a read error when this bit is set.
> 
> Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
> Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
Applied.
> 
> ---
> 
> v3: return -EIO instead of -EREMOTEIO
> v2: new patch
> ---
>  drivers/iio/temperature/mlx90614.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index 73ec767..06b7b96 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -196,6 +196,11 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>  
>  		if (ret < 0)
>  			return ret;
> +
> +		/* MSB is an error flag */
> +		if (ret & 0x8000)
> +			return -EIO;
> +
>  		*val = ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_OFFSET:
> 

