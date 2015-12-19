Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56242 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932811AbbLSQqR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 19 Dec 2015 11:46:17 -0500
Subject: Re: [PATCH 2/3] iio: mma8452: use enum for channel index
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	christoph.muellner@theobroma-systems.com, mfuzzey@parkeon.com
References: <1450197901-9826-1-git-send-email-martink@posteo.de>
 <1450197901-9826-3-git-send-email-martink@posteo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <567589D7.7060609@kernel.org>
Date: Sat, 19 Dec 2015 16:46:15 +0000
MIME-Version: 1.0
In-Reply-To: <1450197901-9826-3-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/12/15 16:45, Martin Kepplinger wrote:
> This gets rid of some magic numbers by adding an enum.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/mma8452.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 162bbef..ccc632a 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -143,6 +143,13 @@ struct mma_chip_info {
>  	u8 ev_count;
>  };
>  
> +enum {
> +	idx_x,
> +	idx_y,
> +	idx_z,
> +	idx_ts,
> +};
> +
>  static int mma8452_drdy(struct mma8452_data *data)
>  {
>  	int tries = 150;
> @@ -816,31 +823,31 @@ static struct attribute_group mma8452_event_attribute_group = {
>  }
>  
>  static const struct iio_chan_spec mma8452_channels[] = {
> -	MMA8452_CHANNEL(X, 0, 12),
> -	MMA8452_CHANNEL(Y, 1, 12),
> -	MMA8452_CHANNEL(Z, 2, 12),
> -	IIO_CHAN_SOFT_TIMESTAMP(3),
> +	MMA8452_CHANNEL(X, idx_x, 12),
> +	MMA8452_CHANNEL(Y, idx_y, 12),
> +	MMA8452_CHANNEL(Z, idx_z, 12),
> +	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
>  };
>  
>  static const struct iio_chan_spec mma8453_channels[] = {
> -	MMA8452_CHANNEL(X, 0, 10),
> -	MMA8452_CHANNEL(Y, 1, 10),
> -	MMA8452_CHANNEL(Z, 2, 10),
> -	IIO_CHAN_SOFT_TIMESTAMP(3),
> +	MMA8452_CHANNEL(X, idx_x, 10),
> +	MMA8452_CHANNEL(Y, idx_y, 10),
> +	MMA8452_CHANNEL(Z, idx_z, 10),
> +	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
>  };
>  
>  static const struct iio_chan_spec mma8652_channels[] = {
> -	MMA8652_CHANNEL(X, 0, 12),
> -	MMA8652_CHANNEL(Y, 1, 12),
> -	MMA8652_CHANNEL(Z, 2, 12),
> -	IIO_CHAN_SOFT_TIMESTAMP(3),
> +	MMA8652_CHANNEL(X, idx_x, 12),
> +	MMA8652_CHANNEL(Y, idx_y, 12),
> +	MMA8652_CHANNEL(Z, idx_z, 12),
> +	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
>  };
>  
>  static const struct iio_chan_spec mma8653_channels[] = {
> -	MMA8652_CHANNEL(X, 0, 10),
> -	MMA8652_CHANNEL(Y, 1, 10),
> -	MMA8652_CHANNEL(Z, 2, 10),
> -	IIO_CHAN_SOFT_TIMESTAMP(3),
> +	MMA8652_CHANNEL(X, idx_x, 10),
> +	MMA8652_CHANNEL(Y, idx_y, 10),
> +	MMA8652_CHANNEL(Z, idx_z, 10),
> +	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
>  };
>  
>  enum {
> 

