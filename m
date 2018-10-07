Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbeJHCSD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Oct 2018 22:18:03 -0400
Date: Sun, 7 Oct 2018 20:09:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Slawomir Stepien <sst@poczta.fm>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH v2 2/2] staging: iio: cdc: ad7150: fix misaligned lines
Message-ID: <20181007200943.6b2a6e50@archlinux>
In-Reply-To: <20181005080515.GC2984@x220.localdomain>
References: <20181005080400.GA2984@x220.localdomain>
        <20181005080515.GC2984@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 5 Oct 2018 10:05:15 +0200
Slawomir Stepien <sst@poczta.fm> wrote:

> These lines were misaligned, but the checkpatch.pl didn't indicate them
> as such.
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/cdc/ad7150.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index e2c70063fa0f..24f74ce60f80 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -183,8 +183,8 @@ static int ad7150_write_event_params(struct iio_dev *indio_dev,
>  	case IIO_EV_TYPE_THRESH:
>  		value = chip->threshold[rising][chan];
>  		return i2c_smbus_write_word_data(chip->client,
> -						ad7150_addresses[chan][3],
> -						swab16(value));
> +						 ad7150_addresses[chan][3],
> +						 swab16(value));
>  	case IIO_EV_TYPE_MAG_ADAPTIVE:
>  		sens = chip->mag_sensitivity[rising][chan];
>  		timeout = chip->mag_timeout[rising][chan];
