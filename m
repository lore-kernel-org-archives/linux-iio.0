Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60746 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391AbbDRQag (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2015 12:30:36 -0400
Message-ID: <553286A8.1010507@kernel.org>
Date: Sat, 18 Apr 2015 17:30:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?=
	<vianney.leclement@essensium.com>, linux-iio@vger.kernel.org
CC: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: Re: [PATCH] iio: mlx90614: Fix duplicate const warning
References: <1429279535-19730-1-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1429279535-19730-1-git-send-email-vianney.leclement@essensium.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/04/15 15:05, Vianney le Clément de Saint-Marcq wrote:
> Fix a typo triggering a duplicate const warning on some compilers.
> 
> Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
> Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play.  I'm not bothering to push this
out faster as it is afterall just a warning and has no actually effect.
> ---
>  drivers/iio/temperature/mlx90614.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index 06b7b96..b2d3b56 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -263,7 +263,7 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
>  }
>  
>  static int mlx90614_write_raw_get_fmt(struct iio_dev *indio_dev,
> -				     const struct iio_chan_spec const *channel,
> +				     struct iio_chan_spec const *channel,
>  				     long mask)
>  {
>  	switch (mask) {
> 

