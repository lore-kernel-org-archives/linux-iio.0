Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51015 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbbJDOjz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Oct 2015 10:39:55 -0400
Subject: Re: [PATCH v2] staging: iio: adc: fix comment block coding style
 issue
To: Hugo Camboulive <hugo.camboulive@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org
References: <56111433.4090904@metafoo.de>
 <1443976245-869-1-git-send-email-hugo.camboulive@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56113A38.30709@kernel.org>
Date: Sun, 4 Oct 2015 15:39:52 +0100
MIME-Version: 1.0
In-Reply-To: <1443976245-869-1-git-send-email-hugo.camboulive@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/10/15 17:30, Hugo Camboulive wrote:
> This patch to ad7746.c makes the comment blocks end with a */
> on a separate line, and start with a /* on an empty line.
> 
> Signed-off-by: Hugo Camboulive <hugo.camboulive@gmail.com>
Thanks.

Applied to the togreg branch of iio.git - initially pushed out
as staging for the automated build testing to check it.
(obviously not really going to do much with this patch!)

Probably a good few more of these in the staging drivers if
you want to clear out a few more!

If not, take a look at the review I did of this driver the other
day for other bits that could do with cleaning up.
http://marc.info/?l=linux-iio&m=144277958123939&w=2

> ---
>  drivers/staging/iio/cdc/ad7746.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 10fa372..e8eab25 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -528,10 +528,11 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
>  			goto out;
>  		}
>  
> -		/* CAPDAC Scale = 21pF_typ / 127
> +		/*
> +		 * CAPDAC Scale = 21pF_typ / 127
>  		 * CIN Scale = 8.192pF / 2^24
>  		 * Offset Scale = CAPDAC Scale / CIN Scale = 338646
> -		 * */
> +		 */
>  
>  		val /= 338646;
>  
> @@ -600,7 +601,8 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  
>  		switch (chan->type) {
>  		case IIO_TEMP:
> -		/* temperature in milli degrees Celsius
> +		/*
> +		 * temperature in milli degrees Celsius
>  		 * T = ((*val / 2048) - 4096) * 1000
>  		 */
>  			*val = (*val * 125) / 256;
> 

