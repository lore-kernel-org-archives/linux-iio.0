Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbeKECEh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Nov 2018 21:04:37 -0500
Date: Sun, 4 Nov 2018 16:48:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Tavares <matheus.bernardino@usp.br>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Victor Colombo <victorcolombo@gmail.com>
Subject: Re: [PATCH v3 5/6] staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to
 channel spec and read_raw
Message-ID: <20181104164857.119019f3@archlinux>
In-Reply-To: <20181103224948.31014-6-matheus.bernardino@usp.br>
References: <20181103224948.31014-1-matheus.bernardino@usp.br>
        <20181103224948.31014-6-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  3 Nov 2018 19:49:47 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> This patch adds the IIO_CHAN_INFO_SCALE mask to ad2s90_chan and
> implements the relative read behavior at ad2s90_read_raw.
> 
> Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Hi Matheus,

Somewhere in the process, the authorship of this patch changed from
Victor to you (From:).  Given the sign off order I've assumed this
was be accident and put it back to Victor.

For reference
git commit --amend --author="Victor Colombo <victorcolombo@gmail.com>"

Whilst the patch was modified a fair bit, the fact you have left Victor
as the first sign-off implies you think it is still substantially
Victor's patch (I agree with that).

Anyhow, shout if you disagree as still time to change it before
I push this tree out as non rebasing (probably later this week).

Whilst things are only visible in testing I can change anything,
but once I push out as togreg, I am committing to that being a stable
platform for others to base their code on so can't fix things like this.

Applied.
Thanks,
Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s90.c | 30 +++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 8f79cccf4814..9c168b7410d0 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -34,17 +34,29 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
>  	int ret;
>  	struct ad2s90_state *st = iio_priv(indio_dev);
>  
> -	mutex_lock(&st->lock);
> -	ret = spi_read(st->sdev, st->rx, 2);
> -	if (ret < 0) {
> +	switch (m) {
> +	case IIO_CHAN_INFO_SCALE:
> +		/* 2 * Pi / 2^12 */
> +		*val = 6283; /* mV */
> +		*val2 = 12;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		ret = spi_read(st->sdev, st->rx, 2);
> +		if (ret < 0) {
> +			mutex_unlock(&st->lock);
> +			return ret;
> +		}
> +		*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
> +
>  		mutex_unlock(&st->lock);
> -		return ret;
> -	}
> -	*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
>  
> -	mutex_unlock(&st->lock);
> +		return IIO_VAL_INT;
> +	default:
> +		break;
> +	}
>  
> -	return IIO_VAL_INT;
> +	return -EINVAL;
>  }
>  
>  static const struct iio_info ad2s90_info = {
> @@ -55,7 +67,7 @@ static const struct iio_chan_spec ad2s90_chan = {
>  	.type = IIO_ANGL,
>  	.indexed = 1,
>  	.channel = 0,
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>  };
>  
>  static int ad2s90_probe(struct spi_device *spi)
