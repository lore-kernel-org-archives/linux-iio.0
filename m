Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36612 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755637AbbI0N3z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2015 09:29:55 -0400
Subject: Re: [PATCH] iio: hdc100x: correct IIO_CHAN_INFO_OFFSET value
To: Matt Ranostay <mranostay@gmail.com>
References: <1443334737-3772-1-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5607EF50.6020102@kernel.org>
Date: Sun, 27 Sep 2015 14:29:52 +0100
MIME-Version: 1.0
In-Reply-To: <1443334737-3772-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/09/15 07:18, Matt Ranostay wrote:
> Previous offset wasn't applied in the correct order and invalid.
> This patchset fixes this issue, and also has the correct scale value
> applied to the offset.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Oops, missed that.

Given it's provided in the datasheet as effectively a fractional value
would val = -40000, val2 = 65536 and type = IIO_FRACTIONAL not be cleaner
and give the same answer?

Speaking of which, for the scale are we loosing any precision by shifting
the bottom of the fraction right 2 rather than the top left 2 which would have
the same result?

Jonathan
> ---
>  drivers/iio/humidity/hdc100x.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index 2824578..a7f61e8 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -221,8 +221,9 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
>  		}
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
> -		*val = -40;
> -		return IIO_VAL_INT;
> +		*val = -3971;
> +		*val2 = 879096;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
>  	}
> 

